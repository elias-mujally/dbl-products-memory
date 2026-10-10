# Bounded Real Recovery Capture #001: administrative READ-ONLY preflight only.
# No SQL stop/start, file copy, backup/restore, source ACL change, disk write or SQL query.
$ErrorActionPreference='Stop'
$identity=[Security.Principal.WindowsIdentity]::GetCurrent()
$principal=[Security.Principal.WindowsPrincipal]::new($identity)
if($env:COMPUTERNAME -cne 'DESKTOP-8QRQT7R' -or -not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)){throw 'BLOCKED: exact host and actual authorized administrator token required; no automatic elevation'}
$instance='HKLM:\SOFTWARE\WOW6432Node\Microsoft\Microsoft SQL Server\MSSQL12.YSEDU'
$map=Get-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Microsoft SQL Server\Instance Names\SQL'
if($map.YSEDU -cne 'MSSQL12.YSEDU'){throw 'Instance mapping mismatch'}
$sqlHome='C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.YSEDU\MSSQL'
$approved=@(
'C:\EFA\DBL_HOST_W11_EFA12026_PostS2_Frozen_20261009.bak',
'C:\EFA\DbRepDes.ldf',
'C:\EFA\DbRepDes.mdf',
'C:\EFA\EFA001.bak',
'C:\EFA\EFA12026.ldf',
'C:\EFA\EFA12026.mdf',
'C:\EFA\EFAARC10.mdf',
'C:\EFA\EFAARC10_log.ldf',
'C:\EFA\Multi_Lang.ldf',
'C:\EFA\Multi_Lang.mdf',
'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.YSEDU\MSSQL\Backup\DBL_HOST_W11_EFA12026_PreMutation_20261006_47a3d84be3294eba8c035cd0dfde8001.bak',
'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.YSEDU\MSSQL\Binn\mssqlsystemresource.ldf',
'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.YSEDU\MSSQL\Binn\mssqlsystemresource.mdf',
'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.YSEDU\MSSQL\DATA\DBL_HOST_W11_EFA12026_PostS2_Frozen_20261009.mdf',
'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.YSEDU\MSSQL\DATA\DBL_HOST_W11_EFA12026_PostS2_Frozen_20261009_log.ldf',
'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.YSEDU\MSSQL\DATA\DBL_HOST_W11_EFA12026_RestoreProof_20261007.mdf',
'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.YSEDU\MSSQL\DATA\DBL_HOST_W11_EFA12026_RestoreProof_20261007_log.ldf',
'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.YSEDU\MSSQL\DATA\master.mdf',
'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.YSEDU\MSSQL\DATA\mastlog.ldf',
'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.YSEDU\MSSQL\DATA\model.mdf',
'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.YSEDU\MSSQL\DATA\modellog.ldf',
'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.YSEDU\MSSQL\DATA\MSDBData.mdf',
'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.YSEDU\MSSQL\DATA\MSDBLog.ldf'
)
$excluded=@("$sqlHome\DATA\tempdb.mdf","$sqlHome\DATA\templog.ldf")
$dirs=@('C:\EFA',"$sqlHome\DATA","$sqlHome\Backup","$sqlHome\Binn","$sqlHome\Log")
$found=@()
foreach($dir in $dirs){
 $items=@(Get-ChildItem -LiteralPath $dir -Force)
 if($items.Count -gt 1000){throw "Inspection bound exceeded: $dir"}
 foreach($f in $items|Where-Object {-not $_.PSIsContainer -and $_.Extension -in @('.mdf','.ndf','.ldf','.bak','.trn')}){
  if($f.FullName -cnotin $approved -and $f.FullName -cnotin $excluded){throw "STOP: new out-of-allowlist SQL/backup file: $($f.FullName)"}
  $found+=$f.FullName
 }
 foreach($child in $items|Where-Object {$_.PSIsContainer}){
  if($child.Attributes -band [IO.FileAttributes]::ReparsePoint){throw "STOP: unqualified directory link: $($child.FullName)"}
  # Report unknown directories without traversing them or silently claiming coverage.
 }
}
foreach($path in $approved){if($path -cnotin $found){throw "STOP: approved path not found: $path"}}
$startup=@((Get-ItemProperty -LiteralPath "$instance\MSSQLServer\Parameters").PSObject.Properties|Where-Object Name -match '^SQLArg\d+$'|ForEach-Object {[pscustomobject]@{Name=$_.Name;Value=[string]$_.Value}})
$expected=@("-d$sqlHome\DATA\master.mdf","-e$sqlHome\Log\ERRORLOG","-l$sqlHome\DATA\mastlog.ldf")
if($startup.Count -ne 3 -or @($startup|Where-Object {$_.Value -cnotin $expected}).Count){throw 'STOP: startup paths/settings differ from accepted scope'}
$config=Get-ItemProperty -LiteralPath "$instance\MSSQLServer"
if($config.BackupDirectory -cne "$sqlHome\Backup" -or -not [string]::IsNullOrWhiteSpace($config.DefaultData) -or -not [string]::IsNullOrWhiteSpace($config.DefaultLog)){throw 'STOP: configured directory differs from approved scope'}
$service=Get-CimInstance Win32_Service -Filter 'Name="MSSQL$YSEDU"'
if($service.Name -cne 'MSSQL$YSEDU' -or $service.State -ne 'Running' -or $service.PathName -notlike ('*'+$sqlHome+'\Binn\sqlservr.exe*')){throw 'STOP: YSEDU service identity/state mismatch'}
$files=@()
foreach($path in $approved){
 $f=Get-Item -LiteralPath $path -Force
 if($f.Attributes -band ([IO.FileAttributes]::ReparsePoint -bor [IO.FileAttributes]::Encrypted -bor [IO.FileAttributes]::SparseFile -bor [IO.FileAttributes]::Compressed)){throw "STOP: unsupported file attributes: $path"}
 if($f.Length -gt 4GB -or $path.Length -gt 211){throw "STOP: file size/path beyond qualified bound: $path"}
 $streams=@(Get-Item -LiteralPath $path -Stream *)
 if(@($streams|Where-Object {$_.Stream -ne ':$DATA'}).Count){throw "STOP: alternate stream: $path"}
 # Does not hash/read live MDF/LDF contents. Full SACL inspection is a separate required privileged gate.
 $a=Get-Acl -LiteralPath $path
 $files+=[pscustomobject]@{Path=$path;Bytes=$f.Length;Attributes=[int]$f.Attributes;CreationUtc=$f.CreationTimeUtc.ToString('o');WriteUtc=$f.LastWriteTimeUtc.ToString('o');Owner=$a.Owner;DaclProtected=$a.AreAccessRulesProtected;Streams=$streams.Stream;LiveContentsRead=$false}
}
$log=Get-Item -LiteralPath "$sqlHome\Log\ERRORLOG" -Force
if($log.PSIsContainer -or $log.Attributes -band [IO.FileAttributes]::ReparsePoint){throw 'STOP: invalid error-log path'}
$volumes=@(Get-Volume -DriveLetter C,D,E|Select-Object DriveLetter,FileSystem,HealthStatus,Size,SizeRemaining)
$parts=@(Get-Partition -DriveLetter C,D,E|Select-Object DriveLetter,DiskNumber,PartitionNumber)
if(($parts|Where-Object DriveLetter -eq E).DiskNumber -eq ($parts|Where-Object DriveLetter -eq C).DiskNumber -or ($parts|Where-Object DriveLetter -eq E).DiskNumber -eq ($parts|Where-Object DriveLetter -eq D).DiskNumber){throw 'STOP: E not physically independent'}
if(($volumes|Where-Object DriveLetter -eq C).FileSystem -ne 'NTFS'){throw 'STOP: NTFS not confirmed'}
$total=($files|Measure-Object Bytes -Sum).Sum
$ntfsNeed=[math]::Ceiling(4*$total*1.20)+256MB
$eNeed=[math]::Ceiling($total*1.20)+256MB
if(($volumes|Where-Object DriveLetter -eq C).SizeRemaining -lt $ntfsNeed -or ($volumes|Where-Object DriveLetter -eq E).SizeRemaining -lt $eNeed){throw 'STOP: insufficient working capacity'}
$tools=@(
 @{Path='C:\Program Files\Git\usr\bin\gpg.exe';Hash='A5140C85353E8399DA8D6BD7E3741524CD76A4E69BE88AF12042B1C9EF022984'},
 @{Path='C:\Windows\System32\tar.exe';Hash='92FAFED485AF0FE4C291457DC3C00D0241F6A136731BAB63EF18A3F0C949D37A'},
 @{Path='C:\Program Files\Git\usr\bin\pinentry-w32.exe';Hash='95A49C7B02CFA93DFDEC7F7E122D703E6A6003B2AE064B0EB61C22AB7C79410D'})
