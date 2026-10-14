# First Historical Inventory Offline Integration #001 — PASSED

> Historical checkpoint preserved. [Merged state 2026-10-14](MERGED_STATE_2026-10-14.md) and [evidence register](EVIDENCE_REGISTER_2026-10-14.md) supersede earlier implementation/next-step gaps only within the qualified offline case. PR13/14/16/15/17 are merged; one inbound37 is qualified separately from historical balance37. No current stock, outbound, physical count, final GL posting, generalized ledger or live ERP qualification follows. Original failures/results/hashes below remain their original evidence; no raw re-verification or helper execution in this memory update.

**FIRST HISTORICAL INVENTORY OFFLINE INTEGRATION = PASSED.**

Actual execution: `2026-10-14T03:47:09.336Z`–`2026-10-14T03:47:09.460Z` (06:47+03 local). This is a bounded offline historical insight, not a new SQL inventory read or current balance.

Owner authority: correct only the local harness audit API following code commit `0c325c8` and Product Memory `e202c58`; qualify it offline, then one first actual ImportOrchestrator import into a new isolated SQLite and verify complete DBL readback. Product code remains **`0c325c8a0695bfe21747783548eb1ec7f60bfdeb`**, branch `codex/historical-inventory-offline-001`, tracked tree clean. No additional contracts, migrations, live connector, or production code changes; no application-code push/merge/deployment.

## Bounded correction and prevention

New local evidence directory: `outputs/host-historical-inventory-offline-import-001-20261014/`. The previous directory `outputs/host-historical-inventory-offline-integration-001-20261014/`, including failed harness/results/empty SQLite/legacy build and passed compatibility gate, is unchanged.

The corrected harness uses a tiny local typed adapter `createAudit(databasePath)` calling `new SqliteAuditSink({databasePath})`. The sink initializes in its constructor; there is no call to `audit.initialize()`. The old gate-execution branch was excluded from this new harness; the existing passed gate is used as evidence, not rerun.

Fresh offline preflight **PASSED**, at `2026-10-14T03:46:52.897Z`:

- Actual existing declaration types accept correct factory/orchestrator wiring. `@ts-expect-error` negative compile checks prove that the old `{filename}` option and `.initialize()` call are rejected.
- Runtime factory rejects empty databasePath, exposes the existing append/list/close API, has no initialize method, and passes append/list verification in **memory-only SQLite**. This is an API probe, not a historical import or synthetic source proof.
- New harness syntax qualified. Only the task-local factory was compiled; product build and successful workspace tests were not repeated.
- **424 file pins** cover current tracked code, relevant built modules, native SQLite/runtime, FACT/original evidence, local helper sources and all previous attempt-directory artifacts. Commit and tracked cleanliness are also checked. Pin verification succeeded before import and again after the experiment. File pins ensure consistency, not protection against a malicious filesystem owner.
- No SQL/ERP connection, credentials, or ImportOrchestrator call occurred during preflight.

Preflight record: [PREFLIGHT_RESULT](research/DBL_HISTORICAL_OFFLINE_IMPORT_001_PREFLIGHT_RESULT.json). The earlier build/typecheck/258 passed tests and intentionally skipped opt-in live SQL test remain their historical results; no new external/Linux/Windows CI claim is made.

## One actual offline import

Source is the **original qualified FACT file**, backed by the original preserved Reader SQL evidence, not a fixture or manually constructed positive snapshot. Complete source pins:

- FACT SHA256: `0DE22CE4304839AC2D9807A45F448900C598F55177596A374D5A8E230A6FD670`
- Original evidence SHA256: `7D742175B6652860C7974115F8A1CBB789F49D86ACAD4FC5DD40CFCE310E7BAC`

Path proved:

`Pinned FACT + original evidence → file-only connector/profile → Canonical 2.1 observation → ImportOrchestrator → staging/committed SQLite v4 → close/reopen → SnapshotReader → application query/read scope → Arabic preview`

