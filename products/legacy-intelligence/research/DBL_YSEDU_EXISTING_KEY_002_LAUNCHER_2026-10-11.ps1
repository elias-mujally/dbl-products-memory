[CmdletBinding()]
param([switch]$CheckOnly)
# Visible operator console, inherited existing administrator token; no RunAs or secret arguments.
$ErrorActionPreference='Stop'
$runtime=Join-Path 'C:\Users\user' '.cache\codex-runtimes\codex-primary-runtime\dependencies\native\powershell\pwsh.exe'
if($env:COMPUTERNAME -cne 'DESKTOP-8QRQT7R' -or (Get-FileHash -LiteralPath $runtime -Algorithm SHA256).Hash -cne '362A356CE7F0940EC74F73A8FC2C990A2CC24A38A11C90BBD8ECA947110AD139' -or [string](Get-AuthenticodeSignature -LiteralPath $runtime).Status -cne 'Valid'){throw 'STOP: runtime or host identity'}
$p='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010\Qualify-YseduExistingKey002.ps1'
if((Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash -cne '265A32E1BFC4707F5F30C3F63560D4A77E2D476CCBFE1721935FDDE682D60679'){throw 'STOP: resume helper pin'}
$code=@'
& { $p='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010\Qualify-YseduExistingKey002.ps1'; if ((Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash -cne '265A32E1BFC4707F5F30C3F63560D4A77E2D476CCBFE1721935FDDE682D60679') { throw 'STOP: resume helper pin' }; & ([scriptblock]::Create((Get-Content -LiteralPath $p -Raw))) }
[void](Read-Host 'Finished. Return final sanitized JSON/error only; press Enter to close. Do not retry.')
'@
$encoded=[Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($code))
if([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String($encoded)) -cne $code){throw 'STOP: public command encoding'}
$principal=[Security.Principal.WindowsPrincipal]::new([Security.Principal.WindowsIdentity]::GetCurrent());$elevated=$principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if($CheckOnly){[pscustomobject]@{Decision='EXISTING_KEY_002_LAUNCHER_PINS_PASSED';Elevated=$elevated;ChildLaunched=$false;PrivateKeyOpened=$false;NativeKeyCreation=$false}|ConvertTo-Json;return}
if(-not $elevated){throw 'STOP: manually open Windows PowerShell as administrator; no automatic elevation'}
$child=Start-Process -FilePath $runtime -ArgumentList @('-NoProfile','-EncodedCommand',$encoded) -WindowStyle Normal -PassThru
try{[pscustomobject]@{Decision='EXISTING_KEY_002_CONSOLE_STARTED_RESULT_PENDING';ProcessId=$child.Id;Next='Final child JSON/error only; no key creation, CA signing, certificate acceptance or SQL stop'}|ConvertTo-Json}finally{$child.Dispose()}