foreach($t in $tools){if((Get-FileHash -LiteralPath $t.Path -Algorithm SHA256).Hash -cne $t.Hash){throw 'STOP: qualified tool changed'}}
[pscustomobject]@{
 Decision='ADMINISTRATIVE_FILESET_PREFLIGHT_PASSED_SECURITY_METADATA_PENDING'
 ObservedAt=(Get-Date -Format o);Host=$env:COMPUTERNAME;Operator=$identity.Name;Elevated=$true
 Files=$files;PersistentCount=$files.Count;PersistentBytes=$total
 ExcludedTempdb=$excluded;Startup=$startup
 Service=[pscustomobject]@{Name=$service.Name;State=$service.State;Path=$service.PathName;Account=$service.StartName;ProcessId=$service.ProcessId;StartMode=$service.StartMode}
 ChildDirectories=@($dirs|ForEach-Object {Get-ChildItem -LiteralPath $_ -Directory -Force|Select-Object FullName})
 Volumes=$volumes;Partitions=$parts;NTFSTemporaryMinimum=$ntfsNeed;CiphertextMinimum=$eNeed
 ToolsMatched=$true;SqlConnection=$false;SourceContentsRead=$false;ServiceChanged=$false;SourcesChanged=$false;EWrites=$false
 Pending=@('Full SDDL/SACL and parent-directory metadata/hardlink qualification','Exact settings/local evidence allowlist','Private NTFS root ACL','Independent secret and decoder custody','Normal ERP closure','Stop/capture/verify/start')
}|ConvertTo-Json -Depth 7
