# Public PKCS10 validation only. No key creation, signing, import or host changes.
# Dot-source in a fresh PS7/.NET10 process. Reject SHA1/tampered requests/unknown extensions.
function Read-YseduCsr001([byte[]]$Der) {
 if($Der.Length -gt 16384 -or $Der.Length -lt 256){throw 'STOP: CSR length bound'}
 $reader=[System.Formats.Asn1.AsnReader]::new([ReadOnlyMemory[byte]]::new($Der),[System.Formats.Asn1.AsnEncodingRules]::DER)
 $seq=$reader.ReadSequence($null)
 [void]$seq.ReadEncodedValue()
 $alg=$seq.ReadSequence($null)
 if($alg.ReadObjectIdentifier() -cne '1.2.840.113549.1.1.11'){throw 'STOP: CSR SHA256/RSA signature required'}
 if($alg.HasData){$alg.ReadNull($null)}
 $alg.ThrowIfNotEmpty()
 $unused=0;[void]$seq.ReadBitString([ref]$unused,$null)
 if($unused -ne 0){throw 'STOP: CSR signature padding'}
 $seq.ThrowIfNotEmpty();$reader.ThrowIfNotEmpty()
 # This overload verifies the PKCS10 signature; never SkipSignatureValidation.
 $req=[Security.Cryptography.X509Certificates.CertificateRequest]::LoadSigningRequest($Der,[Security.Cryptography.HashAlgorithmName]::SHA256,[Security.Cryptography.X509Certificates.CertificateRequestLoadOptions]::UnsafeLoadCertificateExtensions,[Security.Cryptography.RSASignaturePadding]::Pkcs1)
 if($req.SubjectName.Name -cne 'CN=DESKTOP-8QRQT7R' -or $req.PublicKey.Oid.Value -cne '1.2.840.113549.1.1.1'){throw 'STOP: CSR subject/key algorithm'}
 $rsa=$req.PublicKey.GetRSAPublicKey()
 try {if($rsa.KeySize -ne 2048){throw 'STOP: CSR RSA2048 required'}}finally{$rsa.Dispose()}
 $seen=@{};$haveSan=$false;$haveEku=$false;$haveUsage=$false
 foreach($ext in $req.CertificateExtensions){
  $oid=$ext.Oid.Value
  if($seen.ContainsKey($oid)){throw 'STOP: duplicate CSR extension'};$seen[$oid]=$true
  switch -CaseSensitive ($oid){
   '2.5.29.17' {
    $builder=[Security.Cryptography.X509Certificates.SubjectAlternativeNameBuilder]::new();$builder.AddDnsName('DESKTOP-8QRQT7R');$expected=$builder.Build($ext.Critical)
    if([Convert]::ToBase64String($ext.RawData) -cne [Convert]::ToBase64String($expected.RawData)){throw 'STOP: CSR SAN mismatch'};$haveSan=$true
   }
   '2.5.29.37' {
    $eku=[Security.Cryptography.X509Certificates.X509EnhancedKeyUsageExtension]::new($ext,$ext.Critical)
    if($eku.EnhancedKeyUsages.Count -ne 1 -or $eku.EnhancedKeyUsages[0].Value -cne '1.3.6.1.5.5.7.3.1'){throw 'STOP: CSR EKU mismatch'};$haveEku=$true
   }
   '2.5.29.15' {
    $usage=[Security.Cryptography.X509Certificates.X509KeyUsageExtension]::new($ext,$ext.Critical)
    if([int]$usage.KeyUsages -ne 160){throw 'STOP: CSR key usage mismatch'};$haveUsage=$true
   }
   '2.5.29.19' {
    $bc=[Security.Cryptography.X509Certificates.X509BasicConstraintsExtension]::new($ext,$ext.Critical)
    if($bc.CertificateAuthority -or $bc.HasPathLengthConstraint){throw 'STOP: CSR CA constraint'}
   }
   default {throw 'STOP: unknown CSR extension'}
  }
 }
 if(-not $haveSan -or -not $haveEku -or -not $haveUsage){throw 'STOP: required CSR extension missing'}
 return $req
}
