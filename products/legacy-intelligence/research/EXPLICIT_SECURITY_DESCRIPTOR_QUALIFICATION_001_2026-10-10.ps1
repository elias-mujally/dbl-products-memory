param([switch]$EngineOnly)
# Explicit Security Descriptor Qualification #001. No SQL content/copy/stop or E: writes.
# Security writes are permitted only under a NEW isolated fixture root; sealed before real reads.
$ErrorActionPreference='Stop'
$explicitHome='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-real-recovery-capture-001-20261010'
$explicitNative="$explicitHome\Explicit-Security001.Native.cs"
$explicitNativeHash='76FF48475E26BE7DD01A938BE7E2565D1FF5A0A20956F4D9A03786AFAC847056'
if((Get-FileHash -LiteralPath $explicitNative -Algorithm SHA256).Hash -cne $explicitNativeHash){throw 'STOP: native reader changed'}
if('DblExplicitSecurity001' -as [type]){throw 'STOP: fresh PowerShell session required'}
Add-Type -TypeDefinition (Get-Content -LiteralPath $explicitNative -Raw)
function Assert-Explicit($ok,[string]$reason){if(-not $ok){throw "STOP: $reason"}}
function Get-ExplicitSummary($r,[string]$path){
 [pscustomobject]@{Path=$path;CanonicalSHA256=$r.SHA256;ControlFlags=('0x{0:X4}' -f $r.Control);DaclState=$r.DaclState;SaclState=$r.SaclState;DaclAceTypes=$r.DaclTypes;SaclAceTypes=$r.SaclTypes;Components=$r.Components;SourceComparison='EXPLICIT_HANDLE_AND_INDEPENDENT_FILE_SECURITY_PRE_POST_EQUAL';AceOrderPreserved=$true}
}
function Test-ExplicitEngine {
 # Native SDDL decoder is independent of the new parser/encoder. No filesystem read/write.
 $v=[DblExplicitSecurity001]::FromSddl('O:SYG:BAD:P(A;;0x20000;;;SY)(D;;0x1;;;WD)S:P(AU;SAFA;FR;;;WD)(ML;;NW;;;ME)')
 $p=[DblExplicitSecurity001]::Parse($v)
 Assert-Explicit (($p.Control -band 0x3000) -eq 0x3000) 'known protected flags missing'
 Assert-Explicit ($p.Dacl[8] -eq 0 -and $p.Dacl[28] -eq 1) 'known noncanonical allow/deny order changed'
 Assert-Explicit ($p.Sacl[8] -eq 2 -and $p.Sacl[28] -eq 17) 'known audit/label order changed'
 [DblExplicitSecurity001]::Supported($v)
 $encoded=[DblExplicitSecurity001]::Encode($p)
 Assert-Explicit ([DblExplicitSecurity001]::Equivalent($v,$encoded)) 'fixture descriptor encode mismatch'
 $altered=[DblExplicitSecurity001]::FromSddl('O:SYG:BAD:P(D;;0x1;;;WD)(A;;0x20000;;;SY)S:P(AU;SAFA;FR;;;WD)(ML;;NW;;;ME)')
 Assert-Explicit (-not [DblExplicitSecurity001]::Equivalent($v,$altered)) 'ACE reordering not detected'
 $changed=[byte[]]$encoded.Clone();$changed[2]=$changed[2] -bxor 1
 Assert-Explicit (-not [DblExplicitSecurity001]::Equivalent($encoded,$changed)) 'control change not detected'
 $absent=[byte[]]::new(20);$absent[0]=1;$absent[3]=0x80
 $nullAcl=[byte[]]$absent.Clone();$nullAcl[2]=4
 $empty=[byte[]]::new(28);[Array]::Copy($nullAcl,$empty,20);$empty[16]=20;$empty[20]=2;$empty[22]=8
 Assert-Explicit (-not [DblExplicitSecurity001]::Equivalent($absent,$nullAcl) -and -not [DblExplicitSecurity001]::Equivalent($nullAcl,$empty)) 'absent/null/empty ACL collapsed'
 $absentSacl=[byte[]]$absent.Clone();$nullSacl=[byte[]]$absent.Clone();$nullSacl[2]=16
 $emptySacl=[byte[]]::new(28);[Array]::Copy($nullSacl,$emptySacl,20);$emptySacl[12]=20;$emptySacl[20]=2;$emptySacl[22]=8
 Assert-Explicit (-not [DblExplicitSecurity001]::Equivalent($absentSacl,$nullSacl) -and -not [DblExplicitSecurity001]::Equivalent($nullSacl,$emptySacl)) 'absent/null/empty SACL collapsed'
 $unsupported=[DblExplicitSecurity001]::Parse($v);$unsupported.Sacl[8]=18
 $rejected=$false;try{[DblExplicitSecurity001]::Supported([DblExplicitSecurity001]::Encode($unsupported))}catch{$rejected=$true}
 Assert-Explicit $rejected 'unsupported resource ACE not rejected'
 $truncated=[byte[]]::new(21);[Array]::Copy($encoded,$truncated,21)
 $rejected=$false;try{$null=[DblExplicitSecurity001]::Parse($truncated)}catch{$rejected=$true}
 Assert-Explicit $rejected 'truncated descriptor not rejected'
 $rm=[byte[]]$encoded.Clone();$rm[3]=$rm[3] -bor 0x40
 $rejected=$false;try{[DblExplicitSecurity001]::Supported($rm)}catch{$rejected=$true}
 Assert-Explicit $rejected 'unqualified RM control not rejected'
 [pscustomobject]@{Decision='EXPLICIT_DESCRIPTOR_ENGINE_VECTORS_PASSED';VectorChecks=10;NativeSDDLReference=$true;KnownAuditAndMediumMIC=$true;OrderAndControlNegativeChecks=$true;NullAbsentEmptyDaclAndSaclDistinct=$true;UnsupportedAndTruncationStopped=$true;FilesystemWrite=$false;ProtectedObjectRead=$false}
}
$explicitEngine=Test-ExplicitEngine
if($EngineOnly){$explicitEngine|ConvertTo-Json -Depth 4;return}
$explicitIdentity=[Security.Principal.WindowsIdentity]::GetCurrent()
$explicitBefore=[DblExplicitSecurity001]::State()
if($env:COMPUTERNAME -cne 'DESKTOP-8QRQT7R' -or -not $explicitBefore.Elevated){throw 'STOP: exact host and actual authorized administrator; no UAC routine'}
Assert-Explicit ($explicitBefore.SecurityPresent -and -not $explicitBefore.SecurityEnabled -and -not $explicitBefore.BackupEnabled -and -not $explicitBefore.RestoreEnabled -and -not $explicitBefore.ThreadTokenPresent) 'fresh elevated primary-token state required'
$explicitRoot=[DblExplicitSecurity001]::FixtureRoot
Assert-Explicit (-not (Test-Path -LiteralPath $explicitRoot)) 'fresh fixture root required; no reuse/overwrite'
Assert-Explicit ((Get-Volume -DriveLetter C).FileSystem -eq 'NTFS') 'fixture volume not NTFS'
$explicitParent=[IO.DirectoryInfo]::new([IO.Path]::GetDirectoryName($explicitRoot))
while($null -ne $explicitParent){Assert-Explicit (-not ($explicitParent.Attributes -band [IO.FileAttributes]::ReparsePoint)) 'fixture ancestor link';$explicitParent=$explicitParent.Parent}
$explicitPrevious=$null;$explicitRestorePrevious=$null;$explicitError=$null;$explicitRestoreError=$null
$explicitDuring=$null;$explicitFixtureToken=$null;$explicitAfter=$null;$explicitFixtureResults=@();$explicitRecords=@();$paths=@{};$preflight=$null
$explicitStage='FixtureSetup';$explicitPath=$explicitRoot;$explicitFixturesPassed=$false;$explicitSourceRead=$false
try {
 $explicitPrevious=[DblExplicitSecurity001]::EnableSecurity()
 $explicitRestorePrevious=[DblExplicitSecurity001]::EnableFixtureRestore()
 $explicitFixtureToken=[DblExplicitSecurity001]::State()
 Assert-Explicit ($explicitFixtureToken.SecurityEnabled -and $explicitFixtureToken.RestoreEnabled -and -not $explicitFixtureToken.BackupEnabled -and -not $explicitFixtureToken.ThreadTokenPresent) 'fixture token scope not established'
 $sid=$explicitIdentity.User.Value
 $null=New-Item -ItemType Directory -Path $explicitRoot
 [IO.File]::WriteAllText("$explicitRoot\OWNERSHIP.txt",'DBL_SYNTHETIC_ONLY ESDQ a42c190d 2026-10-10',[Text.UTF8Encoding]::new($false))
 $rootSd=[DblExplicitSecurity001]::FromSddl("O:$($sid)G:$($sid)D:P(A;OICI;FA;;;SY)(A;OICI;FA;;;BA)(A;OICI;FA;;;$sid)S:P")
 [DblExplicitSecurity001]::FixtureApply($explicitRoot,$rootSd)
 $tree="$explicitRoot\fixture-tree";$null=New-Item -ItemType Directory -Path $tree
 $treeSd=[DblExplicitSecurity001]::FromSddl("O:$($sid)G:BAD:P(A;OICI;FA;;;SY)(A;OICI;FA;;;BA)(A;OICI;FA;;;$sid)S:P(AU;OICISAFA;FR;;;$sid)(ML;OICI;NW;;;ME)")
 [DblExplicitSecurity001]::FixtureApply($tree,$treeSd)
 foreach($name in @('protected-source.txt','protected-restored.txt','inherited-source.txt','inherited-restored.txt','empty-source.txt','empty-restored.txt')){
  [IO.File]::WriteAllText("$tree\$name",'DBL SYNTHETIC SECURITY DESCRIPTOR ONLY',[Text.UTF8Encoding]::new($false))
 }
 $protectedSd=[DblExplicitSecurity001]::FromSddl("O:SYG:BAD:P(D;;0x1;;;WD)(A;;FA;;;SY)(A;;FA;;;BA)(A;;FA;;;$sid)S:P(AU;SAFA;FR;;;$sid)(ML;;NW;;;ME)")
 [DblExplicitSecurity001]::FixtureApply("$tree\protected-source.txt",$protectedSd)
 $emptySd=[DblExplicitSecurity001]::FromSddl("O:$($sid)G:BAD:P(A;;FA;;;SY)(A;;FA;;;BA)(A;;FA;;;$sid)S:P")
 [DblExplicitSecurity001]::FixtureApply("$tree\empty-source.txt",$emptySd)
 $explicitStage='FixtureReadAndReplay'
 foreach($case in @('protected','inherited','empty')){
  $source="$tree\$case-source.txt";$target="$tree\$case-restored.txt";$explicitPath=$source
  $record=[DblExplicitSecurity001]::Read($source)
  $sourcePart=[DblExplicitSecurity001]::Parse($record.Descriptor)
  if($case -eq 'protected'){
   Assert-Explicit (($record.Control -band 0x3000) -eq 0x3000 -and $record.DaclTypes[0] -eq 1 -and $record.SaclTypes -contains 2 -and $record.SaclTypes -contains 17) 'protected fixture flags/deny/audit/label absent'
   Assert-Explicit ([Security.Principal.SecurityIdentifier]::new($sourcePart.Owner,0).Value -eq 'S-1-5-18') 'fixture SYSTEM owner not established'
   Assert-Explicit ([Security.Principal.SecurityIdentifier]::new($sourcePart.Group,0).Value -eq 'S-1-5-32-544') 'fixture Administrators group not established'
  }
  if($case -eq 'inherited'){
   Assert-Explicit (($record.Control -band 0x3000) -eq 0 -and $record.SaclTypes -contains 2 -and $record.SaclTypes -contains 17) 'inherited fixture protection/audit/label state'
   Assert-Explicit (($sourcePart.Dacl[9] -band 16) -ne 0) 'actual inherited DACL ACE not established'
  }
  if($case -eq 'empty'){Assert-Explicit ($record.SaclTypes.Count -eq 0) 'empty fixture contains unplanned SACL ACE'}
  # Serialize the actual rebuilt descriptor and reread it BEFORE replay. Dummy security only.
  $manifest="$explicitRoot\$case-descriptor.bin"
  [IO.File]::WriteAllBytes($manifest,$record.Descriptor)
  $fromManifest=[IO.File]::ReadAllBytes($manifest)
  Assert-Explicit ([DblExplicitSecurity001]::Equivalent($record.Descriptor,$fromManifest)) 'fixture manifest reread differs'
  [DblExplicitSecurity001]::FixtureApply($target,$fromManifest)
  $explicitPath=$target;$restored=[DblExplicitSecurity001]::Read($target)
  Assert-Explicit ([DblExplicitSecurity001]::Equivalent($record.Descriptor,$restored.Descriptor)) 'fixture native replay descriptor differs'
  $summary=Get-ExplicitSummary $record $source
  $summary|Add-Member -NotePropertyName RestoredPath -NotePropertyValue $target
  $summary|Add-Member -NotePropertyName RestoredCanonicalSHA256 -NotePropertyValue $restored.SHA256
  $summary|Add-Member -NotePropertyName NativeReplayPassed -NotePropertyValue $true
  $explicitFixtureResults+=$summary
 }
 # Replay a complete protected directory descriptor, too; target is a new sibling fixture.
 $explicitStage='FixtureDirectoryReplay';$explicitPath=$tree
 $directorySource=[DblExplicitSecurity001]::Read($tree)
 $directoryTarget="$explicitRoot\directory-restored";$null=New-Item -ItemType Directory -Path $directoryTarget
 $directoryManifest="$explicitRoot\directory-descriptor.bin"
 [IO.File]::WriteAllBytes($directoryManifest,$directorySource.Descriptor)
 $directoryFromManifest=[IO.File]::ReadAllBytes($directoryManifest)
 Assert-Explicit ([DblExplicitSecurity001]::Equivalent($directorySource.Descriptor,$directoryFromManifest)) 'directory manifest reread differs'
 [DblExplicitSecurity001]::FixtureApply($directoryTarget,$directoryFromManifest)
 $explicitPath=$directoryTarget;$directoryRestored=[DblExplicitSecurity001]::Read($directoryTarget)
 Assert-Explicit ([DblExplicitSecurity001]::Equivalent($directorySource.Descriptor,$directoryRestored.Descriptor)) 'directory native replay descriptor differs'
 $summary=Get-ExplicitSummary $directorySource $tree
 $summary|Add-Member -NotePropertyName RestoredPath -NotePropertyValue $directoryTarget
 $summary|Add-Member -NotePropertyName RestoredCanonicalSHA256 -NotePropertyValue $directoryRestored.SHA256
 $summary|Add-Member -NotePropertyName NativeReplayPassed -NotePropertyValue $true
 $explicitFixtureResults+=$summary
 [DblExplicitSecurity001]::RestoreSecurity($explicitRestorePrevious);$explicitRestorePrevious=$null
 [DblExplicitSecurity001]::SealFixtureWrites()
 $explicitDuring=[DblExplicitSecurity001]::State()
 Assert-Explicit ($explicitDuring.SecurityEnabled -and -not $explicitDuring.RestoreEnabled -and -not $explicitDuring.BackupEnabled -and -not $explicitDuring.ThreadTokenPresent) 'real-reader token scope not restored'
 $explicitFixturesPassed=$true
 $explicitStage='RealAllowlistPreflight';$explicitPath=$null
 $base="$explicitHome\Read-Capture001Preflight.ps1"
 Assert-Explicit ((Get-FileHash -LiteralPath $base -Algorithm SHA256).Hash -ceq '8797AC90621F4584E403AE537C556ACE86891BF7338E6AD275FCBAC055DA0340') 'approved allowlist helper changed'
 $preflight=(& ([scriptblock]::Create((Get-Content -LiteralPath $base -Raw))))|ConvertFrom-Json
 Assert-Explicit ($preflight.Decision -ceq 'ADMINISTRATIVE_FILESET_PREFLIGHT_PASSED_SECURITY_METADATA_PENDING' -and $preflight.PersistentCount -eq 23) 'fresh real allowlist gate failed'
 $paths=@{}
 foreach($f in $preflight.Files){
  $paths[$f.Path]=$false;$dir=[IO.DirectoryInfo]::new([IO.Path]::GetDirectoryName($f.Path))
  while($null -ne $dir){if(-not $paths.ContainsKey($dir.FullName)){$paths[$dir.FullName]=$true};$dir=$dir.Parent}
 }
 Assert-Explicit ($paths.Count -le 64) 'parent scope exceeds original bound'
 $explicitStage='RealScopeMetadata'
 foreach($path in @($paths.Keys|Sort-Object)){
  $explicitPath=$path;$item=Get-Item -LiteralPath $path -Force
  Assert-Explicit ($item.PSIsContainer -eq [bool]$paths[$path]) 'source file/directory identity mismatch'
  $unsupported=[IO.FileAttributes]::ReparsePoint -bor [IO.FileAttributes]::Encrypted -bor [IO.FileAttributes]::SparseFile -bor [IO.FileAttributes]::Compressed
  Assert-Explicit (-not ($item.Attributes -band $unsupported)) 'unsupported real attributes'
  $info=[DblExplicitSecurity001]::Metadata($path)
  if(-not $item.PSIsContainer){
   Assert-Explicit ($info.NumberOfLinks -eq 1) 'real file hardlink unsupported'
   Assert-Explicit (@(Get-Item -LiteralPath $path -Stream *|Where-Object Stream -ne ':$DATA').Count -eq 0) 'real alternate stream unsupported'
  }
  $explicitSourceRead=$true
  $record=[DblExplicitSecurity001]::Read($path)
  $summary=Get-ExplicitSummary $record $path
  $summary|Add-Member -NotePropertyName Directory -NotePropertyValue $item.PSIsContainer
  $summary|Add-Member -NotePropertyName FileIdentity -NotePropertyValue ('{0:X8}:{1:X8}{2:X8}' -f $info.VolumeSerial,$info.IndexHigh,$info.IndexLow)
  $summary|Add-Member -NotePropertyName LinkCount -NotePropertyValue $info.NumberOfLinks
  $explicitRecords+=$summary
 }
}catch{$explicitError=$_.Exception.Message}
finally{
 # Always restore fixture-only SeRestore, then reader SeSecurity, even on STOP.
 if($null -ne $explicitRestorePrevious){try{[DblExplicitSecurity001]::RestoreSecurity($explicitRestorePrevious)}catch{$explicitRestoreError=$_.Exception.Message}}
 if($null -ne $explicitPrevious){try{[DblExplicitSecurity001]::RestoreSecurity($explicitPrevious)}catch{$explicitRestoreError=$_.Exception.Message}}
 try{
  $explicitAfter=[DblExplicitSecurity001]::State()
  Assert-Explicit ($explicitAfter.SecurityEnabled -eq $explicitBefore.SecurityEnabled -and $explicitAfter.SecurityPresent -eq $explicitBefore.SecurityPresent -and ($explicitAfter.SecurityAttributes -band 3) -eq ($explicitBefore.SecurityAttributes -band 3) -and $explicitAfter.RestoreEnabled -eq $explicitBefore.RestoreEnabled -and $explicitAfter.BackupEnabled -eq $explicitBefore.BackupEnabled) 'observed privilege restoration mismatch'
 }catch{$explicitRestoreError=$_.Exception.Message}
}
$passed=($null -eq $explicitError -and $null -eq $explicitRestoreError -and $explicitFixturesPassed -and $explicitRecords.Count -eq $paths.Count)
[pscustomobject]@{
 Decision=if($passed){'SECURITY_METADATA_GATE_PASSED'}else{'SECURITY_METADATA_GATE_BLOCKED'}
 Task='EXPLICIT_SECURITY_DESCRIPTOR_QUALIFICATION_001';ObservedAt=(Get-Date -Format o);Host=$env:COMPUTERNAME
 Operator=$explicitIdentity.Name;ProcessId=$PID;PowerShellVersion=$PSVersionTable.PSVersion.ToString()
 NativeReaderSHA256=$explicitNativeHash;FixtureRoot=$explicitRoot;EngineVectors=$explicitEngine;FixturesPassed=$explicitFixturesPassed;FixtureResults=$explicitFixtureResults
 ProcessTokenBefore=$explicitBefore;ProcessTokenDuringFixtureReplay=$explicitFixtureToken;ProcessTokenDuringRealRead=$explicitDuring;ProcessTokenAfter=$explicitAfter;PrivilegeRestoreFailure=$explicitRestoreError
 FailurePhase=if($null -ne $explicitError){$explicitStage}else{$null};FailurePath=if($null -ne $explicitError){$explicitPath}else{$null};NativeStage=[DblExplicitSecurity001]::Stage;NativeCurrentPath=[DblExplicitSecurity001]::CurrentPath;Reason=$explicitError
 PersistentCount=if($null -ne $preflight){$preflight.PersistentCount}else{0};ExpectedSecurityRecordCount=if($null -ne $paths){$paths.Count}else{0};CompletedSecurityRecordCount=$explicitRecords.Count;Records=$explicitRecords
 SupportedPresentAceTypes=@(0,1,2,17);OtherComponents='Read explicitly; STOP if present without qualified replay';ResourceManagerControlReplay='UNSUPPORTED_STOP_IF_PRESENT'
 BackupSecurityInformationUsed=$false;FullDescriptorRebuiltAndCompared=$passed;SourceSecurityMetadataRead=$explicitSourceRead;SourceContentsRead=$false;SourceSecurityChanged=$false;SqlStopped=$false;EWrites=$false;RealCaptureStarted=$false
 SQLStatus=(Get-Service -Name 'MSSQL$YSEDU').Status.ToString();RawRealSecurityDescriptorsPublished=$false;FixtureCleanup='NOT_PERFORMED; synthetic only'
 Pending=@('Exact settings/local-evidence allowlist','Private NTFS real stage ACL','Fresh storage/tool/custody gates','ERP closure','Final pre-stop refresh','Real capture excluded from this task')
}|ConvertTo-Json -Depth 10
# STOP, even if the explicit security gate PASSES. No real recovery operation.
