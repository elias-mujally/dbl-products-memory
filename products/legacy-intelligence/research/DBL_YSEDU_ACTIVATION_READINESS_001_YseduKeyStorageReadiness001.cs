using System;
using System.Runtime.InteropServices;
using System.Text;
// Existing provider context and storage locator only. No key handle, signing, export or repair API.
public static class DblYseduKeyStorageReadiness001 {
 [StructLayout(LayoutKind.Sequential)] struct Info {public IntPtr Container,Provider;public uint Type,Flags,Count;public IntPtr Params;public uint KeySpec;}
 [DllImport("crypt32.dll",SetLastError=true)] static extern bool CertGetCertificateContextProperty(IntPtr c,uint p,IntPtr d,ref uint n);
 [DllImport("advapi32.dll",CharSet=CharSet.Unicode,SetLastError=true,ExactSpelling=true)] static extern bool CryptAcquireContextW(out IntPtr p,string container,string provider,uint type,uint flags);
 [DllImport("advapi32.dll",SetLastError=true)] static extern bool CryptGetProvParam(IntPtr p,uint param,[Out] byte[] data,ref uint n,uint flags);
 [DllImport("advapi32.dll",SetLastError=true)] static extern bool CryptReleaseContext(IntPtr p,uint flags);
 public sealed class Result {public string Check="AssociationMetadata",UniqueName;public int? Win32;public bool ContextOpened,ContextReleased;}
 static string ReadString(IntPtr p,IntPtr start,uint n){long offset=p.ToInt64()-start.ToInt64();if(p==IntPtr.Zero||offset<0||offset>n-2||(offset&1)!=0)throw new InvalidOperationException();for(int i=0;i<4096&&offset+2L*i+2<=n;i++)if(Marshal.ReadInt16(p,2*i)==0)return Marshal.PtrToStringUni(p,i);throw new InvalidOperationException();}
 public static void Read(IntPtr certificate,Result r){
  uint n=0;IntPtr buffer=IntPtr.Zero,prov=IntPtr.Zero;
  try {
   if(!CertGetCertificateContextProperty(certificate,2,IntPtr.Zero,ref n)){r.Win32=Marshal.GetLastWin32Error();throw new InvalidOperationException();}
   if(n<Marshal.SizeOf<Info>()||n>65536)throw new InvalidOperationException();
   buffer=Marshal.AllocHGlobal((int)n);uint got=n;
   if(!CertGetCertificateContextProperty(certificate,2,buffer,ref got)){r.Win32=Marshal.GetLastWin32Error();throw new InvalidOperationException();}
   if(got>n||got<Marshal.SizeOf<Info>())throw new InvalidOperationException();
   var info=Marshal.PtrToStructure<Info>(buffer);string container=ReadString(info.Container,buffer,got),provider=ReadString(info.Provider,buffer,got);
   if(provider!="Microsoft Enhanced RSA and AES Cryptographic Provider"||info.Type!=24||info.Flags!=32||info.KeySpec!=1||info.Count!=0||container.Length==0)throw new InvalidOperationException();
   r.Check="OpenExistingProviderContextMachineSilent";
   // Only MACHINE_KEYSET|SILENT; no NEWKEYSET, DELETEKEYSET, VERIFYCONTEXT or cert association healing.
   if(!CryptAcquireContextW(out prov,container,provider,24,0x60)){r.Win32=Marshal.GetLastWin32Error();throw new InvalidOperationException();}
   r.ContextOpened=true;r.Check="ReadUniqueStorageLocator";byte[] name=new byte[1024];uint size=1024;
   if(!CryptGetProvParam(prov,36,name,ref size,0)){r.Win32=Marshal.GetLastWin32Error();throw new InvalidOperationException();}
   if(size<2||size>1024||name[size-1]!=0)throw new InvalidOperationException();
   for(int i=0;i<size-1;i++)if(!((name[i]>='0'&&name[i]<='9')||(name[i]>='a'&&name[i]<='z')||(name[i]>='A'&&name[i]<='Z')||name[i]=='_'||name[i]=='-'))throw new InvalidOperationException();
   r.UniqueName=Encoding.ASCII.GetString(name,0,(int)size-1);r.Check="ExistingStorageLocatorRead";
  }finally {
   if(buffer!=IntPtr.Zero)Marshal.FreeHGlobal(buffer);
   if(prov!=IntPtr.Zero){r.ContextReleased=CryptReleaseContext(prov,0);if(!r.ContextReleased){r.Check="ProviderContextRelease";r.Win32=Marshal.GetLastWin32Error();throw new InvalidOperationException();}}
  }
 }
}
