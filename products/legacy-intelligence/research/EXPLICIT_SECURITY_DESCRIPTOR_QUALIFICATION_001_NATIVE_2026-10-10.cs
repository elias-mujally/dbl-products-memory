using System;
using System.Runtime.InteropServices;
using Microsoft.Win32.SafeHandles;
public static class DblExplicitSecurity001 {
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
 public static Info Metadata(string path) {
  // Metadata-only handle: desired access zero, share read/write/delete; NEVER reads file contents.
  using(SafeFileHandle file=CreateFileW(path,0,7,IntPtr.Zero,3,0x02200000,IntPtr.Zero)) {
   if(file.IsInvalid)throw new InvalidOperationException("Metadata handle open failed; Win32="+Marshal.GetLastWin32Error());
   Info result;if(!GetFileInformationByHandle(file,out result))throw new InvalidOperationException("Metadata query failed; Win32="+Marshal.GetLastWin32Error());
   return result;
  }
 }

 public static Tp EnableFixtureRestore() {
  IntPtr token;if(!OpenProcessToken(GetCurrentProcess(),0x28,out token))throw new InvalidOperationException("Process token open failed");
  try {Luid id;if(!LookupPrivilegeValue(null,"SeRestorePrivilege",out id))throw new InvalidOperationException("Security privilege lookup failed");
   Tp wanted=new Tp{Count=1,Id=id,Attributes=2},previous;int returned;
   if(!AdjustTokenPrivileges(token,false,ref wanted,Marshal.SizeOf(typeof(Tp)),out previous,out returned)||Marshal.GetLastWin32Error()!=0)throw new InvalidOperationException("Security privilege not assigned");
   return previous;
  }finally{CloseHandle(token);}
 }


