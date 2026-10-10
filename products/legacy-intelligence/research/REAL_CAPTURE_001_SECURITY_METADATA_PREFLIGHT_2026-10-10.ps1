# Capture #001: read-only security metadata gate; NO SQL contents/copy/stop/start.
$ErrorActionPreference='Stop'
$securityIdentity=[Security.Principal.WindowsIdentity]::GetCurrent()
$securityPrincipal=[Security.Principal.WindowsPrincipal]::new($securityIdentity)
if($env:COMPUTERNAME -cne 'DESKTOP-8QRQT7R' -or -not $securityPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)){throw 'STOP: actual authorized administrator on exact host required; no elevation routine'}
$securityBase='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-real-recovery-capture-001-20261010\Read-Capture001Preflight.ps1'
if((Get-FileHash -LiteralPath $securityBase -Algorithm SHA256).Hash -cne '8797AC90621F4584E403AE537C556ACE86891BF7338E6AD275FCBAC055DA0340'){throw 'STOP: approved read-only preflight helper changed'}
$securityPreflightJson=& ([scriptblock]::Create((Get-Content -LiteralPath $securityBase -Raw)))
$securityPreflight=$securityPreflightJson|ConvertFrom-Json
if($securityPreflight.Decision -cne 'ADMINISTRATIVE_FILESET_PREFLIGHT_PASSED_SECURITY_METADATA_PENDING' -or $securityPreflight.PersistentCount -ne 23){throw 'STOP: refreshed allowlist preflight did not pass'}
if('DblCapture001SecurityRead' -as [type]){throw 'STOP: use a fresh administrative PowerShell session; no repeated native-type replacement'}
Add-Type -TypeDefinition @'
using System;
using System.Runtime.InteropServices;
using Microsoft.Win32.SafeHandles;
public static class DblCapture001SecurityRead {
 [StructLayout(LayoutKind.Sequential)] public struct Luid {public uint Low;public int High;}
 [StructLayout(LayoutKind.Sequential)] public struct Tp {public uint Count;public Luid Id;public uint Attributes;}
 [StructLayout(LayoutKind.Sequential)] public struct Info {
  public uint Attributes,CreationLow,CreationHigh,AccessLow,AccessHigh,WriteLow,WriteHigh;
  public uint VolumeSerial,SizeHigh,SizeLow,NumberOfLinks,IndexHigh,IndexLow;
 }
 [DllImport("kernel32.dll")] static extern IntPtr GetCurrentProcess();
 [DllImport("kernel32.dll")] static extern bool CloseHandle(IntPtr handle);
 [DllImport("kernel32.dll")] static extern IntPtr LocalFree(IntPtr buffer);
 [DllImport("advapi32.dll",SetLastError=true)] static extern bool OpenProcessToken(IntPtr process,uint access,out IntPtr token);
 [DllImport("advapi32.dll",CharSet=CharSet.Unicode,SetLastError=true)] static extern bool LookupPrivilegeValue(string system,string name,out Luid id);
 [DllImport("advapi32.dll",SetLastError=true)] static extern bool AdjustTokenPrivileges(IntPtr token,bool disable,ref Tp state,int length,out Tp previous,out int returned);
 [DllImport("advapi32.dll",CharSet=CharSet.Unicode,ExactSpelling=true)] static extern uint GetNamedSecurityInfoW(string path,int objectType,uint info,out IntPtr owner,out IntPtr group,out IntPtr dacl,out IntPtr sacl,out IntPtr descriptor);
 [DllImport("advapi32.dll")] static extern uint GetSecurityDescriptorLength(IntPtr descriptor);
 [DllImport("kernel32.dll",CharSet=CharSet.Unicode,SetLastError=true,ExactSpelling=true)] static extern SafeFileHandle CreateFileW(string path,uint access,uint share,IntPtr security,uint creation,uint flags,IntPtr template);
 [DllImport("kernel32.dll",SetLastError=true)] static extern bool GetFileInformationByHandle(SafeFileHandle file,out Info info);
 public static Tp EnableSecurity() {
  IntPtr token;if(!OpenProcessToken(GetCurrentProcess(),0x28,out token))throw new InvalidOperationException("Process token open failed");
  try {Luid id;if(!LookupPrivilegeValue(null,"SeSecurityPrivilege",out id))throw new InvalidOperationException("Security privilege lookup failed");
   Tp wanted=new Tp{Count=1,Id=id,Attributes=2},previous;int returned;
   if(!AdjustTokenPrivileges(token,false,ref wanted,Marshal.SizeOf(typeof(Tp)),out previous,out returned)||Marshal.GetLastWin32Error()!=0)throw new InvalidOperationException("Security privilege not assigned");
   return previous;
  }finally{CloseHandle(token);}
 }
 public static void RestoreSecurity(Tp previous) {
  if(previous.Count==0)return;IntPtr token;
  if(!OpenProcessToken(GetCurrentProcess(),0x28,out token))throw new InvalidOperationException("Privilege restore token open failed");
  try {Tp unused;int returned;
   if(!AdjustTokenPrivileges(token,false,ref previous,Marshal.SizeOf(typeof(Tp)),out unused,out returned)||Marshal.GetLastWin32Error()!=0)throw new InvalidOperationException("Privilege restore failed");
  }finally{CloseHandle(token);}
 }
 public static byte[] Descriptor(string path) {
  IntPtr owner,group,dacl,sacl,descriptor=IntPtr.Zero;
  try {
   // BACKUP_SECURITY_INFORMATION asks for all descriptor parts, including label/policy ACEs.
   uint error=GetNamedSecurityInfoW(path,1,0x00010000,out owner,out group,out dacl,out sacl,out descriptor);
   if(error!=0||descriptor==IntPtr.Zero)throw new InvalidOperationException("Full descriptor read failed; Win32="+error);
   uint size=GetSecurityDescriptorLength(descriptor);
   if(size<20||size>262144)throw new InvalidOperationException("Descriptor size outside bound");
   byte[] result=new byte[(int)size];Marshal.Copy(descriptor,result,0,result.Length);return result;
  }finally{if(descriptor!=IntPtr.Zero)LocalFree(descriptor);}
 }
 public static Info Metadata(string path) {
  // Metadata-only handle: desired access zero, share read/write/delete; NEVER reads file contents.
  using(SafeFileHandle file=CreateFileW(path,0,7,IntPtr.Zero,3,0x02200000,IntPtr.Zero)) {
   if(file.IsInvalid)throw new InvalidOperationException("Metadata handle open failed; Win32="+Marshal.GetLastWin32Error());
   Info result;if(!GetFileInformationByHandle(file,out result))throw new InvalidOperationException("Metadata query failed; Win32="+Marshal.GetLastWin32Error());
   return result;
  }
 }
}
'@
$securityPaths=@{}
foreach($securityFile in $securityPreflight.Files){
 $securityPaths[$securityFile.Path]=$false
 $securityDirectory=[IO.DirectoryInfo]::new([IO.Path]::GetDirectoryName($securityFile.Path))
 while($null -ne $securityDirectory){
  if(-not $securityPaths.ContainsKey($securityDirectory.FullName)){$securityPaths[$securityDirectory.FullName]=$true}
  $securityDirectory=$securityDirectory.Parent
 }
}
if($securityPaths.Count -gt 64){throw 'STOP: parent-directory scope exceeds bound'}
$securityPrevious=$null;$securityFailure=$null;$securityRestoreFailure=$null;$securityResults=@()
$securityHash=[Security.Cryptography.SHA256]::Create()
try {
 $securityPrevious=[DblCapture001SecurityRead]::EnableSecurity()
 foreach($securityPath in @($securityPaths.Keys|Sort-Object)){
  $securityItem=Get-Item -LiteralPath $securityPath -Force
  $securityDirectory=[bool]$securityPaths[$securityPath]
  if($securityItem.PSIsContainer -ne $securityDirectory){throw "STOP: file/directory identity mismatch: $securityPath"}
  $securityUnsupported=[IO.FileAttributes]::ReparsePoint -bor [IO.FileAttributes]::Encrypted -bor [IO.FileAttributes]::SparseFile -bor [IO.FileAttributes]::Compressed
  if($securityItem.Attributes -band $securityUnsupported){throw "STOP: unsupported source/parent attributes: $securityPath"}
  $securityInformation=[DblCapture001SecurityRead]::Metadata($securityPath)
  if(-not $securityDirectory -and $securityInformation.NumberOfLinks -ne 1){throw "STOP: file hardlink count is not one: $securityPath"}
  $securityRaw=[DblCapture001SecurityRead]::Descriptor($securityPath)
  $securityDescriptor=[Security.AccessControl.RawSecurityDescriptor]::new($securityRaw,0)
  if($null -eq $securityDescriptor.Owner -or $null -eq $securityDescriptor.Group -or $null -eq $securityDescriptor.DiscretionaryAcl){throw "STOP: unqualified null owner/group/DACL: $securityPath"}
  $null=$securityDescriptor.Owner.Translate([Security.Principal.NTAccount])
  $null=$securityDescriptor.Group.Translate([Security.Principal.NTAccount])
  $securityDaclCount=0;$securitySaclCount=0
  foreach($securityAce in $securityDescriptor.DiscretionaryAcl){
   if([int]$securityAce.AceType -notin @(0,1) -or $securityAce -isnot [Security.AccessControl.CommonAce] -or $securityAce.IsCallback){throw "STOP: unsupported DACL ACE type: $securityPath"}
   $null=$securityAce.SecurityIdentifier.Translate([Security.Principal.NTAccount]);$securityDaclCount++
  }
  if($null -ne $securityDescriptor.SystemAcl){
   foreach($securityAce in $securityDescriptor.SystemAcl){
    if([int]$securityAce.AceType -ne 2 -or $securityAce -isnot [Security.AccessControl.CommonAce] -or $securityAce.IsCallback){throw "STOP: unqualified SACL label/policy/ACE: $securityPath"}
    $null=$securityAce.SecurityIdentifier.Translate([Security.Principal.NTAccount]);$securitySaclCount++
   }
  }
  $securitySddl=$securityDescriptor.GetSddlForm([Security.AccessControl.AccessControlSections]::All)
  $securityRoundtrip=[Security.AccessControl.RawSecurityDescriptor]::new($securitySddl)
  if($securityRoundtrip.GetSddlForm([Security.AccessControl.AccessControlSections]::All) -cne $securitySddl){throw "STOP: descriptor string conversion mismatch: $securityPath"}
  if(-not $securityDirectory){
   $securityStreams=@(Get-Item -LiteralPath $securityPath -Stream *)
   if(@($securityStreams|Where-Object Stream -ne ':$DATA').Count){throw "STOP: alternate file stream: $securityPath"}
  }
  $securitySddlHash=[BitConverter]::ToString($securityHash.ComputeHash([Text.Encoding]::UTF8.GetBytes($securitySddl))).Replace('-','')
  $securityResults+=[pscustomobject]@{
   Path=$securityPath;Directory=$securityDirectory;Attributes=[int]$securityItem.Attributes
   LinkCount=$securityInformation.NumberOfLinks
   FileIdentity=('{0:X8}:{1:X8}{2:X8}' -f $securityInformation.VolumeSerial,$securityInformation.IndexHigh,$securityInformation.IndexLow)
   FullSddlSha256=$securitySddlHash
   OwnerGroupAndAceSidsResolved=$true;DaclAceCount=$securityDaclCount;AuditSaclAceCount=$securitySaclCount
   UnsupportedSecurityAce=$false;DirectoryReparse=$false
  }
 }
}catch{$securityFailure=$_.Exception.Message}
finally{
 $securityHash.Dispose()
 if($null -ne $securityPrevious){try{[DblCapture001SecurityRead]::RestoreSecurity($securityPrevious)}catch{$securityRestoreFailure=$_.Exception.Message}}
}
if($null -ne $securityFailure -or $null -ne $securityRestoreFailure){
 [pscustomobject]@{Decision='SECURITY_METADATA_PREFLIGHT_BLOCKED';ObservedAt=(Get-Date -Format o);CompletedRecords=$securityResults.Count;Reason=$securityFailure;PrivilegeRestoreFailure=$securityRestoreFailure;SqlStopped=$false;SourceContentsRead=$false;SourceSecurityChanged=$false}|ConvertTo-Json -Depth 5
 throw 'STOP: security metadata gate did not pass; no shutdown authorized by this script'
}
[pscustomobject]@{
 Decision='SECURITY_METADATA_PREFLIGHT_PASSED'
 ObservedAt=(Get-Date -Format o);Host=$env:COMPUTERNAME;Operator=$securityIdentity.Name;Elevated=$true
 PersistentFileCount=$securityPreflight.PersistentCount;PersistentBytes=$securityPreflight.PersistentBytes
 SecurityRecordCount=$securityResults.Count;Records=$securityResults
 ProcessSecurityPrivilegeRestored=$true
 FullDescriptorRawValuesPublished=$false;SourceContentsRead=$false;SourcesChanged=$false;SqlStopped=$false;SqlConnection=$false;EWrites=$false
 Pending=@('Exact settings and local evidence allowlist','Private NTFS root ACL','Normal ERP closure','Final pre-stop refresh and bounded capture')
}|ConvertTo-Json -Depth 7
