# AlMuhaseb1 Lab Progress — 2026-09-01

## Purpose and scope

This note records the current AlMuhaseb1 investigation so future sessions do not lose the evidence, repeat work, or accidentally turn this lab into a change of product direction.

**AlMuhaseb1 is a legacy acquisition laboratory and evidence source. It is not a replacement for the current Primary First Connector Target, YemenSoft Motakamel Plus.**

The investigation is useful because it exercises the exact difficult boundary DBL Legacy Intelligence must learn to handle: old accounting software, opaque storage, runtime report generation, source isolation, accounting reconciliation, and system-specific acquisition knowledge.

## Product-context guardrail

The product remains a **Local-First Legacy ERP Intelligence Layer**. The core direction remains:

`Legacy ERP -> System-specific Connector -> Import Orchestrator -> SQLite -> SnapshotReader -> Query/Insight Engines -> Application Service -> UI/Reports/future AI`

The AlMuhaseb1 work must preserve the existing principles:

- local/offline-first;
- read-only toward customer legacy systems in V1;
- no free-form SQL;
- AI is not execution authority;
- exact decimal and currency-safe semantics;
- closed-world runtime validation;
- explicit provenance;
- bounded/streaming processing;
- source-specific connectors;
- semantic reconciliation and operational qualification before connector readiness;
- implement first, abstract second.

Do not expand the Canonical Model or build generic acquisition frameworks merely because AlMuhaseb1 exposes unusual legacy behavior.

## Why AlMuhaseb1 was investigated

The original artifact exposed a real legacy accounting application using VB6/DAO/Jet/Access and Crystal Reports. Direct read-only ACE/DAO access to the protected MDB was not available without credentials, and the investigation explicitly rejected brute force, password cracking, credential extraction, authentication bypass, and direct MDB writes.

The resulting working acquisition hypothesis became:

`Official Backup -> Disposable Full Company Copy -> Official AlMuhaseb1 / Crystal Workflow -> Structured Export -> Normalization -> Reconciliation -> DBL-ready acquisition artifact`

This is an acquisition-boundary experiment, not yet a connector implementation.

## Static and runtime findings before the isolated VM

- Application stack: VB6 + DAO/Jet + Crystal Reports.
- 178 Crystal Reports were analyzed.
- Static reconstruction produced a runtime model approximately:
  `VB6 -> DAO/Jet -> Business Tables -> Crystal Reports`.
- Candidate business objects/tables observed in report/static evidence included names such as `item_detail`, `Customer`, `Bills`, `Bill_detail`, `item_store`, and `RT_BILLS`, but names alone are not accepted as schema/semantic proof.
- Official `.bak` artifacts are themselves Jet/Access database artifacts.
- Crystal reporting was proven capable of producing structured exports for five domains, but report execution also mutated the working MDB, so direct operation on a customer source is not an acceptable V1 boundary.

## Golden Dataset established through the normal application UI

A controlled dataset was created through AlMuhaseb1's normal workflows. Important known values are:

- Warehouse: `1`, `DBL_TEST_WAREHOUSE_001`.
- Inventory Group: `001`, `DBL_TEST_GROUP_001`.
- Product: `DBL_TEST_PRODUCT_001`.
- Product identifier: `DBL-P-001`.
- Initial inventory mutation: `37`.
- Customer: `DBL_TEST_CUSTOMER_001`.
- Sale quantity: `3`.
- Unit price: `1234.56`.
- Sale gross: `3703.68`.
- Return quantity: `1`.
- Return amount: `1234.56`.
- Expected final inventory: `35`.
- Expected net sales: `2469.12`.

Known reconciliations:

- `37 - 3 + 1 = 35`
- `3 × 1234.56 = 3703.68`
- `1 × 1234.56 = 1234.56`
- `3703.68 - 1234.56 = 2469.12`

A COA anomaly around accounts `411`/`412`, posting semantics, and COGS remains unresolved and must not be silently normalized.

## Isolated Hyper-V laboratory

To close the source-isolation and repeatability gap, a dedicated Hyper-V Windows VM was prepared:

- VM: `DBL-AlMuhaseb1-Lab`.
- Windows 10 Pro guest.
- Clean checkpoint: `C0-Clean-Windows`.
- AlMuhaseb1 installer and T7 were transferred with SHA-256 verification.
- AlMuhaseb1 installed successfully inside the VM.
- Network remained disconnected during the controlled experiment.
- The application was not run on the Host during the experiment.
- Host source artifacts were treated as immutable evidence.

AlMuhaseb1 launched successfully in the VM. T7 was then restored through the application's official restore workflow rather than by direct MDB modification.

Post-restore verification confirmed the Golden Dataset through the GUI:

- product/customer present;
- inventory `35`;
- invoice 1 quantity `3`, total `3703.68`;
- return 1 linked to it, quantity `1`, value `1234.56`.

The transferred T7 source remained unchanged in SHA-256, size, and modification time. After normal application shutdown, the restored lab database matched T7 at that checkpoint and the application/Crystal processes were stopped.

A second checkpoint was created and verified:

`C1-T7-Ready-for-Acquisition`

This is the controlled baseline for acquisition experiments.

