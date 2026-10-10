# First Live Data #001 — single-host CA custody execution gate

Date: 2026-10-10, Asia/Aden (+03:00). Supersedes the custody-approval hold in `9ff75cd`, not its evidence limits.

## Decision

**LAB-ONLY SINGLE-HOST CA EXCEPTION = OWNER APPROVED.** No new offline issuing workstation or second recovery-medium prerequisite. The owner expressly accepts unlocked-key exposure on this lab host and the single E: copy's loss risk. This does not waive TLS, Firewall, reader identity/permissions or bounded maintenance limits.

**CA CUSTODY = BLOCKED / STOP after the actual 20:57 operator attempt.** The runtime/console preflight passed, but issuance did not qualify. A confirmed PowerShell null-to-empty-string binding defect invalidates the intended unnamed-key call. Exact failing assertion and actual key persistence were not recorded; do not infer them from the sanitized phase. E: contains the ownership marker only, not a PFX/public certificate. FIRST LIVE DATA #001 = NOT TESTED. No automatic retry or SQL interruption.

The encrypted-recovery-archive project remains PAUSED; accepted historical S2 fallback is not reopened. S2 LAB-PROVEN and S3 ACCOUNTING-BLOCKED unchanged.

## Fresh evidence

- Inspection shell: PowerShell7.6.5, .NET10.0.11. Runtime executable SHA256 `362A356CE7F0940EC74F73A8FC2C990A2CC24A38A11C90BBD8ECA947110AD139`, valid Microsoft signature. APIs for encrypted PFX export, bounded loading, integrity inspection and unnamed ephemeral CNG keys are present.
- E: is Healthy exFAT, 251,647,754,240 bytes total / 139,523,522,560 free at this inspection. It is partition1 on USB disk1, distinct from C:/D: on disk0/NVMe. Disk online and writable; root is not a reparse point. These are read-only observations, not a write/integrity/lifetime proof. No exFAT ACL or whole-drive encryption claim.
- Fresh approved S2 `.bak` SHA256 still `E63DF84D2DBB22C5ACD535DC5881D2DCF417F420665502927EBD9AD66731E572`. This retains historical limited recovery evidence, not current whole-instance recovery or a new Restore test.
- YSEDU Running/Auto/LocalSystem/PID5072; Browser Stopped/Disabled/LocalService. No bounded named GL/inv/pr/RepDes/SSMS/sqlcmd clients returned. No authenticated transaction/session/catalog inspection. Owner accepted this visibility limit; refresh before any actual shutdown.
- Node22.23.2 resolves the expected hostname to link-local IPv6 and local IPv4 192.168.56.1, 192.168.43.196, 172.17.80.1. No resolver change, packet probe or SQL login. Tedious's actual installed sender uses all resolved addresses for SSRP; no claim that SQL already listens on any of them. Choose/verify the exact restricted listener before mutation.
- Existing build checkout remains clean and its tracked tree equals merged origin/main `8c22f7b`; no connector or Canonical edits. Actual source pins encrypt=true, trustServerCertificate=false, YSEDU/frozen DB/reader, fixed bounded SELECTs and parameterized Item A. Existing end-to-end fixture test is not live evidence.

## Issuance helper and narrowly bounded operator step

Local reviewed file: `outputs/host-first-live-data-001-20261010/Invoke-LabCaCustody001.ps1`.

SHA256: **26974BC9463F79C2D9F6FAE17614D7BC7F3D63648608AAEF3DDA957A76D16BBC**.
[Retained source](research/DBL_LAB_CA_CUSTODY_001_HELPER_2026-10-10.ps1), text-equivalent after newline normalization. Retained copy is not the executable hash-pinned handoff target.

Actual `-PreflightOnly` execution at **20:40:45.5805102+03:00** returned `CA_CUSTODY_API_PREFLIGHT_PASSED`, KeyCreated=false, EWrites=false, SqlChanged=false. Syntax parsed successfully. The strict ASN.1 PBE parser separately accepted a public synthetic PBES2/AES256/HMAC-SHA256/200000 vector and rejected an AES128 variant. No cryptographic-key/PFX roundtrip is claimed from these checks.

