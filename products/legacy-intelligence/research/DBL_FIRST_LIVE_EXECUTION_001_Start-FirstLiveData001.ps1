[CmdletBinding()]
param([switch]$CheckOnly)
$ErrorActionPreference='Stop';Set-StrictMode -Version Latest
$task='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010'
$ps=Join-Path 'C:\Users\user' '.cache\codex-runtimes\codex-primary-runtime\dependencies\native\powershell\pwsh.exe'
$helper=Join-Path $task 'Invoke-FirstLiveDataInteractive001.ps1'
if($env:COMPUTERNAME -cne 'DESKTOP-8QRQT7R' -or (Get-FileHash -LiteralPath $ps).Hash -cne '362A356CE7F0940EC74F73A8FC2C990A2CC24A38A11C90BBD8ECA947110AD139' -or [string](Get-AuthenticodeSignature -LiteralPath $ps).Status -cne 'Valid' -or (Get-FileHash -LiteralPath $helper).Hash -cne 'A956DC9ADED8EDFCC33CAD46AA8F1EBC2434A741A6B098EE53F473F40BA854AB'){throw 'STOP: launcher pin'}
$code=@'
& {
 $p='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010\Invoke-FirstLiveDataInteractive001.ps1'
 if((Get-FileHash -LiteralPath $p).Hash -cne 'A956DC9ADED8EDFCC33CAD46AA8F1EBC2434A741A6B098EE53F473F40BA854AB'){throw 'STOP: helper pin'}
 & $p
}
[void](Read-Host 'Return final safe JSON only. Never send password or retry. Press Enter to close.')
'@
$tokens=$null;$errors=$null;[void][Management.Automation.Language.Parser]::ParseInput($code,[ref]$tokens,[ref]$errors);if($errors.Count){throw 'STOP: child parse'}
if($CheckOnly){[pscustomobject]@{Decision='LIVE_LAUNCHER_PINS_PARSE_PASSED';ChildLaunched=$false;PasswordRequested=$false;SQLConnection=$false}|ConvertTo-Json;return}
if([Security.Principal.WindowsIdentity]::GetCurrent().Name -cne 'DESKTOP-8QRQT7R\user'){throw 'STOP: owner interactive identity required; no impersonation/elevation'}
foreach($n in 'OWNER_PREFLIGHT.json','ATTEMPT.json','RESULT.json','snapshot.sqlite','audit.sqlite','CANONICAL.json'){if(Test-Path -LiteralPath (Join-Path $task ('FIRST_LIVE_DATA_001_'+$n))){throw 'STOP: existing run artifact; no retry'}}
$encoded=[Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($code));$child=Start-Process -FilePath $ps -ArgumentList @('-NoProfile','-EncodedCommand',$encoded) -WindowStyle Normal -PassThru
try{[pscustomobject]@{Decision='OWNER_READER_CONSOLE_STARTED_LIVE_RESULT_PENDING';ProcessId=$child.Id;SecretInArguments=$false;AdminRequired=$false;NoAutomaticElevation=$true}|ConvertTo-Json}finally{$child.Dispose()}
