[CmdletBinding()]
param([switch]$CheckOnly)
# Interactive owner password console only. No auto-elevation, secrets in arguments or service changes.
$ErrorActionPreference='Stop'
$runtime=Join-Path 'C:\Users\user' '.cache\codex-runtimes\codex-primary-runtime\dependencies\native\powershell\pwsh.exe'
$p='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010\Invoke-YseduLeafSigning001.ps1'
if($env:COMPUTERNAME -cne 'DESKTOP-8QRQT7R' -or (Get-FileHash -LiteralPath $runtime -Algorithm SHA256).Hash -cne '362A356CE7F0940EC74F73A8FC2C990A2CC24A38A11C90BBD8ECA947110AD139' -or [string](Get-AuthenticodeSignature -LiteralPath $runtime).Status -cne 'Valid'){throw 'STOP: runtime/host identity'}
if((Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash -cne '8C1A2C960F6D93DEDE95841E6508D97BA929904B320C416B32C97E2C4A325484'){throw 'STOP: signing helper pin'}
$code=@'
& { $p='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010\Invoke-YseduLeafSigning001.ps1'; if ((Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash -cne '8C1A2C960F6D93DEDE95841E6508D97BA929904B320C416B32C97E2C4A325484') { throw 'STOP: signing helper pin' }; & ([scriptblock]::Create((Get-Content -LiteralPath $p -Raw))) }
[void](Read-Host 'Finished. Return final sanitized JSON/error only. Do not retry or send password/private files. Press Enter to close.')
'@
$encoded=[Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($code))
if([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String($encoded)) -cne $code){throw 'STOP: public command encoding'}
if($CheckOnly){[pscustomobject]@{Decision='YSEDU_LEAF_SIGNING_LAUNCHER_PINS_PASSED';ChildLaunched=$false;CAUnlocked=$false;LeafIssued=$false;SqlChanged=$false}|ConvertTo-Json;return}
$child=Start-Process -FilePath $runtime -ArgumentList @('-NoProfile','-EncodedCommand',$encoded) -WindowStyle Normal -PassThru
try{[pscustomobject]@{Decision='YSEDU_LEAF_SIGNING_CONSOLE_STARTED_RESULT_PENDING';ProcessId=$child.Id;Next='Existing CA password hidden in child console; final child JSON/error only. No server store acceptance or SQL/network operation.'}|ConvertTo-Json}finally{$child.Dispose()}
