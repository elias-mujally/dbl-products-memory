# Host W11 — post-S2 frozen snapshot + independent reader — 2026-10-09

## Outcome and next programming decision

| Gate | Executed result |
|---|---|
| Snapshot Qualification | **PASSED — LAB-PROVEN**, isolated recovered READ_ONLY EFA12026 image |
| Independent Reader Qualification | **PASSED — LAB-PROVEN**, actual separate SQL-authenticated connections, bounded object access and denial tests |
| S2 Reconciliation from Frozen Snapshot | **PASSED — LAB-PROVEN**, exact selected event and item/unit/warehouse/quantity/currency scope |

**Next programming decision: READY FOR IMPLEMENTATION — the bounded Item A identity-only first increment.** Implement only the specific Motakamel educational profile and the existing Product.id/name contract, with the qualified frozen stage, externally supplied constrained-reader credentials and exercised resource/row/byte/provenance safeguards. This decision is not implementation authorization or a claim that the useful scoped-inventory/purchase contract is already designed. Its necessary unit/warehouse/provenance and numeric/runtime decisions remain a separate bounded task; no purchase-as-Sale, speculative field, generic SQL connector or mapping DSL. S3 remains **FROZEN / ACCOUNTING-BLOCKED**. Controlled Zero remains **PARTIAL**; historical zero provenance was not reopened. Gate B/C, representative performance, PARTNER-VALIDATED and PILOT-QUALIFIED are not claimed.

The user accepted972e9d3 and separately authorized COPY_ONLY/CHECKSUM → verify → independent restore → READ_ONLY → least-privilege reader. The prior Reference Lab snapshot technique and October7 Host RestoreProof were reviewed as historical procedure/recovery evidence, not proof of this post-S2 copy. Current Pilot #001 and Controlled Dataset plan/S2 mapping were retained. Build origin/main was freshly fetched and remained **95bf225e1523e0fd0f72cdf3da8393df18d635cc**; the clean local checkout **0fb18e982e90ae09b5e68f306c406ee97a7f29ff** has identical tracked content. Core Product still permits identity without new business fields; Purchase/scoped inventory context is still absent. No build edit, install or connector test occurred.

## Gate A — actual preflight and declared administrative surface

Source **DESKTOP-8QRQT7R\YSEDU / EFA12026 / database_id7**, SQL12.0.6024.0 Express, existing mixed authentication enabled. Source is ONLINE/writable, TRUSTWORTHY/cross-DB chaining false, SNAPSHOT OFF/RCSI false. Existing diagnostic Windows operator is sysadmin; it prepares the copy but is **not** the DBL reader. No FMMA or Windows identity/ACL/UAC/service/authentication-mode change.

Source logical files EFA12026 / EFA12026_log remain **C:\EFA\EFA12026.mdf / .ldf**. Allocated bytes: **25,755,648 +224,526,336 =250,281,984**. Preflight C free **17,540,235,264 bytes (~16.336 GiB)**, D free **17,562,300,416 bytes**. Conservative backup/restore budget750,845,952 bytes plus5 GiB untouched reserve passed. This is a small SQL-copy budget, not the unrelated VM Stage-B50 GiB gate.

The proposed database/login/backup/MDF/LDF names were absent before creation. Existing SQL DATA directory and C:\EFA permissions were inspected without modification; SQL service is LocalSystem. Source invoice1-44-1-0-1 and available37 matched the accepted S2 evidence. Bounded full protected rows, two movement rows, eight document/receipt/journal/cache tables and all21 monitored business counts were retained for comparison.

Administrative changes declared before execution: one new backup file and ordinary msdb backup history; one separate database with independent MDF/LDF; one new SQL login and clone-only user/grants/denies; clone READ_ONLY. User/permission metadata was prepared **before** freezing because READ_ONLY would prevent that metadata write. No source business mutation, existing DB replacement, WITH REPLACE, DROP/cleanup, source isolation change, production setting change or ERP Save.

## Gate B — exact frozen-copy provenance

