# Motakamel Plus Evidence Milestone — 2026-09-02

## Purpose

This milestone records the first direct, reproducible evidence from a real `EFA6_EDU` installation of Motakamel Plus. It closes the installer/provisioning investigation and establishes the pre-login system/version/runtime baseline. It does not declare the connector ready and does not change the Canonical Model.

## Product direction guardrail

**Motakamel Plus remains the Primary First Connector Target.**

AlMuhaseb1 remains an acquisition/evidence laboratory for legacy Access/Crystal boundaries. It is not a replacement target and its schema must not be used as a proxy for Motakamel Plus.

## What is now proven

### Exact educational installation

- Installed package: `EFA6_EDU`, version 6.
- User-visible application: `M+ Professional ERP V6` / Motakamel.
- Main executable: `C:\EFA\GL.exe`.
- `GL.exe` file version: `8.03.0812`.
- `GL.exe` SHA-256: `8A66CB7C39736A108C9249C1395ADB7A712D1190FD630FFB2BCEC578D405583A`.
- SQL Server: Microsoft SQL Server 2014 Express `12.0.6024.0`.
- Instance: `YSEDU`.
- Application/database root: `C:\EFA\`.
- The observed Host is Windows 11 Pro x64 build 22631, UTC+03:00.

Installed executable evidence includes `Admin.exe`, `CreateMultiLang.exe`, `GL_New.exe`, `inv.exe`, `Sale.exe`, `Prch.exe`, `pos.exe`, `EFAReportDesigner.exe`, `CallRep.exe`, and `IFR.exe`. File presence does not prove module licensing or enablement.

### Isolated laboratory

- A standalone VM named `DBL-MotakamelPlus-Lab` was created from a verified clean Windows checkpoint.
- Its VHDX/configuration are independent from `DBL-AlMuhaseb1-Lab`; the standalone base has no external parent path.
- Guest OS: Windows 10 Pro build 19045.
- Network remained disconnected during the provisioning investigation.
- `M1-Pre-Motakamel-Install` preserved the pre-install state.
- `M2-PostInstall-FMMA-Missing` preserved the reproduced incomplete-provisioning state.

### Database topology facts

The installation restored or created these application databases:

- `Multi_Lang`: proven pre-login use by live Motakamel sessions; full functional scope remains unresolved.
- `DbRepDes`: installed/restored and online; exact function remains unresolved and is not inferred from its name.
- `EFA12026`: installed/restored, online, compatibility 120, and initialized; it contains 516 user tables. Exact business/table semantics have not been inventoried.
- `EFAARC10`: created during the official Maintenance/Create workflow. Exact archive/history semantics remain unresolved.

Standard SQL Server system databases are also present and are not treated as Motakamel business stores.

### Pre-login runtime path

The Host launch reached the normal login screen and exposed live local SQL sessions proving:

`GL.exe` → `YsEDU` → `FMMA` → `Multi_Lang`

An additional Motakamel session through `sa` to `master` was observed; its exact responsibility is unresolved. No observed FMMA session used `EFA12026` as its current database at the captured pre-login boundary, so pre-login use of `EFA12026` must not be asserted.

### SQL identity

- `FMMA` is an enabled SQL Server login.
- Proven server roles: `sysadmin` and `dbcreator`.
- No independent `FMMA` database user exists inside `EFA12026` after provisioning.
- As a sysadmin login, FMMA operates as `dbo`; this behavior was sufficient for application startup.

**DBL must not assume FMMA is an appropriate connector identity.** It is over-privileged. A separate least-privilege, database-enforced read-only boundary must be proven before connector implementation.

## Provisioning result

The clean installation reproduced the original incomplete state:

1. MSI Finish launched `CreateMultiLang.exe`.
2. `Multi_Lang`, `DbRepDes`, and `EFA12026` were restored successfully.
3. MSI completed successfully.
4. `FMMA` remained absent.

Root cause classification: `PROVISIONING SKIPPED`, not attempted-and-failed. `CreateMultiLang.exe` restores databases but contains no FMMA login/user creation operation. The proven server-login creation path is in `GL.exe → Log_in1.CreateDataBaseRequired`, and MSI did not invoke it.

In a disposable laboratory checkpoint, the official System Update and Maintenance `Create` workflow:

- created the `FMMA` SQL login;
- granted `sysadmin` and `dbcreator`;
- did not create an independent EFA12026 database user;
- did not drop, recreate, or restore `EFA12026`;
- created `EFAARC10`;
- performed broad schema maintenance;
- changed `abranch` from 1 to 2 rows;
- changed `Units_types` from 7 to 14 rows;
- changed the `BackupSchedule` row fingerprint;
- allowed Motakamel to reach its natural login screen.

The Host was preserved with verified `COPY_ONLY + CHECKSUM` SQL backups. Its current FMMA/EFAARC10 timestamps and exact post-Create fingerprints show with high confidence that it had already passed through the same workflow or an operationally equivalent path. A second Host Create is prohibited because idempotence is unproven.

## Evidence classification

### PROVEN

- Package, executable, SQL Server, Host, and lab identities.
- Installer database-restore order.
- Skipped FMMA orchestration boundary.
- Maintenance/Create effects on one disposable educational baseline.
- FMMA login/roles and absence of an explicit EFA12026 user.
- Pre-login FMMA sessions against `Multi_Lang`.
- Successful login-screen launch on lab and Host.
- VM isolation and Host preservation backups.

### INFERRED

- `EFA12026` is the active business/company-year store for the observed configuration; its precise module/table boundary remains unproven.
- The Host executed Maintenance/Create or an operationally equivalent path before the preservation baseline.

### UNRESOLVED

- Enabled/licensed modules and customization flags.
- Explicit database/schema version marker.
- Complete functions of `DbRepDes`, `EFAARC10`, and the pre-login `sa` session.
- Post-login database-selection path.
- Collation, fiscal, branch, warehouse, UOM, currency, and timezone business semantics.
- Complete V1 least-privilege object/database allowlist and production operational qualification; bounded identity and isolation tests are now available in the follow-up below.
- Source schema, mappings, reconciliation, and representative performance.
- Safety/idempotence of a second Maintenance/Create execution.

## Connector evidence gates

| Artifact | Status | Current reason |
|---|---|---|
| System and Version Profile | `PARTIAL` | Pre-login identity/topology is complete; enabled modules, customization, and explicit schema version remain unresolved |
| Read-only Access & Isolation Record | `PARTIAL` | Narrow SQL identity/denials and frozen single-DB backup consistency proven; V1 DB/object boundary, privileged preparation separation and production performance/cancellation remain incomplete |
| Source Schema Inventory | `NOT STARTED` | Object counts are not a schema inventory |
| Mapping Evidence Table | `NOT STARTED` | No Motakamel canonical mapping exists |
| Reconciliation Baseline | `NOT STARTED` | No Motakamel Golden Dataset or reconciliation exists |
| Unsupported/Unresolved Semantics List | `PARTIAL` | Pre-login/provisioning unknowns are recorded; business semantics await evidence |
| Dataset Size & Performance Profile | `PARTIAL` | Physical sizes, object counts and one small backup/restore timing are known; representative distribution/index/workload/resource behavior is not |
| Exact V1 Connector Scope Decision | `PARTIAL` | Products/Inventory/Customers/Sales remain provisional; exact supported scope/exclusions are not evidence-backed yet |

Connector readiness remains **NOT READY**. No connector code should be written from this milestone alone.

## Decisions carried forward

- Keep Motakamel Plus as Primary First Connector Target.
- Keep AlMuhaseb1 as an acquisition/evidence lab only.
- Do not change the Canonical Model based on installed-module names or generic ERP expectations.
- Do not use FMMA as the connector identity.
- Do not repeat Installer, Maintenance/Create, or FMMA experiments.
- Do not interpret successful application launch as semantic or operational connector readiness.

## Access and snapshot follow-up — reviewed 2026-09-03

This follow-up materially changes the consistency-route evidence, not the primary target or connector-readiness decision.

- Independent SQL identities with CONNECT and narrow object-level SELECT can read the bounded tested EFA objects. Tested DML/DDL restrictions and focused effective CONTROL SERVER absence are evidenced. The old GRANT/ROLLBACK probe remains historically inconclusive; it was not replayed or used as denial proof.
- Live READ COMMITTED blocked under an uncommitted writer and saw a later commit in the same reader transaction. Source RCSI/SNAPSHOT remained OFF. No live snapshot-consistency claim.
- M5 preserved the independent Motakamel lab before the official COPY_ONLY+CHECKSUM experiment. One backup restored to separately named DB/files, passed VERIFYONLY and CHECKDB, and was frozen READ_ONLY.
- `DBL_SNAP_RO_TEST` read only the restored copy using CONNECT plus SELECT on abranch and three synthetic objects. No FMMA usage, privileged reader roles, or user mapping in source EFA12026.
- Three exact semantic readings over5.112 seconds remained at synthetic header300.00/lines100.00+200.00/pending0 while source commits became550.00/pending999 then777.00/pending2026. The transaction held uncommitted during backup was absent from the recovered point.
- Decision: **BACKUP-RESTORE SNAPSHOT QUALIFIED**, for the bounded single-database consistency mechanism. This is not full V1 semantic coverage, independent A/B restores, or production-scale qualification.
- Backup246ms, VERIFYONLY84ms, restore412ms, CHECKDB1,147ms; backup22,794,240 bytes. Restored data+log allocation248,184,832 bytes. Two small source reads during backup succeeded in9ms/8ms; no production SLA inferred.
- Source aggregate516 tables/194 views/188 procedures/190 functions; three synthetic tables included in the qualification backup. Ninety-one dependency rows have a referenced database name; actual targets, self-reference, V1 relevance and multi-database atomicity are unresolved. No full Schema Inventory began.
- Snapshot state metadata reported ON then OFF despite no ALLOW_SNAPSHOT_ISOLATION command; source remained OFF, restored READ_ONLY stayed true and records stayed equal. The cause is unresolved, not silently normalized or needed for the frozen-copy claim.
- Cleanup removed the test DB/files/login/source synthetic schema; verified backup retained. Thirteen selected before/after metadata/reference sections matched. Engine/log/msdb mutation is expected; zero physical mutation is not proven. No Host SQL/Motakamel access.

Architectural assessment: a **customer/DBA-produced official backup plus independently administered read-only restored store is a real V1 offline/fallback candidate**, not merely a lab technique. DBL must not silently inherit backup/restore administrative authority or FMMA. Default customer operation, separate-instance resources, V1 dependency coverage, security/retention and representative performance remain unqualified. Gate2 stays PARTIAL; Schema Inventory/Mapping/Business Reconciliation remain NOT STARTED.

Evidence retained outside this repository: `MOTAKAMEL_PLUS_BACKUP_RESTORE_SNAPSHOT_QUALIFICATION.md`, updated `MOTAKAMEL_PLUS_READONLY_ACCESS_ISOLATION_RECORD.md`, and `outputs/motakamel-backup-snapshot-01/{RAW_SHA256.txt,VERIFICATION.json,result.json}`. All26 raw-manifest entries revalidated. Backup SHA-256: `F67CC5054D64FC27944449DCE41552106B4624B05363BB04EFFEA3A73450D1F7`. Oracle SHA-256: `6678C1A8EE49ED0799BD4048A9700B18BA10530EC49C96A20866276DBBED78D6`. No backup payload, passwords or credentials are stored in Product Memory.

## Next single step

**Targeted V1 Database Boundary Qualification** on a disposable restored read-only copy: resolve relevant database-qualified references and determine whether V1 acquisition can stay wholly within EFA12026. Not executed; no mapping or connector code authorized by this proposal.
