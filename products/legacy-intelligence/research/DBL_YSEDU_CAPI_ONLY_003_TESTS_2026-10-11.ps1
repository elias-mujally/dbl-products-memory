$ErrorActionPreference='Stop';Set-StrictMode -Version Latest
Add-Type -TypeDefinition (Get-Content -LiteralPath (Join-Path $PSScriptRoot 'YseduCapiOnly003.cs') -Raw)
$checks=[Collections.Generic.List[string]]::new()
function Require([bool]$Ok,[string]$Code){if(-not $Ok){throw ('Synthetic failure: '+$Code)};[void]$checks.Add($Code)}
Require ([DblYseduCapiOnly003]::AcquireFlags -eq 76 -and ([DblYseduCapiOnly003]::AcquireFlags -band 0x70003) -eq 0) 'CapiOnlyNoCacheOrFallbackExactFlags'
for($n=0;$n -lt 512;$n++){if([DblYseduCapiOnly003]::NoExportPermission($n) -ne (($n -band 4) -eq 0 -and ($n -band 256) -eq 0)){throw 'Permission bit policy regression'}}
Require $true 'All512PermissionsMatchIndependentExportArchiveBits'
Require ([DblYseduCapiOnly003]::DecodeDword([byte[]](24,0,0,0),4) -eq 24) 'BoundedDwordLittleEndian'
$threw=$false;try{[void][DblYseduCapiOnly003]::DecodeDword([byte[]](24,0,0),3)}catch{$threw=$true};Require $threw 'ShortDwordRejected'
$threw=$false;try{[void][DblYseduCapiOnly003]::DecodeDword([byte[]](24,0,0,0),8)}catch{$threw=$true};Require $threw 'OversizedReportedDwordRejected'
Require ([DblYseduCapiOnly003]::DecodeName([byte[]](65,66,0),3) -ceq 'AB') 'ProviderNameBoundedAscii'
$threw=$false;try{[void][DblYseduCapiOnly003]::DecodeName([byte[]](65,0,66,0),4)}catch{$threw=$true};Require $threw 'EmbeddedNullNameRejected'
$threw=$false;try{[void][DblYseduCapiOnly003]::DecodeName([byte[]](65,66),2)}catch{$threw=$true};Require $threw 'UnterminatedNameRejected'
Require (-not [DblYseduCapiOnly003]::ReleaseProviderRequired([IntPtr]1,$false) -and [DblYseduCapiOnly003]::ReleaseProviderRequired([IntPtr]1,$true) -and -not [DblYseduCapiOnly003]::ReleaseProviderRequired([IntPtr]::Zero,$true)) 'BorrowedVsOwnedProviderHandlePolicy'
$r=[DblYseduCapiOnly003+Result]::new();$r.Check='PrimaryFailure';$r.Win32=5
[DblYseduCapiOnly003]::Cleanup($r,'FakeRelease',[Func[bool]]{return $false})
Require ($r.Check -ceq 'PrimaryFailure' -and $r.Win32 -eq 5 -and $r.CleanupFailures[0] -ceq 'FakeRelease') 'PrimaryFailurePreservedWithSeparateCleanup'
[DblYseduCapiOnly003]::Cleanup($r,'FakeThrow',[Func[bool]]{throw 'synthetic sensitive cleanup'})
Require ($r.CleanupFailures.Count -eq 2 -and ($r|ConvertTo-Json -Depth 4) -notmatch 'synthetic sensitive') 'ThrowingCleanupSanitized'
$noNative=[DblYseduCapiOnly003]::Run([IntPtr]::Zero,$null)
Require (-not $noNative.Passed -and -not $noNative.AcquisitionAttempted -and $noNative.Check -ceq 'NativeInputs') 'InvalidInputsStopBeforeAnyNativeCall'
[pscustomobject]@{Decision='CAPI003_SYNTHETIC_GUARDS_PASSED';At=(Get-Date -Format o);Checks=@($checks.ToArray());Count=$checks.Count;PermissionCases=512;PrivateKeyAcquisition=$false;PrivateExport=$false;NativeKeyCreation=$false;SqlChanged=$false}|ConvertTo-Json -Depth 5