The hash-pinned interactive step was handed to the owner in a fresh **non-elevated**, no-profile PowerShell7 process. No UAC/security-dialog automation or extra administrative privilege is required for this CA-only step. Input must be a real non-redirected console; automatic transcription policy is rejected. Owner confirms a newly generated, independently retained CA password (not archive/SQL), then enters it twice with `Read-Host -AsSecureString`. No password in command arguments, environment handoff, evidence, history command or chat.

The helper's **intended, not yet qualified** operation is one dedicated RSA3072/SHA256 CA with critical CA=true/pathLen0 and keyCertSign/cRLSign, two-year validity. Its source calls `CngKey.Create(RSA, $null, explicit parameters)` and checks IsEphemeral/no key name. The later binding probe disproves that this PowerShell call supplies the intended CLR null; the source expression alone is not an ephemeral-key guarantee. No certificate-store insertion is implemented. Intended retention is encrypted private PFX only on E:, with public DER/PEM alongside it, using CreateNew and no replacement/deletion/automatic second attempt. None of that PFX retention was achieved in the actual attempt.

PFX uses explicit PBES2 AES256-CBC with PBKDF2/HMAC-SHA256/200000 iterations plus SHA256 password MAC. Helper verifies actual ASN.1 encryption/KDF/MAC parameters, one encrypted private-key bag/one certificate, MAC success and random wrong-password MAC rejection. It re-reads E: bytes and SHA256, imports using only EphemeralKeySet with one-key/one-certificate/KDF bounds, verifies loaded ephemeral key identity and a sign/verify challenge, then checks unchanged thumbprint fingerprints of CurrentUser/My+Root and LocalMachine/My+Root. Only a sanitized public result can enter Product Memory. Password entropy and independent retention are owner attestation, not a measured entropy proof.

The key/password exist transiently in process memory. BSTR/byte buffers are cleared where supported and objects disposed, but managed string/runtime/pagefile traces are not guaranteed erased. This is the explicitly accepted lab risk. No claim that a compromised host cannot read an unlocked key. E: stays attached until necessary signing and verification finish; the owner disconnects it afterward, not now.

## STOP and continuation

- Missing APIs, wrong runtime/storage, redirected input, unconfirmed secret custody, mismatch, encryption/MAC/algorithm/bag/import/key/store drift => **STOP**. Retain artifacts; no retry or weaker crypto/persistent-key fallback, SQL interruption or private-key upload.
- This helper does **not** create a SQL leaf/CSR/machine key, install root trust, bind a certificate, alter permissions/TCP/Browser/Firewall, stop/start SQL or run the connector. It reports only its custody stage.
- After a successful actual operator result: prepare/review fresh YSEDU-specific combined rollback before host mutation; generate the single approved nonexportable legacy-SChannel RSA2048/KeySpec1 leaf request, validate/sign using the retained CA through secure interactive unlock, then qualify public leaf/key/provider. Machine operations require an actual authorized elevated operator; the agent token is not elevated by sandbox permission.
- Refresh client/service/Browser policy/listener selection before the authorized one normal YSEDU stop/start. No extra restart loop, ForceEncryption, Windows Root-store insertion, Firewall change, unrelated instance or data write implied. Stop for any extra security/ACL/trust/change requirement.
- Reader-secret gate remains separate: no archive/CA password substitution, guessing, administrative connector or login rotation. If unavailable, request reader-only rotation approval as instructed. Live success requires actual strict-TLS frozen-reader acquisition followed by ImportOrchestrator commit to SQLite and SnapshotReader exact Item A/name equality. Fixture/replay/projection-only tests cannot establish it.

## Operator result — 20:45 STOP

