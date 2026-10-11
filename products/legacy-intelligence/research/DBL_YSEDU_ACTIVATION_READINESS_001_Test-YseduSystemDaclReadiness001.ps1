$ErrorActionPreference='Stop';Set-StrictMode -Version Latest
$p='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010\Read-YseduActivationReadiness001.ps1'
$t=$null;$e=$null;$ast=[Management.Automation.Language.Parser]::ParseFile($p,[ref]$t,[ref]$e)
if($e.Count){throw 'Readiness helper parse'}
$state=[pscustomobject]@{Phase='FixtureOnly';Check='NotStarted'}
foreach($name in @('Need-Readiness','Readiness-SystemDacl')){$f=$ast.Find({param($n) $n -is [Management.Automation.Language.FunctionDefinitionAst] -and $n.Name -ceq $name},$true);. ([scriptblock]::Create($f.Extent.Text))}
$cases=@(
 @('O:SYG:SYD:(A;;FA;;;SY)',$true),@('O:SYG:SYD:(A;;0x120089;;;SY)',$true),
 @('O:SYG:SYD:(A;ID;FA;;;SY)',$true),@('O:SYG:SYD:(A;;FA;;;BA)',$false),
 @('O:SYG:SYD:(A;IO;FA;;;SY)',$false),@('O:SYG:SYD:(A;;0x1;;;SY)',$false),
 @('O:SYG:SYD:(D;;0x1;;;WD)(A;;FA;;;SY)',$false),@('O:SYG:SYD:',$false))
foreach($c in $cases){$raw=[Security.AccessControl.RawSecurityDescriptor]::new($c[0]);$passed=$false;try{[void](Readiness-SystemDacl $raw);$passed=$true}catch{};if($passed -ne $c[1]){throw 'DACL fixture decision mismatch'}}
$nullDacl=[Security.AccessControl.RawSecurityDescriptor]::new([Security.AccessControl.ControlFlags]::SelfRelative,[Security.Principal.SecurityIdentifier]::new('S-1-5-18'),[Security.Principal.SecurityIdentifier]::new('S-1-5-18'),$null,$null)
$threw=$false;try{[void](Readiness-SystemDacl $nullDacl)}catch{$threw=$true};if(-not $threw){throw 'Null DACL accepted'}
[pscustomobject]@{Decision='SYSTEM_DACL_READINESS_PURE_TESTS_PASSED';At=(Get-Date -Format o);Vectors=($cases.Count+1);RealKeyOrFileAccess=$false;AclWrite=$false;EffectiveSystemTokenTest=$false}|ConvertTo-Json
