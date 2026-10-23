# V1 — sequence, obstacles and resolutions

[Index](README.md) · [Evidence registry](EVIDENCE.json) · [Semantics](DATA_SEMANTICS.md)

## 1. Architecture and guest readiness — 18–20 October

- **DECISION:** Windows 10 Pro 22H2 x64, standalone V1, 4 vCPU/8 GiB/Generation 2 per owner setup. Prior successful Windows 10 evidence informed selection; old Windows 11/SQL experiments did not justify repeating that installation route. No blanket assertion that all Windows 11 or all newer SQL versions are incompatible.
- **FACT / owner report:** owner created V1, installed Windows 10 and reached its desktop. No second VM was created by this work. Current Hyper-V resources/network were not re-queried with elevated privileges.
- **FACT:** the network was disconnected. Hyper-V/HNS reads encountered access denial; advanced isolation was paused. ExecutionPolicy blocked an owner .ps1 before inventory commands ran; a TXT path was also mistakenly treated as an executable. These are separate failures, not evidence that every Get command was denied. No bypass, ACL change or network connection was applied.
- **FACT:** EFA6_EDU_Gold.exe alone was transferred by owner Copy-VMFile. Guest Service Interface was initially false, temporarily enabled, then restored false. Guest SHA-256 `1DE2B3556E43465EDDEE847BA194024CFA7AFE9400C6523D510869A22CE2994C` was visually supplied. A host-side Get-FileHash on the guest destination failed because that path was inside V1; it did not prove the copy failed. No original SQL data was transferred.
- **FACT:** Computer Use approval failures, approval timeout and stale-window/activation/capture problems occurred. A permanent allow-list entry alone did not establish control. Reopening standalone System32 VMConnect normally outside elevated Hyper-V Manager produced a measured Medium/non-elevated window and restored capture, activation, clicks and English/Arabic press_key entry. **type_text remains unqualified.**
- **HYPOTHESIS:** High VMConnect vs Medium Codex/UIPI strongly contributed to prior input failures. Reopening also changed the window/session state, and the input-helper token was not measured; this is not a unique root cause for every observed fault. Do not solve it by elevating Codex or changing Windows/Hyper-V permissions.
- **FACT:** owner installed ERP and created/updated the V1 database. On 19 October an owner SQL probe independently found missing FMMA login/user under sysadmin metadata visibility. On 20 October ERP startup and inventory navigation worked through VMConnect. The exact intervening FMMA provisioning action was not preserved; do not claim which repair caused success or that FMMA alone explained every GL exit.

## 2. First product persistence — 21 October

- **FACT:** inventory-account and chart lookups initially showed no usable saved account in the observed year/activity/branch. Minimum chart setup through the ERP GUI made account 101 available, then group 001 and DBL-T01 persisted after close/reopen. This does not prove one particular linkage flag was the sole lookup filter, or that every other fiscal context was empty.
- **DECISION:** small lab numbering 1/101, subsidiary inventory account, current-assets classification, balance-sheet report, SAR, observed linkage 8/inventory groups. These are lab choices and observed dropdown meanings, not vendor-standard account numbers.
- **FACT:** T02–T05 were saved and retrieved with group 001 and unit 1, without opening stock. Installed local help labelled version 5 was treated as guidance with a caveat while the running inventory UI displayed version 6.1.

## 3. Warehouse prerequisite and accounting scope

- **FACT:** the initial no-movement report hit `ChecK_W_CODE_Item_Mov`. Owner-supplied definitions showed GetW_CODE checking both warehouse and branch in W_DETAIL, which then contained zero rows. This established a missing prerequisite; the exact rejected report row and zero-movement mode were not fully qualified.
- **FACT:** one warehouse save attempt stopped at the mandatory stock-transfer intermediary account. F9 displaying 101 did not make reusing the inventory account correct accounting.
- **DECISION:** distinct 102 clearing account, current assets/linkage 9 observed in the actual accounting module; chosen for an inventory-in-transit role described in local help. Account 101 was independently reread and unchanged. The exact classification was a professional lab decision, not a proved mandatory vendor code.
- **FACT:** ERP accepted and persisted warehouse 1/branch 1 with 102. Receipt counteraccount 201 and consumption expense 301 were created separately. A later requisition required a supplier; 201 was not supplier-eligible in the observed lookup. Supplier account 202/linkage 7, supplier type 1 and synthetic supplier 001 were created, rather than repurposing 201. No complete production chart was initialized.

## 4. Actual inventory cycle — 21–22 October

All changes were GUI operations inside V1. No direct ERP SQL writes manufactured outcomes.

| Document | Actual action | Value SAR |
|---|---|---:|
| Receipt 1 | T01 +100 @20, Dr101/Cr201 | 2000 |
| Issue 1 | T01 -70 @20, Dr301/Cr101, consumption | 1400 |
| Receipt 2 | T02 +20 @80; T03 +50 @5; T04 +10 @40; T05 +15 @25 | 2625 |
| Issue 2 | T02 -17; T04 -8; T05 -5, Dr301/Cr101 | 1805 |
| Receipt 3 / issue return | T05 +2 @25 against issue 2 only, Dr101/Cr301 | 50 |
| Requisition 1 | T04 requested 20 @40, unapproved/unreceived | 800 estimated; no stock receipt |

**FACT:** final ERP available-quantity report after saving the requisition showed 30/3/50/2/12 in warehouse/branch 1, generated 22 October 00:23:12 guest time as of 21 October. Net accounting report showed 101 debit1470, 201 credit4625, 301 debit3155. These net balances must not be confused with gross journal turnover.

