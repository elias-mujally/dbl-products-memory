$ErrorActionPreference='Stop';Set-StrictMode -Version Latest
$root=$PSScriptRoot
. (Join-Path $root 'ExistingKeyDiagnostics002.ps1')
$checks=[Collections.Generic.List[string]]::new()
Add-Type -TypeDefinition 'public sealed class DblDiagnosticFake002 { public int Value { get { return 24; } } public bool Broken { get { throw new System.InvalidOperationException("synthetic getter error"); } } }'
function Require([bool]$Ok,[string]$Name){if(-not $Ok){throw ('Synthetic test failed: '+$Name)};[void]$checks.Add($Name)}
# Exercise the invocation scope used by the operator launcher, not a script-scope shortcut.
& {
 $state=New-YseduDiagnosticState
 $threw=$false;try{Assert-YseduDiagnostic $state $false 'LegacyCspRequired'}catch{$threw=$true}
 Require ($threw -and $state.Check -ceq 'LegacyCspRequired') 'SharedStateAssertExactCode'
 Set-YseduReturnedKeyState $state $null
 Require (-not $state.KeyReturnedNonNull -and $state.ManagedKeyType -ceq 'NULL' -and -not $state.OpenAttempted) 'NullIsNotOpenedOrUsable'
 $state.OpenAttempted=$true
 $threw=$false;try{Assert-YseduDiagnostic $state $state.KeyReturnedNonNull 'ReturnedKeyRequired'}catch{$threw=$true}
 Require ($threw -and $state.Check -ceq 'ReturnedKeyRequired' -and $state.OpenAttempted -and -not $state.KeyReturnedNonNull) 'NullAfterOpenAttemptStopsPrecisely'
 $fake=[DblDiagnosticFake002]::new()
 Set-YseduReturnedKeyState $state $fake
 Require ($state.KeyReturnedNonNull -and $state.ManagedKeyType -ceq 'OTHER_UNQUALIFIED') 'ReturnedObjectIsNotLegacyQualification'
 $observed=Read-YseduExplicitProperty $state 'ReadProviderType' $fake 'Value'
 Require ($observed -eq 24 -and $state.Check -ceq 'ReadProviderType') 'CheckedReadReturnsProperty'
 $threw=$false;try{[void](Read-YseduExplicitProperty $state 'ReadExportable' $fake 'Broken')}catch{$threw=$true}
 Require ($threw -and $state.Check -ceq 'ReadExportable') 'ThrowingGetterSetsCodeBeforeEvaluation'
 $threw=$false;try{Assert-YseduDiagnostic $state $false 'NonExportableRequired'}catch{$threw=$true}
 Require ($threw -and $state.Check -ceq 'NonExportableRequired') 'FalsePropertyAssertionSetsDifferentExactCode'
 $bad=[pscustomobject]@{}
 $bad|Add-Member -MemberType ScriptMethod -Name Dispose -Value {throw 'synthetic cleanup secret'}
 $good=[pscustomobject]@{Closed=$false}
 $good|Add-Member -MemberType ScriptMethod -Name Dispose -Value {$this.Closed=$true}
 $primary=[pscustomobject]@{Phase='ExistingPendingKey';FailedCheck='NonExportableRequired'}
 Close-YseduDiagnosticResources $state @(@{Code='ExistingPrivateDispose';Resource=$bad},@{Code='PendingCertificateDispose';Resource=$good},@{Code='NullDispose';Resource=$null})
 Require ($primary.FailedCheck -ceq 'NonExportableRequired' -and $state.Check -ceq 'NonExportableRequired') 'CleanupDoesNotReplacePrimaryCheck'
 Require ($good.Closed -and $state.CleanupFailures.Count -eq 1 -and $state.CleanupFailures[0] -ceq 'ExistingPrivateDispose') 'CleanupContinuesWithSafeSeparateCode'
 $json=$state|ConvertTo-Json -Depth 8
 Require ($json -notmatch 'synthetic cleanup secret|synthetic sensitive error') 'NoRawErrorInDiagnostics'
}
[pscustomobject]@{Decision='EXISTING_KEY_DIAGNOSTIC_SYNTHETIC_TESTS_PASSED';At=(Get-Date -Format o);Checks=@($checks.ToArray());Count=$checks.Count;ExistingPrivateKeyAccessed=$false;NativeKeyCreation=$false;CertificateStoresRead=$false;SqlChanged=$false}|ConvertTo-Json -Depth 6
