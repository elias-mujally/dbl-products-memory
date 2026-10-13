# Historical Inventory Storage Compatibility Gate #001 — implementation and STOP

Decision: **STORAGE COMPATIBILITY GATE = PASSED; FIRST HISTORICAL INVENTORY OFFLINE INTEGRATION = BLOCKED / NOT PASSED.**

Owner authority: bounded offline versioned Product-table implementation following `c4ce16f`, with one end-to-end import only after compatibility qualification. This does not authorize SQL/ERP, production database changes, merge, or sales work.

## Implemented code, retained for independent review

Local branch `codex/historical-inventory-offline-001` in `work/dbl-legacy-intelligence`; local commit **`0c325c8a0695bfe21747783548eb1ec7f60bfdeb`**. No code push, PR, merge, or deployment. Baseline commit `84eadfddfd064ada961e36675ceffe24e33f2f3a`, tree `51f15b2a1113fc3742559f7d76dab350fb8bb83c`, the merged PR12 implementation tree.

- Optional typed `Product.historicalInventoryObservation`, separate from `quantityOnHand`, Canonical `2.1.0`. Contains fact ID/schema version/quantity/scope/balance kind/source-as-of/acquisition interval/full source, FACT, original evidence and backup references/`liveRead=false`/caveats.
- Exact-key validation with enumerable data fields; rejects missing/extra metadata, scope/quantity conflicts, wrong profile/product, live claims, future acquisition, invalid calendar/offset, and reversed intervals including sub-millisecond precision. Historical age is disclosed, not treated as freshness. This deliberately bounded v1 accepts nonnegative safe-integer DecimalStrings only, not arbitrary fractional inventory.
- New migration **4** adds observation JSON, renames Product tables to `snapshot_products_v4` and `snapshot_staging_products_v4`, and adds per-snapshot/per-stage unique fact-ID indexes. Earlier migrations 1–3 unchanged. No permissive legacy views.
- Writer/commit/staged fingerprint/new SnapshotReader carry complete JSON. The reader rejects unsupported snapshot versions and historical missing metadata or fingerprint mismatch. Old observation-free 2.0 snapshots remain readable by the new implementation.
- A narrow compatibility DML trigger on `snapshots` and `snapshot_staging_sessions` additionally rejects connections lacking `dbl_storage_v4_capability()`. This was necessary because the actual old `initialize()` deletes abandoned parent staging rows before querying Product tables; rename alone would not protect active historical staging from cascade deletion. This signal is **not authentication or an integrity boundary against the database-file owner**.
- New file-only connector/profile `@dbl/connector-historical-inventory`, no SQL driver. Pins complete FACT and original evidence bytes, checks historical Reader result/source/backup/time/product binding, and maps the actual FACT quantity. No hardcoded quantity oracle. The current live Motakamel connector, TLS, Canonical `quantityOnHand` semantics, and existing Insights rules are unchanged.
- New application preview function queries a pinned application read scope, checks its historical context, and renders the Arabic historical label, scope/as-of/source/provenance/`liveRead=false` and not-current/not-physical warning. **It has not yet been demonstrated on a successfully imported historical snapshot.**

## Actual local qualification

Pinned Windows Node `v22.23.2`; no package upgrades or new external runtime dependencies (new workspace package entry only).

`build`: PASSED. `typecheck`: PASSED. `npm test`: **258 passed, 1 skipped** across existing affected workspaces. The skipped test is the pre-existing opt-in live SQL test, intentionally not enabled. New historical connector suite: **27 passed with the real owner artifacts present**, including negative provenance/scope/duplicate/time/live/general-quantity cases and file-hash failures. These source-backed tests explicitly skip if the actual artifacts are absent on another host; no synthetic positive replacement is used. External CI/Linux tests were **not run**, and no claim is made for them.

An initial offline validation test run exposed a timezone regex capture-index error; it was corrected and the full build/typecheck/test run above passed **before** the integration harness was attempted. No actual import was used to debug it.

Task evidence directory: `outputs/host-historical-inventory-offline-integration-001-20261014/`.

The actual old implementation was preserved before rebuilding (30 old module/native pins plus pinned Node, manifest retained), not replaced by mocks. `GATE_RESULT.json` at `2026-10-13T21:50:35.643Z` (14 October local) proves:

| Required gate | Actual result |
|---|---|
| Old SnapshotReader / old application Product query | Rejected with missing legacy Product-table error, not incomplete Product |
| Old default initialize cleanup | Rejected at missing capability function; active new staging Product preserved |
| Old begin-write and old Product append | Rejected; append still fails on missing legacy staging table even when capability function is manually registered |
| SchemaVersion-only bypass | Rejected for 2.0.0, 2.1.0 and 3.0.0; changing header version does not restore old table names |
| New full observation staging | Complete JSON equals mapped actual FACT observation |
| Existing observation-free snapshot migration/read | Complete baseline data and fingerprint preserved |
| Foreign keys / stage abort cascade | Passed |
| Injected migration-4 failure | Transaction rolls back rename, new column and migration record; original layout remains |
| Legacy views | Absent |

