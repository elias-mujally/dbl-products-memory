[CmdletBinding()]
param([switch]$CheckOnly)
$ErrorActionPreference='Stop'
$root='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010'
$runtime=Join-Path 'C:\Users\user' '.cache\codex-runtimes\codex-primary-runtime\dependencies\native\powershell\pwsh.exe'
$helper=Join-Path $root 'Invoke-MachineRootRemedy001.ps1'
if($env:COMPUTERNAME -cne 'DESKTOP-8QRQT7R' -or
 (Get-FileHash -LiteralPath $runtime -Algorithm SHA256).Hash -cne '362A356CE7F0940EC74F73A8FC2C990A2CC24A38A11C90BBD8ECA947110AD139' -or
 [string](Get-AuthenticodeSignature -LiteralPath $runtime).Status -cne 'Valid' -or
 (Get-FileHash -LiteralPath $helper -Algorithm SHA256).Hash -cne '92269382E7B96C3CBFB7D9C681FE6FD11474A584A73709FF4573BF0B91A2E3AD') {throw 'STOP: host/runtime/helper pin'}
$code=@'
& {
 $ErrorActionPreference='Stop'
 $root='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010'
 $p=Join-Path $root 'Invoke-MachineRootRemedy001.ps1'
 if((Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash -cne '92269382E7B96C3CBFB7D9C681FE6FD11474A584A73709FF4573BF0B91A2E3AD'){throw 'STOP: helper pin'}
 & $p
}
[void](Read-Host 'Return final JSON/error only. No password. Do not retry. SQL was not stopped. Press Enter to close.')
'@
$tokens=$null;$errors=$null
[void][Management.Automation.Language.Parser]::ParseInput($code,[ref]$tokens,[ref]$errors)
if($errors.Count){throw 'STOP: child parse'}
if($CheckOnly){[pscustomobject]@{Decision='MACHINE_ROOT_LAUNCHER_PINS_PARSE_PASSED';ChildLaunched=$false;RootChanged=$false;SQLStopped=$false}|ConvertTo-Json;return}
$identity=[Security.Principal.WindowsIdentity]::GetCurrent()
try{if($identity.Name -cne 'DESKTOP-8QRQT7R\user' -or -not ([Security.Principal.WindowsPrincipal]::new($identity)).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)){throw 'STOP: owner must manually open administrator console; no automatic elevation'}}finally{$identity.Dispose()}
foreach($name in 'MACHINE_ROOT_REMEDY_001_BEFORE.json','MACHINE_ROOT_REMEDY_001_ATTEMPT.json','MACHINE_ROOT_REMEDY_001_RESULT.json'){if(Test-Path -LiteralPath (Join-Path $root $name)){throw 'STOP: prior evidence exists; do not repeat'}}
$encoded=[Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($code))
$child=Start-Process -FilePath $runtime -ArgumentList @('-NoProfile','-EncodedCommand',$encoded) -WindowStyle Normal -PassThru
try{[pscustomobject]@{Decision='MACHINE_ROOT_CONSOLE_STARTED_RESULT_PENDING';ProcessId=$child.Id;NoAutomaticElevation=$true;SQLStopped=$false;CertreqInvoked=$false}|ConvertTo-Json}finally{$child.Dispose()}
