$ErrorActionPreference='Stop';Set-StrictMode -Version Latest
$root=$PSScriptRoot
if((Get-FileHash -LiteralPath "$root\YseduLeafSigning001.cs" -Algorithm SHA256).Hash -cne '2C024FBAC7312934CC9A10F0107E0E36FEBFD7D69B9E768E31F567E0D4A46139'){throw 'Source pin'}
if((Get-FileHash -LiteralPath "$root\Read-YseduExistingCsr001.ps1" -Algorithm SHA256).Hash -cne '13785BB0C686698FEBFB49C323D567E08C0C7E233616A3C8699BEA2FB871925A'){throw 'CSR reader pin'}
Add-Type -TypeDefinition (Get-Content -LiteralPath "$root\YseduLeafSigning001.cs" -Raw)
. "$root\Read-YseduExistingCsr001.ps1"
$text=Get-Content -LiteralPath "$root\YSEDU-Leaf-CSP24-001.req" -Raw
if($text -cnotmatch '\A\s*-----BEGIN (?:NEW )?CERTIFICATE REQUEST-----\s+([A-Za-z0-9+/=\s]+)-----END (?:NEW )?CERTIFICATE REQUEST-----\s*\z'){throw 'CSR PEM'}
$csr=Read-YseduExistingCsr001 ([Convert]::FromBase64String($Matches[1]))
$ca=[Security.Cryptography.X509Certificates.X509CertificateLoader]::LoadCertificate([IO.File]::ReadAllBytes('E:\DBL-Lab-CA-YSEDU-001\ca-public.cer'))
$public=$null;$tampered=$null;$checks=[Collections.Generic.List[string]]::new()
function Pass([string]$Name,[bool]$Passed){if(-not $Passed){throw "Test rejected: $Name"};$checks.Add($Name)}
function Reject([string]$Name,[string]$Code,[scriptblock]$Action){
 $caught=$false
 try{& $Action}catch{$e=$_.Exception;while($null -ne $e){if($e.Message -ceq $Code){$caught=$true;break};$e=$e.InnerException}}
 Pass $Name $caught
}
try{
 [DblYseduLeafSigning001]::ValidateCa($ca,[DateTimeOffset]::UtcNow);Pass 'ExactExistingPublicCa' (-not $ca.HasPrivateKey)
 $r=[DblYseduLeafSigning001]::ApprovedRequest($csr)
 $expected=@{'2.5.29.15'='030205A0';'2.5.29.17'='3011820F4445534B544F502D38515251543752';'2.5.29.19'='3000';'2.5.29.37'='300A06082B06010505070301'}
 Pass 'FourApprovedExtensionsOnly' ($r.CertificateExtensions.Count -eq 4)
 foreach($x in $r.CertificateExtensions){Pass ('IndependentRawProfile_'+$x.Oid.Value) ([Convert]::ToHexString($x.RawData) -ceq $expected[$x.Oid.Value])}
 Pass 'ApprovedRequestUsesExistingPublicKey' ([Convert]::ToHexString($r.PublicKey.ExportSubjectPublicKeyInfo()) -ceq [Convert]::ToHexString($csr.PublicKey.ExportSubjectPublicKeyInfo()))
 $wrong=[Security.Cryptography.X509Certificates.CertificateRequest]::new([Security.Cryptography.X509Certificates.X500DistinguishedName]::new('CN=WRONG'),$csr.PublicKey,[Security.Cryptography.HashAlgorithmName]::SHA256,[Security.Cryptography.RSASignaturePadding]::Pkcs1)
 Reject 'WrongSubjectRejected' 'RequestSubject' {[void][DblYseduLeafSigning001]::ApprovedRequest($wrong)}
 $bad=[DblYseduLeafSigning001]::ApprovedRequest($csr);$bad.CertificateExtensions.RemoveAt(0)
 Reject 'MissingUsageRejected' 'LeafExtensionCount' {[DblYseduLeafSigning001]::ValidateExtensions($bad.CertificateExtensions)}
 $bad=[DblYseduLeafSigning001]::ApprovedRequest($csr);$bad.CertificateExtensions.Add($bad.CertificateExtensions[0])
 Reject 'DuplicateExtensionRejected' 'LeafExtensionSet' {[DblYseduLeafSigning001]::ValidateExtensions($bad.CertificateExtensions)}
 $bad=[DblYseduLeafSigning001]::ApprovedRequest($csr);$bad.CertificateExtensions[0]=[Security.Cryptography.X509Certificates.X509Extension]::new('2.5.29.15',[Convert]::FromHexString('030205A0'),$false)
 Reject 'UsageCriticalityRejected' 'LeafExtensionValue' {[DblYseduLeafSigning001]::ValidateExtensions($bad.CertificateExtensions)}
 $bad=[DblYseduLeafSigning001]::ApprovedRequest($csr);$bad.CertificateExtensions[1]=[Security.Cryptography.X509Certificates.X509Extension]::new('2.5.29.17',[Convert]::FromHexString('3003820141'),$false)
 Reject 'WrongSanRejected' 'LeafExtensionValue' {[DblYseduLeafSigning001]::ValidateExtensions($bad.CertificateExtensions)}
 $bad=[DblYseduLeafSigning001]::ApprovedRequest($csr);$bad.CertificateExtensions[3]=[Security.Cryptography.X509Certificates.X509Extension]::new('1.2.840.113549.1.9.15',[byte[]]@(48,0),$false)
 Reject 'SmimeForwardingRejected' 'LeafExtensionSet' {[DblYseduLeafSigning001]::ValidateExtensions($bad.CertificateExtensions)}
 Reject 'ExpiredCaRejected' 'CaValidity' {[DblYseduLeafSigning001]::ValidateCa($ca,[DateTimeOffset]::new([datetime]'2030-01-01T00:00:00Z'))}
 Reject 'PublicCaCannotSign' 'CaPrivateKeyRequired' {[void][DblYseduLeafSigning001]::Sign($csr,$ca,[DateTimeOffset]::UtcNow)}
 $bytes=$ca.RawData.Clone();$bytes[$bytes.Length-1]=$bytes[$bytes.Length-1] -bxor 1
 $tampered=[Security.Cryptography.X509Certificates.X509CertificateLoader]::LoadCertificate($bytes)
 Reject 'ChangedCaBytesRejected' 'ExactCaIdentity' {[DblYseduLeafSigning001]::ValidateCa($tampered,[DateTimeOffset]::UtcNow)}
 $public=[Security.Cryptography.X509Certificates.RSACertificateExtensions]::GetRSAPublicKey($ca)
 Reject 'TamperedSignatureRejected' 'CertificateSignatureMismatch' {[DblYseduLeafSigning001]::VerifySignature($tampered,$public)}
 $source=Get-Content -LiteralPath "$root\YseduLeafSigning001.cs" -Raw
 Pass 'NoKeyCreationExportStoreOrNativeAcquireAPIs' ($source -notmatch 'RSA\.Create|CngKey\.Create|CreateSelfSigned|ExportPkcs|CopyWithPrivateKey|CryptAcquireCertificatePrivateKey|X509Store|Process\.Start')
 [pscustomobject]@{Decision='YSEDU_LEAF_SIGNING_PUBLIC_GUARDS_PASSED';ObservedAt=(Get-Date -Format o);Checks=$checks.Count;TestNames=$checks.ToArray();ExistingPublicArtifactsOnly=$true;TestKeysCreated=$false;CAUnlocked=$false;LeafIssued=$false;ActualLeafChain='PENDING OWNER SIGNING';NoSqlOrNetworkChange=$true}|ConvertTo-Json -Depth 6
}finally{if($null -ne $public){$public.Dispose()};if($null -ne $tampered){$tampered.Dispose()};$ca.Dispose()}
