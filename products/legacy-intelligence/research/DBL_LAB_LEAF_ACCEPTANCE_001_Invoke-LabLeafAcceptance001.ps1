[CmdletBinding()]
param([switch]$CheckOnly)
# Owner-approved lab policy and ONE ordinary machine acceptance. Never interrupts SQL.
$ErrorActionPreference='Stop';Set-StrictMode -Version Latest
$root='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010'
$caThumb='121CDC9857488ED95F4BC62106D7672BB0DBC6C3'
$caPin='A3FBC7905425B2E8C10F3A070B8713F876B94FC42B8D1243DEAD5D0F42889472'
$leafThumb='A51BD253B6083D0114428FCFBAD57D008CD102F5'
$leafPin='522C79FD31F0422D3988FB00CC4EF0A51B4042DEED72A435A6519237AC548DFE'
$pendingThumb='079AF9D20802BD4A16B862928194A77BC14B93F4'
$caEntry=$caThumb+':'+$caPin;$leafEntry=$leafThumb+':'+$leafPin
$beforePath=Join-Path $root 'LAB_LEAF_ACCEPTANCE_001_BEFORE.json'
$attemptPath=Join-Path $root 'LAB_LEAF_ACCEPTANCE_001_ATTEMPT.json'
$acceptPath=Join-Path $root 'LAB_LEAF_ACCEPTANCE_001_CERTREQ_ATTEMPT.json'
$resultPath=Join-Path $root 'LAB_LEAF_ACCEPTANCE_001_RESULT.json'
$state=[pscustomobject]@{Phase='Identity';Check='OwnerHostRuntime'}
function Need([bool]$ok,[string]$code){$state.Check=$code;if(-not $ok){throw [InvalidOperationException]::new($code)}}
function Hash([string]$p){(Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash}
function New-Json([string]$p,$value){
 $bytes=[Text.UTF8Encoding]::new($false).GetBytes(($value|ConvertTo-Json -Depth 25))
 $s=[IO.File]::Open($p,[IO.FileMode]::CreateNew,[IO.FileAccess]::Write,[IO.FileShare]::None)
 try{$s.Write($bytes,0,$bytes.Length);$s.Flush($true)}finally{$s.Dispose()}
}
function Inventory {
 $rows=@()
 foreach($location in 'CurrentUser','LocalMachine'){
  $names=if($location -ceq 'LocalMachine'){@('Root','CA','My','Request')}else{@('Root','CA','My')}
  foreach($name in $names){
   $store=[Security.Cryptography.X509Certificates.X509Store]::new($name,[Security.Cryptography.X509Certificates.StoreLocation]::$location);$certs=$null
   try{
    $store.Open([Security.Cryptography.X509Certificates.OpenFlags]::ReadOnly -bor [Security.Cryptography.X509Certificates.OpenFlags]::OpenExistingOnly)
    $certs=$store.Certificates
    $entries=@($certs|ForEach-Object{$_.Thumbprint+':'+[Convert]::ToHexString([Security.Cryptography.SHA256]::HashData($_.RawData))}|Sort-Object)
    Need ($entries.Count -le 256) 'BoundedStoreInventory'
    $rows += [pscustomobject]@{Location=$location;Store=$name;Entries=$entries;Count=$entries.Count;Fingerprint=[Convert]::ToHexString([Security.Cryptography.SHA256]::HashData([Text.Encoding]::UTF8.GetBytes(($entries -join "`n"))))}
   }finally{if($null -ne $certs){foreach($c in $certs){$c.Dispose()}};$store.Dispose()}
  }
 }
 return $rows
}
function Assert-Delta($before,$after,[bool]$rootAdded,[bool]$accepted){
 Need ($before.Count -eq 7 -and $after.Count -eq 7) 'SevenStoreViewsRequired'
 $required=@('CurrentUser/Root','CurrentUser/CA','CurrentUser/My','LocalMachine/Root','LocalMachine/CA','LocalMachine/My','LocalMachine/Request')|Sort-Object
 foreach($views in @($before),@($after)){
  $identities=@($views|ForEach-Object{$_.Location+'/'+$_.Store}|Sort-Object)
  Need (($identities -join '|') -ceq ($required -join '|')) 'ExactUniqueSevenStoreIdentities'
 }
 foreach($b in $before){
  $a=@($after|Where-Object{$_.Location -ceq $b.Location -and $_.Store -ceq $b.Store});Need ($a.Count -eq 1) 'UniqueStoreView'
  $expected=@($b.Entries)
  if($rootAdded -and $b.Store -ceq 'Root'){$expected+=@($caEntry)}
  if($accepted -and $b.Location -ceq 'LocalMachine'){
   if($b.Store -ceq 'My'){$expected+=@($leafEntry)}
   if($b.Store -ceq 'Request'){$expected=@($expected|Where-Object{$_ -cnotlike ($pendingThumb+':*')})}
  }
  Need ((@($expected|Sort-Object) -join "`n") -ceq (@($a[0].Entries|Sort-Object) -join "`n")) ('UnexpectedStoreDelta_'+$b.Location+'_'+$b.Store)
 }
}
function Summary($views){@($views|Select-Object Location,Store,Count,Fingerprint)}
function Assert-ChainIdentity($c){
 Need (-not $c.AdditionalPublicIssuer -and -not $c.AdditionalStoreIsTrustAnchor -and $c.Elements.Count -eq 2) 'ExactNoExtraIssuerChain'
 Need ($c.Elements[0].Thumbprint -ceq $leafThumb -and $c.Elements[1].Thumbprint -ceq $caThumb) 'ExactLeafCaOrder'
 Need ($c.BasePolicy.IgnoreFlags -eq 0 -and $c.SslPolicy.IgnoreFlags -eq 0 -and $c.SslPolicy.Hostname -ceq 'DESKTOP-8QRQT7R') 'StrictPolicyAndHostname'
}
function Assert-Chain($c){
 Assert-ChainIdentity $c
 Need (-not $c.RevocationRequested -and $c.ErrorStatus -ceq '0x00000000' -and $c.BasePolicy.Error -ceq '0x00000000' -and $c.SslPolicy.Error -ceq '0x00000000') 'RequiredTrustProfileChainPassed'
 foreach($element in $c.Elements){Need ($element.ErrorStatus -ceq '0x00000000') 'RequiredChainElementNoError'}
}
function Classify-Revocation($c){
 Assert-ChainIdentity $c;Need ($c.RevocationRequested) 'SeparateRevocationRequested'
 if($c.ErrorStatus -ceq '0x00000000' -and $c.BasePolicy.Error -ceq '0x00000000' -and $c.SslPolicy.Error -ceq '0x00000000'){return 'PASSED_CACHE_ONLY_AT_OBSERVATION'}
 # Only a pure UNKNOWN/offline UNKNOWN is the explicit lab exception, never revoked/other errors.
 Need ($c.ErrorStatus -cin @('0x00000040','0x01000040') -and
  $c.BasePolicy.Error -cin @('0x80092012','0x80092013') -and $c.SslPolicy.Error -cin @('0x80092012','0x80092013')) 'RevocationErrorOutsideApprovedUnknown'
 Need ($c.Elements[1].ErrorStatus -ceq '0x00000000' -and $c.Elements[0].ErrorStatus -cin @('0x00000040','0x01000040')) 'UnknownOnlyOnExistingLeaf'
 return 'UNKNOWN'
}
function Services {
 @(Get-CimInstance Win32_Service -Filter 'Name=''MSSQL$YSEDU'' OR Name=''SQLBrowser'''|Select-Object Name,State,StartMode,ProcessId,StartName,PathName|Sort-Object Name)
}
function Equal($a,$b){return (($a|ConvertTo-Json -Depth 25 -Compress) -ceq ($b|ConvertTo-Json -Depth 25 -Compress))}
function Registry-State($saved){
 $base=[Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine,[Microsoft.Win32.RegistryView]::Registry32);$rows=@()
 try{
  $tcp=$base.OpenSubKey($saved.Security.Path+'\Tcp',$false)
  try{Need ($null -ne $tcp) 'TcpKeyExists';$subkeys=@($tcp.GetSubKeyNames()|Sort-Object);Need ($subkeys.Count -le 32) 'BoundedTcpSubkeys'}finally{if($null -ne $tcp){$tcp.Dispose()}}
  $expected=@($saved.TcpRegistry|Where-Object Path -CNE ($saved.Security.Path+'\Tcp')|ForEach-Object{Split-Path $_.Path -Leaf}|Sort-Object)
  Need (($subkeys -join '|') -ceq ($expected -join '|')) 'OriginalTcpSubkeyInventory'
  $targetIndex=0
  foreach($target in @($saved.Security)+@($saved.TcpRegistry)+@($saved.Startup)+@($saved.ServiceRegistry)){
   $state.Check='OriginalRegistryReadTarget_'+$targetIndex;$targetIndex++
   $key=$base.OpenSubKey($target.Path,$false)
   try{
    Need ($null -ne $key) 'OriginalRegistryTargetExists';$values=@()
    foreach($v in $target.Values){
     $present=$key.GetValueNames() -ccontains $v.Name
     $kind=if($present){[string]$key.GetValueKind($v.Name)}else{$null}
     $value=if($present){$key.GetValue($v.Name,$null,[Microsoft.Win32.RegistryValueOptions]::DoNotExpandEnvironmentNames)}else{$null}
     Need ($present -eq $v.Present -and (Equal $kind $v.Kind) -and (Equal $value $v.Value)) ('OriginalRegistryValue_'+$v.Name)
     $values+=[pscustomobject]@{Name=$v.Name;Present=$present;Kind=$kind;Value=$value}
    }
    $rows+=[pscustomobject]@{Path=$target.Path;Values=$values}
   }finally{if($null -ne $key){$key.Dispose()}}
  }
  return $rows
 }finally{$base.Dispose()}
}
function Read-Key($cert){
 $meta=[DblYseduKeyStorageReadiness001+Result]::new()
 try{[DblYseduKeyStorageReadiness001]::Read($cert.Handle,$meta)}catch{$state.Check='ExistingKey_'+$meta.Check;throw}
 Need ($meta.ContextOpened -and $meta.ContextReleased) 'ExistingCsp24KeySpec1MachineContextReleased'
 $path=Join-Path (Join-Path $env:ProgramData 'Microsoft\Crypto\RSA\MachineKeys') $meta.UniqueName
 $file=Get-Item -LiteralPath $path -Force;Need ($file -is [IO.FileInfo]) 'ExistingKeyFileOnly'
 $item=$file;while($null -ne $item){Need (-not($item.Attributes -band [IO.FileAttributes]::ReparsePoint)) 'NoKeyPathReparse';$item=if($item -is [IO.DirectoryInfo]){$item.Parent}else{$item.Directory}}
 $sddl=(Get-Acl -LiteralPath $path).GetSecurityDescriptorSddlForm([Security.AccessControl.AccessControlSections]'Owner,Group,Access')
 $hash=[Convert]::ToHexString([Security.Cryptography.SHA256]::HashData([Text.Encoding]::UTF8.GetBytes($sddl)))
 Need ($hash -ceq '119EE2FB1E288527CD7128D069EC147F2C5E203DB8709B655A0B2A5FDDA2ED82') 'ExistingQualifiedKeyDaclUnchanged'
 return [pscustomobject]@{Locator=$meta.UniqueName;DaclSHA256=$hash;ExistingProviderContextOpened=$true;ContextReleased=$true}
}
function Test-RootRollbackSafe($before,$after,[bool]$certreqStillRunning,[bool]$servicesEqual,[bool]$registryEqual,[bool]$keyEqual){
 if($certreqStillRunning -or -not $servicesEqual -or -not $registryEqual -or -not $keyEqual){return $false}
 try{Assert-Delta $before $after $true $false;return $true}catch{return $false}
}
$ca=$null;$leaf=$null;$csrPublic=$null;$pending=@();$installed=@();$process=$null;$writerLoaded=$false;$elevated=$false
$before=$null;$postRoot=$null;$final=$null;$servicesBefore=$null;$servicesAfter=$null;$registryBefore=$null;$registryAfter=$null;$keyBefore=$null
$chain=@();$revocation=@();$revocationStatus='NOT_TESTED';$failure=$null;$rollback='NOT_NEEDED';$rollbackFailure=$null;$baselineHash=$null
$attemptConsumed=$false;$certreqCalls=0;$certreqExit=$null;$certreqStillRunning=$false;$accepted=$false;$retained=$false;$associationVerified=$false
$managedCleanup=[Collections.Generic.List[string]]::new()
try{
 Need ($env:COMPUTERNAME -ceq 'DESKTOP-8QRQT7R' -and $PSVersionTable.PSVersion.ToString() -ceq '7.6.5' -and [IntPtr]::Size -eq 8) 'ExactHostPS7X64'
 $pins=@{
  'WindowsChainReadOnly001.cs'='1E07A72C4A8E6DA06FF8B88A9E98ADCF47E550ACDD91AC0E73DF8294B998EE66'
  'OwnedMachineRoot001.cs'='968CB5C984DF94519871BFAE20B03D7DE01108A7D8546E7CC4B3236041B62CC1'
  'YseduKeyStorageReadiness001.cs'='957DC651000AB683D2F679CF8ED844864BB4A075C0DDC2FF469598524D2E3784'
  'YSEDU_LEAF_SIGNING_001_RESULT.json'='756917FF89B109902D5E88CBDDC487B121C1B830B9EECAEF302DE441E6C505C4'
  'YSEDU_EXISTING_KEY_003_RESULT.json'='94B673461344785C58B1D96E366E5666B0D09D9C34DB6E6FF640EBBE8241D4DB'
  'YSEDU_LEAF_MAINTENANCE_ORIGINAL.json'='BB3BF707DCEEDB99396BF2C598B3A0E9BF2E02E83F3FD7AE3A8DB27CF1931BD5'
  'MACHINE_ROOT_REMEDY_001_BEFORE.json'='2D9F518F5A9DB2A98C63ACF73C16AF3F57F83FB2CD90D160FAE7DF2DD65D4B9E'
  'MACHINE_ROOT_REMEDY_001_RESULT.json'='76A5DB59050B0C9697D10ED244CD8862C4B1369C62141100C01AFF69CCB275A2'
  'YSEDU-Leaf-CSP24-001.req'='61B48D26A1AFB37B27ACF0EFDFAA1D90A29B9A39B2F012E0DA7367046E19B889'
  'YSEDU-Leaf-Signed-001.cer'=$leafPin
 }
 foreach($pin in $pins.GetEnumerator()){Need ((Hash (Join-Path $root $pin.Key)) -ceq $pin.Value) ('Pin_'+$pin.Key)}
 $runtime=Join-Path $PSHOME 'pwsh.exe';Need ((Hash $runtime) -ceq '362A356CE7F0940EC74F73A8FC2C990A2CC24A38A11C90BBD8ECA947110AD139' -and [string](Get-AuthenticodeSignature -LiteralPath $runtime).Status -ceq 'Valid') 'QualifiedRuntime'
 $certreq='C:\Windows\System32\certreq.exe';Need ((Hash $certreq) -ceq '07480DC8CAD237515BCEA89F8566E58EA360B57B20AD025E8AEA83EC24106AC1' -and [string](Get-AuthenticodeSignature -LiteralPath $certreq).Status -ceq 'Valid') 'QualifiedWindowsCertreq'
 $saved=Get-Content -LiteralPath (Join-Path $root 'YSEDU_LEAF_MAINTENANCE_ORIGINAL.json') -Raw|ConvertFrom-Json
 Need ($saved.InstanceId -ceq 'MSSQL12.YSEDU' -and $saved.Security.Path -ceq 'SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL12.YSEDU\MSSQLServer\SuperSocketNetLib') 'OriginalYseduIdentity'
 if($CheckOnly){[pscustomobject]@{Decision='LAB_LEAF_ACCEPTANCE_SOURCE_PINS_PASSED';AdministratorChecks=$false;StoreMutation=$false;CertreqInvoked=$false;NoSQLInterruption=$true}|ConvertTo-Json;return}
 $id=[Security.Principal.WindowsIdentity]::GetCurrent()
 try{$elevated=([Security.Principal.WindowsPrincipal]::new($id)).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator);Need ($elevated -and $id.Name -ceq 'DESKTOP-8QRQT7R\user') 'ActualOwnerAdministrator'}finally{$id.Dispose()}
 foreach($p in $beforePath,$attemptPath,$acceptPath,$resultPath){Need (-not(Test-Path -LiteralPath $p)) 'FreshAttemptNoOverwrite'}
 $state.Phase='PublicProfiles';$caPath='E:\DBL-Lab-CA-YSEDU-001\ca-public.cer';$leafPath=Join-Path $root 'YSEDU-Leaf-Signed-001.cer'
 Need ((Hash $caPath) -ceq $caPin) 'ExactPublicCaDer';$caBytes=[IO.File]::ReadAllBytes($caPath);$leafBytes=[IO.File]::ReadAllBytes($leafPath)
 $ca=[Security.Cryptography.X509Certificates.X509CertificateLoader]::LoadCertificate($caBytes);$leaf=[Security.Cryptography.X509Certificates.X509CertificateLoader]::LoadCertificate($leafBytes)
 Need ($ca.Thumbprint -ceq $caThumb -and $leaf.Thumbprint -ceq $leafThumb -and -not $ca.HasPrivateKey -and -not $leaf.HasPrivateKey) 'ExactPublicOnlyIdentities'
 foreach($c in $ca,$leaf){Need ([datetime]::UtcNow -ge $c.NotBefore.ToUniversalTime() -and [datetime]::UtcNow -lt $c.NotAfter.ToUniversalTime() -and $c.SignatureAlgorithm.Value -ceq '1.2.840.113549.1.1.11') 'CurrentValiditySha256'}
 Add-Type -Path (Join-Path $root 'WindowsChainReadOnly001.cs');Add-Type -Path (Join-Path $root 'OwnedMachineRoot001.cs');$writerLoaded=$true
 Add-Type -Path (Join-Path $root 'YseduKeyStorageReadiness001.cs')
 $caSig=[DblWindowsChainReadOnly001]::Signature($caBytes,$caBytes);$leafSig=[DblWindowsChainReadOnly001]::Signature($leafBytes,$caBytes)
 Need ($caSig.Verified -and $leafSig.Verified -and $leafSig.IssuerSubjectRawEqual) 'PinnedPublicSignatures'
 $state.Phase='FreshBaseline';$before=Inventory
 foreach($s in $before){Need (@($s.Entries|Where-Object{$_ -clike ($caThumb+':*') -or $_ -clike ($leafThumb+':*')}).Count -eq 0) 'CaAndLeafAbsentBeforeOwnedAdd'}
 $historical=Get-Content -LiteralPath (Join-Path $root 'MACHINE_ROOT_REMEDY_001_BEFORE.json') -Raw|ConvertFrom-Json
 foreach($s in $historical.Before){$a=@($before|Where-Object{$_.Location -ceq $s.Location -and $_.Store -ceq $s.Store});Need ($a.Count -eq 1 -and $a[0].Fingerprint -ceq $s.Fingerprint) 'SixHistoricalStoreBaselinesIntact'}
 $servicesBefore=Services
 foreach($name in 'YSEDU','Browser'){
  $expected=$saved.BrowserPolicy.$name;$actual=@($servicesBefore|Where-Object Name -CEQ $expected.Name)
  Need ($actual.Count -eq 1 -and $actual[0].State -ceq $expected.State -and $actual[0].StartMode -ceq $expected.StartMode -and $actual[0].StartName -ceq $expected.StartName -and $actual[0].PathName -ceq $expected.PathName) 'OriginalRunningSqlStoppedDisabledBrowser'
 }
 $registryBefore=Registry-State $saved
 $pending=@(Get-ChildItem -LiteralPath 'Cert:\LocalMachine\Request');Need ($pending.Count -eq 1 -and $pending[0].Thumbprint -ceq $pendingThumb -and $pending[0].HasPrivateKey) 'OneExactExistingPendingKey'
 $csr=Get-Content -LiteralPath (Join-Path $root 'YSEDU-Leaf-CSP24-001.req') -Raw
 Need ($csr -cmatch '\A\s*-----BEGIN (?:NEW )?CERTIFICATE REQUEST-----\s+([A-Za-z0-9+/=\s]+)-----END (?:NEW )?CERTIFICATE REQUEST-----\s*\z') 'ExistingCsrEncoding'
 $request=[Security.Cryptography.X509Certificates.CertificateRequest]::LoadSigningRequest([Convert]::FromBase64String($Matches[1]),[Security.Cryptography.HashAlgorithmName]::SHA256,[Security.Cryptography.X509Certificates.CertificateRequestLoadOptions]::UnsafeLoadCertificateExtensions,[Security.Cryptography.RSASignaturePadding]::Pkcs1)
 $csrPublic=$request.PublicKey.GetRSAPublicKey();$spki=[Convert]::ToHexString($csrPublic.ExportSubjectPublicKeyInfo())
 Need ($spki -ceq [Convert]::ToHexString($leaf.PublicKey.ExportSubjectPublicKeyInfo()) -and $spki -ceq [Convert]::ToHexString($pending[0].PublicKey.ExportSubjectPublicKeyInfo()) -and $csrPublic.KeySize -eq 2048) 'CsrPendingLeafPublicKeysIdentical'
 $keyBefore=Read-Key $pending[0]
 New-Json $beforePath ([pscustomobject]@{At=(Get-Date -Format o);Owner='LAB_REVOCATION_POLICY_PLUS_ONE_LEAF_ACCEPTANCE';Stores=$before;Services=$servicesBefore;Registry=$registryBefore;PendingThumbprint=$pendingThumb;PendingPublicMatchesCsrAndLeaf=$true;KeyDaclSHA256=$keyBefore.DaclSHA256;KeyProvider='CSP24';KeySpec=1;MachineKeySet=$true;ExistingProviderContextReleased=$true;RawKeyLocatorPublished=$false;RevocationPolicy='UNKNOWN accepted as separate lab assurance gap only; actual certreq errors never ignored';Rollback='Owned Root context only if seven stores show Root-only delta, key/settings/services unchanged and certreq not running; otherwise defer. No leaf/request/key deletion or request recreation.'})
 $baselineHash=Hash $beforePath
 $state.Phase='ImmediatePreAdd';Assert-Delta $before (Inventory) $false $false;Need ((Equal $servicesBefore (Services)) -and (Equal $registryBefore (Registry-State $saved))) 'BaselineUnchangedImmediatelyBeforeAdd'
 Need ((Hash $caPath) -ceq $caPin -and (Hash $leafPath) -ceq $leafPin) 'ImmediatePublicPins'
 New-Json $attemptPath ([pscustomobject]@{At=(Get-Date -Format o);BaselineSHA256=$baselineHash;RootDisposition='ADD_NEW';RootAddLimit=1;CertreqLimit=1;UnknownDoesNotCauseRollbackAlone=$true;SqlMustRemainRunning=$true;PrivateCAUse=$false})
 $attemptConsumed=$true;$state.Phase='OneOwnedRootAdd';$state.Check='PinnedAddNew';[DblOwnedMachineRoot001]::AddNew($caBytes)
 $postRoot=Inventory;Assert-Delta $before $postRoot $true $false
 $state.Phase='RequiredWindowsChains'
 foreach($machine in $true,$false){$chain += [DblWindowsChainReadOnly001]::Build($leafBytes,$caBytes,$machine,$false,$false)}
 foreach($c in $chain){Assert-Chain $c}
 $state.Phase='SeparateRevocationObservation'
 foreach($machine in $true,$false){$revocation += [DblWindowsChainReadOnly001]::Build($leafBytes,$caBytes,$machine,$false,$true)}
 $statuses=@($revocation|ForEach-Object{Classify-Revocation $_});$revocationStatus=if($statuses -contains 'UNKNOWN'){'UNKNOWN'}else{'PASSED_CACHE_ONLY_AT_OBSERVATION'}
 $state.Phase='ImmediatePreAccept';Assert-Delta $before (Inventory) $true $false
 Need ((Equal $servicesBefore (Services)) -and (Equal $registryBefore (Registry-State $saved)) -and (Equal $keyBefore (Read-Key $pending[0]))) 'SameRunningSqlSettingsAndPendingKeyBeforeAccept'
 Need ((Hash $certreq) -ceq '07480DC8CAD237515BCEA89F8566E58EA360B57B20AD025E8AEA83EC24106AC1' -and (Hash $leafPath) -ceq $leafPin) 'ImmediateCertreqAndLeafPins'
 New-Json $acceptPath ([pscustomobject]@{At=(Get-Date -Format o);Command='certreq -accept -machine';LeafDER_SHA256=$leafPin;AttemptLimit=1;Force=$false;AllowUntrusted=$false;SqlState='Running';Revocation=$revocationStatus})
 $state.Phase='OneOrdinaryCertreqAcceptance';Need ($certreqCalls -eq 0) 'OneCertreqOnly'
 $startInfo=[Diagnostics.ProcessStartInfo]::new($certreq);$startInfo.UseShellExecute=$false;$startInfo.CreateNoWindow=$true;$startInfo.RedirectStandardOutput=$true;$startInfo.RedirectStandardError=$true;$startInfo.RedirectStandardInput=$true
 foreach($arg in @('-accept','-machine',$leafPath)){$startInfo.ArgumentList.Add($arg)}
 $process=[Diagnostics.Process]::new();$process.StartInfo=$startInfo;$certreqCalls++;$state.Check='OrdinaryCertreqStart'
 $null=$process.Start();$process.StandardInput.Close();$stdout=$process.StandardOutput.ReadToEndAsync();$stderr=$process.StandardError.ReadToEndAsync()
 if(-not $process.WaitForExit(60000)){$certreqStillRunning=$true;Need $false 'CertreqTimeoutNoKillNoRollbackRace'}
 $certreqExit=$process.ExitCode;$null=$stdout.GetAwaiter().GetResult();$null=$stderr.GetAwaiter().GetResult()
 Need ($certreqExit -eq 0) 'CertreqAcceptExitZero'
 $state.Phase='PostAcceptanceVerification';$installed=@(Get-ChildItem -LiteralPath 'Cert:\LocalMachine\My')
 Need ($installed.Count -eq 1 -and $installed[0].Thumbprint -ceq $leafThumb -and $installed[0].HasPrivateKey -and [Convert]::ToHexString([Security.Cryptography.SHA256]::HashData($installed[0].RawData)) -ceq $leafPin) 'ExactInstalledLeafHasExistingKey'
 $keyAfter=Read-Key $installed[0];Need ((Equal $keyBefore $keyAfter) -and $spki -ceq [Convert]::ToHexString($installed[0].PublicKey.ExportSubjectPublicKeyInfo())) 'SameOriginalKeyAndSecurityAfterAccept'
 $final=Inventory;Assert-Delta $before $final $true $true;$associationVerified=$true
 $servicesAfter=Services;$registryAfter=Registry-State $saved;Need ((Equal $servicesBefore $servicesAfter) -and (Equal $registryBefore $registryAfter)) 'SameSqlPidAndOriginalSettingsNoBinding'
 foreach($pin in $pins.GetEnumerator()){Need ((Hash (Join-Path $root $pin.Key)) -ceq $pin.Value) 'PreviousEvidencePreservedAfterAccept'}
 Need ((Hash $caPath) -ceq $caPin) 'CaPublicUnchanged'
 $accepted=$true;$retained=$true
}catch{
 $failure=[pscustomobject]@{Phase=$state.Phase;Check=$state.Check;ExceptionType=$_.Exception.GetType().FullName;RawExceptionPublished=$false}
 if($CheckOnly){throw [InvalidOperationException]::new('STOP: source qualification failed at '+$state.Check)}
 if($writerLoaded -and [DblOwnedMachineRoot001]::Added){
  try{
   $rollback='DEFERRED_PARTIAL_STATE_OR_ACTIVE_PROCESS_NO_BROAD_REPAIR'
   if(-not $certreqStillRunning){
    $final=Inventory;$servicesAfter=Services;$registryAfter=Registry-State $saved;$keyNow=Read-Key $pending[0]
    $safe=Test-RootRollbackSafe $before $final $false (Equal $servicesBefore $servicesAfter) (Equal $registryBefore $registryAfter) (Equal $keyBefore $keyNow)
    if($safe){[DblOwnedMachineRoot001]::RemoveOwned();$final=Inventory;Assert-Delta $before $final $false $false;$rollback='OWNED_ROOT_REMOVED_SEVEN_STORE_BASELINE_EQUAL'}
   }
  }catch{$rollback='LIMITED_ROLLBACK_FAILED_OR_READINESS_UNRESOLVED';$rollbackFailure=[pscustomobject]@{Check=$state.Check;ExceptionType=$_.Exception.GetType().FullName;RawExceptionPublished=$false}}
 }
}finally{
 if($writerLoaded){try{[DblOwnedMachineRoot001]::Close()}catch{$managedCleanup.Add('OwnedRootContextClose')}}
 foreach($c in @($ca,$leaf,$csrPublic)+$pending+$installed){if($null -ne $c){try{$c.Dispose()}catch{$managedCleanup.Add('PublicOrExistingCertificateDispose')}}}
 if($null -ne $process){try{$process.Dispose()}catch{$managedCleanup.Add('CertreqProcessObjectDispose')}}
}
if($CheckOnly){return}
$cleanup=@();$addAttempted=$false;$added=$false;$rootRemoval=$false
if($writerLoaded){$cleanup=@([DblOwnedMachineRoot001]::CleanupFailures);$addAttempted=[DblOwnedMachineRoot001]::Attempted;$added=[DblOwnedMachineRoot001]::Added;$rootRemoval=[DblOwnedMachineRoot001]::RollbackSucceeded}
$cleanup+=@($managedCleanup.ToArray())
$decision=if($accepted -and $retained -and $null -eq $failure -and $cleanup.Count -eq 0){'LAB_LEAF_ACCEPTANCE_001_PASSED_SQL_LOADING_NOT_TESTED'}else{'LAB_LEAF_ACCEPTANCE_001_BLOCKED_STOP'}
$report=[pscustomobject]@{Decision=$decision;At=(Get-Date -Format o);Host=$env:COMPUTERNAME;Elevated=$elevated;LabPolicyOwnerApproved=$true;AttemptConsumed=$attemptConsumed;BaselineSHA256=$baselineHash;CAThumbprint=$caThumb;CADER_SHA256=$caPin;LeafThumbprint=$leafThumb;LeafDER_SHA256=$leafPin;RootAddAttempted=$addAttempted;RootAdded=$added;RootRetained=($added -and -not $rootRemoval);CertreqCalls=$certreqCalls;CertreqExitCode=$certreqExit;CertreqExitHex=if($null -ne $certreqExit){'0x'+([uint32]([long]$certreqExit -band 0xffffffffL)).ToString('X8')}else{$null};CertreqStillRunning=$certreqStillRunning;LeafAcceptedAndVerified=$accepted;ExistingKeyAssociationVerified=$associationVerified;PendingRequestConsumedByCertreq=($associationVerified);RequiredChains=$chain;Revocation=$revocationStatus;RevocationResults=$revocation;ProductionRevocationQualified=$false;Before=Summary $before;AfterRootAdd=Summary $postRoot;Final=Summary $final;ServicesBefore=$servicesBefore;ServicesAfter=$servicesAfter;SqlStopCalls=0;SqlStartCalls=0;SqlCertificateBindingChanged=$false;SqlCertificateLoading='NOT_TESTED';BrowserStarted=$false;NetworkChanged=$false;FirewallChanged=$false;WindowsRevocationPolicyChanged=$false;KeyAclChanged=$false;CAUnlocked=$false;PfxOpened=$false;NativeKeyCreation=$false;KeyDeleted=$false;LeafDeleted=$false;PendingRequestDeletedByHelper=$false;RequestRecreated=$false;SQLConnection=$false;FirstLiveData='NOT_TESTED';Rollback=$rollback;RollbackFailure=$rollbackFailure;Failure=$failure;CleanupFailures=$cleanup;RawCertreqOutputPublished=$false;NoAutomaticRetry=$true;Pending='STOP; no binding, network or maintenance. Any SQL loading/live test requires separate owner approval.'}
if($elevated -and -not(Test-Path -LiteralPath $resultPath)){New-Json $resultPath $report}
$report|ConvertTo-Json -Depth 25
