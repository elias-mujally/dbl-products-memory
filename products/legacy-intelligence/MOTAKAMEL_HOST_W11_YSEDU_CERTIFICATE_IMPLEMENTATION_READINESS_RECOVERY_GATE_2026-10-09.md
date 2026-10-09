# YSEDU Certificate Implementation Readiness & Recovery Gate

Date: **2026-10-09**. Host: **DESKTOP-8QRQT7R**. Inspection: **22:01–22:06 +03:00**.
Baseline design: [5dc9c3e](MOTAKAMEL_HOST_W11_YSEDU_CERTIFICATE_REMEDIATION_DESIGN_2026-10-09.md).
**Decision: NO-GO for certificate implementation / SQL interruption now. Tool-capability preflight is available; current recovery coverage and custody handoff are not complete.**

The owner has accepted the dedicated laboratory CA, one YSEDU leaf, additive Windows maintenance-user
CurrentUser/Root trust and exclusive approved-CA trust in a later Node22 process. Those trust-scope
choices supersede the earlier request for an owner decision; their actual installation/handshake remains
untested. Approval in principle is **not** issuance, import, binding, outage or live-test authorization.
No product change: S2 remains LAB-PROVEN, S3 ACCOUNTING-BLOCKED, live connector NOT TESTED.

## 1. Actual tool readiness — no cryptographic artifact created

| Current observation | Qualified limit |
| --- | --- |
| certreq.exe / certutil.exe in System32, file version10.0.22621.1 | Installed native request/import/diagnostic tools; only help and `certutil -csplist` ran |
| Microsoft RSA SChannel Cryptographic Provider / type12 PROV_RSA_SCHANNEL | Provider presence directly enumerated, not inferred only from registry |
| Microsoft Enhanced RSA and AES Cryptographic Provider / type24 | Also present; **not substituted** for the selected leaf provider |
| PKI New-SelfSignedCertificate | Command metadata exposes Provider, KeySpec, KeyLength, HashAlgorithm, Signer, Type, TextExtension, KeyExportPolicy, CertStoreLocation; command never invoked |
| PKI Export/Import-PfxCertificate and Export-Certificate | Present; no certificate/private key exported or imported |
| Existing SQLServerManager12.msc | `C:\Windows\SysWOW64\SQLServerManager12.msc` present; no console action |
| Inspection shell | PowerShell7.6.5 / .NET10.0.11, bundled pwsh; **not Node**, not the SQL runtime |
| .NET CertificateRequest API reflection | LoadSigningRequest/Pem, CreateSelfSigned and issuer Create overloads present; none invoked |
| .NET encrypted PFX / loading API reflection | ExportPkcs12(PbeParameters or Pkcs12ExportPbeParameters), Pbes2Aes256Sha256 and X509CertificateLoader.LoadPkcs12 present; no key/PFX loaded or generated |
| OpenSSL | Not resolved on PATH; not claimed absent everywhere, not installed |
| Operator | DESKTOP-8QRQT7R\user, non-elevated; machine issuance/import/binding and protected inventory need an authorized elevated operator |

The selected host request design remains **RSA2048 / legacy SChannel CSP / ProviderType12 /
KeySpec1 AT_KEYEXCHANGE / MachineKeySet=true / non-exportable**, explicit SHA256 request and approved
SAN/EKU/usages. `certreq -new` and `-accept -machine` are future actions, **not readiness probes**.
Microsoft's SQL encryption page supplies a SHA256/KeyExchange/SChannel-provider example; installed
command metadata and provider enumeration support a practical route, not empirical proof of CSR creation,
provider hashing, key association or SQL2014 loading. If creation later fails, STOP: no SHA1 downgrade,
KSP switch, reuse of an unrelated key or automatic alternate-provider experiment.
See [certreq parameter/key association documentation](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/certreq_1)
and [SQL certificate creation and loading](https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/configure-sql-server-encryption?view=sql-server-ver16).

## 2. Practical custody and issuance route — proposed, not executed

**Recommended separation:** the owner nominates a trusted **offline signing workstation/session and
custodian**, separate from the SQL service, plus two protected offline storage locations. None was
demonstrated available in this inspection. Do not assume the earlier USB E: is mounted, encrypted or
reserved for CA custody. No private CA key in YSEDU's machine/user stores, SQL account, GitHub, Product
Memory, OneDrive or any project workspace. A local disk path outside Git alone is not adequate offline
custody. If only this host is available, return for an explicit custody/risk decision rather than silently
keeping the CA signing key online on it.

Proposed narrow tooling route, avoiding an AD CS service or a new package dependency:

