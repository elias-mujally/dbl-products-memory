# Host Windows 11 Motakamel development baseline — 2026-10-06

**Result: `HOST W11 MOTAKAMEL COMPUTER USE PARTIALLY QUALIFIED`. Development environment readiness is NOT established.** Direct observation works; mouse and keyboard delivery remain unresolved. A new official SQL backup was created and verified by SQL Server, but filesystem size and SHA-256 collection require a privileged read of that existing file. No ERP business mutation or controlled dataset creation occurred.

## Execution decision and protected boundary

The user explicitly selected the already working physical-host Motakamel installation for controlled DBL development. The user states that it was installed specifically for experimentation and contains no important/private production, customer, hospital or personal business data. This is an environment declaration, not permission to inspect unrelated host data or modify Windows.

The host is NOT disposable. Personal files, unrelated applications, Windows/SQL/network/security configuration remain protected. No installation, repair, upgrade, DSN/FMMA/login/role changes, registry edits, service changes, ACL changes or SQL business writes are authorized by this task.

The prior Windows 11 Agent Lab installation failure is outside the current critical path. No Hyper-V VM was started, repaired, reverted or modified. The existing Reference Lab remains preserved and was not connected or altered. Its prior controlled Item A must not be confused with the empty host item tables. No new live Hyper-V integrity/network audit was needed or performed in this task.

## Host and executable baseline

| Evidence | Observed value |
|---|---|
| Physical host | DESKTOP-8QRQT7R |
| Windows | Windows 11 Pro / Professional, 23H2, build 22631.6199, X64 |
| Branding caveat | Registry ProductName says Windows 10 Pro; OS build/version identifies Windows 11. This host is not the 25H2 rebuilt guest. |
| Installation directory | C:\EFA |
| Active application | C:\EFA\GL.exe |
| GL FileVersion / ProductVersion | 8.03.0812 / 8.03.0812 |
| GL physical length | 3,358,720 bytes |
| GL SHA-256 | 8A66CB7C39736A108C9249C1395ADB7A712D1190FD630FFB2BCEC578D405583A |
| Historical comparison | Exact version/hash match with supplied reference; not evidence that database contents match any lab. |
| Visible UI branding | M+ Professional ERP; Trial Version; Gold Version; V6.0; Ver. 6 E-Invoice 18-01-2026 |
| Current UI context | Financial year 2026; activity 1; branch 1; authenticated Main Menu |
| Component file metadata | inv.exe 8.03.0304; Sale.exe 8.03.2063; GL_New.exe 5.03.0723. These components were not launched or otherwise qualified. |
| Initial host free space | C: 40,302,235,648 bytes; D: 17,562,300,416 bytes. Point-in-time measurements, not fixed reserves. |

Opening GL via Sky timed out without proving launch. The user then opened Motakamel normally and completed authentication manually. The main UI was captured directly afterwards. Normal operation in this environment is proven at this boundary, not autonomous launch/authentication.

## SQL baseline and active database attribution

The normal execution sandbox account was `CodexSandboxOffline`. Windows-authentication attempts there failed with security-package/SSPI errors before SQL queries could run. No credentials, permissions, security settings or authentication workaround were introduced.

A supported `require_escalated` execution context subsequently ran as the ordinary host user and successfully connected using existing Windows integrated authentication. This resolved the SQL execution-context limitation without changing SQL or host configuration. A user-supplied SQL result was corroborated by fresh direct queries.

- Server: DESKTOP-8QRQT7R\YSEDU.
- Engine: **Microsoft SQL Server 2014 SP3 (KB4022619), 12.0.6024.0, Express Edition, Intel X86**, operating under WOW64 on the x64 host.
- Engine-reported version is authoritative. Setup registry Version/PatchLevel was 12.3.6024.0 and sqlservr.exe file metadata was 2014.0120.6024.00; these are recorded separately and must not replace the engine result.
- MSSQL$YSEDU was Running; SQLAgent$YSEDU was Stopped. No service action was performed.
- GL process PID 64148 was matched to SQL sessions with `program_name=Motakamel` on this host: session 52 used Multi_Lang and session 54 used EFA12026. This ties the active application to the instance/database, rather than inferring from filenames.

