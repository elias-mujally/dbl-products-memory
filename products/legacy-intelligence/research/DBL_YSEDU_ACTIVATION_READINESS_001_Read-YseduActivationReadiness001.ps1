[CmdletBinding()]
param([switch]$CheckOnly)
# Activation readiness only. No Apply, certificate acceptance, ACL/trust/service/network writes.
$ErrorActionPreference='Stop';Set-StrictMode -Version Latest
$root='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010'
$state=[pscustomobject]@{Phase='Identity';Check='ExactHostRuntime'}
$keyMetadata=$null;$pending=@();$public=$null;$leaf=$null;$result=$null;$failure=$null;$who=$null
$output=Join-Path $root 'YSEDU_ACTIVATION_READINESS_001_RESULT.json'
function Need-Readiness([bool]$Ok,[string]$Code){$state.Check=$Code;if(-not $Ok){throw 'STOP: readiness check'}}
function Readiness-SystemDacl($Raw){
 Need-Readiness ($null -ne $Raw.DiscretionaryAcl -and $Raw.DiscretionaryAcl.Count -gt 0) 'KeyDaclPresent'
 $mask=0L;$denies=0
 foreach($ace in $Raw.DiscretionaryAcl){
  Need-Readiness ($ace -is [Security.AccessControl.CommonAce] -and -not $ace.IsCallback -and [int]$ace.AceType -in @(0,1)) 'SupportedKeyDaclAce'
  if($ace.AceQualifier -eq [Security.AccessControl.AceQualifier]::AccessDenied){$denies++}
  if($ace.AceQualifier -eq [Security.AccessControl.AceQualifier]::AccessAllowed -and $ace.SecurityIdentifier.Value -ceq 'S-1-5-18' -and -not($ace.AceFlags -band [Security.AccessControl.AceFlags]::InheritOnly)){$mask=$mask -bor ([long]$ace.AccessMask -band 0xffffffffL)}
 }
 Need-Readiness ($denies -eq 0 -and ($mask -band 0x120089L) -eq 0x120089L) 'ExplicitSystemFileGenericReadNoDeny'
 return $denies
}
function Store-ReadinessFingerprint {
 $list=[Collections.Generic.List[string]]::new()
 foreach($p in @('Cert:\CurrentUser\My','Cert:\CurrentUser\Root','Cert:\LocalMachine\My','Cert:\LocalMachine\Root','Cert:\LocalMachine\Request')){
  $items=@(Get-ChildItem -LiteralPath $p)
  try{foreach($c in $items){$list.Add($p+'|'+$c.Thumbprint)}}finally{foreach($c in $items){$c.Dispose()}}
 }
 return [Convert]::ToHexString([Security.Cryptography.SHA256]::HashData([Text.Encoding]::UTF8.GetBytes((@($list|Sort-Object)-join "`n"))))
}
try {
 Need-Readiness ($env:COMPUTERNAME -ceq 'DESKTOP-8QRQT7R' -and $PSVersionTable.PSVersion.ToString() -ceq '7.6.5') 'ExactHostRuntime'
 $pins=@{
  'Restore-YseduLeafNetwork002.ps1'='3F1E4FEF5BB3FF0845014E4893155FE9A13059D7F593C6F1DA9066FCD1059D87'
  'YseduKeyStorageReadiness001.cs'='957DC651000AB683D2F679CF8ED844864BB4A075C0DDC2FF469598524D2E3784'
  'Read-BrowserExposure001.ps1'='0367AAB24C897A6D7964507AE4E1F0C1D8845A430D50D564115889C11AFD786B'
  'YSEDU_LEAF_MAINTENANCE_ORIGINAL.json'='BB3BF707DCEEDB99396BF2C598B3A0E9BF2E02E83F3FD7AE3A8DB27CF1931BD5'
  'YSEDU_LEAF_SIGNING_001_RESULT.json'='756917FF89B109902D5E88CBDDC487B121C1B830B9EECAEF302DE441E6C505C4'
  'YSEDU-Leaf-Signed-001.cer'='522C79FD31F0422D3988FB00CC4EF0A51B4042DEED72A435A6519237AC548DFE'
  'YSEDU_EXISTING_KEY_003_RESULT.json'='94B673461344785C58B1D96E366E5666B0D09D9C34DB6E6FF640EBBE8241D4DB'
 }
 $state.Phase='PinnedReadOnlySources'
 foreach($pin in $pins.GetEnumerator()){Need-Readiness ((Get-FileHash -LiteralPath (Join-Path $root $pin.Key) -Algorithm SHA256).Hash -ceq $pin.Value) ('ArtifactPin_'+$pin.Key.Replace('.','_'))}
 if($CheckOnly){[pscustomobject]@{Decision='ACTIVATION_READINESS_HELPER_PINS_PASSED';AdministrativeChecks=$false;ProviderOpened=$false;HostChanged=$false}|ConvertTo-Json;return}
 $who=[Security.Principal.WindowsPrincipal]::new([Security.Principal.WindowsIdentity]::GetCurrent())
 Need-Readiness ($who.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) 'ActualAdministrator'
 Need-Readiness (-not(Test-Path -LiteralPath $output)) 'FreshReadOnlyEvidenceNoOverwrite'
 $before=Store-ReadinessFingerprint
 $state.Phase='OriginalBaselineAndRollback';$state.Check='ReadOnlyRollbackInspection'
 $rollback=((& ([scriptblock]::Create((Get-Content -LiteralPath (Join-Path $root 'Restore-YseduLeafNetwork002.ps1') -Raw))) -RequireBaseline)-join "`n")|ConvertFrom-Json
 Need-Readiness ($rollback.Decision -ceq 'YSEDU_COMBINED_ROLLBACK_INSPECTION_PASSED' -and -not $rollback.ApplyRequested -and @($rollback.Changes).Count -eq 0 -and $rollback.OwnedLeafCount -eq 0) 'OriginalBaselineIntact'
 $state.Check='ReadServiceIdentity';$sql=Get-CimInstance Win32_Service -Filter 'Name=''MSSQL$YSEDU'''
 Need-Readiness ($sql.StartName -ieq 'LocalSystem' -and $sql.State -ceq 'Running') 'CurrentSqlLocalSystemRunning'
 $state.Phase='CurrentLocalTcpTarget';$state.Check='ReadLocalIp'
 $ip=@(Get-NetIPAddress -AddressFamily IPv4 -IPAddress '192.168.56.1')
 Need-Readiness ($ip.Count -eq 1 -and [string]$ip[0].AddressState -ceq 'Preferred') 'ApprovedLocalIpPreferred'
 $state.Check='ReadLocalAdapter';$adapter=Get-NetAdapter -InterfaceIndex $ip[0].InterfaceIndex
 Need-Readiness ([string]$adapter.Status -ceq 'Up' -and $adapter.InterfaceDescription -like '*VirtualBox*Host-Only*') 'ApprovedHostOnlyAdapterUp'
 $state.Check='ReadHostDns';$dns=@([Net.Dns]::GetHostAddresses('DESKTOP-8QRQT7R')|ForEach-Object IPAddressToString)
 Need-Readiness ($dns -contains '192.168.56.1') 'ApprovedLocalAddressInDns'
 $state.Phase='BrowserStaticPolicy';$state.Check='ReadBrowserExposure'
 $browser=((& ([scriptblock]::Create((Get-Content -LiteralPath (Join-Path $root 'Read-BrowserExposure001.ps1') -Raw))))-join "`n")|ConvertFrom-Json
 Need-Readiness ($browser.Decision -ceq 'BROWSER_FIREWALL_POLICY_STATIC_QUALIFICATION_PASSED' -and @($browser.ExperimentalClients).Count -eq 0 -and @($browser.UDP1434Endpoints).Count -eq 0) 'BrowserAndClientBaseline'
 $state.Phase='ExistingKeyStorageAndDacl';$state.Check='ReadPendingCertificate'
 $pending=@(Get-ChildItem -LiteralPath 'Cert:\LocalMachine\Request')
 Need-Readiness ($pending.Count -eq 1 -and $pending[0].Thumbprint -ceq '079AF9D20802BD4A16B862928194A77BC14B93F4') 'ExactPendingAssociation'
 $leaf=[Security.Cryptography.X509Certificates.X509CertificateLoader]::LoadCertificate([IO.File]::ReadAllBytes((Join-Path $root 'YSEDU-Leaf-Signed-001.cer')))
 $public=[Security.Cryptography.X509Certificates.RSACertificateExtensions]::GetRSAPublicKey($pending[0])
 Need-Readiness ([Convert]::ToHexString($public.ExportSubjectPublicKeyInfo()) -ceq [Convert]::ToHexString($leaf.PublicKey.ExportSubjectPublicKeyInfo())) 'PendingPublicMatchesSignedLeaf'
 $state.Check='CompileStorageMetadataReader';Add-Type -TypeDefinition (Get-Content -LiteralPath (Join-Path $root 'YseduKeyStorageReadiness001.cs') -Raw)
 $keyMetadata=[DblYseduKeyStorageReadiness001+Result]::new();$state.Check='ReadExistingStorageLocator'
 [DblYseduKeyStorageReadiness001]::Read($pending[0].Handle,$keyMetadata)
 Need-Readiness ($keyMetadata.ContextOpened -and $keyMetadata.ContextReleased) 'ExistingProviderContextReleased'
 $keyFile=Join-Path (Join-Path $env:ProgramData 'Microsoft\Crypto\RSA\MachineKeys') $keyMetadata.UniqueName
 $state.Check='ReadKeyFileMetadata';$file=Get-Item -LiteralPath $keyFile -Force
 Need-Readiness ($file -is [IO.FileInfo]) 'ExistingKeyFile'
 $entry=$file;while($null -ne $entry){Need-Readiness (-not($entry.Attributes -band [IO.FileAttributes]::ReparsePoint)) 'NoKeyPathReparse';$entry=if($entry -is [IO.DirectoryInfo]){$entry.Parent}else{$entry.Directory}}
 $state.Check='ReadKeyDacl';$acl=Get-Acl -LiteralPath $keyFile
 $sections=[Security.AccessControl.AccessControlSections]'Owner,Group,Access'
 $sddl=$acl.GetSecurityDescriptorSddlForm($sections)
 $raw=[Security.AccessControl.RawSecurityDescriptor]::new($sddl)
 $denies=Readiness-SystemDacl $raw
 $state.Check='VerifyKeyDaclUnchanged'
 Need-Readiness ((Get-Acl -LiteralPath $keyFile).GetSecurityDescriptorSddlForm($sections) -ceq $sddl) 'KeyDaclUnchanged'
 Need-Readiness ((Store-ReadinessFingerprint) -ceq $before) 'FiveStoresUnchanged'
 Need-Readiness ((Get-Service -Name 'MSSQL$YSEDU').Status -eq 'Running' -and (Get-Service -Name SQLBrowser).Status -eq 'Stopped') 'ServicesUnchanged'
 $result=[pscustomobject]@{Decision='ACTIVATION_ADMIN_READONLY_PREFLIGHT_PASSED';At=(Get-Date -Format o);Host=$env:COMPUTERNAME;Elevated=$true;OriginalBaselineIntact=$true;SqlServiceAccount=$sql.StartName;SqlProcessId=$sql.ProcessId;LocalTcpCandidate='192.168.56.1 / IP4';Adapter=$adapter.InterfaceDescription;AddressPreferred=$true;DnsContainsLocalAddress=$true;BrowserStaticPolicy=$browser.Decision;BrowserPacketReachability='NOT_TESTED; future activation must verify actual exposure without Firewall changes';PendingPublicMatchesSignedLeaf=$true;ExistingProviderContextOpened=$true;NoKeyHandleOrSigning=$true;ContextReleased=$true;ExplicitSystemFileGenericRead=$true;KeyDenyAceCount=$denies;KeyDaclUnchanged=$true;KeyDaclSHA256=[Convert]::ToHexString([Security.Cryptography.SHA256]::HashData([Text.Encoding]::UTF8.GetBytes($sddl)));SystemServiceEffectiveKeyUse='NOT_TESTED; actual SQL loading gate after separately authorized maintenance';FiveStoresUnchanged=$true;SQL2014Loading='NOT_TESTED';RollbackApplyTested=$false;CertificateAccepted=$false;AclChanged=$false;ServiceChanged=$false;NetworkChanged=$false;TrustChanged=$false;FirstLiveData='NOT_TESTED';Pending='Review this evidence and bounded forward/rollback before one separately authorized maintenance. Do not stop SQL from readiness helper.'}
}catch{
 $failure=[pscustomobject]@{Decision='ACTIVATION_READINESS_BLOCKED_STOP';At=(Get-Date -Format o);Phase=$state.Phase;FailedCheck=$state.Check;NativeCheck=if($null -ne $keyMetadata){$keyMetadata.Check}else{$null};Win32=if($null -ne $keyMetadata){$keyMetadata.Win32}else{$null};ExceptionType=$_.Exception.GetType().FullName;NoAutomaticRetry=$true;CertificateAccepted=$false;AclChanged=$false;ServiceChanged=$false;NetworkChanged=$false;FirstLiveData='NOT_TESTED'}
}finally{foreach($c in @($public,$leaf)+$pending){if($null -ne $c){$c.Dispose()}}}
$final=if($null -ne $failure){$failure}else{$result}
if(-not $CheckOnly -and $who -and $who.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)){
 $bytes=[Text.Encoding]::UTF8.GetBytes(($final|ConvertTo-Json -Depth 6));$stream=[IO.File]::Open($output,[IO.FileMode]::CreateNew,[IO.FileAccess]::Write,[IO.FileShare]::None)
 try{$stream.Write($bytes,0,$bytes.Length);$stream.Flush($true)}finally{$stream.Dispose()}
}
$final|ConvertTo-Json -Depth 6
