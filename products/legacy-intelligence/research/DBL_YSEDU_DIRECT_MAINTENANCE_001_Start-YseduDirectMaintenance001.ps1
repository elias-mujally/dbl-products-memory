[CmdletBinding()]
param([switch]$CheckOnly)
$ErrorActionPreference='Stop'
$runtime=Join-Path 'C:\Users\user' '.cache\codex-runtimes\codex-primary-runtime\dependencies\native\powershell\pwsh.exe'
$p='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010\Invoke-YseduDirectMaintenance001.ps1'
if($env:COMPUTERNAME -cne 'DESKTOP-8QRQT7R' -or
 (Get-FileHash -LiteralPath $runtime -Algorithm SHA256).Hash -cne '362A356CE7F0940EC74F73A8FC2C990A2CC24A38A11C90BBD8ECA947110AD139' -or
 [string](Get-AuthenticodeSignature -LiteralPath $runtime).Status -cne 'Valid' -or
 (Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash -cne 'AF849B3844CF34E8F0C16F76DD6B0440CE7E056368DC604CD86F62B8DEAD7771'){throw 'STOP: host/runtime/helper pins'}
$code=@'
& { $p='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010\Invoke-YseduDirectMaintenance001.ps1'; if ((Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash -cne 'AF849B3844CF34E8F0C16F76DD6B0440CE7E056368DC604CD86F62B8DEAD7771') { throw 'STOP: maintenance helper pin' }; & ([scriptblock]::Create((Get-Content -LiteralPath $p -Raw))) -MaintenanceAuthorized }
[void](Read-Host 'Finished. Return final non-sensitive JSON/error. No passwords; never retry or start/stop SQL manually. Press Enter to close.')
'@
$tokens=$null;$errors=$null
[void][Management.Automation.Language.Parser]::ParseInput($code,[ref]$tokens,[ref]$errors)
if($errors.Count){throw 'STOP: public child command parse'}
if($CheckOnly){[pscustomobject]@{Decision='DIRECT_MAINTENANCE_LAUNCHER_PINS_PARSE_PASSED';ChildLaunched=$false;SqlStopped=$false;HostChanged=$false}|ConvertTo-Json;return}
$principal=[Security.Principal.WindowsPrincipal]::new([Security.Principal.WindowsIdentity]::GetCurrent())
if(-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)){throw 'STOP: manually opened administrator token required; no automatic elevation'}
$encoded=[Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($code))
$child=Start-Process -FilePath $runtime -ArgumentList @('-NoProfile','-EncodedCommand',$encoded) -WindowStyle Normal -PassThru
try{[pscustomobject]@{Decision='YSEDU_DIRECT_MAINTENANCE_CONSOLE_STARTED_RESULT_PENDING';ProcessId=$child.Id;NotMaintenanceSuccess=$true}|ConvertTo-Json}finally{$child.Dispose()}
