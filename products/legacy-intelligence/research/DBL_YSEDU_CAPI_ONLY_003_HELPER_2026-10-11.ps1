[CmdletBinding()]
param([switch]$PublicOnly)
# OWNER APPROVED: qualify the existing CSR/key ONLY. No certreq, key creation, CA or SQL mutation.
$ErrorActionPreference='Stop';Set-StrictMode -Version Latest
$resumeRoot='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010'
$resumeOutput=Join-Path $resumeRoot 'YSEDU_EXISTING_KEY_003_RESULT.json'
$diagnosticPath=Join-Path $resumeRoot 'ExistingKeyDiagnostics002.ps1'
if((Get-FileHash -LiteralPath $diagnosticPath -Algorithm SHA256).Hash -cne '980064A9487C97F9F8E51F3F8CD7D0B27C308F109A53904316D6057072939BF9'){throw 'STOP: diagnostic library pin'}
. $diagnosticPath
$state=New-YseduDiagnosticState
$attemptPath=Join-Path $resumeRoot 'YSEDU_EXISTING_KEY_003_ATTEMPT.json'
$result=$null;$failure=$null;$attemptConsumed=$false;$native=$null
$pending=@();$pendingCertificate=$null;$pendingPublic=$null;$requestPublic=$null;$storeBefore=$null
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
  'YseduCapiOnly003.cs'='ED81A7F991CAF6F61FC187B0CF254D331184AB64204DDCE15AA0D955180C5308'
  'YSEDU_EXISTING_KEY_002_RESULT.json'='E9CED7F9BBBFEAA55CAB4FDBCD4AB89B27D13E12423604C45D9E399A852ED3C2'
  'YSEDU_EXISTING_KEY_002_ATTEMPT.json'='FB51CA15E4C76DA293122087B437C6DD817D9C5D4B2969E9E9BE358718028F2C'
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
 $state.Check='CompilePinnedNativeSource';Add-Type -TypeDefinition (Get-Content -LiteralPath (Join-Path $resumeRoot 'YseduCapiOnly003.cs') -Raw)
 Assert-Resume ([DblYseduCapiOnly003]::AcquireFlags -eq 76 -and ([DblYseduCapiOnly003]::AcquireFlags -band 0x70003) -eq 0) 'ExactCapiOnlyNoCacheFlags'
 if($PublicOnly){[pscustomobject]@{Decision='EXISTING_KEY_003_PUBLIC_PREFLIGHT_PASSED';ObservedAt=(Get-Date -Format o);ExistingDerSHA256='A1BE601581E3B647D3DAAF231524B71C78A2F874342CDB5FCB4CBD987577F273';OriginalEvidencePins='PASSED';PublicProfile='PASSED';ExistingPrivateKeyAccessed=$false;NativeKeyCreation=$false;SqlChanged=$false;ResultWritten=$false}|ConvertTo-Json;return}
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
 $pendingPublic=[Security.Cryptography.X509Certificates.RSACertificateExtensions]::GetRSAPublicKey($pendingCertificate);$requestPublic=$request.PublicKey.GetRSAPublicKey()
 Assert-Resume ($null -ne $pendingPublic -and $null -ne $requestPublic -and [Convert]::ToBase64String($pendingPublic.ExportSubjectPublicKeyInfo()) -ceq [Convert]::ToBase64String($requestPublic.ExportSubjectPublicKeyInfo())) 'PendingPublicMatchesPinnedCsr'
 $prior=Get-Content -LiteralPath (Join-Path $resumeRoot 'YSEDU_EXISTING_KEY_002_RESULT.json') -Raw|ConvertFrom-Json
 Assert-Resume ($prior.Decision -ceq 'EXISTING_KEY_002_BLOCKED_STOP' -and $prior.FailedCheck -ceq 'LegacyCspRequired' -and $prior.DiagnosticState.ManagedKeyType -ceq 'RSACng') 'PreservedPreviousStop'
 $state.Check='CreateNewCapiOnlyAttempt'
 $marker=[Text.Encoding]::UTF8.GetBytes((([pscustomobject]@{Task='EXISTING_KEY_CAPI_ONLY_003';At=(Get-Date -Format o);NativeKeyCreation=$false;SingleAcquisitionAuthorized=$true;AcquireFlags=76})|ConvertTo-Json))
 $markerStream=[IO.File]::Open($attemptPath,[IO.FileMode]::CreateNew,[IO.FileAccess]::Write,[IO.FileShare]::None);$attemptConsumed=$true
 try{$markerStream.Write($marker,0,$marker.Length);$markerStream.Flush($true)}finally{$markerStream.Dispose()}
 $state.Phase='CapiOnlyNativeQualification';$state.Check='SingleCapiOnlyInvocation'
 $native=[DblYseduCapiOnly003]::Run($pendingCertificate.Handle,$requestPublic)
 Assert-Resume $native.Passed 'NativeQualificationResult'
 $state.Phase='FinalReadOnlyChecks';Assert-Resume ((Get-ResumeStores) -ceq $storeBefore) 'FiveStoresUnchangedDuringResume'
 Assert-Resume ((Get-Service -Name 'MSSQL$YSEDU').Status -eq 'Running' -and (Get-Service -Name SQLBrowser).Status -eq 'Stopped') 'ServiceBaselineUnchanged'
 foreach($pair in $pins.GetEnumerator()){$state.Check='FinalArtifactPin';Assert-Resume ((Get-FileHash -LiteralPath (Join-Path $resumeRoot $pair.Key) -Algorithm SHA256).Hash -ceq $pair.Value) 'FinalArtifactPin'}
 $state.Phase='NewEvidenceOnly';$state.Check='CreateNewResumeResult'
 $result=[pscustomobject]@{Decision='EXISTING_KEY_CAPI_ONLY_003_QUALIFIED';ObservedAt=(Get-Date -Format o);Host=$env:COMPUTERNAME;Elevated=$true;CSRFileSHA256=$pins['YSEDU-Leaf-CSP24-001.req'];PendingRequestThumbprint=$pendingCertificate.Thumbprint;NativeDiagnostics=$native;CapiOnly=$true;AcquireFlags=76;CngFallback=$false;Healing=$false;PrivateExportAttempted=$false;NativeKeyCreation=$false;PersistedKeyDeleted=$false;CertificateIssued=$false;CertificateAccepted=$false;CAUnlocked=$false;SqlStopped=$false;RegistryChanged=$false;ServiceChanged=$false;FirewallChanged=$false;AclChanged=$false;EWrites=$false;FiveStoreInventoriesUnchanged=$true;OriginalArtifactsUnchanged=$true;KeyDacl='NOT_TESTED';EffectiveSystemAccess='NOT_TESTED';SQL2014CertificateLoading='NOT_TESTED';SQLConnection=$false;FirstLiveData='NOT_TESTED';Pending='STOP; next separate step is bounded existing-CSR leaf signing/profile qualification, not service/network change'}

 # Evidence is emitted only after resource cleanup has succeeded.
}catch{
 $failure=[pscustomobject]@{Decision='EXISTING_KEY_CAPI_ONLY_003_BLOCKED_STOP';ObservedAt=(Get-Date -Format o);Phase=$state.Phase;FailedCheck=$(if($null -ne $native -and -not $native.Passed){$native.Check}else{$state.Check});NativeDiagnostics=$native;ExceptionType=$_.Exception.GetType().FullName;AttemptConsumed=$attemptConsumed;CapiOnly=$true;AcquireFlags=76;PrivateExportAttempted=$false;NativeKeyCreation=$false;CAUnlocked=$false;SqlStopped=$false;OriginalArtifactsChanged=$false;NoAutomaticRetry=$true;Reason='Safe check codes only; preserve original evidence and existing key; STOP before another acquisition or maintenance'}
}finally{
 $resources=@(
  @{Code='RequestPublicDispose';Resource=$requestPublic},
  @{Code='PendingPublicDispose';Resource=$pendingPublic}
 )
 foreach($certificate in $pending){$resources+=@{Code='PendingCertificateDispose';Resource=$certificate}}
 Close-YseduDiagnosticResources $state $resources
}
if($state.CleanupFailures.Count -gt 0 -and $null -eq $failure){
 $failure=[pscustomobject]@{Decision='EXISTING_KEY_CAPI_ONLY_003_BLOCKED_STOP';ObservedAt=(Get-Date -Format o);Phase='Cleanup';FailedCheck='ResourceDisposal';AttemptConsumed=$attemptConsumed;NativeDiagnostics=$native;CapiOnly=$true;AcquireFlags=76;NativeKeyCreation=$false;PrivateExportAttempted=$false;CAUnlocked=$false;SqlStopped=$false;NoAutomaticRetry=$true}
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
