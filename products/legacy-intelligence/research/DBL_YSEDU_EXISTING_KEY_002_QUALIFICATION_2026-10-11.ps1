[CmdletBinding()]
param([switch]$PublicOnly)
# OWNER APPROVED: qualify the existing CSR/key ONLY. No certreq, key creation, CA or SQL mutation.
$ErrorActionPreference='Stop';Set-StrictMode -Version Latest
$resumeRoot='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010'
$resumeOutput=Join-Path $resumeRoot 'YSEDU_EXISTING_KEY_002_RESULT.json'
$diagnosticPath=Join-Path $resumeRoot 'ExistingKeyDiagnostics002.ps1'
if((Get-FileHash -LiteralPath $diagnosticPath -Algorithm SHA256).Hash -cne '980064A9487C97F9F8E51F3F8CD7D0B27C308F109A53904316D6057072939BF9'){throw 'STOP: diagnostic library pin'}
. $diagnosticPath
$state=New-YseduDiagnosticState
$attemptPath=Join-Path $resumeRoot 'YSEDU_EXISTING_KEY_002_ATTEMPT.json'
$result=$null;$failure=$null;$attemptConsumed=$false
$pendingCertificate=$null;$privateRsa=$null;$pendingPublic=$null;$requestPublic=$null;$storeBefore=$null
function Assert-Resume([bool]$Condition,[string]$Code){Assert-YseduDiagnostic $state $Condition $Code}
function Get-ResumeStores {
 $lines=@(foreach($store in @('Cert:\CurrentUser\My','Cert:\CurrentUser\Root','Cert:\LocalMachine\My','Cert:\LocalMachine\Root','Cert:\LocalMachine\Request')){Get-ChildItem -LiteralPath $store|ForEach-Object {$store+'|'+$_.Thumbprint}})
 return [Convert]::ToHexString([Security.Cryptography.SHA256]::HashData([Text.Encoding]::UTF8.GetBytes((@($lines|Sort-Object)-join "`n"))))
}
function Write-ResumeResult($Object){$bytes=[Text.Encoding]::UTF8.GetBytes(($Object|ConvertTo-Json -Depth 6));$stream=[IO.File]::Open($resumeOutput,[IO.FileMode]::CreateNew,[IO.FileAccess]::Write,[IO.FileShare]::None);try{$stream.Write($bytes,0,$bytes.Length);$stream.Flush($true)}finally{$stream.Dispose()}}
try {
 Assert-Resume ($env:COMPUTERNAME -ceq 'DESKTOP-8QRQT7R' -and $PSVersionTable.PSVersion -ge [version]'7.6') 'HostRuntime'
 if(-not $PublicOnly){$principal=[Security.Principal.WindowsPrincipal]::new([Security.Principal.WindowsIdentity]::GetCurrent());Assert-Resume ($principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) 'ActualAdministrator';Assert-Resume (-not(Test-Path -LiteralPath $resumeOutput) -and -not(Test-Path -LiteralPath $attemptPath)) 'NewDiagnosticAttemptNoOverwrite'}
 $state.Phase='PreservedEvidencePins'
 $pins=@{
  'ExistingKeyDiagnostics002.ps1'='980064A9487C97F9F8E51F3F8CD7D0B27C308F109A53904316D6057072939BF9'
  'YSEDU_LEAF_CSR_ATTEMPT.json'='471BC62AA9572EB4F55D756CF2B95F4C0FA41F5AF4059418314BBC5716160BAE'
  'YSEDU_LEAF_CSR_RESULT.json'='770F09AA9B3844482081AA4879CEDCB73BFF0D112FE725FF52100E217ACFE4F0'
  'YSEDU-Leaf-CSP24-001.req'='61B48D26A1AFB37B27ACF0EFDFAA1D90A29B9A39B2F012E0DA7367046E19B889'
  'Invoke-YseduLeafCsr001.ps1'='D5C1F979DDA81AAE7868346F5715158BA20516AA6732EE28B6003EBC8DB48451'
  'Read-YseduExistingCsr001.ps1'='13785BB0C686698FEBFB49C323D567E08C0C7E233616A3C8699BEA2FB871925A'
  'YSEDU_LEAF_MAINTENANCE_ORIGINAL.json'='BB3BF707DCEEDB99396BF2C598B3A0E9BF2E02E83F3FD7AE3A8DB27CF1931BD5'
  'Restore-YseduLeafNetwork001.ps1'='B4BDAABC3802BBE4AE34C196AEE4A49CFED17328311CD2F6C2D5781532217B35'
  'Read-BrowserExposure001.ps1'='0367AAB24C897A6D7964507AE4E1F0C1D8845A430D50D564115889C11AFD786B'
 }
 foreach($pair in $pins.GetEnumerator()){$state.Check='ArtifactPin';Assert-Resume ((Get-FileHash -LiteralPath (Join-Path $resumeRoot $pair.Key) -Algorithm SHA256).Hash -ceq $pair.Value) 'ArtifactPin'}
 $old=Get-Content -LiteralPath (Join-Path $resumeRoot 'YSEDU_LEAF_CSR_RESULT.json') -Raw|ConvertFrom-Json
 Assert-Resume ($old.Decision -ceq 'YSEDU_CSR_BLOCKED_STOP' -and $old.Phase -ceq 'PublicCsrSignatureAndExtensions' -and $old.AttemptConsumed -eq $true -and $old.CertreqStillRunning -eq $false) 'PriorConsumedAttemptIdentity'
 $state.Phase='ExistingPublicCsr';$state.Check='PemEncoding'
 $text=Get-Content -LiteralPath (Join-Path $resumeRoot 'YSEDU-Leaf-CSP24-001.req') -Raw
 Assert-Resume ($text -cmatch '\A\s*-----BEGIN (?:NEW )?CERTIFICATE REQUEST-----\s+([A-Za-z0-9+/=\s]+)-----END (?:NEW )?CERTIFICATE REQUEST-----\s*\z') 'PemEncoding'
 $der=[Convert]::FromBase64String($Matches[1]);Assert-Resume ([Convert]::ToHexString([Security.Cryptography.SHA256]::HashData($der)) -ceq 'A1BE601581E3B647D3DAAF231524B71C78A2F874342CDB5FCB4CBD987577F273') 'ExactExistingDer'
 . (Join-Path $resumeRoot 'Read-YseduExistingCsr001.ps1');$state.Check='ClosedWorldPublicProfile';$request=Read-YseduExistingCsr001 $der
 if($PublicOnly){[pscustomobject]@{Decision='EXISTING_KEY_002_PUBLIC_PREFLIGHT_PASSED';ObservedAt=(Get-Date -Format o);ExistingDerSHA256='A1BE601581E3B647D3DAAF231524B71C78A2F874342CDB5FCB4CBD987577F273';OriginalEvidencePins='PASSED';PublicProfile='PASSED';ExistingPrivateKeyAccessed=$false;NativeKeyCreation=$false;SqlChanged=$false;ResultWritten=$false}|ConvertTo-Json;return}
 $state.Phase='NativeReadOnlyBaseline';$state.Check='NoCertreqProcess'
 Assert-Resume (@(Get-Process -Name certreq -ErrorAction SilentlyContinue).Count -eq 0) 'NoCertreqProcess'
 $state.Check='CombinedRollbackBaseline';$rb=((& ([scriptblock]::Create((Get-Content -LiteralPath (Join-Path $resumeRoot 'Restore-YseduLeafNetwork001.ps1') -Raw))) -RequireBaseline)-join "`n")|ConvertFrom-Json
 Assert-Resume ($rb.Decision -ceq 'YSEDU_COMBINED_ROLLBACK_INSPECTION_PASSED' -and $rb.ApplyRequested -eq $false -and @($rb.Changes).Count -eq 0 -and $rb.OwnedLeafCount -eq 0) 'CombinedRollbackBaseline'
 $state.Check='BrowserClientBaseline';$browser=((& ([scriptblock]::Create((Get-Content -LiteralPath (Join-Path $resumeRoot 'Read-BrowserExposure001.ps1') -Raw))))-join "`n")|ConvertFrom-Json
 Assert-Resume ($browser.Decision -ceq 'BROWSER_FIREWALL_POLICY_STATIC_QUALIFICATION_PASSED' -and @($browser.ExperimentalClients).Count -eq 0 -and @($browser.UDP1434Endpoints).Count -eq 0 -and @($browser.SQLInstanceMap).Count -eq 1 -and $browser.SQLInstanceMap[0].Name -ceq 'YSEDU') 'BrowserClientBaseline'
 Assert-Resume (@(Get-Service -Name 'MSSQL$YSEDU' -DependentServices|Where-Object Status -NE 'Stopped').Count -eq 0) 'DependentServiceBaseline'
 $storeBefore=Get-ResumeStores
 $state.Phase='ExistingPendingKey';$state.Check='PendingRequestIdentity'
 $pending=@(Get-ChildItem -LiteralPath 'Cert:\LocalMachine\Request')
 Assert-Resume ($pending.Count -eq 1 -and $pending[0].Subject -ceq 'CN=DESKTOP-8QRQT7R' -and $pending[0].HasPrivateKey) 'PendingRequestIdentity'
 $pendingCertificate=$pending[0]
 Assert-Resume ($pendingCertificate.Thumbprint -ceq '079AF9D20802BD4A16B862928194A77BC14B93F4') 'ExactPendingRequestThumbprint'
 $state.Check='CreateNewDiagnosticAttempt'
 $marker=[Text.Encoding]::UTF8.GetBytes((([pscustomobject]@{Task='EXISTING_KEY_DIAGNOSTIC_002';At=(Get-Date -Format o);NativeKeyCreation=$false;OwnerApprovedSingleExistingKeyCheck=$true})|ConvertTo-Json))
 $markerStream=[IO.File]::Open($attemptPath,[IO.FileMode]::CreateNew,[IO.FileAccess]::Write,[IO.FileShare]::None)
 $attemptConsumed=$true
 try{$markerStream.Write($marker,0,$marker.Length);$markerStream.Flush($true)}finally{$markerStream.Dispose()}
 $state.OpenAttempted=$true
 $privateRsa=Invoke-YseduCheckedRead $state 'GetRSAPrivateKey' { [Security.Cryptography.X509Certificates.RSACertificateExtensions]::GetRSAPrivateKey($pendingCertificate) }
 Set-YseduReturnedKeyState $state $privateRsa
 Assert-Resume $state.KeyReturnedNonNull 'ReturnedKeyRequired'
 Assert-Resume ($privateRsa -is [Security.Cryptography.RSACryptoServiceProvider]) 'LegacyCspRequired'
 $ki=Read-YseduExplicitProperty $state 'ReadCspKeyContainerInfo' $privateRsa 'CspKeyContainerInfo'
 $state.ProviderType=Read-YseduExplicitProperty $state 'ReadProviderType' $ki 'ProviderType'
 Assert-Resume ($state.ProviderType -eq 24) 'ProviderType24'
 $observedProvider=Read-YseduExplicitProperty $state 'ReadProviderName' $ki 'ProviderName'
 $state.ProviderName=if($observedProvider -ceq 'Microsoft Enhanced RSA and AES Cryptographic Provider'){$observedProvider}else{'OTHER_UNQUALIFIED'}
 Assert-Resume ($state.ProviderName -ceq 'Microsoft Enhanced RSA and AES Cryptographic Provider') 'ProviderNameCsp24'
 $state.KeySpec=[int](Read-YseduExplicitProperty $state 'ReadKeySpec' $ki 'KeyNumber')
 Assert-Resume ($state.KeySpec -eq 1) 'KeySpec1'
 $state.MachineKeySet=Read-YseduExplicitProperty $state 'ReadMachineKeyStore' $ki 'MachineKeyStore'
 Assert-Resume ($state.MachineKeySet -is [bool] -and $state.MachineKeySet) 'MachineKeyRequired'
 $state.Exportable=Read-YseduExplicitProperty $state 'ReadExportable' $ki 'Exportable'
 Assert-Resume ($state.Exportable -is [bool] -and -not $state.Exportable) 'NonExportableRequired'
 $state.RSAKeyBits=Read-YseduExplicitProperty $state 'ReadKeySize' $privateRsa 'KeySize'
 Assert-Resume ($state.RSAKeyBits -eq 2048) 'RSA2048Required'
 $pendingPublic=[Security.Cryptography.X509Certificates.RSACertificateExtensions]::GetRSAPublicKey($pendingCertificate);$requestPublic=$request.PublicKey.GetRSAPublicKey()
 Assert-Resume ([Convert]::ToBase64String($pendingPublic.ExportSubjectPublicKeyInfo()) -ceq [Convert]::ToBase64String($requestPublic.ExportSubjectPublicKeyInfo())) 'ExistingKeyMatchesCsr'
 $state.Check='ExistingKeyChallenge';$challenge=[Security.Cryptography.RandomNumberGenerator]::GetBytes(32);$signature=$privateRsa.SignData($challenge,[Security.Cryptography.HashAlgorithmName]::SHA256,[Security.Cryptography.RSASignaturePadding]::Pkcs1)
 Assert-Resume ($requestPublic.VerifyData($challenge,$signature,[Security.Cryptography.HashAlgorithmName]::SHA256,[Security.Cryptography.RSASignaturePadding]::Pkcs1)) 'ExistingKeyChallenge'
 $state.ChallengePassed=$true
 $state.Phase='ExistingKeyDaclRead';$state.Check='KeyIdentityBound'
 $uniqueKeyName=Read-YseduExplicitProperty $state 'ReadUniqueKeyContainerName' $ki 'UniqueKeyContainerName'
 Assert-Resume (-not [string]::IsNullOrEmpty($uniqueKeyName) -and $uniqueKeyName -notmatch '[\\/:]') 'KeyIdentityBound'
 $keyFile=Join-Path 'C:\ProgramData\Microsoft\Crypto\RSA\MachineKeys' $uniqueKeyName
 $state.Check='KeyFileMetadataRead';$item=Get-Item -LiteralPath $keyFile -Force;Assert-Resume (($item.Attributes -band [IO.FileAttributes]::ReparsePoint) -eq 0) 'NoKeyReparsePoint'
 $state.Check='KeyDaclRead';$acl=Get-Acl -LiteralPath $keyFile;$rules=@($acl.GetAccessRules($true,$true,[Security.Principal.SecurityIdentifier]))
 $deny=@($rules|Where-Object {$_.AccessControlType -eq 'Deny'});$allow=@($rules|Where-Object {$_.AccessControlType -eq 'Allow' -and $_.IdentityReference.Value -ceq 'S-1-5-18' -and ([int]$_.FileSystemRights -band [int][Security.AccessControl.FileSystemRights]::ReadData)})
 Assert-Resume ($deny.Count -eq 0 -and $allow.Count -gt 0) 'SystemReadRuleNoDeny'
 $state.Phase='FinalReadOnlyChecks';Assert-Resume ((Get-ResumeStores) -ceq $storeBefore) 'FiveStoresUnchangedDuringResume'
 Assert-Resume ((Get-Service -Name 'MSSQL$YSEDU').Status -eq 'Running' -and (Get-Service -Name SQLBrowser).Status -eq 'Stopped') 'ServiceBaselineUnchanged'
 foreach($pair in $pins.GetEnumerator()){$state.Check='FinalArtifactPin';Assert-Resume ((Get-FileHash -LiteralPath (Join-Path $resumeRoot $pair.Key) -Algorithm SHA256).Hash -ceq $pair.Value) 'FinalArtifactPin'}
 $state.Phase='NewEvidenceOnly';$state.Check='CreateNewResumeResult'
 $result=[pscustomobject]@{Decision='EXISTING_YSEDU_CSR_AND_CSP24_KEY_QUALIFIED_002';ObservedAt=(Get-Date -Format o);Host=$env:COMPUTERNAME;Elevated=$true;CSRFileSHA256=$pins['YSEDU-Leaf-CSP24-001.req'];CSRDerSHA256='A1BE601581E3B647D3DAAF231524B71C78A2F874342CDB5FCB4CBD987577F273';PendingRequestThumbprint=$pendingCertificate.Thumbprint;Subject=$request.SubjectName.Name;Signature='SHA256/RSA verified';NativeExtraExtensions='Exact noncritical enrollment metadata; not leaf profile';SKI='Matches existing public key';EnrollmentAttributes='Exact three observed values; not forwarded';OpenAttempted=$state.OpenAttempted;KeyReturnedNonNull=$state.KeyReturnedNonNull;ManagedKeyType=$state.ManagedKeyType;Provider=$state.ProviderName;ProviderType=$state.ProviderType;KeySpec=$state.KeySpec;RSAKeyBits=$state.RSAKeyBits;MachineKeySet=$state.MachineKeySet;Exportable=$state.Exportable;KeyFile=$keyFile;KeyOwner=$acl.Owner;KeyDaclSDDL=$acl.Sddl;SystemReadRulePresent=$true;EffectiveSystemAccess='NOT_TESTED';KeyChallengePassed=$true;OriginalArtifactsUnchanged=$true;FiveStoresUnchangedDuringResume=$true;NativeKeyCreation=$false;CertificateIssued=$false;CertificateAccepted=$false;CAUnlocked=$false;SqlStopped=$false;RegistryChanged=$false;ServiceChanged=$false;FirewallChanged=$false;EWrites=$false;SQLConnection=$false;FirstLiveData='NOT_TESTED';Pending='STOP before CA signing, certificate acceptance or maintenance'}
 # Evidence is emitted only after resource cleanup has succeeded.
}catch{
 $failure=[pscustomobject]@{Decision='EXISTING_KEY_002_BLOCKED_STOP';ObservedAt=(Get-Date -Format o);Phase=$state.Phase;FailedCheck=$state.Check;ExceptionType=$_.Exception.GetType().FullName;AttemptConsumed=$attemptConsumed;DiagnosticState=$state;NativeKeyCreation=$false;CAUnlocked=$false;SqlStopped=$false;OriginalArtifactsChanged=$false;NoAutomaticRetry=$true;Reason='Safe check codes only; preserve original evidence and existing key; STOP before signing or maintenance'}
}finally{
 Close-YseduDiagnosticResources $state @(
  @{Code='RequestPublicDispose';Resource=$requestPublic},
  @{Code='PendingPublicDispose';Resource=$pendingPublic},
  @{Code='ExistingPrivateDispose';Resource=$privateRsa},
  @{Code='PendingCertificateDispose';Resource=$pendingCertificate}
 )
}
if($state.CleanupFailures.Count -gt 0 -and $null -eq $failure){
 $failure=[pscustomobject]@{Decision='EXISTING_KEY_002_BLOCKED_STOP';ObservedAt=(Get-Date -Format o);Phase='Cleanup';FailedCheck='ResourceDisposal';AttemptConsumed=$attemptConsumed;DiagnosticState=$state;NativeKeyCreation=$false;CAUnlocked=$false;SqlStopped=$false;NoAutomaticRetry=$true}
}
$final=if($null -ne $failure){$failure}else{$result}
if($null -ne $final){
 $final|Add-Member -NotePropertyName CleanupFailures -NotePropertyValue @($state.CleanupFailures.ToArray())
 if(-not $PublicOnly -and $attemptConsumed){try{Write-ResumeResult $final}catch{
  $final|Select-Object -ExcludeProperty KeyFile,KeyOwner,KeyDaclSDDL|ConvertTo-Json -Depth 8
  [pscustomobject]@{Decision='RESULT_PERSISTENCE_BLOCKED_STOP';Phase='WriteCreateNewEvidence';EvidencePersisted=$false;NoAutomaticRetry=$true}|ConvertTo-Json
  return
 }}
 $final|Select-Object -ExcludeProperty KeyFile,KeyOwner,KeyDaclSDDL|ConvertTo-Json -Depth 8
}