Actual ImportOrchestrator calls **1**, import attempts **1**, batches processed **1**; retry policy maxAttempts=1 and shouldRetry=false. Operation ID `e4c2b50a-ca94-417f-bf80-6891c5dcd10f`. Snapshot:

`historical-inventory-v1-0de22ce4304839ac2d9807a45f448900c598f55177596a374d5a8e230a6fd670`

Checkpoint content fingerprint:

`643cc2a5b464c34a06dbaead89eca062445ca64674c551d9095fe0c09e911f58`

Counts **products=1, customers=0, sales=0**. `auditComplete=true`, no warnings. Independent readonly audit inspection found exactly one event each for `import.started`, `connector.health.ok`, and `import.completed`.

## Full stored meaning verified after reopen

The new SQLite was closed after import and reopened before SnapshotReader and application access. Complete mapped Product JSON matched the reopened SnapshotReader Product, and the application query items matched the SnapshotReader data. A recomputed fingerprint matched the committed checkpoint. Readonly native inspection additionally compared committed JSON with the complete readback.

| Element | Value preserved in DBL |
|---|---|
| Product | `DBL_P001_ITEM_A` / `DBL_ITEM_A` |
| Observation schema/fact | `1.0.0` / `historical-inventory-001-7d742175b6652860` |
| Quantity, extracted from source | DecimalString `37`, unit `UA` |
| Scope | Branch 1, warehouse 1, package 1 |
| Balance kind | `erp.available.book.historical` |
| Source-as-of | `2026-10-09T08:12:11+03:00` |
| Historical acquisition | `2026-10-09T08:16:58.287468+03:00` → `2026-10-09T08:17:01.0517634+03:00` |
| Source | `DESKTOP-8QRQT7R\YSEDU` / `DBL_HOST_W11_EFA12026_PostS2_Frozen_20261009` |
| Backup UUID | `2b9d2bde-8d89-4ee7-98de-224fb97060c7` |
| Backup SHA256 | `E63DF84D2DBB22C5ACD535DC5881D2DCF417F420665502927EBD9AD66731E572` |
| Provenance | FACT/original evidence hashes and pointers, historical function definition hash, source Reader, backup/as-of, qualified scope and recorded Reader quantity |
| Live flag | `liveRead=false` |
| General quantityOnHand | Absent from Product; SQL column NULL |

Full acquisition strings retain offsets and sub-millisecond precision inside observation; the generic Canonical capturedAt is the existing millisecond UTC timestamp and is not substituted for them. Caveats survive the round-trip. The old FACT caveat saying it was not yet imported was excluded from the new snapshot as a superseded artifact-state statement; the source FACT bytes were never edited.

Arabic output **generated from the stored DBL application read scope**, not directly from FACT:

> الرصيد المتاح المؤهّل تاريخيًا
>
> DBL_ITEM_A — 37 UA — الفرع 1، المخزن 1، العبوة 1.
>
> تاريخ الصورة: 2026-10-09T08:12:11+03:00. liveRead=false.
>
> ليس رصيد اليوم ولا جردًا ماديًا.

The complete local `DBL_ARABIC_PREVIEW.md` also includes source, acquisition interval, factId, FACT/evidence/backup hashes, snapshot and caveats. Requested opening in Codex was queued by the UI; no claim of a screenshot/rendering inspection is made.

## Negative copies and independent readonly verification

After closing the qualified success SQLite, each test mutated a **separate copy only**, without another import:

| Mutation | Actual expected rejection |
|---|---|
| Missing stored observation | `INVALID_HISTORICAL_INVENTORY` |
| Scope mismatch | `INVALID_HISTORICAL_INVENTORY` |
| Quantity plus recorded-quantity changed together | `SQLITE_HISTORICAL_FINGERPRINT` |
| Unsupported snapshot schema 2.9.0 | `SQLITE_UNSUPPORTED_SNAPSHOT_VERSION` |

