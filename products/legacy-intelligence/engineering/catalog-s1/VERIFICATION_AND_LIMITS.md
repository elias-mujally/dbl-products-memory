# S1 verification, repairs and reproduction

2026-10-25 · [Index](README.md). Product baseline tree `f1988518b45b94ef303ae79eb0eabb761fd12aa6`; remote main parent `bccc89ecb077b11ec5476b82a222ed9c4a3487b9`. Final product head `d76bc71f1cf5320c43edbde4c4d6076436d5bb1a` in Draft PR23. Local work used independent branch `codex/catalog-s1-20261025`; unrelated Stage B drafts/local files were preserved and excluded from publication.

## Actual execution sequence

| Step | Actual result and correction |
| --- | --- |
| Initial target build | TS2571: pragma foreign_key_check result was unknown. Fixed a type annotation in new state.ts; no SQL/guard change. An initial smoke used emitted JS despite that type error, so it was not counted as a successful build qualification |
| Initial schema smoke | Installed SQLite reported 3.51.3 and executed 13 tables/32 triggers. Original prototype state retained privately |
| First S1 suite | 47 cases: 45 passed, 2 failed. Test assumptions, not schema relaxation: readonly WAL inspection can create WAL/SHM sidecars; the attempted bad checksum string hit its length CHECK before the intended inspection test |
| Test repairs | Permit only legitimate sidecars and still verify main DB/marker bytes; inject a wrong 64-character checksum in a disposable fixture and restore the original immutable trigger before inspection |
| Second S1 suite | 51 passed, zero failed/skipped; added exact review/request linkage, synthetic-only class and positive V1 backup/restore boundary coverage |
| Public export test/typecheck | Test's literal self-package import caused TS2209 root inference. Load the compiled package name dynamically at runtime in the test instead; production types stay strict and no tsconfig/dependency change |
| Pre-hardening focused regression | 191 cases: 187 passed, zero failed, four Windows-conditional skips. Includes 53 S1 cases and 134 existing passes |
| Pre-hardening S1-only rerun | 53 passed, zero failed/skipped, including the test-loader correction |
| Final S1 hardening | Review found a leaf-file symlink could evade header classification in legacy store/audit. Both now refuse redirected targets before open, including dangling aliases. Added a real POSIX file-alias regression; Windows skips creation instead of requesting elevated privileges. No changes outside the approved S1 files |\n| Hardened final runs | S1: 54 cases, 53 passed / zero failed / 1 Windows-conditional skip. Focused regression: 192 cases, 187 passed / zero failed / 5 platform skips, including S1 |\n| Final build/typecheck | core, storage-sqlite, audit-sqlite and v1-file-import passed with the existing toolchain |
| Publication verification | Restored existing files' baseline LF endings after connector publication initially caused formatting churn. Follow-up fast-forward commit preserved history, no force push; final base diff is the bounded code/guard changes plus new files |

No proposed SQL table/FK needed weakening to pass. The reviewed schema blocks ran successfully; 28 required seal/metadata/request/control guards complement the four reviewed central triggers. Schema fingerprint/checksum detects structural drift without migrations on open. This is a schema result, not validation of a source attestation algorithm.

## Tests actually exercised

- All thirteen STRICT tables, supported runtime, schema fingerprint, version/checksum/marker matching and FK integrity after reopen.
- Positive **structural** SQL fixture with snapshot, products, event, matching consumed request and automatic head. Missing event/consumption/wrong consumed identity fails deferred COMMIT and rolls back the whole fixture. These are unsigned toy rows, not trusted imports.
- Cross-company product/head references fail; equal IDs/SKUs in separate domains remain independent. Duplicate product key, row count mismatch, stale expected parent, orphan snapshot and invalid type/count/class fail.
- Immutable rows reject UPDATE/DELETE and REPLACE; product seal prevents append after structural admission; request identity/terminal transitions and control revision guard work; head cannot regress/move source/delete.
- Exact owner-review request/registration/event FK linkage using toy SQL, not an implemented owner review workflow.
- Pure state-family discrimination; early legacy store/audit refusal; copied Catalog DB without marker; V1 lock/inspect/report/nested destination refusal; reverse refusal for V1/foreign nonempty/mixed roots.
- Unchanged legacy migration runner stops at the future-lineage fence before its staging recovery. This tests reviewed source behavior, not execution of Preview1 or every old binary.
- Four real child-process bootstrap exits: before transaction, after schema DDL inside transaction, before COMMIT, and immediately after COMMIT. Only interrupted bootstrap is qualified; S3/S5 admission crash/concurrency is not.
- Existing V1 synthetic import/history/replay/audit/backup/restore tests, ordinary storage/migrations, WAL lifecycle and audit tests selected explicitly. No owner-evidence file was provided or read.

