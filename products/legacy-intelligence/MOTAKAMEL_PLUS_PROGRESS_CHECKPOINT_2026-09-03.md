# Motakamel Plus — V1 Evidence Progress Checkpoint

Date: 2026-09-03

This checkpoint records the current Motakamel Plus evidence state before the targeted Golden Dataset qualification. It is a product-memory milestone, not connector implementation and not a Canonical Model change.

## Current decision

**DATABASE BOUNDARY STILL REQUIRES GOLDEN DATASET**

Motakamel Plus remains the Primary First Connector Target. `EFA12026` is the only database currently proven REQUIRED for the minimum V1 scope. `Multi_Lang` is OPTIONAL for the current minimum scope; no indispensable semantic dependency on `S_FLAGS` has been proven. `DbRepDes` and `EFAARC10` are OPTIONAL on current evidence.

The next evidence step is **Motakamel V1 Targeted Golden Dataset Qualification** inside the isolated lab using the official Motakamel UI.

## What has now been proven

### System and runtime baseline

- Real educational Motakamel Plus package `EFA6_EDU` has been installed and investigated.
- Application identity observed as M+ Professional ERP V6.
- `GL.exe` version: `8.03.0812`.
- SQL Server instance: `YsEDU`.
- SQL Server 2014 Express SP3 version `12.0.6024.0`.
- Proven pre-login runtime path: `GL.exe -> YsEDU -> FMMA -> Multi_Lang`.
- `EFA12026` is the initialized business database under investigation.

### Isolated Motakamel lab

A dedicated Hyper-V lab was created from the clean pre-AlMuhaseb checkpoint and kept separate from the Host Motakamel installation. The lab is the authorized investigation environment for destructive/disposable qualification work. Host Motakamel must not be used for connector experiments.

### FMMA provisioning investigation

The clean install reproduced the missing-FMMA condition. Investigation identified the boundary as provisioning being skipped after successful database restore, rather than a proven failed FMMA SQL operation.

The official Maintenance Create workflow was tested only in the disposable lab. It successfully provisioned FMMA but also performed broader maintenance/schema/reference changes, proving that Create is not a narrow user-fix action.

Host preservation later established that the Host had already passed through Create or an equivalent provisioning state. Host Create therefore must not be repeated without independent idempotence evidence.

### Independent read-only identity

DBL must not use FMMA as its connector identity. FMMA has elevated server privileges and is inappropriate as the DBL V1 acquisition boundary.

A separate least-privilege SQL test identity proved useful bounded reads with explicit `CONNECT` and object-level `SELECT` grants. Write and DDL capabilities were denied in the qualification scope.

A focused follow-up proved:

**CONTROL SERVER DENIAL PROVEN**

Effective `CONTROL SERVER` checks remained false before, during, after, and after reconnect. No administrative role membership appeared and the test identity was removed afterward.

### Isolation finding

Ordinary SQL Server `READ COMMITTED` is not sufficient evidence for DBL pinned/snapshot-consistent acquisition:

- a reader can wait for a concurrent writer;
- values can differ between reads inside the same transaction;
- `SNAPSHOT` was disabled in the observed database;
- database isolation settings were not changed merely to make the experiment pass.

Therefore read-only permission safety and snapshot consistency are separate gates.

### Frozen backup snapshot technique

Decision:

**BACKUP-RESTORE SNAPSHOT QUALIFIED** for a single `EFA12026` lab database snapshot.

The lab proved:

- `COPY_ONLY + CHECKSUM` backup;
- backup verification;
- restore to independent database/files;
- restored database switched to `READ_ONLY`;
- repeated independent read-only queries returned the same frozen state;
- later source changes did not appear in the restored snapshot;
- an uncommitted source transaction at backup time did not become visible in the restored snapshot.

Observed small educational dataset measurements were approximately 246 ms backup, 412 ms restore and 22,794,240 bytes backup size. These are lab measurements only and are not production performance guarantees.

Architectural interpretation: a customer/DBA-provided SQL backup is a credible **offline/fallback V1 acquisition mode**. This is not authorization for DBL to perform privileged backup/restore administration on customer SQL Server installations.

## Current database boundary

Targeted boundary qualification currently classifies:

