[CmdletBinding()]
param([switch]$CheckOnly,[switch]$MaintenanceAuthorized)
# Already accepted leaf; one NEW natural cycle only. Never enrolls a certificate or connects to SQL.
$ErrorActionPreference='Stop';Set-StrictMode -Version Latest
$root='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010'
$scope='SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL12.YSEDU\MSSQLServer\SuperSocketNetLib'
$thumb='A51BD253B6083D0114428FCFBAD57D008CD102F5';$leafPin='522C79FD31F0422D3988FB00CC4EF0A51B4042DEED72A435A6519237AC548DFE'
$rollbackPath=Join-Path $root 'Restore-YseduLeafNetwork002-RetainedCertificates.ps1'
$rollbackPin='BCEE15DACD346B4E6EB6C53F78965C3D9FCC0346AA540FD69FAE8FDF0751E92B'
$beforePath=Join-Path $root 'YSEDU_SQL_ACTIVATION_001_BEFORE.json';$attemptPath=Join-Path $root 'YSEDU_SQL_ACTIVATION_001_ATTEMPT.json';$output=Join-Path $root 'YSEDU_SQL_ACTIVATION_001_RESULT.json'
$state=[pscustomobject]@{Phase='Identity';Check='HostRuntime'}
$r=[ordered]@{Decision='YSEDU_SQL_ACTIVATION_001_BLOCKED_STOP';At=$null;Host=$env:COMPUTERNAME;Elevated=$false;StopCalls=0;StartCalls=0;RegistryWriteAttempts=0;RegistryWrites=0;OriginalPid=$null;NewPid=$null;Rollback='NOT_NEEDED';RootRetained=$true;LeafRetained=$true;KeyDaclUnchanged=$false;LeafThumbprint=$thumb;CertificateLoading='NOT_TESTED';TcpListener=$null;SQLBrowser='NOT_TESTED';Revocation='UNKNOWN_ACCEPTED_LAB_GAP_NOT_RETESTED';NodeTLS='NOT_TESTED';ReaderLogin='NOT_TESTED';FirstLiveData='NOT_TESTED';CertreqCalls=0;TrustChanged=$false;AclChanged=$false;FirewallChanged=$false;ForceEncryptionChanged=$false;SQLConnection=$false;NoAutomaticRetry=$true}
$r.RootRetained=$null;$r.LeafRetained=$null
$base=$null;$service=$null;$leaf=@();$ca=@();$public=$null;$failure=$null;$cleanup=[Collections.Generic.List[string]]::new();$before=$null;$keyBefore=$null;$beforeHash=$null;$stopUtc=$null;$logEvidence=$null
function Need([bool]$ok,[string]$code){$state.Check=$code;if(-not $ok){throw [InvalidOperationException]::new($code)}}
function Hash([string]$p){(Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash}
function New-Json([string]$p,$v){$bytes=[Text.UTF8Encoding]::new($false).GetBytes(($v|ConvertTo-Json -Depth 18));$f=[IO.File]::Open($p,[IO.FileMode]::CreateNew,[IO.FileAccess]::Write,[IO.FileShare]::None);try{$f.Write($bytes,0,$bytes.Length);$f.Flush($true)}finally{$f.Dispose()}}
function Inspect([string]$mode,[int]$port=0){
 Need ((Hash $rollbackPath) -ceq $rollbackPin) 'RetainedCertificateRollbackPin'
 $text=(& $rollbackPath -Phase $mode -RuntimePort $port) -join "`n";$report=$text|ConvertFrom-Json
 Need ($report.Decision -ceq 'YSEDU_ROLLBACK_002_RETAINED_CERTIFICATES_INSPECTION_PASSED' -and -not $report.ApplyRequested) 'ReadOnlyRollbackInspection'
 return $report
}
function Equal($a,$b){return (($a|ConvertTo-Json -Depth 18 -Compress) -ceq ($b|ConvertTo-Json -Depth 18 -Compress))}
function Address {
 $ips=@(Get-NetIPAddress -AddressFamily IPv4 -IPAddress '192.168.56.1');Need ($ips.Count -eq 1 -and [string]$ips[0].AddressState -ceq 'Preferred') 'OnlyQualifiedAddressPreferred'
 $adapter=Get-NetAdapter -InterfaceIndex $ips[0].InterfaceIndex;Need ([string]$adapter.Status -ceq 'Up' -and $adapter.InterfaceDescription -like '*VirtualBox*Host-Only*') 'HostOnlyAdapterUp'
 Need (@([Net.Dns]::GetHostAddresses('DESKTOP-8QRQT7R')|ForEach-Object IPAddressToString) -contains '192.168.56.1') 'QualifiedAddressInHostDns'
 return [pscustomobject]@{Address='192.168.56.1';InterfaceIndex=$ips[0].InterfaceIndex;Adapter=$adapter.InterfaceDescription;State=[string]$ips[0].AddressState}
}
function Clients {
 Need (@(Get-Process|Where-Object ProcessName -in @('GL','inv','pr','RepDes','ssms','sqlcmd')).Count -eq 0) 'ExperimentalClientsClosed'
 Need (@(Get-Service -Name 'MSSQL$YSEDU' -DependentServices|Where-Object Status -NE 'Stopped').Count -eq 0) 'DependentServicesStopped'
}
function Browser {
 $b=Get-CimInstance Win32_Service -Filter 'Name=''SQLBrowser'''
 Need ($b.State -ceq 'Stopped' -and $b.StartMode -ceq 'Disabled' -and $b.ProcessId -eq 0 -and $b.PathName -ceq $saved.BrowserPolicy.Browser.PathName -and $b.StartName -ceq $saved.BrowserPolicy.Browser.StartName) 'BrowserNeverStartedOrChanged'
 $r.SQLBrowser='Stopped/Disabled'
}
function Key-Metadata($cert){
 $meta=[DblYseduKeyStorageReadiness001+Result]::new()
 try{[DblYseduKeyStorageReadiness001]::Read($cert.Handle,$meta)}catch{$state.Check='ExistingKey_'+$meta.Check;throw}
 Need ($meta.ContextOpened -and $meta.ContextReleased) 'ExistingCsp24MachineKeySpec1Released'
 $p=Join-Path (Join-Path $env:ProgramData 'Microsoft\Crypto\RSA\MachineKeys') $meta.UniqueName
 $f=Get-Item -LiteralPath $p -Force;Need ($f -is [IO.FileInfo]) 'ExistingKeyFile'
 $entry=$f;while($null -ne $entry){Need (-not($entry.Attributes -band [IO.FileAttributes]::ReparsePoint)) 'NoKeyPathReparse';$entry=if($entry -is [IO.DirectoryInfo]){$entry.Parent}else{$entry.Directory}}
 $sddl=(Get-Acl -LiteralPath $p).GetSecurityDescriptorSddlForm([Security.AccessControl.AccessControlSections]'Owner,Group,Access');$dacl=[Security.AccessControl.RawSecurityDescriptor]::new($sddl).DiscretionaryAcl
 Need ($null -ne $dacl -and $dacl.Count -gt 0) 'DaclPresent';$mask=0L
 foreach($ace in $dacl){
  Need ($ace -is [Security.AccessControl.CommonAce] -and -not $ace.IsCallback -and [int]$ace.AceType -eq 0) 'SupportedAllowOnlyKeyDacl'
  if($ace.SecurityIdentifier.Value -ceq 'S-1-5-18' -and -not($ace.AceFlags -band [Security.AccessControl.AceFlags]::InheritOnly)){$mask=$mask -bor ([long]$ace.AccessMask -band 0xffffffffL)}
 }
 Need (($mask -band 0x120089L) -eq 0x120089L) 'ExplicitSystemGenericRead'
 $digest=[Convert]::ToHexString([Security.Cryptography.SHA256]::HashData([Text.Encoding]::UTF8.GetBytes($sddl)))
 Need ($digest -ceq '119EE2FB1E288527CD7128D069EC147F2C5E203DB8709B655A0B2A5FDDA2ED82') 'ExistingQualifiedKeyDaclUnchanged'
 return [pscustomobject]@{Locator=$meta.UniqueName;DaclSHA256=$digest;Provider='CSP24';KeySpec=1;Machine=$true}
}
function Start-Once {
 Need ($r.StartCalls -eq 0 -and (Get-Service -Name 'MSSQL$YSEDU').Status -eq 'Stopped') 'OneNaturalStartOnly'
 $r.StartCalls++;New-Json (Join-Path $root 'YSEDU_SQL_ACTIVATION_001_START_ATTEMPT.json') ([pscustomobject]@{At=(Get-Date -Format o);Task='YSEDU_SQL_ACTIVATION_001';BaselineSHA256=$beforeHash;AttemptLimit=1;Recovery=($state.Phase -ceq 'OneOriginalConfigurationRecoveryStart')});$service.Start();$service.WaitForStatus('Running',[TimeSpan]::FromSeconds(120));$service.Refresh();Need ($service.Status -eq 'Running') 'StartRunningWithin120Seconds'
}
function Write-Owned([int]$index,[string]$path,[string]$name,$old,$new,[string]$kind){
 Need (Rb-Target $path $name $old $new $kind) 'FourExactOwnedTargetsOnly'
 Need ($r.StopCalls -eq 1 -and $r.StartCalls -eq 0 -and (Get-Service -Name 'MSSQL$YSEDU').Status -eq 'Stopped') 'WriteOnlyDuringThisStoppedCycle'
 $k=$base.OpenSubKey($path,$true)
 try{Need ([string]$k.GetValueKind($name) -ceq $kind -and (Equal ($k.GetValue($name)) $old)) 'TargetBeforeValueUnchanged'
  New-Json (Join-Path $root ('YSEDU_SQL_ACTIVATION_001_WRITE_'+$index+'.json')) ([pscustomobject]@{Index=$index;BaselineSHA256=$beforeHash;Path=$path;Name=$name;Before=$old;After=$new;Kind=$kind;At=(Get-Date -Format o)})
  $r.RegistryWriteAttempts++;$k.SetValue($name,$new,[Enum]::Parse([Microsoft.Win32.RegistryValueKind],$kind));$r.RegistryWrites++
 }finally{if($null -ne $k){$k.Dispose()}}
}
function Startup-Evidence($lines,[int]$pidValue,[datetime]$sinceUtc){
 $fresh=@()
 foreach($line in $lines){
  $m=[regex]::Match($line,'^(?<stamp>\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\.\d{2,3})\s+(?<message>.+)$')
  if(-not $m.Success){continue};$parsed=[datetime]::MinValue
  if([datetime]::TryParseExact($m.Groups['stamp'].Value,[string[]]@('yyyy-MM-dd HH:mm:ss.ff','yyyy-MM-dd HH:mm:ss.fff'),[Globalization.CultureInfo]::InvariantCulture,[Globalization.DateTimeStyles]::AssumeLocal,[ref]$parsed) -and $parsed.ToUniversalTime() -ge $sinceUtc){$fresh+=@($line)}
 }
 $cert=@($fresh|Where-Object{$_ -match 'A51BD253B6083D0114428FCFBAD57D008CD102F5' -and $_ -match 'successfully loaded for encryption'})
 $ready=@($fresh|Where-Object{$_ -match 'SQL Server is now ready for client connections'})
 $pidLine=@($fresh|Where-Object{$_ -match ('Server process ID is '+$pidValue+'\.')})
 $fallback=@($fresh|Where-Object{$_ -match 'self-generated certificate was successfully loaded'})
 return [pscustomobject]@{Passed=($cert.Count -eq 1 -and $ready.Count -ge 1 -and $pidLine.Count -eq 1 -and $fallback.Count -eq 0);CertificateLine=if($cert.Count -eq 1){$cert[0]}else{$null};ReadyLine=if($ready.Count){$ready[0]}else{$null};PidLine=if($pidLine.Count -eq 1){$pidLine[0]}else{$null};FallbackDetected=($fallback.Count -gt 0)}
}
try{
 Need ($env:COMPUTERNAME -ceq 'DESKTOP-8QRQT7R' -and $PSVersionTable.PSVersion.ToString() -ceq '7.6.5' -and [IntPtr]::Size -eq 8) 'ExactHostRuntime'
 Need ((Hash (Join-Path $PSHOME 'pwsh.exe')) -ceq '362A356CE7F0940EC74F73A8FC2C990A2CC24A38A11C90BBD8ECA947110AD139' -and [string](Get-AuthenticodeSignature -LiteralPath (Join-Path $PSHOME 'pwsh.exe')).Status -ceq 'Valid') 'PinnedSignedRuntime'
 $pins=@{
  'Restore-YseduLeafNetwork002-RetainedCertificates.ps1'=$rollbackPin
  'YseduKeyStorageReadiness001.cs'='957DC651000AB683D2F679CF8ED844864BB4A075C0DDC2FF469598524D2E3784'
  'YSEDU_LEAF_MAINTENANCE_ORIGINAL.json'='BB3BF707DCEEDB99396BF2C598B3A0E9BF2E02E83F3FD7AE3A8DB27CF1931BD5'
  'LAB_LEAF_ACCEPTANCE_001_RESULT.json'='80A38357E94790A5DDE33B714BEBDAE08AC020DEF5F64E91F337244ED5DF25EB'
  'YSEDU-Leaf-Signed-001.cer'=$leafPin
 }
 foreach($pin in $pins.GetEnumerator()){Need ((Hash (Join-Path $root $pin.Key)) -ceq $pin.Value) ('Pin_'+$pin.Key)}
 $saved=Get-Content -LiteralPath (Join-Path $root 'YSEDU_LEAF_MAINTENANCE_ORIGINAL.json') -Raw|ConvertFrom-Json
 if($CheckOnly){[pscustomobject]@{Decision='SQL_ACTIVATION_SOURCE_PINS_PASSED';AdministrativeChecks=$false;HostMutation=$false;ServiceCalls=0}|ConvertTo-Json;return}
 $id=[Security.Principal.WindowsIdentity]::GetCurrent()
 try{$r.Elevated=([Security.Principal.WindowsPrincipal]::new($id)).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator);Need ($r.Elevated -and $id.Name -ceq 'DESKTOP-8QRQT7R\user' -and $MaintenanceAuthorized) 'ActualOwnerAdminAndNewCycleAuthority'}finally{$id.Dispose()}
 foreach($path in @($beforePath,$attemptPath,$output,(Join-Path $root 'YSEDU_SQL_ACTIVATION_001_START_ATTEMPT.json'))+@(0..3|ForEach-Object{Join-Path $root ('YSEDU_SQL_ACTIVATION_001_WRITE_'+$_+'.json')})){Need (-not(Test-Path -LiteralPath $path)) 'FreshCycleNoOverwriteOrRetry'}
 $state.Phase='FreshAdministrativePreflight';$before=Inspect 'Baseline';$addr=Address;Clients;Browser
 $sql=@($before.Services|Where-Object Name -CEQ 'MSSQL$YSEDU');Need ($sql.Count -eq 1 -and $sql[0].ProcessId -gt 0) 'CurrentYseduProcess';$r.OriginalPid=[int]$sql[0].ProcessId
 $process=Get-Process -Id $r.OriginalPid
 try{Need ($process.Path -ceq 'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.YSEDU\MSSQL\Binn\sqlservr.exe') 'OriginalYseduExecutable'}finally{$process.Dispose()}
 $leaf=@(Get-ChildItem -LiteralPath 'Cert:\LocalMachine\My');$ca=@(Get-ChildItem -LiteralPath 'Cert:\LocalMachine\Root'|Where-Object Thumbprint -CEQ '121CDC9857488ED95F4BC62106D7672BB0DBC6C3')
 Need ($leaf.Count -eq 1 -and $leaf[0].Thumbprint -ceq $thumb -and $leaf[0].HasPrivateKey -and [Convert]::ToHexString([Security.Cryptography.SHA256]::HashData($leaf[0].RawData)) -ceq $leafPin) 'ExactAlreadyAcceptedLeaf'
 Need ($ca.Count -eq 1 -and -not $ca[0].HasPrivateKey -and [Convert]::ToHexString([Security.Cryptography.SHA256]::HashData($ca[0].RawData)) -ceq 'A3FBC7905425B2E8C10F3A070B8713F876B94FC42B8D1243DEAD5D0F42889472') 'ExactRetainedPublicRoot'
 $r.RootRetained=$true;$r.LeafRetained=$true
 foreach($cert in $leaf+$ca){Need ([datetime]::UtcNow -ge $cert.NotBefore.ToUniversalTime() -and [datetime]::UtcNow -lt $cert.NotAfter.ToUniversalTime()) 'CurrentCertificateValidity'}
 Add-Type -Path (Join-Path $root 'YseduKeyStorageReadiness001.cs');$keyBefore=Key-Metadata $leaf[0];$r.KeyDaclUnchanged=$true
 # Use only the pure forward allowlist from the pinned rollback revision.
 $tokens=$null;$errors=$null;$ast=[Management.Automation.Language.Parser]::ParseFile($rollbackPath,[ref]$tokens,[ref]$errors);Need ($errors.Count -eq 0) 'RollbackParse'
 $fn=$ast.Find({param($n) $n -is [Management.Automation.Language.FunctionDefinitionAst] -and $n.Name -ceq 'Rb-Target'},$false);Need ($null -ne $fn) 'PinnedForwardAllowlist';. ([scriptblock]::Create($fn.Extent.Text))
 $logPath=([string]($saved.Startup.Values|Where-Object Name -CEQ 'SQLArg1').Value).Substring(2)
 Need ($logPath -ceq 'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.YSEDU\MSSQL\Log\ERRORLOG') 'ExactErrorlog';$logBefore=Get-Item -LiteralPath $logPath
 $codeRoot='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\work\dbl-legacy-intelligence'
 $tree=(& git -C $codeRoot rev-parse 'HEAD^{tree}') -join '';Need ($LASTEXITCODE -eq 0 -and $tree -ceq '51f15b2a1113fc3742559f7d76dab350fb8bb83c') 'MergedPr12CodeTree'
 $diff=@(& git -C $codeRoot diff --name-only HEAD);Need ($LASTEXITCODE -eq 0 -and $diff.Count -eq 0) 'NoUncommittedTrackedCodeChanges'
 $staged=@(& git -C $codeRoot diff --cached --name-only);Need ($LASTEXITCODE -eq 0 -and $staged.Count -eq 0) 'NoStagedCodeChanges'
 New-Json $beforePath ([pscustomobject]@{Task='YSEDU_SQL_ACTIVATION_001';At=(Get-Date -Format o);Original=$before;Address=$addr;KeyDaclSHA256=$keyBefore.DaclSHA256;ExistingCsp24MachineKeySpec1=$true;ExplicitSystemRead=$true;RawKeyLocatorPublished=$false;CodeTree=$tree;LogBeforeBytes=$logBefore.Length;Rollback='Only four journal-owned settings before StartCalls consumed; accepted Root/Leaf/key excluded; after start no second stop or automatic recovery';Revocation='UNKNOWN accepted lab gap; not retested';TransactionsVerified=$false;OwnerAcceptedLabUnfinishedTransactionAndHistoricalRecoveryLimits=$true})
 $beforeHash=Hash $beforePath;$r['BaselineSHA256']=$beforeHash
 $state.Phase='ImmediatePreStop';$now=Inspect 'Baseline';Need ((Equal $before.Registry $now.Registry) -and (Equal $before.Services $now.Services) -and (Equal $before.Stores $now.Stores) -and (Equal $addr (Address)) -and (Equal $keyBefore (Key-Metadata $leaf[0]))) 'BaselineKeyAddressAndServicesStillExact';Clients;Browser
 $service=Get-Service -Name 'MSSQL$YSEDU';Need ($service.Status -eq 'Running') 'StillRunningBeforeOneStop'
 New-Json $attemptPath ([pscustomobject]@{Task='YSEDU_SQL_ACTIVATION_001';At=(Get-Date -Format o);BaselineSHA256=$beforeHash;MaxStops=1;MaxStarts=1;OriginalPid=$r.OriginalPid;CertificateAlreadyAccepted=$true;NoCertreq=$true;NoAutomaticRetry=$true})
 $stopUtc=[datetime]::UtcNow;$state.Phase='OneNaturalStop';$r.StopCalls++;$service.Stop($false);$service.WaitForStatus('Stopped',[TimeSpan]::FromSeconds(120));$service.Refresh()
 Need ($service.Status -eq 'Stopped' -and $null -eq (Get-Process -Id $r.OriginalPid -ErrorAction SilentlyContinue)) 'NaturallyStoppedAndOldProcessExited';Browser
 $state.Phase='FourOwnedBindingTcpChanges';$base=[Microsoft.Win32.RegistryKey]::OpenBaseKey('LocalMachine','Registry32')
 Write-Owned 0 $scope 'Certificate' '' $thumb.ToLowerInvariant() 'String'
 Write-Owned 1 ($scope+'\Tcp') 'ListenOnAllIPs' 1 0 'DWord'
 Write-Owned 2 ($scope+'\Tcp\IP4') 'Enabled' 0 1 'DWord'
 Write-Owned 3 ($scope+'\Tcp') 'Enabled' 0 1 'DWord'
 $null=Inspect 'Forward';Need ((Equal $addr (Address)) -and (Equal $keyBefore (Key-Metadata $leaf[0]))) 'PreStartSameAddressAndKey';Browser
 $state.Phase='OneNaturalStart';Start-Once
 $state.Phase='CurrentStartupCertificateAndOwnedListener'
 $svc=Get-CimInstance Win32_Service -Filter 'Name=''MSSQL$YSEDU'''
 Need ($svc.State -ceq 'Running' -and $svc.StartName -ceq 'LocalSystem' -and $svc.PathName -ceq $saved.BrowserPolicy.YSEDU.PathName -and $svc.ProcessId -gt 0 -and $svc.ProcessId -ne $r.OriginalPid) 'NewYseduPidSameIdentity';$r.NewPid=[int]$svc.ProcessId
 $process=Get-Process -Id $r.NewPid
 try{Need ($process.Path -ceq 'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.YSEDU\MSSQL\Binn\sqlservr.exe' -and $process.StartTime.ToUniversalTime() -ge $stopUtc) 'NewProcessExecutableAndStartTime'}finally{$process.Dispose()}
 $deadline=[datetime]::UtcNow.AddSeconds(45);$listeners=@()
 do{
  Browser;$listeners=@(Get-NetTCPConnection -State Listen -ErrorAction Stop|Where-Object OwningProcess -EQ $r.NewPid)
  Need (@($listeners|Where-Object LocalAddress -CNE '192.168.56.1').Count -eq 0) 'NoUnapprovedYseduTcpListener'
  $logEvidence=Startup-Evidence @(Get-Content -LiteralPath $logPath -Tail 1000) $r.NewPid $stopUtc.AddSeconds(-2)
  if($logEvidence.Passed -and $listeners.Count -eq 1){break};Start-Sleep -Milliseconds 1000
 }while([datetime]::UtcNow -lt $deadline)
 Need ($logEvidence.Passed) 'FreshErrorlogExactLeafPidAndReadyNoFallback'
 Need ($listeners.Count -eq 1 -and $listeners[0].LocalPort -ge 1 -and $listeners[0].LocalPort -le 65535) 'OneActualDynamicPortOwnedByYsedu'
 $port=[int]$listeners[0].LocalPort;$post=Inspect 'Forward' $port
 Need ((Equal $before.Stores $post.Stores) -and (Equal $addr (Address)) -and (Equal $keyBefore (Key-Metadata $leaf[0]))) 'PostStartStoresAddressAndKeyUnchanged'
 Need (@($post.Services|Where-Object{$_.Name -ceq 'MSSQL$YSEDU' -and $_.State -ceq 'Running' -and $_.ProcessId -eq $r.NewPid}).Count -eq 1) 'SameRunningNewPidAfterQualification'
 $last=@(Get-NetTCPConnection -State Listen -ErrorAction Stop|Where-Object OwningProcess -EQ $r.NewPid);Need ($last.Count -eq 1 -and $last[0].LocalAddress -ceq '192.168.56.1' -and $last[0].LocalPort -eq $port) 'ListenerFinalRecheck';Browser
 foreach($pin in $pins.GetEnumerator()){Need ((Hash (Join-Path $root $pin.Key)) -ceq $pin.Value) 'OriginalEvidenceUnchangedAfterActivation'}
 $r.CertificateLoading='PASSED_EXACT_LEAF_CURRENT_STARTUP_ERRORLOG';$r['StartupEvidence']=$logEvidence
 $r.TcpListener=[pscustomobject]@{Address='192.168.56.1';Port=$port;OwningProcess=$r.NewPid;Instance='YSEDU';Dynamic=$true;BrowserDiscovery=$false}
 $r['PostRegistry']=$post.Registry;$r.Decision='YSEDU_SQL_ACTIVATION_001_PASSED_NODE_AND_LIVE_DATA_NOT_TESTED'
}catch{
 $failure=[pscustomobject]@{Phase=$state.Phase;Check=$state.Check;ExceptionType=$_.Exception.GetType().FullName;SafeGateCode=if($_.Exception -is [InvalidOperationException] -and $_.Exception.Message -cmatch '\A[A-Za-z][A-Za-z0-9_]{0,100}\z'){$_.Exception.Message}else{$null};RawExceptionPublished=$false}
 if($CheckOnly){throw [InvalidOperationException]::new('Source qualification failed at '+$state.Check)}
 if($r.StopCalls -eq 1 -and $r.StartCalls -eq 0){
  try{
   if((Get-Service -Name 'MSSQL$YSEDU').Status -eq 'Stopped' -and $null -eq (Get-Process -Id $r.OriginalPid -ErrorAction SilentlyContinue)){
    if($r.RegistryWriteAttempts -gt 0){Need ((Hash $rollbackPath) -ceq $rollbackPin) 'RollbackPinBeforeApply';$rb=(& $rollbackPath -Phase OwnedPartial -Apply -MaintenanceAuthorized) -join "`n"|ConvertFrom-Json;Need ($rb.Decision -ceq 'YSEDU_ROLLBACK_002_OWNED_SETTINGS_RESTORED_CERTIFICATES_RETAINED') 'OwnedRollbackVerified';$r.Rollback='OWNED_BINDING_TCP_RESTORED_CA_LEAF_KEY_RETAINED'}else{$null=Inspect 'OwnedPartial';$r.Rollback='NO_MUTATION_ORIGINAL_SETTINGS'}
    $state.Phase='OneOriginalConfigurationRecoveryStart';Start-Once;$r['RecoveryStart']='ORIGINAL_CONFIGURATION_RUNNING_CERTIFICATES_RETAINED'
   }else{$r.Rollback='DEFERRED_STOP_NOT_COMPLETED_OR_PROCESS_REMAINS_NO_FORCE'}
  }catch{$r['RecoveryFailure']=[pscustomobject]@{Check=$state.Check;ExceptionType=$_.Exception.GetType().FullName;RawExceptionPublished=$false};$r.Rollback='RECOVERY_BLOCKED_NO_AUTOMATIC_RETRY'}
 }elseif($r.StartCalls -gt 0){$r.Rollback='DEFERRED_AFTER_SINGLE_START_CONSUMED_NO_SECOND_STOP_OR_START'}
}finally{
 foreach($c in $leaf+$ca+@($public)){if($null -ne $c){try{$c.Dispose()}catch{$cleanup.Add('CertificateDispose')}}}
 if($null -ne $base){try{$base.Dispose()}catch{$cleanup.Add('RegistryDispose')}}
 if($null -ne $service){try{$service.Dispose()}catch{$cleanup.Add('ServiceControllerDispose')}}
}
if($CheckOnly){return}
$r.At=Get-Date -Format o;$r['Failure']=$failure;$r['CleanupFailures']=@($cleanup.ToArray())
if($cleanup.Count){$r.Decision='YSEDU_SQL_ACTIVATION_001_BLOCKED_STOP'}
try{$r['FinalSqlState']=[string](Get-Service -Name 'MSSQL$YSEDU').Status;$r['FinalBrowserState']=[string](Get-Service -Name SQLBrowser).Status}catch{$r['FinalServiceRead']='FAILED';$r.Decision='YSEDU_SQL_ACTIVATION_001_BLOCKED_STOP'}
$r['Pending']='STOP. No Node TLS, reader login or import. Do not rerun maintenance; any recovery after consumed start needs separate approval.'
if($r.Elevated -and -not(Test-Path -LiteralPath $output)){New-Json $output $r}
$r|ConvertTo-Json -Depth 18
