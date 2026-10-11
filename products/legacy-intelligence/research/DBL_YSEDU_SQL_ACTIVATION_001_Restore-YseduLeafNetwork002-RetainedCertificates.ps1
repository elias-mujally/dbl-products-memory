[CmdletBinding()]
param([ValidateSet('Baseline','Forward','OwnedPartial')][string]$Phase='Baseline',[int]$RuntimePort=0,[switch]$Apply,[switch]$MaintenanceAuthorized)
# Rollback #002 retained-certificate revision. Historical #002 is NOT executable for this operation.
# Only four journal-owned registry values; no certificate/key/service/trust operations.
$ErrorActionPreference='Stop';Set-StrictMode -Version Latest
$root='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010'
$scope='SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL12.YSEDU\MSSQLServer\SuperSocketNetLib'
function Rb-Need([bool]$ok,[string]$code){if(-not $ok){throw [InvalidOperationException]::new($code)}}
function Rb-Equal($a,$b){return (($a|ConvertTo-Json -Depth 15 -Compress) -ceq ($b|ConvertTo-Json -Depth 15 -Compress))}
function Rb-Target([string]$path,[string]$name,$before,$after,[string]$kind){
 $s='SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL12.YSEDU\MSSQLServer\SuperSocketNetLib'
 if($path -ceq $s -and $name -ceq 'Certificate'){return ($kind -ceq 'String' -and [string]$before -ceq '' -and [string]$after -ceq 'a51bd253b6083d0114428fcfbad57d008cd102f5')}
 if($kind -cne 'DWord' -or ($before -isnot [int] -and $before -isnot [long]) -or ($after -isnot [int] -and $after -isnot [long])){return $false}
 if($path -ceq ($s+'\Tcp') -and $name -ceq 'ListenOnAllIPs'){return ($before -eq 1 -and $after -eq 0)}
 if(($path -ceq ($s+'\Tcp') -or $path -ceq ($s+'\Tcp\IP4')) -and $name -ceq 'Enabled'){return ($before -eq 0 -and $after -eq 1)}
 return $false
}
function Rb-Stores {
 $views=@()
 foreach($loc in 'CurrentUser','LocalMachine'){
  $names=if($loc -ceq 'LocalMachine'){@('Root','CA','My','Request')}else{@('Root','CA','My')}
  foreach($name in $names){
   $store=[Security.Cryptography.X509Certificates.X509Store]::new($name,[Security.Cryptography.X509Certificates.StoreLocation]::$loc);$certs=$null
   try{$store.Open([Security.Cryptography.X509Certificates.OpenFlags]'ReadOnly,OpenExistingOnly');$certs=$store.Certificates
    $entries=@($certs|ForEach-Object{$_.Thumbprint+':'+[Convert]::ToHexString([Security.Cryptography.SHA256]::HashData($_.RawData))}|Sort-Object)
    Rb-Need ($entries.Count -le 256) 'StoreBudget'
    $views+=[pscustomobject]@{Location=$loc;Store=$name;Count=$entries.Count;Fingerprint=[Convert]::ToHexString([Security.Cryptography.SHA256]::HashData([Text.Encoding]::UTF8.GetBytes(($entries -join "`n"))))}
   }finally{if($null -ne $certs){foreach($c in $certs){$c.Dispose()}};$store.Dispose()}
  }
 }
 return $views
}
function Rb-AssertStores($actual,$expected){
 Rb-Need ($actual.Count -eq 7 -and $expected.Count -eq 7) 'SevenStoreViews'
 $ids=@('CurrentUser/Root','CurrentUser/CA','CurrentUser/My','LocalMachine/Root','LocalMachine/CA','LocalMachine/My','LocalMachine/Request')|Sort-Object
 foreach($set in @($actual),@($expected)){Rb-Need ((@($set|ForEach-Object{$_.Location+'/'+$_.Store}|Sort-Object) -join '|') -ceq ($ids -join '|')) 'UniqueStoreIdentities'}
 foreach($e in $expected){$a=@($actual|Where-Object{$_.Location -ceq $e.Location -and $_.Store -ceq $e.Store});Rb-Need ($a[0].Count -eq $e.Count -and $a[0].Fingerprint -ceq $e.Fingerprint) 'AcceptedCertificatesAndAllStoresUnchanged'}
}
function Rb-DynamicAllowed([string]$path,[string]$name,[string]$kind,$value,[string]$mode,[int]$port){
 return ($mode -ceq 'Forward' -and $port -ge 1 -and $port -le 65535 -and
  $path -ceq 'SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL12.YSEDU\MSSQLServer\SuperSocketNetLib\Tcp\IP4' -and
  $name -ceq 'TcpDynamicPorts' -and $kind -ceq 'String' -and [string]$value -ceq [string]$port)
}
$base=$null;$changes=@();$records=@();$operations=0
try{
 Rb-Need ($env:COMPUTERNAME -ceq 'DESKTOP-8QRQT7R' -and $PSVersionTable.PSVersion.ToString() -ceq '7.6.5') 'ExactHostRuntime'
 $id=[Security.Principal.WindowsIdentity]::GetCurrent()
 try{Rb-Need ($id.Name -ceq 'DESKTOP-8QRQT7R\user' -and ([Security.Principal.WindowsPrincipal]::new($id)).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) 'OwnerAdminRequired'}finally{$id.Dispose()}
 Rb-Need ((Get-FileHash -LiteralPath (Join-Path $root 'YSEDU_LEAF_MAINTENANCE_ORIGINAL.json')).Hash -ceq 'BB3BF707DCEEDB99396BF2C598B3A0E9BF2E02E83F3FD7AE3A8DB27CF1931BD5') 'OriginalPin'
 Rb-Need ((Get-FileHash -LiteralPath (Join-Path $root 'LAB_LEAF_ACCEPTANCE_001_RESULT.json')).Hash -ceq '80A38357E94790A5DDE33B714BEBDAE08AC020DEF5F64E91F337244ED5DF25EB') 'AcceptanceResultPin'
 $saved=Get-Content -LiteralPath (Join-Path $root 'YSEDU_LEAF_MAINTENANCE_ORIGINAL.json') -Raw|ConvertFrom-Json
 $accepted=Get-Content -LiteralPath (Join-Path $root 'LAB_LEAF_ACCEPTANCE_001_RESULT.json') -Raw|ConvertFrom-Json
 Rb-Need ($accepted.LeafAcceptedAndVerified -and $accepted.RootRetained -and $accepted.ExistingKeyAssociationVerified) 'AcceptedExistingIdentity'
 $stores=Rb-Stores;Rb-AssertStores $stores $accepted.Final
 $intents=@();$baselineHash=$null
 if($Phase -cne 'Baseline'){
  $baselineFile=Join-Path $root 'YSEDU_SQL_ACTIVATION_001_BEFORE.json';$baselineHash=(Get-FileHash -LiteralPath $baselineFile).Hash
  $attempt=Get-Content -LiteralPath (Join-Path $root 'YSEDU_SQL_ACTIVATION_001_ATTEMPT.json') -Raw|ConvertFrom-Json
  Rb-Need ($attempt.Task -ceq 'YSEDU_SQL_ACTIVATION_001' -and $attempt.BaselineSHA256 -ceq $baselineHash -and $attempt.MaxStops -eq 1 -and $attempt.MaxStarts -eq 1) 'CurrentMaintenanceOwnership'
  foreach($index in 0..3){$p=Join-Path $root ('YSEDU_SQL_ACTIVATION_001_WRITE_'+$index+'.json');if(Test-Path -LiteralPath $p){$intent=Get-Content -LiteralPath $p -Raw|ConvertFrom-Json
    Rb-Need ($intent.Index -eq $index -and $intent.BaselineSHA256 -ceq $baselineHash -and (Rb-Target $intent.Path $intent.Name $intent.Before $intent.After $intent.Kind)) 'ExactOwnedWriteIntent'
    $intents+=@($intent)
  }}
  Rb-Need ((@($intents|ForEach-Object{$_.Path+'|'+$_.Name}|Sort-Object -Unique)).Count -eq $intents.Count) 'UniqueOwnedTargets'
  if($Phase -ceq 'Forward'){Rb-Need ($intents.Count -eq 4) 'AllFourForwardIntents'}
 }
 Rb-Need (-not $Apply -or ($MaintenanceAuthorized -and $Phase -ceq 'OwnedPartial' -and $RuntimePort -eq 0)) 'ApplyOnlyOwnedPreStartPartial'
 $base=[Microsoft.Win32.RegistryKey]::OpenBaseKey('LocalMachine','Registry32')
 $tcp=$base.OpenSubKey($scope+'\Tcp',$false)
 try{$names=@($tcp.GetSubKeyNames()|Sort-Object);$expected=@($saved.TcpRegistry|Where-Object Path -CNE ($scope+'\Tcp')|ForEach-Object{Split-Path $_.Path -Leaf}|Sort-Object);Rb-Need (($names -join '|') -ceq ($expected -join '|')) 'ExactTcpSubkeys'}finally{$tcp.Dispose()}
 foreach($target in @($saved.Security)+@($saved.TcpRegistry)+@($saved.Startup)+@($saved.ServiceRegistry)){
  $k=$base.OpenSubKey($target.Path,$false)
  try{Rb-Need ($null -ne $k) 'RegistryTargetExists';$values=@()
   foreach($v in $target.Values){
    $present=$k.GetValueNames() -ccontains $v.Name;$kind=if($present){[string]$k.GetValueKind($v.Name)}else{$null};$value=if($present){$k.GetValue($v.Name,$null,[Microsoft.Win32.RegistryValueOptions]::DoNotExpandEnvironmentNames)}else{$null}
    $match=$present -eq $v.Present -and $kind -ceq $v.Kind -and (Rb-Equal $value $v.Value)
    $intent=@($intents|Where-Object{$_.Path -ceq $target.Path -and $_.Name -ceq $v.Name})
    if($intent.Count){
     Rb-Need ($present -and $v.Present -and $kind -ceq $v.Kind -and $kind -ceq $intent[0].Kind -and (Rb-Equal $v.Value $intent[0].Before)) 'IntentOriginalMatchesPinnedBaseline'
     $forward=Rb-Equal $value $intent[0].After
     Rb-Need ($forward -or ($Phase -ceq 'OwnedPartial' -and $match)) 'OwnedTargetBeforeOrExactAfter'
     if($forward){$changes+=@([pscustomobject]@{Path=$target.Path;Name=$v.Name;Before=$value;After=$v.Value;Kind=$kind})}
    }elseif(-not $match){Rb-Need (Rb-DynamicAllowed $target.Path $v.Name $kind $value $Phase $RuntimePort) 'UnexplainedRegistryDrift'}
    $values+=@([pscustomobject]@{Name=$v.Name;Present=$present;Kind=$kind;Value=$value})
   }
   $records+=@([pscustomobject]@{Path=$target.Path;Values=$values})
  }finally{if($null -ne $k){$k.Dispose()}}
 }
 $services=@(Get-CimInstance Win32_Service -Filter 'Name=''MSSQL$YSEDU'' OR Name=''SQLBrowser'''|Select-Object Name,State,StartMode,ProcessId,StartName,PathName|Sort-Object Name)
 $sql=@($services|Where-Object Name -CEQ 'MSSQL$YSEDU');$browser=@($services|Where-Object Name -CEQ 'SQLBrowser')
 Rb-Need ($sql.Count -eq 1 -and $sql[0].PathName -ceq $saved.BrowserPolicy.YSEDU.PathName -and $sql[0].StartName -ceq 'LocalSystem' -and $sql[0].StartMode -ceq 'Auto') 'SameSqlService'
 Rb-Need ($browser.Count -eq 1 -and $browser[0].State -ceq 'Stopped' -and $browser[0].StartMode -ceq 'Disabled' -and $browser[0].ProcessId -eq 0 -and $browser[0].PathName -ceq $saved.BrowserPolicy.Browser.PathName -and $browser[0].StartName -ceq $saved.BrowserPolicy.Browser.StartName) 'BrowserUnchangedStoppedDisabled'
 $protocols=@(Get-CimInstance -Namespace 'root\Microsoft\SqlServer\ComputerManagement12' -ClassName ServerNetworkProtocol -Filter "InstanceName='YSEDU'"|Select-Object ProtocolName,Enabled|Sort-Object ProtocolName)
 Rb-Need ($protocols.Count -eq 3 -and (@($protocols.ProtocolName|Sort-Object) -join '|') -ceq 'Np|Sm|Tcp' -and @($protocols|Where-Object{$_.ProtocolName -ceq 'Sm' -and $_.Enabled}).Count -eq 1 -and @($protocols|Where-Object{$_.ProtocolName -ceq 'Np' -and $_.Enabled}).Count -eq 0) 'UnchangedOtherProtocols'
 $tcpEnabled=@($protocols|Where-Object{$_.ProtocolName -ceq 'Tcp' -and $_.Enabled}).Count -eq 1
 $expectedTcp=if($Phase -ceq 'Forward'){$true}elseif($Phase -ceq 'OwnedPartial'){@($changes|Where-Object{$_.Path -ceq ($scope+'\Tcp') -and $_.Name -ceq 'Enabled'}).Count -eq 1}else{$false}
 Rb-Need ($tcpEnabled -eq $expectedTcp) 'TcpProtocolMatchesOwnedState'
 if($Phase -ceq 'Baseline'){Rb-Need ($sql[0].State -ceq 'Running' -and $changes.Count -eq 0) 'OriginalSettingsRunningWithRetainedCertificates'}
 if($Apply){
  Rb-Need (-not(Test-Path -LiteralPath (Join-Path $root 'YSEDU_SQL_ACTIVATION_001_START_ATTEMPT.json'))) 'NoApplyAfterStartAttemptConsumed'
  Rb-Need ($sql[0].State -ceq 'Stopped' -and $sql[0].ProcessId -eq 0) 'ApplyAlreadyStoppedOnly'
  Rb-Need (@(Get-Service -Name 'MSSQL$YSEDU' -DependentServices|Where-Object Status -NE 'Stopped').Count -eq 0) 'StoppedDependents'
  foreach($change in $changes){
   Rb-Need ((Get-Service -Name 'MSSQL$YSEDU').Status -eq 'Stopped') 'StillStoppedBeforeOwnedRestore'
   $k=$base.OpenSubKey($change.Path,$true)
   try{Rb-Need ([string]$k.GetValueKind($change.Name) -ceq $change.Kind -and (Rb-Equal ($k.GetValue($change.Name)) $change.Before)) 'RollbackNoConcurrentDrift';$k.SetValue($change.Name,$change.After,[Enum]::Parse([Microsoft.Win32.RegistryValueKind],$change.Kind));$operations++}finally{$k.Dispose()}
  }
  foreach($change in $changes){$k=$base.OpenSubKey($change.Path,$false);try{Rb-Need (Rb-Equal ($k.GetValue($change.Name)) $change.After) 'OwnedRestoreValueVerified'}finally{$k.Dispose()}}
  Rb-AssertStores (Rb-Stores) $accepted.Final
  $verified=(& $PSCommandPath -Phase OwnedPartial) -join "`n"|ConvertFrom-Json
  Rb-Need ($verified.Changes.Count -eq 0 -and @($verified.Services|Where-Object{$_.Name -ceq 'MSSQL$YSEDU' -and $_.State -ceq 'Stopped' -and $_.ProcessId -eq 0}).Count -eq 1) 'FullOriginalSettingsVerifiedWhileStopped'
 }
 [pscustomobject]@{Decision=if($Apply){'YSEDU_ROLLBACK_002_OWNED_SETTINGS_RESTORED_CERTIFICATES_RETAINED'}else{'YSEDU_ROLLBACK_002_RETAINED_CERTIFICATES_INSPECTION_PASSED'};Phase=$Phase;ApplyRequested=[bool]$Apply;Operations=$operations;Changes=$changes;Registry=$records;Stores=$stores;Services=$services;Protocols=$protocols;RootOrLeafDeleted=$false;KeyOrAclChanged=$false;ServiceCalls=0;RuntimePort=$RuntimePort}|ConvertTo-Json -Depth 16
}finally{if($null -ne $base){$base.Dispose()}}
