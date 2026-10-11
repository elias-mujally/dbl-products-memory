[CmdletBinding()]
param([switch]$PublicOnly)
# Sign the one pinned existing public CSR with the one existing ephemeral-import CA only.
# No machine private-key opening, key creation, store write, leaf acceptance or SQL/network operation.
$ErrorActionPreference='Stop';Set-StrictMode -Version Latest
$root='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010'
$custody='E:\DBL-Lab-CA-YSEDU-001'
$phase='Identity';$check='ExactHostRuntime';$attempt=$false;$unlocked=$false;$signAttempted=$false;$signed=$false
$leaf=$null;$ca=$null;$imported=$null;$secure=$null;$password=$null;$bstr=[IntPtr]::Zero;$pfx=$null
$pending=@();$pendingPublic=$null;$csrPublic=$null;$result=$null;$failure=$null
$cleanup=[Collections.Generic.List[string]]::new()
$marker=Join-Path $root 'YSEDU_LEAF_SIGNING_001_ATTEMPT.json'
$output=Join-Path $root 'YSEDU_LEAF_SIGNING_001_RESULT.json'
$cerPath=Join-Path $root 'YSEDU-Leaf-Signed-001.cer'
$pemPath=Join-Path $root 'YSEDU-Leaf-Signed-001.pem'
$pins=@{
 'YseduLeafSigning001.cs'='2C024FBAC7312934CC9A10F0107E0E36FEBFD7D69B9E768E31F567E0D4A46139'
 'Read-YseduExistingCsr001.ps1'='13785BB0C686698FEBFB49C323D567E08C0C7E233616A3C8699BEA2FB871925A'
 'YSEDU-Leaf-CSP24-001.req'='61B48D26A1AFB37B27ACF0EFDFAA1D90A29B9A39B2F012E0DA7367046E19B889'
 'YSEDU_EXISTING_KEY_003_RESULT.json'='94B673461344785C58B1D96E366E5666B0D09D9C34DB6E6FF640EBBE8241D4DB'
 'YSEDU_EXISTING_KEY_003_ATTEMPT.json'='EC02A03387C9A585FEB29589B489112043374E68528755BA185953ED822ECCC0'
 'YSEDU_LEAF_MAINTENANCE_ORIGINAL.json'='BB3BF707DCEEDB99396BF2C598B3A0E9BF2E02E83F3FD7AE3A8DB27CF1931BD5'
 'CA_CUSTODY_CORRECTED_RESULT.json'='FD3FE8A9EC26E1D8305B3062352E53AAC345E8FAADEE6896BA5E3727DDED357C'
}
$custodyPins=@{
 'ca-public.cer'='A3FBC7905425B2E8C10F3A070B8713F876B94FC42B8D1243DEAD5D0F42889472'
 'ca-public.pem'='5CFE59F6CD9A090A62FC03ACECA6C1A2A2F8DB47569019890D59D7EA9C826D4F'
 'ca-signing-key.pfx'='7C8FD60E8997AEDDA3C445E900BD5C1F685D9929ABC89BF9E20818354A862E32'
 'OWNERSHIP.txt'='00691F280AEF17DA4F5C00839DFED194597713CDA4241F4FAF93C94EE64E4688'
}
function Assert-Sign([bool]$Condition,[string]$Code){$script:check=$Code;if(-not $Condition){throw "STOP: $Code"}}
function Assert-NoLinks([string]$Path){
 $entry=Get-Item -LiteralPath $Path -Force
 while($null -ne $entry){Assert-Sign (-not($entry.Attributes -band [IO.FileAttributes]::ReparsePoint)) 'NoReparseAncestors';$entry=if($entry -is [IO.DirectoryInfo]){$entry.Parent}else{$entry.Directory}}
}
function Write-SignNew([string]$Path,[byte[]]$Bytes){
 $stream=[IO.File]::Open($Path,[IO.FileMode]::CreateNew,[IO.FileAccess]::Write,[IO.FileShare]::None)
 try{$stream.Write($Bytes,0,$Bytes.Length);$stream.Flush($true)}finally{$stream.Dispose()}
}
function Assert-SignPins {
 foreach($p in $pins.GetEnumerator()){Assert-NoLinks (Join-Path $root $p.Key);Assert-Sign ((Get-FileHash -LiteralPath (Join-Path $root $p.Key) -Algorithm SHA256).Hash -ceq $p.Value) ('ArtifactPin_'+$p.Key.Replace('.','_'))}
 foreach($p in $custodyPins.GetEnumerator()){Assert-NoLinks (Join-Path $custody $p.Key);Assert-Sign ((Get-FileHash -LiteralPath (Join-Path $custody $p.Key) -Algorithm SHA256).Hash -ceq $p.Value) ('CustodyPin_'+$p.Key.Replace('.','_'))}
}
function Get-SignStoreFingerprint {
 $lines=[Collections.Generic.List[string]]::new()
 foreach($p in @('Cert:\CurrentUser\My','Cert:\CurrentUser\Root','Cert:\LocalMachine\My','Cert:\LocalMachine\Root','Cert:\LocalMachine\Request')){
  $certificates=@(Get-ChildItem -LiteralPath $p)
  try {foreach($c in $certificates){$lines.Add($p+'|'+$c.Thumbprint)}}finally{foreach($c in $certificates){$c.Dispose()}}
 }
 return [DblYseduLeafSigning001]::Hash([Text.Encoding]::UTF8.GetBytes((@($lines|Sort-Object)-join "`n")))
}
function Get-SignServices {return (@(Get-Service -Name 'MSSQL$YSEDU','SQLBrowser'|Sort-Object Name|ForEach-Object {$_.Name+'|'+$_.Status})-join ';')}
function Close-SignResource([object]$Resource,[string]$Code){if($null -ne $Resource){try{$Resource.Dispose()}catch{$cleanup.Add($Code)}}}
try {
 Assert-Sign ($env:COMPUTERNAME -ceq 'DESKTOP-8QRQT7R' -and $PSVersionTable.PSVersion.ToString() -ceq '7.6.5' -and [Runtime.InteropServices.RuntimeInformation]::FrameworkDescription -ceq '.NET 10.0.11') 'ExactHostRuntime'
 Assert-Sign ((Get-FileHash -LiteralPath "$PSHOME\pwsh.exe" -Algorithm SHA256).Hash -ceq '362A356CE7F0940EC74F73A8FC2C990A2CC24A38A11C90BBD8ECA947110AD139' -and [string](Get-AuthenticodeSignature -LiteralPath "$PSHOME\pwsh.exe").Status -ceq 'Valid') 'PinnedRuntime'
 Assert-NoLinks $root;Assert-NoLinks $custody
 Assert-Sign (@(Get-ChildItem -LiteralPath $custody -Force).Count -eq 4) 'ExistingCaCustodyNoUnexpectedArtifacts'
 foreach($p in @($marker,$output,$cerPath,$pemPath)){Assert-Sign (-not(Test-Path -LiteralPath $p)) 'FreshSigningAttemptNoOverwrite'}
 $phase='PreservedPins';Assert-SignPins
 $proof=Get-Content -LiteralPath (Join-Path $root 'YSEDU_EXISTING_KEY_003_RESULT.json') -Raw|ConvertFrom-Json
 Assert-Sign ($proof.Decision -ceq 'EXISTING_KEY_CAPI_ONLY_003_QUALIFIED' -and $proof.NativeDiagnostics.Passed -and $proof.NativeDiagnostics.ChallengePassed -and $proof.NativeDiagnostics.ProviderType -eq 24 -and $proof.NativeDiagnostics.KeySpec -eq 1 -and $proof.NativeDiagnostics.KeyBits -eq 2048 -and $proof.NativeDiagnostics.MachineFlags -eq 32 -and -not $proof.NativeDiagnostics.ExportAllowed -and -not $proof.NativeDiagnostics.ArchiveAllowed -and $proof.FiveStoreInventoriesUnchanged) 'QualifiedExistingKeyEvidence'
 $phase='PublicProfile';$check='CompileSigningSource'
 Add-Type -TypeDefinition (Get-Content -LiteralPath (Join-Path $root 'YseduLeafSigning001.cs') -Raw)
 . (Join-Path $root 'Read-YseduExistingCsr001.ps1')
 $text=Get-Content -LiteralPath (Join-Path $root 'YSEDU-Leaf-CSP24-001.req') -Raw
 Assert-Sign ($text -cmatch '\A\s*-----BEGIN (?:NEW )?CERTIFICATE REQUEST-----\s+([A-Za-z0-9+/=\s]+)-----END (?:NEW )?CERTIFICATE REQUEST-----\s*\z') 'ExactCsrPem'
 $der=[Convert]::FromBase64String($Matches[1]);$check='PinnedClosedWorldCsr';$csr=Read-YseduExistingCsr001 $der
 $check='LoadPublicCa';$ca=[Security.Cryptography.X509Certificates.X509CertificateLoader]::LoadCertificate([IO.File]::ReadAllBytes((Join-Path $custody 'ca-public.cer')))
 $check='PublicCaProfile';[DblYseduLeafSigning001]::ValidateCa($ca,[DateTimeOffset]::UtcNow)
 $check='ApprovedLeafPublicRequest';$approved=[DblYseduLeafSigning001]::ApprovedRequest($csr)
 Assert-Sign (-not $ca.HasPrivateKey) 'PublicCaOnlyAtPreflight'
 $phase='ReadOnlyStoreAndServiceBaseline';$check='FiveStoresReadOnly';$storeBefore=Get-SignStoreFingerprint
 $servicesBefore=Get-SignServices
 Assert-Sign ($servicesBefore -ceq 'MSSQL$YSEDU|Running;SQLBrowser|Stopped') 'UnchangedServiceBaseline'
 $pending=@(Get-ChildItem -LiteralPath 'Cert:\LocalMachine\Request')
 Assert-Sign ($pending.Count -eq 1 -and $pending[0].Thumbprint -ceq '079AF9D20802BD4A16B862928194A77BC14B93F4' -and $pending[0].Subject -ceq 'CN=DESKTOP-8QRQT7R' -and $pending[0].HasPrivateKey) 'ExistingPendingRequestIdentity'
 $pendingPublic=[Security.Cryptography.X509Certificates.RSACertificateExtensions]::GetRSAPublicKey($pending[0]);$csrPublic=$csr.PublicKey.GetRSAPublicKey()
 Assert-Sign ([Convert]::ToHexString($pendingPublic.ExportSubjectPublicKeyInfo()) -ceq [Convert]::ToHexString($csrPublic.ExportSubjectPublicKeyInfo())) 'PendingCsrPublicMatchWithoutPrivateAccess'
 if($PublicOnly){
  $result=[pscustomobject]@{Decision='YSEDU_LEAF_SIGNING_PUBLIC_PREFLIGHT_PASSED';ObservedAt=(Get-Date -Format o);ExistingCsrAndKeyProofPinned=$true;ExactPublicCa=$true;LeafValidityDays=180;ApprovedExtensionCount=$approved.CertificateExtensions.Count;PendingPublicMatches=$true;CAUnlocked=$false;ServerPrivateKeyOpened=$false;NativeKeyCreation=$false;CertificateIssued=$false;CertificateAccepted=$false;SqlStopped=$false;NetworkChanged=$false;ResultWritten=$false}
 }else{
  $phase='InteractiveSafety';Assert-Sign (-not [Console]::IsInputRedirected -and -not [Console]::IsOutputRedirected) 'InteractiveConsoleRequired'
  foreach($policy in @('HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription','HKCU:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription')){
   if(Test-Path -LiteralPath $policy){$v=Get-ItemProperty -LiteralPath $policy;Assert-Sign (-not($v.PSObject.Properties.Name -contains 'EnableTranscripting' -and $v.EnableTranscripting -eq 1)) 'NoAutomaticTranscription'}
  }
  Assert-Sign ((Read-Host 'Existing independent CA password is retained by you; type CA_STORED (do not enter archive/SQL password)') -ceq 'CA_STORED') 'OwnerCaCustodyConfirmed'
  $secure=Read-Host 'Enter EXISTING CA password (hidden; never paste into chat)' -AsSecureString
  Assert-Sign ($secure.Length -ge 24) 'ExistingCaPasswordMinimum'
  $phase='ConsumeOneSigningAttempt';$check='CreateNewAttempt'
  Write-SignNew $marker ([Text.Encoding]::UTF8.GetBytes((([pscustomobject]@{Task='EXISTING_YSEDU_CSR_SIGNING_001';At=(Get-Date -Format o);NativeKeyCreation=$false;NoAutomaticRetry=$true})|ConvertTo-Json)))
  $attempt=$true
  $phase='CaPasswordAndEphemeralImport';$check='CaPfxAuthenticationOrEphemeralImport'
  $bstr=[Runtime.InteropServices.Marshal]::SecureStringToBSTR($secure);$password=[Runtime.InteropServices.Marshal]::PtrToStringBSTR($bstr)
  Assert-Sign (-not $password.Contains([char]0)) 'PasswordUnsupportedNull'
  $pfx=[IO.File]::ReadAllBytes((Join-Path $custody 'ca-signing-key.pfx'))
  Assert-Sign ([DblYseduLeafSigning001]::Hash($pfx) -ceq $custodyPins['ca-signing-key.pfx']) 'PfxBytesPinnedBeforeImport'
  $limits=[Security.Cryptography.X509Certificates.Pkcs12LoaderLimits]::new();$limits.MaxKeys=1;$limits.MaxCertificates=1;$limits.IndividualKdfIterationLimit=250000;$limits.TotalKdfIterationLimit=1000000;$limits.MacIterationLimit=250000
  $check='CaPfxAuthenticationOrEphemeralImport'
  $imported=[Security.Cryptography.X509Certificates.X509CertificateLoader]::LoadPkcs12Collection($pfx,$password,[Security.Cryptography.X509Certificates.X509KeyStorageFlags]::EphemeralKeySet,$limits)
  Assert-Sign ($imported.Count -eq 1 -and $imported[0].HasPrivateKey -and $imported[0].Thumbprint -ceq [DblYseduLeafSigning001]::CaThumb) 'ExactExistingCaPrivateIdentity';$unlocked=$true
  # Discard password buffers before signing. Managed strings may leave residual memory; no erasure claim.
  [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($bstr);$bstr=[IntPtr]::Zero;$password=$null;$secure.Dispose();$secure=$null;[Array]::Clear($pfx);$pfx=$null
  $phase='SingleLeafSigningAndProfile';Assert-SignPins
  $now=[DateTimeOffset]::FromUnixTimeSeconds([DateTimeOffset]::UtcNow.ToUnixTimeSeconds())
  $check='SignAndProfileQualification';$signAttempted=$true
  $leaf=[DblYseduLeafSigning001]::Sign($csr,$imported[0],$now);$signed=$true
  $phase='PublicLeafPersistenceAndReRead';$check='CreateNewPublicLeafDer'
  Write-SignNew $cerPath $leaf.RawData
  $check='CreateNewPublicLeafPem';Write-SignNew $pemPath ([Text.Encoding]::ASCII.GetBytes($leaf.ExportCertificatePem()+"`n"))
  $check='PublicLeafReRead';$reread=[Security.Cryptography.X509Certificates.X509CertificateLoader]::LoadCertificate([IO.File]::ReadAllBytes($cerPath))
  try {
   Assert-Sign ([DblYseduLeafSigning001]::Hash($reread.RawData) -ceq [DblYseduLeafSigning001]::Hash($leaf.RawData)) 'PersistedLeafDerMatches'
   $check='ReReadProfileAndExclusiveChain';[DblYseduLeafSigning001]::ValidateLeaf($reread,$csr,$ca,$now.AddMinutes(-5),$now.AddMinutes(-5).AddDays(180),$now)
   $check='PublicPemReRead';$pemCert=[Security.Cryptography.X509Certificates.X509Certificate2]::CreateFromPem((Get-Content -LiteralPath $pemPath -Raw))
   try{Assert-Sign ([DblYseduLeafSigning001]::Hash($pemCert.RawData) -ceq [DblYseduLeafSigning001]::Hash($leaf.RawData)) 'PersistedLeafPemMatches'}finally{Close-SignResource $pemCert 'PemPublicCertificateDispose'}
  }finally{Close-SignResource $reread 'ReReadPublicCertificateDispose'}
  $phase='FinalReadOnlyComparison';Assert-SignPins
  Assert-Sign ((Get-SignStoreFingerprint) -ceq $storeBefore) 'FiveCertificateStoresUnchanged'
  Assert-Sign ((Get-SignServices) -ceq $servicesBefore) 'SqlAndBrowserServicesUnchanged'
  $result=[pscustomobject]@{Decision='YSEDU_EXISTING_CSR_LEAF_SIGNED_AND_PROFILE_QUALIFIED';ObservedAt=(Get-Date -Format o);Host=$env:COMPUTERNAME;Subject=$leaf.Subject;Issuer=$leaf.Issuer;LeafThumbprint=$leaf.Thumbprint;LeafSHA256=[DblYseduLeafSigning001]::Hash($leaf.RawData);LeafPemSHA256=(Get-FileHash -LiteralPath $pemPath -Algorithm SHA256).Hash;LeafSerial=$leaf.SerialNumber;NotBeforeUtc=$leaf.NotBefore.ToUniversalTime().ToString('o');NotAfterUtc=$leaf.NotAfter.ToUniversalTime().ToString('o');ValidityDays=180;SignatureAlgorithm=$leaf.SignatureAlgorithm.Value;RSAKeyBits=2048;CNandSAN='DESKTOP-8QRQT7R';EKU='1.3.6.1.5.5.7.3.1';KeyUsage='DigitalSignature, KeyEncipherment';BasicConstraints='critical CA=false';CsrPublicKeyMatches=$true;CsrFileSHA256=$pins['YSEDU-Leaf-CSP24-001.req'];CAThumbprint=$ca.Thumbprint;CAPublicSHA256=[DblYseduLeafSigning001]::CaHash;CAPfxSHA256=$custodyPins['ca-signing-key.pfx'];CaEphemeralImport=$true;ExclusiveOfflineChain='PASSED: exact leaf -> pinned CA; NoFlag; downloads disabled';Revocation='NOT_TESTED: offline lab has no CRL/OCSP';PublicArtifactsReReadEqual=$true;FiveCertificateStoresUnchanged=$true;ExistingArtifactsUnchanged=$true;NativeKeyCreation=$false;ServerPrivateKeyOpened=$false;PrivateKeyExported=$false;CertificateAccepted=$false;CAReissued=$false;SqlStopped=$false;ServiceChanged=$false;NetworkChanged=$false;AclChanged=$false;TrustStoreChanged=$false;EWrites=$false;LeafCerPath=$cerPath;LeafPemPath=$pemPath;SQL2014Loading='NOT_TESTED';SQLConnection=$false;FirstLiveData='NOT_TESTED';Pending='Prepare bounded certificate/network procedure only; do not accept/bind leaf or stop SQL from this helper';ResidualRisk='Ephemeral CA import and managed password memory not comprehensive erasure; owner accepted single-host custody exception'}
 }
}catch{
 $safeCode=$null;$err=$_.Exception
 # Only pinned code literals may be exposed; never publish arbitrary driver/PFX/password errors.
 $allowed=@('RequestSubject','RequestRsa','RequestRsa2048','LeafExtensionCount','LeafExtensionSet','LeafExtensionValue','CertificateSignatureAlgorithm','CertificateSignaturePadding','CertificateSignatureMismatch','ExactCaIdentity','CaSubjectIssuer','CaValidity','CaRsa','CaRsa3072','CaConstraints','CaUsage','CaPurpose','PublicLeafOnly','LeafSubject','LeafIssuer','LeafCsrPublicMatch','LeafValidity180Days','LeafWithinCaValidity','LeafSha256Rsa','ExclusiveCaOfflineChain','ExactTwoCertificateChain','CaPrivateKeyRequired','CaEphemeralOnly','LeafValidityWithinIssuer')
 while($null -ne $err){if($err.Message -cin $allowed){$safeCode=$err.Message;break};$err=$err.InnerException}
 $failure=[pscustomobject]@{Decision='YSEDU_LEAF_SIGNING_BLOCKED_STOP';ObservedAt=(Get-Date -Format o);Phase=$phase;FailedCheck=$check;SafeNativeCode=$safeCode;ExceptionType=$_.Exception.GetType().FullName;AttemptConsumed=$attempt;CAUnlocked=$unlocked;SigningAttempted=$signAttempted;PublicLeafQualified=$signed;NativeKeyCreation=$false;CertificateAccepted=$false;SqlStopped=$false;NetworkChanged=$false;NoAutomaticRetry=$true;Reason='Bounded signing gate failed; preserve artifacts. No raw exception, password or private material publication.'}
}finally{
 Close-SignResource $leaf 'LeafDispose';Close-SignResource $ca 'CaPublicDispose'
 if($null -ne $imported){foreach($c in $imported){Close-SignResource $c 'CaEphemeralCertificateDispose'}}
 Close-SignResource $pendingPublic 'PendingPublicDispose';Close-SignResource $csrPublic 'CsrPublicDispose'
 foreach($c in $pending){Close-SignResource $c 'PendingCertificateDispose'}
 if($bstr -ne [IntPtr]::Zero){try{[Runtime.InteropServices.Marshal]::ZeroFreeBSTR($bstr)}catch{$cleanup.Add('SecretBstrClear')}}
 Close-SignResource $secure 'SecurePasswordDispose';$password=$null
 if($null -ne $pfx){[Array]::Clear($pfx)}
 $Error.Clear()
}
if($cleanup.Count -gt 0 -and $null -eq $failure){$failure=[pscustomobject]@{Decision='YSEDU_LEAF_SIGNING_BLOCKED_STOP';ObservedAt=(Get-Date -Format o);Phase='Cleanup';FailedCheck='ResourceDisposal';AttemptConsumed=$attempt;SigningAttempted=$signAttempted;NativeKeyCreation=$false;CertificateAccepted=$false;SqlStopped=$false;NoAutomaticRetry=$true}}
$final=if($null -ne $failure){$failure}else{$result}
$final|Add-Member -NotePropertyName CleanupFailures -NotePropertyValue @($cleanup.ToArray())
if(-not $PublicOnly -and $attempt){try{Write-SignNew $output ([Text.Encoding]::UTF8.GetBytes(($final|ConvertTo-Json -Depth 8)))}catch{$final|ConvertTo-Json -Depth 8;[pscustomobject]@{Decision='SIGNING_RESULT_PERSISTENCE_BLOCKED_STOP';FailedCheck='CreateNewEvidence';NoAutomaticRetry=$true}|ConvertTo-Json;return}}
$final|ConvertTo-Json -Depth 8
