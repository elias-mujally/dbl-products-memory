[CmdletBinding()]
param([switch]$CheckOnly,[switch]$MaintenanceAuthorized)
# Exactly one normal YSEDU stop/start. SQLBrowser never started. No SQL credentials.
$ErrorActionPreference='Stop';Set-StrictMode -Version Latest
$root='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010'
$ss='SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL12.YSEDU\MSSQLServer\SuperSocketNetLib'
$thumb='A51BD253B6083D0114428FCFBAD57D008CD102F5'
$state=[pscustomobject]@{Phase='Identity';Check='HostRuntimeAuthority'}
$r=[ordered]@{Decision='YSEDU_DIRECT_MAINTENANCE_BLOCKED_STOP';At=$null;Host=$env:COMPUTERNAME;Elevated=$false;StopCalls=0;StartCalls=0;CertificateAcceptanceAttempted=$false;CertificateAccepted=$false;RegistryChanges=0;Rollback='NOT_NEEDED';CertreqExitCode=$null;CertreqStillRunning=$false;LeafThumbprint=$thumb;KeyDaclUnchanged=$false;SqlCertificateLoading='NOT_TESTED';TcpListener=$null;Browser='NOT_CHECKED';TLS='NOT_TESTED';ReaderCredential='NOT_TESTED';FirstLiveData='NOT_TESTED';FirewallChanged=$false;TrustChanged=$false;AclChanged=$false;NativeKeyCreation=$false;PrivateKeyDeleted=$false;NoAutomaticRetry=$true}
$base=$null;$service=$null;$pending=@();$installed=@();$certProcess=$null;$mutated=$false;$originalPid=0;$oldStore=$null
$output=Join-Path $root 'YSEDU_DIRECT_MAINTENANCE_001_RESULT.json'
$attempt=Join-Path $root 'YSEDU_DIRECT_MAINTENANCE_001_ATTEMPT.json'
function Need([bool]$ok,[string]$code){$state.Check=$code;if(-not $ok){throw 'STOP: bounded gate failed'}}
function Hash([string]$p){(Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash}
function New-Json([string]$p,$value){
 $bytes=[Text.Encoding]::UTF8.GetBytes(($value|ConvertTo-Json -Depth 8));$stream=[IO.File]::Open($p,[IO.FileMode]::CreateNew,[IO.FileAccess]::Write,[IO.FileShare]::None)
 try{$stream.Write($bytes,0,$bytes.Length);$stream.Flush($true)}finally{$stream.Dispose()}
}
function Assert-Browser {
 $b=Get-CimInstance Win32_Service -Filter 'Name=''SQLBrowser'''
 Need ($b.State -ceq 'Stopped' -and $b.StartMode -ceq 'Disabled' -and $b.ProcessId -eq 0 -and $b.PathName -ceq $saved.BrowserPolicy.Browser.PathName -and $b.StartName -ieq 'NT AUTHORITY\LOCALSERVICE') 'BrowserOriginalStoppedDisabled'
 $r.Browser='Stopped/Disabled'
}
function Assert-Address {
 $ips=@(Get-NetIPAddress -AddressFamily IPv4 -IPAddress '192.168.56.1')
 Need ($ips.Count -eq 1 -and [string]$ips[0].AddressState -ceq 'Preferred') 'ApprovedAddressPreferred'
 $adapter=Get-NetAdapter -InterfaceIndex $ips[0].InterfaceIndex
 Need ([string]$adapter.Status -ceq 'Up' -and $adapter.InterfaceDescription -like '*VirtualBox*Host-Only*') 'ApprovedAdapterUp'
 Need (@([Net.Dns]::GetHostAddresses('DESKTOP-8QRQT7R')|ForEach-Object IPAddressToString) -contains '192.168.56.1') 'ApprovedAddressInDns'
}
function Assert-Clients {
 $clients=@(Get-Process|Where-Object ProcessName -in @('GL','inv','pr','RepDes','ssms','sqlcmd'))
 Need ($clients.Count -eq 0) 'ExperimentalClientsClosed'
 Need (@(Get-Service -Name 'MSSQL$YSEDU' -DependentServices|Where-Object Status -NE 'Stopped').Count -eq 0) 'DependentsStopped'
}
function Store-Inventory {
 $map=@{}
 foreach($path in @('Cert:\CurrentUser\My','Cert:\CurrentUser\Root','Cert:\LocalMachine\Root','Cert:\LocalMachine\My','Cert:\LocalMachine\Request')){
  $certs=@(Get-ChildItem -LiteralPath $path)
  try{$map[$path]=@($certs|ForEach-Object Thumbprint|Sort-Object)}finally{foreach($c in $certs){$c.Dispose()}}
 }
 return $map
}
function Assert-UnchangedStores($before,[bool]$accepted){
 $after=Store-Inventory
 foreach($path in @('Cert:\CurrentUser\My','Cert:\CurrentUser\Root','Cert:\LocalMachine\Root')){
  Need (($after[$path]-join '|') -ceq ($before[$path]-join '|')) 'TrustAndUserStoresUnchanged'
 }
 Need (($after['Cert:\LocalMachine\My']-join '|') -ceq $(if($accepted){$thumb}else{''})) 'OnlyOwnedLeafInMachineMy'
 $requests=$after['Cert:\LocalMachine\Request']-join '|'
 Need ($requests -ceq '' -or $requests -ceq '079AF9D20802BD4A16B862928194A77BC14B93F4') 'OnlyOriginalPendingRequestOrConsumed'
}
function Read-Key($cert){
 $meta=[DblYseduKeyStorageReadiness001+Result]::new()
 [DblYseduKeyStorageReadiness001]::Read($cert.Handle,$meta)
 Need ($meta.ContextOpened -and $meta.ContextReleased) 'ExistingCsp24MachineKeySpec1ContextReleased'
 $path=Join-Path (Join-Path $env:ProgramData 'Microsoft\Crypto\RSA\MachineKeys') $meta.UniqueName
 $entry=Get-Item -LiteralPath $path -Force
 while($null -ne $entry){Need (-not($entry.Attributes -band [IO.FileAttributes]::ReparsePoint)) 'NoKeyPathReparse';$entry=if($entry -is [IO.DirectoryInfo]){$entry.Parent}else{$entry.Directory}}
 $sddl=(Get-Acl -LiteralPath $path).GetSecurityDescriptorSddlForm([Security.AccessControl.AccessControlSections]'Owner,Group,Access')
 $hash=[Convert]::ToHexString([Security.Cryptography.SHA256]::HashData([Text.Encoding]::UTF8.GetBytes($sddl)))
 Need ($hash -ceq '119EE2FB1E288527CD7128D069EC147F2C5E203DB8709B655A0B2A5FDDA2ED82') 'QualifiedSystemReadDaclUnchanged'
 return $meta.UniqueName # storage locator used only in memory, never published
}
function Inspect-Rollback([bool]$baseline){
 $text=(& ([scriptblock]::Create((Get-Content -LiteralPath (Join-Path $root 'Restore-YseduLeafNetwork002.ps1') -Raw))) -RequireBaseline:$baseline) -join "`n"
 $report=$text|ConvertFrom-Json
 Need ($report.Decision -ceq 'YSEDU_COMBINED_ROLLBACK_INSPECTION_PASSED' -and -not $report.ApplyRequested) 'PinnedRollbackInspection'
 return $report
}
function Write-Owned([string]$path,[string]$name,$before,$after,[string]$kind){
 Need (Test-ForwardTarget $path $name $before $after $kind) 'ExactFourOwnedForwardTargetsOnly'
 Need ((Get-Service -Name 'MSSQL$YSEDU').Status -eq 'Stopped') 'SqlStoppedDuringOwnedWrite'
 $k=$base.OpenSubKey($path,$true)
 try{Need ($null -ne $k -and [string]$k.GetValueKind($name) -ceq $kind -and [string]$k.GetValue($name) -ceq [string]$before) 'OwnedTargetExpectedBefore';$k.SetValue($name,$after,[Enum]::Parse([Microsoft.Win32.RegistryValueKind],$kind));$r.RegistryChanges++;$mutated=$true}finally{if($null -ne $k){$k.Dispose()}}
}
function Test-ForwardTarget([string]$path,[string]$name,$before,$after,[string]$kind){
 $scope='SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL12.YSEDU\MSSQLServer\SuperSocketNetLib'
 if($path -ceq $scope -and $name -ceq 'Certificate'){return ($kind -ceq 'String' -and [string]$before -ceq '' -and [string]$after -ceq 'a51bd253b6083d0114428fcfbad57d008cd102f5')}
 if($kind -cne 'DWord'){return $false}
 if($path -ceq ($scope+'\Tcp') -and $name -ceq 'ListenOnAllIPs'){return ([int]$before -eq 1 -and [int]$after -eq 0)}
 if(($path -ceq ($scope+'\Tcp') -or $path -ceq ($scope+'\Tcp\IP4')) -and $name -ceq 'Enabled'){return ([int]$before -eq 0 -and [int]$after -eq 1)}
 return $false
}
function Start-Once {
 Need ($r.StartCalls -eq 0 -and (Get-Service -Name 'MSSQL$YSEDU').Status -eq 'Stopped') 'OneNormalStartOnly'
 $r.StartCalls++;$service.Start();$service.WaitForStatus('Running',[TimeSpan]::FromSeconds(120));$service.Refresh()
 Need ($service.Status -eq 'Running') 'NormalStartRunning'
}
try {
 Need ($env:COMPUTERNAME -ceq 'DESKTOP-8QRQT7R' -and $PSVersionTable.PSVersion.ToString() -ceq '7.6.5') 'ExactHostRuntime'
 $pins=@{
  'Restore-YseduLeafNetwork002.ps1'='3F1E4FEF5BB3FF0845014E4893155FE9A13059D7F593C6F1DA9066FCD1059D87'
  'YseduKeyStorageReadiness001.cs'='957DC651000AB683D2F679CF8ED844864BB4A075C0DDC2FF469598524D2E3784'
  'YSEDU_LEAF_MAINTENANCE_ORIGINAL.json'='BB3BF707DCEEDB99396BF2C598B3A0E9BF2E02E83F3FD7AE3A8DB27CF1931BD5'
  'YSEDU_LEAF_SIGNING_001_RESULT.json'='756917FF89B109902D5E88CBDDC487B121C1B830B9EECAEF302DE441E6C505C4'
  'YSEDU-Leaf-Signed-001.cer'='522C79FD31F0422D3988FB00CC4EF0A51B4042DEED72A435A6519237AC548DFE'
  'YSEDU_RESUMED_ADMIN_PREFLIGHT_001_RESULT.json'='D1F849335CFA6328B7F019A006BB5103396904B1D933F2CEF1DB3C9E114D2451'
 }
 foreach($pin in $pins.GetEnumerator()){Need ((Hash (Join-Path $root $pin.Key)) -ceq $pin.Value) ('Pinned_'+$pin.Key)}
 $saved=Get-Content -LiteralPath (Join-Path $root 'YSEDU_LEAF_MAINTENANCE_ORIGINAL.json') -Raw|ConvertFrom-Json
 $pre=Get-Content -LiteralPath (Join-Path $root 'YSEDU_RESUMED_ADMIN_PREFLIGHT_001_RESULT.json') -Raw|ConvertFrom-Json
 Need ($pre.Decision -ceq 'ACTIVATION_ADMIN_READONLY_PREFLIGHT_PASSED' -and $pre.Elevated) 'OwnerAdminPreflightPassed'
 if($CheckOnly){[pscustomobject]@{Decision='DIRECT_MAINTENANCE_HELPER_PINS_PASSED';HostChanged=$false;SqlStopped=$false;CertificateAccepted=$false}|ConvertTo-Json;return}
 $principal=[Security.Principal.WindowsPrincipal]::new([Security.Principal.WindowsIdentity]::GetCurrent())
 $r.Elevated=$principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
 Need ($MaintenanceAuthorized -and $r.Elevated) 'OwnerAuthorityActualAdministrator'
 Need (-not(Test-Path -LiteralPath $attempt) -and -not(Test-Path -LiteralPath $output)) 'FreshAttemptAndOutputNoOverwrite'
 $state.Phase='ImmediatePreStop'
 $null=Inspect-Rollback $true;Assert-Browser;Assert-Address;Assert-Clients
 $svc=Get-CimInstance Win32_Service -Filter 'Name=''MSSQL$YSEDU'''
 Need ($svc.State -ceq 'Running' -and $svc.StartMode -ceq 'Auto' -and $svc.StartName -ieq 'LocalSystem' -and $svc.PathName -ceq $saved.BrowserPolicy.YSEDU.PathName) 'ExactYseduRunningService'
 $originalPid=[int]$svc.ProcessId
 $base=[Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine,[Microsoft.Win32.RegistryView]::Registry32)
 $ip4=$base.OpenSubKey($ss+'\Tcp\IP4',$false)
 try{Need ([string]$ip4.GetValue('IpAddress') -ceq '192.168.56.1' -and [int]$ip4.GetValue('Active') -eq 1 -and [string]$ip4.GetValue('TcpDynamicPorts') -ceq '0' -and [string]$ip4.GetValue('TcpPort') -ceq '') 'OnlyQualifiedIp4DynamicTarget'}finally{$ip4.Dispose()}
 foreach($target in $saved.TcpRegistry|Where-Object Path -Match '\\IP\d+$'){
  Need (@($target.Values|Where-Object {$_.Name -ceq 'Enabled' -and $_.Value -eq 0}).Count -eq 1) 'AllOriginalIndividualIpDisabled'
 }
 Add-Type -TypeDefinition (Get-Content -LiteralPath (Join-Path $root 'YseduKeyStorageReadiness001.cs') -Raw)
 $pending=@(Get-ChildItem -LiteralPath 'Cert:\LocalMachine\Request')
 Need ($pending.Count -eq 1 -and $pending[0].Thumbprint -ceq '079AF9D20802BD4A16B862928194A77BC14B93F4') 'ExactExistingPendingKey'
 $public=[Security.Cryptography.X509Certificates.X509CertificateLoader]::LoadCertificate([IO.File]::ReadAllBytes((Join-Path $root 'YSEDU-Leaf-Signed-001.cer')))
 try{Need ($public.Thumbprint -ceq $thumb -and [datetime]::UtcNow -gt $public.NotBefore.ToUniversalTime() -and [datetime]::UtcNow -lt $public.NotAfter.ToUniversalTime() -and [Convert]::ToHexString($public.PublicKey.ExportSubjectPublicKeyInfo()) -ceq [Convert]::ToHexString($pending[0].PublicKey.ExportSubjectPublicKeyInfo())) 'ExistingLeafValidityAndPublicMatch'}finally{$public.Dispose()}
 $keyLocator=Read-Key $pending[0];$r.KeyDaclUnchanged=$true;$oldStore=Store-Inventory
 $certreq=Join-Path $env:SystemRoot 'System32\certreq.exe'
 Need ([string](Get-AuthenticodeSignature -LiteralPath $certreq).Status -ceq 'Valid') 'SignedInstalledCertreq'
 $service=Get-Service -Name 'MSSQL$YSEDU'
 # Last refresh occurs immediately before consuming the single stop call.
 $null=Inspect-Rollback $true;Assert-Browser;Assert-Address;Assert-Clients
 New-Json $attempt ([pscustomobject]@{Task='YSEDU_DIRECT_MAINTENANCE_001';At=(Get-Date -Format o);Authorized=$true;OriginalPid=$originalPid;MaxStops=1;MaxStarts=1;NoAutomaticRetry=$true})
 $state.Phase='OneNormalStop';$r.StopCalls++;$service.Stop();$service.WaitForStatus('Stopped',[TimeSpan]::FromSeconds(120));$service.Refresh()
 Need ($service.Status -eq 'Stopped') 'StoppedWithin120Seconds'
 Need ($null -eq (Get-Process -Id $originalPid -ErrorAction SilentlyContinue)) 'OriginalSqlProcessExited'
 Assert-Browser
 $state.Phase='AcceptExistingLeaf';$r.CertificateAcceptanceAttempted=$true;$mutated=$true
 $startInfo=[Diagnostics.ProcessStartInfo]::new($certreq);$startInfo.UseShellExecute=$false;$startInfo.RedirectStandardOutput=$true;$startInfo.RedirectStandardError=$true
 # -q suppresses dialogs only, not validation; no -f overwrite or trust override.
 foreach($arg in @('-accept','-machine','-q',(Join-Path $root 'YSEDU-Leaf-Signed-001.cer'))){$startInfo.ArgumentList.Add($arg)}
 $certProcess=[Diagnostics.Process]::new();$certProcess.StartInfo=$startInfo;$null=$certProcess.Start()
 $stdout=$certProcess.StandardOutput.ReadToEndAsync();$stderr=$certProcess.StandardError.ReadToEndAsync()
 if(-not $certProcess.WaitForExit(60000)){$r.CertreqStillRunning=$true;Need $false 'CertreqTimedOutNoKillNoRollbackRace'}
 $r.CertreqExitCode=$certProcess.ExitCode;$null=$stdout.GetAwaiter().GetResult();$null=$stderr.GetAwaiter().GetResult()
 Need ($certProcess.ExitCode -eq 0) 'CertreqAcceptExitZero'
 $installed=@(Get-ChildItem -LiteralPath 'Cert:\LocalMachine\My')
 Need ($installed.Count -eq 1 -and $installed[0].Thumbprint -ceq $thumb -and $installed[0].HasPrivateKey -and [Convert]::ToHexString([Security.Cryptography.SHA256]::HashData($installed[0].RawData)) -ceq '522C79FD31F0422D3988FB00CC4EF0A51B4042DEED72A435A6519237AC548DFE') 'ExactInstalledLeafExistingPrivateKey'
 Need ((Read-Key $installed[0]) -ceq $keyLocator) 'SameExistingKeyStorageLocator'
 $r.CertificateAccepted=$true;Assert-UnchangedStores $oldStore $true
 $state.Phase='BindAndEnableOwnedTcp'
 Write-Owned $ss 'Certificate' '' $thumb.ToLowerInvariant() 'String'
 Write-Owned ($ss+'\Tcp') 'ListenOnAllIPs' 1 0 'DWord'
 Write-Owned ($ss+'\Tcp\IP4') 'Enabled' 0 1 'DWord'
 Write-Owned ($ss+'\Tcp') 'Enabled' 0 1 'DWord'
 $null=Inspect-Rollback $false;Assert-Browser;Assert-Address;Assert-UnchangedStores $oldStore $true
 $state.Phase='OneNormalStart';Start-Once
 $state.Phase='VerifySqlLoadingAndListener'
 $newSvc=Get-CimInstance Win32_Service -Filter 'Name=''MSSQL$YSEDU'''
 Need ($newSvc.State -ceq 'Running' -and $newSvc.StartName -ieq 'LocalSystem' -and $newSvc.PathName -ceq $saved.BrowserPolicy.YSEDU.PathName -and $newSvc.ProcessId -gt 0) 'SameYseduServiceFreshProcess'
 $newPid=[int]$newSvc.ProcessId
 $logPath=([string]($saved.Startup.Values|Where-Object Name -CEQ 'SQLArg1').Value).Substring(2)
 Need ($logPath -ceq 'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.YSEDU\MSSQL\Log\ERRORLOG') 'ExactOriginalErrorlogPath'
 $deadline=[datetime]::UtcNow.AddSeconds(45);$certLoaded=$false;$ready=$false;$listeners=@()
 do{
  Assert-Browser
  $listeners=@(Get-NetTCPConnection -State Listen -ErrorAction SilentlyContinue|Where-Object OwningProcess -EQ $newPid)
  Need (@($listeners|Where-Object LocalAddress -CNE '192.168.56.1').Count -eq 0) 'NoUnapprovedSqlTcpListener'
  $lines=@(Get-Content -LiteralPath $logPath -Tail 1000)
  $certLoaded=@($lines|Where-Object {$_ -match $thumb -and $_ -match 'successfully loaded for encryption'}).Count -gt 0
  $ready=@($lines|Where-Object {$_ -match 'SQL Server is now ready for client connections'}).Count -gt 0
  if($certLoaded -and $ready -and $listeners.Count -eq 1){break}
  Start-Sleep -Milliseconds 1000
 }while([datetime]::UtcNow -lt $deadline)
 Need ($certLoaded) 'ExactLeafLoadedInCurrentSqlErrorlog'
 Need ($ready -and $listeners.Count -eq 1 -and $listeners[0].LocalPort -ge 1 -and $listeners[0].LocalPort -le 65535) 'ReadySingleOwnedScopedListener'
 $process=Get-Process -Id $newPid
 try{Need ($process.Path -ceq 'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.YSEDU\MSSQL\Binn\sqlservr.exe') 'ListenerOwnerYseduExecutable'}finally{$process.Dispose()}
 $null=Inspect-Rollback $false;Assert-Browser;Assert-UnchangedStores $oldStore $true
 $r.SqlCertificateLoading='PASSED: exact leaf thumbprint in current startup ERRORLOG'
 $r.TcpListener=[pscustomobject]@{Address=$listeners[0].LocalAddress;Port=[int]$listeners[0].LocalPort;OwningProcess=$newPid;Instance='YSEDU'}
 $r.Decision='YSEDU_ONE_BOUNDED_DIRECT_MAINTENANCE_PASSED'
}catch{
 $r['FailurePhase']=$state.Phase;$r['FailedCheck']=$state.Check;$r['ExceptionType']=$_.Exception.GetType().FullName
 # Never issue a second stop/start. Recovery while already stopped only, with #002.
 if($r.StopCalls -eq 1 -and -not $r.CertreqStillRunning){
  try{
   $current=Get-Service -Name 'MSSQL$YSEDU'
   if($current.Status -eq 'Stopped' -and $null -eq (Get-Process -Id $originalPid -ErrorAction SilentlyContinue)){
    if($mutated){$state.Phase='OwnedRollbackWhileAlreadyStopped';$rollbackText=(& ([scriptblock]::Create((Get-Content -LiteralPath (Join-Path $root 'Restore-YseduLeafNetwork002.ps1') -Raw))) -Apply -MaintenanceAuthorized)-join "`n";$rollback=$rollbackText|ConvertFrom-Json;Need ($rollback.Decision -ceq 'YSEDU_COMBINED_SETTINGS_RESTORED_SQL_STILL_STOPPED') 'OwnedRollbackVerified';$r.Rollback='OWNED_SETTINGS_RESTORED_KEY_PRESERVED'}
    else{$r.Rollback='NO_FORWARD_MUTATION'}
    if($r.StartCalls -eq 0){$state.Phase='OneRecoveryStart';Start-Once;$r['RecoveryStart']='ORIGINAL_CONFIGURATION_RUNNING'}
    else{$r['RecoveryStart']='NOT_PERMITTED_START_ALREADY_CONSUMED'}
   }else{$r.Rollback='NOT_APPLIED_SQL_NOT_STOPPED_OR_OLD_PROCESS_NOT_EXITED; NO_SECOND_STOP'}
  }catch{$r['RecoveryFailedCheck']=$state.Check;$r['RecoveryExceptionType']=$_.Exception.GetType().FullName;$r.Rollback='FAILED_STOP_NO_AUTOMATIC_RETRY'}
 }
}finally{
 foreach($c in $pending+$installed){$c.Dispose()}
 if($null -ne $certProcess){$certProcess.Dispose()}
 if($null -ne $base){$base.Dispose()}
 if($null -ne $service){$service.Dispose()}
}
if(-not $CheckOnly){
 $r.At=Get-Date -Format o
 try{$r['FinalSqlState']=[string](Get-Service -Name 'MSSQL$YSEDU').Status;$r['FinalBrowserState']=[string](Get-Service -Name SQLBrowser).Status}catch{$r['FinalServiceRead']='FAILED'}
 if($r.Elevated -and -not(Test-Path -LiteralPath $output)){New-Json $output $r}
 $r|ConvertTo-Json -Depth 8
}
