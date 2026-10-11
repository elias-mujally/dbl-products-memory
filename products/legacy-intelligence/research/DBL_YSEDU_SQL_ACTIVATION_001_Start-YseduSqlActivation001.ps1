[CmdletBinding()]
param([switch]$CheckOnly)
$ErrorActionPreference='Stop';Set-StrictMode -Version Latest
$root='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010'
$runtime=Join-Path 'C:\Users\user' '.cache\codex-runtimes\codex-primary-runtime\dependencies\native\powershell\pwsh.exe'
$helper=Join-Path $root 'Invoke-YseduSqlActivation001.ps1'
if($env:COMPUTERNAME -cne 'DESKTOP-8QRQT7R' -or
 (Get-FileHash -LiteralPath $runtime -Algorithm SHA256).Hash -cne '362A356CE7F0940EC74F73A8FC2C990A2CC24A38A11C90BBD8ECA947110AD139' -or
 [string](Get-AuthenticodeSignature -LiteralPath $runtime).Status -cne 'Valid' -or
 (Get-FileHash -LiteralPath $helper -Algorithm SHA256).Hash -cne '9B6C1AFD4E7F6F6ECF7232D726EEEE4B6BEA46F2803AA04A79AB9D0AE1237DCF') {throw 'STOP: host/runtime/helper pin'}
$code=@'
& {
 $ErrorActionPreference='Stop'
 $p='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010\Invoke-YseduSqlActivation001.ps1'
 if((Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash -cne '9B6C1AFD4E7F6F6ECF7232D726EEEE4B6BEA46F2803AA04A79AB9D0AE1237DCF'){throw 'STOP: helper pin'}
 & $p -MaintenanceAuthorized
}
[void](Read-Host 'Return final JSON/error only. No password; no retry or manual SQL stop/start. Press Enter to close.')
'@
$tokens=$null;$errors=$null;[void][Management.Automation.Language.Parser]::ParseInput($code,[ref]$tokens,[ref]$errors)
if($errors.Count){throw 'STOP: child parse'}
if($CheckOnly){[pscustomobject]@{Decision='SQL_ACTIVATION_LAUNCHER_PINS_PARSE_PASSED';ChildLaunched=$false;ServiceCalls=0;HostMutation=$false}|ConvertTo-Json;return}
$identity=[Security.Principal.WindowsIdentity]::GetCurrent()
try{if($identity.Name -cne 'DESKTOP-8QRQT7R\user' -or -not ([Security.Principal.WindowsPrincipal]::new($identity)).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)){throw 'STOP: manually opened owner administrator console required; no automatic elevation'}}finally{$identity.Dispose()}
foreach($name in 'YSEDU_SQL_ACTIVATION_001_BEFORE.json','YSEDU_SQL_ACTIVATION_001_ATTEMPT.json','YSEDU_SQL_ACTIVATION_001_START_ATTEMPT.json','YSEDU_SQL_ACTIVATION_001_RESULT.json'){if(Test-Path -LiteralPath (Join-Path $root $name)){throw 'STOP: prior activation evidence exists; do not repeat'}}
foreach($i in 0..3){if(Test-Path -LiteralPath (Join-Path $root ('YSEDU_SQL_ACTIVATION_001_WRITE_'+$i+'.json'))){throw 'STOP: existing owned-write evidence; do not repeat'}}
$encoded=[Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($code))
$child=Start-Process -FilePath $runtime -ArgumentList @('-NoProfile','-EncodedCommand',$encoded) -WindowStyle Normal -PassThru
try{[pscustomobject]@{Decision='SQL_ACTIVATION_CONSOLE_STARTED_RESULT_PENDING';ProcessId=$child.Id;NoAutomaticElevation=$true;PasswordRequired=$false;MaintenanceNotYetProven=$true}|ConvertTo-Json}finally{$child.Dispose()}