1. On the approved offline issuer, verify equivalent .NET/PowerShell APIs first. Create the previously
   designed RSA3072/SHA256 CA **in memory**, with critical CA=true/pathLen0 and keyCertSign/cRLSign;
   export its recovery PFX using explicit **PBES2 AES256/SHA256**, not legacy/default PFX algorithms.
   Never export an unencrypted PEM private key. This host's API presence does not qualify that device.
2. Write encrypted signing material directly to the owner-approved protected, non-synchronized offline
   location, with a second encrypted recovery copy. Use a separately held high-entropy password via an
   interactive no-echo input, never command arguments, Git, environment logs, transcript or chat. Validate
   encrypted export/re-import on the issuer with ephemeral key storage before declaring custody ready.
   Password encryption does not protect a compromised issuer while the signing key is unlocked.
3. Generate **only the SQL leaf key/request on the SQL host**, in the approved machine legacy CSP.
   Send public PKCS#10 to the offline issuer. Validate its signature and subject/public key; sign with
   SHA256/PKCS1v1.5, unique recorded serial, 180-day validity inside the CA's proposed2-year lifetime.
   Apply the explicit approved SAN DNS:DESKTOP-8QRQT7R, Server Authentication, CA=false and usages.
   No blind extension copying, SkipSignatureValidation, arbitrary names or issuer-controlled server key
   export. .NET LoadSigningRequest with default validation and explicit extension allowlist is the
   proposed signing route; `certreq -sign` alone is **not** assumed a standalone ordinary CA issuer.
4. Return only public leaf/root DER/PEM and public manifest; accept the leaf against the host's original
   pending key with the native tool. Verify actual provider, KeySpec, key association, validity, signature,
   SAN and usages before binding. CA private PFX never returns to the SQL host. No leaf PFX required.
5. Dispose signing objects, lock/disconnect custody media and end the signing session. Do not promise
   managed-memory zeroization or filesystem secure erasure. Persist no CA key to Windows stores as part
   of this route. Public chain and fingerprints may be documented; custody paths/passwords remain private.

