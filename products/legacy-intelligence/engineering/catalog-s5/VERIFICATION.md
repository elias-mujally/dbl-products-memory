# S5 verification, corrections and reproduction

2026-10-26 · [Index](README.md)

## Actual local results

Existing approved Windows development setup: Node22.23.2, better-sqlite3 12.8.0, SQLite3.51.3. Nothing installed. Workspace `build` and `typecheck` completed with exit0. New S5 process tests: **46 passed, 0 failed**. Public-boundary corrected run: **24 passed, 0 failed, 1 skipped**. Widened final run: **501 total, 495 passed, 0 failed, 6 skipped**. This is not a clean-Windows, human operator or production test.

| Group | Passed | Failed | Skipped |
| --- | ---: | ---: | ---: |
| S5 process contention/fault/termination | 46 | 0 | 0 |
| S5 public-boundary tests | 24 | 0 | 1 |
| Existing S1–S4/application/V1 bounded selection | 425 | 0 | 5 |
| Total | 495 | 0 | 6 |

The six skips are S5 normal native symlink creation (permission unavailable), S1 file-alias symlink, V1 POSIX private file mode, broad POSIX directory permission refusal, redirected backup ancestor and dangling symlink. The successful hard-link test is a different test and is not substituted for a skip. No elevation, security, link-policy or ACL change occurred.

## Observed CI, exact published head

[Workflow40314347256](https://github.com/elias-mujally/dbl-legacy-intelligence/actions/runs/40314347256) completed successfully on **Windows and Ubuntu** at `fdafd4c6b84384ca9e9eb093c9eee8beac153fa1`. Both jobs completed build, typecheck, configured tests, delivery controls and ten Worker/native WAL regression cycles.

| CI job | Workspace Vitest passed / skipped | Storage subset passed / skipped | New S5 passed / skipped | WAL repeat |
| --- | --- | --- | --- | --- |
| Windows121543064929 | 737 / 74 | 378 / 1 | 71 / 0 | 10 cycles, 230 passes |
| Ubuntu121543065393 | 742 / 69 | 379 / 0 | 71 / 0 | 10 cycles, 230 passes |

These are distinct selections, not numbers to add to the local495 or count as unique repeated tests. Each delivery-control run separately reports4 passed,4 skipped,0 failed. Existing private-actual/historical/live evidence gates account for many workspace skips; none was enabled, accessed or counted as passing. The Windows audit step is skipped by the unchanged workflow; Ubuntu's critical-level audit step succeeds, not a claim that all advisory findings are absent.

The S5 normal native symbolic-link test **passes on both hosted CI systems**, unlike the unavailable local permission. Windows storage still has its inherited S1 hardcoded symlink skip; Linux exercises its existing POSIX/link variants. CI link support does not grant local permissions or qualify deployed Windows ACL/privacy policy. Logs retain warnings about actions' embedded Node20 runtime being run under Node24, deprecated punycode/prebuild-install, and record the hosted Ubuntu26.04 image. The application test runtime is distinct; no workflow, dependency or version was changed to suppress these observations.

## Initial failures are retained, not counted as success

`s5-boundary-first.json`: 25 total, 12 passed, 12 failed, 1 skipped. Ten failures incorrectly expected Node's export-map error code from the Vitest/Vite resolver. The corrected tests exercise Node itself in real child processes and require `ERR_PACKAGE_PATH_NOT_EXPORTED`. One fixture corruption used `receipt` instead of actual `receipt_bytes`; corrected to address the existing column. One assertion wrongly assumed raw SQL could not add a different event ID referring to the same admission; the [boundary review](PUBLIC_BOUNDARY_REVIEW.md) documents the actual limit. The corrected test verifies deterministic identity conflict and public-API event uniqueness; no runtime guard/schema was relaxed.

First process run already passed46. Corrected boundary and widened runs pass as counted above. Original reports, paths, SQLite/WAL/control files and keys are **not published**; only filenames/digests and sanitized conclusions are retained in the manifest. No code/test removal concealed an actual API race failure.

## Reproduction without private evidence

Use product PR27 head and its exact S4 parent, provisioned locked dependencies and the existing supported Node22 development environment. Do not copy any retained ERP/Preview1/customer state. Run existing workspace build/typecheck. Then use installed Vitest with one worker on:

```text
packages/storage-sqlite/test
packages/audit-sqlite/test
packages/application-service/test
apps/v1-file-import/test/bootstrap.test.ts
apps/v1-file-import/test/operator.test.ts
apps/v1-file-import/test/refresh.test.ts
apps/v1-file-import/test/state-publication.test.ts
packages/connectors-motakamel-plus/test/v1-acquisition.test.ts
packages/import-orchestrator/test/orchestrator.test.ts
packages/import-orchestrator/test/integration.test.ts
```

The five new S5 files are `concurrency.test.ts`, `crash.test.ts`, `public-bypass.test.ts`, `s5-worker.mjs`, `s5-process.ts` under storage-sqlite/test/catalog. They generate fresh synthetic fixtures and ephemeral keys; no external source or secret is required. Production exposes no test fault controls. Process-local PRAGMAs and the separate DELETE-journal fixture are scoped exactly as documented in the protocol.

The unchanged GitHub workflow additionally runs workspace tests, delivery assembly controls and ten Worker/native WAL regression cycles on Windows/Ubuntu. Existing private-evidence/assembly gates and platform skips must remain visible; a green job is not proof those gated tests ran.

## Publication and rollback safety

Local Git ownership safety refusal from S4 remains respected: no safe-directory, ownership/ACL change, elevation or local Git retry. Publication uses the authorized GitHub connector, exact S4 tree/parent and five-file allowlist. Source/package blob verification confirmed57 files unchanged. Published blobs/changed-file allowlist and observed CI are checked separately. No main branch update, force push or merge.

If a failure appears, keep the failing state/report; reopen through public APIs and resolve the durable capture identity before retrying. Unknown commit outcome is not permission to create another capture. Revert only the isolated development test/code slice if needed; never repair accepted history, strip markers, down-migrate V1 or alter retained customer state. S5 adds no recovery CLI or automatic cleanup.

## Qualification limits

The [family matrix](C01_C44_MATRIX.md) is authoritative for C01–C44. Local acceptance/audit/current/history under process termination and concurrency pass the stated protocol. Native SQLite I/O errors are partly controlled/simulated; no physical device/power failure. Exact native WAL commit instruction interruption, hostile raw SQL/OS owner, off-host recovery and whole-state anti-rollback remain unqualified. No actual ERP producer, customer data, Desktop/IPC, scheduled sync, operational trust provisioning, human approval UX or commercial readiness is established.