| Database | Created (raw SQL metadata) | State | Compatibility | Recovery | Allocated bytes (data + log) |
|---|---|---|---:|---|---:|
| Multi_Lang | 2026-09-01 17:12:07.047 | ONLINE | 100 | SIMPLE | 85,860,352 |
| DbRepDes | 2026-09-01 17:12:12.507 | ONLINE | 100 | FULL | 26,214,400 |
| EFA12026 | 2026-09-01 17:12:13.250 | ONLINE | 120 | SIMPLE | 247,136,256 |
| EFAARC10 | 2026-09-02 06:53:51.163 | ONLINE | 120 | SIMPLE | 243,400,704 |

**Active business database: EFA12026.** Approximate allocated size: 235.688 MiB. EFAARC10 exists; EFAARC12026 was not returned by the relevant EFA-name discovery query. No archive-error investigation or SQL configuration audit beyond this baseline was undertaken.

## Current dataset state

Catalog counts in EFA12026: 516 user tables, 194 views, 188 procedures, 190 functions. Partition metadata estimates 54 populated user tables and 1,573 user rows. These are approximate, point-in-time counts, not a transaction reconciliation.

The populated-table metadata list is dominated by dictionaries, menu/report metadata, parameter/permission/branch/user settings and standards. Examples include country/currency standards, doc_types, FlagsName, System_Parametrs*, report signatures and Units_types. Such rows are not classified as customer business data merely because they exist.

Exact SELECT counts, corroborated again after the UI tests:

| Surface | Exact rows |
|---|---:|
| dbo.Measure | 0 |
| dbo.i_group | 0 |
| dbo.item_detail | 0 |
| dbo.item_mov | 0 |
| dbo.Account | 0 |
| dbo.Account_Cur_Detail | 0 |

`DBL_UNIT_A`, `DBL_GROUP_A`, `DBL_P001_ITEM_A` and `DBL_ITEM_A` each returned zero matches on their corresponding observed unit/group/item code/name surfaces. No global scan of every text column was performed. Units_types has 14 dictionary rows; it must not be equated with an existing reusable primary unit.

**Classification: effectively clean/uninitialized for the inspected business domains, with system seed/configuration already present.** This is not a proof of every seed row's origin or every table's semantics. It is not the Reference Lab's controlled dataset. No prerequisite account/unit/group/item exists in the checked host master tables; further prerequisite discovery/creation requires a separate task.

## New pre-mutation backup

Source: EFA12026 only. Support databases were observed but not backed up; this is NOT a complete application/server/environment recovery package.

Existing SQL backup directory was used without directory/ACL/configuration changes. Target name included a new GUID, was checked for nonexistence, and did not overwrite any existing backup. No INIT/FORMAT, database-object creation, restore, compression-setting change or backup-device registration was used.

```text
C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.YSEDU\MSSQL\Backup\DBL_HOST_W11_EFA12026_PreMutation_20261006_47a3d84be3294eba8c035cd0dfde8001.bak
```

| Metadata | Value |
|---|---|
| msdb backup_set_id | 1011 |
| Backup type | D — full database |
| Backup start / finish (raw msdb) | 2026-10-06 17:19:26.000 / 2026-10-06 17:19:26.000 |
| Correlated SQL clock | 2026-10-06T14:19:26.8755872Z; 17:19 local Asia/Aden |
| is_copy_only | 1 |
| has_backup_checksums | 1 |
| SQL backup_size / compressed_backup_size | 22,634,496 / 22,634,496 bytes |
| Database GUID | 9EE44BF3-A684-46B1-8502-20AFA0659CBF |
| first_lsn | 40000003895200170 |
| last_lsn | 40000003902400001 |
| checkpoint_lsn | 40000003895200170 |
| database_backup_lsn | 39000001251000162 |
| differential_base_lsn before / after | 39000001251000162 / 39000001251000162 — unchanged |
| RESTORE VERIFYONLY | Completed with CHECKSUM and STOP_ON_ERROR; SQL returned: The backup set on file 1 is valid. |
| Physical filesystem bytes | PENDING — ordinary-user and sandbox file reads denied. SQL backup_size is not substituted for filesystem length. |
| SHA-256 | PENDING — manual administrative file read requested; no ACL change permitted or performed. |
| Isolated restore | NOT PERFORMED; no new database or database overwrite authorized. |