The owner returned a failed launcher command using `C:\Users\user.cache\...` rather than the supplied `C:\Users\user\.cache\...`: CommandNotFoundException, so that command did not start the qualified PowerShell7 executable. The helper was then invoked in the original session and returned **CA_CUSTODY_BLOCKED_STOP**, Phase=Preflight, RuntimeException, CustodyDirectoryCreated=false, EncryptedPfxWritten=false, SqlChanged=false, BrowserChanged=false, LeafIssued=false. [Sanitized retained result](research/DBL_LAB_CA_CUSTODY_001_OPERATOR_STOP_2026-10-10.json).

Failed qualified-runtime launch is directly evidenced. Rejection in the original runtime is consistent with the helper's exact-version/framework guard; the precise caller version was **not included** in its result, so do not assert a newly measured version or a PFX/cryptographic failure. Secret-entry phase was not reached.

Independent follow-up read confirmed the same on-disk sanitized JSON, no E: custody directory, the correctly spelled qualified runtime executable present, YSEDU still Running/Auto/PID5072, Browser still Stopped/Disabled/PID0 and no LocalMachine/My certificate entries returned. No rerun, E: write, key creation or service change. The failed local `CA_CUSTODY_RESULT.json` is retained; the helper deliberately requires a fresh evidence target, so **do not merely repeat it**. After the owner confirms the correct runtime, preserve this failed artifact before a separately reviewed invocation. No replacement of a PFX or key, no arbitrary new CA identity or expanded investigation.

## Corrected runtime handoff — owner confirmed7.6.5

The owner supplied `7.6.5` from the exact executable version-only command. Preserve the earlier failure as historical, not an unresolved runtime-path blocker.

The original sanitized result was moved **within the exact task output directory**, without replacement/deletion, to `CA_CUSTODY_RESULT_PREFLIGHT_STOP_20261010_204514.json`; SHA256 before/after equals **08BD7A060AF73ADEEDC41D1C894BED154D2B6A340A992E5FA6ED234E7567D057**. Decision/time/phase and all no-key/no-mutation flags were verified before that move. No E: change. The real custody directory remains absent; this is not a second CA identity or a key replacement.

Fresh no-key/no-write preflight at20:51:31.5892895+03 passed. A public launcher was tested through Windows PowerShell into the exact PowerShell7 executable using only `-PreflightOnly`; actual result at20:52:13.1310288+03 again passed, with KeyCreated/EWrites/SqlChanged=false. This qualifies the path/argument handoff, not hidden input or cryptographic execution.

The launcher then received an explicit interactive branch: one **visible, user-operated, non-RunAs** child console via Start-Process/WindowStyle Normal, no redirected input/output, no captured password prompt, no SQL change. Native arguments contain only encoded **public source**, not any password/key; this is quote-safe dispatch, not execution-policy or TLS bypass. The child checks the immutable custody-helper hash again. The parent only reports console process launch, never custody success. An interactive result has not yet been supplied. No agent-created interactive console was started by the validation calls.

Local launcher: `outputs/host-first-live-data-001-20261010/Start-LabCaCustody001.ps1`, SHA256 **7DB230D56144B81B1DE34E0812E68214035D34A938E23354D23B65A3945C05A3**; [retained source](research/DBL_LAB_CA_CUSTODY_001_LAUNCHER_2026-10-10.ps1), newline-normalized text equivalent. Syntax parsed. The original custody helper/hash remains unchanged. A single hash-pinned invocation was handed to the owner; no automatic retry or weaker requirement.

Fresh service observation after preparation: YSEDU Running/Auto/PID5072; Browser Stopped/Disabled/PID0. No leaf, SQL connection/import or host setting change. **Current handoff: await the sanitized actual child-console result; do not infer CA/PFX success from the launch or preflight.** `.vscode` excluded.

## Operator result — 20:57 issuance STOP and bounded diagnosis