 // Public result never serializes Descriptor: caller emits only Summary.
 public sealed class Part {
  public byte Revision,Rm;
  public ushort Control;
  public byte[] Owner,Group,Dacl,Sacl;
 }
 public sealed class Component {
  public uint Mask;public string Name,State;public int AceCount;
 }
 public sealed class Qualified {
  public byte[] Descriptor;
  public string SHA256,DaclState,SaclState;
  public ushort Control;
  public int[] DaclTypes,SaclTypes;
  public Component[] Components;
 }
 [DllImport("advapi32.dll",CharSet=CharSet.Unicode,SetLastError=true,ExactSpelling=true)]
 static extern bool GetFileSecurityW(string path,uint mask,IntPtr data,uint size,out uint needed);
 [DllImport("advapi32.dll",CharSet=CharSet.Unicode,SetLastError=true,ExactSpelling=true)]
 static extern bool SetFileSecurityW(string path,uint mask,byte[] data);
 [DllImport("advapi32.dll",CharSet=CharSet.Unicode,SetLastError=true,ExactSpelling=true)]
 static extern bool ConvertStringSecurityDescriptorToSecurityDescriptorW(string sddl,uint revision,out IntPtr data,out uint size);
 [DllImport("advapi32.dll",SetLastError=true)] static extern bool IsValidSecurityDescriptor(byte[] data);
 public static string Stage="",CurrentPath="";
 public const string FixtureRoot=@"C:\Users\user\Documents\Codex\ESDQ-20261010-a42c190d";
 public static bool FixtureWritesSealed=false;
 static void Fail(string reason){throw new InvalidOperationException("STOP: "+reason);}
 static void Bounds(byte[] b,int o,int n){if(o<0||n<0||o>b.Length-n)Fail("descriptor bounds");}
 static byte[] Slice(byte[] b,int o,int n){Bounds(b,o,n);byte[] x=new byte[n];Array.Copy(b,o,x,0,n);return x;}
 static ushort U16(byte[] b,int o){Bounds(b,o,2);return BitConverter.ToUInt16(b,o);}
 static uint U32(byte[] b,int o){Bounds(b,o,4);return BitConverter.ToUInt32(b,o);}
 static byte[] SidAt(byte[] b,uint offset) {
  if(offset==0)return null;if(offset>Int32.MaxValue)Fail("SID offset");
  int o=(int)offset;Bounds(b,o,8);if(o<20||(o&3)!=0||b[o]!=1||b[o+1]>15)Fail("SID header");
  return Slice(b,o,8+4*b[o+1]);
 }
 static byte[] AclAt(byte[] b,uint offset) {
  if(offset==0)return null;if(offset>Int32.MaxValue)Fail("ACL offset");
  int o=(int)offset;Bounds(b,o,8);if(o<20||(o&3)!=0)Fail("ACL alignment");
  byte[] acl=Slice(b,o,U16(b,o+2));return CompactAcl(acl);
 }
 static byte[][] Aces(byte[] acl) {
  if(acl==null)return new byte[0][];
  Bounds(acl,0,8);if((acl[0]!=2&&acl[0]!=4)||acl[1]!=0||U16(acl,6)!=0||U16(acl,2)!=acl.Length)Fail("unqualified ACL header");
  int count=U16(acl,4);if(count>512)Fail("ACE count bound");
  byte[][] rows=new byte[count][];int o=8;
  for(int i=0;i<count;i++){Bounds(acl,o,4);int n=U16(acl,o+2);if(n<4||(n&3)!=0)Fail("ACE size");rows[i]=Slice(acl,o,n);o+=n;}
  for(int i=o;i<acl.Length;i++)if(acl[i]!=0)Fail("nonzero unparsed ACL storage");
  return rows;
 }
 static byte[] CompactAcl(byte[] acl) {
  if(acl==null)return null;byte[][] rows=Aces(acl);int n=8;foreach(byte[] row in rows)n+=row.Length;
  byte[] compact=Slice(acl,0,n);Array.Copy(BitConverter.GetBytes((ushort)n),0,compact,2,2);return compact;
 }
 public static Part Parse(byte[] b) {
  Bounds(b,0,20);if(b.Length>262144||b[0]!=1)Fail("descriptor revision/size");
  Part p=new Part{Revision=b[0],Rm=b[1],Control=U16(b,2)};
  if((p.Control&0x8000)==0)Fail("non-self-relative descriptor");
  if((p.Control&0x4000)==0&&p.Rm!=0)Fail("reserved resource-manager byte");
  p.Owner=SidAt(b,U32(b,4));p.Group=SidAt(b,U32(b,8));p.Sacl=AclAt(b,U32(b,12));p.Dacl=AclAt(b,U32(b,16));
  if((p.Control&4)==0&&p.Dacl!=null||(p.Control&16)==0&&p.Sacl!=null)Fail("ACL presence/offset contradiction");
  return p;
 }
 public static byte[] Encode(Part p) {
  byte[][] pieces={p.Owner,p.Group,p.Sacl,p.Dacl};int size=20;foreach(byte[] a in pieces)if(a!=null)size+=a.Length;
  byte[] b=new byte[size];b[0]=p.Revision;b[1]=p.Rm;Array.Copy(BitConverter.GetBytes(p.Control),0,b,2,2);int cursor=20;
  for(int i=0;i<4;i++)if(pieces[i]!=null){Array.Copy(BitConverter.GetBytes((uint)cursor),0,b,4+i*4,4);Array.Copy(pieces[i],0,b,cursor,pieces[i].Length);cursor+=pieces[i].Length;}
  return b;
 }
 static bool Same(byte[] a,byte[] b) {
  if(a==null||b==null)return a==null&&b==null;if(a.Length!=b.Length)return false;
  for(int i=0;i<a.Length;i++)if(a[i]!=b[i])return false;return true;
 }
 public static bool Equivalent(byte[] a,byte[] b){return Same(Encode(Parse(a)),Encode(Parse(b)));}
 public static string Hash(byte[] b){using(var h=System.Security.Cryptography.SHA256.Create()){return BitConverter.ToString(h.ComputeHash(b)).Replace("-","");}}
 static byte[] CopyDescriptor(IntPtr sd) {
  ushort control;uint revision;if(sd==IntPtr.Zero||!GetSecurityDescriptorControl(sd,out control,out revision)||(control&0x8000)==0)Fail("native descriptor self-relative/control");
  uint n=GetSecurityDescriptorLength(sd);if(n<20||n>262144)Fail("native descriptor size");
  byte[] b=new byte[n];Marshal.Copy(sd,b,0,b.Length);if(!IsValidSecurityDescriptor(b))Fail("invalid native descriptor");
  Parse(b);return b;
 }
 static byte[] Query(SafeFileHandle h,uint mask) {
  Stage="GetSecurityInfo mask=0x"+mask.ToString("X");IntPtr o,g,d,s,sd=IntPtr.Zero;
  try {uint e=GetSecurityInfo(h,1,mask,out o,out g,out d,out s,out sd);if(e!=0)Fail("security query failed Win32="+e);return CopyDescriptor(sd);}
  finally{if(sd!=IntPtr.Zero)LocalFree(sd);}
 }
 static byte[] Independent(string path) {
  Stage="GetFileSecurityW composite 0x1FF";uint needed;
  bool ok=GetFileSecurityW(path,0x1ff,IntPtr.Zero,0,out needed);int e=Marshal.GetLastWin32Error();
  if(ok||e!=122||needed<20||needed>262144)Fail("independent size query Win32="+e);
  IntPtr b=Marshal.AllocHGlobal((int)needed);
  try {if(!GetFileSecurityW(path,0x1ff,b,needed,out needed))Fail("independent descriptor query Win32="+Marshal.GetLastWin32Error());return CopyDescriptor(b);}
  finally{Marshal.FreeHGlobal(b);}
 }
 static uint Role(byte type) {
  if(type==17)return 16;if(type==18)return 32;if(type==19)return 64;if(type==20)return 128;if(type==21)return 256;
  if(type==2||type==3||type==7||type==8||type==13||type==14||type==15||type==16)return 8;
  Fail("unrecognized SACL ACE type="+type);return 0;
 }
 static byte[][] Projection(byte[] acl,uint role) {
  var rows=new System.Collections.Generic.List<byte[]>();foreach(byte[] ace in Aces(acl))if(Role(ace[0])==role)rows.Add(ace);return rows.ToArray();
 }
 static bool RowsSame(byte[][] a,byte[][] b){if(a.Length!=b.Length)return false;for(int i=0;i<a.Length;i++)if(!Same(a[i],b[i]))return false;return true;}
 static string AclState(byte[] acl,ushort control,int present){return (control&present)==0?"ABSENT_READ_OK":acl==null?"NULL_PRESENT_READ_OK":Aces(acl).Length==0?"EMPTY_PRESENT_READ_OK":"PRESENT_READ_OK";}
 static int[] Types(byte[] acl){var rows=Aces(acl);int[] t=new int[rows.Length];for(int i=0;i<rows.Length;i++)t[i]=rows[i][0];return t;}
 static void Resolve(byte[] sid,bool integrity) {
  if(sid==null)Fail("unqualified missing owner/group/SID");var id=new System.Security.Principal.SecurityIdentifier(sid,0);
  if(integrity){if(!id.Value.StartsWith("S-1-16-")||sid[1]!=1)Fail("invalid integrity SID");}
  else id.Translate(typeof(System.Security.Principal.NTAccount));
 }
 public static void Supported(byte[] b) {
  Part p=Parse(b);
  if((p.Control&0x40c0)!=0)Fail("RM/untrusted/server control replay not qualified");
  Resolve(p.Owner,false);Resolve(p.Group,false);
  foreach(byte[] ace in Aces(p.Dacl)){
   if(ace[0]!=0&&ace[0]!=1)Fail("unsupported DACL ACE type="+ace[0]);
   if((ace[1]&~0x1f)!=0)Fail("unqualified DACL ACE flags");
   Bounds(ace,8,8);if(ace[8]!=1||ace[9]>15||ace.Length!=16+4*ace[9])Fail("DACL ACE SID/trailing payload");
   Resolve(Slice(ace,8,ace.Length-8),false);
  }
  foreach(byte[] ace in Aces(p.Sacl)){
   if(ace[0]!=2&&ace[0]!=17)Fail("unsupported SACL ACE type="+ace[0]);
   if((ace[1]&(ace[0]==2?~0xdf:~0x1f))!=0)Fail("unqualified SACL ACE flags");
   Bounds(ace,8,8);if(ace[8]!=1||ace[9]>15||ace.Length!=16+4*ace[9])Fail("SACL ACE SID/trailing payload");
   if(ace[0]==17&&(U32(ace,4)&~7u)!=0)Fail("unknown integrity policy bits");
   Resolve(Slice(ace,8,ace.Length-8),ace[0]==17);
  }
 }
 public static Qualified Read(string path) {
  CurrentPath=path;Stage="OpenSecurityHandle";
  using(SafeFileHandle h=CreateFileW(path,0x01020000,7,IntPtr.Zero,3,0x02200000,IntPtr.Zero)){
   if(h.IsInvalid)Fail("security handle open Win32="+Marshal.GetLastWin32Error());
   Info idBefore;if(!GetFileInformationByHandle(h,out idBefore))Fail("metadata handle identity");
   byte[] reference=Query(h,0x1ff);byte[] independent=Independent(path);
   if(!Equivalent(reference,independent))Fail("independent full explicit reference mismatch");
   Part owner=Parse(Query(h,1)),group=Parse(Query(h,2)),dacl=Parse(Query(h,4)),sacl=Parse(Query(h,0x1f8));
   // Shared/global control state must agree; component flags come from their own queries.
   ushort global=(ushort)(owner.Control&0xc000);
   if((group.Control&0xc000)!=global||(dacl.Control&0xc000)!=global||(sacl.Control&0xc000)!=global||owner.Rm!=group.Rm||owner.Rm!=dacl.Rm||owner.Rm!=sacl.Rm)Fail("global control/RM query disagreement");
   Part assembled=new Part{Revision=owner.Revision,Rm=owner.Rm,Control=(ushort)(global|(owner.Control&1)|(group.Control&2)|(dacl.Control&0x15cc)|(sacl.Control&0x2a30)),Owner=owner.Owner,Group=group.Group,Dacl=dacl.Dacl,Sacl=sacl.Sacl};
   byte[] rebuilt=Encode(assembled);
   if(!IsValidSecurityDescriptor(rebuilt)||!Equivalent(rebuilt,reference))Fail("explicit reconstruction/control/ACE-order mismatch");
   var components=new System.Collections.Generic.List<Component>();
   components.Add(new Component{Mask=1,Name="Owner",State=assembled.Owner==null?"ABSENT_READ_OK":"PRESENT_READ_OK"});
   components.Add(new Component{Mask=2,Name="Group",State=assembled.Group==null?"ABSENT_READ_OK":"PRESENT_READ_OK"});
   components.Add(new Component{Mask=4,Name="DACL",State=AclState(assembled.Dacl,assembled.Control,4),AceCount=Aces(assembled.Dacl).Length});
   components.Add(new Component{Mask=0x1f8,Name="CompleteSACLExplicit",State=AclState(assembled.Sacl,assembled.Control,16),AceCount=Aces(assembled.Sacl).Length});
   uint[] masks={8,16,32,64,128,256};string[] names={"AuditSACL","IntegrityLabel","ResourceAttributes","ScopePolicy","ProcessTrustLabel","AccessFilter"};
   for(int i=0;i<masks.Length;i++){
    Part p=Parse(Query(h,masks[i]));byte[][] expected=Projection(assembled.Sacl,masks[i]),actual=Aces(p.Sacl);
    // Some providers return the complete SACL for flag8. Never rearrange or concatenate either case.
    bool fullAudit=masks[i]==8&&RowsSame(actual,Aces(assembled.Sacl));
    if(!fullAudit&&!RowsSame(actual,expected))Fail("component projection/order mismatch mask=0x"+masks[i].ToString("X"));
    components.Add(new Component{Mask=masks[i],Name=names[i],State=expected.Length==0?"ABSENT_COMPONENT_READ_OK":"PRESENT_COMPONENT_READ_OK",AceCount=expected.Length});
   }
   Supported(rebuilt);
   byte[] again=Query(h,0x1ff),independentAgain=Independent(path);
   Info idAfter;if(!GetFileInformationByHandle(h,out idAfter))Fail("metadata recheck");
   Info namedId=Metadata(path);
   if(idBefore.VolumeSerial!=idAfter.VolumeSerial||idBefore.IndexHigh!=idAfter.IndexHigh||idBefore.IndexLow!=idAfter.IndexLow||idBefore.VolumeSerial!=namedId.VolumeSerial||idBefore.IndexHigh!=namedId.IndexHigh||idBefore.IndexLow!=namedId.IndexLow)Fail("object identity changed");
   if(!Equivalent(rebuilt,again)||!Equivalent(rebuilt,independentAgain))Fail("security descriptor changed during read");
   Stage="QUALIFIED";
   return new Qualified{Descriptor=rebuilt,SHA256=Hash(rebuilt),Control=assembled.Control,DaclState=AclState(assembled.Dacl,assembled.Control,4),SaclState=AclState(assembled.Sacl,assembled.Control,16),DaclTypes=Types(assembled.Dacl),SaclTypes=Types(assembled.Sacl),Components=components.ToArray()};
  }
 }
 public static byte[] FromSddl(string sddl) {
  IntPtr b=IntPtr.Zero;uint size;
  try {if(!ConvertStringSecurityDescriptorToSecurityDescriptorW(sddl,1,out b,out size))Fail("fixture SDDL Win32="+Marshal.GetLastWin32Error());return CopyDescriptor(b);}
  finally{if(b!=IntPtr.Zero)LocalFree(b);}
 }
 public static void FixtureApply(string path,byte[] descriptor) {
  Stage="FIXTURE_ONLY_REPLAY";
  string full=System.IO.Path.GetFullPath(path);
  if(FixtureWritesSealed||!(full.Equals(FixtureRoot,StringComparison.OrdinalIgnoreCase)||full.StartsWith(FixtureRoot+@"\",StringComparison.OrdinalIgnoreCase)))Fail("fixture-only write guard");
  var item=System.IO.File.GetAttributes(full);if((item&System.IO.FileAttributes.ReparsePoint)!=0)Fail("fixture link");
  var parent=new System.IO.DirectoryInfo(System.IO.Path.GetDirectoryName(full));
  while(parent!=null&&parent.FullName.StartsWith(FixtureRoot,StringComparison.OrdinalIgnoreCase)){
   if((parent.Attributes&System.IO.FileAttributes.ReparsePoint)!=0)Fail("fixture parent link");parent=parent.Parent;
  }
  Supported(descriptor);Part p=Parse(descriptor);
  uint mask=0x1f|((p.Control&0x1000)!=0?0x80000000u:0x20000000u)|((p.Control&0x2000)!=0?0x40000000u:0x10000000u);
  if(!SetFileSecurityW(full,mask,descriptor))Fail("fixture replay Win32="+Marshal.GetLastWin32Error());
 }
 public static void SealFixtureWrites(){FixtureWritesSealed=true;}
}
