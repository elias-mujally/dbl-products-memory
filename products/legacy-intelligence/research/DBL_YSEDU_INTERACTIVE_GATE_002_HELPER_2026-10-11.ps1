[CmdletBinding()]
param([switch]$CheckOnly)
# OWNER APPROVED diagnostic only: no CA/PFX/certificates/password/private-key access or signing.
$ErrorActionPreference='Stop';Set-StrictMode -Version Latest
$root='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010'
$diag=Join-Path $root 'ExistingKeyDiagnostics002.ps1'
$safety=Join-Path $root 'YseduInteractiveSafety002.ps1'
if((Get-FileHash -LiteralPath $diag -Algorithm SHA256).Hash -cne '980064A9487C97F9F8E51F3F8CD7D0B27C308F109A53904316D6057072939BF9'){throw 'STOP: diagnostic library pin'}
if((Get-FileHash -LiteralPath $safety -Algorithm SHA256).Hash -cne '88F858C7B854592A5201F06321BEDBA300CB2A3FA5824BD9E23DEFCD23D62D48'){throw 'STOP: safety library pin'}
. $diag;. $safety
$state=New-YseduDiagnosticState;$readiness=New-YseduInteractiveReadiness002
$marker=Join-Path $root 'YSEDU_INTERACTIVE_GATE_002_ATTEMPT.json'
$output=Join-Path $root 'YSEDU_INTERACTIVE_GATE_002_RESULT.json'
$consumed=$false;$result=$null
function Write-GateNew([string]$Path,[object]$Value){
 $bytes=[Text.Encoding]::UTF8.GetBytes(($Value|ConvertTo-Json -Depth 8))
 $stream=[IO.File]::Open($Path,[IO.FileMode]::CreateNew,[IO.FileAccess]::Write,[IO.FileShare]::None)
 try{$stream.Write($bytes,0,$bytes.Length);$stream.Flush($true)}finally{$stream.Dispose()}
}
try{
 Assert-YseduDiagnostic $state ($env:COMPUTERNAME -ceq 'DESKTOP-8QRQT7R' -and $PSVersionTable.PSVersion.ToString() -ceq '7.6.5') 'HostRuntime'
 Assert-YseduDiagnostic $state ((Get-FileHash -LiteralPath "$PSHOME\pwsh.exe" -Algorithm SHA256).Hash -ceq '362A356CE7F0940EC74F73A8FC2C990A2CC24A38A11C90BBD8ECA947110AD139') 'RuntimePin'
 Assert-YseduDiagnostic $state (-not(Test-Path -LiteralPath $marker) -and -not(Test-Path -LiteralPath $output)) 'FreshDiagnosticNoOverwrite'
 if($CheckOnly){[pscustomobject]@{Decision='INTERACTIVE_GATE_002_PINS_PASSED';ActualConsoleProbe=$false;AttemptConsumed=$false;PasswordRequested=$false;CAUnlocked=$false;SigningAttempted=$false}|ConvertTo-Json;return}
 $state.Check='CreateNewDiagnosticMarker'
 Write-GateNew $marker ([pscustomobject]@{Task='INTERACTIVE_GATE_002_DIAGNOSTIC_ONLY';At=(Get-Date -Format o);PasswordRequested=$false;SigningAttempted=$false})
 $consumed=$true
 Test-YseduInteractiveSafety002 $state $readiness -PublicPromptProbe
 $result=[pscustomobject]@{Decision='INTERACTIVE_GATE_002_PASSED';ObservedAt=(Get-Date -Format o);Phase=$state.Phase;LastCheck=$state.Check;Readiness=$readiness;PasswordRequested=$false;CAUnlocked=$false;SigningAttempted=$false;SqlChanged=$false;NoAutomaticSigning=$true}
}catch{
 $result=[pscustomobject]@{Decision='INTERACTIVE_GATE_002_BLOCKED_STOP';ObservedAt=(Get-Date -Format o);Phase=$state.Phase;FailedCheck=$state.Check;ExceptionType=$_.Exception.GetType().FullName;Readiness=$readiness;AttemptConsumed=$consumed;PasswordRequested=$false;CAUnlocked=$false;SigningAttempted=$false;SqlChanged=$false;NoAutomaticRetry=$true}
}
if($consumed){try{Write-GateNew $output $result}catch{$result|ConvertTo-Json -Depth 8;[pscustomobject]@{Decision='INTERACTIVE_GATE_RESULT_WRITE_BLOCKED_STOP';NoAutomaticRetry=$true}|ConvertTo-Json;return}}
$result|ConvertTo-Json -Depth 8
