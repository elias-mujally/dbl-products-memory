# Security Metadata Access Diagnosis #001: bounded read-only; NO SQL contents/copy/stop/start.
# Existing SeSecurityPrivilege enabled temporarily and restored; no account rights or ACL changes.
# Partial probes are diagnostic ONLY. Gate requires full BACKUP descriptor with all original checks.
$ErrorActionPreference='Stop'
$securityIdentity=[Security.Principal.WindowsIdentity]::GetCurrent()
$securityPrincipal=[Security.Principal.WindowsPrincipal]::new($securityIdentity)
if($env:COMPUTERNAME -cne 'DESKTOP-8QRQT7R' -or -not $securityPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)){throw 'STOP: actual authorized administrator on exact host required; no elevation routine'}
$securityBase='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-real-recovery-capture-001-20261010\Read-Capture001Preflight.ps1'
if((Get-FileHash -LiteralPath $securityBase -Algorithm SHA256).Hash -cne '8797AC90621F4584E403AE537C556ACE86891BF7338E6AD275FCBAC055DA0340'){throw 'STOP: approved read-only preflight helper changed'}
$securityPreflightJson=& ([scriptblock]::Create((Get-Content -LiteralPath $securityBase -Raw)))
$securityPreflight=$securityPreflightJson|ConvertFrom-Json
if($securityPreflight.Decision -cne 'ADMINISTRATIVE_FILESET_PREFLIGHT_PASSED_SECURITY_METADATA_PENDING' -or $securityPreflight.PersistentCount -ne 23){throw 'STOP: refreshed allowlist preflight did not pass'}
if('DblSecurityDiagnosis001' -as [type]){throw 'STOP: use a fresh administrative PowerShell session; no repeated native-type replacement'}
Add-Type -TypeDefinition @'
using System;
using System.Runtime.InteropServices;
using Microsoft.Win32.SafeHandles;
public static class DblSecurityDiagnosis001 {
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

