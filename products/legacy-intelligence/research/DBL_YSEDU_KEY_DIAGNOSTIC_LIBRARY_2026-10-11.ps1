# Shared mutable state; no mixed script/invocation variable scopes. No native APIs.
Set-StrictMode -Version Latest
function New-YseduDiagnosticState {
 return [pscustomobject]@{Phase='Identity';Check='HostRuntime';OpenAttempted=$false;KeyReturnedNonNull=$false;ManagedKeyType=$null;ProviderType=$null;ProviderName=$null;KeySpec=$null;MachineKeySet=$null;Exportable=$null;RSAKeyBits=$null;ChallengePassed=$false;CleanupFailures=[Collections.Generic.List[string]]::new()}
}
function Invoke-YseduCheckedRead($State,[string]$Code,[scriptblock]$Read) {
 $State.Check=$Code
 & $Read
}
function Read-YseduExplicitProperty($State,[string]$Code,$Instance,[string]$Property) {
 $State.Check=$Code
 if($null -eq $Instance){throw 'STOP: property instance missing'}
 $member=$Instance.GetType().GetProperty($Property,[Reflection.BindingFlags]'Public,Instance')
 if($null -eq $member -or -not $member.CanRead){throw 'STOP: property getter unavailable'}
 # Reflection invocation propagates getter failure, unlike PowerShell adapted access.
 return $member.GetValue($Instance)
}
function Assert-YseduDiagnostic($State,[bool]$Condition,[string]$Code) {
 $State.Check=$Code
 if(-not $Condition){throw ('STOP: '+$Code)}
}
function Set-YseduReturnedKeyState($State,$Key) {
 $State.KeyReturnedNonNull=($null -ne $Key)
 if($null -eq $Key){$State.ManagedKeyType='NULL';return}
 if($Key -is [Security.Cryptography.RSACryptoServiceProvider]){$State.ManagedKeyType='RSACryptoServiceProvider'}
 elseif($Key -is [Security.Cryptography.RSACng]){$State.ManagedKeyType='RSACng'}
 else{$State.ManagedKeyType='OTHER_UNQUALIFIED'}
}
function Close-YseduDiagnosticResources($State,$Resources) {
 foreach($entry in $Resources){
  if($null -ne $entry.Resource){try{$entry.Resource.Dispose()}catch{[void]$State.CleanupFailures.Add($entry.Code)}}
 }
}