| Property | Observed value |
|---|---|
| Backup | `C:\EFA\DBL_HOST_W11_EFA12026_PostS2_Frozen_20261009.bak` |
| Backup physical bytes | **25,350,144** (24.176 MiB) |
| Backup SHA-256 | **E63DF84D2DBB22C5ACD535DC5881D2DCF417F420665502927EBD9AD66731E572** — fresh filesystem hash |
| Backup set / UUID | **1012 / 2b9d2bde-8d89-4ee7-98de-224fb97060c7** |
| Backup start/finish | SQL local wall time **2026-10-09 08:12:11 /08:12:11**, Host observed offset+03:00; not the October8 business date |
| Backup mode | COPY_ONLY, CHECKSUM, STOP_ON_ERROR; dedicated absent path, no append to an existing backup |
| Verification | VERIFYONLY FILE1/CHECKSUM/STOP_ON_ERROR passed; HEADERONLY confirms source, IsCopyOnly/HasBackupChecksums |
| Restored database | **DBL_HOST_W11_EFA12026_PostS2_Frozen_20261009**, ID**10**, ONLINE / **READ_ONLY** |
| Restore | History**5**, **08:12:12.160**; FILE1/CHECKSUM/STOP_ON_ERROR/RECOVERY/MOVE; replace=false |
| MDF | `C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.YSEDU\MSSQL\DATA\DBL_HOST_W11_EFA12026_PostS2_Frozen_20261009.mdf` |
| LDF | Same directory, `DBL_HOST_W11_EFA12026_PostS2_Frozen_20261009_log.ldf` |
| Restored allocated footprint | **250,281,984 bytes**; no shared source/previous-proof file |
| Integrity | Fresh DBCC CHECKDB, ALL_ERRORMSGS/NO_INFOMSGS, completed without reported errors; no repair |
| Freeze completed | **08:15:38.099+03:00**, no ROLLBACK IMMEDIATE or forced session termination |

Backup firstLSN **40000004672000108**, lastLSN **40000004678400001**, checkpointLSN **40000004672000108**, databaseBackupLSN **39000001251000162** are preserved as **SQL-converted text**, not JavaScript numeric IDs. Backup/recovery provenance is the as-of boundary; qualification08:17 is acquisition/observation time, not an invented exact ERP business timestamp. This is one recovered database, not a synchronized EFA/support-database/application snapshot.

READ_ONLY and independent files, not READ COMMITTED, NOLOCK or an assumed live transaction snapshot, are the consistency boundary. No concurrent live writer/uncommitted-transaction experiment was repeated. Immediate post-freeze catalog briefly reported SNAPSHOT ON; the later/final observations report OFF, with RCSI false throughout. No ALTER SNAPSHOT/RCSI was issued or needed; no interpretation of that transient is required for this frozen-copy proof. An administrator can subsequently thaw/drop the stage: this is not immutability against a privileged operator.

After qualification C free **17,260,564,480 bytes (~16.075 GiB)**; D unchanged at17,562,300,416. Source and prior **DBL_HOST_W11_EFA12026_RestoreProof_20261007 /ID9** remain ONLINE/writable; prior proof was neither replaced nor used as this snapshot.

## Gate C — actual independent identity and permissions

SQL login/database user **DBL_HOST_W11_S2_Reader_20261009**; default DB is the new frozen stage. Original/effective login and database user all match this identity on actual independent SqlClient connections. sysadmin0, dbcreator0, db_owner0, CONTROL SERVER0; explicit server/database role lists empty (implicit public remains). Only ordinary CONNECT SQL is explicitly present at server level. No impersonation-as-admin is used to claim an independent connection.

| Securable | Granted purpose |
|---|---|
| Clone database | CONNECT |
| dbo.item_detail | SELECT — exact item identity/base binding |
| dbo.Item_Detail_Units | SELECT — item/unit/primary package relation |
| dbo.Measure | SELECT — UA identity |
| dbo.W_DETAIL | SELECT — Branch1/Warehouse1 identity |
| dbo.Bills | SELECT — selected saved purchase header |
| dbo.Bill_detail | SELECT — selected purchase line |
| dbo.gr_note | SELECT — same-event generated receipt header |
| dbo.gr_detail | SELECT — same-event receipt/warehouse corroboration |
| dbo.item_mov | SELECT — two scoped rows and one+37 event |
| dbo.FindAvQty | **EXECUTE on this scalar function only** — SELECT invocation of the verified read-only quantity calculation |

