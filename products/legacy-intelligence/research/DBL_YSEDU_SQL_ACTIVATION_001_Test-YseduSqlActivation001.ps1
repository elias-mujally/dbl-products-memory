$ErrorActionPreference='Stop';Set-StrictMode -Version Latest
$root=$PSScriptRoot;$checks=0
function Extract([string]$path,[string[]]$names){
 $tokens=$null;$errors=$null;$ast=[Management.Automation.Language.Parser]::ParseFile($path,[ref]$tokens,[ref]$errors);if($errors.Count){throw 'Parse'}
 foreach($name in $names){$f=@($ast.FindAll({param($n)$n -is [Management.Automation.Language.FunctionDefinitionAst]},$false)|Where-Object Name -CEQ $name);if($f.Count -ne 1){throw 'Function identity'};[scriptblock]::Create($f[0].Extent.Text)}
}
foreach($fn in @(Extract (Join-Path $root 'Restore-YseduLeafNetwork002-RetainedCertificates.ps1') @('Rb-Need','Rb-Target','Rb-AssertStores','Rb-DynamicAllowed'))){. $fn}
foreach($fn in @(Extract (Join-Path $root 'Invoke-YseduSqlActivation001.ps1') @('Need','Equal','Startup-Evidence','Start-Once','Write-Owned'))){. $fn}
function Check([bool]$ok){if(-not $ok){throw ('Test assertion after '+$script:checks+' successful checks')};$script:checks++}
function Reject($body){$failed=$false;try{& $body}catch{$failed=$true};Check $failed}
$s='SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL12.YSEDU\MSSQLServer\SuperSocketNetLib'
$vectors=@(
 @($s,'Certificate','','a51bd253b6083d0114428fcfbad57d008cd102f5','String',$true),
 @(($s+'\Tcp'),'ListenOnAllIPs',1,0,'DWord',$true),@(($s+'\Tcp'),'Enabled',0,1,'DWord',$true),@(($s+'\Tcp\IP4'),'Enabled',[long]0,[long]1,'DWord',$true),
 @($s,'Certificate','','other','String',$false),@($s,'ForceEncryption',0,1,'DWord',$false),@(($s+'\Tcp'),'Enabled','0','1','DWord',$false),
 @(($s+'\Tcp'),'Enabled',0.0,1.0,'DWord',$false),@(($s+'\Tcp\IP3'),'Enabled',0,1,'DWord',$false),@(($s+'\Tcp\IPAll'),'Enabled',0,1,'DWord',$false),
 @(($s+'\Tcp\IP4'),'TcpPort','','1433','String',$false),@(($s+'\Tcp\IP4'),'TcpDynamicPorts','0','60000','String',$false),
 @('SYSTEM\CurrentControlSet\Services\SQLBrowser','Start',4,3,'DWord',$false),@($s.Replace('YSEDU','OTHER'),'Certificate','','a51bd253b6083d0114428fcfbad57d008cd102f5','String',$false))
