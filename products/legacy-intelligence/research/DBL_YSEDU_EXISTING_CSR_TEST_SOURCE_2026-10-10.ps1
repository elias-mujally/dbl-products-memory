# Public native CSR plus in-memory independently assembled negative requests; no machine/store key.
$ErrorActionPreference='Stop'
$testRoot='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010'
. (Join-Path $testRoot 'Read-YseduExistingCsr001.ps1')
function New-PublicFixture($Rsa,[string]$Mode='Normal') {
 $subject=if($Mode -ceq 'WrongSubject'){'CN=OTHER'}else{'CN=DESKTOP-8QRQT7R'}
 $q=[Security.Cryptography.X509Certificates.CertificateRequest]::new($subject,$Rsa,[Security.Cryptography.HashAlgorithmName]::SHA256,[Security.Cryptography.RSASignaturePadding]::Pkcs1)
 $ku=if($Mode -ceq 'WrongUsage'){128}else{160}
 $q.CertificateExtensions.Add([Security.Cryptography.X509Certificates.X509KeyUsageExtension]::new([Security.Cryptography.X509Certificates.X509KeyUsageFlags]$ku,$true))
 $san=[Security.Cryptography.X509Certificates.SubjectAlternativeNameBuilder]::new();$san.AddDnsName($(if($Mode -ceq 'WrongSan'){'OTHER'}else{'DESKTOP-8QRQT7R'}));$sanExtension=$san.Build($false);$q.CertificateExtensions.Add($sanExtension)
 if($Mode -cne 'MissingEku'){$ekus=[Security.Cryptography.OidCollection]::new();[void]$ekus.Add([Security.Cryptography.Oid]::new('1.3.6.1.5.5.7.3.1'));$q.CertificateExtensions.Add([Security.Cryptography.X509Certificates.X509EnhancedKeyUsageExtension]::new($ekus,($Mode -ceq 'CoreCriticality')))}
 $q.CertificateExtensions.Add([Security.Cryptography.X509Certificates.X509BasicConstraintsExtension]::new(($Mode -ceq 'CA'),$false,0,$true))
 $smime=[Convert]::FromHexString('308183300E06082A864886F70D030202020080300E06082A864886F70D030402020080300706052B0E030207300A06082A864886F70D0307300B060960864801650304012A300B060960864801650304012D300B0609608648016503040116300B0609608648016503040119300B0609608648016503040102300B0609608648016503040105')
 if($Mode -ceq 'SmimeDrift'){$smime[$smime.Length-1]=$smime[$smime.Length-1] -bxor 1}
 if($Mode -cne 'MissingSmime'){$q.CertificateExtensions.Add([Security.Cryptography.X509Certificates.X509Extension]::new('1.2.840.113549.1.9.15',$smime,($Mode -ceq 'SmimeCritical')))}
 $ski=[Security.Cryptography.X509Certificates.X509SubjectKeyIdentifierExtension]::new($q.PublicKey,$false)
 if($Mode -ceq 'SkiDrift'){$ski=[Security.Cryptography.X509Certificates.X509SubjectKeyIdentifierExtension]::new('0000000000000000000000000000000000000000',$false)}
 if($Mode -ceq 'SkiCritical'){$ski.Critical=$true};$q.CertificateExtensions.Add($ski)
 if($Mode -ceq 'UnknownExtension'){$q.CertificateExtensions.Add([Security.Cryptography.X509Certificates.X509Extension]::new('1.2.3.4.5',[byte[]](5,0),$false))}
 if($Mode -ceq 'DuplicateExtension'){$q.CertificateExtensions.Add($sanExtension)}
 $values=@(
  @('1.3.6.1.4.1.311.13.2.3','160C31302E302E32323633312E32'),
  @('1.3.6.1.4.1.311.21.20','30370201090C0F4445534B544F502D385152515437520C144445534B544F502D385152515437525C757365720C0B636572747265712E657865'),
  @('1.3.6.1.4.1.311.13.2.2','30720201011E6A004D006900630072006F0073006F0066007400200045006E00680061006E006300650064002000520053004100200061006E00640020004100450053002000430072007900700074006F0067007200610070006800690063002000500072006F00760069006400650072030100')
 )
 foreach($value in $values){
  if($Mode -ceq 'MissingAttribute' -and $value[0] -ceq '1.3.6.1.4.1.311.13.2.3'){continue}
  $data=[Convert]::FromHexString($value[1]);if($Mode -ceq 'AttributeDrift' -and $value[0] -ceq '1.3.6.1.4.1.311.13.2.3'){$data[$data.Length-1]=$data[$data.Length-1] -bxor 1}
  $a=[Security.Cryptography.AsnEncodedData]::new([Security.Cryptography.Oid]::new($value[0]),$data);$q.OtherRequestAttributes.Add($a)
  if($Mode -ceq 'DuplicateAttribute' -and $value[0] -ceq '1.3.6.1.4.1.311.13.2.3'){$q.OtherRequestAttributes.Add($a)}
 }
 if($Mode -ceq 'UnknownAttribute'){$q.OtherRequestAttributes.Add([Security.Cryptography.AsnEncodedData]::new([Security.Cryptography.Oid]::new('1.2.3.4.6'),[byte[]](5,0)))}
 return $q.CreateSigningRequest()
}
$rsa=[Security.Cryptography.RSA]::Create(2048);$weak=[Security.Cryptography.RSA]::Create(1024)
try {
 $text=Get-Content -LiteralPath (Join-Path $testRoot 'YSEDU-Leaf-CSP24-001.req') -Raw
 if($text -cnotmatch '\A\s*-----BEGIN (?:NEW )?CERTIFICATE REQUEST-----\s+([A-Za-z0-9+/=\s]+)-----END (?:NEW )?CERTIFICATE REQUEST-----\s*\z'){throw 'Native public encoding changed'}
 $native=[Convert]::FromBase64String($Matches[1]);$nativeRequest=Read-YseduExistingCsr001 $native
 $actualSki=@($nativeRequest.CertificateExtensions|Where-Object {$_.Oid.Value -ceq '2.5.29.14'})[0]
 if([Convert]::ToHexString($actualSki.RawData) -cne '0414AF91886B9B6F58BF2A344C425CE2DF789601A808'){throw 'Independent observed SKI mismatch'}
 [void](Read-YseduExistingCsr001 (New-PublicFixture $rsa))
 $negative=0;$modes=@('WrongSubject','WrongSan','WrongUsage','MissingEku','CoreCriticality','CA','SmimeDrift','MissingSmime','SmimeCritical','SkiDrift','SkiCritical','UnknownExtension','DuplicateExtension','MissingAttribute','AttributeDrift','DuplicateAttribute','UnknownAttribute')
 foreach($mode in $modes){$bad=New-PublicFixture $rsa $mode;$rejected=$false;try{[void](Read-YseduExistingCsr001 $bad)}catch{$rejected=$true};if(-not $rejected){throw ('Invalid request accepted: '+$mode)};$negative++}
 foreach($bad in @((New-PublicFixture $weak),([byte[]]$native.Clone()))){
  if($bad.Length -eq $native.Length){$bad[$bad.Length-1]=$bad[$bad.Length-1] -bxor 1}
  $rejected=$false;try{[void](Read-YseduExistingCsr001 $bad)}catch{$rejected=$true};if(-not $rejected){throw 'Weak/tampered request accepted'};$negative++
 }
 [pscustomobject]@{Decision='EXISTING_CSR_NATIVE_AND_MEMORY_PROFILE_TESTS_PASSED';ObservedAt=(Get-Date -Format o);NativePublicPositive=1;MemoryPositive=1;Negatives=$negative;NativeDerSHA256=[Convert]::ToHexString([Security.Cryptography.SHA256]::HashData($native));OriginalArtifactsUnchanged='READ_ONLY';ExistingPrivateKeyAccessed=$false;MachineKeyCreated=$false;CertificateStoreChanged=$false;SqlChanged=$false;ExtraExtensions='Validated enrollment metadata only; never forwarded to SQL leaf'}|ConvertTo-Json
}finally{$rsa.Dispose();$weak.Dispose()}
