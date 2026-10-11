[CmdletBinding()]
param([switch]$CheckOnly)
$ErrorActionPreference='Stop';Set-StrictMode -Version Latest
$task='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010'
$node='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\work\node-v22.23.2-win-x64\node.exe'
$runner=Join-Path $task 'Run-FirstLiveData001.mjs';$child=$null;$secure=$null;$bstr=[IntPtr]::Zero;$plain=$null;$payload=$null;$phase='PublicPins'
function Need([bool]$ok,[string]$code){if(-not $ok){throw [InvalidOperationException]::new($code)}}
try{
 Need ($env:COMPUTERNAME -ceq 'DESKTOP-8QRQT7R' -and $PSVersionTable.PSVersion.ToString() -ceq '7.6.5') 'OwnerHostRuntime'
 foreach($pin in @(@{P=$node;H='0D0F5E39F9F3D9587BC19F73EAB3C2C9C4903FD02D6DBF9C853DD81B3D95FAD4'},@{P=$runner;H='4BAFFF5BE383EE0620C6A58E0A8C55E654279B9FAAE1CA4A91FC9B13E57A142B'},@{P=(Join-Path $task 'FIRST_LIVE_DATA_001_BUILD_PINS.json');H='5002A188956FCF07B3C271ED143C5C007C388075E0A8D4F4920E1E1EDC6E846A'})){Need ((Get-FileHash -LiteralPath $pin.P -Algorithm SHA256).Hash -ceq $pin.H) 'ExecutableOrBuildManifestPin'}
 if($CheckOnly){[pscustomobject]@{Decision='INTERACTIVE_LIVE_WRAPPER_PINS_PASSED';PasswordRequested=$false;SQLConnection=$false}|ConvertTo-Json;return}
 $phase='InteractiveSafety';Need ([Security.Principal.WindowsIdentity]::GetCurrent().Name -ceq 'DESKTOP-8QRQT7R\user' -and -not [Console]::IsInputRedirected -and -not [Console]::IsOutputRedirected) 'OwnerNonRedirectedConsole'
 foreach($hive in 'HKLM','HKCU'){$p=$hive+':\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription';if(Test-Path -LiteralPath $p){$policy=Get-ItemProperty -LiteralPath $p;Need (-not($policy.PSObject.Properties.Name -contains 'EnableTranscripting') -or $policy.EnableTranscripting -ne 1) 'TranscriptionPolicyNotEnabled'}}
 foreach($name in 'NODE_TLS_REJECT_UNAUTHORIZED','NODE_OPTIONS','NODE_EXTRA_CA_CERTS','SSLKEYLOGFILE','DEBUG','DBL_MOTAKAMEL_READER_PASSWORD'){Need (-not [Environment]::GetEnvironmentVariable($name,'Process')) 'NoUnsafeDebugOrSecretEnvironment'}
 foreach($suffix in 'OWNER_PREFLIGHT.json','ATTEMPT.json','RESULT.json','CANONICAL.json','snapshot.sqlite','audit.sqlite'){Need (-not(Test-Path -LiteralPath (Join-Path $task ('FIRST_LIVE_DATA_001_'+$suffix)))) 'NoPriorRunNoOverwriteNoRetry'}
 $phase='FreshOwnerPreflight'; & $node '--dns-result-order=ipv4first' $runner 'owner-preflight';Need ($LASTEXITCODE -eq 0) 'FreshOwnerPreflightPassed'
 $phase='ReaderConfirmation';Need ((Read-Host 'Type READER_READY only if you have the CURRENT DBL_HOST_W11_S2_Reader_20261009 password; not CA/archive/admin password') -ceq 'READER_READY') 'CurrentReaderOwnerConfirmed'
 $phase='HiddenReaderInput';$secure=Read-Host 'Existing SQL Reader password (hidden; never send in chat)' -AsSecureString;Need ($secure.Length -gt 0 -and $secure.Length -le 4096) 'NonemptyBoundedReaderSecret'
 $info=[Diagnostics.ProcessStartInfo]::new($node);$info.UseShellExecute=$false;$info.WorkingDirectory=$task;$info.RedirectStandardInput=$true;$info.RedirectStandardOutput=$false;$info.RedirectStandardError=$false
 foreach($a in '--dns-result-order=ipv4first',$runner,'live'){$info.ArgumentList.Add($a)}
 # Credentials are only in the private child stdin pipe, never argv/env/file/log.
 $phase='SingleLiveChild';$child=[Diagnostics.Process]::new();$child.StartInfo=$info;Need ($child.Start()) 'NodeChildStarted'
 try{$bstr=[Runtime.InteropServices.Marshal]::SecureStringToBSTR($secure);$plain=[Runtime.InteropServices.Marshal]::PtrToStringBSTR($bstr);$payload=@{password=$plain}|ConvertTo-Json -Compress;$child.StandardInput.Write($payload)}finally{$child.StandardInput.Close();$payload=$null;$plain=$null;if($bstr -ne [IntPtr]::Zero){[Runtime.InteropServices.Marshal]::ZeroFreeBSTR($bstr);$bstr=[IntPtr]::Zero};if($null -ne $secure){$secure.Dispose();$secure=$null}}
 if(-not $child.WaitForExit(180000)){[pscustomobject]@{Decision='LIVE_CHILD_TIMEOUT_STOP_NO_KILL';ProcessId=$child.Id;NoRetry=$true;Pending='Do not repeat or stop SQL; retain artifacts and report state'}|ConvertTo-Json;return}
 [pscustomobject]@{Decision='LIVE_CHILD_FINISHED_REVIEW_RESULT_JSON';ExitCode=$child.ExitCode;PasswordPersisted=$false;PasswordInArguments=$false;PasswordInEnvironment=$false;NoAutomaticRetry=$true;MemoryErasureGuarantee=$false}|ConvertTo-Json
}catch{
 [pscustomobject]@{Decision='INTERACTIVE_LIVE_WRAPPER_BLOCKED_STOP';Phase=$phase;SafeGate=if($_.Exception -is [InvalidOperationException] -and $_.Exception.Message -cmatch '\A[A-Za-z][A-Za-z0-9_]{0,80}\z'){$_.Exception.Message}else{'INTERACTIVE_OR_PROCESS_FAILURE'};RawExceptionPublished=$false;NoAutomaticRetry=$true;HostMutation=$false}|ConvertTo-Json
}finally{
 $payload=$null;$plain=$null;if($bstr -ne [IntPtr]::Zero){[Runtime.InteropServices.Marshal]::ZeroFreeBSTR($bstr)};if($null -ne $secure){$secure.Dispose()};if($null -ne $child){$child.Dispose()}
}
