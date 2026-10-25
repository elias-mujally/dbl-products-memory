# C1 slices and exact proposed file map

2026-10-25 · [Index](README.md) · **Planned files only; none created/changed in the product by this task.**

## Reviewed baseline and implementation choice

Product main: `bccc89ecb077b11ec5476b82a222ed9c4a3487b9`, tree `f1988518b45b94ef303ae79eb0eabb761fd12aa6`. Stage B tests are in unmerged PR22 at `ecba3c2129488fa98bf88355df560bd2f5becf8f`; plan S5 must explicitly include those reviewed tests or await their merge, not assume they are on main. Memory PR16 is still draft/unmerged at the reviewed proposal commit.

Observed: `SqliteSnapshotWriteSession.commit()` owns finalize.immediate(); ordinary store initialize runs migrations and cleans staging; ImportOrchestrator writes completion audit afterward to a separate sink. Application read scope supports pinned latest only. Therefore C1 will **not** refactor that finalize, attach metadata afterward, or use a write-capable LocalStore adapter for Catalog.

## Existing files proposed to change

| File | Planned bounded change | Explicit exclusion |
| --- | --- | --- |
| `packages/core/src/index.ts` | Export new pure state-family discriminator and separate catalog port/DTO types | No change to SourceRef/Product/canonical validation, schema/API version constants or V1 profiles |
| `packages/storage-sqlite/package.json` | Add `./catalog` export for the safe Catalog facade; keep `.` legacy export | No external dependencies or package upgrades; existing workspace build already compiles src |
| `packages/storage-sqlite/src/sqlite-store.ts` | Read-only state-family preflight before opening a writable DB or calling migrations/recovery; reject Catalog | No refactor to legacy commit, migration chain or staging semantics |
| `packages/audit-sqlite/src/sqlite-audit-sink.ts` | Same family refusal before opening a Catalog DB as an audit target | No idempotent audit-delivery feature or new workspace dependency |
| `apps/v1-file-import/src/state.ts` | Refuse Catalog-marked target/root before directory/control/bootstrap writes | Add negative family guard only; do not weaken V1 identity/cardinality, source or ACL guards |
| `apps/v1-file-import/src/operator.ts` | Apply target-family check before any new target creation in restore/backup operations; retain existing V1 marker checks | No changes to Preview1 artifact, source profile, stock logic or existing states |
| `packages/application-service/src/index.ts` | Export a separate catalog application read facade | Do not change existing LegacyIntelligenceApplication behavior or add SQLite access to renderer |

The audit/store/V1 adapters read headers using their Node-side code; a pure discriminator in core accepts bytes/marker metadata, **not filesystem paths or a Node filesystem dependency**. Reference SQLite connector currently opens source read-only and requires items/clients/invoices tables absent from Catalog; test its refusal, but do not modify it unless that test proves a real gap. Any extra writer entry point discovered must be added to the review map before claiming the bypass gate passed.

No root dependency install is needed: Node crypto, better-sqlite3, Vitest and TypeScript already exist. No new workspace/package is introduced. Dependency/lockfile changes are not in this plan; if implementation genuinely needs one, report it before adding/installing it. Existing root build/test order covers core -> storage -> application. Package exports and public type additions are nevertheless real future protocol changes requiring implementation approval.

## New product files proposed

| Slice | Files / purpose |
| --- | --- |
| S1 | `packages/core/src/state-family.ts` (pure recognition); `packages/storage-sqlite/src/catalog/schema.ts`, `state.ts`, `family-probe.ts`; `packages/storage-sqlite/test/catalog/schema.test.ts`, `family.test.ts`, `bootstrap.test.ts` (including pure discriminator tests via core export) |
| S2 | `packages/core/src/catalog.ts` (separate source handles/read ports/DTOs); `packages/storage-sqlite/src/catalog/contracts.ts`, `encoding.ts`, `proof.ts`, `registry.ts`; `packages/storage-sqlite/test/catalog/proof.test.ts`, `registry.test.ts`, `fixture-issuer.ts` |
| S3 | `packages/storage-sqlite/src/catalog/admission.ts`, `events.ts`, `index.ts` (safe facade exports only); `packages/storage-sqlite/test/catalog/admission.test.ts`, `fault-worker.mjs` |
| S4 | `packages/storage-sqlite/src/catalog/reader.ts`, `diff.ts`; `packages/application-service/src/catalog.ts`; corresponding `packages/storage-sqlite/test/catalog/reader.test.ts`, `diff.test.ts` and `packages/application-service/test/catalog.test.ts` |
| S5 | `packages/storage-sqlite/test/catalog/concurrency.test.ts`, `crash.test.ts`, `public-bypass.test.ts`; existing audit and V1 test directories get catalog-family rejection cases; `docs/contracts/CATALOG_ADMISSION_C1.md` and sanitized result/manifest documentation |

