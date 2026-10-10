# FIRST LIVE DATA #001 - Browser exposure READ-ONLY qualification.
# No certificate, private-key, registry, firewall, service or SQL mutation.
$ErrorActionPreference='Stop'
$brIdentity=[Security.Principal.WindowsIdentity]::GetCurrent()
$brPrincipal=[Security.Principal.WindowsPrincipal]::new($brIdentity)
if($env:COMPUTERNAME -cne 'DESKTOP-8QRQT7R' -or -not $brPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)){throw 'STOP: exact host and actual authorized administrator required; no automatic elevation'}
$brService=Get-CimInstance Win32_Service -Filter 'Name="SQLBrowser"'
$brSql=Get-CimInstance Win32_Service -Filter 'Name="MSSQL$YSEDU"'
$brProgram='C:\Program Files (x86)\Microsoft SQL Server\90\Shared\sqlbrowser.exe'
if($brService.PathName -cne ('"'+$brProgram+'"') -or $brService.StartName -ine 'NT AUTHORITY\LOCALSERVICE' -or $brService.State -ne 'Stopped' -or $brService.StartMode -ne 'Disabled'){throw 'STOP: Browser identity/baseline changed'}
if($brSql.State -ne 'Running' -or $brSql.PathName -notlike '*MSSQL12.YSEDU\MSSQL\Binn\sqlservr.exe*'){throw 'STOP: YSEDU baseline changed'}
$brRules=@(Get-NetFirewallRule -PolicyStore ActiveStore -Enabled True -Direction Inbound -Action Allow)
if($brRules.Count -gt 2000){throw 'STOP: firewall rule bound exceeded'}
$brPorts=@{};Get-NetFirewallPortFilter -PolicyStore ActiveStore|ForEach-Object {$brPorts[$_.InstanceID]=$_}
$brApps=@{};Get-NetFirewallApplicationFilter -PolicyStore ActiveStore|ForEach-Object {$brApps[$_.InstanceID]=$_}
$brServices=@{};Get-NetFirewallServiceFilter -PolicyStore ActiveStore|ForEach-Object {$brServices[$_.InstanceID]=$_}
$brAddresses=@{};Get-NetFirewallAddressFilter -PolicyStore ActiveStore|ForEach-Object {$brAddresses[$_.InstanceID]=$_}
$brUnknown=@();$brCandidates=@()
foreach($rule in $brRules){
 $p=$brPorts[$rule.Name];$a=$brApps[$rule.Name];$s=$brServices[$rule.Name]
 if($null -eq $p -or $null -eq $a -or $null -eq $s){$brUnknown+=$rule.Name;continue}
 if([string]$p.Protocol -notin @('UDP','17','Any','256')){continue}
 if([string]$s.Service -ne 'Any' -and [string]$s.Service -ine 'SQLBrowser'){continue}
 $program=[Environment]::ExpandEnvironmentVariables([string]$a.Program)
 if($program -ne 'Any' -and $program -ine $brProgram){continue}
 # A specific package SID rule does not authorize this unpackaged Win32 service.
 if(-not [string]::IsNullOrEmpty([string]$a.Package) -and [string]$a.Package -ne 'Any'){continue}
 $possible=$false;$unknownPort=$false
 foreach($v in @($p.LocalPort)){
  if([string]$v -eq 'Any'){$possible=$true}
  elseif([string]$v -match '^\d+$'){if([int]$v -eq 1434){$possible=$true}}
  elseif([string]$v -match '^(\d+)-(\d+)$'){if([int]$Matches[1] -le 1434 -and [int]$Matches[2] -ge 1434){$possible=$true}}
  else{$unknownPort=$true}
 }
 if($possible -or $unknownPort){
  $addr=$brAddresses[$rule.Name]
  if($null -eq $addr){$brUnknown+=$rule.Name}
  $brCandidates+=[pscustomobject]@{Name=$rule.Name;DisplayName=$rule.DisplayName;Profile=[string]$rule.Profile;Protocol=[string]$p.Protocol;LocalPort=$p.LocalPort;Program=$program;Package=$a.Package;Service=[string]$s.Service;LocalAddress=$addr.LocalAddress;RemoteAddress=$addr.RemoteAddress;EdgeTraversalPolicy=[string]$rule.EdgeTraversalPolicy;PolicyStoreSource=$rule.PolicyStoreSource;UnknownPortSemantics=$unknownPort}
 }
}
$brProfiles=@(Get-NetFirewallProfile -PolicyStore ActiveStore|Select-Object Name,Enabled,DefaultInboundAction,DefaultOutboundAction,AllowInboundRules,AllowLocalFirewallRules)
$brProfileUnsafe=@($brProfiles|Where-Object {([string]$_.Enabled -notin @('True','1')) -or ([string]$_.DefaultInboundAction -notin @('Block','4'))})
$brSig=Get-AuthenticodeSignature -LiteralPath $brProgram
$brMap=Get-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Microsoft SQL Server\Instance Names\SQL'
$brNetworks=@(Get-NetConnectionProfile|Select-Object InterfaceAlias,InterfaceIndex,NetworkCategory,IPv4Connectivity,IPv6Connectivity)
$brClients=@(Get-Process -Name GL,inv,pr,RepDes,SSMS,sqlcmd -ErrorAction SilentlyContinue|Select-Object ProcessName,Id,MainWindowTitle)
$ok=($brUnknown.Count -eq 0 -and $brCandidates.Count -eq 0 -and $brProfiles.Count -eq 3 -and $brProfileUnsafe.Count -eq 0 -and [string]$brSig.Status -eq 'Valid')
[pscustomobject]@{
 Decision=if($ok){'BROWSER_FIREWALL_POLICY_STATIC_QUALIFICATION_PASSED'}else{'BROWSER_EXPOSURE_UNRESOLVED_STOP'}
 ObservedAt=(Get-Date -Format o);Host=$env:COMPUTERNAME;Operator=$brIdentity.Name;Elevated=$true;ProcessId=$PID
 EffectiveInboundAllowRulesInspected=$brRules.Count;MissingFilterJoins=$brUnknown;PotentialBrowserUDP1434AllowRules=$brCandidates;FirewallProfiles=$brProfiles;NetworkProfiles=$brNetworks
 BrowserExecutable=$brProgram;BrowserSignatureStatus=[string]$brSig.Status;BrowserSigner=if($null -ne $brSig.SignerCertificate){$brSig.SignerCertificate.Subject}else{$null}
 Browser=$brService|Select-Object Name,State,StartMode,ProcessId,StartName,PathName
 YSEDU=$brSql|Select-Object Name,State,StartMode,ProcessId,StartName,PathName
 SQLInstanceMap=@($brMap.PSObject.Properties|Where-Object Name -notmatch '^PS'|Select-Object Name,Value)
 ExperimentalClients=$brClients
 UDP1434Endpoints=@(Get-NetUDPEndpoint -LocalPort 1434 -ErrorAction SilentlyContinue|Select-Object LocalAddress,LocalPort,OwningProcess)
 Limit='Static Windows Firewall rule/profiles only; not packet reachability proof, not a Browser loopback bind, not permission to change settings'
 FirewallChanged=$false;BrowserStarted=$false;SqlStopped=$false;CertificateCreated=$false;SQLConnection=$false
}|ConvertTo-Json -Depth 8
# STOP. Any actual activation is a later bounded step only after owner scope acceptance.