The API basis is [validated CSR loading](https://learn.microsoft.com/en-us/dotnet/api/system.security.cryptography.x509certificates.certificaterequest.loadsigningrequest?view=net-10.0)
and [explicit AES256/SHA256 PFX option](https://learn.microsoft.com/en-us/dotnet/api/system.security.cryptography.x509certificates.pkcs12exportpbeparameters?view=net-10.0).
This is an implementation procedure proposal, **not a written/tested issuer implementation**. No
CertificateRequest, RSA key, signing operation, export, store write or private-key extraction occurred.

**Retention/renewal responsibility:** the owner is accountable; a named nominated custodian performs
issuance, recovery-copy checks and renewal. Record public expiry/serial/hash and manual reminders45/30/7
days before leaf expiry; no automation was created. Renew using a new leaf key before expiry; rotate the
CA before remaining validity cannot cover the next leaf. Keep the encrypted CA/recovery copies until all
its issued leaves are retired and the owner approves destruction. A lost password/key prevents renewal,
not recovery by DBL; a compromised CA requires removal from the approved user trust and Node bundle plus
replacement, not reliance on a nonexistent automatic CRL service. No production revocation guarantee.

## 3. Current bounded file/service inventory

At22:01–22:06, MSSQL$YSEDU **Running / Automatic / LocalSystem / PID5072**; Browser **Stopped / Disabled**.
Certificate binding empty, ForceEncryption0, HideInstance0, TCP Enabled0, ListenOnAllIPs1 unchanged.
SCM query returned no listed recovery actions and non-crash failure-action flagfalse; refresh before
implementation. No service configuration changed. LocalMachine/My remains empty. Named process check
found sqlservr/sqlwriter, no GL/inv/pr/SSMS in that enumeration; **not SQL transaction/session proof**.

Read-only top-level C:\EFA inventory at22:02:27 (no recursive whole-disk search):

| File | Bytes | Observed LastWriteTime (+03:00) |
| --- | ---: | --- |
| EFA12026.mdf |25,755,648|2026-10-09 17:20:05|
| EFA12026.ldf |224,526,336|2026-10-09 17:20:05|
| DbRepDes.mdf |10,485,760|2026-09-01 17:12:39|
| DbRepDes.ldf |15,728,640|2026-09-18 21:54:43|
| Multi_Lang.mdf |29,753,344|2026-09-09 12:16:11|
| Multi_Lang.ldf |56,107,008|2026-09-18 21:53:29|
| EFAARC10.mdf |18,874,368|2026-09-02 18:08:17|
| EFAARC10_log.ldf |224,526,336|2026-09-02 18:08:17|
| DBL_HOST_W11_EFA12026_PostS2_Frozen_20261009.bak |25,350,144|2026-10-09 08:12:11|
| EFA001.bak |25,350,144|2026-10-09 17:19:39|

Ten observed files total **656,457,728 bytes (~626 MiB)**. Names/mtime do **not** prove attachment,
database identity, a committed business change, backup freshness/contents or causality. No .ndf/.trn
in this returned top-level listing; files elsewhere are not excluded.

- SQL instance `MSSQL\DATA` and `MSSQL\Backup` directory enumeration: **Access denied**, not absent/empty.
- Startup Parameters registry read: **Requested registry access not allowed**. Current master/model/msdb
  file paths and full startup -d/-l/-e values remain unverified. No ACL/UAC bypass or repeated escalation.
- Readable instance MSSQLServer key: BackupDirectory points to the protected Backup directory;
  DefaultData/DefaultLog properties returned blank, not proof of where all databases live.
- Known frozen MDF/log paths in the protected DATA directory and older RestoreProof are **historical**
  qualified SQL evidence, not newly observed filesystem/catalog state.
- No authenticated SQL query or new connection was attempted; the prior strict certificate failure
  remains. Current sys.databases/sys.master_files, active transactions, reader login/grants and frozen
  READ_ONLY cannot be established by these probes. No insecure inventory route.
- Current volume listing has C: and D: fixed NTFS plus an unlettered fixed volume, **no E:**. At22:01
  C free17,404,055,552 / D17,562,300,416 bytes; later C17,412,001,792. Storage changes are observations,
  not this task's data write. BitLocker status read denied, so encryption is unverified. Visible subset
  fits available space; **no full-instance capacity/off-host recovery budget proven**.

## 4. Known restore points, integrity and loss boundaries

| Artifact | Current/historical proof | Coverage limit |
| --- | --- | --- |
| post-S2 backup in C:\EFA |Fresh SHA256 **E63DF84D2DBB22C5ACD535DC5881D2DCF417F420665502927EBD9AD66731E572**,25,350,144 bytes, matches prior record |One EFA12026 image, not all databases/system logins/frozen grants |
| EFA001.bak |Fresh SHA256 **60A5BA6B5DD116FBCE255551C0573ADD7FA93088680DF1C8ADCBE538262E96C0** |Unknown backup DB/set/checksum/restore validity; not a newly qualified recovery point merely because later mtime |
| PreMutation20261006 .bak in protected Backup |Read denied now; historically22,663,168 bytes/SHA2821DDAA854FBC3EA0FFC015F933654D02BC03C952044C586A275B719A391722 |Older clean baseline, **not S2 recovery**; fresh presence/hash not established |

The accepted [post-S2 qualification](MOTAKAMEL_HOST_W11_POST_S2_FROZEN_READER_QUALIFICATION_2026-10-09.md)
records COPY_ONLY/CHECKSUM, backup set1012/UUID2b9d2bde-8d89-4ee7-98de-224fb97060c7,
**08:12:11+03:00** start/finish, VERIFYONLY, independent restore08:12:12.160 and CHECKDB success.
Fresh matching bytes retain that historical restore proof; **no VERIFYONLY/restore/CHECKDB rerun now**.
Source EFA12026 ID7, RestoreProof ID9 and frozen ID10 were ONLINE, frozen READ_ONLY in the08:17 evidence.
These three historical states are not a complete current instance catalog.

**Known recovery fallback:** preserve the hash-matched08:12:11 EFA12026 backup and qualification manifest;
after separate recovery authorization restore it into a new, non-conflicting DB/file path with MOVE,
CHECKSUM/VERIFY/CHECKDB and reconcile S2 ItemA/37/SAR3700. Do not overwrite/drop a current DB or use WITH
REPLACE automatically. This restores the source image as of the backup boundary, **not** the later
independent reader login in master, clone-only grants or the whole application/support state. Rebuilding
those administrative objects would require separately approved recovery, not connector privileges.

Potential rollback loss window is **08:12:11 → future shutdown/recovery** (already ~13h54 at22:06).
Later file timestamps and EFA001.bak cannot quantify actual business changes/loss. No log-backup chain or
system/support-database recovery was demonstrated; no zero-loss/PITR claim. Configuration rollback normally
needs **no database restore**, but that distinction does not qualify comprehensive disaster recovery.

**Recovery coverage is insufficient for an unqualified whole-instance interruption approval.** Before GO,
obtain elevated **read-only** startup/DATA/Backup/file inventory and a recovery destination/capacity check;
ideally a qualified current whole-instance recovery boundary through a trusted channel or approved image
mechanism. If still unable to prove catalog/completeness, owner must explicitly accept the known-EFA-only
fallback and unknown other-database/system-metadata loss exposure for this experimental host. It is not
silently accepted by “lab only.” No new backup, image, file copy or restore is authorized/executed here.

If owner authorizes the bootstrap outage with that limit: normal stop first; **only after confirmed
Stopped**, capture every independently inventoried persistent MDF/NDF/LDF, system DB, relevant settings
and approved key/config material to a new protected recovery destination, hash and retain paths/ACL
metadata before binding. Exclude regenerated tempdb files from a persistent-data restore claim. Such a
post-stop copy preserves known committed recoverable state, **not** unknown omitted files or work rolled
back during shutdown. Live locked MDF copying is not a valid SQL backup. Unknown inventory is not cured
by calling an incomplete directory copy “full-instance.”

## 5. Future maintenance sequence and interruption effects

**Not executed; fresh independent approval required.** Preserve current network/TLS flags and all unrelated
certificates. Outage affects **every DB/client on MSSQL$YSEDU**, not only the frozen clone; Browser/other
instances remain untouched. Connections drop; open work may be rolled back, recovered DBs may need time
to come ONLINE. READ_ONLY/state after restart cannot be inferred now.

1. Resolve custody, inventory/recovery and explicit experimental outage-risk acceptance above. Identify
   the elevated Windows operator separately from the Node reader. Prepare reviewed certificate-only
   rollback and protected original-settings/public-store/key-ACL manifest, with exact absent-versus-empty
   registry value, types and targets; do not reuse the network applying rollback.
2. Prepare public CA/leaf artifacts and machine pending key only within separately approved issuance
   scope. Installing a matching leaf while SQL runs can affect the next unplanned restart, so defer its
   acceptance into LocalMachine/My until the controlled stopped interval. Root signing remains offline.
3. Freeze experimental work; close known ERP/SQL clients normally. Prefer a demonstrated strict trusted
   maintenance channel and current session/transaction/catalog report if one appears. Otherwise state
   visibility failure and accepted risk; repeat process/service observations immediately before shutdown,
   **not** as substitute transaction proof. No forced client/session termination.
4. Gracefully stop **MSSQL$YSEDU only**. Proposed120-second observation bound: StopPending/timeout → STOP,
   operator escalation, no kill/Force/reboot or certificate edits until confirmed Stopped. Never copy files
   believed offline while sqlservr still owns the instance. Perform approved offline recovery capture.
5. While Stopped, accept only the qualified new leaf into LocalMachine/My, verify provider/KeySpec and
   SYSTEM access to its **specific** private key. Add no ACL if already sufficient; any required key-only
   SYSTEM grant must be independently enumerated/approved. Bind YSEDU via existing Configuration Manager
   to exact new thumbprint, record original/new values; no registry workaround if UI rejects it.
6. Import **public root only** into the actual maintenance user's CurrentUser/Root in that user's context,
   not a different elevated-admin user's store. No LocalMachine Root/import of private CA. Installed-tool
   chain/loading rejection requiring broader trust → STOP for new authorization, not automatic root import.
7. Start YSEDU normally once; proposed120-second observation bound, retain startup/system/error evidence.
   A Running service alone does not prove leaf selection, correct DB recovery or strict TLS.
8. Under explicitly authorized maintenance verification, actual `Encrypt=true / TrustServerCertificate=false`
   Windows channel must verify host/instance/peer certificate, session rights, all visible/expected DB
   states, frozen READ_ONLY and bounded S2 facts. Expected invisible/offline DBs require full catalog rights,
   not a filtered list. Fail any check → stop further enablement and evaluate certificate rollback.
9. No network enablement, credential rotation or live DBL test is bundled. Once maintenance is trusted,
   fresh activity checks are required immediately before any subsequent independently approved restart.

## 6. Certificate-specific rollback — correction to the earlier design

**Material clarification:** restoring an empty binding alone may be insufficient. SQL can auto-select an
eligible machine-store certificate even when not explicitly selected. [Microsoft documents selection
precedence](https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/configure-sql-server-encryption?view=sql-server-ver16).
This is a documented risk, not an observed auto-selection on this host.

If the new certificate fails loading/startup or strict qualification:

1. Retain logs/public manifest; confirm YSEDU is Stopped (normal stop if running, with the same timeout rule).
   No restart loop, Force stop, rollback of other services, data restore or TLS bypass.
2. Restore **only YSEDU's captured Certificate property's original exact state** (currently empty; refresh
   its existence/type before change), preserving ForceEncryption/HideInstance/TCP/Browser and other settings.
   Prefer the qualified Configuration Manager removal; if a direct original-value rollback is necessary,
   it must be pre-reviewed for the exact mapped32-bit YSEDU target, not both registry views.
3. Prevent new-leaf auto-selection **before** restarting: remove only the exact newly installed leaf's
   certificate entry from LocalMachine/My, after confirming identity and no other consumer. Retain its
   public DER and private key/container; **do not use DeleteKey or a wildcard**. The certificate provider
   documents [certificate-only removal versus private-key deletion](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.security/about/about_certificate_provider?view=powershell-7.5).
   Removing the certificate entry leaves the key, so non-exportability does not force destructive key
   cleanup. Future key reassociation/removal needs separate review; do not promise automatic reinstallation.
4. Restore only a changed new-key ACL from its capture; remove only the newly added public CA from the
   maintenance user's Root if absent before installation. Keep all preexisting certificates/trust untouched.
   Do not copy the CA key online, delete the key directory or revoke unrelated SYSTEM permissions.
5. Start YSEDU normally once, inspect service/recovery evidence and compare known settings. The former
   fallback behavior may return; it is operational rollback **not trusted maintenance/Node readiness**.
   Without a trusted catalog, report recovery limits rather than asserting all databases equal/ONLINE.
6. If original configuration still cannot start, STOP and escalate for a separately authorized recovery
   action; no automatic database replacement, attaching arbitrary MDFs or restoration of a live directory.
   Failed public-root cleanup is reported independently, not hidden behind the startup error.

Original network artifacts remain intact and freshly hash-matched: ORIGINAL_SETTINGS.json
**E1BA78C819F348EC3D84FD8FC65178481D955340683238BD3AD92C3939F6005E**;
Restore-YseduNetwork.ps1 **732298D06C12AF89AFDFC08082FF31369D4437712F04AEC34CA3FB44ECFC70AA**.
That utility deliberately refuses certificate drift; **not a certificate rollback tool**. No applying
rollback or new rollback script was tested; the sequence above is an exact scoped plan, not an executed
recovery guarantee. A later implementation must review its actual target-specific commands before use.

## 7. GO/NO-GO and independent execution approvals

| Gate | Decision |
| --- | --- |
| Owner CA/leaf + Windows additive/Node exclusive design |ACCEPTED IN PRINCIPLE; no longer the old trust-scope decision gap|
| Existing tools/legacy provider/API capability |AVAILABLE; actual issuance/import/loading NOT TESTED|
| CA custodian, offline issuer, two protected copies/password ownership |NOT ESTABLISHED; owner must designate privately|
| Known post-S2 backup |HASH VERIFIED now + prior restore/CHECKDB proof retained|
| Current full-instance inventory/recovery coverage |PARTIAL / INSUFFICIENT; protected paths/startup inaccessible, current SQL catalog unknown|
| Transactions/restart safety |NOT PROVEN; requires trusted evidence or explicit bounded outage-risk acceptance|
| Certificate implementation / SQL interruption now |**NO-GO**|

**Smallest next step:** owner/elevated operator supplies read-only protected startup/DATA/Backup inventory
and confirms an off-host protected recovery destination, while designating the offline issuer/custodian.
No certificate/key creation is needed for that next gate. If catalog remains inaccessible, decide explicitly
between a qualified current recovery mechanism and the narrower known-EFA-only experimental-risk fallback.

The following are separate **execution** decisions, not granted here: CA issuance/custody/export-recovery;
host leaf key/CSR and leaf import; narrowly necessary new-key SYSTEM ACL if needed; public maintenance-user
Root addition; exact YSEDU binding; graceful stop/start with declared loss/recovery policy and approved
offline capture; certificate-only rollback/root removal and subsequent strict maintenance verification.
Any machine-wide Root trust, different provider/algorithm/name, broader ACL, network/security adjustment,
login/password/grant change, data restore or live Node/connector test requires a distinct approval.

Only this report and README are edited/committed. Prior qualification artifact SHA remains
**7D742175B6652860C7974115F8A1CBB789F49D86ACAD4FC5DD40CFCE310E7BAC**. No issuance/key creation,
private export, import, trust/binding/permission/network/TLS/service/SQL/ERP change, backup/copy/restore,
live connector run or business query. No byte-for-byte current business-state preservation claim without
SQL evidence. `.vscode` stays outside commit. **STOP before implementation.**
