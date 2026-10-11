$ErrorActionPreference='Stop';Set-StrictMode -Version Latest
$root=$PSScriptRoot;$helper=Join-Path $root 'Invoke-LabLeafAcceptance001.ps1'
$tokens=$null;$errors=$null
$ast=[Management.Automation.Language.Parser]::ParseFile($helper,[ref]$tokens,[ref]$errors)
if($errors.Count){throw 'Helper parse failed'}
# Load only explicitly named pure guards. Never execute the helper's operational body.
$allow=@('Need','Assert-Delta','Assert-ChainIdentity','Assert-Chain','Classify-Revocation','Test-RootRollbackSafe')
foreach($name in $allow){
 $f=@($ast.FindAll({param($n) $n -is [Management.Automation.Language.FunctionDefinitionAst]},$false)|Where-Object Name -CEQ $name)
 if($f.Count -ne 1){throw 'Pure guard definition mismatch'}
 . ([scriptblock]::Create($f[0].Extent.Text))
}
$state=[pscustomobject]@{Check='test'};$checks=0
function Pass($body){& $body;$script:checks++}
function Reject($body){$rejected=$false;try{& $body}catch{$rejected=$true};if(-not $rejected){throw 'Negative case accepted'};$script:checks++}
# Independent inventory fixtures use fixed symbolic entries, not native-reader expected results.
$caEntry='new-root';$leafEntry='new-leaf';$pendingThumb='old-request'
$before=@(
 [pscustomobject]@{Location='CurrentUser';Store='Root';Entries=@('existing-root')},
 [pscustomobject]@{Location='CurrentUser';Store='CA';Entries=@()},
 [pscustomobject]@{Location='CurrentUser';Store='My';Entries=@('existing-user-cert')},
 [pscustomobject]@{Location='LocalMachine';Store='Root';Entries=@('existing-root')},
 [pscustomobject]@{Location='LocalMachine';Store='CA';Entries=@()},
 [pscustomobject]@{Location='LocalMachine';Store='My';Entries=@()},
 [pscustomobject]@{Location='LocalMachine';Store='Request';Entries=@('old-request:hash')})
