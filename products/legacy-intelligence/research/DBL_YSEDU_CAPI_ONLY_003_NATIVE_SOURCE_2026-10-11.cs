using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Security.Cryptography;
using System.Text;

public static class DblYseduCapiOnly003 {
 public const uint AcquireFlags=0x0000004C; // COMPARE_KEY | NO_HEALING | SILENT; no cache/NCRYPT flags.
 const string ExpectedProvider="Microsoft Enhanced RSA and AES Cryptographic Provider";
 public sealed class AssociationPolicy {public string ProviderName;public uint ProviderType,Flags,KeySpec,ParameterCount;public bool ContainerNamePresent;}
 public sealed class Result {
  public bool Passed,AcquisitionAttempted,Acquired,ChallengePassed,AssociationUnchanged;
  public string Check="NativeInput",ProviderName,FailureKind;
  public int? Win32;
  public uint? ProviderType,KeySpec,MachineFlags,Algorithm,KeyBits,Permissions;
  public bool? CallerFreeProvider,ExportAllowed,ArchiveAllowed;
  public List<string> CleanupFailures=new List<string>();
  public AssociationPolicy AssociationBefore,AssociationAfter;
 }
 sealed class Stop:Exception {}
 [StructLayout(LayoutKind.Sequential)] struct Info {public IntPtr Container,Provider;public uint Type,Flags,Count;public IntPtr Params;public uint KeySpec;}
 [DllImport("crypt32.dll",SetLastError=true)] static extern bool CertGetCertificateContextProperty(IntPtr c,uint p,IntPtr d,ref uint n);
 [DllImport("crypt32.dll",SetLastError=true)] static extern bool CryptAcquireCertificatePrivateKey(IntPtr c,uint f,IntPtr reserved,out IntPtr p,out uint spec,[MarshalAs(UnmanagedType.Bool)] out bool free);
 [DllImport("advapi32.dll",SetLastError=true)] static extern bool CryptGetProvParam(IntPtr p,uint param,[Out] byte[] data,ref uint n,uint flags);
 [DllImport("advapi32.dll",SetLastError=true)] static extern bool CryptGetUserKey(IntPtr p,uint spec,out IntPtr key);
 [DllImport("advapi32.dll",SetLastError=true)] static extern bool CryptGetKeyParam(IntPtr key,uint param,[Out] byte[] data,ref uint n,uint flags);
 [DllImport("advapi32.dll",SetLastError=true)] static extern bool CryptCreateHash(IntPtr p,uint alg,IntPtr key,uint flags,out IntPtr hash);
 [DllImport("advapi32.dll",SetLastError=true)] static extern bool CryptHashData(IntPtr hash,byte[] data,uint n,uint flags);
 [DllImport("advapi32.dll",CharSet=CharSet.Unicode,SetLastError=true,ExactSpelling=true)] static extern bool CryptSignHashW(IntPtr hash,uint spec,IntPtr description,uint flags,[Out] byte[] sig,ref uint n);
 [DllImport("advapi32.dll",SetLastError=true)] static extern bool CryptDestroyHash(IntPtr hash);
 [DllImport("advapi32.dll",SetLastError=true)] static extern bool CryptDestroyKey(IntPtr key);
 [DllImport("advapi32.dll",SetLastError=true)] static extern bool CryptReleaseContext(IntPtr p,uint flags);
 // Cleanup of an unexpected handle only; never used for CNG acquisition/fallback.
 [DllImport("ncrypt.dll")] static extern int NCryptFreeObject(IntPtr h);
 static void Need(bool value,Result r,string check){r.Check=check;if(!value){r.FailureKind="VALIDATION_OR_POLICY_MISMATCH";throw new Stop();}}
 static void Native(bool value,Result r,string check){r.Check=check;if(!value){r.Win32=Marshal.GetLastWin32Error();r.FailureKind="WIN32_API_FAILURE";throw new Stop();}}
 public static uint DecodeDword(byte[] data,uint length){if(data==null||data.Length!=4||length!=4)throw new InvalidOperationException();return (uint)(data[0]|data[1]<<8|data[2]<<16|data[3]<<24);}
 public static bool NoExportPermission(uint permissions){return (permissions&0x00000104)==0;}
 public static bool ReleaseProviderRequired(IntPtr provider,bool callerFree){return provider!=IntPtr.Zero&&callerFree;}
 static uint ProvDword(IntPtr p,uint param,Result r,string check){r.Check=check;byte[] b=new byte[4];uint n=4;Native(CryptGetProvParam(p,param,b,ref n,0),r,check);return DecodeDword(b,n);}
 static uint KeyDword(IntPtr key,uint param,Result r,string check){r.Check=check;byte[] b=new byte[4];uint n=4;Native(CryptGetKeyParam(key,param,b,ref n,0),r,check);return DecodeDword(b,n);}
 public static string DecodeName(byte[] data,uint n){if(data==null||n<2||n>data.Length||data[n-1]!=0)throw new InvalidOperationException();for(int i=0;i<n-1;i++)if(data[i]==0||data[i]>127)throw new InvalidOperationException();return Encoding.ASCII.GetString(data,0,(int)n-1);}
 static string BoundedString(IntPtr value,IntPtr start,uint bytes){if(value==IntPtr.Zero)throw new InvalidOperationException();long offset=value.ToInt64()-start.ToInt64();if(offset<0||offset>bytes-2||(offset&1)!=0)throw new InvalidOperationException();for(int n=0;n<4096&&offset+2L*n+2<=bytes;n++)if(Marshal.ReadInt16(value,n*2)==0)return Marshal.PtrToStringUni(value,n);throw new InvalidOperationException();}
 static string Association(IntPtr c,Result r,string check){
  r.Check=check;uint n=0;Native(CertGetCertificateContextProperty(c,2,IntPtr.Zero,ref n),r,check);Need(n>=Marshal.SizeOf<Info>()&&n<=65536,r,"AssociationLength");
  IntPtr buffer=Marshal.AllocHGlobal((int)n);
  try{uint got=n;Native(CertGetCertificateContextProperty(c,2,buffer,ref got),r,check);Need(got<=n&&got>=Marshal.SizeOf<Info>(),r,"AssociationReturnedLength");var info=Marshal.PtrToStructure<Info>(buffer);
   string provider=BoundedString(info.Provider,buffer,got),container=BoundedString(info.Container,buffer,got);
   var policy=new AssociationPolicy{ProviderName=provider==ExpectedProvider?provider:"OTHER_UNQUALIFIED",ProviderType=info.Type,KeySpec=info.KeySpec,Flags=info.Flags,ParameterCount=info.Count,ContainerNamePresent=container.Length>0};
   if(check=="AssociationBeforeAcquire")r.AssociationBefore=policy;else r.AssociationAfter=policy;
   Need(provider==ExpectedProvider,r,"StoredAssociationProviderName");Need(info.Type==24,r,"StoredAssociationProviderType24");Need(info.KeySpec==1,r,"StoredAssociationKeySpec1");Need(info.Flags==32,r,"StoredAssociationMachineFlags32");Need(info.Count==0,r,"StoredAssociationNoProviderParameters");Need(container.Length>0,r,"StoredAssociationContainerPresent");
   return Convert.ToHexString(SHA256.HashData(Encoding.UTF8.GetBytes(provider+"\0"+container+"\0"+info.Type+"|"+info.Flags+"|"+info.KeySpec+"|"+info.Count)));
  }finally{Marshal.FreeHGlobal(buffer);}
 }
 public static void Cleanup(Result r,string code,Func<bool> action){try{if(!action())r.CleanupFailures.Add(code);}catch{r.CleanupFailures.Add(code);}}
 public static Result Run(IntPtr certificate,RSA csrPublic){
  var r=new Result();IntPtr prov=IntPtr.Zero,key=IntPtr.Zero,hash=IntPtr.Zero;uint spec=0;bool free=false;string before=null;
  try{
   Need(certificate!=IntPtr.Zero&&csrPublic!=null&&csrPublic.KeySize==2048,r,"NativeInputs");
   before=Association(certificate,r,"AssociationBeforeAcquire");
   r.Check="CryptAcquireCertificatePrivateKeyCapiOnly";r.AcquisitionAttempted=true;
   Native(CryptAcquireCertificatePrivateKey(certificate,AcquireFlags,IntPtr.Zero,out prov,out spec,out free),r,"CryptAcquireCertificatePrivateKeyCapiOnly");r.Acquired=true;r.KeySpec=spec;r.CallerFreeProvider=free;
   Need(prov!=IntPtr.Zero&&spec==1,r,"ReturnedCapiATKeyExchange");
   r.ProviderType=ProvDword(prov,16,r,"ReadActualProviderType");Need(r.ProviderType==24,r,"ActualCsp24");
   r.Check="ReadActualProviderName";byte[] name=new byte[512];uint nameLen=512;Native(CryptGetProvParam(prov,4,name,ref nameLen,0),r,"ReadActualProviderName");string actualName=DecodeName(name,nameLen);r.ProviderName=actualName==ExpectedProvider?actualName:"OTHER_UNQUALIFIED";Need(actualName==ExpectedProvider,r,"ActualProviderName");
   r.MachineFlags=ProvDword(prov,27,r,"ReadActualKeysetType");Need(r.MachineFlags==32,r,"ActualMachineKeyset");
   r.Check="CryptGetUserKeyATKeyExchange";Native(CryptGetUserKey(prov,1,out key),r,"CryptGetUserKeyATKeyExchange");Need(key!=IntPtr.Zero,r,"NonNullUserKey");
   r.Algorithm=KeyDword(key,7,r,"ReadActualKeyAlgorithm");Need(r.Algorithm==0x0000A400,r,"ActualRsaKeyExchangeAlgorithm");
   r.KeyBits=KeyDword(key,9,r,"ReadActualKeyBits");Need(r.KeyBits==2048,r,"ActualRSA2048");
   r.Permissions=KeyDword(key,6,r,"ReadActualKeyPermissions");r.ExportAllowed=(r.Permissions.Value&4)!=0;r.ArchiveAllowed=(r.Permissions.Value&256)!=0;Need(NoExportPermission(r.Permissions.Value),r,"NonexportablePolicyNoExportOrArchive");
   byte[] challenge=RandomNumberGenerator.GetBytes(32);
   r.Check="CryptCreateSha256Hash";Native(CryptCreateHash(prov,0x0000800C,IntPtr.Zero,0,out hash),r,"CryptCreateSha256Hash");Need(hash!=IntPtr.Zero,r,"NonNullHash");
   r.Check="CryptHashChallenge";Native(CryptHashData(hash,challenge,32,0),r,"CryptHashChallenge");
   // RSA2048 signature has a known bounded length: one signing call, no size-query signing call.
   byte[] signature=new byte[256];uint sigLen=256;r.Check="CryptSignHashSha256ATKeyExchange";Native(CryptSignHashW(hash,1,IntPtr.Zero,0,signature,ref sigLen),r,"CryptSignHashSha256ATKeyExchange");Need(sigLen==256,r,"SignatureLength256");
   Array.Reverse(signature);r.Check="VerifyChallengeAgainstPinnedCsr";Need(csrPublic.VerifyData(challenge,signature,HashAlgorithmName.SHA256,RSASignaturePadding.Pkcs1),r,"VerifyChallengeAgainstPinnedCsr");r.ChallengePassed=true;
   r.Passed=true;r.Check="NativeChecksPassed";
  }catch(Stop){r.Passed=false;}catch{r.Passed=false;r.FailureKind="INVALID_DATA_OR_MANAGED_FAILURE";/* Never publish raw provider/managed exceptions. */}
  finally{
   if(hash!=IntPtr.Zero)Cleanup(r,"CryptDestroyHash",()=>CryptDestroyHash(hash));
   if(key!=IntPtr.Zero)Cleanup(r,"CryptDestroyKeyHandle",()=>CryptDestroyKey(key)); // releases handle, not persisted key container.
   if(ReleaseProviderRequired(prov,free))Cleanup(r,spec==0xFFFFFFFF?"UnexpectedNCryptHandleRelease":"CryptReleaseContext",()=>spec==0xFFFFFFFF?NCryptFreeObject(prov)==0:CryptReleaseContext(prov,0));
  }
  // Keep certificate alive for borrowed provider handles; compare association without acquiring again.
  if(before!=null){string primary=r.Check,kind=r.FailureKind;int? error=r.Win32;bool wasPassed=r.Passed;try{r.AssociationUnchanged=Association(certificate,r,"AssociationAfterCleanup")==before;if(!r.AssociationUnchanged){if(wasPassed){r.Check="AssociationChanged";r.FailureKind="ASSOCIATION_CHANGED";}r.Passed=false;}else if(wasPassed)r.Check="NativeChecksAndAssociationPassed";}catch{r.CleanupFailures.Add("AssociationAfterCleanupRead");if(wasPassed){r.Check="AssociationAfterCleanupRead";r.FailureKind="POST_READ_FAILURE";}r.Passed=false;}finally{if(!wasPassed){r.Check=primary;r.FailureKind=kind;r.Win32=error;}}}
  if(r.CleanupFailures.Count>0){if(r.Passed){r.Check="NativeResourceCleanup";r.FailureKind="CLEANUP_FAILURE";}r.Passed=false;}
  return r;
 }
}