 public sealed class TokenState {
  public bool Elevated,SecurityPresent,SecurityEnabled,BackupEnabled,RestoreEnabled,ThreadTokenPresent;
  public uint SecurityAttributes;
  public int ElevationType;
 }
 [DllImport("kernel32.dll")] static extern IntPtr GetCurrentThread();
 [DllImport("advapi32.dll",SetLastError=true)] static extern bool OpenThreadToken(IntPtr t,uint a,bool s,out IntPtr h);
 [DllImport("advapi32.dll",SetLastError=true)] static extern bool GetTokenInformation(IntPtr t,int c,IntPtr b,int n,out int used);
 [DllImport("advapi32.dll")] static extern uint GetSecurityInfo(SafeFileHandle h,int type,uint mask,out IntPtr o,out IntPtr g,out IntPtr d,out IntPtr s,out IntPtr sd);
 [DllImport("advapi32.dll")] static extern void QuerySecurityAccessMask(uint mask,out uint access);
 [DllImport("advapi32.dll",SetLastError=true)] static extern bool GetSecurityDescriptorControl(IntPtr sd,out ushort control,out uint revision);
 static IntPtr TokenBuffer(IntPtr t,int c,out int n) {
  GetTokenInformation(t,c,IntPtr.Zero,0,out n);
  if(n<4||n>65536)throw new InvalidOperationException("Token buffer outside bound");
  IntPtr b=Marshal.AllocHGlobal(n);
  if(!GetTokenInformation(t,c,b,n,out n)){int e=Marshal.GetLastWin32Error();Marshal.FreeHGlobal(b);throw new InvalidOperationException("Token query failed; Win32="+e);}return b;
 }
 public static TokenState State() {
  TokenState r=new TokenState();IntPtr t;
  if(!OpenProcessToken(GetCurrentProcess(),8,out t))throw new InvalidOperationException("Token query open failed");
  try {
   int n;IntPtr b=TokenBuffer(t,20,out n);try{r.Elevated=Marshal.ReadInt32(b)!=0;}finally{Marshal.FreeHGlobal(b);}
   b=TokenBuffer(t,18,out n);try{r.ElevationType=Marshal.ReadInt32(b);}finally{Marshal.FreeHGlobal(b);}
   Luid security,backup,restore;
   if(!LookupPrivilegeValue(null,"SeSecurityPrivilege",out security)||!LookupPrivilegeValue(null,"SeBackupPrivilege",out backup)||!LookupPrivilegeValue(null,"SeRestorePrivilege",out restore))throw new InvalidOperationException("Privilege lookup failed");
   b=TokenBuffer(t,3,out n);
   try {
    int count=Marshal.ReadInt32(b);if(count<0||count>256||4+count*12>n)throw new InvalidOperationException("Token privilege count outside bound");
    for(int i=0;i<count;i++){IntPtr row=IntPtr.Add(b,4+i*12);Luid id=(Luid)Marshal.PtrToStructure(row,typeof(Luid));uint a=unchecked((uint)Marshal.ReadInt32(row,8));
     if(id.Low==security.Low&&id.High==security.High){r.SecurityPresent=true;r.SecurityAttributes=a;r.SecurityEnabled=(a&2)!=0;}
     if(id.Low==backup.Low&&id.High==backup.High)r.BackupEnabled=(a&2)!=0;
     if(id.Low==restore.Low&&id.High==restore.High)r.RestoreEnabled=(a&2)!=0;
    }
   }finally{Marshal.FreeHGlobal(b);}
  }finally{CloseHandle(t);}
  IntPtr thread;if(OpenThreadToken(GetCurrentThread(),8,true,out thread)){r.ThreadTokenPresent=true;CloseHandle(thread);}
  else {int e=Marshal.GetLastWin32Error();if(e!=1008)throw new InvalidOperationException("Thread token query failed; Win32="+e);}
  return r;
 }
 public static uint RequiredAccess(uint mask){uint a;QuerySecurityAccessMask(mask,out a);return a;}
 public static bool UseHandle=false;
 public static uint Mask=0x10000,LastError=0;
 public static string LastStage="";

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
   LastError=0;LastStage="QueryDescriptor";
   uint error;
   if(!UseHandle){error=GetNamedSecurityInfoW(path,1,Mask,out owner,out group,out dacl,out sacl,out descriptor);}
   else {
    LastStage="OpenSecurityHandle";
    // READ_CONTROL | ACCESS_SYSTEM_SECURITY ONLY; no data-read/write/ACL-write/owner-write.
    using(SafeFileHandle file=CreateFileW(path,0x01020000,7,IntPtr.Zero,3,0x02200000,IntPtr.Zero)){
     if(file.IsInvalid){LastError=unchecked((uint)Marshal.GetLastWin32Error());throw new InvalidOperationException("Security handle open failed; Win32="+LastError);}
     LastStage="QueryDescriptor";error=GetSecurityInfo(file,1,Mask,out owner,out group,out dacl,out sacl,out descriptor);
    }
   }
   LastError=error;
   if(error!=0||descriptor==IntPtr.Zero)throw new InvalidOperationException("Full descriptor read failed; Win32="+error);
   LastStage="DescriptorConversion";
   ushort control;uint revision;
   if(!GetSecurityDescriptorControl(descriptor,out control,out revision)||(control&0x8000)==0)throw new InvalidOperationException("STOP: returned descriptor not qualified self-relative");
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
$diagBefore=[DblSecurityDiagnosis001]::State();$diagDuring=$null;$diagAfter=$null
$diagFirstFailure=$null;$diagComparisons=@();$diagReader='OriginalNamedBackup';$diagPath=$null;$diagStage='TokenPreflight'
$diagRequired=[DblSecurityDiagnosis001]::RequiredAccess(0x10000)
function Read-DiagnosticProbe([string]$path,[uint32]$mask,[bool]$handle) {
 [DblSecurityDiagnosis001]::UseHandle=$handle;[DblSecurityDiagnosis001]::Mask=$mask
 $bytes=$null;$reason=$null
 try {$bytes=[DblSecurityDiagnosis001]::Descriptor($path)}catch{$reason=$_.Exception.Message}
 [pscustomobject]@{Bytes=$bytes;Summary=[pscustomobject]@{Path=$path;Method=if($handle){'CreateFileW -> GetSecurityInfo'}else{'GetNamedSecurityInfoW'};Stage=[DblSecurityDiagnosis001]::LastStage;SecurityInformation=('0x{0:X8}' -f $mask);DesiredAccess=('0x{0:X8}' -f [DblSecurityDiagnosis001]::RequiredAccess($mask));Win32=[DblSecurityDiagnosis001]::LastError;Reason=$reason;DescriptorReturned=($null -ne $bytes)}}
}
function Assert-FullMatchesParts([byte[]]$bytes,$basic,$audit) {
 if($null -ne $basic.Summary.Reason -or $null -ne $audit.Summary.Reason){throw 'STOP: independent owner/group/DACL or SACL comparison unavailable'}
 $full=[Security.AccessControl.RawSecurityDescriptor]::new($bytes,0)
 $partBasic=[Security.AccessControl.RawSecurityDescriptor]::new([byte[]]$basic.Bytes,0)
 $partAudit=[Security.AccessControl.RawSecurityDescriptor]::new([byte[]]$audit.Bytes,0)
 $ogd=[Security.AccessControl.AccessControlSections]::Owner -bor [Security.AccessControl.AccessControlSections]::Group -bor [Security.AccessControl.AccessControlSections]::Access
 if($full.GetSddlForm($ogd) -cne $partBasic.GetSddlForm($ogd) -or $full.GetSddlForm([Security.AccessControl.AccessControlSections]::Audit) -cne $partAudit.GetSddlForm([Security.AccessControl.AccessControlSections]::Audit)){throw 'STOP: full descriptor differs from independent requested parts'}
}
$securityHash=[Security.Cryptography.SHA256]::Create()
try {
 if(-not $diagBefore.Elevated -or -not $diagBefore.SecurityPresent -or $diagBefore.ThreadTokenPresent){throw 'STOP: missing elevated primary token/privilege or thread impersonation'}
 if($diagBefore.BackupEnabled -or $diagBefore.RestoreEnabled){throw 'STOP: fresh session required; unrelated backup/restore privilege already enabled'}
 if($diagRequired -ne 0x01020000){throw 'STOP: runtime BACKUP query mask differs from documented rights'}
 $securityPrevious=[DblSecurityDiagnosis001]::EnableSecurity()
 $diagDuring=[DblSecurityDiagnosis001]::State()
 if(-not $diagDuring.SecurityEnabled -or $diagDuring.ThreadTokenPresent -or $diagDuring.BackupEnabled -or $diagDuring.RestoreEnabled){throw 'STOP: observed privilege state unsuitable'}
 foreach($securityPath in @($securityPaths.Keys|Sort-Object)){
  $diagPath=$securityPath;$diagStage='GetItemAndMetadata'
  $securityItem=Get-Item -LiteralPath $securityPath -Force
  $securityDirectory=[bool]$securityPaths[$securityPath]
  if($securityItem.PSIsContainer -ne $securityDirectory){throw "STOP: file/directory identity mismatch: $securityPath"}
  $securityUnsupported=[IO.FileAttributes]::ReparsePoint -bor [IO.FileAttributes]::Encrypted -bor [IO.FileAttributes]::SparseFile -bor [IO.FileAttributes]::Compressed
  if($securityItem.Attributes -band $securityUnsupported){throw "STOP: unsupported source/parent attributes: $securityPath"}
  $securityInformation=[DblSecurityDiagnosis001]::Metadata($securityPath)
  if(-not $securityDirectory -and $securityInformation.NumberOfLinks -ne 1){throw "STOP: file hardlink count is not one: $securityPath"}
  $diagStage='FullDescriptorRead'
  $diagProbe=Read-DiagnosticProbe $securityPath 0x10000 ($diagReader -eq 'CorrectedHandleBackup')
  if($null -ne $diagProbe.Summary.Reason -and $diagReader -eq 'OriginalNamedBackup'){
   $diagFirstFailure=$diagProbe.Summary
   $diagFirstFailure|Add-Member -NotePropertyName TokenAtFailure -NotePropertyValue ([DblSecurityDiagnosis001]::State())
   # Three comparisons ONCE, on the same first failing object. No partial fallback qualifies.
   $diagBasic=Read-DiagnosticProbe $securityPath 7 $false
   $diagAudit=Read-DiagnosticProbe $securityPath 8 $false
   $diagHandle=Read-DiagnosticProbe $securityPath 0x10000 $true
   $diagComparisons=@($diagBasic.Summary,$diagAudit.Summary,$diagHandle.Summary)
   if($null -ne $diagHandle.Summary.Reason){throw 'STOP: full handle-based BACKUP read failed; no weaker fallback'}
   Assert-FullMatchesParts ([byte[]]$diagHandle.Bytes) $diagBasic $diagAudit
   $diagReader='CorrectedHandleBackup';$diagProbe=$diagHandle
  }
  if($null -ne $diagProbe.Summary.Reason){
   $diagComparisons+=$diagProbe.Summary
   throw 'STOP: corrected full descriptor read failed on scope object'
  }
  $securityRaw=[byte[]]$diagProbe.Bytes
  $diagStage='DescriptorPreservationValidation'
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
 if($null -ne $securityPrevious){try{[DblSecurityDiagnosis001]::RestoreSecurity($securityPrevious)}catch{$securityRestoreFailure=$_.Exception.Message}}
 try {
  $diagAfter=[DblSecurityDiagnosis001]::State()
  if($diagAfter.SecurityPresent -ne $diagBefore.SecurityPresent -or $diagAfter.SecurityEnabled -ne $diagBefore.SecurityEnabled -or (($diagAfter.SecurityAttributes -band 3) -ne ($diagBefore.SecurityAttributes -band 3)) -or $diagAfter.BackupEnabled -ne $diagBefore.BackupEnabled -or $diagAfter.RestoreEnabled -ne $diagBefore.RestoreEnabled){throw 'Process privilege state restoration comparison failed'}
 }catch{$securityRestoreFailure=$_.Exception.Message}
}

$diagOk=($null -eq $securityFailure -and $null -eq $securityRestoreFailure)
[pscustomobject]@{
 Decision=if($diagOk){'SECURITY_METADATA_PREFLIGHT_PASSED'}else{'SECURITY_METADATA_PREFLIGHT_BLOCKED'}
 Task='SECURITY_METADATA_ACCESS_DIAGNOSIS_001';ObservedAt=(Get-Date -Format o)
 Host=$env:COMPUTERNAME;Identity=$securityIdentity.Name;IdentitySid=$securityIdentity.User.Value
 ProcessId=$PID;ProcessPath=(Get-Process -Id $PID).Path;PowerShellVersion=$PSVersionTable.PSVersion.ToString()
 ProcessTokenBefore=$diagBefore;ProcessTokenDuring=$diagDuring;ProcessTokenAfter=$diagAfter
 PrivilegeRestoredAndObserved=($null -eq $securityRestoreFailure)
 OriginalFirstFailure=$diagFirstFailure;BoundedComparisons=$diagComparisons;ReaderUsed=$diagReader
 FailurePath=if($diagOk){$null}else{$diagPath};FailureStage=if($diagOk){$null}else{$diagStage}
 Reason=$securityFailure;PrivilegeRestoreFailure=$securityRestoreFailure
 BackupQueryRequiredAccess=('0x{0:X8}' -f $diagRequired)
 PersistentCount=$securityPreflight.PersistentCount;SecurityRecordCount=$securityResults.Count;Records=$securityResults
 ServiceStatus=(Get-Service -Name 'MSSQL$YSEDU').Status.ToString()
 SourceContentsRead=$false;SourceSecurityChanged=$false;SqlStopped=$false;EWrites=$false;RealCaptureStarted=$false
 RawSecurityDescriptorsPublished=$false
 Pending=@('Exact settings/evidence allowlist','Private NTFS root ACL','ERP closure','Final pre-stop refresh','Real capture excluded from this task')
}|ConvertTo-Json -Depth 9
# STOP after diagnostic JSON, even if the security gate passes. No real recovery operation.
