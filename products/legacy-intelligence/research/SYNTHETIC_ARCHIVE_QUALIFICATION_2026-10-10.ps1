param([switch]$ResumeFixtures)
$ErrorActionPreference = 'Stop'
$root = 'C:\Users\user\Documents\Codex\SAQ-20261010-b6f1a72c'
$gpg = 'C:\Program Files\Git\usr\bin\gpg.exe'
$gpgconf = 'C:\Program Files\Git\usr\bin\gpgconf.exe'
$tar = 'C:\Windows\System32\tar.exe'
$expectedGpgHash = 'A5140C85353E8399DA8D6BD7E3741524CD76A4E69BE88AF12042B1C9EF022984'
if ($PSScriptRoot -ne $root -or (Get-Content -LiteralPath "$root\OWNERSHIP.txt" -Raw).Trim() -ne 'DBL_SYNTHETIC_ONLY b6f1a72c 2026-10-10') { throw 'Synthetic root identity mismatch' }
if (-not $ResumeFixtures -and @(Get-ChildItem -LiteralPath $root -Force).Count -ne 2) { throw 'Root must contain only the initial script and ownership marker' }
if ($ResumeFixtures) {
    if (Test-Path -LiteralPath "$root\package.tar.gpg") { throw 'Resume is allowed only before encryption' }
    if (@(Get-ChildItem -LiteralPath $root -Force -Recurse | Where-Object { $_.Attributes -band [IO.FileAttributes]::ReparsePoint }).Count) { throw 'Reparse point in owned root' }
    $allowedTop=@('Run-SyntheticQualification.ps1','OWNERSHIP.txt','RESULT.json','package.tar','source','restore','gnupg')
    if (@(Get-ChildItem -LiteralPath $root -Force | Where-Object {$_.Name -notin $allowedTop}).Count) { throw 'Unexpected test-root entry' }
    $previousResult=Get-Content -LiteralPath "$root\RESULT.json" -Raw | ConvertFrom-Json
    if ($previousResult.Failure -ne 'TAR member set mismatch') { throw 'Resume requires the diagnosed text-listing-only failure' }
}
if ((Get-Volume -DriveLetter C).FileSystem -ne 'NTFS') { throw 'Root is not on expected NTFS volume' }
if ((Get-FileHash -LiteralPath $gpg -Algorithm SHA256).Hash -ne $expectedGpgHash) { throw 'Qualified GPG binary changed' }
if ((Get-Volume -DriveLetter C).SizeRemaining -lt 4GB) { throw 'Insufficient bounded synthetic workspace' }
$started = Get-Date -Format o
$gpgHome = "$root\gnupg"
function GpgPath([string]$p) { if (-not $p.StartsWith($root + '\', [StringComparison]::OrdinalIgnoreCase)) { throw 'GPG path escaped root' }; '/c/' + $p.Substring(3).Replace('\','/') }
$gpgHomeUnix = GpgPath $gpgHome
function Invoke-Child([string]$exe, [string[]]$cli, $pipeSecret = $null, [int]$seconds = 60) {
    $si = [Diagnostics.ProcessStartInfo]::new($exe)
    $si.UseShellExecute = $false; $si.CreateNoWindow = $true; $si.WorkingDirectory = $root
    $si.RedirectStandardOutput = $true; $si.RedirectStandardError = $true
    $si.StandardOutputEncoding = [Text.UTF8Encoding]::new($false); $si.StandardErrorEncoding = [Text.UTF8Encoding]::new($false)
    foreach ($arg in $cli) { $si.ArgumentList.Add($arg) }
    if ($null -ne $pipeSecret) {
        if (@($cli | Where-Object { $_.Contains($pipeSecret) }).Count -ne 0) { throw 'Secret in arguments' }
        $si.RedirectStandardInput = $true
    }
    $p = [Diagnostics.Process]::new(); $p.StartInfo = $si
    try {
        $p.Start() | Out-Null
        $outTask = $p.StandardOutput.ReadToEndAsync(); $errTask = $p.StandardError.ReadToEndAsync()
        if ($null -ne $pipeSecret) {
            $secretBytes = [Text.Encoding]::UTF8.GetBytes($pipeSecret + "`n")
            try { $p.StandardInput.BaseStream.Write($secretBytes,0,$secretBytes.Length); $p.StandardInput.Close() }
            finally { [Array]::Clear($secretBytes) }
        }
        if (-not $p.WaitForExit($seconds * 1000)) { $p.Kill(); $p.WaitForExit(); throw 'Only the owned child was terminated after its timeout' }
        $outText = $outTask.GetAwaiter().GetResult(); $errText = $errTask.GetAwaiter().GetResult()
        if ($null -ne $pipeSecret -and ($outText.Contains($pipeSecret) -or $errText.Contains($pipeSecret))) { throw 'Secret appeared in child output; output suppressed' }
        [pscustomobject]@{Exit=$p.ExitCode;Out=$outText;Err=$errText}
    } finally { $p.Dispose() }
}
function Status-Lines($r) { @($r.Err -split "`r?`n" | Where-Object { $_ -match '^\[GNUPG:\] (DECRYPTION_INFO|DECRYPTION_OKAY|DECRYPTION_FAILED|GOODMDC|BADMDC|BEGIN_ENCRYPTION|END_ENCRYPTION|ERROR|FAILURE)( |$)' }) }
function Assert-Exit($r, [string]$phase) { if ($r.Exit -ne 0) { throw "$phase failed, exit $($r.Exit); raw driver output suppressed" } }
function Relative([string]$path) { $path.Substring($root.Length+1).Replace('\','/') }
function Fingerprint([string]$base) {
    @(Get-ChildItem -LiteralPath $base -File -Recurse -Force | Sort-Object FullName | ForEach-Object {
        [pscustomobject]@{Path=$_.FullName.Substring($base.Length+1).Replace('\','/');Bytes=$_.Length;SHA256=(Get-FileHash -LiteralPath $_.FullName -Algorithm SHA256).Hash}
    })
}
function Read-TarMembers([string]$path) {
    Add-Type -AssemblyName System.Formats.Tar
    $stream=[IO.File]::OpenRead($path); $reader=[System.Formats.Tar.TarReader]::new($stream,$true); $names=@()
    try {
        while ($null -ne ($entry=$reader.GetNextEntry($false))) {
            if ($entry.EntryType.ToString() -notin @('Directory','RegularFile')) { throw 'Unexpected TAR entry type' }
            $names += $entry.Name
        }
    } finally { $reader.Dispose(); $stream.Dispose() }
    $names
}
function Assert-Same($a,$b,[string]$label) { if (($a | ConvertTo-Json -Depth 5 -Compress) -cne ($b | ConvertTo-Json -Depth 5 -Compress)) { throw "$label mismatch" } }
$source = "$root\source"; $payload = "$source\payload"; $metadata = "$source\metadata"
$archive = "$root\package.tar"; $cipher = "$root\package.tar.gpg"; $decoded = "$root\decoded.tar"; $restore = "$root\restore"
$sessionSecret = $null; $wrongSecret = $null; $results = [ordered]@{}
try {
    if (-not $ResumeFixtures) {
    foreach ($dir in @($gpgHome,$payload,$metadata,$restore,"$payload\space folder","$payload\unicode")) { New-Item -ItemType Directory -Path $dir -ErrorAction Stop | Out-Null }
    }
    $socketCheck = Invoke-Child $gpgconf @('--homedir',$gpgHomeUnix,'--list-dirs','socketdir')
    Assert-Exit $socketCheck 'Socket directory check'
    if ($socketCheck.Out.Trim() -ne $gpgHomeUnix) { throw 'GPG socket directory is outside owned root' }
    if (-not $ResumeFixtures) {
    [IO.File]::WriteAllBytes("$payload\empty.bin",[byte[]]@())
    [IO.File]::WriteAllText("$payload\ascii.txt","DBL SYNTHETIC ONLY`r`n",[Text.UTF8Encoding]::new($false))
    [IO.File]::WriteAllText("$payload\space folder\test file.txt","synthetic spaces`n",[Text.UTF8Encoding]::new($false))
    [IO.File]::WriteAllText("$payload\unicode\بيانات تجريبية.txt","هذه بيانات وهمية فقط`n",[Text.UTF8Encoding]::new($false))
    [IO.File]::WriteAllBytes("$payload\unicode\测试.bin",[byte[]]@(0,1,2,127,128,254,255))
    $longDir = $payload
    for ($i=1; $i -le 6; $i++) { $longDir = Join-Path $longDir ("segment_1234567890_$i"); New-Item -ItemType Directory -Path $longDir | Out-Null }
    [IO.File]::WriteAllText("$longDir\long-path-file.txt",'synthetic path',[Text.UTF8Encoding]::new($false))
    $buffer = [byte[]]::new(1MB); for ($i=0; $i -lt $buffer.Length; $i++) { $buffer[$i] = $i % 251 }
    $large = [IO.File]::Open("$payload\synthetic-sql-size-257MiB.bin",[IO.FileMode]::CreateNew,[IO.FileAccess]::Write,[IO.FileShare]::None)
    try { for ($i=0;$i -lt 257;$i++) { $large.Write($buffer,0,$buffer.Length) }; $large.Flush($true) } finally { $large.Dispose() }
    $payloadBefore = Fingerprint $payload
    $payloadBefore | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath "$metadata\manifest.json" -Encoding utf8NoBOM
    } else {
        $payloadBefore=Fingerprint $payload
        $recordedPayload=@(Get-Content -LiteralPath "$metadata\manifest.json" -Raw | ConvertFrom-Json)
        Assert-Same $recordedPayload $payloadBefore 'Owned fixture hashes before resume'
        if ($payloadBefore.Count -ne 7 -or ($payloadBefore | Where-Object Path -eq 'synthetic-sql-size-257MiB.bin').Bytes -ne 269484032) { throw 'Fixture identity/size mismatch' }
        if (@(Get-ChildItem -LiteralPath $restore -Force).Count) { throw 'Restore destination is not empty' }
    }
    $sourceBefore = Fingerprint $source
    if (-not $ResumeFixtures) {
    $create = Invoke-Child $tar @('-cf',$archive,'-C',$source,'payload','metadata')
    Assert-Exit $create 'TAR creation'
    }
    $list = Invoke-Child $tar @('-tf',$archive); Assert-Exit $list 'TAR listing'
    $members = @(Read-TarMembers $archive)
    $expectedFiles = @($sourceBefore.Path)
    $listedFiles = @($members | Where-Object { -not $_.EndsWith('/') } | Sort-Object)
    $expectedSorted = @($expectedFiles | Sort-Object)
    Assert-Same $listedFiles $expectedSorted 'TAR member set'
    $expectedDirectories=@(Get-ChildItem -LiteralPath $source -Directory -Recurse | ForEach-Object {$_.FullName.Substring($source.Length+1).Replace('\','/')+'/'} | Sort-Object)
    $actualDirectories=@($members | Where-Object {$_.EndsWith('/')} | Sort-Object)
    Assert-Same $actualDirectories $expectedDirectories 'TAR directory set'
    foreach ($member in $members) { if ($member -match '^[/\\]|^[A-Za-z]:|(^|[/\\])\.\.([/\\]|$)' -or $member.Contains('\')) { throw 'Unsafe archive path' } }
    if (@($members | Group-Object | Where-Object Count -gt 1).Count) { throw 'Duplicate TAR member' }
    $tarHash = (Get-FileHash -LiteralPath $archive -Algorithm SHA256).Hash
    $sessionSecret = [Convert]::ToBase64String([Security.Cryptography.RandomNumberGenerator]::GetBytes(32))
    $wrongSecret = [Convert]::ToBase64String([Security.Cryptography.RandomNumberGenerator]::GetBytes(32))
    $baseCli = @('--no-options','--homedir',$gpgHomeUnix,'--batch','--pinentry-mode','loopback','--passphrase-fd','0','--no-symkey-cache','--status-fd','2')
    $encCli = $baseCli + @('--cipher-algo','AES256','--force-ocb','--s2k-mode','3','--s2k-digest-algo','SHA256','--s2k-count','65011712','--compress-algo','none','--symmetric','--output',(GpgPath $cipher),(GpgPath $archive))
    $enc = Invoke-Child $gpg $encCli $sessionSecret 60; Assert-Exit $enc 'AES256/OCB encryption'
    $kill1 = Invoke-Child $gpgconf @('--homedir',$gpgHomeUnix,'--kill','gpg-agent'); Assert-Exit $kill1 'Scoped GPG-agent termination'
    $decCli = $baseCli + @('--decrypt','--output',(GpgPath $decoded),(GpgPath $cipher))
    $dec = Invoke-Child $gpg $decCli $sessionSecret 60; Assert-Exit $dec 'Authenticated decryption'
    $decStatus = Status-Lines $dec
    if (-not ($decStatus -match '^\[GNUPG:\] DECRYPTION_INFO 0 9 2$') -or -not ($decStatus -match '^\[GNUPG:\] DECRYPTION_OKAY$')) { throw 'Actual AES256/OCB status was not proven' }
    if ((Get-FileHash -LiteralPath $decoded -Algorithm SHA256).Hash -ne $tarHash) { throw 'Decoded TAR hash mismatch' }
    $relist = Invoke-Child $tar @('-tf',$decoded); Assert-Exit $relist 'Decoded TAR listing'
    $decodedMembers=@(Read-TarMembers $decoded)
    Assert-Same $decodedMembers $members 'Decoded TAR paths'
    $extract = Invoke-Child $tar @('-xf',$decoded,'-C',$restore); Assert-Exit $extract 'Quarantine extraction'
    $restored = Fingerprint $restore; Assert-Same $sourceBefore $restored 'Restored file hashes/counts/lengths'
    $finalSource = Fingerprint $source; Assert-Same $sourceBefore $finalSource 'Source preservation'
    $cipherHashBefore = (Get-FileHash -LiteralPath $cipher -Algorithm SHA256).Hash
    $negative = @()
    foreach ($case in @('wrong-password','tampered-body','truncated-tail')) {
        $caseInput = $cipher; $caseSecret = $sessionSecret
        if ($case -eq 'wrong-password') { $caseSecret = $wrongSecret }
        else {
            $caseInput = "$root\$case.gpg"; Copy-Item -LiteralPath $cipher -Destination $caseInput -ErrorAction Stop
            $edit = [IO.File]::Open($caseInput,[IO.FileMode]::Open,[IO.FileAccess]::ReadWrite,[IO.FileShare]::None)
            try {
                if ($case -eq 'tampered-body') { $offset=[long]($edit.Length/2); $edit.Position=$offset; $b=$edit.ReadByte(); $edit.Position=$offset; $edit.WriteByte([byte]($b -bxor 128)) }
                else { $edit.SetLength($edit.Length - 17) }; $edit.Flush($true)
            } finally { $edit.Dispose() }
        }
        $caseOutput = "$root\$case.pending.tar"
        $bad = Invoke-Child $gpg ($baseCli + @('--decrypt','--output',(GpgPath $caseOutput),(GpgPath $caseInput))) $caseSecret 60
        if ($bad.Exit -eq 0) { throw "Negative test $case was accepted" }
        $negative += [pscustomobject]@{Case=$case;Exit=$bad.Exit;Status=(Status-Lines $bad);PartialPlaintextBytes=$(if (Test-Path -LiteralPath $caseOutput) { (Get-Item -LiteralPath $caseOutput).Length } else {0});Extracted=$false}
    }
    if ((Get-FileHash -LiteralPath $cipher -Algorithm SHA256).Hash -ne $cipherHashBefore) { throw 'Original ciphertext changed' }
    $results = [ordered]@{Decision='SYNTHETIC QUALIFIED';StartedAt=$started;CompletedAt=(Get-Date -Format o);Root=$root;Filesystem='NTFS';PasswordTransport='32 random bytes base64; anonymous redirected stdin FD0; never argv/env/file; loopback for synthetic only';ActualDecryptionStatus=$decStatus;EncryptionStatus=(Status-Lines $enc);PayloadFiles=$payloadBefore;SourceMembers=$sourceBefore;TarBytes=(Get-Item -LiteralPath $archive).Length;CiphertextBytes=(Get-Item -LiteralPath $cipher).Length;TarSHA256=$tarHash;CiphertextSHA256=$cipherHashBefore;MaxSourcePathChars=(@(Get-ChildItem -LiteralPath $source -File -Recurse | ForEach-Object {$_.FullName.Length}) | Measure-Object -Maximum).Maximum;NegativeTests=$negative;AgentRestartBeforeDecrypt=$true;TarPathsAndRestoredFiles='EXACT MATCH';TarMemberVerifier='Independent System.Formats.Tar.TarReader, not locale-dependent tar -t text';NativeTarTextListingUnicode='DISPLAY LOSS; not an authoritative Unicode validator';PinentryRealRecovery='NOT TESTED';Over4GiB='NOT TESTED';ACLReplay='NOT TESTED';Edrive='NOT TOUCHED';ERP_SQL='NOT READ OR CHANGED'}
} catch {
    $safeMessage=$_.Exception.Message
    if ($sessionSecret) { $safeMessage=$safeMessage.Replace($sessionSecret,'[REDACTED]') }
    if ($wrongSecret) { $safeMessage=$safeMessage.Replace($wrongSecret,'[REDACTED]') }
    $results=[ordered]@{Decision='BLOCKED';StartedAt=$started;Failure=$safeMessage;Root=$root}
} finally {
    $sessionSecret=$null; $wrongSecret=$null
    if (Test-Path -LiteralPath $gpgHome) {
        $agentExit=Invoke-Child $gpgconf @('--homedir',$gpgHomeUnix,'--kill','gpg-agent')
        if ($agentExit.Exit -ne 0) { $results.Decision='BLOCKED'; $results['AgentCleanup']='FAILED; no broad process termination' }
        else { $results['AgentCleanup']='SCOPED GPG-AGENT STOPPED' }
    }
}
$results | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath "$root\RESULT.json" -Encoding utf8NoBOM
$results | ConvertTo-Json -Depth 10