Backup succeeded and verification succeeded; the combined command subsequently returned nonzero because filesystem Get-Item was denied. Do NOT misclassify this as backup failure or create another backup blindly.

Microsoft documents COPY_ONLY as not affecting the differential base. VERIFYONLY checks backup readability/completeness/checksums but does not establish full restored database/application correctness:

- https://learn.microsoft.com/en-us/sql/relational-databases/backup-restore/copy-only-backups-sql-server
- https://learn.microsoft.com/en-us/sql/t-sql/statements/restore-statements-verifyonly-transact-sql

## Direct host Computer Use — bounded result

Current skill and guidance/API/confirmation documentation were read. Every UI operation used node_repl -> @oai/sky. No VMConnect/RdpViewer path was used; no SQL client or terminal UI was automated.

Fresh returned GL identity: `process:C:\EFA\GL.exe`, window 1377924, Main Menu. Enumeration, get_window, activation and visual capture succeeded. Original screenshots were displayed by the tool at 1920 x 1020; no screenshot payload was decoded or saved for inspection. No sensitive/authentication dialog was active. SetIsBorderRequired / 0x80004002 / E_NOINTERFACE did not reproduce.

1. Fresh BEFORE screenshot showed Main Menu.
2. Exactly one left click at (1790,270), derived from that screenshot, targeted the visible inventory top-level heading. Immediate and delayed captures showed no observable navigation change. No second click/double-click or guessed retry was performed. **Mouse effect: UNRESOLVED**, not proof of broken delivery.
3. Exactly one F1 key requested application help from the unchanged non-business main screen. No visible change appeared; a fresh enumeration returned only the GL Main Menu window and no GL-owned secondary window or hh.exe help window. **Keyboard effect: UNRESOLVED**, not proof that all guest/host keyboard delivery is broken.
4. No text, Enter, Save, Add/Edit/Delete, ERP form or transaction workflow was invoked. Follow-up SELECT confirmed the six business/master tables above remained empty.

**HOST W11 MOTAKAMEL COMPUTER USE PARTIALLY QUALIFIED.** Activation/capture do not qualify input. The input cause/semantics are not established by this bounded test; do not infer elevation/session mismatch or non-working application solely from lack of these two visible effects.

## Deployment support and readiness

This is **working in this environment**, not an officially supported SQL Server 2014 / Windows 11 combination. Microsoft's compatibility table explicitly marks SQL Server 2014 on Windows 11 not supported. Vendor support for this exact deployment remains unverified:
https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/install/windows/use-sql-server-in-windows

No Windows/SQL/Motakamel upgrade, repair, PowerShell 2.0 reinstatement or vendor compatibility workaround is implied or authorized by the host development decision.

**HOST W11 MOTAKAMEL DEVELOPMENT ENVIRONMENT PARTIALLY QUALIFIED — NOT READY.** The new database backup is SQL-verified, but its SHA-256/filesystem length remains pending; independent mouse and keyboard visible-effect qualification remains pending. Do not start controlled ERP mutation.

Safest next actions: obtain the existing backup's filesystem length and SHA-256 via manual administrative read without changing ACLs; then separately authorize a bounded input-only follow-up using a clearly responsive reversible menu target. Do not recreate the backup or troubleshoot broader host security speculatively.

Once those gates are proved, the intended direction is to resume Pilot #001 controlled evidence work through the official Motakamel UI under separate authorization. This task does NOT complete S0b, start S2/S3, migrate Reference data, create Unit/Group/Item A, or advance connector implementation/customer-pilot qualification.

## Repository handling

The unrelated untracked `products/legacy-intelligence/research/.vscode/` directory was preserved and must remain unstaged. Explicit staging is limited to this evidence note and the README entry linking the current host decision. Backup binaries, database rows, credentials and unrelated files are not committed.
