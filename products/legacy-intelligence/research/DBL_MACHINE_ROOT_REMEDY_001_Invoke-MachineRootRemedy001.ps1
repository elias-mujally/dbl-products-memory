[CmdletBinding()]
param([switch]$CheckOnly)
$ErrorActionPreference='Stop'
$root=$PSScriptRoot
$resultPath=Join-Path $root 'MACHINE_ROOT_REMEDY_001_RESULT.json'
$attemptPath=Join-Path $root 'MACHINE_ROOT_REMEDY_001_ATTEMPT.json'
$beforePath=Join-Path $root 'MACHINE_ROOT_REMEDY_001_BEFORE.json'
$caPin='A3FBC7905425B2E8C10F3A070B8713F876B94FC42B8D1243DEAD5D0F42889472'
$caThumb='121CDC9857488ED95F4BC62106D7672BB0DBC6C3'
$leafPin='522C79FD31F0422D3988FB00CC4EF0A51B4042DEED72A435A6519237AC548DFE'
$leafThumb='A51BD253B6083D0114428FCFBAD57D008CD102F5'
$entry=$caThumb+':'+$caPin
function Require($condition,[string]$code){if(-not $condition){throw [InvalidOperationException]::new($code)}}
function Write-NewJson([string]$path,$value){
 $bytes=[Text.UTF8Encoding]::new($false).GetBytes(($value|ConvertTo-Json -Depth 25))
 $s=[IO.File]::Open($path,[IO.FileMode]::CreateNew,[IO.FileAccess]::Write,[IO.FileShare]::None)
 try{$s.Write($bytes,0,$bytes.Length);$s.Flush($true)}finally{$s.Dispose()}
}
function Inventory {
 $rows=@()
 foreach($location in 'CurrentUser','LocalMachine'){foreach($name in 'Root','CA','My'){
  $store=[Security.Cryptography.X509Certificates.X509Store]::new($name,[Security.Cryptography.X509Certificates.StoreLocation]::$location)
  $certs=$null
  try{
   $store.Open([Security.Cryptography.X509Certificates.OpenFlags]::ReadOnly -bor [Security.Cryptography.X509Certificates.OpenFlags]::OpenExistingOnly)
   $certs=$store.Certificates
   $entries=@($certs|ForEach-Object{$_.Thumbprint+':'+[Convert]::ToHexString([Security.Cryptography.SHA256]::HashData($_.RawData))}|Sort-Object)
   $rows += [pscustomobject]@{Location=$location;Store=$name;Entries=$entries;Count=$entries.Count;Fingerprint=[Convert]::ToHexString([Security.Cryptography.SHA256]::HashData([Text.Encoding]::UTF8.GetBytes(($entries -join "`n"))))}
  }finally{if($certs){foreach($c in $certs){$c.Dispose()}};$store.Dispose()}
 }}
 return $rows
}
function Assert-Delta($before,$after,[bool]$added){
 Require ($before.Count -eq 6 -and $after.Count -eq 6) 'SixStoreViewsRequired'
 foreach($b in $before){
  $a=@($after|Where-Object{$_.Location -ceq $b.Location -and $_.Store -ceq $b.Store})
  Require ($a.Count -eq 1) 'UniqueStoreViewRequired'
  $expected=@($b.Entries)
  if($added -and $b.Store -ceq 'Root'){$expected=@($expected)+@($entry)} # Machine Root inherited by CurrentUser Root.
  Require ((@($expected|Sort-Object) -join "`n") -ceq (@($a[0].Entries|Sort-Object) -join "`n")) ('UnexpectedStoreDelta_'+$b.Location+'_'+$b.Store)
 }
}
function Services {
 @(Get-CimInstance Win32_Service -Filter 'Name=''MSSQL$YSEDU'' OR Name=''SQLBrowser'''|Select-Object Name,State,StartMode,ProcessId,StartName,PathName|Sort-Object Name)
}
function Summary($views){@($views|Select-Object Location,Store,Count,Fingerprint)}
function Assert-Chain($chain){
 Require ($chain.AdditionalPublicIssuer -eq $false -and $chain.AdditionalStoreIsTrustAnchor -eq $false -and $chain.Elements.Count -eq 2) 'ExactChainWithoutExtraStoreRequired'
 Require ($chain.Elements[0].Thumbprint -ceq $leafThumb -and $chain.Elements[1].Thumbprint -ceq $caThumb) 'ExactLeafCaOrderRequired'
 Require ($chain.BasePolicy.IgnoreFlags -eq 0 -and $chain.SslPolicy.IgnoreFlags -eq 0) 'ZeroIgnoreFlagsRequired'
 Require ($chain.ErrorStatus -ceq '0x00000000' -and $chain.BasePolicy.Error -ceq '0x00000000' -and $chain.SslPolicy.Error -ceq '0x00000000') 'ChainPolicyNotPassed'
}
function Test-PureDelta {
 $b=@();foreach($loc in 'CurrentUser','LocalMachine'){foreach($name in 'Root','CA','My'){$b += [pscustomobject]@{Location=$loc;Store=$name;Entries=@('BASE:'+($loc+$name))}}}
 $a=@($b|ConvertTo-Json -Depth 8|ConvertFrom-Json)
 foreach($r in $a){if($r.Store -ceq 'Root'){$r.Entries=@($r.Entries)+@($entry)}}
 Assert-Delta $b $a $true;Assert-Delta $b $b $false
 $negative=0
 foreach($test in 'RootMissing','OtherAdded','OriginalRemoved','Duplicate','SingleUserOnly','ChangedDer'){
  $bad=@($a|ConvertTo-Json -Depth 8|ConvertFrom-Json)
  switch($test){
   'RootMissing'{$bad[0].Entries=@($b[0].Entries)}
   'OtherAdded'{$bad[1].Entries=@($bad[1].Entries)+@('UNAUTHORIZED')}
   'OriginalRemoved'{$bad[0].Entries=@($entry)}
   'Duplicate'{$bad[3].Entries=@($bad[3].Entries)+@($entry)}
   'SingleUserOnly'{$bad[3].Entries=@($b[3].Entries)}
   'ChangedDer'{$bad[3].Entries=@($b[3].Entries)+@($caThumb+':WRONG')}
  }
  $rejected=$false;try{Assert-Delta $b $bad $true}catch{$rejected=$true};Require $rejected ('NegativeVectorNotRejected_'+$test);$negative++
 }
 [pscustomobject]@{PositiveVectors=2;NegativeVectors=$negative;RealStoreOpened=$false;CertificateMutation=$false}
}
if($CheckOnly){
 Require ($PSVersionTable.PSVersion.Major -ge 7) 'PS7Required'
 $vectors=Test-PureDelta
 [pscustomobject]@{Decision='MACHINE_ROOT_PURE_GUARDS_PASSED';Vectors=$vectors;CertreqInvoked=$false;ServiceChanged=$false}|ConvertTo-Json -Depth 8
 return
}
$phase='Identity';$check='HostToken';$before=$null;$after=$null;$final=$null;$servicesBefore=$null;$servicesAfter=$null
$chains=@();$revocation=@();$chainStatus='NOT_TESTED';$revocationStatus='NOT_TESTED';$failure=$null;$rollback='NOT_NEEDED';$rollbackFailure=$null;$baselineHash=$null;$attemptConsumed=$false
$ca=$null;$leaf=$null;$mutatorLoaded=$false;$retained=$false
try{
 Require ($env:COMPUTERNAME -ceq 'DESKTOP-8QRQT7R' -and $PSVersionTable.PSVersion.Major -ge 7 -and [IntPtr]::Size -eq 8) 'HostPS7X64Required'
 $id=[Security.Principal.WindowsIdentity]::GetCurrent()
 try{Require ($id.Name -ceq 'DESKTOP-8QRQT7R\user' -and ([Security.Principal.WindowsPrincipal]::new($id)).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) 'OwnerAdministratorRequired'}finally{$id.Dispose()}
 Require (-not (Test-Path -LiteralPath $resultPath) -and -not (Test-Path -LiteralPath $attemptPath) -and -not (Test-Path -LiteralPath $beforePath)) 'FreshAttemptOnly'
 $phase='PublicPins';$check='ExactArtifacts'
 $reader=Join-Path $root 'WindowsChainReadOnly001.cs';$writer=Join-Path $root 'OwnedMachineRoot001.cs'
 Require ((Get-FileHash -LiteralPath $reader -Algorithm SHA256).Hash -ceq '1E07A72C4A8E6DA06FF8B88A9E98ADCF47E550ACDD91AC0E73DF8294B998EE66') 'ReaderSourcePin'
 Require ((Get-FileHash -LiteralPath $writer -Algorithm SHA256).Hash -ceq '968CB5C984DF94519871BFAE20B03D7DE01108A7D8546E7CC4B3236041B62CC1') 'WriterSourcePin'
 $caPath='E:\DBL-Lab-CA-YSEDU-001\ca-public.cer';$leafPath=Join-Path $root 'YSEDU-Leaf-Signed-001.cer'
 Require ((Get-FileHash -LiteralPath $caPath -Algorithm SHA256).Hash -ceq $caPin -and (Get-FileHash -LiteralPath $leafPath -Algorithm SHA256).Hash -ceq $leafPin) 'PublicDerPins'
 $caBytes=[IO.File]::ReadAllBytes($caPath);$leafBytes=[IO.File]::ReadAllBytes($leafPath)
 $ca=[Security.Cryptography.X509Certificates.X509CertificateLoader]::LoadCertificate($caBytes);$leaf=[Security.Cryptography.X509Certificates.X509CertificateLoader]::LoadCertificate($leafBytes)
 Require ($ca.Thumbprint -ceq $caThumb -and $leaf.Thumbprint -ceq $leafThumb -and -not $ca.HasPrivateKey -and -not $leaf.HasPrivateKey) 'PublicThumbprintsOnly'
 Require ($ca.Subject -ceq 'CN=DBL Laboratory YSEDU CA 001 - 20261010' -and $ca.Subject -ceq $ca.Issuer -and $leaf.Issuer -ceq $ca.Subject) 'IssuerSubjectProfile'
 $rsa=[Security.Cryptography.X509Certificates.RSACertificateExtensions]::GetRSAPublicKey($ca)
 try{Require ($rsa.KeySize -eq 3072) 'CaRSA3072Required'}finally{$rsa.Dispose()}
 foreach($c in $ca,$leaf){Require ([datetime]::UtcNow -ge $c.NotBefore.ToUniversalTime() -and [datetime]::UtcNow -lt $c.NotAfter.ToUniversalTime() -and $c.SignatureAlgorithm.Value -ceq '1.2.840.113549.1.1.11') 'TimeSignatureProfile'}
 $expectedExtensions=@{'2.5.29.19'='True:30060101FF020100';'2.5.29.15'='True:03020106';'2.5.29.14'='False:04144C845EF2946D4B594E4F0FE15A2DCC5C6B2E0EC2'}
 Require ($ca.Extensions.Count -eq 3) 'ExactCaExtensions'
 foreach($e in $ca.Extensions){Require ($expectedExtensions.ContainsKey($e.Oid.Value) -and ($e.Critical.ToString()+':'+[Convert]::ToHexString($e.RawData)) -ceq $expectedExtensions[$e.Oid.Value]) 'CaExtensionProfile'}
 Add-Type -Path $reader;Add-Type -Path $writer;$mutatorLoaded=$true
 $caSignature=[DblWindowsChainReadOnly001]::Signature($caBytes,$caBytes);$leafSignature=[DblWindowsChainReadOnly001]::Signature($leafBytes,$caBytes)
 Require ($caSignature.Verified -and $leafSignature.Verified -and $leafSignature.IssuerSubjectRawEqual) 'PublicSignatures'
 $phase='FreshBaseline';$check='RootAbsentAndServices'
 $before=Inventory
 foreach($s in $before){Require (@($s.Entries|Where-Object{$_ -like ($caThumb+':*')}).Count -eq 0) 'CaUnexpectedlyPresentStop'}
 $servicesBefore=Services
 Require ($servicesBefore.Count -eq 2 -and @($servicesBefore|Where-Object{$_.Name -ceq 'MSSQL$YSEDU' -and $_.State -ceq 'Running' -and $_.StartMode -ceq 'Auto' -and $_.StartName -ceq 'LocalSystem'}).Count -eq 1 -and @($servicesBefore|Where-Object{$_.Name -ceq 'SQLBrowser' -and $_.State -ceq 'Stopped' -and $_.StartMode -ceq 'Disabled'}).Count -eq 1) 'OriginalServiceStateRequired'
 Write-NewJson $beforePath ([pscustomobject]@{At=(Get-Date -Format o);Host=$env:COMPUTERNAME;Scope='six logical stores thumbprint+DER';Before=$before;Services=$servicesBefore;ExpectedAddition=$entry;ExpectedInheritedUserRoot=$true;Rollback='Only newly returned ADD_NEW certificate context; never lookup/delete by subject'})
 $baselineHash=(Get-FileHash -LiteralPath $beforePath -Algorithm SHA256).Hash
 $check='RecheckBeforeAdd';Assert-Delta $before (Inventory) $false
 Require ((Get-FileHash -LiteralPath $caPath -Algorithm SHA256).Hash -ceq $caPin) 'ImmediateCaPin'
 Write-NewJson $attemptPath ([pscustomobject]@{At=(Get-Date -Format o);Host=$env:COMPUTERNAME;Owner='OWNER_APPROVAL_BOUNDED_MACHINE_ROOT_TRUST_REMEDY';Target='LocalMachine\Root';Thumbprint=$caThumb;DER_SHA256=$caPin;BaselineSHA256=$baselineHash;Disposition='CERT_STORE_ADD_NEW';MutationLimit=1;RollbackOnChainOrRevocationFailure=$true})
 $attemptConsumed=$true;$phase='AddNew';$check='OnePinnedNativeAdd'
 [DblOwnedMachineRoot001]::AddNew($caBytes)
 $phase='PostAdd';$check='ExactSixStoreDelta';$after=Inventory;Assert-Delta $before $after $true
 $phase='ChainReadiness';$check='MachineAndUserNoExtraIssuer'
 foreach($machine in $true,$false){$chains += [DblWindowsChainReadOnly001]::Build($leafBytes,$caBytes,$machine,$false,$false)}
 foreach($c in $chains){Assert-Chain $c};$chainStatus='PASSED_CHAIN_TRUST_PROFILE_ONLY'
 $phase='Revocation';$check='MachineAndUserCacheOnlyRevocation'
 foreach($machine in $true,$false){$revocation += [DblWindowsChainReadOnly001]::Build($leafBytes,$caBytes,$machine,$false,$true)}
 $revocationStatus='FAILED_OR_UNKNOWN'
 foreach($c in $revocation){Assert-Chain $c};$revocationStatus='PASSED_CACHE_ONLY_AT_OBSERVATION'
 $phase='FinalGuard';$check='NoOtherChange'
 Assert-Delta $before (Inventory) $true
 $servicesAfter=Services;Require (($servicesBefore|ConvertTo-Json -Depth 5 -Compress) -ceq ($servicesAfter|ConvertTo-Json -Depth 5 -Compress)) 'ServiceStateChanged'
 Require ((Get-FileHash -LiteralPath $caPath -Algorithm SHA256).Hash -ceq $caPin -and (Get-FileHash -LiteralPath $leafPath -Algorithm SHA256).Hash -ceq $leafPin) 'FinalPublicPins'
 $retained=$true;$final=Inventory
}catch{
 $failure=[pscustomobject]@{Phase=$phase;Check=$check;SafeCode=$_.Exception.Message;ExceptionType=$_.Exception.GetType().FullName}
 if($mutatorLoaded -and [DblOwnedMachineRoot001]::Added){
  try{
   # Owned context came from successful ADD_NEW against an absent exact CA; no broad repair.
   [DblOwnedMachineRoot001]::RemoveOwned();$rollback='OWNED_ROOT_REMOVED'
   $final=Inventory;Assert-Delta $before $final $false;$rollback='OWNED_ROOT_REMOVED_SIX_VIEWS_BASELINE_EQUAL'
  }catch{$rollback='LIMITED_ROLLBACK_FAILED_OR_OTHER_DELTA_REMAINS';$rollbackFailure=[pscustomobject]@{SafeCode=$_.Exception.Message;ExceptionType=$_.Exception.GetType().FullName}}
 }
 try{$servicesAfter=Services}catch{}
}finally{
 if($mutatorLoaded){[DblOwnedMachineRoot001]::Close()}
 if($ca){$ca.Dispose()};if($leaf){$leaf.Dispose()}
}
$cleanup=@();$added=$false;$nativeAttempt=$false;$removalAttempt=$false;$removalSuccess=$false
if($mutatorLoaded){$cleanup=@([DblOwnedMachineRoot001]::CleanupFailures);$added=[DblOwnedMachineRoot001]::Added;$nativeAttempt=[DblOwnedMachineRoot001]::Attempted;$removalAttempt=[DblOwnedMachineRoot001]::RollbackAttempted;$removalSuccess=[DblOwnedMachineRoot001]::RollbackSucceeded}
$decision='MACHINE_ROOT_REMEDY_BLOCKED_STOP';if($retained -and -not $failure -and $cleanup.Count -eq 0){$decision='MACHINE_ROOT_AND_CACHE_REVOCATION_READINESS_PASSED'}
$report=[pscustomobject]@{Decision=$decision;At=(Get-Date -Format o);Host=$env:COMPUTERNAME;Target='LocalMachine\Root';CAThumbprint=$caThumb;CADER_SHA256=$caPin;LeafThumbprint=$leafThumb;BaselineSHA256=$baselineHash;AttemptConsumed=$attemptConsumed;NativeAddAttempted=$nativeAttempt;AddSucceeded=$added;RootRetained=$retained;ChainReadiness=$chainStatus;Revocation=$revocationStatus;ChainResults=$chains;RevocationResults=$revocation;Before=Summary $before;AfterAdd=Summary $after;Final=Summary $final;Rollback=$rollback;RollbackAttempted=$removalAttempt;RollbackSucceeded=$removalSuccess;Failure=$failure;RollbackFailure=$rollbackFailure;CleanupFailures=$cleanup;ServicesBefore=$servicesBefore;ServicesAfter=$servicesAfter;CertreqInvoked=$false;SQLStopped=$false;ServiceChangedByHelper=$false;BrowserStarted=$false;NetworkChanged=$false;FirewallChanged=$false;PfxOpened=$false;PrivateKeyOpened=$false;AclChanged=$false;SQLConnection=$false;FirstLiveData='NOT_TESTED';Context='Elevated owner token; machine engine not LocalSystem impersonation';RevocationScope='Cache-only, exclude root; unknown is failure, no ignore flags';NoAutomaticRetry=$true;Pending='STOP; leaf acceptance and maintenance require separate authorization'}
Write-NewJson $resultPath $report
$report|ConvertTo-Json -Depth 25
