using System;
using System.Collections.Generic;
using System.Formats.Asn1;
using System.Runtime.InteropServices;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;

// Public certificates only. No persistent store, enrollment, private-key, or trust override APIs.
public static class DblWindowsChainReadOnly001 {
 [StructLayout(LayoutKind.Sequential)] struct Trust { public uint Error, Info; }
 [StructLayout(LayoutKind.Sequential)] struct Usage { public uint Count; public IntPtr Oids; }
 [StructLayout(LayoutKind.Sequential)] struct Match { public uint Type; public Usage Usage; }
 [StructLayout(LayoutKind.Sequential)] struct ChainPara {
  public uint Size; public Match Usage, Issuance; public uint Timeout; public int Fresh;
  public uint FreshTime; public IntPtr Resync, Strong; public uint StrongFlags;
 }
 [StructLayout(LayoutKind.Sequential)] struct Chain {
  public uint Size; public Trust Trust; public uint Count; public IntPtr Chains;
  public uint LowerCount; public IntPtr Lower; public int Fresh; public uint FreshTime, Flags; public Guid Id;
 }
 [StructLayout(LayoutKind.Sequential)] struct Simple {
  public uint Size; public Trust Trust; public uint Count; public IntPtr Elements, List; public int Fresh; public uint FreshTime;
 }
 [StructLayout(LayoutKind.Sequential)] struct Element {
  public uint Size; public IntPtr Cert; public Trust Trust; public IntPtr Revocation, Issuance, Application, ErrorInfo;
 }
 [StructLayout(LayoutKind.Sequential)] struct Cert { public uint Encoding; public IntPtr Bytes; public uint Length; public IntPtr Info, Store; }
 [StructLayout(LayoutKind.Sequential)] struct PolicyPara { public uint Size, Flags; public IntPtr Extra; }
 [StructLayout(LayoutKind.Sequential)] struct PolicyStatus { public uint Size, Error; public int ChainIndex, ElementIndex; public IntPtr Extra; }
 [StructLayout(LayoutKind.Sequential)] struct SslPara { public uint Size, Auth, Checks; public IntPtr Name; }
 [DllImport("crypt32.dll", SetLastError=true)] static extern IntPtr CertOpenStore(IntPtr provider,uint encoding,IntPtr crypt,uint flags,IntPtr param);
 [DllImport("crypt32.dll", SetLastError=true)] static extern bool CertAddEncodedCertificateToStore(IntPtr store,uint encoding,byte[] bytes,uint length,uint disposition,IntPtr output);
 [DllImport("crypt32.dll", SetLastError=true)] static extern bool CertCloseStore(IntPtr store,uint flags);
 [DllImport("crypt32.dll", SetLastError=true)] static extern bool CertGetCertificateChain(IntPtr engine,IntPtr cert,IntPtr time,IntPtr store,ref ChainPara para,uint flags,IntPtr reserved,out IntPtr chain);
 [DllImport("crypt32.dll")] static extern void CertFreeCertificateChain(IntPtr chain);
 [DllImport("crypt32.dll", SetLastError=true)] static extern bool CertVerifyCertificateChainPolicy(IntPtr policy,IntPtr chain,ref PolicyPara para,ref PolicyStatus status);
 static void Require(bool ok,string code) { if(!ok) throw new InvalidOperationException(code); }
 static string Hex(uint v) { return "0x"+v.ToString("X8"); }
 public static object Signature(byte[] certificate, byte[] issuer) {
  using(var cert=X509CertificateLoader.LoadCertificate(certificate))
  using(var parent=X509CertificateLoader.LoadCertificate(issuer))
  using(var rsa=parent.GetRSAPublicKey()) {
   var reader=new AsnReader(certificate,AsnEncodingRules.DER); var seq=reader.ReadSequence();
   byte[] tbs=seq.ReadEncodedValue().ToArray(); var alg=seq.ReadSequence(); string oid=alg.ReadObjectIdentifier();
   if(alg.HasData) alg.ReadNull(); alg.ThrowIfNotEmpty();
   int unused; byte[] signature=seq.ReadBitString(out unused); seq.ThrowIfNotEmpty(); reader.ThrowIfNotEmpty();
   Require(oid=="1.2.840.113549.1.1.11" && unused==0 && rsa!=null,"UnsupportedSignatureAlgorithm");
   bool valid=rsa.VerifyData(tbs,signature,HashAlgorithmName.SHA256,RSASignaturePadding.Pkcs1);
   Require(valid,"PublicSignatureVerificationFailed");
   return new { Verified=true, Algorithm=oid, IssuerSubjectRawEqual=Convert.ToHexString(cert.IssuerName.RawData)==Convert.ToHexString(parent.SubjectName.RawData) };
  }
 }
 static object Policy(IntPtr chain,bool ssl,string hostname) {
  IntPtr name=IntPtr.Zero, extra=IntPtr.Zero;
  try {
   var para=new PolicyPara { Size=(uint)Marshal.SizeOf<PolicyPara>(), Flags=0 };
   if(ssl) {
    name=Marshal.StringToHGlobalUni(hostname); var s=new SslPara { Size=(uint)Marshal.SizeOf<SslPara>(), Auth=2, Checks=0, Name=name };
    extra=Marshal.AllocHGlobal(Marshal.SizeOf<SslPara>()); Marshal.StructureToPtr(s,extra,false); para.Extra=extra;
   }
   var status=new PolicyStatus { Size=(uint)Marshal.SizeOf<PolicyStatus>() };
   Require(CertVerifyCertificateChainPolicy(new IntPtr(ssl?4:1),chain,ref para,ref status),"PolicyApiFailed:"+Marshal.GetLastWin32Error());
   return new { Error=Hex(status.Error), status.ChainIndex, status.ElementIndex, IgnoreFlags=0, Hostname=ssl?hostname:null };
  } finally { if(extra!=IntPtr.Zero) Marshal.FreeHGlobal(extra); if(name!=IntPtr.Zero) Marshal.FreeHGlobal(name); }
 }
 public static object Build(byte[] leaf,byte[] ca,bool machine,bool additionalIssuer,bool revocation) {
  // HCCE_CURRENT_USER=0 / HCCE_LOCAL_MACHINE=1. MEMORY additional store supplies issuer, not trust.
  IntPtr store=IntPtr.Zero, chain=IntPtr.Zero, oid=IntPtr.Zero, oids=IntPtr.Zero;
  var cleanup=new List<string>(); object result=null;
  using(var cert=X509CertificateLoader.LoadCertificate(leaf)) {
   try {
    Require(IntPtr.Size==8 && Marshal.SizeOf<ChainPara>()==96 && Marshal.SizeOf<Chain>()==72 && Marshal.SizeOf<Element>()==56,"NativeStructureLayoutMismatch");
    if(additionalIssuer) {
     store=CertOpenStore(new IntPtr(2),0,IntPtr.Zero,0x2000,IntPtr.Zero); Require(store!=IntPtr.Zero,"MemoryStoreOpenFailed");
     Require(CertAddEncodedCertificateToStore(store,1,ca,(uint)ca.Length,1,IntPtr.Zero),"MemoryIssuerAddFailed");
    }
    oid=Marshal.StringToHGlobalAnsi("1.3.6.1.5.5.7.3.1"); oids=Marshal.AllocHGlobal(IntPtr.Size); Marshal.WriteIntPtr(oids,oid);
    var para=new ChainPara { Size=(uint)Marshal.SizeOf<ChainPara>(), Usage=new Match { Type=0, Usage=new Usage { Count=1,Oids=oids } } };
    uint flags=0x4|0x100|0x2000; if(revocation) flags|=0x40000000|0x80000000;
    Require(CertGetCertificateChain(new IntPtr(machine?1:0),cert.Handle,IntPtr.Zero,store,ref para,flags,IntPtr.Zero,out chain),"ChainApiFailed:"+Marshal.GetLastWin32Error());
    var c=Marshal.PtrToStructure<Chain>(chain); Require(c.Count>0 && c.Count<=8,"UnexpectedChainCount");
    var rows=new List<object>();
    for(int i=0;i<c.Count;i++) {
     var s=Marshal.PtrToStructure<Simple>(Marshal.ReadIntPtr(c.Chains,i*IntPtr.Size)); Require(s.Count>0 && s.Count<=16,"UnexpectedElementCount");
     for(int j=0;j<s.Count;j++) {
      var e=Marshal.PtrToStructure<Element>(Marshal.ReadIntPtr(s.Elements,j*IntPtr.Size)); var n=Marshal.PtrToStructure<Cert>(e.Cert);
      Require(n.Length>0 && n.Length<65536,"UnexpectedPublicCertificateLength"); byte[] raw=new byte[n.Length]; Marshal.Copy(n.Bytes,raw,0,raw.Length);
      using(var x=X509CertificateLoader.LoadCertificate(raw)) rows.Add(new { Chain=i, Element=j, x.Subject, x.Issuer, x.Thumbprint, ErrorStatus=Hex(e.Trust.Error), InfoStatus=Hex(e.Trust.Info) });
     }
    }
    result=new { Engine=machine?"HCCE_LOCAL_MACHINE":"HCCE_CURRENT_USER", AdditionalPublicIssuer=additionalIssuer, AdditionalStoreIsTrustAnchor=false, Flags=Hex(flags), UrlDownloads=false, RootAutoUpdate=false, RevocationRequested=revocation, ErrorStatus=Hex(c.Trust.Error), InfoStatus=Hex(c.Trust.Info), Elements=rows, BasePolicy=Policy(chain,false,null), SslPolicy=Policy(chain,true,"DESKTOP-8QRQT7R") };
   } finally {
    if(chain!=IntPtr.Zero) CertFreeCertificateChain(chain);
    if(store!=IntPtr.Zero && !CertCloseStore(store,2)) cleanup.Add("MemoryStoreCloseFailed:"+Marshal.GetLastWin32Error());
    if(oids!=IntPtr.Zero) Marshal.FreeHGlobal(oids); if(oid!=IntPtr.Zero) Marshal.FreeHGlobal(oid);
   }
  }
  Require(cleanup.Count==0,string.Join(";",cleanup)); return result;
 }
}
