using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;
using System.Security.Principal;

// Exactly one pinned public certificate, one fixed existing machine store, ADD_NEW only.
// Retain the returned context for owned rollback. No lookup/delete by Subject/thumbprint.
public static class DblOwnedMachineRoot001 {
 const string Pin="A3FBC7905425B2E8C10F3A070B8713F876B94FC42B8D1243DEAD5D0F42889472";
 const string Thumb="121CDC9857488ED95F4BC62106D7672BB0DBC6C3";
 static IntPtr store=IntPtr.Zero, owned=IntPtr.Zero;
 public static bool Attempted {get;private set;}
 public static bool Added {get;private set;}
 public static bool RollbackAttempted {get;private set;}
 public static bool RollbackSucceeded {get;private set;}
 public static List<string> CleanupFailures {get;}=new List<string>();
 [StructLayout(LayoutKind.Sequential)] struct Cert {public uint Encoding;public IntPtr Bytes;public uint Length;public IntPtr Info,Store;}
 [DllImport("crypt32.dll",SetLastError=true,CharSet=CharSet.Unicode)] static extern IntPtr CertOpenStore(IntPtr provider,uint encoding,IntPtr crypt,uint flags,string name);
 [DllImport("crypt32.dll",SetLastError=true)] static extern bool CertAddEncodedCertificateToStore(IntPtr store,uint encoding,byte[] bytes,uint length,uint disposition,out IntPtr context);
 [DllImport("crypt32.dll",SetLastError=true)] static extern bool CertDeleteCertificateFromStore(IntPtr context);
 [DllImport("crypt32.dll",SetLastError=true)] static extern bool CertFreeCertificateContext(IntPtr context);
 [DllImport("crypt32.dll",SetLastError=true)] static extern bool CertCloseStore(IntPtr store,uint flags);
 static void Require(bool ok,string code){if(!ok)throw new InvalidOperationException(code);}
 static void Validate(byte[] der){
  Require(Convert.ToHexString(SHA256.HashData(der))==Pin,"ExactDerRequired");
  using(var c=X509CertificateLoader.LoadCertificate(der))Require(c.Thumbprint==Thumb && !c.HasPrivateKey,"ExactPublicCaRequired");
 }
 public static void AddNew(byte[] der){
  Require(!Attempted && store==IntPtr.Zero && owned==IntPtr.Zero,"OneAttemptOnly");
  Require(Environment.MachineName=="DESKTOP-8QRQT7R","HostRequired");
  using(var id=WindowsIdentity.GetCurrent())Require(new WindowsPrincipal(id).IsInRole(WindowsBuiltInRole.Administrator),"RealAdministratorRequired");
  Validate(der); Attempted=true;
  // SYSTEM_W=10, LOCAL_MACHINE=0x20000, OPEN_EXISTING=0x4000. No create-store or replace.
  store=CertOpenStore(new IntPtr(10),0,IntPtr.Zero,0x24000,"Root");
  Require(store!=IntPtr.Zero,"OpenMachineRootFailed:"+Marshal.GetLastWin32Error());
  bool ok=CertAddEncodedCertificateToStore(store,1,der,(uint)der.Length,1,out owned); // CERT_STORE_ADD_NEW=1
  int error=Marshal.GetLastWin32Error(); Added=ok;
  Require(ok,"AddNewFailed:"+error); Require(owned!=IntPtr.Zero,"MissingOwnedContextStop");
 }
 public static void RemoveOwned(){
  Require(Added && !RollbackAttempted && owned!=IntPtr.Zero,"OwnedRemovalNotAvailable");
  var c=Marshal.PtrToStructure<Cert>(owned); Require(c.Length>0 && c.Length<65536,"OwnedLengthInvalid");
  var der=new byte[c.Length];Marshal.Copy(c.Bytes,der,0,der.Length);Validate(der);
  RollbackAttempted=true; IntPtr remove=owned;owned=IntPtr.Zero;
  // Delete always consumes/frees its context, including failure. Never retry with a freed pointer.
  RollbackSucceeded=CertDeleteCertificateFromStore(remove);
  Require(RollbackSucceeded,"OwnedRemovalFailed:"+Marshal.GetLastWin32Error());
 }
 public static void Close(){
  if(owned!=IntPtr.Zero){var p=owned;owned=IntPtr.Zero;if(!CertFreeCertificateContext(p))CleanupFailures.Add("OwnedContextFreeFailed");}
  if(store!=IntPtr.Zero){var p=store;store=IntPtr.Zero;if(!CertCloseStore(p,2))CleanupFailures.Add("StoreCloseFailed");}
 }
}
