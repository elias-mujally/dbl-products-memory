$ErrorActionPreference='Stop'
$testRoot='C:\Users\user\Documents\Codex\FRCSQ-20261010-7e3821a9'
if($env:COMPUTERNAME -cne 'DESKTOP-8QRQT7R' -or (Get-Content -LiteralPath "$testRoot\OWNERSHIP.txt" -Raw).Trim() -cne 'DBL_SYNTHETIC_ONLY FRCSQ 7e3821a9 2026-10-10'){throw 'Host/test ownership mismatch'}
if((Get-Item -LiteralPath $testRoot).Attributes -band [IO.FileAttributes]::ReparsePoint -or @(Get-ChildItem -LiteralPath $testRoot -Recurse -Force|Where-Object {$_.Attributes -band [IO.FileAttributes]::ReparsePoint}).Count){throw 'Link in synthetic root'}
$principal=[Security.Principal.WindowsPrincipal]::new([Security.Principal.WindowsIdentity]::GetCurrent())
if(-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)){throw 'Actual administrator token required'}
if(-not ('DblSyntheticToken' -as [type])){throw 'Use the same administrative PowerShell session that completed Qualify-ElevatedMetadata; token helper is not loaded'}
$helper="$testRoot\Verify-ExtractedManifest.ps1"
if((Get-FileHash -LiteralPath $helper -Algorithm SHA256).Hash -cne 'CBC2A28AC8A653103B361BC6A602DD3D594B8D9D6D6370857032C389D3375BA7'){throw 'Synthetic helper hash mismatch'}
$oldRestore=$null;$oldSecurity=$null
try {
 $oldRestore=[DblSyntheticToken]::Enable('SeRestorePrivilege')
 $oldSecurity=[DblSyntheticToken]::Enable('SeSecurityPrivilege')
 & ([scriptblock]::Create((Get-Content -LiteralPath $helper -Raw)))
}finally{
 if($null -ne $oldSecurity){[DblSyntheticToken]::Restore($oldSecurity)}
 if($null -ne $oldRestore){[DblSyntheticToken]::Restore($oldRestore)}
}
Write-Output 'SYNTHETIC_REPLAY_FINISHED_WITH_PROCESS_PRIVILEGES_RESTORED'
