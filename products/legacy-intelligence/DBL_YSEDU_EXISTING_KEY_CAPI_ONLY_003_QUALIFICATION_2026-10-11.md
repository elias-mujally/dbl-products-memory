# Existing Key CAPI-only Qualification #003 — authorized gate

Date: 2026-10-11, Asia/Aden (+03). Follow-up to a02d6e1; original failures, helper #002 and key/CSR remain preserved.

## Actual decision

**2026-10-11 07:12:59+03 — EXISTING_KEY_CAPI_ONLY_003_QUALIFIED / PASSED within the existing-key scope. FIRST LIVE DATA remains NOT TESTED.** [Actual operator result and independently measured artifact hashes](research/DBL_YSEDU_CAPI_ONLY_003_OPERATOR_QUALIFIED_2026-10-11.json). Agent reread the local result and attempt, checked source/helper/CSR hashes, and did not repeat acquisition. Native acquisition proved actual Enhanced RSA and AES CSP/type24, KeySpec1/AT_KEYEXCHANGE, machine flags32, CALG_RSA_KEYX and RSA2048. One SHA256 challenge verified against the pinned CSR public key. KP_PERMISSIONS=59 (0x3B) lacks both export/archive policy bits; no export was attempted. This is policy qualification, not a guarantee against all privileged extraction.

Association before/after and five certificate-store inventories were unchanged within the operator invocation; original artifacts were reported unchanged. CallerFreeProvider=true; no native or managed cleanup failures were reported. Current helper/native-source/CSR hashes match their pinned bytes. This result does not establish a blanket historical key/security fingerprint. Fresh agent service read at07:16:19+03: YSEDU Running, SQLBrowser Stopped. No new key, CA unlock, leaf issuance/acceptance, SQL stop, ACL, registry, network or E writes in this gate; this follow-up reviewed evidence only.

**Still NOT TESTED:** key DACL suitability, effective SYSTEM access, SQL2014 certificate loading, strict TLS connection and live SQL→DBL import. Reader credentials are not qualified by this gate. Historical #002 really rejected a returned RSACng wrapper; #003 now qualifies the actual native CSP policy without weakening the approved requirement. The reason for managed wrapper selection remains uninvestigated; do not infer key conversion, corruption or replacement.

**Next separate step:** bounded signing/profile qualification of the existing CSR with the existing CA and owner-interactive password custody. No new key/CA, no automatic leaf acceptance or service/network maintenance. STOP now, preserving the consumed #003 marker/result and earlier failures.

## Historical preparation before operator execution

**Synthetic guard tests = PASSED; public preflight = PASSED; native existing-key qualification = PENDING OPERATOR / NOT TESTED. FIRST LIVE DATA NOT TESTED.** [Actual non-sensitive evidence and hashes](research/DBL_YSEDU_CAPI_ONLY_003_PREFLIGHT_2026-10-11.json). No new machine key, native acquisition, certificate signing/acceptance, CA unlock, SQL interruption, ACL/store/network/ERP mutation or E access in this turn. Fresh YSEDU Running / Browser Stopped. Attempt/result #003 absent. Agent token is non-administrative; no automatic elevation or private-key retry attempted.

## Exact bounded method

[Native source](research/DBL_YSEDU_CAPI_ONLY_003_NATIVE_SOURCE_2026-10-11.cs) calls CryptAcquireCertificatePrivateKey **once**, flags0x4C (COMPARE_KEY + NO_HEALING + SILENT), no cache/use-provision-info or NCRYPT technology flags. No CryptAcquireContext/key creation/import/export/set/delete APIs. Existing certificate association is separately bounded/read and required to identify CSP24/name/KeySpec1/flags32/no provider parameters/nonempty container before acquisition. Container name stays in memory, never in stdout or public evidence. Association fingerprint is compared after native cleanup without acquiring again.

