[CmdletBinding()]
param([switch]$PreflightOnly)
# OWNER-APPROVED single-host laboratory exception. One CA only; no SQL/leaf/service changes.
# The only retained private material is encrypted PFX on E:. Never add the CA to a store.
$ErrorActionPreference='Stop'
Set-StrictMode -Version Latest
$caPhase='Preflight'
$caRoot='E:\DBL-Lab-CA-YSEDU-001'
$caEvidence='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010\CA_CUSTODY_RESULT.json'
$caRuntimeHash='362A356CE7F0940EC74F73A8FC2C990A2CC24A38A11C90BBD8ECA947110AD139'
$caKey=$null;$caRsa=$null;$caCert=$null;$caLoaded=$null;$caLoadedRsa=$null;$caPublicRsa=$null
$caSecure1=$null;$caSecure2=$null;$caBstr1=[IntPtr]::Zero;$caBstr2=[IntPtr]::Zero
$caPassword=$null;$caConfirm=$null;$caPfxBytes=$null;$caReRead=$null;$caResult=$null
$caCreated=$false;$caPfxWritten=$false
function Write-CaNewFile([string]$Path,[byte[]]$Bytes) {
    $stream=[IO.File]::Open($Path,[IO.FileMode]::CreateNew,[IO.FileAccess]::Write,[IO.FileShare]::None)
    try {$stream.Write($Bytes,0,$Bytes.Length);$stream.Flush($true)} finally {$stream.Dispose()}
}
function Get-CaStoreFingerprint {
    $thumbprints=@(foreach($p in @('Cert:\CurrentUser\My','Cert:\CurrentUser\Root','Cert:\LocalMachine\My','Cert:\LocalMachine\Root')) {
        foreach($c in @(Get-ChildItem -LiteralPath $p -ErrorAction Stop)) { $p+'|'+$c.Thumbprint }
    })
    $text=(@($thumbprints|Sort-Object) -join "`n")
    [Convert]::ToHexString([Security.Cryptography.SHA256]::HashData([Text.Encoding]::UTF8.GetBytes($text)))
}
function Assert-CaPbeAlgorithm([System.Formats.Asn1.AsnReader]$alg,[int]$CipherLength) {
    if($alg.ReadObjectIdentifier() -cne '1.2.840.113549.1.5.13'){throw 'STOP: PBES2 required'}
    $pbes=$alg.ReadSequence($null);$kdf=$pbes.ReadSequence($null)
    if($kdf.ReadObjectIdentifier() -cne '1.2.840.113549.1.5.12'){throw 'STOP: PBKDF2 required'}
    $kp=$kdf.ReadSequence($null);$salt=$kp.ReadOctetString($null);$iterations=$kp.ReadInteger($null)
    if($salt.Length -lt 16 -or $iterations -ne 200000){throw 'STOP: KDF parameters mismatch'}
    if($kp.PeekTag().TagValue -eq 2){if($kp.ReadInteger($null) -ne 32){throw 'STOP: AES256 key length mismatch'}}
    $prf=$kp.ReadSequence($null)
    if($prf.ReadObjectIdentifier() -cne '1.2.840.113549.2.9'){throw 'STOP: HMAC-SHA256 required'}
    if($prf.HasData){$prf.ReadNull($null)}
    $enc=$pbes.ReadSequence($null)
    if($enc.ReadObjectIdentifier() -cne '2.16.840.1.101.3.4.1.42'){throw 'STOP: AES256-CBC required'}
    $iv=$enc.ReadOctetString($null)
    if($iv.Length -ne 16 -or $CipherLength -eq 0 -or $CipherLength % 16 -ne 0){throw 'STOP: encrypted payload mismatch'}
    foreach($r in @($alg,$pbes,$kdf,$kp,$prf,$enc)){if($r.HasData){throw 'STOP: unexpected PBE field'}}
}
function Assert-CaPbe([ReadOnlyMemory[byte]]$EncryptedInfo) {
    $a=[System.Formats.Asn1.AsnReader]::new($EncryptedInfo,[System.Formats.Asn1.AsnEncodingRules]::BER)
    $s=$a.ReadSequence($null);$alg=$s.ReadSequence($null);$cipher=$s.ReadOctetString($null)
    Assert-CaPbeAlgorithm $alg $cipher.Length
    if($a.HasData -or $s.HasData){throw 'STOP: trailing encrypted key data'}
}
function Assert-CaPfx([byte[]]$Bytes,[string]$Password) {
    $bytesRead=0
    $info=[Security.Cryptography.Pkcs.Pkcs12Info]::Decode([ReadOnlyMemory[byte]]::new($Bytes),[ref]$bytesRead,$false)
    if($bytesRead -ne $Bytes.Length -or $info.IntegrityMode -ne [Security.Cryptography.Pkcs.Pkcs12IntegrityMode]::Password -or -not $info.VerifyMac($Password)){throw 'STOP: PFX integrity failed'}
    $wrong=[Convert]::ToHexString([Security.Cryptography.RandomNumberGenerator]::GetBytes(32))
    if($info.VerifyMac($wrong)){throw 'STOP: wrong password accepted'}
    $outer=[System.Formats.Asn1.AsnReader]::new([ReadOnlyMemory[byte]]::new($Bytes),[System.Formats.Asn1.AsnEncodingRules]::BER)
    $pfx=$outer.ReadSequence($null)
    if($pfx.ReadInteger($null) -ne 3){throw 'STOP: PFX version'}
    $auth=$pfx.ReadSequence($null)
    if($auth.ReadObjectIdentifier() -cne '1.2.840.113549.1.7.1'){throw 'STOP: PFX authsafe format'}
    $tag=[System.Formats.Asn1.Asn1Tag]::new([System.Formats.Asn1.TagClass]::ContextSpecific,0,$true)
    $content=$auth.ReadSequence($tag);$authBytes=$content.ReadOctetString($null)
    $mac=$pfx.ReadSequence($null);$digestInfo=$mac.ReadSequence($null);$digestAlg=$digestInfo.ReadSequence($null)
    if($digestAlg.ReadObjectIdentifier() -cne '2.16.840.1.101.3.4.2.1'){throw 'STOP: MAC SHA256 required'}
    if($digestAlg.HasData){$digestAlg.ReadNull($null)}
    if($digestInfo.ReadOctetString($null).Length -ne 32 -or $mac.ReadOctetString($null).Length -lt 16 -or $mac.ReadInteger($null) -ne 200000){throw 'STOP: MAC parameters mismatch'}
    foreach($r in @($outer,$pfx,$auth,$content,$mac,$digestInfo,$digestAlg)){if($r.HasData){throw 'STOP: trailing PFX field'}}
    # Read the authsafe to verify encryption parameters on certificate safes as well as the key bag.
    $sa=[System.Formats.Asn1.AsnReader]::new([ReadOnlyMemory[byte]]::new($authBytes),[System.Formats.Asn1.AsnEncodingRules]::BER)
    $safeSequence=$sa.ReadSequence($null);$encryptedSafes=0
    while($safeSequence.HasData){
        $ci=$safeSequence.ReadSequence($null);$oid=$ci.ReadObjectIdentifier()
        if($oid -ceq '1.2.840.113549.1.7.6'){
            $edwrap=$ci.ReadSequence($tag);$ed=$edwrap.ReadSequence($null)
            if($ed.ReadInteger($null) -ne 0){throw 'STOP: EncryptedData version'}
            $eci=$ed.ReadSequence($null)
            if($eci.ReadObjectIdentifier() -cne '1.2.840.113549.1.7.1'){throw 'STOP: encrypted safe type'}
            $safeAlgorithm=$eci.ReadSequence($null)
            $cipherEncoded=$eci.ReadOctetString([System.Formats.Asn1.Asn1Tag]::new([System.Formats.Asn1.TagClass]::ContextSpecific,0))
            Assert-CaPbeAlgorithm $safeAlgorithm $cipherEncoded.Length
            foreach($r in @($ci,$edwrap,$ed,$eci)){if($r.HasData){throw 'STOP: unexpected encrypted safe field'}}
            $encryptedSafes++
        } elseif($oid -ceq '1.2.840.113549.1.7.1'){
            $data=$ci.ReadSequence($tag);[void]$data.ReadOctetString($null)
            if($data.HasData -or $ci.HasData){throw 'STOP: unexpected data safe field'}
        } else {throw 'STOP: unexpected safe type'}
    }
    if($sa.HasData -or $encryptedSafes -ne 1){throw 'STOP: encrypted certificate safe mismatch'}
    $keys=0;$certs=0
    foreach($safe in $info.AuthenticatedSafe){
        if($safe.ConfidentialityMode -eq [Security.Cryptography.Pkcs.Pkcs12ConfidentialityMode]::Password){$safe.Decrypt($Password)}
        elseif($safe.ConfidentialityMode -ne [Security.Cryptography.Pkcs.Pkcs12ConfidentialityMode]::None){throw 'STOP: unsupported safe confidentiality'}
        foreach($bag in $safe.GetBags()){
            if($bag -is [Security.Cryptography.Pkcs.Pkcs12ShroudedKeyBag]){Assert-CaPbe $bag.EncryptedPkcs8PrivateKey;$keys++}
            elseif($bag -is [Security.Cryptography.Pkcs.Pkcs12CertBag]){$certs++}
            else {throw 'STOP: unencrypted private key or unknown bag'}
        }
    }
    if($keys -ne 1 -or $certs -ne 1){throw 'STOP: single CA key/certificate required'}
}
try {
    if($env:COMPUTERNAME -cne 'DESKTOP-8QRQT7R' -or $PSVersionTable.PSVersion.ToString() -cne '7.6.5' -or [Runtime.InteropServices.RuntimeInformation]::FrameworkDescription -cne '.NET 10.0.11'){throw 'STOP: exact host/runtime required'}
    if((Get-FileHash -LiteralPath "$PSHOME\pwsh.exe" -Algorithm SHA256).Hash -cne $caRuntimeHash){throw 'STOP: runtime hash mismatch'}
    if((Get-AuthenticodeSignature -LiteralPath "$PSHOME\pwsh.exe").Status -ne 'Valid'){throw 'STOP: runtime signature'}
    foreach($policy in @('HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription','HKCU:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription')){
        if(Test-Path -LiteralPath $policy){$pv=Get-ItemProperty -LiteralPath $policy;if($pv.PSObject.Properties.Name -contains 'EnableTranscripting' -and $pv.EnableTranscripting -eq 1){throw 'STOP: automatic transcription enabled'}}
    }
    Add-Type -AssemblyName System.Security.Cryptography.Pkcs
    if(-not [Security.Cryptography.X509Certificates.X509Certificate2].GetMethods().Where({$_.Name -eq 'ExportPkcs12' -and $_.GetParameters()[0].ParameterType -eq [Security.Cryptography.PbeParameters]}) -or -not [Security.Cryptography.X509Certificates.X509CertificateLoader].GetMethods().Where({$_.Name -eq 'LoadPkcs12Collection'})){throw 'STOP: encrypted PFX API missing'}
    $v=Get-Volume -DriveLetter E
    $ep=Get-Partition -DriveLetter E;$cp=Get-Partition -DriveLetter C;$dp=Get-Partition -DriveLetter D
    $disk=Get-Disk -Number $ep.DiskNumber
    if($v.FileSystem -cne 'exFAT' -or $v.HealthStatus -ne 'Healthy' -or $v.SizeRemaining -lt 10485760 -or $ep.DiskNumber -eq $cp.DiskNumber -or $ep.DiskNumber -eq $dp.DiskNumber -or $disk.BusType -ne 'USB' -or $disk.IsOffline -or $disk.IsReadOnly){throw 'STOP: E custody destination changed'}
    if((Get-Item -LiteralPath 'E:\').Attributes -band [IO.FileAttributes]::ReparsePoint -or (Test-Path -LiteralPath $caRoot) -or (Test-Path -LiteralPath $caEvidence)){throw 'STOP: fresh custody directory/evidence required'}
    $caStoreBefore=Get-CaStoreFingerprint
    if($PreflightOnly){
        [pscustomobject]@{Decision='CA_CUSTODY_API_PREFLIGHT_PASSED';ObservedAt=(Get-Date -Format o);Runtime=$PSVersionTable.PSVersion.ToString();Framework=[Runtime.InteropServices.RuntimeInformation]::FrameworkDescription;RuntimeSHA256=$caRuntimeHash;EphemeralCreate='CngKey.Create(RSA,null,explicit-parameters)';EncryptedExport='PbeParameters AES256 SHA256 200000';EphemeralLoad='EphemeralKeySet only';ExternalDestinationIndependent=$true;KeyCreated=$false;EWrites=$false;SqlChanged=$false}|ConvertTo-Json
        return
    }
    if([Console]::IsInputRedirected -or [Console]::IsOutputRedirected){throw 'STOP: interactive console required'}
    $caPhase='OwnerSecretEntry'
    if((Read-Host 'New independent CA password is saved outside this host and E:; type CA_STORED to confirm') -cne 'CA_STORED'){throw 'STOP: independent secret custody not confirmed'}
    $caSecure1=Read-Host 'Enter NEW CA-key password (not archive or SQL)' -AsSecureString
    $caSecure2=Read-Host 'Confirm NEW CA-key password' -AsSecureString
    if($caSecure1.Length -lt 24 -or $caSecure2.Length -lt 24){throw 'STOP: strong random password minimum 24 characters'}
    $caBstr1=[Runtime.InteropServices.Marshal]::SecureStringToBSTR($caSecure1);$caBstr2=[Runtime.InteropServices.Marshal]::SecureStringToBSTR($caSecure2)
    $caPassword=[Runtime.InteropServices.Marshal]::PtrToStringBSTR($caBstr1);$caConfirm=[Runtime.InteropServices.Marshal]::PtrToStringBSTR($caBstr2)
    if(-not [string]::Equals($caPassword,$caConfirm,[StringComparison]::Ordinal) -or $caPassword.Contains([char]0)){throw 'STOP: password mismatch/unsupported character'}
    $caPhase='EphemeralCaIssuance'
    [void][IO.Directory]::CreateDirectory($caRoot);$caCreated=$true
    Write-CaNewFile "$caRoot\OWNERSHIP.txt" ([Text.Encoding]::UTF8.GetBytes('DBL LAB ONLY YSEDU CA CUSTODY 001; owner-approved single-host exception 2026-10-10'))
    $params=[Security.Cryptography.CngKeyCreationParameters]::new()
    $params.Provider=[Security.Cryptography.CngProvider]::MicrosoftSoftwareKeyStorageProvider
    $params.KeyUsage=[Security.Cryptography.CngKeyUsages]::Signing
    $params.ExportPolicy=[Security.Cryptography.CngExportPolicies]::AllowExport -bor [Security.Cryptography.CngExportPolicies]::AllowPlaintextExport
    $params.Parameters.Add([Security.Cryptography.CngProperty]::new('Length',[BitConverter]::GetBytes([int]3072),[Security.Cryptography.CngPropertyOptions]::None))
    $caKey=[Security.Cryptography.CngKey]::Create([Security.Cryptography.CngAlgorithm]::Rsa,$null,$params)
    if(-not $caKey.IsEphemeral -or $null -ne $caKey.KeyName){throw 'STOP: key is not ephemeral'}
    $caRsa=[Security.Cryptography.RSACng]::new($caKey)
    if($caRsa.KeySize -ne 3072){throw 'STOP: RSA3072 required'}
    $req=[Security.Cryptography.X509Certificates.CertificateRequest]::new('CN=DBL Laboratory YSEDU CA 001 - 20261010',$caRsa,[Security.Cryptography.HashAlgorithmName]::SHA256,[Security.Cryptography.RSASignaturePadding]::Pkcs1)
    $req.CertificateExtensions.Add([Security.Cryptography.X509Certificates.X509BasicConstraintsExtension]::new($true,$true,0,$true))
    $usage=[Security.Cryptography.X509Certificates.X509KeyUsageFlags]::KeyCertSign -bor [Security.Cryptography.X509Certificates.X509KeyUsageFlags]::CrlSign
    $req.CertificateExtensions.Add([Security.Cryptography.X509Certificates.X509KeyUsageExtension]::new($usage,$true))
    $req.CertificateExtensions.Add([Security.Cryptography.X509Certificates.X509SubjectKeyIdentifierExtension]::new($req.PublicKey,$false))
    $now=[DateTimeOffset]::UtcNow;$caCert=$req.CreateSelfSigned($now.AddMinutes(-5),$now.AddYears(2))
    $pbe=[Security.Cryptography.PbeParameters]::new([Security.Cryptography.PbeEncryptionAlgorithm]::Aes256Cbc,[Security.Cryptography.HashAlgorithmName]::SHA256,200000)
    $caPhase='EncryptedPfxQualification'
    $caPfxBytes=$caCert.ExportPkcs12($pbe,$caPassword)
    Assert-CaPfx $caPfxBytes $caPassword
    $caPhase='EncryptedRetentionAndReRead'
    Write-CaNewFile "$caRoot\ca-signing-key.pfx" $caPfxBytes;$caPfxWritten=$true
    $caReRead=[IO.File]::ReadAllBytes("$caRoot\ca-signing-key.pfx")
    $pfxHash=[Convert]::ToHexString([Security.Cryptography.SHA256]::HashData($caPfxBytes))
    if([Convert]::ToHexString([Security.Cryptography.SHA256]::HashData($caReRead)) -cne $pfxHash){throw 'STOP: external PFX reread mismatch'}
    Assert-CaPfx $caReRead $caPassword
    $caPhase='IsolatedEphemeralImport'
    $limits=[Security.Cryptography.X509Certificates.Pkcs12LoaderLimits]::new();$limits.MaxKeys=1;$limits.MaxCertificates=1
    $limits.IndividualKdfIterationLimit=250000;$limits.TotalKdfIterationLimit=1000000;$limits.MacIterationLimit=250000
    $caLoaded=[Security.Cryptography.X509Certificates.X509CertificateLoader]::LoadPkcs12Collection($caReRead,$caPassword,[Security.Cryptography.X509Certificates.X509KeyStorageFlags]::EphemeralKeySet,$limits)
    if($caLoaded.Count -ne 1 -or -not $caLoaded[0].HasPrivateKey -or $caLoaded[0].Thumbprint -cne $caCert.Thumbprint){throw 'STOP: isolated CA identity mismatch'}
    $caLoadedRsa=[Security.Cryptography.X509Certificates.RSACertificateExtensions]::GetRSAPrivateKey($caLoaded[0])
    if($caLoadedRsa -isnot [Security.Cryptography.RSACng] -or -not $caLoadedRsa.Key.IsEphemeral -or $null -ne $caLoadedRsa.Key.KeyName){throw 'STOP: loaded key persistence'}
    $caPublicRsa=[Security.Cryptography.X509Certificates.RSACertificateExtensions]::GetRSAPublicKey($caCert)
    $challenge=[Security.Cryptography.RandomNumberGenerator]::GetBytes(32)
    $signature=$caLoadedRsa.SignData($challenge,[Security.Cryptography.HashAlgorithmName]::SHA256,[Security.Cryptography.RSASignaturePadding]::Pkcs1)
    if(-not $caPublicRsa.VerifyData($challenge,$signature,[Security.Cryptography.HashAlgorithmName]::SHA256,[Security.Cryptography.RSASignaturePadding]::Pkcs1)){throw 'STOP: private key roundtrip failed'}
    $caPhase='PublicArtifactsAndStoreComparison'
    Write-CaNewFile "$caRoot\ca-public.cer" $caCert.RawData
    Write-CaNewFile "$caRoot\ca-public.pem" ([Text.Encoding]::ASCII.GetBytes($caCert.ExportCertificatePem()+"`n"))
    $caStoreAfter=Get-CaStoreFingerprint
    if($caStoreAfter -cne $caStoreBefore){throw 'STOP: certificate store drift'}
    $caResult=[pscustomobject]@{Decision='CA_ENCRYPTED_CUSTODY_AND_EPHEMERAL_REIMPORT_PASSED';ObservedAt=(Get-Date -Format o);Host=$env:COMPUTERNAME;Subject=$caCert.Subject;Thumbprint=$caCert.Thumbprint;PublicCertificateSHA256=[Convert]::ToHexString([Security.Cryptography.SHA256]::HashData($caCert.RawData));SerialNumber=$caCert.SerialNumber;NotBeforeUtc=$caCert.NotBefore.ToUniversalTime().ToString('o');NotAfterUtc=$caCert.NotAfter.ToUniversalTime().ToString('o');RSAKeyBits=3072;CaPathLength=0;PfxSHA256=$pfxHash;PfxBytes=$caReRead.Length;PBE='PBES2 AES256-CBC / PBKDF2 HMAC-SHA256 / 200000';Mac='SHA256 / 200000';WrongPasswordMacRejected=$true;PrivateBagEncrypted=$true;ExternalReReadEqual=$true;EphemeralCreateVerified=$true;EphemeralReimportVerified=$true;PrivateKeyChallengePassed=$true;FourCertificateStoreFingerprintsUnchanged=$true;IndependentPasswordCustody='OWNER_INTERACTIVE_ATTESTATION';PrivateKeyPersistedInStore=$false;PlainPrivateKeyWritten=$false;LeafIssued=$false;SqlChanged=$false;BrowserChanged=$false;WindowsTrustChanged=$false;FirstLiveData='NOT_TESTED';Pending='Keep E attached until separately qualified leaf signing; no SQL stop in this helper';ResidualRisk='Owner accepted single host and one encrypted E copy; no comprehensive memory erasure claim'}
} catch {
    $caResult=[pscustomobject]@{Decision='CA_CUSTODY_BLOCKED_STOP';ObservedAt=(Get-Date -Format o);Phase=$caPhase;ExceptionType=$_.Exception.GetType().FullName;InnerExceptionType=if($null -ne $_.Exception.InnerException){$_.Exception.InnerException.GetType().FullName}else{$null};CustodyDirectoryCreated=$caCreated;EncryptedPfxWritten=$caPfxWritten;SqlChanged=$false;BrowserChanged=$false;LeafIssued=$false;NoAutomaticRetry=$true;Reason='Bounded step failed; raw exception/secret material deliberately omitted. Retain artifacts; no SQL interruption.'}
} finally {
    if($null -ne $caPublicRsa){$caPublicRsa.Dispose()};if($null -ne $caLoadedRsa){$caLoadedRsa.Dispose()}
    if($null -ne $caLoaded){foreach($c in $caLoaded){$c.Dispose()}}
    if($null -ne $caCert){$caCert.Dispose()};if($null -ne $caRsa){$caRsa.Dispose()};if($null -ne $caKey){$caKey.Dispose()}
    if($caBstr2 -ne [IntPtr]::Zero){[Runtime.InteropServices.Marshal]::ZeroFreeBSTR($caBstr2)}
    if($caBstr1 -ne [IntPtr]::Zero){[Runtime.InteropServices.Marshal]::ZeroFreeBSTR($caBstr1)}
    if($null -ne $caSecure2){$caSecure2.Dispose()};if($null -ne $caSecure1){$caSecure1.Dispose()}
    $caPassword=$null;$caConfirm=$null
    if($null -ne $caPfxBytes){[Array]::Clear($caPfxBytes)};if($null -ne $caReRead){[Array]::Clear($caReRead)}
    $Error.Clear()
}
if($null -ne $caResult){
    $json=$caResult|ConvertTo-Json -Depth 5
    if(-not (Test-Path -LiteralPath $caEvidence)){Write-CaNewFile $caEvidence ([Text.Encoding]::UTF8.GetBytes($json+"`n"))}
    $json
}
# STOP for failed gate. Successful custody is not leaf/SQL/live qualification.
