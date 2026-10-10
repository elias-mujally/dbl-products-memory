# Host W11 — Bounded Real Recovery Capture #001

Date: 2026-10-10. Prior qualified procedure: Product Memory `cab9540`.

## Resumption — 2026-10-10

**Current decision: BLOCKED BEFORE SHUTDOWN — DECODER COPY NOT YET RETAINED.** This supersedes the missing-secret reason at checkpoint `527edf0`, without changing the accepted capture procedure or repeating successful synthetic tests.

The owner confirmed a newly generated strong random recovery secret, available through a password manager from another device and also recorded on external paper. **Independent secret custody = OWNER-CONFIRMED**; its value and entropy were intentionally not observed or requested. Do not ask the owner to regenerate or disclose it.

The owner first identified E: for decoder retention, then explicitly clarified: **«سأضعها لاحقا ولم انسخها بعد»**. Therefore **Independent Decoder Retention = NOT READY**, not a verified existing copy. E: can hold the public qualified decoder distribution independently of Disk0; co-location with the encrypted archive remains within the already accepted single-external-copy risk. No additional off-E copy is silently imposed as a new gate.

At **2026-10-10T16:42:02.2366841+03:00**, the ordinary agent token was `DESKTOP-8QRQT7R\user`, Elevated=false. Installed GPG, TAR and native Pinentry still matched all three published hashes below. `MSSQL$YSEDU` returned Running / Automatic. E: was again Disk1, distinct from C:/D: Disk0, exFAT/Healthy, with139,640,832,000 free bytes. C: NTFS had35,925,835,776 free bytes at the storage refresh. Space does not qualify a retained decoder or a real archive.

A single top-level E: name/metadata listing located no obvious decoder package. No personal directory was traversed or personal file read. This listing alone did not prove absence; the owner's explicit clarification establishes that the intended decoder copy has not yet been made.

Known qualified decoder package from the accepted synthetic evidence:

- Full distribution: `Git-2.54.0-64-bit.tar.bz2`, **116,824,890 bytes**; retain the distribution and its dependencies, not only unsigned `gpg.exe`.
- Qualified package SHA-256: `E1819CEE60D09793DDE322CDB1170E03663C41CD9265CF45246219FC5E6AEECD`.
- Recorded official asset: `https://github.com/git-for-windows/git/releases/download/v2.54.0.windows.1/Git-2.54.0-64-bit.tar.bz2`.
- Installed qualified GPG member SHA-256: `A5140C85353E8399DA8D6BD7E3741524CD76A4E69BE88AF12042B1C9EF022984`.

These package/source values come from the already qualified report, not a new download or an independently tested recovery workstation in this turn. The prior public asset was processed in memory only; it was not a retained decoder copy. Retain the public digest and the qualified decoding/validation instructions with the tools, anchored separately in Product Memory.

Next step is owner placement of that distribution/instructions at an exact E: path for read-only hash qualification, or explicit permission for a narrowly scoped public-tool download into a new E: folder with no installation/overwrite. No public-tool write to E: was assumed from authorization to write the encrypted real-data archive. Only after decoder retention passes may the remaining security/settings/private-stage gates and the already authorized capture sequence proceed.

No Pinentry, ERP closure, SQL stop/start, real-data staging/copy, cryptographic execution, source ACL modification, E: write or cleanup occurred in this resumption. Real archive location/SHA remain none; SQL RESTORE NOT TESTED. The 23-file metadata evidence below is the prior operator preflight, not a newly repeated administrative run. No unchanged-live-source-bytes claim is made. S3 remains frozen and Live Connector NOT TESTED. **STOP before outage.**

## Previous checkpoint 527edf0 — Decision

**OWNER AUTHORIZATION ACCEPTED — BLOCKED BEFORE SHUTDOWN / REAL CAPTURE NOT STARTED.**

The owner explicitly authorized the bounded real capture, graceful stop/start of `MSSQL$YSEDU` only, private NTFS staging, encrypted E: archive and isolated verification. The owner accepted incomplete catalog/transaction visibility, possible rollback of uncommitted experimental transactions, plaintext staging/remanence, a single external copy and the distinction between archive verification and SQL restore proof. These accepted risks do not require another design round.

The owner subsequently answered: **«لا, لم اجهز كلمة استرجاع»**. Independent retention of decoding tools/instructions is also unconfirmed. This is an explicit pre-shutdown STOP condition; no Pinentry, private real-data staging, ERP closure, SQL stop, real data copy or E: write followed.

## Evidence read and fresh preflight

The accepted Recovery Inventory, Minimal Encrypted Recovery Archive Design, Synthetic Archive Qualification and Final Recovery Capture Safety Qualification reports were reread. Synthetic qualification remains synthetic only; it does not prove a real capture or SQL recovery.

An ordinary agent token could not substitute for an administrative Windows session. The owner manually ran the bounded read-only helper in an administrative PowerShell session; no automatic elevation, UAC bypass or source ACL change was used.