[Microsoft acquisition contract](https://learn.microsoft.com/en-us/windows/win32/api/wincrypt/nf-wincrypt-cryptacquirecertificateprivatekey) defines CryptoAPI-only behavior in the absence of NCRYPT flags, public-key comparison, no-healing/silent semantics and returned handle ownership. Final native checks require acquisition KeySpec1; PP_PROVTYPE24; exact Enhanced RSA and AES provider name; PP_KEYSET_TYPE32; CryptGetUserKey(AT_KEYEXCHANGE); KP_ALGID CALG_RSA_KEYX; KP_KEYLEN2048. [Provider queries](https://learn.microsoft.com/en-us/windows/win32/api/wincrypt/nf-wincrypt-cryptgetprovparam) and [key queries](https://learn.microsoft.com/en-us/windows/win32/api/wincrypt/nf-wincrypt-cryptgetkeyparam) supply the properties; stored metadata alone is not enough.

Nonexportability is **policy evidence** from KP_PERMISSIONS: CRYPT_EXPORT0x4 and CRYPT_ARCHIVE0x100 must both be absent. It is not an attempted export or a guarantee against every privileged attacker. Do not confuse CRYPT_EXPORT_KEY (exporting other keys) with CRYPT_EXPORT (exporting this key). Failure reports actual permission bits and exact check, without secret material. [Windows SDK header](https://raw.githubusercontent.com/microsoft/win32metadata/main/generation/WinSDK/RecompiledIdlHeaders/um/wincrypt.h) independently confirms constants and flag masks.

A single random32-byte challenge is hashed with CALG_SHA_256; one CryptSignHashW call uses AT_KEYEXCHANGE/default PKCS1 and a fixed256-byte buffer justified by already-verified RSA2048. No signing size-query second call. Native signature bytes are reversed for RSA public VerifyData against the pinned CSR public key. Pending-certificate public key equals CSR before any acquisition; native COMPARE_KEY plus successful challenge establishes actual key linkage. No private/public key export API is called on the acquired handle; only already-public CSR/certificate SPKI is compared. Signature/hash are transient, not published. [Signing API](https://learn.microsoft.com/en-us/windows/win32/api/wincrypt/nf-wincrypt-cryptsignhashw).

## Cleanup and diagnostics

Hash/user-key handles are released before caller-owned provider. Borrowed provider is not explicitly released; certificate remains alive throughout Run/post-read, then PowerShell disposes it. CryptDestroyKey releases a handle and **does not delete the persisted public/private pair**, per [Microsoft](https://learn.microsoft.com/en-us/windows/win32/api/wincrypt/nf-wincrypt-cryptdestroykey). Unexpected NCrypt-spec return fails immediately; NCryptFreeObject exists only to release an unexpected caller-owned handle, never as a CNG fallback/acquisition path. No key ACL or ownership setters.

Result records exact check, safe failure-kind and native Win32 numeric code when applicable. Individual association fields also have distinct rejecting checks. Primary failure/check/Win32 survives post-read and cleanup errors; secondary cleanup codes are separate. Any cleanup or association mismatch vetoes success. Bounded native buffers/strings/DWORD lengths fail closed. No raw provider exceptions/container/private material published.

## Actual tests and handoff

At07:07:07+03 [12 synthetic tests](research/DBL_YSEDU_CAPI_ONLY_003_TESTS_2026-10-11.ps1) passed: exact no-cache/no-NCRYPT flags;512 independently computed permission combinations; DWORD/name bounds; borrowed/owned handle policy; secondary false/throw cleanup; invalid-input stop before any native call. These are compile/static/managed guard tests, not actual CSP/PInvoke/SQL proof. Prior successful CSR/encryption/archive tests not repeated.

At07:07:49+03 [helper](research/DBL_YSEDU_CAPI_ONLY_003_HELPER_2026-10-11.ps1) PublicOnly passed exact original consumed native CSR/result/marker and #002 stop/marker pins, original rollback/settings/Browser/source pins, closed-world signed CSR profile and native compilation. PublicOnly did not open/read certificate stores or acquire a private key. [Launcher](research/DBL_YSEDU_CAPI_ONLY_003_LAUNCHER_2026-10-11.ps1) CheckOnly passed pinned Microsoft-signed PS7 runtime/helper without launching a child. PowerShell parsing passed. All four local source SHA256 pins in evidence JSON; source copies are review evidence, not alternate executable paths.

Full execution requires actual manually opened administrator token and fresh rollback/client/dependent-service/read-only baselines. Exact sole pending Request thumbprint079AF9D20802BD4A16B862928194A77BC14B93F4 and public identity must match. A CreateNew #003 marker is written immediately before the single native Run invocation; never reset/remove old or new attempt markers. CreateNew result follows resource cleanup; final five certificate-store inventories/original pins/service statuses must match for success. Any failure stops, no retry or auto-remediation.

## Bounds / next step

Only an actual successful #003 result qualifies tested native key properties/linkage/policy/challenge, **not effective SYSTEM access, key-DACL suitability, SQL2014 certificate loading, TCP/Browser/TLS, reader credentials or live data**. On success the next bounded maintenance step is signing/profile qualification of the existing public CSR with the existing CA; no new key/CA. Prepare/execute that only after the actual result is reviewed and required owner-interactive CA custody step is available. This helper does not unlock CA, issue/accept a leaf, stop SQL or change network. The current task's explicit prohibitions and final STOP take precedence over broader older maintenance authorization.

On failure retain precise result and STOP; no new diagnosis chain. Archive path remains paused, S2 LAB-PROVEN, S3 ACCOUNTING-BLOCKED, no connector/Core/Canonical/ERP changes. Product Memory only; .vscode excluded.