Compatibility tests did not call ImportOrchestrator. The legacy preservation fixture uses the actual source product identity but is not offered as proof of a historical import or ERP business read. The old-reader rejection was exercised on the migrated layout; a committed historical observation was not available because the subsequent import never began.

## Integration attempt — exact stop and cause

The one task-local harness invocation in `real` mode returned:

```json
{"Decision":"OFFLINE_INTEGRATION_BLOCKED_STOP","Phase":"OneImport","SafeCode":"BOUNDED_FAILURE","RawErrorPublished":false,"ImportAttemptExists":false,"SQLServerConnections":0,"NoAutomaticRetry":true}
```

**Cause: my task-local JavaScript harness used the audit API incorrectly**, not an ERP, TLS, Reader, or historical source failure. At line 96 it passed `{filename: ...}` to `SqliteAuditSink`, whose existing contract requires `{databasePath: ...}`, then invoked `await audit.initialize()`, a method that the audit sink does not have (its constructor initializes it). The installed SQLite dependency defaults an undefined filename to an anonymous database, so the first definite invalid call is the nonexistent initialize method. This cause is established by static source review; the catch retained the original generic safe code and was not rewritten.

The untyped external harness was not covered by workspace TypeScript checks. This is the remaining preparation gap. No error exception or business export was published to diagnose it.

After STOP, independent **readonly** inspection of the task-local files at `2026-10-13T22:00:43.400Z` confirmed:

- Historical integration SQLite exists but has **0 committed snapshots, 0 Product rows, 0 staging sessions** and no FK errors.
- `IMPORT_ATTEMPT.json` is absent; execution failed before the marker and before `importFrom`.
- **ImportOrchestrator calls = 0**; no named audit SQLite, readback, or Arabic preview exists.
- Migration rollback SQLite has its original Product columns, without the historical column, and no FK errors.
- FACT and original evidence complete SHA-256 values remain unchanged.

No harness correction or automatic retry was performed after failure. All failed and successful artifacts are retained. No quantity from a sidecar is presented as a DBL-storage readback. The full close/reopen round-trip, committed historical fingerprint, application read and Arabic output, and four planned negative committed-copy checks remain **NOT EXECUTED**.

## Pinned artifacts and evidence

| Artifact | SHA-256 |
|---|---|
| Qualified FACT | `0DE22CE4304839AC2D9807A45F448900C598F55177596A374D5A8E230A6FD670` |
| Original qualification evidence | `7D742175B6652860C7974115F8A1CBB789F49D86ACAD4FC5DD40CFCE310E7BAC` |
| GATE_RESULT.json | `FD3DE7041AEBF315EC6456F5B1F4670CD0248F0436B0CF50B1355D5B604C87F3` |
| FAILURE.json | `5690EF9D74048488492542816D8CF8069864289DF45A31642D88410BF56353A6` |
| Failed run-integration.mjs (preserved, do not rerun) | `4682C62EFCD30EC20E89C30091C936341C3BC01FA26DBD758A1A252128B61BB3` |

Historical source still means the post-S2 frozen image, B1/W1/UA/package1, source-as-of `2026-10-09T08:12:11+03:00`, backup UUID `2b9d2bde-8d89-4ee7-98de-224fb97060c7`, backup SHA `E63DF84D2DBB22C5ACD535DC5881D2DCF417F420665502927EBD9AD66731E572`. The source-backed mapper extracts historical 37 from the qualified evidence; it is not a current balance, physical count, or successful DBL insight yet.

Nonsecret status evidence is attached as [result record](DBL_HISTORICAL_INVENTORY_STORAGE_GATE_AND_INTEGRATION_STOP_001_RESULT.json). Raw business exports, native files, SQLite files, and local legacy build remain local; they are not added to Product Memory Git.

## Minimum separate follow-up authority required

Approve correction of **only the task-local harness** to use `databasePath` and constructor initialization, and offline API-shape/typed checking before execution. Retain original failed helper/results/empty SQLite unchanged. Then authorize one first actual ImportOrchestrator import into a **new isolated directory/database**, followed by planned reopen/read/application/Arabic-preview and negative-copy checks. Existing passed compatibility gate must not be repeated unnecessarily; revalidate code/source pins. No additional architecture change, SQL or permissions work is proposed.

Until that approval, **STOP**. Code remains local and unmerged. No SQL/ERP/credentials, production SQLite/FIRST LIVE DATA, Reader/TLS/host settings, live source qualification, administrative identity criteria, or sales work changed. `INVENTORY SOURCE QUALIFICATION` remains NOT PROVEN and current FindAvQty definition remains NOT TESTED. `.vscode` remains excluded.
