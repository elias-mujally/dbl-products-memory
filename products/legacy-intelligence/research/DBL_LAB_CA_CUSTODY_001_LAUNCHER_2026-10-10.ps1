[CmdletBinding()]
param([switch]$PreflightOnly)
# Public launcher only. No secret in arguments or this file; no execution-policy change.
$ErrorActionPreference='Stop'
$runtime=Join-Path $env:USERPROFILE '.cache\codex-runtimes\codex-primary-runtime\dependencies\native\powershell\pwsh.exe'
if($env:COMPUTERNAME -cne 'DESKTOP-8QRQT7R' -or $runtime -cne 'C:\Users\user\.cache\codex-runtimes\codex-primary-runtime\dependencies\native\powershell\pwsh.exe'){throw 'STOP: exact host/runtime path required'}
if((Get-FileHash -LiteralPath $runtime -Algorithm SHA256).Hash -cne '362A356CE7F0940EC74F73A8FC2C990A2CC24A38A11C90BBD8ECA947110AD139'){throw 'STOP: runtime hash mismatch'}
$publicCode=@'
& {
 $p='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010\Invoke-LabCaCustody001.ps1'
 if((Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash -cne '26974BC9463F79C2D9F6FAE17614D7BC7F3D63648608AAEF3DDA957A76D16BBC'){throw 'STOP: custody helper hash mismatch'}
 & ([scriptblock]::Create((Get-Content -LiteralPath $p -Raw)))
}
'@
if($PreflightOnly){$publicCode=$publicCode.Replace('& ([scriptblock]::Create((Get-Content -LiteralPath $p -Raw)))','& ([scriptblock]::Create((Get-Content -LiteralPath $p -Raw))) -PreflightOnly')}
else {$publicCode+="`n[void](Read-Host 'Finished. Review JSON; press Enter to close this interactive window')"}
# UTF16 encoding prevents parent-shell quote/path damage. Encoded content is public source above,
# not a password or key. Password is entered only inside the child console via hidden Read-Host.
$encodedPublicCode=[Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($publicCode))
if($PreflightOnly){
 & $runtime -NoProfile -EncodedCommand $encodedPublicCode
 if($LASTEXITCODE -ne 0){throw 'STOP: child runtime failed; no automatic retry'}
} else {
 # This is the user-operated password console, intentionally visible, never RunAs/UAC.
 # No redirected input/output, capture of its secret prompts, or persistent secret argument.
 $interactive=Start-Process -FilePath $runtime -ArgumentList @('-NoProfile','-EncodedCommand',$encodedPublicCode) -WindowStyle Normal -PassThru
 [pscustomobject]@{Decision='INTERACTIVE_CA_CONSOLE_STARTED_NOT_YET_QUALIFIED';ProcessId=$interactive.Id;KeySuccess='NOT_ASSERTED';Next='Enter secret only in the visible child console; return sanitized JSON or STOP; no rerun'}|ConvertTo-Json
}
