# FIRST LIVE DATA #001: fresh administrative READ-ONLY settings capture.
# Writes only a new non-sensitive JSON in the task output directory; no host mutation.
$ErrorActionPreference='Stop'
Set-StrictMode -Version Latest
$lmPhase='Identity'
$lmOutput='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010\YSEDU_LEAF_MAINTENANCE_ORIGINAL.json'
$lmBase=$null
function Read-LmRegistryValues([string]$Path,[string[]]$Names) {
 $key=$lmBase.OpenSubKey($Path,$false)
 if($null -eq $key){throw 'Required registry key absent'}
 try {
  $available=@($key.GetValueNames())
  $values=@(foreach($name in $Names){
   if($available -ccontains $name){[pscustomobject]@{Name=$name;Present=$true;Kind=[string]$key.GetValueKind($name);Value=$key.GetValue($name,$null,[Microsoft.Win32.RegistryValueOptions]::DoNotExpandEnvironmentNames)}}
   else{[pscustomobject]@{Name=$name;Present=$false;Kind=$null;Value=$null}}
  })
  [pscustomobject]@{View='Registry32';Path=$Path;Values=$values}
 }finally{$key.Dispose()}
}
try {
 $identity=[Security.Principal.WindowsIdentity]::GetCurrent()
 $principal=[Security.Principal.WindowsPrincipal]::new($identity)
 if($env:COMPUTERNAME -cne 'DESKTOP-8QRQT7R' -or -not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)){throw 'Exact host and actual administrative token required'}
 if(Test-Path -LiteralPath $lmOutput){throw 'Fresh original-settings file required; no overwrite'}
 $lmPhase='CaPublicAndCustodyResult'
 $caResultPath=Join-Path (Split-Path -Parent $lmOutput) 'CA_CUSTODY_CORRECTED_RESULT.json'
 $caResult=Get-Content -LiteralPath $caResultPath -Raw|ConvertFrom-Json
 if($caResult.Decision -cne 'CA_ENCRYPTED_CUSTODY_AND_EPHEMERAL_REIMPORT_PASSED' -or $caResult.Thumbprint -cne '121CDC9857488ED95F4BC62106D7672BB0DBC6C3' -or (Get-FileHash -LiteralPath 'E:\DBL-Lab-CA-YSEDU-001\ca-public.cer' -Algorithm SHA256).Hash -cne 'A3FBC7905425B2E8C10F3A070B8713F876B94FC42B8D1243DEAD5D0F42889472'){throw 'CA public/result mismatch'}
 # Hash encrypted bytes only. No PFX loading, password prompt or private-key access.
 if((Get-FileHash -LiteralPath 'E:\DBL-Lab-CA-YSEDU-001\ca-signing-key.pfx' -Algorithm SHA256).Hash -cne '7C8FD60E8997AEDDA3C445E900BD5C1F685D9929ABC89BF9E20818354A862E32'){throw 'Retained PFX hash mismatch'}
 $lmPhase='FreshBrowserPolicy'
 $browserHelper=Join-Path (Split-Path -Parent $lmOutput) 'Read-BrowserExposure001.ps1'
 if((Get-FileHash -LiteralPath $browserHelper -Algorithm SHA256).Hash -cne '0367AAB24C897A6D7964507AE4E1F0C1D8845A430D50D564115889C11AFD786B'){throw 'Browser helper mismatch'}
 $browserJson=(& ([scriptblock]::Create((Get-Content -LiteralPath $browserHelper -Raw)))) -join "`n"
 $browser=$browserJson|ConvertFrom-Json
 if($browser.Decision -cne 'BROWSER_FIREWALL_POLICY_STATIC_QUALIFICATION_PASSED' -or @($browser.SQLInstanceMap).Count -ne 1 -or $browser.SQLInstanceMap[0].Name -cne 'YSEDU' -or $browser.SQLInstanceMap[0].Value -cne 'MSSQL12.YSEDU' -or @($browser.ExperimentalClients).Count -ne 0 -or @($browser.UDP1434Endpoints).Count -ne 0){throw 'Browser/clients/instance gate not qualified'}
 $lmPhase='ExactRegistryAndProtocols'
 $lmBase=[Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine,[Microsoft.Win32.RegistryView]::Registry32)
 $ss='SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL12.YSEDU\MSSQLServer\SuperSocketNetLib'
 $security=Read-LmRegistryValues $ss @('Certificate','ForceEncryption','HideInstance','ExtendedProtection')
 foreach($name in @('Certificate','ForceEncryption','HideInstance')){
  $v=@($security.Values|Where-Object Name -CEQ $name)
  if($v.Count -ne 1 -or -not $v[0].Present){throw 'Expected security property missing'}
  if(($name -eq 'Certificate' -and [string]$v[0].Value -cne '') -or ($name -ne 'Certificate' -and [int]$v[0].Value -ne 0)){throw 'Security baseline drift'}
 }
 $tcpKey=$lmBase.OpenSubKey($ss+'\Tcp',$false)
 if($null -eq $tcpKey){throw 'TCP registry key missing'}
 try{$ipNames=@($tcpKey.GetSubKeyNames());if($ipNames.Count -gt 32 -or @($ipNames|Where-Object {$_ -cnotmatch '^IP(?:[0-9]+|All)$'}).Count){throw 'Unexpected TCP target set'}}finally{$tcpKey.Dispose()}
 $tcpRegistry=@(Read-LmRegistryValues ($ss+'\Tcp') @('Enabled','ListenOnAllIPs','KeepAlive','KeepAliveInterval'))
 foreach($ip in $ipNames){$tcpRegistry+=Read-LmRegistryValues ($ss+'\Tcp\'+$ip) @('Active','Enabled','IpAddress','TcpPort','TcpDynamicPorts')}
 $startup=Read-LmRegistryValues 'SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL12.YSEDU\MSSQLServer\Parameters' @('SQLArg0','SQLArg1','SQLArg2')
 $serviceRegistry=@(foreach($s in @('MSSQL$YSEDU','SQLBrowser')){Read-LmRegistryValues ('SYSTEM\CurrentControlSet\Services\'+$s) @('Start','DelayedAutoStart','ImagePath','ObjectName','FailureActions','FailureActionsOnNonCrashFailures')})
 $ns='root\Microsoft\SqlServer\ComputerManagement12'
 $protocols=@(Get-CimInstance -Namespace $ns -ClassName ServerNetworkProtocol -Filter "InstanceName='YSEDU'"|Select-Object ProtocolName,Enabled)
 if($protocols.Count -ne 3 -or @($protocols|Where-Object {$_.ProtocolName -eq 'Tcp' -and $_.Enabled}).Count -or @($protocols|Where-Object {$_.ProtocolName -eq 'Np' -and $_.Enabled}).Count -or @($protocols|Where-Object {$_.ProtocolName -eq 'Sm' -and $_.Enabled}).Count -ne 1){throw 'Protocol baseline changed'}
 $tcpProperties=@(Get-CimInstance -Namespace $ns -ClassName ServerNetworkProtocolProperty -Filter "InstanceName='YSEDU' AND ProtocolName='Tcp'"|Select-Object IPAddressName,PropertyName,PropertyNumVal,PropertyStrVal,PropertyType)
 if($tcpProperties.Count -gt 200 -or $tcpProperties.Count -lt 7){throw 'TCP property bound'}
 $lmPhase='HostToolsStoresAndRecoveryBoundary'
 $dependent=@(Get-Service -Name 'MSSQL$YSEDU' -DependentServices|Select-Object Name,@{N='State';E={[string]$_.Status}})
 if(@($dependent|Where-Object State -NE 'Stopped').Count){throw 'Running dependent service requires separate handling'}
 $machineStores=@(foreach($store in @('Cert:\LocalMachine\My','Cert:\LocalMachine\Request','Cert:\LocalMachine\Root')){
  $items=@(Get-ChildItem -LiteralPath $store)
  if($items.Count -gt 256){throw 'Certificate inventory bound'}
  [pscustomobject]@{Store=$store;Certificates=@($items|Select-Object Subject,Issuer,Thumbprint,HasPrivateKey,NotBefore,NotAfter)}
 })
 if(@($machineStores|Where-Object Store -EQ 'Cert:\LocalMachine\My')[0].Certificates.Count -ne 0){throw 'Machine Personal store drift; review before new leaf'}
 $caPrivateStores=@(foreach($store in @('Cert:\CurrentUser\My','Cert:\LocalMachine\My')){Get-ChildItem -LiteralPath $store|Where-Object {$_.Thumbprint -ceq '121CDC9857488ED95F4BC62106D7672BB0DBC6C3' -and $_.HasPrivateKey}})
 if($caPrivateStores.Count){throw 'Unexpected CA private-store persistence'}
 $tools=@(foreach($p in @('C:\Windows\System32\certreq.exe','C:\Windows\System32\certutil.exe','C:\Windows\SysWOW64\SQLServerManager12.msc')){
  $file=Get-Item -LiteralPath $p
  $signature=Get-AuthenticodeSignature -LiteralPath $p
  if($p.EndsWith('.exe') -and [string]$signature.Status -ne 'Valid'){throw 'Native tool signature failed'}
  [pscustomobject]@{Path=$p;Bytes=$file.Length;SHA256=(Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash;SignatureStatus=[string]$signature.Status}
 })
 $provider=Read-LmRegistryValues 'SOFTWARE\Microsoft\Cryptography\Defaults\Provider\Microsoft RSA SChannel Cryptographic Provider' @('Type','Image Path')
 $type=@($provider.Values|Where-Object Name -EQ 'Type')[0]
 if(-not $type.Present -or [int]$type.Value -ne 12){throw 'Legacy SChannel provider not qualified'}
 $backup='C:\EFA\DBL_HOST_W11_EFA12026_PostS2_Frozen_20261009.bak'
 $backupFile=Get-Item -LiteralPath $backup
 $backupHash=(Get-FileHash -LiteralPath $backup -Algorithm SHA256).Hash
 if($backupFile.Length -ne 25350144 -or $backupHash -cne 'E63DF84D2DBB22C5ACD535DC5881D2DCF417F420665502927EBD9AD66731E572'){throw 'Accepted historical S2 recovery bytes changed'}
 $addresses=@(Get-NetIPAddress|Where-Object {$_.AddressState -eq 'Preferred'}|Select-Object InterfaceIndex,InterfaceAlias,AddressFamily,IPAddress,PrefixLength)
 $dns=@([Net.Dns]::GetHostAddresses('DESKTOP-8QRQT7R')|ForEach-Object {$_.ToString()})
 $lmReport=[pscustomobject]@{Decision='YSEDU_LEAF_MAINTENANCE_ORIGINAL_CAPTURED_READONLY';ObservedAt=(Get-Date -Format o);Host=$env:COMPUTERNAME;Operator=$identity.Name;Elevated=$true;RegistryView='Registry32';Instance='YSEDU';InstanceId='MSSQL12.YSEDU';Security=$security;TcpRegistry=$tcpRegistry;Startup=$startup;ServiceRegistry=$serviceRegistry;Protocols=$protocols;TcpProperties=$tcpProperties;BrowserPolicy=$browser;DependentServices=$dependent;MachineCertificateStores=$machineStores;Tools=$tools;LegacyProvider=$provider;LocalAddresses=$addresses;DnsAddresses=$dns;HistoricalS2Backup=[pscustomobject]@{Path=$backup;Bytes=$backupFile.Length;SHA256=$backupHash;WholeInstanceRecovery=$false};CaThumbprint=$caResult.Thumbprint;CaCustodyResultSHA256=(Get-FileHash -LiteralPath $caResultPath -Algorithm SHA256).Hash;SQLConnection=$false;TransactionsVerified=$false;PasswordRequested=$false;PfxDecrypted=$false;CertificateOrKeyCreated=$false;CertificateAccepted=$false;RegistryChanged=$false;FirewallChanged=$false;ServiceChanged=$false;EWrites=$false;SqlStopped=$false;Pending='Review exact forward/rollback targets before machine CSR or service mutation; no shutdown from this helper'}
 $json=$lmReport|ConvertTo-Json -Depth 14
 $stream=[IO.File]::Open($lmOutput,[IO.FileMode]::CreateNew,[IO.FileAccess]::Write,[IO.FileShare]::None)
 try{$bytes=[Text.Encoding]::UTF8.GetBytes($json+"`n");$stream.Write($bytes,0,$bytes.Length);$stream.Flush($true)}finally{$stream.Dispose()}
 [pscustomobject]@{Decision=$lmReport.Decision;ObservedAt=$lmReport.ObservedAt;Host=$lmReport.Host;Elevated=$true;OriginalSettingsFile=$lmOutput;OriginalSettingsSHA256=(Get-FileHash -LiteralPath $lmOutput -Algorithm SHA256).Hash;BrowserPolicy=$browser.Decision;MachinePersonalCertificateCount=0;CertificateOrKeyCreated=$false;RegistryChanged=$false;FirewallChanged=$false;ServiceChanged=$false;SqlStopped=$false;TransactionsVerified=$false;EWrites=$false;Pending=$lmReport.Pending}|ConvertTo-Json -Depth 4
}catch{
 [pscustomobject]@{Decision='YSEDU_LEAF_MAINTENANCE_PREFLIGHT_BLOCKED_STOP';ObservedAt=(Get-Date -Format o);Phase=$lmPhase;ExceptionType=$_.Exception.GetType().FullName;OriginalSettingsWritten=(Test-Path -LiteralPath $lmOutput);SqlStopped=$false;HostMutation=$false;SQLConnection=$false;NoAutomaticRetry=$true;Reason='Bounded read-only gate failed; no raw exception or credential material published'}|ConvertTo-Json
}finally{if($null -ne $lmBase){$lmBase.Dispose()}}
# STOP: this helper never creates a key, binds a certificate or changes/stops a service.
