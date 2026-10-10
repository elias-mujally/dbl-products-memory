[CmdletBinding()]
param([switch]$PreflightOnly)
# OWNER APPROVED: one CSP24 non-exportable machine key and public PKCS10 request.
# No CA unlock/signing, certificate acceptance, TLS/TCP/Browser/SQL/service mutation.
$ErrorActionPreference='Stop'
Set-StrictMode -Version Latest
$csrPhase='Identity';$csrConsumed=$false;$csrNative=$null;$csrStillRunning=$false
$csrPendingCert=$null;$csrPrivate=$null;$csrPublic=$null;$csrRequestPublic=$null
$csrRoot='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010'
$csrAttempt=Join-Path $csrRoot 'YSEDU_LEAF_CSR_ATTEMPT.json'
$csrResult=Join-Path $csrRoot 'YSEDU_LEAF_CSR_RESULT.json'
$csrPath=Join-Path $csrRoot 'YSEDU-Leaf-CSP24-001.req'
function Write-CsrNew([string]$Path,[byte[]]$Bytes){$s=[IO.File]::Open($Path,[IO.FileMode]::CreateNew,[IO.FileAccess]::Write,[IO.FileShare]::None);try{$s.Write($Bytes,0,$Bytes.Length);$s.Flush($true)}finally{$s.Dispose()}}
function Get-CsrStoreFingerprint {
 $lines=@(foreach($p in @('Cert:\CurrentUser\My','Cert:\CurrentUser\Root','Cert:\LocalMachine\My','Cert:\LocalMachine\Root')){Get-ChildItem -LiteralPath $p|ForEach-Object {$p+'|'+$_.Thumbprint}})
 return [Convert]::ToHexString([Security.Cryptography.SHA256]::HashData([Text.Encoding]::UTF8.GetBytes((@($lines|Sort-Object)-join "`n"))))
}
try {
 $who=[Security.Principal.WindowsPrincipal]::new([Security.Principal.WindowsIdentity]::GetCurrent())
 if($env:COMPUTERNAME -cne 'DESKTOP-8QRQT7R' -or -not $who.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator) -or $PSVersionTable.PSVersion -lt [version]'7.6'){throw 'STOP: exact host, actual administrative token and PS7.6 required'}
 foreach($p in @($csrAttempt,$csrResult,$csrPath)){if(Test-Path -LiteralPath $p){throw 'STOP: existing attempt/result/request; no overwrite or retry'}}
 $csrPhase='PinnedArtifactsAndOriginals'
 $pins=@{
  'YSEDU_LEAF_MAINTENANCE_ORIGINAL.json'='BB3BF707DCEEDB99396BF2C598B3A0E9BF2E02E83F3FD7AE3A8DB27CF1931BD5'
  'Restore-YseduLeafNetwork001.ps1'='B4BDAABC3802BBE4AE34C196AEE4A49CFED17328311CD2F6C2D5781532217B35'
  'Read-YseduCsr001.ps1'='434399B81762918BFCB6305E1555DF9634407177E597BC7C802E3105EE9D9D8F'
  'YSEDU-Leaf-CSP24-001.inf'='82B55E5092553DCA5AEFDF4905259AA9832C9B74A8B7004C8D78467590A88ECF'
  'Read-BrowserExposure001.ps1'='0367AAB24C897A6D7964507AE4E1F0C1D8845A430D50D564115889C11AFD786B'
 }
 foreach($pair in $pins.GetEnumerator()){if((Get-FileHash -LiteralPath (Join-Path $csrRoot $pair.Key) -Algorithm SHA256).Hash -cne $pair.Value){throw 'STOP: pinned artifact mismatch'}}
 if((Get-FileHash -LiteralPath 'E:\DBL-Lab-CA-YSEDU-001\ca-public.cer' -Algorithm SHA256).Hash -cne 'A3FBC7905425B2E8C10F3A070B8713F876B94FC42B8D1243DEAD5D0F42889472' -or (Get-FileHash -LiteralPath 'E:\DBL-Lab-CA-YSEDU-001\ca-signing-key.pfx' -Algorithm SHA256).Hash -cne '7C8FD60E8997AEDDA3C445E900BD5C1F685D9929ABC89BF9E20818354A862E32'){throw 'STOP: retained CA artifact changed'}
 $exe='C:\Windows\System32\certreq.exe'
 if((Get-FileHash -LiteralPath $exe -Algorithm SHA256).Hash -cne '07480DC8CAD237515BCEA89F8566E58EA360B57B20AD025E8AEA83EC24106AC1' -or [string](Get-AuthenticodeSignature -LiteralPath $exe).Status -cne 'Valid'){throw 'STOP: certreq identity'}
 $csrPhase='CombinedRollbackBaselineInspection'
 $comparison=(& ([scriptblock]::Create((Get-Content -LiteralPath (Join-Path $csrRoot 'Restore-YseduLeafNetwork001.ps1') -Raw))) -RequireBaseline) -join "`n"
 $rb=$comparison|ConvertFrom-Json
 if($rb.Decision -cne 'YSEDU_COMBINED_ROLLBACK_INSPECTION_PASSED' -or $rb.ApplyRequested -ne $false -or @($rb.Changes).Count -or $rb.OwnedLeafCount -ne 0){throw 'STOP: rollback inspection not baseline'}
 $csrPhase='FreshBrowserClientsAndStores'
 $browser=((& ([scriptblock]::Create((Get-Content -LiteralPath (Join-Path $csrRoot 'Read-BrowserExposure001.ps1') -Raw)))) -join "`n")|ConvertFrom-Json
 if($browser.Decision -cne 'BROWSER_FIREWALL_POLICY_STATIC_QUALIFICATION_PASSED' -or @($browser.ExperimentalClients).Count -or @($browser.UDP1434Endpoints).Count -or @($browser.SQLInstanceMap).Count -ne 1 -or $browser.SQLInstanceMap[0].Name -cne 'YSEDU'){throw 'STOP: client/Browser/instance drift'}
 if(@(Get-ChildItem -LiteralPath 'Cert:\LocalMachine\Request').Count -or @(Get-ChildItem -LiteralPath 'Cert:\LocalMachine\My').Count){throw 'STOP: pending/personal certificate baseline drift'}
 if(@(Get-Service -Name 'MSSQL$YSEDU' -DependentServices|Where-Object Status -NE 'Stopped').Count){throw 'STOP: dependent service active'}
 $storesBefore=Get-CsrStoreFingerprint
 $csrPhase='ApprovedProviderRegistration'
 $registry=[Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine,[Microsoft.Win32.RegistryView]::Registry32)
 $provider=$null
 try {$provider=$registry.OpenSubKey('SOFTWARE\Microsoft\Cryptography\Defaults\Provider\Microsoft Enhanced RSA and AES Cryptographic Provider',$false);if($null -eq $provider -or [int]$provider.GetValue('Type') -ne 24){throw 'STOP: CSP24 absent'}}finally{if($null -ne $provider){$provider.Dispose()};$registry.Dispose()}
 . (Join-Path $csrRoot 'Read-YseduCsr001.ps1')
 if($PreflightOnly){[pscustomobject]@{Decision='YSEDU_CSR_ADMINISTRATIVE_PREFLIGHT_PASSED';ObservedAt=(Get-Date -Format o);CombinedRollbackBaseline='PASSED';AttemptConsumed=$false;MachineKeyCreated=$false;SqlStopped=$false;EWrites=$false}|ConvertTo-Json;return}
 # Claim the sole attempt immediately before the native key-generating operation.
 Write-CsrNew $csrAttempt ([Text.Encoding]::UTF8.GetBytes(([pscustomobject]@{Task='YSEDU_LEAF_CSR_001';At=(Get-Date -Format o);OriginalSHA256=$pins['YSEDU_LEAF_MAINTENANCE_ORIGINAL.json']}|ConvertTo-Json)))
 $csrConsumed=$true;$csrPhase='OneNativeMachineCsr'
 $info=[Diagnostics.ProcessStartInfo]::new($exe)
 $info.UseShellExecute=$false;$info.CreateNoWindow=$true;$info.RedirectStandardOutput=$true;$info.RedirectStandardError=$true
 foreach($arg in @('-new','-machine','-q',(Join-Path $csrRoot 'YSEDU-Leaf-CSP24-001.inf'),$csrPath)){$info.ArgumentList.Add($arg)}
 $csrNative=[Diagnostics.Process]::Start($info)
 $stdout=$csrNative.StandardOutput.ReadToEndAsync();$stderr=$csrNative.StandardError.ReadToEndAsync()
 if(-not $csrNative.WaitForExit(120000)){$csrStillRunning=$true;throw 'STOP: certreq timeout; no kill or repeat'}
 [void]$stdout.GetAwaiter().GetResult();[void]$stderr.GetAwaiter().GetResult()
 if($csrNative.ExitCode -ne 0 -or -not(Test-Path -LiteralPath $csrPath)){throw 'STOP: certreq failed; preserve pending key/artifacts'}
 $csrPhase='PublicCsrSignatureAndExtensions'
 $text=Get-Content -LiteralPath $csrPath -Raw
 if($text -cnotmatch '\A\s*-----BEGIN (?:NEW )?CERTIFICATE REQUEST-----\s+([A-Za-z0-9+/=\s]+)-----END (?:NEW )?CERTIFICATE REQUEST-----\s*\z'){throw 'STOP: CSR encoding'}
 $der=[Convert]::FromBase64String($Matches[1])
 $request=Read-YseduCsr001 $der
 $csrRequestPublic=$request.PublicKey.GetRSAPublicKey()
 $csrPhase='ActualPendingKeyMetadata'
 $pending=@(Get-ChildItem -LiteralPath 'Cert:\LocalMachine\Request')
 if($pending.Count -ne 1 -or $pending[0].Subject -cne 'CN=DESKTOP-8QRQT7R' -or -not $pending[0].HasPrivateKey){throw 'STOP: pending key association unresolved'}
 $csrPendingCert=$pending[0]
 $csrPrivate=[Security.Cryptography.X509Certificates.RSACertificateExtensions]::GetRSAPrivateKey($csrPendingCert)
 if($csrPrivate -isnot [Security.Cryptography.RSACryptoServiceProvider]){throw 'STOP: non-legacy key provider'}
 $ki=$csrPrivate.CspKeyContainerInfo
 if($ki.ProviderType -ne 24 -or $ki.ProviderName -cne 'Microsoft Enhanced RSA and AES Cryptographic Provider' -or [int]$ki.KeyNumber -ne 1 -or -not $ki.MachineKeyStore -or $ki.Exportable -or $csrPrivate.KeySize -ne 2048){throw 'STOP: actual key properties mismatch'}
 $csrPublic=[Security.Cryptography.X509Certificates.RSACertificateExtensions]::GetRSAPublicKey($csrPendingCert)
 if([Convert]::ToBase64String($csrPublic.ExportSubjectPublicKeyInfo()) -cne [Convert]::ToBase64String($csrRequestPublic.ExportSubjectPublicKeyInfo())){throw 'STOP: pending key/CSR mismatch'}
 $challenge=[Security.Cryptography.RandomNumberGenerator]::GetBytes(32)
 $sig=$csrPrivate.SignData($challenge,[Security.Cryptography.HashAlgorithmName]::SHA256,[Security.Cryptography.RSASignaturePadding]::Pkcs1)
 if(-not $csrRequestPublic.VerifyData($challenge,$sig,[Security.Cryptography.HashAlgorithmName]::SHA256,[Security.Cryptography.RSASignaturePadding]::Pkcs1)){throw 'STOP: pending CSP24 SHA256 challenge'}
 $csrPhase='NewKeySecurityEvidence'
 if([string]::IsNullOrEmpty($ki.UniqueKeyContainerName) -or $ki.UniqueKeyContainerName -match '[\\/:]'){throw 'STOP: key identity path bound'}
 $keyFile=Join-Path 'C:\ProgramData\Microsoft\Crypto\RSA\MachineKeys' $ki.UniqueKeyContainerName
 $keyItem=Get-Item -LiteralPath $keyFile -Force
 if($keyItem.Attributes -band [IO.FileAttributes]::ReparsePoint){throw 'STOP: key file link'}
 $acl=Get-Acl -LiteralPath $keyFile
 $rules=@($acl.GetAccessRules($true,$true,[Security.Principal.SecurityIdentifier]))
 # New-key defaults only: any deny ACE requires separate interpretation, never guessing token membership.
 $deny=@($rules|Where-Object {$_.AccessControlType -eq 'Deny'})
 $allow=@($rules|Where-Object {$_.AccessControlType -eq 'Allow' -and $_.IdentityReference.Value -ceq 'S-1-5-18' -and ([int]$_.FileSystemRights -band [int][Security.AccessControl.FileSystemRights]::ReadData)})
 if($deny.Count -or -not $allow.Count){throw 'STOP: SYSTEM key read access not qualified; no ACL change'}
 if((Get-CsrStoreFingerprint) -cne $storesBefore -or (Get-Service -Name 'MSSQL$YSEDU').Status -ne 'Running' -or (Get-Service -Name SQLBrowser).Status -ne 'Stopped'){throw 'STOP: protected store/service drift after CSR'}
 $csrPhase='Result'
 $result=[pscustomobject]@{Decision='YSEDU_MACHINE_CSP24_CSR_AND_KEY_PROPERTIES_PASSED';ObservedAt=(Get-Date -Format o);Host=$env:COMPUTERNAME;Elevated=$true;OriginalSettingsSHA256=$pins['YSEDU_LEAF_MAINTENANCE_ORIGINAL.json'];RollbackBaseline='PASSED';CSRPath=$csrPath;CSRFileSHA256=(Get-FileHash -LiteralPath $csrPath -Algorithm SHA256).Hash;CSRDerSHA256=[Convert]::ToHexString([Security.Cryptography.SHA256]::HashData($der));PendingRequestThumbprint=$csrPendingCert.Thumbprint;Subject=$request.SubjectName.Name;SAN='DNS:DESKTOP-8QRQT7R';CSRSignature='SHA256/RSA-PKCS1 verified';Provider=$ki.ProviderName;ProviderType=$ki.ProviderType;KeySpec=[int]$ki.KeyNumber;RSAKeyBits=$csrPrivate.KeySize;MachineKeySet=$ki.MachineKeyStore;Exportable=$ki.Exportable;KeyFile=$keyFile;KeyOwner=$acl.Owner;KeyDaclSDDL=$acl.Sddl;SystemReadRulePresent=$true;KeyChallengePassed=$true;FourProtectedStoresUnchanged=$true;CAUnlocked=$false;LeafIssued=$false;CertificateAccepted=$false;SqlStopped=$false;RegistryChanged=$false;FirewallChanged=$false;ServiceChanged=$false;EWrites=$false;SQLConnection=$false;FirstLiveData='NOT_TESTED';Pending='Validate result then sign the approved public CSR with the existing CA using owner hidden password; do not accept certificate or stop SQL yet'}
 Write-CsrNew $csrResult ([Text.Encoding]::UTF8.GetBytes(($result|ConvertTo-Json -Depth 6)))
 # Do not ask operator to publish the private-key ACL/location; full local result is retained.
 $result|Select-Object -ExcludeProperty KeyFile,KeyOwner,KeyDaclSDDL|ConvertTo-Json -Depth 6
}catch{
 $failure=[pscustomobject]@{Decision='YSEDU_CSR_BLOCKED_STOP';ObservedAt=(Get-Date -Format o);Phase=$csrPhase;ExceptionType=$_.Exception.GetType().FullName;AttemptConsumed=$csrConsumed;MachineKeyMayExist=$csrConsumed;CertreqStillRunning=$csrStillRunning;SqlStopped=$false;CAUnlocked=$false;NoAutomaticRetry=$true;Reason='Bounded step failed; retain artifacts and no raw exception/private key material publication'}
 if($csrConsumed -and -not(Test-Path -LiteralPath $csrResult)){Write-CsrNew $csrResult ([Text.Encoding]::UTF8.GetBytes(($failure|ConvertTo-Json)))}
 $failure|ConvertTo-Json
}finally{
 foreach($item in @($csrRequestPublic,$csrPublic,$csrPrivate,$csrPendingCert,$csrNative)){if($null -ne $item){$item.Dispose()}}
}
