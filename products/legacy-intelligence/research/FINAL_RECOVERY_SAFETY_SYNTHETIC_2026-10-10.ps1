param([ValidateSet('Metadata','Interactive')][string]$Phase='Metadata')
$ErrorActionPreference='Stop'
$root='C:\Users\user\Documents\Codex\FRCSQ-20261010-7e3821a9'
if ($PSScriptRoot -cne $root -or (Get-Content -LiteralPath "$root\OWNERSHIP.txt" -Raw).Trim() -cne 'DBL_SYNTHETIC_ONLY FRCSQ 7e3821a9 2026-10-10') { throw 'Test-root identity mismatch' }
if ((Get-Item -LiteralPath $root).Attributes -band [IO.FileAttributes]::ReparsePoint) { throw 'Root is a reparse point' }
if (@(Get-ChildItem -LiteralPath $root -Recurse -Force | Where-Object {$_.Attributes -band [IO.FileAttributes]::ReparsePoint}).Count) {throw 'Reparse point in root'}
if ((Get-Volume -DriveLetter C).FileSystem -ne 'NTFS') {throw 'NTFS required'}
$gpg='C:\Program Files\Git\usr\bin\gpg.exe'; $gpgconf='C:\Program Files\Git\usr\bin\gpgconf.exe'; $tar='C:\Windows\System32\tar.exe'
if ((Get-FileHash -LiteralPath $gpg -Algorithm SHA256).Hash -ne 'A5140C85353E8399DA8D6BD7E3741524CD76A4E69BE88AF12042B1C9EF022984') {throw 'GPG changed'}
function Msys([string]$p) {if (-not $p.StartsWith($root+'\',[StringComparison]::OrdinalIgnoreCase)) {throw 'Path escaped root'}; '/c/'+$p.Substring(3).Replace('\','/')}
function Child([string]$exe,[string[]]$cli,[int]$timeout=60) {
    $si=[Diagnostics.ProcessStartInfo]::new($exe);$si.UseShellExecute=$false;$si.CreateNoWindow=$true;$si.WorkingDirectory=$root
    $si.RedirectStandardOutput=$true;$si.RedirectStandardError=$true
    $si.StandardOutputEncoding=[Text.UTF8Encoding]::new($false);$si.StandardErrorEncoding=[Text.UTF8Encoding]::new($false)
    foreach ($arg in $cli) {$si.ArgumentList.Add($arg)}
    $p=[Diagnostics.Process]::new();$p.StartInfo=$si
    try {
        $p.Start()|Out-Null;$o=$p.StandardOutput.ReadToEndAsync();$e=$p.StandardError.ReadToEndAsync()
        if (-not $p.WaitForExit($timeout*1000)) {$p.Kill();$p.WaitForExit();throw 'Owned child timed out; no global process kill'}
        [pscustomobject]@{Exit=$p.ExitCode;Out=$o.GetAwaiter().GetResult();Err=$e.GetAwaiter().GetResult()}
    }finally{$p.Dispose()}
}
function Status($r) {@($r.Err -split "`r?`n" | Where-Object {$_ -match '^\[GNUPG:\] (PINENTRY_LAUNCHED|BEGIN_ENCRYPTION|END_ENCRYPTION|DECRYPTION_INFO|DECRYPTION_OKAY|GOODMDC|BADMDC|DECRYPTION_FAILED|ERROR|FAILURE)( |$)'})}
function Progress([string]$value) {[pscustomobject]@{Phase=$value;At=(Get-Date -Format o)}|ConvertTo-Json|Set-Content -LiteralPath "$root\PROGRESS.json" -Encoding utf8NoBOM}
function SecurityRecord([string]$p,[string]$relative) {
    $a=Get-Acl -LiteralPath $p;$f=Get-Item -LiteralPath $p -Force
    $sections=[Security.AccessControl.AccessControlSections]::Owner -bor [Security.AccessControl.AccessControlSections]::Group -bor [Security.AccessControl.AccessControlSections]::Access
    [pscustomobject]@{Path=$relative;Directory=$f.PSIsContainer;OwnerSid=$a.GetOwner([Security.Principal.SecurityIdentifier]).Value;GroupSid=$a.GetGroup([Security.Principal.SecurityIdentifier]).Value;Sddl=$a.GetSecurityDescriptorSddlForm($sections);Protected=$a.AreAccessRulesProtected;Attributes=[int]$f.Attributes;CreationUtc=$f.CreationTimeUtc.ToString('o');WriteUtc=$f.LastWriteTimeUtc.ToString('o');AccessUtc=$f.LastAccessTimeUtc.ToString('o');Bytes=$(if($f.PSIsContainer){0}else{$f.Length});SHA256=$(if($f.PSIsContainer){$null}else{(Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash})}
}
function ValidateTar([string]$path,[string[]]$allowed) {
    Add-Type -AssemblyName System.Formats.Tar
    $stream=[IO.File]::OpenRead($path);$reader=[System.Formats.Tar.TarReader]::new($stream,$true)
    $seen=[Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase);$names=@();$total=0L
    try {
        while($null -ne ($entry=$reader.GetNextEntry($false))) {
            $name=$entry.Name
            if ($entry.EntryType.ToString() -notin @('RegularFile','Directory')) {throw 'FORBIDDEN_LINK_OR_TYPE'}
            if ($name -match '^[/\\]|^[A-Za-z]:' -or $name.Contains('\') -or $name.Contains(':')) {throw 'ABSOLUTE_OR_WINDOWS_NAMESPACE'}
            $canonical=$name.TrimEnd('/');$parts=$canonical.Split('/')
            if (-not $canonical -or @($parts|Where-Object {$_ -in @('','..','.') -or $_ -match '[. ]$|^(CON|PRN|AUX|NUL|COM[1-9]|LPT[1-9])(\.|$)'}).Count) {throw 'TRAVERSAL_OR_WINDOWS_ALIAS'}
            if (-not $seen.Add($canonical)) {throw 'DUPLICATE_OR_CASE_ALIAS'}
            if ($name -cnotin $allowed) {throw 'UNEXPECTED_MEMBER'}
            $total+=$entry.Length;$names+=$name
            if ($names.Count -gt 1000 -or $total -gt 1MB) {throw 'SYNTHETIC_BOUND_EXCEEDED'}
        }
        if ($names.Count -ne $allowed.Count) {throw 'INCOMPLETE_MEMBER_SET'}
        [pscustomobject]@{Names=$names;Bytes=$total;Safe=$true}
    }finally{$reader.Dispose();$stream.Dispose()}
}
function WriteAttack([string]$path,[string]$name,[string]$type='RegularFile',[bool]$validPrefix=$false) {
    Add-Type -AssemblyName System.Formats.Tar
    $f=[IO.File]::Open($path,[IO.FileMode]::CreateNew);$w=[System.Formats.Tar.TarWriter]::new($f,[System.Formats.Tar.TarEntryFormat]::Pax,$true)
    try {
        if ($validPrefix) {$prefix=[System.Formats.Tar.PaxTarEntry]::new([System.Formats.Tar.TarEntryType]::RegularFile,'payload/data.bin');$prefix.DataStream=[IO.MemoryStream]::new([byte[]]@(1,2,3));try{$w.WriteEntry($prefix)}finally{$prefix.DataStream.Dispose()}}
        $entry=[System.Formats.Tar.PaxTarEntry]::new([System.Enum]::Parse([System.Formats.Tar.TarEntryType],$type),$name)
        if ($type -in @('SymbolicLink','HardLink')) {$entry.LinkName='../outside.bin'} else {$entry.DataStream=[IO.MemoryStream]::new([byte[]]@(4,5,6))}
        try{$w.WriteEntry($entry)}finally{if($entry.DataStream){$entry.DataStream.Dispose()}}
    }finally{$w.Dispose();$f.Dispose()}
}
if ($Phase -eq 'Metadata') {
    if (@(Get-ChildItem -LiteralPath $root -Force).Count -ne 2) {throw 'Fresh fixture root required'}
    $source="$root\source";$restore="$root\metadata-restore";$guard="$root\negative-extraction"
    foreach($d in @($source,$restore,$guard,"$root\attacks","$root\private-gpg")){New-Item -ItemType Directory -Path $d|Out-Null}
    $sid=[Security.Principal.WindowsIdentity]::GetCurrent().User
    $protected=[Security.AccessControl.DirectorySecurity]::new();$protected.SetOwner($sid);$protected.SetGroup($sid);$protected.SetAccessRuleProtection($true,$false)
    foreach($identity in @($sid.Value,'S-1-5-18','S-1-5-32-544')) {$protected.AddAccessRule([Security.AccessControl.FileSystemAccessRule]::new([Security.Principal.SecurityIdentifier]::new($identity),'FullControl','ContainerInherit,ObjectInherit','None','Allow'))}
    Set-Acl -LiteralPath $source -AclObject $protected
    New-Item -ItemType Directory -Path "$source\payload"|Out-Null;New-Item -ItemType Directory -Path "$source\metadata"|Out-Null
    $data=[byte[]]::new(128KB);for($i=0;$i -lt $data.Length;$i++){$data[$i]=$i%251}
    [IO.File]::WriteAllBytes("$source\payload\data.bin",$data);[IO.File]::WriteAllText("$source\payload\inherited.txt",'DBL SYNTHETIC INHERITANCE',[Text.UTF8Encoding]::new($false))
    $explicit=Get-Acl -LiteralPath "$source\payload\data.bin";$explicit.SetAccessRuleProtection($true,$true)
    Set-Acl -LiteralPath "$source\payload\data.bin" -AclObject $explicit
    foreach($p in @("$source\payload\data.bin","$source\payload\inherited.txt")) {[IO.File]::SetCreationTimeUtc($p,[datetime]'2026-10-01T01:02:03Z');[IO.File]::SetLastWriteTimeUtc($p,[datetime]'2026-10-02T04:05:06Z');[IO.File]::SetLastAccessTimeUtc($p,[datetime]'2026-10-03T07:08:09Z')}
    [IO.File]::SetAttributes("$source\payload\data.bin",[IO.FileAttributes]::ReadOnly -bor [IO.FileAttributes]::Hidden -bor [IO.FileAttributes]::Archive)
    $records=@(SecurityRecord $source '.';SecurityRecord "$source\payload" 'payload';SecurityRecord "$source\payload\data.bin" 'payload/data.bin';SecurityRecord "$source\payload\inherited.txt" 'payload/inherited.txt')
    $sacl='UNRESOLVED';try {$audit=Get-Acl -LiteralPath "$source\payload\data.bin" -Audit;$sacl='READ_SUCCEEDED_NOT_REPLAY_TESTED'}catch{$sacl='BLOCKED_CURRENT_TOKEN_NO_SACL_READ';$saclError=$_.Exception.GetType().FullName}
    $manifest=[pscustomobject]@{Schema='DBL_SYNTHETIC_NTFS_MANIFEST_V1';Scope='synthetic-only same-host';Files=$records;Sacl=$sacl;SaclError=$saclError;OwnerReplayScope='current user SID only; no arbitrary-owner privilege'}
    $manifest|ConvertTo-Json -Depth 10|Set-Content -LiteralPath "$source\metadata\manifest.json" -Encoding utf8NoBOM
    foreach($r in $records|Where-Object Directory){if($r.Path -ne '.'){New-Item -ItemType Directory -Path (Join-Path $restore $r.Path)|Out-Null}}
    foreach($r in $records|Where-Object {-not $_.Directory}){Copy-Item -LiteralPath (Join-Path $source $r.Path) -Destination (Join-Path $restore $r.Path)}
    $roundTrip=@()
    foreach($r in $records){
        $destination=if($r.Path -eq '.'){$restore}else{Join-Path $restore $r.Path}
        $sec=if($r.Directory){[Security.AccessControl.DirectorySecurity]::new()}else{[Security.AccessControl.FileSecurity]::new()}
        $sec.SetSecurityDescriptorSddlForm($r.Sddl,[Security.AccessControl.AccessControlSections]::Owner -bor [Security.AccessControl.AccessControlSections]::Group -bor [Security.AccessControl.AccessControlSections]::Access)
        Set-Acl -LiteralPath $destination -AclObject $sec
        if(-not $r.Directory -and (Get-FileHash -LiteralPath $destination -Algorithm SHA256).Hash -ne $r.SHA256){throw 'Restored content mismatch'}
    }
    foreach($r in @($records|Sort-Object { $_.Path.Length } -Descending)){
        $destination=if($r.Path -eq '.'){$restore}else{Join-Path $restore $r.Path}
        [IO.File]::SetAttributes($destination,[IO.FileAttributes]$r.Attributes)
        if($r.Directory){[IO.Directory]::SetCreationTimeUtc($destination,[datetime]$r.CreationUtc);[IO.Directory]::SetLastWriteTimeUtc($destination,[datetime]$r.WriteUtc);[IO.Directory]::SetLastAccessTimeUtc($destination,[datetime]$r.AccessUtc)}else{[IO.File]::SetCreationTimeUtc($destination,[datetime]$r.CreationUtc);[IO.File]::SetLastWriteTimeUtc($destination,[datetime]$r.WriteUtc);[IO.File]::SetLastAccessTimeUtc($destination,[datetime]$r.AccessUtc)}
        $now=SecurityRecord $destination $r.Path
        foreach($field in @('OwnerSid','GroupSid','Sddl','Protected','Attributes','CreationUtc','WriteUtc','AccessUtc','Bytes','SHA256')){if($now.$field -cne $r.$field){throw "Metadata mismatch: $($r.Path) $field"}}
        $roundTrip+=[pscustomobject]@{Path=$r.Path;OwnerDaclAttributesUtcHashes='MATCH';OwnerSid=$r.OwnerSid;Protected=$r.Protected}
    }
    $allowed=@('payload/','payload/data.bin','payload/inherited.txt','metadata/','metadata/manifest.json')
    $pack=Child $tar @('-cf',"$root\package.tar",'-C',$source,'payload','metadata');if($pack.Exit -ne 0){throw 'TAR creation failed'}
    $valid=ValidateTar "$root\package.tar" $allowed
    $cases=@(
        @{Case='traversal';Name='../outside.bin';Expected='TRAVERSAL_OR_WINDOWS_ALIAS'},
        @{Case='late-traversal';Name='payload/../../outside.bin';Expected='TRAVERSAL_OR_WINDOWS_ALIAS';Prefix=$true},
        @{Case='absolute-posix';Name='/outside.bin';Expected='ABSOLUTE_OR_WINDOWS_NAMESPACE'},
        @{Case='absolute-windows';Name='C:/outside.bin';Expected='ABSOLUTE_OR_WINDOWS_NAMESPACE'},
        @{Case='drive-relative';Name='C:outside.bin';Expected='ABSOLUTE_OR_WINDOWS_NAMESPACE'},
        @{Case='unc';Name='//server/share/outside.bin';Expected='ABSOLUTE_OR_WINDOWS_NAMESPACE'},
        @{Case='backslash';Name='payload\..\outside.bin';Expected='ABSOLUTE_OR_WINDOWS_NAMESPACE'},
        @{Case='symlink';Name='payload/data.bin';Type='SymbolicLink';Expected='FORBIDDEN_LINK_OR_TYPE'},
        @{Case='hardlink';Name='payload/data.bin';Type='HardLink';Expected='FORBIDDEN_LINK_OR_TYPE'},
        @{Case='duplicate';Name='payload/data.bin';Prefix=$true;Expected='DUPLICATE_OR_CASE_ALIAS'},
        @{Case='case-alias';Name='PAYLOAD/DATA.BIN';Prefix=$true;Expected='DUPLICATE_OR_CASE_ALIAS'},
        @{Case='ads';Name='payload/data.bin:secret';Expected='ABSOLUTE_OR_WINDOWS_NAMESPACE'})
    $negative=@()
    foreach($c in $cases){$type=if($c.Type){$c.Type}else{'RegularFile'};$attack="$root\attacks\$($c.Case).tar";WriteAttack $attack $c.Name $type ([bool]$c.Prefix);$reason=$null;try{$null=ValidateTar $attack $allowed}catch{$reason=$_.Exception.Message};if($reason -cne $c.Expected){throw "Negative TAR test failed: $($c.Case)"};if(@(Get-ChildItem -LiteralPath $guard -Force -Recurse).Count){throw 'Negative extraction destination changed'};$negative+=[pscustomobject]@{Case=$c.Case;Rejected=$reason;ExtractInvocations=0;DestinationEntries=0;SHA256=(Get-FileHash -LiteralPath $attack -Algorithm SHA256).Hash}}
    [pscustomobject]@{At=(Get-Date -Format o);Metadata='PASSED_BOUNDED_CURRENT_USER';RoundTrip=$roundTrip;Sacl=$sacl;ArbitraryOwner='NOT_QUALIFIED_WITH_CURRENT_TOKEN';TarNegatives=$negative;Allowed=$allowed;PackageHash=(Get-FileHash -LiteralPath "$root\package.tar" -Algorithm SHA256).Hash;PackageBytes=(Get-Item -LiteralPath "$root\package.tar").Length}|ConvertTo-Json -Depth 10|Set-Content -LiteralPath "$root\METADATA_RESULT.json" -Encoding utf8NoBOM
    Progress 'METADATA_AND_TAR_GUARDS_PASSED'
    Get-Content -LiteralPath "$root\METADATA_RESULT.json" -Raw
} else {
    if (-not(Test-Path -LiteralPath "$root\METADATA_RESULT.json") -or (Test-Path -LiteralPath "$root\package.tar.gpg")){throw 'Interactive fresh-acquisition guard failed'}
    $gpgHome="$root\private-gpg";$gpgHomeMsys=Msys $gpgHome
    # Only this private synthetic session configuration is written; no global GPG/Windows setting.
    'pinentry-program /c/Program Files/Git/usr/bin/pinentry-w32.exe','no-allow-external-cache'|Set-Content -LiteralPath "$gpgHome\gpg-agent.conf" -Encoding utf8NoBOM
    $base=@('--no-options','--homedir',$gpgHomeMsys,'--batch','--no-tty','--pinentry-mode','ask','--no-symkey-cache','--status-fd','2')
    $record=[ordered]@{Decision='BLOCKED';Mode='native Pinentry ask; no passphrase transport in harness';At=(Get-Date -Format o)}
    try {
        $socket=Child $gpgconf @('--homedir',$gpgHomeMsys,'--list-dirs','socketdir');if($socket.Exit -ne 0 -or $socket.Out.Trim() -cne $gpgHomeMsys){throw 'Agent socket outside owned root'}
        Progress 'PINENTRY_ENCRYPT_WAITING'
        $enc=Child $gpg ($base+@('--cipher-algo','AES256','--force-ocb','--s2k-mode','3','--s2k-digest-algo','SHA256','--s2k-count','65011712','--compress-algo','none','--symmetric','--output',(Msys "$root\package.tar.gpg"),(Msys "$root\package.tar"))) 600
        $record.EncryptionExit=$enc.Exit;$record.EncryptionStatus=Status $enc
        if($enc.Exit -ne 0){throw 'Interactive encryption failed; raw output suppressed'}
        if(-not($record.EncryptionStatus -match '^\[GNUPG:\] PINENTRY_LAUNCHED ')){throw 'Native Pinentry launch was not observed'}
        $stop=Child $gpgconf @('--homedir',$gpgHomeMsys,'--kill','gpg-agent');if($stop.Exit -ne 0){throw 'Scoped agent restart failed'}
        Progress 'PINENTRY_DECRYPT_WAITING'
        $pending="$root\verified.pending.tar"
        if(Test-Path -LiteralPath $pending){throw 'Quarantine already exists'}
        $dec=Child $gpg ($base+@('--decrypt','--output',(Msys $pending),(Msys "$root\package.tar.gpg"))) 600
        $record.DecryptionExit=$dec.Exit;$record.DecryptionStatus=Status $dec
        if($dec.Exit -ne 0 -or -not($record.DecryptionStatus -match '^\[GNUPG:\] DECRYPTION_OKAY$') -or -not($record.DecryptionStatus -match '^\[GNUPG:\] PINENTRY_LAUNCHED ') -or -not($record.DecryptionStatus -match '^\[GNUPG:\] DECRYPTION_INFO 0 9 2$')){throw 'Authenticated interactive decode did not pass'}
        $baseline=Get-Content -LiteralPath "$root\METADATA_RESULT.json" -Raw|ConvertFrom-Json
        if((Get-FileHash -LiteralPath $pending -Algorithm SHA256).Hash -cne $baseline.PackageHash){throw 'Decoded package hash differs'}
        $safe=ValidateTar $pending $baseline.Allowed
        Move-Item -LiteralPath $pending -Destination "$root\verified.tar" -ErrorAction Stop
        $verifiedRestore="$root\authenticated-extraction";New-Item -ItemType Directory -Path $verifiedRestore|Out-Null
        $extract=Child $tar @('-xf',"$root\verified.tar",'-C',$verifiedRestore);if($extract.Exit -ne 0){throw 'Verified extraction failed'}
        foreach($p in @('payload/data.bin','payload/inherited.txt','metadata/manifest.json')){if((Get-FileHash -LiteralPath (Join-Path $verifiedRestore $p) -Algorithm SHA256).Hash -cne (Get-FileHash -LiteralPath (Join-Path "$root\source" $p) -Algorithm SHA256).Hash){throw 'Positive extraction identity differs'}}
        Copy-Item -LiteralPath "$root\package.tar.gpg" -Destination "$root\truncated.gpg"
        $alter=[IO.File]::Open("$root\truncated.gpg",[IO.FileMode]::Open,[IO.FileAccess]::Write);try{$alter.SetLength($alter.Length-17)}finally{$alter.Dispose()}
        $stop2=Child $gpgconf @('--homedir',$gpgHomeMsys,'--kill','gpg-agent');if($stop2.Exit -ne 0){throw 'Negative-test agent restart failed'}
        Progress 'PINENTRY_AUTHENTICATION_FAILURE_TEST_WAITING'
        $failedPending="$root\failed-auth.pending.tar"
        $bad=Child $gpg ($base+@('--decrypt','--output',(Msys $failedPending),(Msys "$root\truncated.gpg"))) 600
        $record.NegativeExit=$bad.Exit;$record.NegativeStatus=Status $bad
        if($bad.Exit -eq 0 -or -not($record.NegativeStatus -match '^\[GNUPG:\] (BADMDC|DECRYPTION_FAILED)( |$)')){throw 'Corrupt-ciphertext auth rejection not proved'}
        $record.NegativePartialBytes=if(Test-Path -LiteralPath $failedPending){(Get-Item -LiteralPath $failedPending).Length}else{0}
        $record.NegativeExtractInvocations=0;$record.FailedPendingPromoted=$false
        if(Test-Path -LiteralPath "$root\failed-auth.tar"){throw 'Failed plaintext was promoted'}
        if(@(Get-ChildItem -LiteralPath "$root\negative-extraction" -Recurse -Force).Count){throw 'Negative extraction destination changed'}
        $record.PositiveAuthentication='EXIT0_PLUS_DECRYPTION_OKAY_ALGO9_2_HASH_MEMBERS_BEFORE_PROMOTION_AND_EXTRACTION';$record.Decision='INTERACTIVE_AND_QUARANTINE_QUALIFIED';$record.CompletedAt=Get-Date -Format o
    }catch{$record.Failure=$_.Exception.Message;Progress 'INTERACTIVE_BLOCKED'}finally{
        $cleanup=Child $gpgconf @('--homedir',$gpgHomeMsys,'--kill','gpg-agent');$record.AgentCleanup=if($cleanup.Exit -eq 0){'SCOPED_STOPPED'}else{'FAILED'}
        if($cleanup.Exit -ne 0){$record.Decision='BLOCKED'}
        $record|ConvertTo-Json -Depth 8|Set-Content -LiteralPath "$root\INTERACTIVE_RESULT.json" -Encoding utf8NoBOM
    }
    Get-Content -LiteralPath "$root\INTERACTIVE_RESULT.json" -Raw
}
