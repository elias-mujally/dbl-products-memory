using System;
using System.Collections.Generic;
using System.Formats.Asn1;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;

// Public CSR -> approved leaf only. No key generation/export, stores or native acquisition.
public static class DblYseduLeafSigning001 {
    public const string CaHash = "A3FBC7905425B2E8C10F3A070B8713F876B94FC42B8D1243DEAD5D0F42889472";
    public const string CaThumb = "121CDC9857488ED95F4BC62106D7672BB0DBC6C3";
    public const string Host = "DESKTOP-8QRQT7R";
    static readonly Dictionary<string,(bool Critical,string Hex)> Profile = new() {
        ["2.5.29.15"]=(true,"030205A0"),
        ["2.5.29.17"]=(false,"3011820F4445534B544F502D38515251543752"),
        ["2.5.29.19"]=(true,"3000"),
        ["2.5.29.37"]=(false,"300A06082B06010505070301")
    };
    static void Require(bool value,string code) { if(!value) throw new InvalidOperationException(code); }
    public static string Hash(byte[] bytes) => Convert.ToHexString(SHA256.HashData(bytes));
    public static void ValidateRequest(CertificateRequest r) {
        Require(r.SubjectName.Name=="CN="+Host,"RequestSubject");
        Require(r.PublicKey.Oid.Value=="1.2.840.113549.1.1.1","RequestRsa");
        using(var rsa=r.PublicKey.GetRSAPublicKey()) Require(rsa!=null && rsa.KeySize==2048,"RequestRsa2048");
    }
    public static CertificateRequest ApprovedRequest(CertificateRequest csr) {
        ValidateRequest(csr);
        var r=new CertificateRequest(csr.SubjectName,csr.PublicKey,HashAlgorithmName.SHA256,RSASignaturePadding.Pkcs1);
        // Never forward S/MIME, SKI, attributes, unknown extensions or private-key associations.
        foreach(var p in Profile) r.CertificateExtensions.Add(new X509Extension(p.Key,Convert.FromHexString(p.Value.Hex),p.Value.Critical));
        ValidateExtensions(r.CertificateExtensions);
        return r;
    }
    public static void ValidateExtensions(IEnumerable<X509Extension> extensions) {
        var seen=new HashSet<string>();
        foreach(var e in extensions) {
            string oid=e.Oid?.Value ?? "";
            Require(seen.Add(oid) && Profile.ContainsKey(oid),"LeafExtensionSet");
            Require(e.Critical==Profile[oid].Critical && Convert.ToHexString(e.RawData)==Profile[oid].Hex,"LeafExtensionValue");
        }
        Require(seen.Count==4,"LeafExtensionCount");
    }
    public static void VerifySignature(X509Certificate2 certificate,RSA issuerPublic) {
        var reader=new AsnReader(certificate.RawData,AsnEncodingRules.DER);
        var outer=reader.ReadSequence(); byte[] tbs=outer.ReadEncodedValue().ToArray();
        var alg=outer.ReadSequence();
        Require(alg.ReadObjectIdentifier()=="1.2.840.113549.1.1.11","CertificateSignatureAlgorithm");
        if(alg.HasData) alg.ReadNull(); alg.ThrowIfNotEmpty();
        byte[] signature=outer.ReadBitString(out int unused);
        Require(unused==0,"CertificateSignaturePadding"); outer.ThrowIfNotEmpty(); reader.ThrowIfNotEmpty();
        Require(issuerPublic.VerifyData(tbs,signature,HashAlgorithmName.SHA256,RSASignaturePadding.Pkcs1),"CertificateSignatureMismatch");
    }
    public static void ValidateCa(X509Certificate2 ca,DateTimeOffset now) {
        Require(Hash(ca.RawData)==CaHash && ca.Thumbprint==CaThumb,"ExactCaIdentity");
        Require(ca.Subject=="CN=DBL Laboratory YSEDU CA 001 - 20261010" && ca.Subject==ca.Issuer,"CaSubjectIssuer");
        Require(now.UtcDateTime>=ca.NotBefore.ToUniversalTime() && now.UtcDateTime<ca.NotAfter.ToUniversalTime(),"CaValidity");
        Require(ca.PublicKey.Oid.Value=="1.2.840.113549.1.1.1","CaRsa");
        using var pub=ca.GetRSAPublicKey(); Require(pub!=null && pub.KeySize==3072,"CaRsa3072");
        VerifySignature(ca,pub);
        bool bc=false,ku=false;
        foreach(var e in ca.Extensions) {
            if(e.Oid?.Value=="2.5.29.19") { var v=new X509BasicConstraintsExtension(e,e.Critical); Require(v.CertificateAuthority && v.HasPathLengthConstraint && v.PathLengthConstraint==0 && v.Critical,"CaConstraints"); bc=true; }
            if(e.Oid?.Value=="2.5.29.15") { var v=new X509KeyUsageExtension(e,e.Critical); Require(v.Critical && v.KeyUsages==(X509KeyUsageFlags.KeyCertSign|X509KeyUsageFlags.CrlSign),"CaUsage"); ku=true; }
        }
        Require(bc && ku,"CaPurpose");
    }
    public static void ValidateLeaf(X509Certificate2 leaf,CertificateRequest csr,X509Certificate2 ca,DateTimeOffset before,DateTimeOffset after,DateTimeOffset now) {
        ValidateCa(ca,now); ValidateRequest(csr);
        Require(!leaf.HasPrivateKey,"PublicLeafOnly");
        Require(Convert.ToHexString(leaf.SubjectName.RawData)==Convert.ToHexString(csr.SubjectName.RawData),"LeafSubject");
        Require(Convert.ToHexString(leaf.IssuerName.RawData)==Convert.ToHexString(ca.SubjectName.RawData),"LeafIssuer");
        Require(Convert.ToHexString(leaf.PublicKey.ExportSubjectPublicKeyInfo())==Convert.ToHexString(csr.PublicKey.ExportSubjectPublicKeyInfo()),"LeafCsrPublicMatch");
        Require(leaf.NotBefore.ToUniversalTime()==before.UtcDateTime && leaf.NotAfter.ToUniversalTime()==after.UtcDateTime && after-before==TimeSpan.FromDays(180),"LeafValidity180Days");
        Require(before.UtcDateTime>=ca.NotBefore.ToUniversalTime() && after.UtcDateTime<=ca.NotAfter.ToUniversalTime() && now>=before && now<after,"LeafWithinCaValidity");
        Require(leaf.SignatureAlgorithm.Value=="1.2.840.113549.1.1.11","LeafSha256Rsa");
        ValidateExtensions(leaf.Extensions);
        using(var pub=ca.GetRSAPublicKey()) VerifySignature(leaf,pub);
        using var chain=new X509Chain();
        chain.ChainPolicy.TrustMode=X509ChainTrustMode.CustomRootTrust;
        chain.ChainPolicy.CustomTrustStore.Add(ca);
        chain.ChainPolicy.DisableCertificateDownloads=true;
        chain.ChainPolicy.VerificationFlags=X509VerificationFlags.NoFlag;
        chain.ChainPolicy.VerificationTime=now.UtcDateTime;
        // Offline lab has no CRL/OCSP. This proves cryptographic chain/profile, NOT revocation or live TLS.
        chain.ChainPolicy.RevocationMode=X509RevocationMode.NoCheck;
        chain.ChainPolicy.ApplicationPolicy.Add(new Oid("1.3.6.1.5.5.7.3.1"));
        Require(chain.Build(leaf),"ExclusiveCaOfflineChain");
        Require(chain.ChainStatus.Length==0 && chain.ChainElements.Count==2 && Hash(chain.ChainElements[0].Certificate.RawData)==Hash(leaf.RawData) && Hash(chain.ChainElements[1].Certificate.RawData)==CaHash,"ExactTwoCertificateChain");
    }
    public static X509Certificate2 Sign(CertificateRequest csr,X509Certificate2 issuer,DateTimeOffset now) {
        ValidateCa(issuer,now); Require(issuer.HasPrivateKey,"CaPrivateKeyRequired");
        using var rsa=issuer.GetRSAPrivateKey();
        Require(rsa is RSACng && ((RSACng)rsa).Key.IsEphemeral && ((RSACng)rsa).Key.KeyName==null && rsa.KeySize==3072,"CaEphemeralOnly");
        DateTimeOffset before=now.AddMinutes(-5),after=before.AddDays(180);
        Require(before.UtcDateTime>=issuer.NotBefore.ToUniversalTime() && after.UtcDateTime<=issuer.NotAfter.ToUniversalTime(),"LeafValidityWithinIssuer");
        byte[] serial=RandomNumberGenerator.GetBytes(16); serial[0]=(byte)((serial[0]&0x7F)|0x01);
        var r=ApprovedRequest(csr);
        // Explicit typed overload. No use of the existing server private key; only issuer signs.
        var generator=X509SignatureGenerator.CreateForRSA(rsa,RSASignaturePadding.Pkcs1);
        X509Certificate2 leaf=r.Create(issuer.SubjectName,generator,before,after,serial);
        try { ValidateLeaf(leaf,csr,issuer,before,after,now); return leaf; }
        catch { leaf.Dispose(); throw; }
    }
}
