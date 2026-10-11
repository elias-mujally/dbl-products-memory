# Shared-state interactive gate. Reads console/policy readiness only; no keys, secrets or SQL.
function New-YseduInteractiveReadiness002 {
 return [pscustomobject]@{InputRedirected=$null;OutputRedirected=$null;PolicyReads=[Collections.Generic.List[object]]::new();PromptProbe='NOT_REACHED';Passed=$false}
}
function Test-YseduInteractiveSafety002($State,$Readiness,[switch]$PublicPromptProbe) {
 $State.Phase='InteractiveSafety'
 $Readiness.InputRedirected=Invoke-YseduCheckedRead $State 'ReadConsoleInputRedirection' {[Console]::IsInputRedirected}
 $Readiness.OutputRedirected=Invoke-YseduCheckedRead $State 'ReadConsoleOutputRedirection' {[Console]::IsOutputRedirected}
 Assert-YseduDiagnostic $State (-not $Readiness.InputRedirected) 'ConsoleInputNotRedirected'
 Assert-YseduDiagnostic $State (-not $Readiness.OutputRedirected) 'ConsoleOutputNotRedirected'
 foreach($scope in @('HKLM','HKCU')){
  $path=$scope+':\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription'
  $exists=Invoke-YseduCheckedRead $State ('ReadTranscriptionPolicyPresence_'+$scope) {Test-Path -LiteralPath $path -ErrorAction Stop}
  $record=[pscustomobject]@{Scope=$scope;Present=$exists;ReadSucceeded=$false;Enabled=$null}
  $Readiness.PolicyReads.Add($record)
  if($exists){
   $v=Invoke-YseduCheckedRead $State ('ReadTranscriptionPolicy_'+$scope) {Get-ItemProperty -LiteralPath $path -ErrorAction Stop}
   $record.Enabled=($v.PSObject.Properties.Name -contains 'EnableTranscripting' -and $v.EnableTranscripting -eq 1)
  }else{$record.Enabled=$false}
  $record.ReadSucceeded=$true
  Assert-YseduDiagnostic $State (-not $record.Enabled) ('AutomaticTranscriptionDisabled_'+$scope)
 }
 if($PublicPromptProbe){
  $Readiness.PromptProbe='READ_ATTEMPTED'
  $answer=Invoke-YseduCheckedRead $State 'ReadPublicPromptProbe' {Read-Host 'DIAGNOSTIC ONLY: type DBL_INTERACTIVE_OK (never any password)'}
  $matches=($answer -ceq 'DBL_INTERACTIVE_OK');$answer=$null
  $Readiness.PromptProbe=if($matches){'CONFIRMED'}else{'TOKEN_NOT_CONFIRMED'}
  Assert-YseduDiagnostic $State $matches 'PublicPromptTokenConfirmed'
 }
 $Readiness.Passed=$true
}