Names are the concrete intended review boundaries, not files already present. Core currently has no test command and its typecheck includes src only; keep discriminator tests in storage-sqlite's existing Vitest/test/typecheck path rather than pretend a new core/test folder would run. Internal SQLite connection, schema initialization, verified proof object and transaction helpers are **not** exported from `./catalog`. Applications consume ports; no new storage dependency is required by application-service at runtime.

## S1 — state isolation and schema

After implementation approval, first create a wholly new disposable directory in the existing approved development environment. No source acquisition or Preview1 input. Bootstrap a catalog format marker, application_id and schema in a single initial SQLite transaction, with an explicit incomplete-bootstrap state if interrupted; see schema contract. Do not inspect unrelated state roots as a convenience.

Exit: actual proposed DDL passes syntax/constraint/foreign_key_check tests; source keys cannot cross domains; immutable-row and head guards work; generic catalog-target opens refuse before DDL/recovery. Failed bootstrap is preserved and refused, not auto-cleaned or reused. A second init cannot adopt a partially initialized directory. Existing legacy unit fixtures behave identically.

Rollback: revert S1's source commit in the **development branch** if needed; retain failed new directories/reports privately and use another fresh test directory after fixing. Never strip markers/tables or run down migrations on an accepted state. This task performs none of those actions.

## S2 — source registration and independent proof

Only an owner-side administrative factory can enroll a local source and pin a public key; an input file cannot enroll or pick its namespace. C1 registration is schema-restricted to `synthetic.catalog.capture.1`, trust class synthetic. Tests generate separate Ed25519 keys in memory using the existing Node runtime; the issuer reads a known full fixture independently, computes source-side set evidence, then signs the canonical receipt for a durable request. The import payload does not contain the private key or a key accepted as authority.

Exit: reject wrong company/source/binding/build/epoch/request and incomplete exports including recomputed self-count/hash; invalid key/signature fails. No accepted-row publication API is exported yet. Owner missing-set review is tied to exact receipt/payload/parent and does not override proof. Restore malformed-key/canonical-byte test vectors before expanding grammar; no unknown fields or coercion.

Rollback: disable only the new synthetic test registration via its versioned state control in future tests, or revert S2 in the development branch; do not mutate accepted evidence. Preserve the original failed verifier vectors/results. Registry root compromise or a lying qualified signer is a documented external limit, not a green test.

## S3 — atomic acceptance

One private synchronous immediate transaction owns snapshot/products/source-proof/admission/head/request/event. For <=1 MiB fixtures, keep verified input in bounded private memory and insert all rows inside that transaction; **no persisted multi-commit staging or filesystem pointer protocol in C1**. Recompute the stored product-set digest before sealing admission. The SQL head trigger and deferred linkage require the acceptance unit to be complete. Retrying must resolve accepted capture identity before fresh-request checks.

Exit: A/B accepted once, same capture replayed after reopen, same ID/different content refused; fail each statement boundary and show old or full-new accepted state. Mandatory event exists with every admission. A lost response is reported from durable state on retry, never guessed from an in-memory committed flag.

Rollback: no down migration. Preserve test state, revert the development commit if the change is defective, and rerun the corrected slice on a fresh synthetic state. An already committed capture is not undone because generating a report failed. V1 has not been migrated or used as rollback media.

## S4 — accepted reads and differences

New read-only catalog port opens source-scoped current or a specific accepted snapshot and exposes bounded product pages/diffs. Application-service injects this port and never opens a DB itself. No quantities or money in the C1 capture grammar. Source/epoch/mapping-incompatible comparisons fail explicitly.

Exit: A/B -> revised A/B/C with old values intact, missing B after exact owner review, reappearance without deletion assumptions, two companies using same keys/SKUs isolated; public historical reads work after closing/reopening. No acceptance oracle depends on private SQL; test-only corruption/failure injection is allowed later solely to challenge the guards.

Rollback: reader failures disable the new catalog read facade and preserve accepted state for diagnosis. Revert/fix its code rather than rewriting rows to satisfy expected output. Existing V1 read facade remains unchanged.

## S5 — contention and final qualification

Child processes operate only on the new synthetic directories. Inject process exit before/during/after commit, busy contention, disk/write failure substitutes, key/policy changes between verify and commit, and invalid public API calls. Do not kill host apps, change Defender, permissions, services or SQLite settings on existing states. Record exact runtime/SQLite versions and first failure before a rerun. Real physical power-loss and hardware corruption remain separate from process-crash tests.

Exit: test-family matrix reports all run/blocked/deferred parts; generic APIs cannot return/promote unadmitted catalog data; no mixed current after reopen, no cross-source diff, no duplicate accepted unit/event. Required existing typechecks/tests and Stage B scenarios pass without private evidence. Missing source proofs and incorrect company attribution remain hard failures. Do not expose C1 as an operator/customer package while this gate is open.

Rollback: stop qualification, preserve WAL/SHM and original reports, correct/revert only the faulty development slice; never delete journals, edit IDs, manufacture SQL results or weaken assertions. Resumption repeats affected and relevant regression tests, not every unrelated historical investigation.