## Final A/B Proof-of-Path experiment result

Two independent acquisition attempts were run from controlled VM state. The quality gate correctly retained:

**B — PARTIALLY PROVEN**

### Proven structured domains

Five structured business export domains were obtained independently in both runs:

1. Products.
2. Inventory.
3. Customers.
4. Sales Headers.
5. Sales Return Headers.

Normalized business records for these five domains matched across the two runs. Some report-date differences were classified as non-business metadata. An additional unlabeled date difference in the product export remained unresolved.

### Not proven

The experiment did **not** prove connector-grade structured acquisition for:

- Sales Lines.
- Sales Return Lines.
- Header-to-line relationships for those two domains.

Therefore the Golden Dataset quantities `3` and `1` and unit price `1234.56` are still known from application behavior/GUI but are not yet proven from accepted line-level structured exports.

The independent exports do support:

- sale header amount `3703.68`;
- return header amount `1234.56`;
- net sales reconciliation `2469.12`;
- initial inventory `37` and final inventory `35` through accepted inventory evidence.

### Runtime/source isolation evidence

The original Host sources remained unchanged. T7 remained unchanged. Writes/mutations occurred only in disposable VM working state as far as the captured evidence shows.

The working MDB changed during the extraction attempts:

- Run A growth: `385,024` bytes.
- Run B growth: `393,216` bytes.

There were monitoring interruptions/restarts, so the evidence does not yet prove one fully continuous seven-domain monitored run. This is another reason the result remains B rather than A.

## Focused line-level investigation after A/B

Because repeating the same A/B procedure would only reproduce the same gap, investigation shifted to the specific blocker.

Within the VM:

- Invoice 1 and Return 1 were recalled successfully and their lines were visible in the application.
- Attempting the relevant detail previews failed with **Automation error**.
- Runtime capture proved that the application reads the correct Crystal detail reports.
- No structured line export was produced.
- Crystal inspection exposed formula/schema problems, including an unknown field reference involving `rt_bills.Tax_Value` relative to the report definition.
- It is **not yet proven** that `rt_bills.Tax_Value` is the runtime root cause of the Automation error.
- The discrepancy `3704` vs `3703.68` remains unresolved and must not yet be classified as rounding or a business-semantic difference without evidence.
- After normal shutdown, the observed lab file set and the original Host source set retained their hashes in the latest focused attempt; temporary activity remained inside the VM.

## Exact current blocker

The current blocker is no longer simply “we cannot find sales lines.”

The application can display the relevant lines and reaches the expected Crystal detail reports, but the **detail report preview/export path fails at runtime with an Automation error before a connector-grade structured line artifact is produced**.

The next diagnostic question is therefore narrow:

> What is the first failing Crystal/DAO runtime invocation, with what component/operation/error code, and is it reproducible without capturing credentials?

The active next experiment is to capture the first failing Crystal/DAO call for Sales Detail and Sales Return Detail separately, including HRESULT/COM/DAO error information and the last successful operation before failure. Credentials must not be captured. No `.rpt`, MDB, DLL, or OCX repair/modification should be attempted until the root cause is evidenced.

## Decision gate before any AlMuhaseb1 connector

Do **not** build an AlMuhaseb1 connector yet.

An upgrade to `A — PROVEN WORKING` requires, at minimum:

- a legitimate acquisition path for Sales Lines and Sales Return Lines;
- header/line relationships evidenced;
- Golden Dataset line-level reconciliation including quantities and unit price;
- semantic repeatability across independent A/B runs;
- source isolation demonstrated strongly enough for the chosen acquisition boundary;
- no brute force, auth bypass, credential extraction, or direct MDB modification.

Until then the evidence remains valuable research, not connector readiness.

## Relationship to Motakamel Plus

Do not conflate AlMuhaseb1 and Motakamel Plus.

The Product Memory's current strategic target remains **YemenSoft Motakamel Plus ERP** as the Primary First Connector Target, pending real system/version/schema evidence. AlMuhaseb1 should not be used as a schema substitute for Motakamel Plus, and AlMuhaseb1-specific Crystal/Jet findings must not be projected onto Motakamel.

The AlMuhaseb1 lab nevertheless contributes durable acquisition knowledge: how to establish immutable source baselines, Golden Datasets, disposable-copy boundaries, semantic reconciliation, report/runtime observation, and evidence gates for difficult legacy systems.

## Current stop point

As of 2026-09-01:

- AlMuhaseb1 Proof-of-Path decision: **B — PARTIALLY PROVEN**.
- VM baseline `C1-T7-Ready-for-Acquisition` exists.
- Five structured domains are repeatably evidenced.
- Sales Lines and Sales Return Lines remain the blocking gap.
- The detail reports are reached but fail with an Automation error.
- `rt_bills.Tax_Value` is a lead, not a proven cause.
- `3704` vs `3703.68` remains unresolved.
- 411/412, posting, and COGS remain unresolved.
- No connector has been built.
- DBL implementation and Canonical Model have not been changed because of this investigation.
- Product Memory should only be updated again when the runtime failure is diagnosed, the line-level path changes materially, or the A/B decision changes.
