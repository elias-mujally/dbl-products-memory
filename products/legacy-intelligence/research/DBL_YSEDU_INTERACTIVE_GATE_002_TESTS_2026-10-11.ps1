$ErrorActionPreference='Stop';Set-StrictMode -Version Latest
. (Join-Path $PSScriptRoot 'ExistingKeyDiagnostics002.ps1')
. (Join-Path $PSScriptRoot 'YseduInteractiveSafety002.ps1')
# Mock only console/policy/prompt reads. No real prompt, registry, stores, CA or secrets.
function Invoke-YseduCheckedRead($State,[string]$Code,[scriptblock]$Read){
 $State.Check=$Code
 if($Code -ceq $testCase.ThrowAt){throw 'SYNTHETIC_READ_FAILURE'}
 switch($Code){
  'ReadConsoleInputRedirection' {return $testCase.Input}
  'ReadConsoleOutputRedirection' {return $testCase.Output}
  'ReadTranscriptionPolicyPresence_HKLM' {return $testCase.MachinePresent}
  'ReadTranscriptionPolicyPresence_HKCU' {return $testCase.UserPresent}
  'ReadTranscriptionPolicy_HKLM' {return [pscustomobject]@{EnableTranscripting=[int]$testCase.MachineEnabled}}
  'ReadTranscriptionPolicy_HKCU' {return [pscustomobject]@{EnableTranscripting=[int]$testCase.UserEnabled}}
  'ReadPublicPromptProbe' {return $testCase.Token}
  default {throw 'Unexpected mock read'}
 }
}
$names=[Collections.Generic.List[string]]::new()
foreach($case in @(
 @{Name='InputRedirect';Input=$true;Expected='ConsoleInputNotRedirected'},
 @{Name='OutputRedirect';Output=$true;Expected='ConsoleOutputNotRedirected'},
 @{Name='MachinePresenceFailure';ThrowAt='ReadTranscriptionPolicyPresence_HKLM';Expected='ReadTranscriptionPolicyPresence_HKLM'},
 @{Name='MachinePolicyReadFailure';MachinePresent=$true;ThrowAt='ReadTranscriptionPolicy_HKLM';Expected='ReadTranscriptionPolicy_HKLM'},
 @{Name='MachineTranscriptionEnabled';MachinePresent=$true;MachineEnabled=$true;Expected='AutomaticTranscriptionDisabled_HKLM'},
 @{Name='UserPresenceFailure';ThrowAt='ReadTranscriptionPolicyPresence_HKCU';Expected='ReadTranscriptionPolicyPresence_HKCU'},
 @{Name='UserPolicyReadFailure';UserPresent=$true;ThrowAt='ReadTranscriptionPolicy_HKCU';Expected='ReadTranscriptionPolicy_HKCU'},
 @{Name='UserTranscriptionEnabled';UserPresent=$true;UserEnabled=$true;Expected='AutomaticTranscriptionDisabled_HKCU'},
 @{Name='PromptReadFailure';ThrowAt='ReadPublicPromptProbe';Expected='ReadPublicPromptProbe'},
 @{Name='PromptWrongPublicToken';Token='WRONG_PUBLIC_TOKEN';Expected='PublicPromptTokenConfirmed'},
 @{Name='PassingPublicPrompt';Expected='PASS'}
)){
 $testCase=@{Input=$false;Output=$false;MachinePresent=$false;UserPresent=$false;MachineEnabled=$false;UserEnabled=$false;Token='DBL_INTERACTIVE_OK';ThrowAt=$null}
 foreach($p in $case.GetEnumerator()){$testCase[$p.Key]=$p.Value}
 $state=New-YseduDiagnosticState;$state.Check='FiveStoresReadOnly';$readiness=New-YseduInteractiveReadiness002;$caught=$false
 & ([scriptblock]::Create('param($state,$readiness);try{Test-YseduInteractiveSafety002 $state $readiness -PublicPromptProbe}catch{$script:testCaught=$true}')) $state $readiness
 $caught=($script:testCaught -eq $true);$script:testCaught=$false
 if($case.Expected -ceq 'PASS'){if(-not $readiness.Passed -or $caught -or $state.Check -cne 'PublicPromptTokenConfirmed'){throw 'Positive guard/state failure'}}
 elseif(-not $caught -or $readiness.Passed -or $state.Check -cne $case.Expected){throw ('Negative guard/state failure: '+$case.Name)}
 $names.Add($case.Name)
}
$corrected=Get-Content -LiteralPath (Join-Path $PSScriptRoot 'Invoke-YseduLeafSigning002-Corrected.ps1') -Raw
if($corrected -match '\$script:check' -or $corrected -notmatch "SigningRequiresSeparateOwnerApproval"){throw 'Corrected shared-state/authorization invariant'}
foreach($name in @('Invoke-YseduLeafSigning002-Corrected.ps1','Read-YseduInteractiveGate002.ps1','YseduInteractiveSafety002.ps1')){
 $tokens=$null;$errors=$null;[void][Management.Automation.Language.Parser]::ParseFile((Join-Path $PSScriptRoot $name),[ref]$tokens,[ref]$errors)
 if($errors.Count -gt 0){throw 'Parser error'}
}
[pscustomobject]@{Decision='INTERACTIVE_GATE_002_SHARED_STATE_TESTS_PASSED';At=(Get-Date -Format o);Cases=$names.Count;Names=$names.ToArray();ChildScriptBlockScopeTested=$true;ActualConsoleRead=$false;RegistryRead=$false;PasswordRequested=$false;CAUnlocked=$false;SigningAttempted=$false;SqlChanged=$false}|ConvertTo-Json -Depth 6
