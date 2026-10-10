$ErrorActionPreference='Stop'
$testRoot='C:\Users\user\Documents\Codex\FRCSQ-20261010-7e3821a9'
if (($PSScriptRoot -and $PSScriptRoot -cne $testRoot) -or (Get-Content -LiteralPath "$testRoot\OWNERSHIP.txt" -Raw).Trim() -cne 'DBL_SYNTHETIC_ONLY FRCSQ 7e3821a9 2026-10-10'){throw 'Owned test root required'}
$result=Get-Content -LiteralPath "$testRoot\INTERACTIVE_RESULT.json" -Raw|ConvertFrom-Json
if($result.Decision -ne 'INTERACTIVE_AND_QUARANTINE_QUALIFIED' -or $result.AgentCleanup -ne 'SCOPED_STOPPED'){throw 'Authenticated extraction has not passed'}
$restoredRoot="$testRoot\authenticated-extraction"
if(@(Get-ChildItem -LiteralPath $restoredRoot -Recurse -Force|Where-Object {$_.Attributes -band [IO.FileAttributes]::ReparsePoint}).Count){throw 'Link in restore root'}
$manifest=Get-Content -LiteralPath "$restoredRoot\metadata\manifest.json" -Raw|ConvertFrom-Json
if($manifest.Schema -cne 'DBL_SYNTHETIC_NTFS_MANIFEST_V1' -or $manifest.Scope -cne 'synthetic-only same-host' -or $manifest.Files.Count -ne 4){throw 'Unexpected fixture manifest'}
$sid=[Security.Principal.WindowsIdentity]::GetCurrent().User.Value
$sections=[Security.AccessControl.AccessControlSections]::Owner -bor [Security.AccessControl.AccessControlSections]::Group -bor [Security.AccessControl.AccessControlSections]::Access
$expected=@('.','payload','payload/data.bin','payload/inherited.txt')
foreach($r in $manifest.Files){
 if($r.Path -cnotin $expected -or $r.OwnerSid -cne $sid){throw 'Synthetic identity guard failed'}
 $dest=if($r.Path -eq '.'){$restoredRoot}else{Join-Path $restoredRoot $r.Path}
 $sec=if($r.Directory){[Security.AccessControl.DirectorySecurity]::new()}else{[Security.AccessControl.FileSecurity]::new()}
 # Only an owned synthetic destination is writable here; restore final attributes afterwards.
 if(-not $r.Directory -and ((Get-Item -LiteralPath $dest -Force).Attributes -band [IO.FileAttributes]::ReadOnly)){[IO.File]::SetAttributes($dest,(Get-Item -LiteralPath $dest -Force).Attributes -band (-bnot [IO.FileAttributes]::ReadOnly))}
 # The operator may already have replayed the exact descriptor before a later timestamp failure.
 # Skipping an identical descriptor is not acceptance of a mismatch: every section is verified below.
 if((Get-Acl -LiteralPath $dest).GetSecurityDescriptorSddlForm($sections) -cne $r.Sddl){
  $sec.SetSecurityDescriptorSddlForm($r.Sddl,$sections);Set-Acl -LiteralPath $dest -AclObject $sec
 }
 if(-not $r.Directory -and (Get-FileHash -LiteralPath $dest -Algorithm SHA256).Hash -cne $r.SHA256){throw 'Content mismatch'}
}
$checks=@()
foreach($r in @($manifest.Files|Sort-Object {$_.Path.Length} -Descending)){
 $dest=if($r.Path -eq '.'){$restoredRoot}else{Join-Path $restoredRoot $r.Path}
 # Restore timestamps while writable; ReadOnly is applied last, then checked strictly.
 if(-not $r.Directory -and ((Get-Item -LiteralPath $dest -Force).Attributes -band [IO.FileAttributes]::ReadOnly)){[IO.File]::SetAttributes($dest,(Get-Item -LiteralPath $dest -Force).Attributes -band (-bnot [IO.FileAttributes]::ReadOnly))}
 if($r.Directory){[IO.Directory]::SetCreationTimeUtc($dest,[datetime]$r.CreationUtc);[IO.Directory]::SetLastWriteTimeUtc($dest,[datetime]$r.WriteUtc);[IO.Directory]::SetLastAccessTimeUtc($dest,[datetime]$r.AccessUtc)}else{[IO.File]::SetCreationTimeUtc($dest,[datetime]$r.CreationUtc);[IO.File]::SetLastWriteTimeUtc($dest,[datetime]$r.WriteUtc);[IO.File]::SetLastAccessTimeUtc($dest,[datetime]$r.AccessUtc)}
 [IO.File]::SetAttributes($dest,[IO.FileAttributes]$r.Attributes)
 $acl=Get-Acl -LiteralPath $dest;$file=Get-Item -LiteralPath $dest -Force
 if($acl.GetSecurityDescriptorSddlForm($sections) -cne $r.Sddl -or $acl.GetOwner([Security.Principal.SecurityIdentifier]).Value -cne $r.OwnerSid -or $acl.AreAccessRulesProtected -ne $r.Protected -or [int]$file.Attributes -ne $r.Attributes -or $file.CreationTimeUtc.Ticks -ne ([datetime]$r.CreationUtc).ToUniversalTime().Ticks -or $file.LastWriteTimeUtc.Ticks -ne ([datetime]$r.WriteUtc).ToUniversalTime().Ticks){throw 'Required extracted metadata mismatch'}
 $checks+=[pscustomobject]@{Path=$r.Path;DaclOwnerInheritanceAttributesCreationWriteUtc='MATCH';RecordedAccessUtc=$r.AccessUtc;ObservedAccessUtc=$file.LastAccessTimeUtc.ToString('o');AccessExactAtCheck=($file.LastAccessTimeUtc.Ticks -eq ([datetime]$r.AccessUtc).ToUniversalTime().Ticks);AccessGuarantee='Recorded and applied; subsequent reads may change it; no filesystem-policy change'}
}
[pscustomobject]@{Decision='AUTHENTICATED_TAR_MANIFEST_NTFS_REPLAY_PASSED';At=(Get-Date -Format o);ManifestFrom='authenticated-extraction/metadata/manifest.json';Records=$checks;OwnerScope='current user; arbitrary SID tested separately only'}|ConvertTo-Json -Depth 6|Set-Content -LiteralPath "$testRoot\EXTRACTED_METADATA_RESULT.json" -Encoding utf8
Get-Content -LiteralPath "$testRoot\EXTRACTED_METADATA_RESULT.json" -Raw