The four skipped existing cases are two POSIX mode/umask tests, a redirected-backup-ancestor symlink case and a dangling-symlink publication case, all already skipIf(win32). The additional S1 native file-symlink case is also Windows-conditional; rejection is implemented, but native Windows symlink creation was not exercised. Windows ACL/reparse/privacy qualification is **not** inferred from a POSIX mode argument or these skips.

## Reproduce within approved development setup

No installer or new dependency is needed. Use the approved existing Node 22 runtime and already installed locked workspace dependencies. Build the four affected packages first, since child tests exercise the compiled public export. Do not run delivery assembly, Preview1 or actual owner-evidence tests.

```text
node node_modules/typescript/bin/tsc -p packages/core/tsconfig.build.json
node node_modules/typescript/bin/tsc -p packages/storage-sqlite/tsconfig.build.json
node node_modules/typescript/bin/tsc -p packages/audit-sqlite/tsconfig.build.json
node node_modules/typescript/bin/tsc -p apps/v1-file-import/tsconfig.build.json
node node_modules/vitest/vitest.mjs run packages/storage-sqlite/test/catalog --maxWorkers=1
```

Typecheck the same four package tsconfig.json files with `--noEmit`. Focused regression command:

```text
node node_modules/vitest/vitest.mjs run packages/storage-sqlite/test packages/audit-sqlite/test apps/v1-file-import/test/bootstrap.test.ts apps/v1-file-import/test/operator.test.ts apps/v1-file-import/test/refresh.test.ts apps/v1-file-import/test/state-publication.test.ts packages/connectors-motakamel-plus/test/v1-acquisition.test.ts packages/import-orchestrator/test/orchestrator.test.ts packages/import-orchestrator/test/integration.test.ts --maxWorkers=1
```

Never substitute `npm test` plus owner evidence and call it the same bounded run. New S1 fixtures create only their own temporary directories, close connections and retain those diagnostic fixtures; they do not delete or repair existing states. Existing regression fixtures use their already established scoped cleanup. Private JSON reports/absolute paths/SQLite files remain outside GitHub; public source/report SHA-256 values are in the manifest. New executions have different report hashes because paths/timings/UUIDs change.

## Qualification and remaining gates

PASS is limited to an isolated synthetic schema and supported-API family boundaries on the current Windows developer host. Read-only SQLite inspection may create auxiliary WAL/SHM files in the new state; no read-only logical database-content mutation or automatic journal deletion is claimed. Creation at a new directory is exclusive; partial output stays blocked/preserved. Marker is a family hint, not source authentication; arbitrary file-owner/code tampering is outside the API assurance.

The final negative guard deliberately refuses leaf symbolic-link DB/audit targets generally, including aliases to an ordinary DB, rather than following the link to guess its family. Normal nonredirected V1 fixtures pass; aliased legacy target support is not promised. No links, roles or permissions on the owner's actual machine data were changed.

The public package has only create/inspect. It does not return a DB connection, SQL executor or admission capability. Metadata explicitly says S1_SCHEMA_ONLY/trustedAdmissionAvailable=false. Six data-table counts in the retained reference state are zero (sources, registrations, products, admissions, heads, events). Only schema metadata is populated.

S2 signature/registry/proof semantics; S3 operational atomic admission; S4 trusted history/diffs; S5 acceptance contention/fault qualification; real ERP/company/key/consistent-export proof; clean supported Windows, human acceptance, ACL/Defender and off-host recovery remain open. A SQL signature-length CHECK is not cryptographic verification. No source registration service, signer, collector, scheduler or ERP adapter is implemented. The next step is owner review of PR23 and this evidence, **not** automatic S2 or merging PR16/PR23.
