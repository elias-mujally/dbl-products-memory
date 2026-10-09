# Host W11 — Minimal encrypted recovery archive design

Date: **2026-10-09**. Accepted baseline: **37da337**, [E: qualification/protection](MOTAKAMEL_HOST_W11_EXTERNAL_RECOVERY_DRIVE_E_QUALIFICATION_2026-10-09.md), [elevated known-path inventory](MOTAKAMEL_HOST_W11_ELEVATED_RECOVERY_INVENTORY_2026-10-09.md#6-operator-returned-elevated-inventory--2236-update), and [certificate recovery/rollback gate](MOTAKAMEL_HOST_W11_YSEDU_CERTIFICATE_IMPLEMENTATION_READINESS_RECOVERY_GATE_2026-10-09.md).

**DESIGN COMPLETE — EXECUTION NO-GO until the remaining gates below.** This is a one-time laboratory preservation plan before YSEDU certificate maintenance, not a backup product or PKI project. No archive, staging directory, key, passphrase, SQL copy, test ciphertext or restore was created. No SQL interruption or Windows/security/network change occurred. S2 remains LAB-PROVEN; S3 frozen/accounting-blocked; live connector NOT TESTED.

## 1. Selected technique and actual tool evidence

**One relative-path TAR package, symmetrically encrypted with installed GnuPG 2.4.9 using AES-256/OCB AEAD.** Store only the ciphertext plus a small non-sensitive receipt on E:. No OpenPGP key generation/keyring enrollment, certificate or CA is needed. The archive password is the recovery secret.

Read-only capability inspection around **23:40–23:43 +03:00**, DESKTOP-8QRQT7R:

| Tool | Actual observation / limit |
| --- | --- |
| Windows TAR | `C:\Windows\System32\tar.exe`, **bsdtar/libarchive 3.7.7** from `--version` |
| GnuPG | `C:\Program Files\Git\usr\bin\gpg.exe`, **2.4.9**, libgcrypt **1.12.2-unknown** from `--version`; options include force-ocb, AES256, S2K controls, no-symkey-cache, pinentry-mode |
| Password entry support | gpg-agent.exe, gpgconf.exe, pinentry.exe and pinentry-w32.exe exist in that Git directory; actual hidden-entry/encrypt/decrypt behavior **NOT TESTED** |
| Distribution | `git version 2.54.0.windows.1`; this is the existing installation, not a new installation |
| Metadata/hashes | Get-Acl/Get-FileHash available; native icacls/robocopy help inspected only |
| Other candidates | age/rage/rclone/7z not resolved on PATH; checked standard 7-Zip path absent. This is a bounded search, not proof of global absence |
| OpenSSL | Bundled `usr\bin\openssl.exe` **3.5.6**, not on PATH. Not chosen: `openssl enc` lacks AEAD support ([official documentation](https://docs.openssl.org/3.5/man1/openssl-enc/)) |

Binary observation SHA256, **not vendor authenticity attestations**:

```text
gpg.exe A5140C85353E8399DA8D6BD7E3741524CD76A4E69BE88AF12042B1C9EF022984
tar.exe 92FAFED485AF0FE4C291457DC3C00D0241F6A136731BAB63EF18A3F0C949D37A
```

Get-AuthenticodeSignature for gpg.exe returned **NotSigned**. Its version/options and these local hashes prove availability, not trustworthy supply-chain provenance or absence of vulnerabilities. Before use, the operator must confirm the existing Git distribution's approved origin and retain a trusted matching decoder distribution/dependencies; do not treat one copied unsigned EXE as a qualified standalone recovery tool. The `-unknown` library suffix is recorded, not interpreted as a security verdict. No download/install or package replacement occurred.

The [GnuPG 2.4 manual](https://gnupg.org/documentation/manuals/gnupg24/gpg.1.html) documents force-ocb as AEAD, explicit symmetric cipher/S2K controls, Pinentry and disabling symmetric-key caching. Proposed profile: AES256, force-ocb, salted iterated S2K mode3/SHA256/count65011712, no compression, no-symkey-cache, no inherited options and a private session homedir. No fallback to MDC, CBC-only encryption, ZIP password or older compatibility mode. Same-profile decoding must be qualified; do not claim universal OpenPGP interoperability. S2K is not memory-hard: use a password-manager-generated secret with **at least128 bits of random entropy**, not a memorable account password. Authentication does not establish sender identity against someone who knows that secret.

Future profile example only, **not executed**, with no secret argument:

```text
gpg --no-options --homedir <private-session-dir> --no-symkey-cache
    --pinentry-mode ask --cipher-algo AES256 --force-ocb
    --s2k-mode 3 --s2k-digest-algo SHA256 --s2k-count 65011712
    --compress-algo none --symmetric --output <new-E-ciphertext.partial> <private-NTFS-package.tar>
```

## 2. Scope: known laboratory files, not an invented complete image

Refresh the accepted administrative inventory into an exact file allowlist before capture. Known database candidates are:

- `C:\EFA`: EFA12026, DbRepDes, Multi_Lang, EFAARC10 data/log pairs.
- `C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.YSEDU\MSSQL\DATA`: frozen PostS2 pair, RestoreProof pair, master/mastlog, model/modellog, MSDBData/MSDBLog.
- Instance `Binn`: matched Resource database pair with SQL engine/build identification; retain, do not attach it as a user database.
- Three inventoried .bak files, including the qualified post-S2 image and its proof/hashes; EFA001 retains its unresolved backup semantics.

This is **20 persistent database-file candidates +3 existing backups**, excluding the two regenerated tempdb files: **1,278,906,368 bytes /1.191074 GiB** at the previous inventory. No new SQL backup is proposed. Current authenticated attachment/catalog and unknown external NDF/FILESTREAM paths remain unproved. Inventory differences, unreadable files, reparse points, EFS or alternate streams must stop capture for scope review, not be silently skipped or dereferenced. Do not assume this list covers every attached database.

Add only bounded laboratory recovery metadata: exact startup -d/-l/-e values, mapped instance/registry view and value types/absent-versus-empty states; relevant YSEDU network/certificate flags; service account/start mode/binary path/dependencies/recovery actions; Browser state for comparison only; SQL2014 architecture/build; existing network-original/rollback artifacts and accepted S2/frozen-reader proof. Retain appropriate original configuration and error-log evidence. Proposed registry exports are narrow to YSEDU/mapping/service keys, not whole registry hives; they are evidence, not a blindly imported rollback. No other instance, Windows credential-store dump, private CA key or new TLS material is in scope.

Preserve already-created DBL evidence/local artifacts necessary for the S2/reader proof using explicit paths. Remote Git commits alone are not a local-artifact recovery inventory. Uncommitted project changes or an undiscovered application configuration require explicit enumeration, not indiscriminate project/home-directory capture. No passwords are extracted. If an essential application secret/key is discovered, STOP for separate custody approval.

master plus frozen clone files aim to retain instance login/SID state and clone grants together, but this is **not** proof of restored reader authentication. Machine-bound Service Master Key/DPAPI, service identity, SQL version and unmapped paths limit portability. This is principally same-host/same-build laboratory recovery, not bare-metal or different-machine recovery. A separately qualified restored SQL environment is needed to prove logins/grants/READ_ONLY/S2 after disaster.

## 3. Paths, NTFS metadata and secret handling

Use a **new owner-approved private NTFS staging and verification root**, outside Git/OneDrive/project workspaces, with no inherited broad user access. Confirm its actual ACL first; creating/hardening that temporary root needs later execution approval, never alter source SQL ACLs to obtain access. No plaintext recovery files or manifest on unencrypted E:. C:/D: are also unencrypted in accepted evidence; restrictive ACLs are not at-rest encryption. Explicitly accept the bounded plaintext-staging exposure or STOP; this design does not invent a secure-erase guarantee.

Package has two relative roots: `payload/` with collision-free drive/path mapping and `metadata/`. Internal manifest records each exact original path, archive-relative path, bytes, SHA256, UTC times, attributes, file role and source evidence; also the required source-directory chain. Record owner/group SIDs, DACL/inheritance/protection and SACL/integrity data where readable using Get-Acl/-Audit and complete SDDL. [Get-Acl documentation](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.security/get-acl?view=powershell-7.5) distinguishes audit retrieval. **icacls /save alone is insufficient:** installed help expressly excludes SACLs, owner and integrity labels; its [documented /restore](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/icacls) applies DACLs only. If full sections cannot be read, record that fact and obtain acceptance or STOP; never claim complete ACL preservation.

TAR is the content container, **not** the NTFS security-descriptor authority. Restore metadata explicitly on approved NTFS targets, directory chain first, then files, checking inheritance and SID resolution. Foreign-host/unresolved SID or missing SACL rights is a recovery gate, not permission to grant Everyone/full-control. exFAT only holds opaque encrypted bytes.

Password entry is by the owner in **private native Pinentry** outside chat/tool-output capture, transcripts and screen recordings. No command argument, environment variable, password file, clipboard logging or console echo. Use a dedicated session homedir/agent and disable symmetric caching; terminate only that session's agent afterwards, not unrelated agents. Behavior requires the synthetic test below. Store the recovery secret in an owner-controlled password manager plus an independently held offline recovery record, not on E:, the SQL host/project, GitHub or Product Memory. No extra recovery key/PKI is required. Loss of both secret records means loss of archive access; a compromised host can expose plaintext while processing.

## 4. Later execution sequence — separate approval required

1. **Before interruption:** qualify existing-tool provenance/decoder availability, actual crypto profile/Pinentry with synthetic non-business files, negative tests and metadata round-trip. Confirm custodian/secret recovery record, fresh E: Disk1 mapping/free space, private staging/test paths and exact allowlist. Confirm storage budget: staged payload + original TAR + decrypted quarantine TAR + verification extraction require about **4× refreshed scope plus metadata/headroom on NTFS**, and ciphertext plus overhead on E:, without relying on compression. Historical1.43GiB is not this total budget.
2. **Explicit outage decision:** close ERP/SQL clients normally. Prefer fresh trusted catalog/activity evidence if available; no TLS bypass. If still blocked, owner must explicitly accept unknown catalog/open-transaction/rollback exposure and the bounded known-file capture. “Lab only” is not that consent. Stop/start/abort permission must be explicit. No forced session/client termination.
3. **Normal stop of MSSQL$YSEDU only:** proposed120-second observation bound; StopPending/timeout/failure → stop the procedure, no kill/Force/reboot. Confirm actual Stopped and that no running instance process owns the identified files. No live MDF/LDF copying. Do not change Browser or another instance. Microsoft's [system-file maintenance procedure](https://learn.microsoft.com/en-us/sql/relational-databases/databases/move-system-databases?view=sql-server-ver16) stops SQL before copying and distinguishes regenerated tempdb; this does not turn this plan into a SQL-native backup.
4. **While confirmed stopped:** refresh exact persistent-file list, settings and security metadata; hash every allowlisted source; copy only those files to new NTFS staging via existing native tools, bounded retries, no /MIR,/PURGE,/MOV or broad root copy. Compare stage/source hashes and repeat source hashes after copy; any change/missing/unreadable file fails. Stable stopped-source bytes define the capture boundary; pre-stop hashes of mutable DB files do not. Do not mutate business/source security data.
5. Build relative-path TAR containing only verified payload/metadata. Treat every TAR error/missing entry as failure. Encrypt to a unique new E: `.partial` path after confirming it does not exist; never overwrite existing archives. Require actual AES256/OCB profile proof from the synthetic qualification and sanitized packet/status evidence, not option presence alone. Check encryption exit status, reread full ciphertext and compute SHA256; do not label `.partial` valid yet.
6. **Full verification before certificate work:** decrypt E: ciphertext into a new private NTFS quarantine TAR; consume the entire message and require successful authenticated decryption before listing/extracting. Never pipe unauthenticated partial plaintext into extraction. Compare TAR bytes/hash, then reject absolute/drive-qualified/parent-traversal/link/duplicate/unexpected members. Extract only to a new quarantine root; match every payload and metadata hash/count/length against the source manifest, including expected directory metadata. No SQL attachment or overwrite is part of this test.
7. On success, finalize to a unique `.tar.gpg` plus small receipt (ciphertext digest, scope count/bytes, profile/tool versions, result, capture time; no raw sensitive manifest/secret). Record receipt/hash separately in Product Memory so replacement on E: is detectable against that anchor. Validate independent password recovery after restarting only the scoped GPG session, with no cache dependency. Exact-session cleanup and removal of only owned plaintext test/staging files need later approval; retain protected staging on failure rather than broad deletion. Secure erasure is not promised.
8. **Only under separate stop/start authorization:** restart original unmodified YSEDU and observe operational recovery; otherwise hand control to the operator. Certificate maintenance is another approval/gate, not automatic after archive success. A Running service is not proof all DBs/login/grants recovered. Disconnect/store E: under owner custody after verification; a single USB remains a single-copy risk.

## 5. Verification, restore and abort criteria

Before SQL shutdown, a later authorized **synthetic-only** test must cover: hidden password entry/confirmation; AES256/OCB packet profile; full decrypt; wrong password; corrupt/truncated synthetic ciphertext rejected; contents/hash/count equality; NTFS owner/DACL/SACL/inheritance round-trip to isolated targets. Test the actual build on the recovery workstation, not merely a different mock/library. Unsupported profile, unsigned-tool provenance unresolved, missing privilege or any ignored failure → NO-GO. No such test ran in this design turn.

For real archive verification, success means **AUTHENTICATED ARCHIVE + FILE/METADATA COMPLETENESS within the declared allowlist**, not SQL restore proof. Empty password, auth error, missing file, hash mismatch or metadata gap fails the gate. Partial plaintext from a failed decryption is quarantined and never consumed. Outer SHA256 is an integrity anchor, not a substitute for AEAD or proof that omitted files exist.

Restoration first repeats decrypt/hash/member/metadata verification into a **new NTFS quarantine**, with no database overwrite. For actual recovery, require separate authorization and target-specific same-build SQL review: user backup restore can use new DB/file names plus VERIFY/CHECKDB/S2 reconciliation; system/master recovery must follow its distinct supported process, never attach Resource or blindly overlay a running instance. Restore exact approved paths/security only while the appropriate instance is stopped and preserve originals independently. Confirm reader login/SID/grants and frozen READ_ONLY via a strict trusted maintenance channel, then S2 ItemA/Warehouse1/UA/Package1/37/SAR3700. Until that succeeds, **DATABASE RESTORE QUALIFICATION = NOT TESTED for this archive**. The historical08:12:11 post-S2 .bak proof remains a narrower fallback, not proof of whole-instance or later grants recovery.

Abort: retain sanitized reason and exact newly created `.partial`/quarantine paths; no overwrite/restore/format/ACL reset. If SQL was stopped, original files/settings are untouched: use the previously approved normal start once, not a restart loop or forced recovery. Capture failure prevents certificate maintenance. If original start fails, STOP for explicit recovery authority. Archive/design itself requires no TLS/config rollback; later certificate rollback remains the separate accepted readiness plan. No source file deletion is a rollback step.

Remaining risks: unresolved external/catalog files; work rolled back at shutdown; undetected pre-existing DB corruption; machine-bound secrets/permissions and install dependencies; plaintext staging/pagefile/crash remnants; compromised operator host/weak or lost secret; interrupted USB write/exFAT metadata failure; one external copy; decoder portability not yet tested. Encryption reduces confidentiality/tamper risk, not these recovery-completeness risks.

## 6. Decision and exact remaining owner gates

**Recommended technology available; design complete; capture/protection/restore remain NOT QUALIFIED.** Before implementation: confirm trusted installed-tool distribution and independent decoder; approve synthetic tests/private temporary NTFS paths and their exposure/cleanup; nominate secret custodian; freeze exact recovery scope and explicitly accept remaining catalog/transaction limits or obtain trusted evidence; independently authorize graceful YSEDU stop/capture/abort-start; qualify actual archive after capture. No new tool development or installation is the default path.

Only this report/README documentation changed. Version/help/option/metadata reads and public primary-source research occurred; no encryption/decryption, agent/password interaction, SQL copy/backup/restore, CA/key generation, service stop/start, TLS/network/Windows/ERP change or E: write. `.vscode` excluded. **STOP — do not execute the illustrated profile or capture sequence.**