No db_datareader, schema-wide SELECT, database-wide EXECUTE, VIEW SERVER STATE, db_owner, dbcreator, CONTROL or source user/grant. Whole-table SELECT is the practical object-level allowlist for this tiny frozen lab, **not** row-level security or authorization for arbitrary larger profiles. FindAvQty definition SHA**235E8D7379760735FA7E4F3613CD2F67E822EF974B7C990A3E281665659C2628**; inspected dependencies are only local item_detail/item_mov, no server/other-DB reference. No required Multi_Lang/DbRepDes dependency appeared for this projection.

Explicit clone DENY: INSERT/UPDATE/DELETE, ALTER, CREATE TABLE/VIEW/PROCEDURE/FUNCTION/SYNONYM, ALTER ANY USER/ROLE, TAKE OWNERSHIP. Effective checks are0 for writing, CREATE TABLE, ALTER/CONTROL database, broad EXECUTE and ALTER ANY LOGIN; SELECT Bills1 / EXECUTE FindAvQty1. Public has no database/schema-wide or user-object grant in the filtered catalog check. Standard SQL system metadata/public capabilities are not claimed absent.

| Executed probe using reader only | Result / precise limit |
|---|---|
| INSERT SELECT WHERE1=0 / UPDATE WHERE1=0 / DELETE WHERE1=0 on clone Bills | **Denied229**, actual object permission denial, no business row changed |
| CREATE TABLE unique clone probe | **Denied3906** because READ_ONLY; effective CREATE TABLE0 independently checked, not falsely attributed solely to262/DDL permission rejection |
| Source EFA12026 business SELECT TOP0 | **Denied916**, database inaccessible |
| Previous RestoreProof business SELECT TOP0 | **Denied916**, database inaccessible |
| Clone Account SELECT TOP0 outside allowlist | **Denied229** |

No probe table was created. Cross-DB denial is executed for those **two unauthorized business databases**, not an exhaustive penetration test of every catalog, master/tempdb or every system procedure. This remains a local lab qualification, not production transport/security hardening.

A random secret was generated only in preparation-process memory; policy/expiration remain enabled. No password, password hash or connection string with credentials was written to evidence/repositories. **The active login is retained but the secret was not persisted or delivered.** A later authorized preparation operator must rotate/provide it through an approved secure external injection path before future DBL use. That operational handoff is **NOT QUALIFIED here**; the connector must never perform administrative credential provisioning. No plaintext-password handoff or production deployment claim follows.

### Recorded setup deviations — not hidden retries of business actions