function Clone($v){return ($v|ConvertTo-Json -Depth 12|ConvertFrom-Json)}
Pass {Assert-Delta $before $before $false $false}
$rootOnly=Clone $before;foreach($v in $rootOnly){if($v.Store -ceq 'Root'){$v.Entries+=@('new-root')}}
Pass {Assert-Delta $before $rootOnly $true $false}
$enrolled=Clone $rootOnly;$enrolled[5].Entries=@('new-leaf');$enrolled[6].Entries=@()
Pass {Assert-Delta $before $enrolled $true $true}
Reject {Assert-Delta $before $enrolled $true $false}
Reject {Assert-Delta $before $rootOnly $true $true}
$unexpected=Clone $rootOnly;$unexpected[1].Entries=@('unapproved-issuer')
Reject {Assert-Delta $before $unexpected $true $false}
$missing=Clone $rootOnly;$missing[6]=$missing[5]
Reject {Assert-Delta $before $missing $true $false}
$duplicates=Clone $before;$duplicates[6]=$duplicates[5]
Reject {Assert-Delta $duplicates $duplicates $false $false}
Pass {if(-not(Test-RootRollbackSafe $before $rootOnly $false $true $true $true)){throw 'Root-only rollback should qualify'}}
foreach($case in @(@($true,$true,$true,$true),@($false,$false,$true,$true),@($false,$true,$false,$true),@($false,$true,$true,$false))){
 Pass {if(Test-RootRollbackSafe $before $rootOnly $case[0] $case[1] $case[2] $case[3]){throw 'Unsafe rollback accepted'}}
}
Pass {if(Test-RootRollbackSafe $before $enrolled $false $true $true $true){throw 'Request consumption must defer rollback'}}
# Reuse actual prior observations as inputs; no expected values are computed by the new reader.
$evidence=Get-Content -LiteralPath (Join-Path $root 'MACHINE_ROOT_REMEDY_001_RESULT.json') -Raw|ConvertFrom-Json
$leafThumb='A51BD253B6083D0114428FCFBAD57D008CD102F5';$caThumb='121CDC9857488ED95F4BC62106D7672BB0DBC6C3'
foreach($chain in $evidence.ChainResults){Pass {Assert-Chain $chain}}
foreach($rev in $evidence.RevocationResults){Pass {if((Classify-Revocation $rev) -cne 'UNKNOWN'){throw 'Unknown mislabeled'}}}
$chain=Clone $evidence.ChainResults[0]
$bad=Clone $chain;$bad.SslPolicy.Hostname='different-host';Reject {Assert-Chain $bad}
$bad=Clone $chain;$bad.SslPolicy.IgnoreFlags=1;Reject {Assert-Chain $bad}
$bad=Clone $chain;$bad.AdditionalPublicIssuer=$true;Reject {Assert-Chain $bad}
$bad=Clone $chain;$bad.Elements[1].Thumbprint='different-ca';Reject {Assert-Chain $bad}
$bad=Clone $chain;$bad.ErrorStatus='0x00000020';Reject {Assert-Chain $bad}
$bad=Clone $chain;$bad.Elements[0].ErrorStatus='0x00000020';Reject {Assert-Chain $bad}
$rev=Clone $evidence.RevocationResults[0]
foreach($status in @('0x00000004','0x00000044','0x00000060','0x01000000')){
 $bad=Clone $rev;$bad.ErrorStatus=$status;Reject {Classify-Revocation $bad|Out-Null}
}
$bad=Clone $rev;$bad.Elements[1].ErrorStatus='0x00000040';Reject {Classify-Revocation $bad|Out-Null}
$bad=Clone $rev;$bad.RevocationRequested=$false;Reject {Classify-Revocation $bad|Out-Null}
$offline=Clone $rev;$offline.ErrorStatus='0x01000040';$offline.Elements[0].ErrorStatus='0x01000040';$offline.BasePolicy.Error='0x80092013';$offline.SslPolicy.Error='0x80092013'
Pass {if((Classify-Revocation $offline) -cne 'UNKNOWN'){throw 'Offline UNKNOWN mislabeled'}}
$good=Clone $rev;$good.ErrorStatus='0x00000000';$good.BasePolicy.Error='0x00000000';$good.SslPolicy.Error='0x00000000';$good.Elements[0].ErrorStatus='0x00000000'
Pass {if((Classify-Revocation $good) -cne 'PASSED_CACHE_ONLY_AT_OBSERVATION'){throw 'Positive observation classification failed'}}
$source=Get-Content -LiteralPath $helper -Raw
Pass {if(([regex]::Matches($source,'\$process\.Start\(\)')).Count -ne 1 -or -not $source.Contains('@(''-accept'',''-machine'',$leafPath)')){throw 'Ordinary one-call certreq boundary failed'}}
Pass {if($source -match '(?i)Stop-Service|Start-Service|Restart-Service|\.Kill\(|Set-Acl|Remove-Item|Import-PfxCertificate|[\x27\x22]-AllowUntrusted|TrustServerCertificate\s*=\s*\$true') {throw 'Forbidden operational call'}}
Pass {if(-not $source.Contains('CreateNew') -or -not $source.Contains('FreshAttemptNoOverwrite')){throw 'Evidence overwrite or replay guard missing'}}
# No compilation of writer, no stores/services/registry/key/CA reads, no native calls.
[pscustomobject]@{Decision='LAB_LEAF_ACCEPTANCE_PURE_GUARDS_PASSED';Checks=$checks;HelperSHA256=(Get-FileHash -LiteralPath $helper -Algorithm SHA256).Hash;Fixtures='Independent store vectors and prior captured chain observations';NativeMutation=$false;CertreqInvoked=$false;SQLConnection=$false;Limitation='Does not prove enrollment or runtime native behavior'}|ConvertTo-Json
