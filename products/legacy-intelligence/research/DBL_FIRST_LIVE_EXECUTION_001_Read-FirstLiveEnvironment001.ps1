[CmdletBinding()]
param()
$ErrorActionPreference='Stop';Set-StrictMode -Version Latest
function Need([bool]$ok,[string]$code){if(-not $ok){throw [InvalidOperationException]::new($code)}}
Need ($env:COMPUTERNAME -ceq 'DESKTOP-8QRQT7R') 'HostIdentity'
$q=(& sc.exe queryex 'MSSQL$YSEDU') -join "`n";Need ($LASTEXITCODE -eq 0 -and $q -match 'STATE\s*:\s*4\s+RUNNING') 'YseduRunning'
$m=[regex]::Match($q,'\bPID\s*:\s*(\d+)');Need ($m.Success -and [int]$m.Groups[1].Value -gt 0) 'CurrentServicePid';$sqlPid=[int]$m.Groups[1].Value
$cfg=(& sc.exe qc 'MSSQL$YSEDU') -join "`n";Need ($LASTEXITCODE -eq 0 -and $cfg -match 'START_TYPE\s*:\s*2\s+AUTO_START' -and $cfg -match 'SERVICE_START_NAME\s*:\s*LocalSystem' -and $cfg.Contains('"C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.YSEDU\MSSQL\Binn\sqlservr.exe" -sYSEDU')) 'SameYseduServiceIdentity'
Need ((Get-Service -Name SQLBrowser).Status -eq 'Stopped' -and (Get-Service -Name SQLBrowser).StartType -eq 'Disabled') 'BrowserStoppedDisabled'
$proc=Get-Process -Id $sqlPid;try{Need ($proc.ProcessName -ceq 'sqlservr') 'SqlProcessName'}finally{$proc.Dispose()}
$lines=@((& netstat -ano -p tcp)|Where-Object{$_ -match ('\sLISTENING\s+'+$sqlPid+'\s*$')});Need ($LASTEXITCODE -eq 0 -and $lines.Count -eq 1) 'SoleYseduListener'
$endpoint=[regex]::Match($lines[0],'^\s*TCP\s+192\.168\.56\.1:(\d+)\s+\S+\s+LISTENING\s+\d+\s*$');Need $endpoint.Success 'OnlyApprovedAddress'
$port=[int]$endpoint.Groups[1].Value;Need ($port -ge 1 -and $port -le 65535) 'ActualPortRange'
$base=$null;$certs=@()
try{
 $base=[Microsoft.Win32.RegistryKey]::OpenBaseKey('LocalMachine','Registry32');$scope='SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL12.YSEDU\MSSQLServer\SuperSocketNetLib'
 $k=$base.OpenSubKey($scope,$false);try{Need ($k.GetValue('Certificate') -ceq 'a51bd253b6083d0114428fcfbad57d008cd102f5' -and $k.GetValue('ForceEncryption') -eq 0) 'UnchangedBindingAndForceEncryption'}finally{$k.Dispose()}
 $tcp=$base.OpenSubKey($scope+'\Tcp',$false);try{
  Need ($tcp.GetValue('Enabled') -eq 1 -and $tcp.GetValue('ListenOnAllIPs') -eq 0) 'RestrictedTcp'
  foreach($name in $tcp.GetSubKeyNames()){$ip=$tcp.OpenSubKey($name,$false);try{if($name -ceq 'IP4'){Need ($ip.GetValue('Enabled') -eq 1 -and $ip.GetValue('IpAddress') -ceq '192.168.56.1' -and $ip.GetValue('TcpPort') -ceq '' -and $ip.GetValue('TcpDynamicPorts') -ceq [string]$port) 'Ip4MatchesOwnedListener'}elseif($name -cne 'IPAll'){Need ($ip.GetValue('Enabled') -eq 0) 'OtherIpDisabled'}}finally{$ip.Dispose()}}
 }finally{$tcp.Dispose()}
 foreach($entry in @(@{Path='Cert:\LocalMachine\Root\121CDC9857488ED95F4BC62106D7672BB0DBC6C3';SHA='A3FBC7905425B2E8C10F3A070B8713F876B94FC42B8D1243DEAD5D0F42889472'},@{Path='Cert:\LocalMachine\My\A51BD253B6083D0114428FCFBAD57D008CD102F5';SHA='522C79FD31F0422D3988FB00CC4EF0A51B4042DEED72A435A6519237AC548DFE'})){
  $c=Get-Item -LiteralPath $entry.Path;$certs+=@($c);Need ([Convert]::ToHexString([Security.Cryptography.SHA256]::HashData($c.RawData)) -ceq $entry.SHA -and [datetime]::UtcNow -ge $c.NotBefore.ToUniversalTime() -and [datetime]::UtcNow -lt $c.NotAfter.ToUniversalTime()) 'PinnedPublicCertificateValidity'
 }
 [pscustomobject]@{Decision='CURRENT_LIVE_ENVIRONMENT_READONLY_PASSED';At=(Get-Date -Format o);Host=$env:COMPUTERNAME;Service='MSSQL$YSEDU';ServiceAccount='LocalSystem';Pid=$sqlPid;Address='192.168.56.1';Port=$port;Dynamic=$true;Browser='Stopped/Disabled';CertificateBinding='A51BD253B6083D0114428FCFBAD57D008CD102F5';ForceEncryption=0;HostMutation=$false}|ConvertTo-Json
}finally{foreach($c in $certs){$c.Dispose()};if($null -ne $base){$base.Dispose()}}
