[CmdletBinding()]
param([switch]$CheckOnly)
$ErrorActionPreference='Stop'
$runtime=Join-Path 'C:\Users\user' '.cache\codex-runtimes\codex-primary-runtime\dependencies\native\powershell\pwsh.exe'
$p='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010\Read-YseduActivationReadiness001.ps1'
if($env:COMPUTERNAME -cne 'DESKTOP-8QRQT7R' -or (Get-FileHash -LiteralPath $runtime -Algorithm SHA256).Hash -cne '362A356CE7F0940EC74F73A8FC2C990A2CC24A38A11C90BBD8ECA947110AD139' -or [string](Get-AuthenticodeSignature -LiteralPath $runtime).Status -cne 'Valid'){throw 'STOP: runtime/host identity'}
if((Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash -cne '1D5F4407B3EDF64D1A44427F14F91CAD3661216D9593CD49A3E9AC83072C68A5'){throw 'STOP: readiness helper pin'}
$code=@'
& { $p='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010\Read-YseduActivationReadiness001.ps1'; if ((Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash -cne '1D5F4407B3EDF64D1A44427F14F91CAD3661216D9593CD49A3E9AC83072C68A5') { throw 'STOP: readiness helper pin' }; & ([scriptblock]::Create((Get-Content -LiteralPath $p -Raw))) }
[void](Read-Host 'Finished. Return sanitized final JSON/error only. No password needed. Do not retry. Press Enter to close.')
'@
$encoded=[Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($code));$t=$null;$e=$null
[void][Management.Automation.Language.Parser]::ParseInput($code,[ref]$t,[ref]$e)
if($e.Count -or [Text.Encoding]::Unicode.GetString([Convert]::FromBase64String($encoded)) -cne $code){throw 'STOP: public child command'}
if($CheckOnly){[pscustomobject]@{Decision='ACTIVATION_READINESS_LAUNCHER_PINS_PARSE_PASSED';ChildLaunched=$false;HostChanged=$false}|ConvertTo-Json;return}
$who=[Security.Principal.WindowsPrincipal]::new([Security.Principal.WindowsIdentity]::GetCurrent())
if(-not $who.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)){throw 'STOP: manually opened administrative token required; no automatic elevation'}
$child=Start-Process -FilePath $runtime -ArgumentList @('-NoProfile','-EncodedCommand',$encoded) -WindowStyle Normal -PassThru
try{[pscustomobject]@{Decision='ACTIVATION_READONLY_CONSOLE_STARTED_RESULT_PENDING';ProcessId=$child.Id;Next='Read-only administrative readiness only. No password, signing, acceptance, ACL or service/network change.'}|ConvertTo-Json}finally{$child.Dispose()}