Native guest backups before/after were visually verified; exact names, locations and sizes are retained privately by the owner. They are inside V1, not external, not hash-verified here and not restore-tested. A local Production checkpoint was never represented as an external backup.

## 5. Actual SQL acquisition and DBL import — 22 October

- **FACT:** the first reviewed owner collector failed at unquoted alias rowCount, a SQL reserved keyword. R2 delimited aliases and added fail-fast/completeness checks. A pasted R2 then failed at an unexpected closing brace. Complete R2 parsed correctly, so a copy-boundary mismatch was suspected but the pasted text itself was not recovered. R3 removed the extra outer wrapper and passed Windows PowerShell 5.1 syntax validation; it then completed inside V1.
- **FACT:** owner supplied a 1,063,450-byte artifact. The received file's SHA-256 matched the independently supplied value exactly, including after retention. READ_WRITE/sysadmin metadata were disclosed honestly; the collector's SELECT-only protocol is not DB-enforced least privilege.
- **FACT:** SQL cached quantities were zero and card costs unsuitable. Signed item_mov deltas, receipt details/return linkage and journal pairs yielded the exact GUI balances and value. No SQL UDF or stored procedure was used to compute the stock.
- **FACT:** a new offline V1-specific connector retained the original host connector's pins. Five Canonical products were imported into fresh DBL SQLite, repeated idempotently, closed and read/analyzed by a different Node process. Source/reference hashes remained unchanged. Full proof is registered under EVIDENCE.json.
- **DECISION:** preserve the successful code at e82e5d003f7c546f170698ef2a107773d0837488 before developing repeated imports. The new app uses another state directory and never migrates run-02.

## 6. Repeated-integration engineering

See [current results](RECURRING_STATUS.md) and [ADR](ADR-V1-001-FILE-REFRESH.md). Any subsequent actual extraction is a separate acquisition with its own hash/time. Synthetic changed balances, process crashes or copied timestamps are never relabelled as a new ERP capture.

- **FACT — second actual owner artifact:** on22October the owner reran R3 and supplied the full later JSON and independently recorded SHA-256 E10B8A75…59E9DC7. Received bytes matched. Capture finished11:59:46.8205388UTC; rows/schema matched the04:00:55 first acquisition. Same-state import applied once, replay added no checkpoint, and historical replay left the newer observation current. Two snapshots/five current products/1470SAR passed readback and SQLite integrity checks; no ERP data or runtime code was changed. Exact hashes and result hashes and evidence IDs are registered in EVIDENCE.json; exact locators remain private.

## 7. Recovery gate before the third transaction — 23 October

The owner executed the sealed inspection-only probe inside the guest. A bounded clipboard file-copy attempt did not establish transfer and did not change settings. Guest GUI reading showed the inspection pass. Complete owner-pasted text then reconstructed the exact report bytes/hash; machine checks confirmed inspection metadata and size consistency. VERIFYONLY passed with no backup checksums. No restored fixture, independently retained BAK, third consumption issue or third acquisition is claimed. See [qualification and precise evidence boundaries](RECOVERY_QUALIFICATION.md) and [retention findings](EXTERNAL_RETENTION.md). A new-name/separate-files restore scope is prepared privately for owner review, not executed.

The owner subsequently approved and executed the sealed new-target restore test. Its exact report hash was verified; restore, CHECKDB and before/restored/after eleven-table fixture equality passed. Recomputed historical source table hashes also all matched after explicitly correcting the host UTF8 decode. The recovered reference remains30/3/50/2/12 and1470SAR with matching journal nets. No source stock change or third capture was performed. Retain the successful recovery target; outside-image BAK retention is still pending, without changing session/security/network settings.


## 8. Independent retention, one real stock change and third import — 23 October

The owner-assisted BAK copy was independently verified outside VHDX by size/SHA-256 against the separately restore-tested source. A fresh ERP baseline still showed30/3/50/2/12 and1470SAR. The already authorized consumption issue3 was saved once via standalone ordinary VMConnect, then closed/reopened. ERP stock report showed29/3/50/2/12 and1450SAR; financial entry Dr30120/Cr10120 matched.

The unchanged R3 collector produced a third real1,079,921-byte artifact, exact hash92AD9A1C…092D94. Existing rows were compared, including correlated receipt-detail c_qty/pc_qty30→29. The compiled unchanged product accepted the single new movement/two journal rows/new master. Four same-state CLI processes proved applied/replayed/replayed/replayed, three snapshots, five current products1450SAR, retained old1470SAR history and reopen/audit/integrity success. A private acceptance-harness audit-count assertion failed at12versus8; read-only inspection/correction confirmed three events per invocation without repeating any import or ERP write. [Exact proof, hashes, reproduction and unresolved scope](THIRD_CAPTURE_RESULT.md).


## 9. Operator-assisted execution package — 23 October

The owner authorized ordinary product engineering and a new PR, while prohibiting further ERP transactions or infrastructure changes. Seven commands and an Arabic runbook now cover source checks, import/current-history inspection, local HTML results, independently pinned backup verification and new-directory DBL-state recovery. Initial readonly disk inspection unexpectedly created SQLite sidecars; serialized inspection then exposed WAL-header deserialize requirements. Documented RAM-only adaptation plus nonempty-WAL/journal refusal resolved both without changing source files. Additional controls reject incomplete audit evidence, corrupted data/archives/manifests, concurrent writers and unsafe destinations.

Final local430passed/42skipped tests and nineteen compiled operator processes passed against existing actual artifacts and copied successful operational state. The original still has eleven imports/three snapshots/1450SAR; no fourth capture or ERP change was made. [Full decision and qualification](OPERATOR_PACKAGE.md). PR20 and memory PR9 remain for independent review, without automatic merge.
