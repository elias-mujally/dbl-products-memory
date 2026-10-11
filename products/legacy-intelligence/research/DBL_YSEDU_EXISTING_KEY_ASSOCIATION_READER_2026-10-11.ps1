# Certificate association metadata ONLY. Never opens/acquires/signs/exports/changes a private key.
$ErrorActionPreference='Stop';Set-StrictMode -Version Latest
if($env:COMPUTERNAME -cne 'DESKTOP-8QRQT7R'){throw 'STOP: host mismatch'}
$root='C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010'
if((Get-FileHash -LiteralPath (Join-Path $root 'YSEDU-Leaf-CSP24-001.req') -Algorithm SHA256).Hash -cne '61B48D26A1AFB37B27ACF0EFDFAA1D90A29B9A39B2F012E0DA7367046E19B889'){throw 'STOP: existing CSR drift'}
Add-Type -TypeDefinition @'
using System;
using System.Runtime.InteropServices;
public static class DblExistingKeyAssociation001 {
 [StructLayout(LayoutKind.Sequential)] struct Info { public IntPtr Container,Provider; public uint Type,Flags,ParamCount; public IntPtr Params; public uint KeySpec; }
 public sealed class Result { public bool ReadOK; public int Win32; public string Provider; public uint ProviderType,Flags,KeySpec,ParameterCount; public bool ContainerNamePresent; }
 [DllImport("crypt32.dll",SetLastError=true)] static extern bool CertGetCertificateContextProperty(IntPtr context,uint property,IntPtr data,ref uint bytes);
 static string BoundedString(IntPtr value,IntPtr start,uint bytes) {
  if(value==IntPtr.Zero)return null;
  long offset=value.ToInt64()-start.ToInt64();
  if(offset<0 || offset>bytes-2 || (offset&1)!=0)throw new InvalidOperationException("Metadata pointer bound");
  int length=0;while(offset+2L*length+2<=bytes && length<4096){if(Marshal.ReadInt16(value,length*2)==0)return Marshal.PtrToStringUni(value,length);length++;}
  throw new InvalidOperationException("Metadata string bound");
 }
 public static Result Read(IntPtr context) {
  uint bytes=0;var result=new Result();
  if(!CertGetCertificateContextProperty(context,2,IntPtr.Zero,ref bytes)){result.Win32=Marshal.GetLastWin32Error();return result;}
  if(bytes<Marshal.SizeOf<Info>() || bytes>65536)throw new InvalidOperationException("Metadata length bound");
  IntPtr buffer=Marshal.AllocHGlobal((int)bytes);
  try {
   uint returned=bytes;if(!CertGetCertificateContextProperty(context,2,buffer,ref returned)){result.Win32=Marshal.GetLastWin32Error();return result;}
   if(returned>bytes || returned<Marshal.SizeOf<Info>())throw new InvalidOperationException("Metadata returned length bound");
   var info=Marshal.PtrToStructure<Info>(buffer);
   result.Provider=BoundedString(info.Provider,buffer,returned);result.ContainerNamePresent=!String.IsNullOrEmpty(BoundedString(info.Container,buffer,returned));
   result.ProviderType=info.Type;result.Flags=info.Flags;result.KeySpec=info.KeySpec;result.ParameterCount=info.ParamCount;result.ReadOK=true;return result;
  }finally{Marshal.FreeHGlobal(buffer);}
 }
}
'@
$pending=@(Get-ChildItem -LiteralPath 'Cert:\LocalMachine\Request');$public=$null;$requestPublic=$null
try {
 if($pending.Count -ne 1 -or $pending[0].Thumbprint -cne '079AF9D20802BD4A16B862928194A77BC14B93F4'){throw 'STOP: pending certificate identity'}
 $metadata=[DblExistingKeyAssociation001]::Read($pending[0].Handle)
 $text=Get-Content -LiteralPath (Join-Path $root 'YSEDU-Leaf-CSP24-001.req') -Raw
 if($text -cnotmatch '\A\s*-----BEGIN (?:NEW )?CERTIFICATE REQUEST-----\s+([A-Za-z0-9+/=\s]+)-----END (?:NEW )?CERTIFICATE REQUEST-----\s*\z'){throw 'STOP: CSR encoding'}
 $der=[Convert]::FromBase64String($Matches[1]);$request=[Security.Cryptography.X509Certificates.CertificateRequest]::LoadSigningRequest($der,[Security.Cryptography.HashAlgorithmName]::SHA256,[Security.Cryptography.X509Certificates.CertificateRequestLoadOptions]::UnsafeLoadCertificateExtensions,[Security.Cryptography.RSASignaturePadding]::Pkcs1)
 $public=[Security.Cryptography.X509Certificates.RSACertificateExtensions]::GetRSAPublicKey($pending[0]);$requestPublic=$request.PublicKey.GetRSAPublicKey()
 $publicEqual=[Convert]::ToBase64String($public.ExportSubjectPublicKeyInfo()) -ceq [Convert]::ToBase64String($requestPublic.ExportSubjectPublicKeyInfo())
 [pscustomobject]@{Decision=if($metadata.ReadOK){'EXISTING_KEY_ASSOCIATION_METADATA_READ_PASSED'}else{'EXISTING_KEY_ASSOCIATION_METADATA_READ_BLOCKED'};ObservedAt=(Get-Date -Format o);ReadOK=$metadata.ReadOK;Win32=$metadata.Win32;PendingThumbprint=$pending[0].Thumbprint;HasPrivateKeyProperty=$pending[0].HasPrivateKey;Provider=$metadata.Provider;ProviderType=$metadata.ProviderType;Flags=$metadata.Flags;MachineKeyFlag=(($metadata.Flags -band 32) -ne 0);KeySpec=$metadata.KeySpec;ParameterCount=$metadata.ParameterCount;ContainerNamePresent=$metadata.ContainerNamePresent;PublicKeyMatchesCsr=$publicEqual;ContainerNamePublished=$false;PrivateKeyOpened=$false;PrivateKeyPropertiesQualified=$false;NativeKeyCreation=$false;SqlChanged=$false;StoreChanged=$false}|ConvertTo-Json
}finally{foreach($item in @($public,$requestPublic)+$pending){if($null -ne $item){$item.Dispose()}}}
