# Public, no-key argument-binding probe. Does NOT invoke CngKey.Create.
$ErrorActionPreference='Stop'
Add-Type -TypeDefinition @'
using System.Security.Cryptography;
public static class DblCngSignatureBindingProbe001 {
 public static string Describe(CngAlgorithm algorithm, string keyName, CngKeyCreationParameters parameters) {
   return keyName == null ? "NULL" : keyName.Length == 0 ? "EMPTY" : "NONEMPTY";
 }
 public static string TypedNull(CngAlgorithm algorithm, CngKeyCreationParameters parameters) {
   return Describe(algorithm, null, parameters);
 }
}
'@
$probeArgs=[Security.Cryptography.CngKeyCreationParameters]::new()
$probeMethod=[DblCngSignatureBindingProbe001].GetMethod('Describe')
[pscustomobject]@{
 ObservedAt=(Get-Date -Format o)
 Runtime=$PSVersionTable.PSVersion.ToString()
 SameSignaturePowerShellNull=[DblCngSignatureBindingProbe001]::Describe([Security.Cryptography.CngAlgorithm]::Rsa,$null,$probeArgs)
 SameSignatureReflectionNull=$probeMethod.Invoke($null,[object[]]@([Security.Cryptography.CngAlgorithm]::Rsa,$null,$probeArgs))
 TypedCSharpNull=[DblCngSignatureBindingProbe001]::TypedNull([Security.Cryptography.CngAlgorithm]::Rsa,$probeArgs)
 CryptographicKeyApiCalled=$false
 KeysCreated=$false
 PrivateDataRead=$false
 EWrites=$false
 ServicesChanged=$false
}|ConvertTo-Json
