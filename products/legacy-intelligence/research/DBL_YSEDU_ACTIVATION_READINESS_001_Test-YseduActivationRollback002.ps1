$ErrorActionPreference='Stop';Set-StrictMode -Version Latest
$root='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010'
$tokens=$null;$errors=$null;$ast=[Management.Automation.Language.Parser]::ParseFile((Join-Path $root 'Restore-YseduLeafNetwork002.ps1'),[ref]$tokens,[ref]$errors)
if($errors.Count){throw 'Rollback parse'}
foreach($name in @('Test-RbLeafEvidence','Test-RbOwnedChange')){$f=$ast.Find({param($n) $n -is [Management.Automation.Language.FunctionDefinitionAst] -and $n.Name -ceq $name},$true);if($null -eq $f){throw 'Test function absent'};. ([scriptblock]::Create($f.Extent.Text))}
# Independent literal expectation, not copied from implementation constants or fixture key generation.
$good=[pscustomobject]@{Decision='YSEDU_EXISTING_CSR_LEAF_SIGNED_AND_PROFILE_QUALIFIED';CAThumbprint='121CDC9857488ED95F4BC62106D7672BB0DBC6C3';LeafThumbprint='A51BD253B6083D0114428FCFBAD57D008CD102F5';LeafSHA256='522C79FD31F0422D3988FB00CC4EF0A51B4042DEED72A435A6519237AC548DFE';CsrFileSHA256='61B48D26A1AFB37B27ACF0EFDFAA1D90A29B9A39B2F012E0DA7367046E19B889';CsrPublicKeyMatches=$true;PublicArtifactsReReadEqual=$true;FiveCertificateStoresUnchanged=$true;ExistingArtifactsUnchanged=$true;CertificateAccepted=$false;CAReissued=$false;CleanupFailures=@()}
if(-not(Test-RbLeafEvidence $good)){throw 'Valid actual evidence refused'}
$ownershipTests=1
foreach($field in @('Decision','CAThumbprint','LeafThumbprint','LeafSHA256','CsrFileSHA256','CsrPublicKeyMatches','PublicArtifactsReReadEqual','FiveCertificateStoresUnchanged','ExistingArtifactsUnchanged','CertificateAccepted','CAReissued','CleanupFailures')){
 $bad=$good|ConvertTo-Json -Depth 5|ConvertFrom-Json
 if($field -eq 'CleanupFailures'){$bad.$field=@('Failure')}
 elseif($bad.$field -is [bool]){$bad.$field=-not $bad.$field}else{$bad.$field='UNAPPROVED'}
 if(Test-RbLeafEvidence $bad){throw ('Altered evidence accepted: '+$field)};$ownershipTests++
}
if(Test-RbLeafEvidence $null){throw 'Missing evidence accepted'};$ownershipTests++
$s='SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL12.YSEDU\MSSQLServer\SuperSocketNetLib'
$cases=@(
 @($s,'Certificate','a51bd253b6083d0114428fcfbad57d008cd102f5',$true),@($s,'Certificate','BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB',$false),
 @($s,'ForceEncryption',1,$false),@($s,'HideInstance',1,$false),@($s,'ExtendedProtection',1,$false),
 @(($s+'\Tcp'),'Enabled',1,$true),@(($s+'\Tcp'),'ListenOnAllIPs',0,$true),@(($s+'\Tcp'),'ListenOnAllIPs',1,$false),
 @(($s+'\Tcp\IP4'),'Enabled',1,$true),@(($s+'\Tcp\IP4'),'TcpDynamicPorts','49152',$true),@(($s+'\Tcp\IP4'),'TcpDynamicPorts','65536',$false),
 @(($s+'\Tcp\IP4'),'TcpPort','1433',$false),@(($s+'\Tcp\IP12'),'Enabled',1,$false),@(($s+'\Tcp\IP4'),'IpAddress','192.168.56.2',$false),
 @('SYSTEM\CurrentControlSet\Services\SQLBrowser','Start',3,$true),@('SYSTEM\CurrentControlSet\Services\SQLBrowser','Start',2,$false),
 @('SYSTEM\CurrentControlSet\Services\MSSQL$YSEDU','Start',3,$false),@('SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL12.OTHER\MSSQLServer\SuperSocketNetLib','Certificate',$good.LeafThumbprint,$false))
foreach($c in $cases){if((Test-RbOwnedChange $c[0] $c[1] $c[2] $good) -ne $c[3]){throw 'Rollback scope case failed'}}
if(Test-RbOwnedChange $s 'Certificate' $good.LeafThumbprint $null){throw 'Unowned binding accepted'}
$source=Get-Content -LiteralPath (Join-Path $root 'Restore-YseduLeafNetwork002.ps1') -Raw
if($source -match 'YSEDU_LEAF_SIGNED_RESULT|YSEDU_LEAF_SIGNED_PUBLIC_ONLY_PASSED|Remove-Item|DeleteKey|CRYPT_DELETEKEYSET|Start-Service|\.Start\('){throw 'Legacy evidence or forbidden deletion/start'}
if($source -notmatch 'MaintenanceAuthorized' -or $source -notmatch 'SQL state changed during restore' -or $source -notmatch '\$store.Remove\(\$rbMy\[0\]\)'){throw 'Required rollback guards absent'}
Add-Type -TypeDefinition (Get-Content -LiteralPath (Join-Path $root 'YseduKeyStorageReadiness001.cs') -Raw)
[pscustomobject]@{Decision='ACTIVATION_ROLLBACK_002_PURE_TESTS_PASSED';At=(Get-Date -Format o);OwnershipVectors=$ownershipTests;ScopeVectors=($cases.Count+1);KeyStorageReaderCompiled=$true;RealProviderOpened=$false;RollbackApplyTested=$false;SqlOrWindowsChanged=$false;NoPriorCsrOrSigningTestsRepeated=$true}|ConvertTo-Json
