# Retained source of the actual hash-only probe. No persisted key acquisition/generation.
# Compile in a fresh process; no SQL connection or machine configuration operation.
$ErrorActionPreference='Stop'
Add-Type -TypeDefinition @'
using System;using System.Runtime.InteropServices;
public static class DblProviderHashCompare {
 [DllImport("advapi32.dll",CharSet=CharSet.Unicode,SetLastError=true)] static extern bool CryptAcquireContextW(out IntPtr h,string c,string p,uint t,uint f);
 [DllImport("advapi32.dll",SetLastError=true)] static extern bool CryptCreateHash(IntPtr h,uint a,IntPtr k,uint f,out IntPtr hash);
 [DllImport("advapi32.dll")] static extern bool CryptDestroyHash(IntPtr h);
 [DllImport("advapi32.dll")] static extern bool CryptReleaseContext(IntPtr h,uint f);
 public static string Check(string p,uint t,uint a){IntPtr h=IntPtr.Zero,hash=IntPtr.Zero;try{if(!CryptAcquireContextW(out h,null,p,t,0xF0000000))return "AcquireError=0x"+Marshal.GetLastWin32Error().ToString("X8");if(!CryptCreateHash(h,a,IntPtr.Zero,0,out hash))return "HashError=0x"+Marshal.GetLastWin32Error().ToString("X8");return "PASS";}finally{if(hash!=IntPtr.Zero)CryptDestroyHash(hash);if(h!=IntPtr.Zero)CryptReleaseContext(h,0);}}
}
'@
[pscustomobject]@{
 ObservedAt=(Get-Date -Format o)
 SchannelSHA256=[DblProviderHashCompare]::Check('Microsoft RSA SChannel Cryptographic Provider',12,0x800C)
 SchannelSHA1Control=[DblProviderHashCompare]::Check('Microsoft RSA SChannel Cryptographic Provider',12,0x8004)
 EnhancedRsaAesSHA256=[DblProviderHashCompare]::Check('Microsoft Enhanced RSA and AES Cryptographic Provider',24,0x800C)
 Flag='CRYPT_VERIFYCONTEXT';KeyCreated=$false;CertificateCreated=$false;SettingsChanged=$false
}|ConvertTo-Json