The first preparation batch used SELECT for the scalar function, an invalid permission for this object type; other table grants/user/denies persisted before the exception. The result wrapper also failed to retain that first output. Read-only catalog/msdb checks established what actually existed; backup/restore were **not repeated**. The scalar permission was corrected to object EXECUTE; the overly broad EXECUTE deny on this newly created user was revoked to permit only that explicit function grant. No broad EXECUTE was granted. Microsoft documents scalar permissions as EXECUTE/REFERENCES: [GRANT Object Permissions](https://learn.microsoft.com/en-us/sql/t-sql/statements/grant-object-permissions-transact-sql?view=sql-server-ver16).

The subsequent setup verified/checkdb'd the existing copy and froze it successfully, then stopped **before reader login** because PowerShell's dictionary adaptation rejected SqlConnectionStringBuilder DataSource assignment. Explicit setters were tested locally, then the reader tests succeeded. The process-local secret was rotated for this **new experimental login only** on each controlled resumption; no original identity/permission changed. The frozen stage was never thawed. These were administrative/helper corrections, not ERP Save retries, duplicate snapshots or production-ready automation proof.

## Gate D — independent frozen-reader reconciliation

All business facts in the following projection were read using the new DBL identity. Administrative reads are kept separate for backup/catalog preparation and source-preservation comparison.

| Fact | Reader result / reconciliation |
|---|---|
| Item | One DBL_P001_ITEM_A / DBL_ITEM_A; Group001, primary UA, i_size/p_size1; master p_code='0' retained in its own role |
| Scope | Warehouse1/Branch1 DBL_WAREHOUSE_A, Unit UA / DBL_UNIT_A; package relation I_Code/P_Code=ItemA /Main_Unit=true/Unit_Level1/I_Size1 |
| Purchase | One header +one line PKDoc1-44-1-0-1; invoice1/type26/paytype1; lineUKey0c02c7b5-2210-46f0-a82c-cea2997e6d3a |
| Raw quantities | Invoice line I_qty/p_qty37; receipt37; one linked movement inout_qty**+37**, free/sub contributions0 |
| Raw monetary evidence | Header bill_amt3700/SAR/document rate1/stock rate1; line I_price100/cost_curSAR/cost_rate1; receipt c_price/stk_cost100/SAR |
| Derived gross | Explicit safe-whole-integer control operands37×100 → **3700 SAR**; separate from persisted header3700 |
| Receipt/movement linkage | SamePKDoc and Branch1/W1/UA/package1; receiptUKey differs from lineUKey, movementUKey equals lineUKey in this case; no blanket FK/global uniqueness invented |
| Available balance | FindAvQty(1,ItemA,1,NULL,NULL,NULL) **37**; matches the accepted October8 scoped official report and current source comparison, not a new preview |
| Lifecycle/payment | Cashbox1/account97070103 raw binding retained; Bill_post=false /receiptInvPost=true /gr_post=false; no final GL posting or physical cash-settlement claim |
| Deduplication | One inbound37 despite three representations; not111. Historical73-field zero row unchanged, no provenance investigation |

Two repeated reads and a third after closing/reopening the independent connection were **exactly equal**. First reader projection equals the source preflight projection. Independent reading interval completed **08:17:01.051+03:00**. Source protected-row hash and document/function hash from before backup at **08:11:43.501** match final source observation **08:17:00.867**, with all21 counts equal. Source options remain equal. No new stock transaction, issue, account/master edit or ERP Save was performed.

Protected rows/hash include complete returned accounts/currency links, Unit/Group/Item/Warehouse/Cashbox/GetCash and both movement rows; document/function comparison includes bounded eight-table receipt/journal/cache rows and quantity/function evidence. This is not a fingerprint of every ERP table, all log records or physical source MDF bytes. Ordinary BACKUP/msdb administrative history is an expected effect, not a source-business mutation. Prior raw S2/zero artifacts remain unchanged.

Critical SQL numerics remain **float(53)**. The observed37/100/3700/1 whole numbers are exactly representable and were checked as safe integers before integer derived arithmetic. No rounding policy for fractions, automatic float→exact Decimal, general valuation/FX or large-ID numeric serialization is qualified. Backup LSNs were explicitly selected as text to avoid that separate fidelity trap. No cache0 authority, latest purchase, bonus/return/cancellation/supplier/demand semantics, S3 or broader profile support was added.

## Evidence retention and stop

Local evidence under task workspace, **not committed as database exports**:

| Artifact | SHA-256 |
|---|---|
| outputs/host-motakamel-posts2-frozen-20261009/QUALIFICATION_EVIDENCE.json | **7D742175B6652860C7974115F8A1CBB789F49D86ACAD4FC5DD40CFCE310E7BAC** |
| same directory/Qualify-FrozenS2.ps1 — lab administrative/evidence helper only | **627D58AB45F042EB2DFE23D2209D83DFED2380C8093EBD30D2E8F2D86E4B806C** |
| Prior S2 SAVE_EVIDENCE.json | 938D31CA336A765F231C9E95EE474C170CBC415C5322C769809754C64D006A61 — unchanged |
| Prior zero-row READ_ONLY_EVIDENCE.json | B281E870DF3ADA47841E3CABE47461BE2E43DACB142CA5444F80B1BAD6BA2F23 — unchanged |
| Prior S2 targeted READ_ONLY_EVIDENCE.json | 32E187E8AC71F0895EC2E93BBF78FACC46AA8CB17088776E1F4DB208E222BCA4 — unchanged |

Snapshot, backup and login retained, without automatic cleanup/retention scheduler. The user/preparation operator owns future retention, secure credential handoff and separately authorized removal; admin privileges are not part of the connector. The backup is not claimed encrypted or qualified for production file ACL/transport policy; existing Windows permissions were unchanged.

Only reviewed Product Memory documentation is to be committed/pushed; `.vscode` remains excluded. No Canonical/build/connector change, ERP Save, direct business SQL write, independent posting, Windows/server/service/FMMA configuration change outside the expressly authorized new database/login scope, S3 or additional snapshot was performed. **STOP before programming or any further business action.**