foreach($v in $vectors){Check ((Rb-Target $v[0] $v[1] $v[2] $v[3] $v[4]) -eq $v[5])}
Check (Rb-DynamicAllowed ($s+'\Tcp\IP4') 'TcpDynamicPorts' 'String' '60001' 'Forward' 60001)
foreach($mode in 'Baseline','OwnedPartial'){Check (-not(Rb-DynamicAllowed ($s+'\Tcp\IP4') 'TcpDynamicPorts' 'String' '60001' $mode 60001))}
Check (-not(Rb-DynamicAllowed ($s+'\Tcp\IP4') 'TcpDynamicPorts' 'String' '60002' 'Forward' 60001))
Check (-not(Rb-DynamicAllowed ($s+'\Tcp\IPAll') 'TcpDynamicPorts' 'String' '60001' 'Forward' 60001))
$views=@([pscustomobject]@{Location='CurrentUser';Store='Root';Count=50;Fingerprint='A'},[pscustomobject]@{Location='CurrentUser';Store='CA';Count=11;Fingerprint='B'},[pscustomobject]@{Location='CurrentUser';Store='My';Count=4;Fingerprint='C'},[pscustomobject]@{Location='LocalMachine';Store='Root';Count=50;Fingerprint='A'},[pscustomobject]@{Location='LocalMachine';Store='CA';Count=5;Fingerprint='D'},[pscustomobject]@{Location='LocalMachine';Store='My';Count=1;Fingerprint='E'},[pscustomobject]@{Location='LocalMachine';Store='Request';Count=0;Fingerprint='F'})
Rb-AssertStores $views $views;Check $true
foreach($i in 3,5,6){$bad=$views|ConvertTo-Json|ConvertFrom-Json;$bad[$i].Fingerprint='changed';Reject {Rb-AssertStores $bad $views}}
$bad=$views|ConvertTo-Json|ConvertFrom-Json;$bad[6]=$bad[5];Reject {Rb-AssertStores $bad $views}
# Independent startup text: fresh SQL PID/time is mandatory; old thumbprint success cannot qualify.
$when=[datetime]'2026-10-11T23:00:00';$since=$when.ToUniversalTime();$pidValue=99123
$good=@('2026-10-11 23:00:01.00 Server Server process ID is 99123.','2026-10-11 23:00:02.00 Server The certificate [Cert Hash(sha1) "A51BD253B6083D0114428FCFBAD57D008CD102F5"] was successfully loaded for encryption.','2026-10-11 23:00:03.00 spid11s SQL Server is now ready for client connections.')
Check ((Startup-Evidence $good $pidValue $since).Passed)
Check (-not(Startup-Evidence $good 99124 $since).Passed)
Check (-not(Startup-Evidence $good $pidValue $since.AddMinutes(1)).Passed)
Check (-not(Startup-Evidence @($good[0],$good[1].Replace('A51BD253B6083D0114428FCFBAD57D008CD102F5','0000000000000000000000000000000000000000'),$good[2]) $pidValue $since).Passed)
Check (-not(Startup-Evidence @($good+$good[1]) $pidValue $since).Passed)
Check (-not(Startup-Evidence @($good+'2026-10-11 23:00:04.00 Server A self-generated certificate was successfully loaded for encryption.') $pidValue $since).Passed)
$state=[pscustomobject]@{Phase='OneNaturalStart';Check='Test'};$beforeHash='synthetic';$root='synthetic-no-filesystem';$r=@{StartCalls=0;RegistryWriteAttempts=0;RegistryWrites=0;StopCalls=1}
$script:markers=@();function New-Json([string]$p,$v){$script:markers+=@([pscustomobject]@{Path=$p;Value=$v})}
function Get-Service {param($Name) [pscustomobject]@{Status='Stopped'}}
$service=[pscustomobject]@{Calls=0};$service|Add-Member ScriptMethod Start {$this.Calls++;throw 'SYNTHETIC_START_FAILURE'}
Reject {Start-Once};Check ($r.StartCalls -eq 1 -and $service.Calls -eq 1 -and $script:markers.Count -eq 1)
Reject {Start-Once};Check ($service.Calls -eq 1)
$key=[pscustomobject]@{Calls=0};$key|Add-Member ScriptMethod GetValueKind {param($name) 'DWord'};$key|Add-Member ScriptMethod GetValue {param($name) 0};$key|Add-Member ScriptMethod SetValue {param($name,$value,$kind) $this.Calls++;throw 'SYNTHETIC_REGISTRY_WRITE_FAILURE'};$key|Add-Member ScriptMethod Dispose {}
$base=[pscustomobject]@{Key=$key};$base|Add-Member ScriptMethod OpenSubKey {param($path,$write) $this.Key}
$r.StartCalls=0
Reject {Write-Owned 2 ($s+'\Tcp\IP4') 'Enabled' 0 1 'DWord'}
Check ($r.RegistryWriteAttempts -eq 1 -and $r.RegistryWrites -eq 0 -and $key.Calls -eq 1 -and $script:markers.Count -eq 2)
$helperPath=Join-Path $PSScriptRoot 'Invoke-YseduSqlActivation001.ps1';$rbPath=Join-Path $PSScriptRoot 'Restore-YseduLeafNetwork002-RetainedCertificates.ps1'
foreach($p in $helperPath,$rbPath){$text=Get-Content -LiteralPath $p -Raw;Check ($text -notmatch '(?i)certreq\.exe|[\x27\x22]-accept|\.Remove\(|Remove-Item|CRYPT_DELETEKEYSET|Set-Acl|ReadWrite|Import-Pfx|New-SelfSigned|Stop-Process|\.Kill\(|Restart-Service|Set-Service|Start-Service|Stop-Service')}
$tokens=$null;$errors=$null;$ast=[Management.Automation.Language.Parser]::ParseFile($helperPath,[ref]$tokens,[ref]$errors)
Check (@($ast.FindAll({param($n)$n -is [Management.Automation.Language.InvokeMemberExpressionAst] -and $n.Member.Value -ceq 'Stop'},$true)).Count -eq 1)
Check (@($ast.FindAll({param($n)$n -is [Management.Automation.Language.InvokeMemberExpressionAst] -and $n.Member.Value -ceq 'Start'},$true)).Count -eq 1)
Check ((Get-Content -LiteralPath $rbPath -Raw).Contains('NoApplyAfterStartAttemptConsumed'))
Check ((Get-Content -LiteralPath $helperPath -Raw).Contains('$service.Stop($false)'))
Check (@([System.ServiceProcess.ServiceController].GetMethods()|Where-Object{$_.Name -ceq 'Stop' -and $_.GetParameters().Count -eq 1 -and $_.GetParameters()[0].ParameterType -eq [bool]}).Count -eq 1)
[pscustomobject]@{Decision='SQL_ACTIVATION_001_PURE_GUARDS_PASSED';Checks=$checks;HostMutation=$false;ServiceCalls=$false;RegistryCalls='In-memory doubles only';SqlLoading='NOT_TESTED';Limitation='Pure guards and source checks; real admin preflight/stop/start/loading remain unexecuted'}|ConvertTo-Json