The actual child-console result at **20:57:06.8070425+03** is `CA_CUSTODY_BLOCKED_STOP`, phase `EphemeralCaIssuance`, RuntimeException / no inner exception, custody directory created, encrypted PFX not written, no leaf / SQL / Browser change. The on-disk result matches the owner's JSON. SHA256 of the original local `CA_CUSTODY_RESULT.json`: **6F6B4232157108ABC9ECBC65EA741887ED65CE0051624BBCD5A97F757210A944**. It remains in place without replacement. [Sanitized retained result](research/DBL_LAB_CA_CUSTODY_001_ISSUANCE_STOP_2026-10-10.json). The preceding pending-handoff statements are historical, not the current state.

Follow-up read-only observations:

- Exact E: custody directory contains only the 82-byte `OWNERSHIP.txt` marker matching this authorized operation. No PFX, public CA DER/PEM or successful reimport evidence. No E: writes/deletion/retry by diagnosis.
- YSEDU Running/Auto/PID5072; Browser Stopped/Disabled/PID0. No service or SQL setting changes.
- No matching `DBL Laboratory YSEDU CA 001` certificate in the four inspected My/Root stores. No current-user CNG key file created in the narrowly checked 17:56–17:59 UTC interval. File metadata only, no private key contents. These limited negative observations do **not** prove absence of every possible persisted key or transient trace. No cleanup is authorized or performed from them.
- A harmless public method with the **same CngAlgorithm/string/CngKeyCreationParameters signature**, under PowerShell7.6.5, received `EMPTY` from the direct `$null` call; reflection with an actual null object and a typed C# null both received `NULL`. No cryptographic-key API was called or key created. [Reproducible probe](research/DBL_LAB_CA_CUSTODY_001_NULL_BINDING_PROBE_2026-10-10.ps1), [actual result](research/DBL_LAB_CA_CUSTODY_001_NULL_BINDING_RESULT_2026-10-10.json).

**CONFIRMED implementation defect:** the PowerShell binding at the intended unnamed-key creation boundary does not preserve null. **LIKELY failure explanation, not exact post-mortem proof:** the ephemeral/name assertion rejected the returned key. The sanitized phase spans directory creation, key creation/check and self-signed certificate construction; its generic exception plus cleared error buffer cannot identify the exact assertion or prove key state. Official API documentation promises non-persistence for no name; the public runtime source marks IsEphemeral only when `keyName == null`, not for an empty string. The consulted upstream source is supporting semantics, not a measured execution trace of the installed binary.

**Narrow proposed correction, not executed:** use a typed C# factory that supplies a literal CLR null to CngKey.Create, retains all ephemeral/key-name assertions, and records allowlisted subphase/boolean key-state diagnostics without driver/exception messages or key material. Qualify argument dispatch without creating a key first. Any new issuance is a separately acknowledged single attempt, not an automatic retry: preserve both failures and the existing ownership-only E: folder; do not delete/reset it or invent another CA identity to evade freshness guards. Its safe reuse needs explicit bounded handling before another run. Stop for any persistence evidence or unexplained artifact; no weakening of PFX/TLS requirements.

**Current decision:** no helper/key-generation rerun, no certificate/SQL/network mutation, no live connector test. Obtain owner agreement to the narrow correction and one controlled retry before proceeding. The archive investigation remains PAUSED; this defect does not reopen it. `.vscode` remains excluded.

## Primary API basis

[Unnamed CNG key is ephemeral](https://learn.microsoft.com/en-us/dotnet/api/system.security.cryptography.cngkey.create?view=net-10.0), [upstream null-only ephemeral flag](https://raw.githubusercontent.com/dotnet/runtime/main/src/libraries/System.Security.Cryptography/src/System/Security/Cryptography/CngKey.Create.cs), [explicit PBE export](https://learn.microsoft.com/en-us/dotnet/api/system.security.cryptography.x509certificates.x509certificate.exportpkcs12?view=net-10.0), [PFX EphemeralKeySet import](https://learn.microsoft.com/en-us/dotnet/api/system.security.cryptography.x509certificates.x509keystorageflags?view=net-10.0). API semantics are not a substitute for actual successful custody/reimport evidence.
