[CmdletBinding()]
param([switch]$CheckOnly)
# Same visible encoded-command launch path as failed signing console; diagnostics only.
$ErrorActionPreference='Stop'
$runtime=Join-Path 'C:\Users\user' '.cache\codex-runtimes\codex-primary-runtime\dependencies\native\powershell\pwsh.exe'
$p='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010\Read-YseduInteractiveGate002.ps1'
if($env:COMPUTERNAME -cne 'DESKTOP-8QRQT7R' -or (Get-FileHash -LiteralPath $runtime -Algorithm SHA256).Hash -cne '362A356CE7F0940EC74F73A8FC2C990A2CC24A38A11C90BBD8ECA947110AD139' -or [string](Get-AuthenticodeSignature -LiteralPath $runtime).Status -cne 'Valid'){throw 'STOP: runtime/host identity'}
if((Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash -cne '2829D7160CCBBBE086F696ABE939FD2DD332AFA211654970FCD731BEC6A09F33'){throw 'STOP: diagnostic helper pin'}
$code=@'
& { $p='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010\Read-YseduInteractiveGate002.ps1'; if ((Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash -cne '2829D7160CCBBBE086F696ABE939FD2DD332AFA211654970FCD731BEC6A09F33') { throw 'STOP: diagnostic helper pin' }; & ([scriptblock]::Create((Get-Content -LiteralPath $p -Raw))) }
[void](Read-Host 'DIAGNOSTIC FINISHED: return final JSON/error only. Never enter/send any password. Do not retry. Press Enter to close.')
'@
$encoded=[Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($code))
if([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String($encoded)) -cne $code){throw 'STOP: public command encoding'}
if($CheckOnly){[pscustomobject]@{Decision='INTERACTIVE_GATE_002_LAUNCHER_PINS_PASSED';ChildLaunched=$false;PasswordRequested=$false;SigningAttempted=$false}|ConvertTo-Json;return}
$child=Start-Process -FilePath $runtime -ArgumentList @('-NoProfile','-EncodedCommand',$encoded) -WindowStyle Normal -PassThru
try{[pscustomobject]@{Decision='INTERACTIVE_GATE_002_CONSOLE_STARTED_RESULT_PENDING';ProcessId=$child.Id;Next='Public diagnostic token only if safe; final child JSON/error. No password, CA or signing.'}|ConvertTo-Json}finally{$child.Dispose()}