- Helper executed by owner: `outputs/host-real-recovery-capture-001-20261010/Read-Capture001Preflight.ps1`.
- Executed helper SHA-256: `8797AC90621F4584E403AE537C556ACE86891BF7338E6AD275FCBAC055DA0340`.
- Retained nonsecret source: [read-only preflight helper](research/REAL_CAPTURE_001_READONLY_PREFLIGHT_2026-10-10.ps1).
- Retained source SHA-256 before Git newline conversion: `512253DA8BB369301CDC5A12714035F14CA677A4E2F25B381294AD6FD2512E32`. It differs from the executed helper only in trailing whitespace; code equality after trimming that whitespace and PowerShell syntax were checked. This is not a claim of byte-identical retention.
- Owner result observed at **2026-10-10T16:05:41.9993581+03:00**, host `DESKTOP-8QRQT7R`, operator `DESKTOP-8QRQT7R\user`, `Elevated=true`.
- Decision returned: `ADMINISTRATIVE_FILESET_PREFLIGHT_PASSED_SECURITY_METADATA_PENDING`.
- Exactly **23 allowlisted files / 1,278,906,368 bytes**: persistent SQL data/log/resource files plus three existing backups. `tempdb.mdf` and `templog.ldf` were explicitly excluded.
- All returned file attributes were `32`, and enumerated streams were only `:$DATA`. Owner and DACL-protection metadata were read; file contents and live MDF/LDF hashes were not read.
- The bounded top-level scan found no additional SQL-extension file outside the allowlist. Child directories were listed, not traversed. This is not proof of a complete SQL catalog or every external file dependency.

Full SDDL/SACL, required parent-directory metadata and hardlink qualification remain **PENDING**. The returned owner/protection flags are not evidence that those later gates passed, nor proof of SQL integrity. The helper does not collect business contents or a database catalog.

## Storage and tools

The owner's current volume/partition result identifies C: and D: on Disk 0 and E: on Disk 1, so E: is physically separate from both source volumes within this inventory.

| Volume | Filesystem / reported health | Free bytes at owner preflight |
|---|---|---:|
| C: | NTFS / Healthy | 35,956,252,672 |
| D: | NTFS / Healthy | 17,562,300,416 |
| E: | exFAT / Healthy | 139,640,832,000 |

E: total capacity: 251,647,754,240 bytes. For the observed allowlist, the helper calculated NTFS temporary minimum **6,407,186,023 bytes** and ciphertext minimum **1,803,123,098 bytes**. Space is sufficient for that estimate, not a full recovery-coverage or write-integrity proof. No E: write test or BitLocker change was performed.

The currently installed binaries matched the previously qualified hashes:

- GnuPG: `C:\Program Files\Git\usr\bin\gpg.exe` — `A5140C85353E8399DA8D6BD7E3741524CD76A4E69BE88AF12042B1C9EF022984`.
- TAR: `C:\Windows\System32\tar.exe` — `92FAFED485AF0FE4C291457DC3C00D0241F6A136731BAB63EF18A3F0C949D37A`.
- Pinentry: `C:\Program Files\Git\usr\bin\pinentry-w32.exe` — `95A49C7B02CFA93DFDEC7F7E122D703E6A6003B2AE064B0EB61C22AB7C79410D`.

No new installation or cryptographic execution occurred in this preflight.

## Service evidence and execution boundary

The owner result identifies `MSSQL$YSEDU`, LocalSystem, automatic startup, PID `5072`, Running, with the approved `MSSQL12.YSEDU\MSSQL\Binn\sqlservr.exe -sYSEDU` executable. Startup arguments point to that instance's `master.mdf`, `mastlog.ldf` and `Log\ERRORLOG`. An independent ordinary-token service read at **2026-10-10T16:06:02.5108381+03:00** again returned Running / Automatic.

| Requested result | Current result |
|---|---|
| Real capture / verification | NOT STARTED; BLOCKED BEFORE SHUTDOWN |
| Encrypted archive location | None created |
| Encrypted archive SHA-256 | Not applicable |
| Scope | 23-file metadata allowlist checked; full security/settings gates pending |
| SQL service after this task | Running / Automatic at last read; never stopped or restarted by this task |
| SQL restore | NOT TESTED |
| Real SQL/ERP data copied | None |
| E: writes / temporary data cleanup | None / none needed |

No SQL connection, business write, source ACL change, certificate/TLS/network/Browser/firewall change, service mutation or ERP UI action was executed. The SQL engine remained live and can change its own files: this task does **not** assert unchanged source bytes or business-row fingerprints.

## Remaining gate and resumption

First, the owner must prepare a new strong random recovery secret, retain it independently under their control, and confirm independent access to qualified decoding tools/instructions. Never send the secret in chat, arguments, logs, Git or Product Memory. Pinentry has not been opened.

After that confirmation, resume the already authorized single procedure, with fresh mutable checks, and close the remaining preflight gates: full security/parent/hardlink metadata, exact settings/local-evidence allowlist, private NTFS root ACL, normal ERP closure, then the bounded stop/capture/authenticated verification/start sequence. An administrative execution channel remains operator-controlled; the agent's token is not administrative.

Do not skip pending gates or interpret the successful metadata helper as `REAL CAPTURE VERIFIED`. No further investigation or execution was performed after the custody STOP. No product scope, S3 or Live Connector qualification changed. `.vscode` remains excluded from the commit. **STOP.**
