[CmdletBinding()]
param([switch]$Apply,[switch]$RequireBaseline,[switch]$MaintenanceAuthorized)
# Corrected actual-leaf rollback #002; default inspection only. Preserve #001 for historical pins. Never stops/starts SQL.
# Applying requires SQL already Stopped. No key deletion, trust/ACL/Firewall changes.
$ErrorActionPreference='Stop'
Set-StrictMode -Version Latest
$rbRoot='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010'
$rbOriginal=Join-Path $rbRoot 'YSEDU_LEAF_MAINTENANCE_ORIGINAL.json'
if($env:COMPUTERNAME -cne 'DESKTOP-8QRQT7R' -or (Get-FileHash -LiteralPath $rbOriginal -Algorithm SHA256).Hash -cne 'BB3BF707DCEEDB99396BF2C598B3A0E9BF2E02E83F3FD7AE3A8DB27CF1931BD5'){throw 'STOP: original/host mismatch'}
if($Apply -and (-not $MaintenanceAuthorized -or $RequireBaseline)){throw 'STOP: separate maintenance authority required; Apply is not readiness'}
$rbSaved=Get-Content -LiteralPath $rbOriginal -Raw|ConvertFrom-Json
if($rbSaved.Decision -cne 'YSEDU_LEAF_MAINTENANCE_ORIGINAL_CAPTURED_READONLY' -or $rbSaved.InstanceId -cne 'MSSQL12.YSEDU'){throw 'STOP: original identity'}
$rbSs='SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL12.YSEDU\MSSQLServer\SuperSocketNetLib'
$rbBase=[Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine,[Microsoft.Win32.RegistryView]::Registry32)
$rbPlan=[Collections.Generic.List[object]]::new()
$rbOwned=$null;$rbMy=@();$rbChanges=0
function Test-RbEqual($A,$B){ return (($A|ConvertTo-Json -Depth 5 -Compress) -ceq ($B|ConvertTo-Json -Depth 5 -Compress)) }
function Test-RbLeafEvidence($Owned) {
 try {
  return ($Owned.Decision -ceq 'YSEDU_EXISTING_CSR_LEAF_SIGNED_AND_PROFILE_QUALIFIED' -and
   $Owned.CAThumbprint -ceq '121CDC9857488ED95F4BC62106D7672BB0DBC6C3' -and
   $Owned.LeafThumbprint -ceq 'A51BD253B6083D0114428FCFBAD57D008CD102F5' -and
   $Owned.LeafSHA256 -ceq '522C79FD31F0422D3988FB00CC4EF0A51B4042DEED72A435A6519237AC548DFE' -and
   $Owned.CsrFileSHA256 -ceq '61B48D26A1AFB37B27ACF0EFDFAA1D90A29B9A39B2F012E0DA7367046E19B889' -and
   $Owned.CsrPublicKeyMatches -eq $true -and $Owned.PublicArtifactsReReadEqual -eq $true -and
   $Owned.FiveCertificateStoresUnchanged -eq $true -and $Owned.ExistingArtifactsUnchanged -eq $true -and
   $Owned.CertificateAccepted -eq $false -and $Owned.CAReissued -eq $false -and
   @($Owned.CleanupFailures).Count -eq 0)
 }catch{return $false}
}
function Test-RbOwnedChange([string]$Path,[string]$Name,$Value,$Owned) {
 $ss='SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL12.YSEDU\MSSQLServer\SuperSocketNetLib'
 if($Path -ceq $ss -and $Name -ceq 'Certificate'){return ((Test-RbLeafEvidence $Owned) -and [string]$Value -ieq 'A51BD253B6083D0114428FCFBAD57D008CD102F5')}
 if($Path -ceq ($ss+'\Tcp') -and $Name -ceq 'Enabled'){return ([int]$Value -eq 1)}
 if($Path -ceq ($ss+'\Tcp') -and $Name -ceq 'ListenOnAllIPs'){return ([int]$Value -eq 0)}
 if($Path -ceq ($ss+'\Tcp\IP4') -and $Name -ceq 'Enabled'){return ([int]$Value -eq 1)}
 if($Path -ceq ($ss+'\Tcp\IP4') -and $Name -ceq 'TcpDynamicPorts'){return ([string]$Value -match '^\d{1,5}$' -and [int]$Value -ge 1 -and [int]$Value -le 65535)}
 if($Path -ceq 'SYSTEM\CurrentControlSet\Services\SQLBrowser' -and $Name -ceq 'Start'){return ([int]$Value -eq 3)}
 return $false
}
try {
 $signed=Join-Path $rbRoot 'YSEDU_LEAF_SIGNING_001_RESULT.json'
 if((Get-FileHash -LiteralPath $signed -Algorithm SHA256).Hash -cne '756917FF89B109902D5E88CBDDC487B121C1B830B9EECAEF302DE441E6C505C4'){throw 'STOP: actual signed result pin'}
 $rbOwned=Get-Content -LiteralPath $signed -Raw|ConvertFrom-Json
 if(-not(Test-RbLeafEvidence $rbOwned)){throw 'STOP: actual leaf ownership evidence unqualified'}
 $leafDer=Join-Path $rbRoot 'YSEDU-Leaf-Signed-001.cer'
 if((Get-FileHash -LiteralPath $leafDer -Algorithm SHA256).Hash -cne $rbOwned.LeafSHA256){throw 'STOP: signed DER pin'}
 $publicLeaf=[Security.Cryptography.X509Certificates.X509CertificateLoader]::LoadCertificate([IO.File]::ReadAllBytes($leafDer))
 try{if($publicLeaf.Thumbprint -cne $rbOwned.LeafThumbprint -or $publicLeaf.HasPrivateKey){throw 'STOP: actual public leaf identity'}}finally{$publicLeaf.Dispose()}
 $rbMy=@(Get-ChildItem -LiteralPath 'Cert:\LocalMachine\My')
 if($rbMy.Count -gt 1){throw 'STOP: machine Personal count outside owned scope'}
 foreach($c in $rbMy){
  if($null -eq $rbOwned -or $c.Thumbprint -cne $rbOwned.LeafThumbprint -or [Convert]::ToHexString([Security.Cryptography.SHA256]::HashData($c.RawData)) -cne $rbOwned.LeafSHA256){throw 'STOP: unknown machine Personal certificate'}
 }
 $savedRoots=@(($rbSaved.MachineCertificateStores|Where-Object Store -CEQ 'Cert:\LocalMachine\Root').Certificates.Thumbprint|Sort-Object)
 $currentRoots=@(Get-ChildItem -LiteralPath 'Cert:\LocalMachine\Root'|ForEach-Object Thumbprint|Sort-Object)
 if(-not (Test-RbEqual $savedRoots $currentRoots)){throw 'STOP: machine root trust drift'}
 $tcpKey=$rbBase.OpenSubKey($rbSs+'\Tcp',$false)
 try {$savedNames=@($rbSaved.TcpRegistry|Where-Object Path -CNE ($rbSs+'\Tcp')|ForEach-Object {Split-Path $_.Path -Leaf}|Sort-Object);$liveNames=@($tcpKey.GetSubKeyNames()|Sort-Object);if(-not(Test-RbEqual $savedNames $liveNames)){throw 'STOP: TCP target inventory drift'}}finally{$tcpKey.Dispose()}
 $targets=@($rbSaved.Security)+@($rbSaved.TcpRegistry)+@($rbSaved.Startup)+@($rbSaved.ServiceRegistry)
 foreach($target in $targets){
  $key=$rbBase.OpenSubKey($target.Path,$false)
  if($null -eq $key){throw 'STOP: target missing'}
  try {
   foreach($v in $target.Values){
    $present=@($key.GetValueNames()) -ccontains $v.Name
    $kind=if($present){[string]$key.GetValueKind($v.Name)}else{$null}
    $value=if($present){$key.GetValue($v.Name,$null,[Microsoft.Win32.RegistryValueOptions]::DoNotExpandEnvironmentNames)}else{$null}
    if($present -eq $v.Present -and $kind -ceq $v.Kind -and (Test-RbEqual $value $v.Value)){continue}
    $allowed=$false
    if($present -and $v.Present -and $kind -ceq $v.Kind){
     $allowed=Test-RbOwnedChange $target.Path $v.Name $value $rbOwned
    }
    if(-not $allowed){throw 'STOP: change outside owned forward scope'}
    $rbPlan.Add([pscustomobject]@{Path=$target.Path;Name=$v.Name;Before=$value;After=$v.Value;Kind=$v.Kind})
   }
  }finally{$key.Dispose()}
 }
 $sql=Get-CimInstance Win32_Service -Filter 'Name=''MSSQL$YSEDU'''
 $browser=Get-CimInstance Win32_Service -Filter 'Name=''SQLBrowser'''
 if($sql.PathName -cne $rbSaved.BrowserPolicy.YSEDU.PathName -or $sql.StartName -ine 'LocalSystem' -or $sql.StartMode -ne 'Auto' -or $browser.PathName -cne $rbSaved.BrowserPolicy.Browser.PathName -or $browser.StartName -ine 'NT AUTHORITY\LOCALSERVICE'){throw 'STOP: service identity drift'}
 $protocols=@(Get-CimInstance -Namespace 'root\Microsoft\SqlServer\ComputerManagement12' -ClassName ServerNetworkProtocol -Filter "InstanceName='YSEDU'")
 if($protocols.Count -ne 3 -or @($protocols|Where-Object {$_.ProtocolName -ceq 'Sm' -and $_.Enabled}).Count -ne 1 -or @($protocols|Where-Object {$_.ProtocolName -ceq 'Np' -and $_.Enabled}).Count){throw 'STOP: other protocol drift'}
 if($RequireBaseline -and @($protocols|Where-Object {$_.ProtocolName -ceq 'Tcp' -and $_.Enabled}).Count){throw 'STOP: TCP protocol baseline drift'}
 $sqlState=[string](Get-Service -Name 'MSSQL$YSEDU').Status
 $browserState=[string](Get-Service -Name SQLBrowser).Status
 if($RequireBaseline -and ($rbPlan.Count -or $rbMy.Count -or $sqlState -cne 'Running' -or $browserState -cne 'Stopped')){throw 'STOP: original operational baseline not intact'}
 $rbSummary=[pscustomobject]@{Decision='YSEDU_COMBINED_ROLLBACK_INSPECTION_PASSED';ApplyRequested=[bool]$Apply;Changes=@($rbPlan.ToArray());OwnedLeafCount=$rbMy.Count;SqlState=$sqlState;BrowserState=$browserState;SqlStopOrStart=$false;TrustOrAclChange=$false;KeyDeletion=$false}
 if(-not $Apply){$rbSummary|ConvertTo-Json -Depth 6;return}
 $who=[Security.Principal.WindowsPrincipal]::new([Security.Principal.WindowsIdentity]::GetCurrent())
 if(-not $who.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator) -or $sqlState -cne 'Stopped'){throw 'STOP: apply requires actual administrator and already stopped SQL; no automatic interruption'}
 if(@(Get-Service -Name 'MSSQL$YSEDU' -DependentServices|Where-Object Status -NE 'Stopped').Count){throw 'STOP: dependent service active'}
 if($browserState -ne 'Stopped'){
  $b=Get-Service -Name SQLBrowser
  $b.Stop();$b.WaitForStatus('Stopped',[TimeSpan]::FromSeconds(30))
 }
 if(@($rbPlan|Where-Object {$_.Path -ceq 'SYSTEM\CurrentControlSet\Services\SQLBrowser' -and $_.Name -ceq 'Start'}).Count){Set-Service -Name SQLBrowser -StartupType Disabled;$rbChanges++}
 foreach($change in $rbPlan|Where-Object Path -CNE 'SYSTEM\CurrentControlSet\Services\SQLBrowser'){
  if((Get-Service -Name 'MSSQL$YSEDU').Status -ne 'Stopped'){throw 'STOP: SQL state changed during restore'}
  $key=$rbBase.OpenSubKey($change.Path,$true)
  try {$now=$key.GetValue($change.Name,$null,[Microsoft.Win32.RegistryValueOptions]::DoNotExpandEnvironmentNames);if([string]$key.GetValueKind($change.Name) -cne $change.Kind -or -not(Test-RbEqual $now $change.Before)){throw 'STOP: rollback concurrent drift'};$key.SetValue($change.Name,$change.After,[Enum]::Parse([Microsoft.Win32.RegistryValueKind],$change.Kind));$rbChanges++}finally{$key.Dispose()}
 }
 if($rbMy.Count){
  $binding=$rbBase.OpenSubKey($rbSs,$false)
  try{if([string]$binding.GetValue('Certificate') -cne '' -or (Get-Service -Name 'MSSQL$YSEDU').Status -ne 'Stopped'){throw 'STOP: leaf still bound or SQL state drift'}}finally{$binding.Dispose()}
  $store=[Security.Cryptography.X509Certificates.X509Store]::new('My','LocalMachine')
  try {$store.Open([Security.Cryptography.X509Certificates.OpenFlags]::ReadWrite);$store.Remove($rbMy[0]);$rbChanges++}finally{$store.Close();$store.Dispose()}
 }
 # Re-read from a fresh scope in inspection mode. SQL start remains an explicit separate step.
 $check=(& ([scriptblock]::Create((Get-Content -LiteralPath (Join-Path $rbRoot 'Restore-YseduLeafNetwork002.ps1') -Raw)))) -join "`n"
 $verified=$check|ConvertFrom-Json
 if(@($verified.Changes).Count -or $verified.OwnedLeafCount -ne 0 -or $verified.BrowserState -cne 'Stopped'){throw 'STOP: restoration verification mismatch; no automatic retry/start'}
 [pscustomobject]@{Decision='YSEDU_COMBINED_SETTINGS_RESTORED_SQL_STILL_STOPPED';Operations=$rbChanges;KeyDeleted=$false;SqlStart=$false;RequiredNext='Review evidence, then one authorized normal YSEDU start; not a SQL database recovery proof'}|ConvertTo-Json
}finally{foreach($certificate in $rbMy){$certificate.Dispose()};$rbBase.Dispose()}
