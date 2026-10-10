# In-memory fixtures and pure rollback decisions only; no machine CSR or Apply.
$ErrorActionPreference='Stop'
$testRoot='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010'
. (Join-Path $testRoot 'Read-YseduCsr001.ps1')
$t=$null;$e=$null
$ast=[Management.Automation.Language.Parser]::ParseFile((Join-Path $testRoot 'Restore-YseduLeafNetwork001.ps1'),[ref]$t,[ref]$e)
if($e.Count){throw 'Rollback parse failed'}
$f=$ast.Find({param($n) $n -is [Management.Automation.Language.FunctionDefinitionAst] -and $n.Name -ceq 'Test-RbOwnedChange'},$true)
. ([scriptblock]::Create($f.Extent.Text))
$s='SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL12.YSEDU\MSSQLServer\SuperSocketNetLib'
$owned=[pscustomobject]@{LeafThumbprint='AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'}
$cases=@(
 @($s,'Certificate',$owned.LeafThumbprint,$true),@($s,'Certificate','BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',$false),
 @($s,'ForceEncryption',1,$false),@($s,'HideInstance',1,$false),
 @(($s+'\Tcp'),'Enabled',1,$true),@(($s+'\Tcp'),'ListenOnAllIPs',0,$true),@(($s+'\Tcp'),'KeepAlive',10,$false),
 @(($s+'\Tcp\IP4'),'Enabled',1,$true),@(($s+'\Tcp\IP4'),'TcpDynamicPorts','49152',$true),
 @(($s+'\Tcp\IP4'),'TcpDynamicPorts','65536',$false),@(($s+'\Tcp\IP4'),'TcpPort','1433',$false),
 @(($s+'\Tcp\IP12'),'Enabled',1,$false),@('SYSTEM\CurrentControlSet\Services\SQLBrowser','Start',3,$true),
 @('SYSTEM\CurrentControlSet\Services\MSSQL$YSEDU','Start',3,$false),
 @('SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL12.OTHER\MSSQLServer\SuperSocketNetLib','Certificate',$owned.LeafThumbprint,$false))
foreach($c in $cases){if((Test-RbOwnedChange $c[0] $c[1] $c[2] $owned) -ne $c[3]){throw 'Owned rollback scope vector failed'}}
if(Test-RbOwnedChange $s 'Certificate' $owned.LeafThumbprint $null){throw 'Unowned leaf accepted'}
function New-TestCsr($Rsa,[string]$Subject='CN=DESKTOP-8QRQT7R',[string]$San='DESKTOP-8QRQT7R',[string]$Mode='Normal'){
 $q=[Security.Cryptography.X509Certificates.CertificateRequest]::new($Subject,$Rsa,[Security.Cryptography.HashAlgorithmName]::SHA256,[Security.Cryptography.RSASignaturePadding]::Pkcs1)
 $q.CertificateExtensions.Add([Security.Cryptography.X509Certificates.X509KeyUsageExtension]::new([Security.Cryptography.X509Certificates.X509KeyUsageFlags]160,$true))
 if($Mode -cne 'MissingEku'){$eku=[Security.Cryptography.OidCollection]::new();[void]$eku.Add([Security.Cryptography.Oid]::new('1.3.6.1.5.5.7.3.1'));$q.CertificateExtensions.Add([Security.Cryptography.X509Certificates.X509EnhancedKeyUsageExtension]::new($eku,$false))}
 $builder=[Security.Cryptography.X509Certificates.SubjectAlternativeNameBuilder]::new();$builder.AddDnsName($San);$q.CertificateExtensions.Add($builder.Build($false))
 if($Mode -ceq 'Unknown'){$q.CertificateExtensions.Add([Security.Cryptography.X509Certificates.X509Extension]::new('1.2.3.4.5',[byte[]](5,0),$false))}
 if($Mode -ceq 'Duplicate'){$q.CertificateExtensions.Add($builder.Build($false))}
 if($Mode -ceq 'CA'){$q.CertificateExtensions.Add([Security.Cryptography.X509Certificates.X509BasicConstraintsExtension]::new($true,$true,0,$true))}
 return $q
}
$rsa=[Security.Cryptography.RSA]::Create(2048);$weak=[Security.Cryptography.RSA]::Create(1024)
$negative=0
try{
 $good=(New-TestCsr $rsa).CreateSigningRequest();[void](Read-YseduCsr001 $good)
 $tampered=[byte[]]$good.Clone();$tampered[$tampered.Length-1]=$tampered[$tampered.Length-1] -bxor 1
 $badRequests=@($tampered,(New-TestCsr $rsa 'CN=OTHER').CreateSigningRequest(),(New-TestCsr $rsa 'CN=DESKTOP-8QRQT7R' 'OTHER').CreateSigningRequest(),(New-TestCsr $weak).CreateSigningRequest(),(New-TestCsr $rsa -Mode MissingEku).CreateSigningRequest(),(New-TestCsr $rsa -Mode Unknown).CreateSigningRequest(),(New-TestCsr $rsa -Mode Duplicate).CreateSigningRequest(),(New-TestCsr $rsa -Mode CA).CreateSigningRequest())
 foreach($bad in $badRequests){$rejected=$false;try{[void](Read-YseduCsr001 $bad)}catch{$rejected=$true};if(-not $rejected){throw 'Invalid CSR accepted'};$negative++}
 [pscustomobject]@{Decision='YSEDU_CSR_AND_ROLLBACK_PURE_TESTS_PASSED';ObservedAt=(Get-Date -Format o);RollbackScopeVectors=($cases.Count+1);CsrPositive=1;CsrNegatives=$negative;FixtureKeyScope='Process memory only';MachineKeyCreated=$false;CertificateStoreChanged=$false;SqlStopped=$false;RollbackApplyTested=$false;AdministrativeNativeInspection='Deferred to operator CSR preflight before key creation'}|ConvertTo-Json
}finally{$rsa.Dispose();$weak.Dispose()}