All four produced the exact expected error code. Qualified SQLite hash remained identical after negative-copy tests and readonly inspection. `PRAGMA integrity_check=ok`, no foreign-key violations, one committed snapshot/Product, zero leftover staging sessions. Existing actual-old-reader/old-application/old-writer/migration rollback evidence remains PASSED and unchanged, not rerun. The compatibility capability function remains a signal, not authentication.

## Authoritative local artifact hashes

| Artifact | SHA256 |
|---|---|
| Corrected run-integration.mjs | `BDEBB6392B4EE3080FDF7D87E155045232137C42F363B94D639E6131CD3ED9A4` |
| Typed audit-factory.mts | `7324FA6F9D5F767DCABAAC661D8E81A29AC46E80BC08B8F47D9EC18781AC5459` |
| Emitted audit-factory.mjs | `21E4DE354D3FFD5E9CE1F28B5DBD574ECB34594D9BC4CA731CBBF2DB4BE86E77` |
| preflight.mjs | `3EC23A5082B02715FC5E54F68EAB94756B444F3DD1372A97356F163BBAE33D40` |
| PINS.json | `CF27B2D3BCA87AE744A8A841248D49CF511A43AB8C7EECA4D0AF34FE33F3CDBD` |
| PREFLIGHT_RESULT.json | `95F4DECCE7488C4BCF34E069A165BD6D9BD546A5146067CB4501FCD343E48DA6` |
| RESULT.json | `D8182EA292E4773C9247DBA25FA5EFCC33FAB2DC3C4729B996D947640BBE1199` |
| HISTORICAL_INTEGRATION.sqlite | `23D50CD2E1FBEF9AEB6CFDE9E739D42C5CD18295045BD0BD76E2438C9972B91D` |
| HISTORICAL_AUDIT.sqlite | `C0D509088327FA227B5C17929230C51514BB3DEE6D019BB7F139367C908B3AC6` |
| DBL_READBACK.json | `3EE29B0397C37961C67CB1A1F520E522A163C51930F50F7D893C7C5F249B6AF4` |
| DBL_ARABIC_PREVIEW.md | `31A1DE046FDCFA9AD7E165347FF725B2D46CA2871E6756F72C5B0005D1E6E02C` |
| POST_IMPORT_READONLY_VERIFICATION.json | `ADBB7586E2F2F9A22EB941911CC1F92B5E507B2610B913B1769A43A8B47795D0` |

Status copies in Product Memory preserve JSON content but may normalize formatting; the hashes above refer to authoritative **local original artifacts**. [Import result](research/DBL_HISTORICAL_OFFLINE_IMPORT_001_RESULT.json), [readonly verification](research/DBL_HISTORICAL_OFFLINE_IMPORT_001_POST_IMPORT_READONLY_VERIFICATION.json). No raw ERP export, SQLite, native binary, credentials, or secret material added to Product Memory.

## Limits and STOP

Historical 37 is the qualified available/book quantity in the frozen post-S2 image, not today's writable ERP inventory, physical count, reservation, or promise-to-sell measure. Zero-row business provenance remains PARTIAL; no cancelled draft issue5/new movement synthesized. The source float(53) control is an exact safe-integer case only. Backup UUID/hash are linked through pinned historical evidence; backup file and current SQL database were not reopened/rehashed. Current FindAvQty definition remains **NOT TESTED**, live inventory source qualification **NOT PROVEN**, administrative identity gates unchanged, and previous FIRST LIVE DATA proof unchanged.

SQLServer connections=0; ERP started=false; FindAvQty calls=0; credentials requested=false. No Reader/TLS/host changes, production SQLite or earlier FIRST LIVE DATA snapshot touched, product-code change, additional import, merge/deployment, or sales work. This closes the approved **offline historical integration** criterion only. STOP for owner independent review and separate authority before any further implementation/live/product release.
