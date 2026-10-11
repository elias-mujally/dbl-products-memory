$ErrorActionPreference='Stop'
$path=Join-Path $PSScriptRoot 'Invoke-YseduDirectMaintenance001.ps1'
$tokens=$null;$errors=$null;$ast=[Management.Automation.Language.Parser]::ParseFile($path,[ref]$tokens,[ref]$errors)
if($errors.Count){throw 'Parse'}
$fn=$ast.Find({param($n) $n -is [Management.Automation.Language.FunctionDefinitionAst] -and $n.Name -ceq 'Test-ForwardTarget'},$true)
. ([scriptblock]::Create($fn.Extent.Text))
$s='SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL12.YSEDU\MSSQLServer\SuperSocketNetLib'
$tests=@(
 @($s,'Certificate','','a51bd253b6083d0114428fcfbad57d008cd102f5','String',$true),
 @(($s+'\Tcp'),'ListenOnAllIPs',1,0,'DWord',$true),
 @(($s+'\Tcp'),'Enabled',0,1,'DWord',$true),
 @(($s+'\Tcp\IP4'),'Enabled',0,1,'DWord',$true),
 @(($s+'\Tcp\IP3'),'Enabled',0,1,'DWord',$false),
 @(($s+'\Tcp\IP4'),'TcpPort','','1433','String',$false),
 @(($s+'\Tcp\IP4'),'TcpDynamicPorts','0','54321','String',$false),
 @($s,'ForceEncryption',0,1,'DWord',$false),
 @('SYSTEM\CurrentControlSet\Services\SQLBrowser','Start',4,3,'DWord',$false),
 @($s.Replace('MSSQL12.YSEDU','MSSQL12.OTHER'),'Certificate','','a51bd253b6083d0114428fcfbad57d008cd102f5','String',$false),
 @($s,'Certificate','','wrong','String',$false),
 @(($s+'\Tcp'),'Enabled',1,1,'DWord',$false),
 @(($s+'\Tcp'),'Enabled',0,1,'String',$false)
)
foreach($t in $tests){if((Test-ForwardTarget $t[0] $t[1] $t[2] $t[3] $t[4]) -ne $t[5]){throw 'Forward target vector'}}
$calls=@($ast.FindAll({param($n) $n -is [Management.Automation.Language.InvokeMemberExpressionAst] -and $n.Member.Value -ceq 'Stop'},$true))
if($calls.Count -ne 1){throw 'Single stop call source guard'}
$text=$ast.Extent.Text
if($text -match '(?i)\.Kill\s*\(|Stop-Process|Restart-Service|Start-Service|Set-Service|ForceEncryption''\s+\d|TrustServerCertificate|Import-PfxCertificate|New-SelfSignedCertificate') {throw 'Forbidden maintenance operation'}
$starts=@($ast.FindAll({param($n) $n -is [Management.Automation.Language.InvokeMemberExpressionAst] -and $n.Member.Value -ceq 'Start'},$true))
if($starts.Count -ne 2){throw 'Expected only service Start-Once and certreq process Start'}
# Exercise actual Start-Once without a service: count increment before any exception,
# and rejection of a second start. All objects below are in-memory test doubles.
$startFn=$ast.Find({param($n) $n -is [Management.Automation.Language.FunctionDefinitionAst] -and $n.Name -ceq 'Start-Once'},$true)
. ([scriptblock]::Create($startFn.Extent.Text))
function Need([bool]$ok,[string]$code){if(-not $ok){throw $code}}
function Get-Service {param($Name) [pscustomobject]@{Status='Stopped'}}
$r=@{StartCalls=0};$service=[pscustomobject]@{Status='Stopped';Calls=0}
$service|Add-Member ScriptMethod Start {$this.Calls++;throw 'SYNTHETIC_START_FAILURE'}
$caught=$false;try{Start-Once}catch{$caught=$true}
if(-not $caught -or $r.StartCalls -ne 1 -or $service.Calls -ne 1){throw 'Start failure call budget'}
try{Start-Once;throw 'Second start allowed'}catch{if($_.Exception.Message -ne 'OneNormalStartOnly'){throw}}
if($service.Calls -ne 1){throw 'Second physical start'}
[pscustomobject]@{Decision='DIRECT_MAINTENANCE_SOURCE_GUARDS_PASSED';ForwardVectors=13;StopCallSites=1;SingleStartFailureBudgetPassed=$true;HostChanged=$false;ServiceCall=$false;SqlConnection=$false}|ConvertTo-Json
