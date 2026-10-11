$ErrorActionPreference='Stop'
$area=$PSScriptRoot
$resultPath=Join-Path $area 'WINDOWS_CHAIN_DIAGNOSIS_001_RESULT.json'
if(Test-Path -LiteralPath $resultPath){throw 'STOP: preserve existing result; no automatic repeat'}
if($env:COMPUTERNAME -cne 'DESKTOP-8QRQT7R' -or $PSVersionTable.PSVersion.Major -lt 7){throw 'Wrong host/runtime'}
$identity=[Security.Principal.WindowsIdentity]::GetCurrent()
$elevated=([Security.Principal.WindowsPrincipal]::new($identity)).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
$leafPath=Join-Path $area 'YSEDU-Leaf-Signed-001.cer'
$caPath='E:\DBL-Lab-CA-YSEDU-001\ca-public.cer'
$pins=@{ $leafPath='522C79FD31F0422D3988FB00CC4EF0A51B4042DEED72A435A6519237AC548DFE'; $caPath='A3FBC7905425B2E8C10F3A070B8713F876B94FC42B8D1243DEAD5D0F42889472' }
foreach($p in $pins.Keys){if((Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash -cne $pins[$p]){throw 'Public certificate hash mismatch'}}
$leafBytes=[IO.File]::ReadAllBytes($leafPath);$caBytes=[IO.File]::ReadAllBytes($caPath)
$leaf=[Security.Cryptography.X509Certificates.X509CertificateLoader]::LoadCertificate($leafBytes)
$ca=[Security.Cryptography.X509Certificates.X509CertificateLoader]::LoadCertificate($caBytes)
function Read-PublicProfile($c){
 $rsa=[Security.Cryptography.X509Certificates.RSACertificateExtensions]::GetRSAPublicKey($c)
 try{[pscustomobject]@{Subject=$c.Subject;Issuer=$c.Issuer;Thumbprint=$c.Thumbprint;Serial=$c.SerialNumber;NotBeforeUtc=$c.NotBefore.ToUniversalTime().ToString('o');NotAfterUtc=$c.NotAfter.ToUniversalTime().ToString('o');ValidNow=([datetime]::UtcNow -ge $c.NotBefore.ToUniversalTime() -and [datetime]::UtcNow -le $c.NotAfter.ToUniversalTime());RSAKeyBits=$rsa.KeySize;SignatureOid=$c.SignatureAlgorithm.Value;HasPrivateKey=$c.HasPrivateKey;Extensions=@($c.Extensions|ForEach-Object{[pscustomobject]@{OID=$_.Oid.Value;Critical=$_.Critical;RawHex=[Convert]::ToHexString($_.RawData);Description=$_.Format($false)}});SKIPresent=(@($c.Extensions|Where-Object{$_.Oid.Value -eq '2.5.29.14'}).Count -gt 0);AKIPresent=(@($c.Extensions|Where-Object{$_.Oid.Value -eq '2.5.29.35'}).Count -gt 0)}}finally{if($rsa){$rsa.Dispose()}}
}
function Read-Stores {
 $rows=@()
 foreach($location in 'CurrentUser','LocalMachine'){foreach($name in 'Root','CA','My'){
  $store=[Security.Cryptography.X509Certificates.X509Store]::new($name,[Security.Cryptography.X509Certificates.StoreLocation]::$location)
  try{
   $store.Open([Security.Cryptography.X509Certificates.OpenFlags]::ReadOnly -bor [Security.Cryptography.X509Certificates.OpenFlags]::OpenExistingOnly)
   $certs=$store.Certificates
   $fingerprintInput=(@($certs|ForEach-Object{$_.Thumbprint+':'+[Convert]::ToHexString([Security.Cryptography.SHA256]::HashData($_.RawData))}|Sort-Object) -join "`n")
   $rows += [pscustomobject]@{Location=$location;Store=$name;ReadSucceeded=$true;CertificateCount=$certs.Count;Fingerprint=[Convert]::ToHexString([Security.Cryptography.SHA256]::HashData([Text.Encoding]::UTF8.GetBytes($fingerprintInput)));ExactCaCount=@($certs|Where-Object{$_.Thumbprint -ceq $ca.Thumbprint}).Count;ExactLeafCount=@($certs|Where-Object{$_.Thumbprint -ceq $leaf.Thumbprint}).Count;Related=@($certs|Where-Object{$_.Subject -ceq $ca.Subject -or $_.Subject -ceq $leaf.Subject}|ForEach-Object{[pscustomobject]@{Thumbprint=$_.Thumbprint;Subject=$_.Subject;Issuer=$_.Issuer}})}
  }finally{if($certs){foreach($c in $certs){$c.Dispose()};$certs=$null};$store.Dispose()}
 }}
 return $rows
}
try{
 if($leaf.HasPrivateKey -or $ca.HasPrivateKey){throw 'Public certificates only'}
 $before=Read-Stores
 Add-Type -Path (Join-Path $area 'WindowsChainReadOnly001.cs')
 $leafSignature=[DblWindowsChainReadOnly001]::Signature($leafBytes,$caBytes)
 $caSelfSignature=[DblWindowsChainReadOnly001]::Signature($caBytes,$caBytes)
 $chains=@();foreach($machine in $false,$true){foreach($additional in $false,$true){$chains += [DblWindowsChainReadOnly001]::Build($leafBytes,$caBytes,$machine,$additional,$false)}}
 $revocation=[DblWindowsChainReadOnly001]::Build($leafBytes,$caBytes,$true,$true,$true)
 $after=Read-Stores
 if(($before|ConvertTo-Json -Depth 10 -Compress) -cne ($after|ConvertTo-Json -Depth 10 -Compress)){throw 'Store inventory changed during bounded observation'}
 foreach($p in $pins.Keys){if((Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash -cne $pins[$p]){throw 'Public artifact changed'}}
 $service=Get-CimInstance Win32_Service -Filter 'Name=''MSSQL$YSEDU'' OR Name=''SQLBrowser'''|Select-Object Name,State,StartMode,ProcessId,StartName
 $report=[pscustomobject]@{Decision='READONLY_WINDOWS_CHAIN_DIAGNOSIS_COMPLETED';ObservedAt=(Get-Date -Format o);Host=$env:COMPUTERNAME;Operator=$identity.Name;Elevated=$elevated;PublicPins=$pins;Leaf=Read-PublicProfile $leaf;CA=Read-PublicProfile $ca;LeafSignature=$leafSignature;CaSelfSignature=$caSelfSignature;StoresBefore=$before;StoresAfter=$after;SixStoreInventoriesUnchanged=$true;NativeChains=$chains;CacheOnlyRevocation=$revocation;Services=@($service);CertreqInvoked=$false;CertificatesAddedOrRemoved=$false;PrivateKeyOpened=$false;PfxOpened=$false;TrustChanged=$false;ServiceChanged=$false;SQLConnection=$false;FirstLiveData='NOT_TESTED';ContextLimit='Observed owner token and native machine engine; not LocalSystem impersonation or certreq internal-engine tracing'}
 $json=$report|ConvertTo-Json -Depth 20
 # Result contains only public metadata; source files/stores are never written.
 $json|Set-Content -LiteralPath $resultPath -Encoding utf8NoBOM
 $json
}finally{$leaf.Dispose();$ca.Dispose();$identity.Dispose()}