| Database | Current V1 classification | Reason |
|---|---|---|
| `EFA12026` | REQUIRED | Local candidate reads cover accounting/document, customer, product and inventory areas. |
| `Multi_Lang` | OPTIONAL | Contains labels/flags, but no indispensable minimum-V1 semantic decoder has been proven. |
| `DbRepDes` | OPTIONAL | Report/design metadata; no proven extraction requirement. |
| `EFAARC10` | OPTIONAL | Current evidence does not establish required V1 historical sales data. |

Do not widen SQL grants or backup boundaries in anticipation of unproven dependencies.

## Minimum V1 semantic scope

The current required semantic groups are:

1. sale versus sales-return distinction;
2. document identity and header/line linkage;
3. customer and product linkage;
4. document eligibility/state relevant to extraction;
5. currency identity, exchange rate and amount basis;
6. UOM, quantity and quantity direction;
7. authoritative inventory balance and grain;
8. separation/linkage of financial versus stock movement;
9. return relationship to header/line/product/original document where applicable;
10. actual effective monetary amount after material adjustments.

Full payment-channel translation, active-only customer filtering, pricing engine behavior, assembly/manufacturing recipes, complete journal/account dictionaries, stocktake workflow and UI/printing/localization settings are not prerequisites for the minimum V1.

Raw codes may still need preservation even when their full presentation dictionary is outside V1.

Critical semantic warning retained:

**`Bills.Bill_Type` and `journal.doc_type` must not be treated as the same dictionary merely because numeric values happen to match.**

## Why Golden Dataset is now the blocker

Bounded metadata/read probes established access and candidate structures, but many business tables in the educational database are empty. Empty tables cannot prove populated business semantics.

The remaining required proof needs controlled records created through the official Motakamel UI, with known expected values and before/action/after evidence. The Golden Dataset should be minimal and targeted, covering only what is needed to prove V1 semantics such as:

- one known customer;
- one known product/item;
- known UOM;
- known opening/initial inventory where the official workflow supports it;
- one known sale;
- one known sales return, including official linkage when supported.

The experiment must reconcile quantities, inventory effects and monetary amounts rather than infer meanings from names alone.

The key chain to prove is:

`Official Motakamel UI -> EFA12026 -> consistent frozen backup snapshot -> independent least-privilege read-only acquisition`

If all required minimum V1 semantics can be demonstrated and reconciled from `EFA12026` alone, that will provide strong evidence for the decision `EFA12026 ALONE SUFFICIENT FOR V1`. If an indispensable semantic decoder outside `EFA12026` appears, that dependency must be proven specifically before widening the boundary.

## Evidence gate status

1. **System and Version Profile: PARTIAL** — real educational system/version/runtime baseline proven; enabled modules/customization/explicit schema version remain incomplete.
2. **Read-only Access & Isolation: PARTIAL** — least-privilege reads, write/admin denial and single-DB frozen snapshot technique proven; final V1 boundary and production operational qualification remain open.
3. **Source Schema Inventory: NOT STARTED** — targeted metadata probes are evidence reconnaissance, not the full inventory.
4. **Mapping Evidence Table: NOT STARTED** — candidate anchors exist but implementation-safe business mappings are not yet established.
5. **Reconciliation Baseline: NOT STARTED** — targeted Golden Dataset is the next step.
6. **Unsupported/Unresolved Semantics: PARTIAL** — scope narrowed and non-required flags separated from real V1 blockers.
7. **Dataset Size & Performance Profile: PARTIAL** — only small educational lab measurements exist.
8. **Exact V1 Connector Scope: PARTIAL** — minimum business intent is narrowed, but Golden Dataset/mapping evidence is still required before connector readiness.

## What must NOT happen yet

- Do not build the Motakamel connector yet.
- Do not change the Canonical Model based on guesses.
- Do not create a generic YemenSoft connector.
- Do not start a universal schema inspector or mapping DSL.
- Do not use FMMA as DBL's connector identity.
- Do not change source database isolation settings just to satisfy DBL.
- Do not treat successful SQL access as proof of accounting/business correctness.
- Do not treat report labels or equal numeric codes as semantic proof.
- Do not expand the database boundary until an actual required dependency is proven.

## Next single step

**Motakamel V1 Targeted Golden Dataset Qualification** in `DBL-MotakamelPlus-Lab`.

Create the smallest controlled business dataset through the official Motakamel UI, capture each transition separately, reconcile inventory/quantity/amount semantics, and then verify the resulting records from a frozen `EFA12026` backup using an independent least-privilege read-only identity.

Only after this evidence should the project decide whether `EFA12026` alone is sufficient and move toward targeted Source Schema Inventory and Mapping Evidence.
