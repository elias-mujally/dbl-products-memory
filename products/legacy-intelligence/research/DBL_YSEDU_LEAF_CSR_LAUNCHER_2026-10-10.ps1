[CmdletBinding()]
param([switch]$CheckOnly)
# Public launcher only. Manual administrative parent token is inherited; no RunAs/UAC bypass.
$ErrorActionPreference='Stop'
$runtime=Join-Path 'C:\Users\user' '.cache\codex-runtimes\codex-primary-runtime\dependencies\native\powershell\pwsh.exe'
if($env:COMPUTERNAME -cne 'DESKTOP-8QRQT7R' -or (Get-FileHash -LiteralPath $runtime -Algorithm SHA256).Hash -cne '362A356CE7F0940EC74F73A8FC2C990A2CC24A38A11C90BBD8ECA947110AD139' -or [string](Get-AuthenticodeSignature -LiteralPath $runtime).Status -cne 'Valid'){throw 'STOP: runtime/host identity'}
$p='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010\Invoke-YseduLeafCsr001.ps1'
if((Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash -cne 'D5C1F979DDA81AAE7868346F5715158BA20516AA6732EE28B6003EBC8DB48451'){throw 'STOP: helper hash mismatch'}
$publicCode=@'
& {
 $p='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010\Invoke-YseduLeafCsr001.ps1'
 if((Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash -cne 'D5C1F979DDA81AAE7868346F5715158BA20516AA6732EE28B6003EBC8DB48451'){throw 'STOP: helper hash mismatch'}
 & ([scriptblock]::Create((Get-Content -LiteralPath $p -Raw)))
}
[void](Read-Host 'Finished. Return sanitized JSON only; press Enter to close')
'@
$encoded=[Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($publicCode))
if([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String($encoded)) -cne $publicCode){throw 'STOP: public launcher encoding'}
$who=[Security.Principal.WindowsPrincipal]::new([Security.Principal.WindowsIdentity]::GetCurrent())
$elevated=$who.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if($CheckOnly){[pscustomobject]@{Decision='YSEDU_CSR_LAUNCHER_PATH_AND_PINS_PASSED';Elevated=$elevated;Runtime=$runtime;ChildLaunched=$false;MachineKeyCreated=$false}|ConvertTo-Json;return}
if(-not $elevated){throw 'STOP: open Windows PowerShell manually as administrator first; no automatic elevation'}
$child=Start-Process -FilePath $runtime -ArgumentList @('-NoProfile','-EncodedCommand',$encoded) -WindowStyle Normal -PassThru
[pscustomobject]@{Decision='YSEDU_CSR_CONSOLE_STARTED_RESULT_PENDING';ProcessId=$child.Id;InheritedAdministrativeParent=$true;KeySuccess='NOT_ASSERTED';Next='Return final child JSON/error only, not this launch status; no automatic retry'}|ConvertTo-Json
