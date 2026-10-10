$ErrorActionPreference='Stop'
$testRoot='C:\Users\user\Documents\Codex\FRCSQ-20261010-7e3821a9'
if ($env:COMPUTERNAME -cne 'DESKTOP-8QRQT7R' -or (Get-Content -LiteralPath "$testRoot\OWNERSHIP.txt" -Raw).Trim() -cne 'DBL_SYNTHETIC_ONLY FRCSQ 7e3821a9 2026-10-10') {throw 'Host/test ownership mismatch'}
if ((Get-Item -LiteralPath $testRoot).Attributes -band [IO.FileAttributes]::ReparsePoint -or @(Get-ChildItem -LiteralPath $testRoot -Recurse -Force|Where-Object {$_.Attributes -band [IO.FileAttributes]::ReparsePoint}).Count) {throw 'Link in test root'}
$principal=[Security.Principal.WindowsPrincipal]::new([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)){throw 'Actual administrator token required; no automatic elevation'}
$area="$testRoot\elevated-metadata"
if (Test-Path -LiteralPath $area){throw 'Fresh elevated synthetic area required'}
New-Item -ItemType Directory -Path $area|Out-Null
$oldTemp=$env:TEMP;$oldTmp=$env:TMP
New-Item -ItemType Directory -Path "$area\compiler-temp"|Out-Null
$env:TEMP="$area\compiler-temp";$env:TMP="$area\compiler-temp"
try {
Add-Type -TypeDefinition @'
using System;
using System.Runtime.InteropServices;
public static class DblSyntheticToken {
 [StructLayout(LayoutKind.Sequential)] public struct Luid { public uint Low; public int High; }
 [StructLayout(LayoutKind.Sequential)] public struct Tp { public uint Count; public Luid Id; public uint Attributes; }
 [DllImport("kernel32.dll")] static extern IntPtr GetCurrentProcess();
 [DllImport("kernel32.dll")] static extern bool CloseHandle(IntPtr h);
 [DllImport("advapi32.dll",SetLastError=true)] static extern bool OpenProcessToken(IntPtr p,uint access,out IntPtr token);
 [DllImport("advapi32.dll",CharSet=CharSet.Unicode,SetLastError=true)] static extern bool LookupPrivilegeValue(string system,string name,out Luid id);
 [DllImport("advapi32.dll",SetLastError=true)] static extern bool AdjustTokenPrivileges(IntPtr token,bool disable,ref Tp state,int length,out Tp previous,out int returned);
 public static Tp Enable(string name) {
   if(name!="SeRestorePrivilege" && name!="SeSecurityPrivilege") throw new InvalidOperationException("Synthetic privilege allowlist");
   IntPtr token; if(!OpenProcessToken(GetCurrentProcess(),0x28,out token)) throw new InvalidOperationException("Token open failed");
   try { Luid id; if(!LookupPrivilegeValue(null,name,out id)) throw new InvalidOperationException("Privilege lookup failed");
     Tp state=new Tp{Count=1,Id=id,Attributes=2},old;int returned;
     if(!AdjustTokenPrivileges(token,false,ref state,Marshal.SizeOf(typeof(Tp)),out old,out returned) || Marshal.GetLastWin32Error()!=0) throw new InvalidOperationException("Privilege not assigned");return old;
   } finally {CloseHandle(token);}
 }
 public static void Restore(Tp old) {
   if(old.Count==0)return;IntPtr token;if(!OpenProcessToken(GetCurrentProcess(),0x28,out token))throw new InvalidOperationException("Token restore open failed");
   try {Tp unused;int returned;if(!AdjustTokenPrivileges(token,false,ref old,Marshal.SizeOf(typeof(Tp)),out unused,out returned)||Marshal.GetLastWin32Error()!=0)throw new InvalidOperationException("Token restore failed");}finally{CloseHandle(token);}
 }
}
'@
$beforeRestore=$null;$beforeSecurity=$null
try {
    $beforeRestore=[DblSyntheticToken]::Enable('SeRestorePrivilege');$beforeSecurity=[DblSyntheticToken]::Enable('SeSecurityPrivilege')
    $sid=[Security.Principal.WindowsIdentity]::GetCurrent().User.Value
    $folder=[Security.AccessControl.DirectorySecurity]::new();$folder.SetSecurityDescriptorSddlForm("O:$($sid)G:$($sid)D:PAI(A;OICI;FA;;;SY)(A;OICI;FA;;;BA)(A;OICI;FA;;;$sid)")
    Set-Acl -LiteralPath $area -AclObject $folder
    $source="$area\dummy-source.txt";$target="$area\dummy-restored.txt"
    [IO.File]::WriteAllText($source,'DBL SYNTHETIC OWNER AND AUDIT TEST',[Text.UTF8Encoding]::new($false))
    $fileSecurity=[Security.AccessControl.FileSecurity]::new()
    $fileSecurity.SetSecurityDescriptorSddlForm("O:SYG:BAD:PAI(A;;FA;;;SY)(A;;FA;;;BA)(A;;FA;;;$sid)S:(AU;SAFA;FR;;;$sid)")
    Set-Acl -LiteralPath $source -AclObject $fileSecurity
    $sections=[Security.AccessControl.AccessControlSections]::All
    $sourceAcl=Get-Acl -LiteralPath $source -Audit
    $manifest=[pscustomobject]@{Scope='synthetic-only same-host';SourceName='dummy-source.txt';TargetName='dummy-restored.txt';Owner=$sourceAcl.GetOwner([Security.Principal.SecurityIdentifier]).Value;Sddl=$sourceAcl.GetSecurityDescriptorSddlForm($sections);AuditRuleCount=@($sourceAcl.GetAuditRules($true,$true,[Security.Principal.SecurityIdentifier])).Count;Bytes=(Get-Item -LiteralPath $source).Length;SHA256=(Get-FileHash -LiteralPath $source -Algorithm SHA256).Hash}
    if($manifest.Owner -ne 'S-1-5-18' -or $manifest.AuditRuleCount -lt 1){throw 'Non-user owner/audit source not established'}
    $manifest|ConvertTo-Json -Depth 6|Set-Content -LiteralPath "$area\manifest.json" -Encoding utf8
    [IO.File]::WriteAllText($target,'DBL SYNTHETIC OWNER AND AUDIT TEST',[Text.UTF8Encoding]::new($false))
    $beforeOwner=(Get-Acl -LiteralPath $target).GetOwner([Security.Principal.SecurityIdentifier]).Value
    if($beforeOwner -eq $manifest.Owner){throw 'Owner-change test is vacuous'}
    $recorded=Get-Content -LiteralPath "$area\manifest.json" -Raw|ConvertFrom-Json
    $restoredSecurity=[Security.AccessControl.FileSecurity]::new();$restoredSecurity.SetSecurityDescriptorSddlForm($recorded.Sddl,$sections)
    Set-Acl -LiteralPath $target -AclObject $restoredSecurity
    $after=Get-Acl -LiteralPath $target -Audit
    if($after.GetSecurityDescriptorSddlForm($sections) -cne $recorded.Sddl -or (Get-FileHash -LiteralPath $target -Algorithm SHA256).Hash -cne $recorded.SHA256){throw 'Full synthetic security descriptor/hash mismatch'}
    $result=[pscustomobject]@{Decision='ARBITRARY_OWNER_DACL_AUDIT_SACL_SYNTHETIC_PASSED';At=(Get-Date -Format o);Elevated=$true;OwnerBefore=$beforeOwner;OwnerAfter=$after.GetOwner([Security.Principal.SecurityIdentifier]).Value;AuditRuleCount=$recorded.AuditRuleCount;FullSddlEqual=$true;SHA256=$recorded.SHA256;MachinePolicyChange=$false;SqlOrErpRead=$false;FixtureRoot=$area;MandatoryIntegrityLabelCustomReplay='NOT_TESTED'}
    $result|ConvertTo-Json -Depth 6|Set-Content -LiteralPath "$area\RESULT.json" -Encoding utf8
    $result|ConvertTo-Json -Depth 6
}finally{
    if($null -ne $beforeSecurity){[DblSyntheticToken]::Restore($beforeSecurity)}
    if($null -ne $beforeRestore){[DblSyntheticToken]::Restore($beforeRestore)}
}
}finally{$env:TEMP=$oldTemp;$env:TMP=$oldTmp}
