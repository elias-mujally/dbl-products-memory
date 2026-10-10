# Existing native PKCS10 profile only. No private-key APIs, issuance, stores or host writes.
# Two exact noncritical enrollment additions are qualified but NEVER copied to the leaf.
function Read-YseduExistingCsr001([byte[]]$Der) {
 if($Der.Length -lt 256 -or $Der.Length -gt 16384){throw 'STOP: CSR length'}
 $reader=[System.Formats.Asn1.AsnReader]::new([ReadOnlyMemory[byte]]::new($Der),[System.Formats.Asn1.AsnEncodingRules]::DER)
 $outer=$reader.ReadSequence($null);$info=$outer.ReadSequence($null)
 if($info.ReadInteger($null) -ne 0){throw 'STOP: CSR version'}
 [void]$info.ReadEncodedValue();[void]$info.ReadEncodedValue()
 $tag=[System.Formats.Asn1.Asn1Tag]::new([System.Formats.Asn1.TagClass]::ContextSpecific,0,$true)
 $attributes=$info.ReadSetOf($tag);$attributeOids=@{}
 while($attributes.HasData){
  $attribute=$attributes.ReadSequence($null);$oid=$attribute.ReadObjectIdentifier()
  if($attributeOids.ContainsKey($oid)){throw 'STOP: duplicate request attribute'};$attributeOids[$oid]=$true
  if($oid -cnotin @('1.2.840.113549.1.9.14','1.3.6.1.4.1.311.13.2.3','1.3.6.1.4.1.311.21.20','1.3.6.1.4.1.311.13.2.2')){throw 'STOP: unknown request attribute'}
  $values=$attribute.ReadSetOf($null);[void]$values.ReadEncodedValue();$values.ThrowIfNotEmpty();$attribute.ThrowIfNotEmpty()
 }
 if($attributeOids.Count -ne 4){throw 'STOP: request attributes missing'};$info.ThrowIfNotEmpty()
 $algorithm=$outer.ReadSequence($null)
 if($algorithm.ReadObjectIdentifier() -cne '1.2.840.113549.1.1.11'){throw 'STOP: CSR signature algorithm'}
 if($algorithm.HasData){$algorithm.ReadNull($null)};$algorithm.ThrowIfNotEmpty()
 $unused=0;[void]$outer.ReadBitString([ref]$unused,$null)
 if($unused -ne 0){throw 'STOP: signature padding'};$outer.ThrowIfNotEmpty();$reader.ThrowIfNotEmpty()
 # UnsafeLoadCertificateExtensions loads extensions for CLOSED-WORLD checking; signature is NOT skipped.
 $request=[Security.Cryptography.X509Certificates.CertificateRequest]::LoadSigningRequest($Der,[Security.Cryptography.HashAlgorithmName]::SHA256,[Security.Cryptography.X509Certificates.CertificateRequestLoadOptions]::UnsafeLoadCertificateExtensions,[Security.Cryptography.RSASignaturePadding]::Pkcs1)
 if($request.SubjectName.Name -cne 'CN=DESKTOP-8QRQT7R' -or $request.PublicKey.Oid.Value -cne '1.2.840.113549.1.1.1'){throw 'STOP: subject or key algorithm'}
 $rsa=$request.PublicKey.GetRSAPublicKey()
 try{if($rsa.KeySize -ne 2048){throw 'STOP: RSA size'}}finally{$rsa.Dispose()}
 # Exact approved core criticalities/DER. No arbitrary extension forwarding or unknown-OID acceptance.
 $core=@{
  '2.5.29.15'=@($true,'030205A0')
  '2.5.29.17'=@($false,'3011820F4445534B544F502D38515251543752')
  '2.5.29.19'=@($true,'3000')
  '2.5.29.37'=@($false,'300A06082B06010505070301')
 }
 $seen=@{}
 foreach($extension in $request.CertificateExtensions){
  $oid=$extension.Oid.Value
  if($seen.ContainsKey($oid)){throw 'STOP: duplicate extension'};$seen[$oid]=$true
  if($core.ContainsKey($oid)){
   if($extension.Critical -ne $core[$oid][0] -or [Convert]::ToHexString($extension.RawData) -cne $core[$oid][1]){throw 'STOP: core extension profile'}
  }elseif($oid -ceq '1.2.840.113549.1.9.15'){
   if($extension.Critical -or $extension.RawData.Length -ne 134 -or [Convert]::ToHexString([Security.Cryptography.SHA256]::HashData($extension.RawData)) -cne '9474493A3C3160417F9193375425C15F25DF1124C2CFC6462795AE9781128988'){throw 'STOP: S/MIME enrollment metadata drift'}
   # Exact observed DER includes obsolete advertised algorithms. Not enabled/endorsed for TLS.
  }elseif($oid -ceq '2.5.29.14'){
   $expected=[Security.Cryptography.X509Certificates.X509SubjectKeyIdentifierExtension]::new($request.PublicKey,[Security.Cryptography.X509Certificates.X509SubjectKeyIdentifierHashAlgorithm]::Sha1,$false)
   if($extension.Critical -or [Convert]::ToHexString($extension.RawData) -cne [Convert]::ToHexString($expected.RawData)){throw 'STOP: subject key identifier drift'}
   # SHA1 here is only the standard public-key identifier, not a CSR/leaf signature or TLS hash choice.
  }else{throw 'STOP: unknown extension'}
 }
 if($seen.Count -ne 6){throw 'STOP: native extension set incomplete'}
 $expectedAttributes=@{
  '1.3.6.1.4.1.311.13.2.3'=@(14,'D8594404608B05906D026D934DD71D1FFDD54A382677F36B2C4640DFF98C1AD2')
  '1.3.6.1.4.1.311.21.20'=@(57,'FCBFFD26B9D7D014D025AB9ED5A3B1F4BA7CB82D57DE46062B7C91A4074C589F')
  '1.3.6.1.4.1.311.13.2.2'=@(116,'09687255A9488FBBF90F15F6B52819175B08A3044586C56D4A441F749834C5B9')
 }
 $otherSeen=@{}
 foreach($attribute in $request.OtherRequestAttributes){
  $oid=$attribute.Oid.Value
  if($otherSeen.ContainsKey($oid) -or -not $expectedAttributes.ContainsKey($oid)){throw 'STOP: enrollment attribute set'};$otherSeen[$oid]=$true
  if($attribute.RawData.Length -ne $expectedAttributes[$oid][0] -or [Convert]::ToHexString([Security.Cryptography.SHA256]::HashData($attribute.RawData)) -cne $expectedAttributes[$oid][1]){throw 'STOP: enrollment attribute value drift'}
 }
 if($otherSeen.Count -ne 3){throw 'STOP: enrollment attributes incomplete'}
 return $request
}
