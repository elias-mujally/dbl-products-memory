# S4 executed tests, reproduction and limits

2026-10-25 · **PASS_S4_SYNTHETIC_ACCEPTED_READS_DIFF_AND_MISSING_REVIEW**

## Actual local result

Existing Windows developer setup: Node 22.23.2, better-sqlite3 12.8.0, SQLite 3.51.3; no installation. Core/storage/application builds and storage/application typechecks passed. The first focused run passed 59/59; final widened synthetic regression passed **425, failed 0, skipped 5**. No failing S4 runtime assertion was observed.

| Test group | Passed | Failed | Skipped |
| --- | ---: | ---: | ---: |
| New S4 reader/review | 52 | 0 | 0 |
| New S4 differences | 11 | 0 | 0 |
| New S4 application boundary | 5 | 0 | 0 |
| Existing S3 admission/recovery | 49 | 0 | 0 |
| Existing S2 registry/proof | 97 | 0 | 0 |
| S1 schema/family/bootstrap | 53 | 0 | 1 |
| Prior bounded regressions | 134 | 0 | 4 |
| Existing application-service tests | 24 | 0 | 0 |
| **Total** | **425** | **0** | **5** |

The five inherited Windows skips cover S1 native file alias and V1 POSIX file privacy, broad directory mode, redirected backup ancestor and dangling symlink. No elevation/permission/link-policy workaround was attempted. The widened selection adds all application-service tests to the previously bounded S3 regression selection; it does not imply previously counted 333 tests included those 24.

## Observed GitHub CI

[Workflow 40225625875](https://github.com/elias-mujally/dbl-legacy-intelligence/actions/runs/40225625875), exact product head `6eb2a0f41b71d862d33f64563ec501d930307814`: **Windows and Ubuntu verify jobs both completed successfully**. The unchanged workflow ran workspace builds/typechecks/configured tests, delivery assembly controls and ten repeated Worker/native WAL cycles, retaining its existing skips/private-evidence gates. This is regression evidence, not real ERP, human Desktop acceptance or S5 Catalog qualification.

Annotations concern existing checkout/setup actions' embedded Node runtime and Ubuntu runner-label transition. They did not fail S4 tests; the application runtime is distinct. No workflow/action or host setting was changed to suppress advisories.

## Exercises and corrections

- Actual API/SQLite exercise of current/historical accepted refs, close/reopen, preserved A/B then revised A/B/C, B absence with exact owner review, B return with accepted prior evidence. No raw SQL manufactures successful admissions; deliberate review-event corruption is solely a negative test in a new disposable state.
- Pinned pages and capture listing while head advances; 1,000-product UTF-8/BINARY order; repeated reads preserve main database bytes and audit rows. Bounded output and metadata SQL limits are tested/inspected, not a production latency or multi-process benchmark.
- Forged state/company/source/scope/epoch/admission/snapshot/interpretation/digest references, pending/unadmitted candidates, coercive sizes, altered/cross-view/cross-port/cross-kind/closed cursors and reverse comparisons refuse. Two actual companies with identical keys/SKUs/capture IDs cannot cross-read or compare.
- Owner review rejects every altered binding field, wrong decision, extra trusted flag, incomplete self-rehashed source, bad signature/company, cancelled/expired/suspended request, changed files or stale head. Review row/event save failure rolls back both. A corrupted review event blocks trusted read and S3 replay.
- Read application projects approved fields only and has no writer/owner/SQLite method. Error envelopes do not leak native messages, source paths, stack/cause or getter/proxy errors. No UI, browser, Desktop IPC or independent human acceptance was exercised.
- During code review, capture-list SQL was tightened to LIMIT/OFFSET instead of materializing all signed history; stored products gained a 1,001-row overflow sentinel. Error-code extraction was made descriptor-based/fail-safe. These are pre-publication robustness improvements, not reproduced host memory leaks or ERP incidents. The rerun includes them.
- Local Git branch creation was refused by Git's ownership safety check under the current session identity. No safe-directory setting, owner/ACL change or retry was used. Work remains ordinary approved source edits; remote independent branch publication uses the authorized GitHub connector, verified S3 parent tree, explicit file allowlist and blob/SHA verification. No claim of a new local Git commit is made.

## Reproduction

Use product S4 commit and exact S3 parent, existing provisioned dependencies and fresh synthetic state directories. Build core, storage and application-service using their existing TypeScript build configs; typecheck storage/application. Run the existing Vitest runner with one worker on `packages/storage-sqlite/test`, `packages/audit-sqlite/test`, `packages/application-service/test`; V1 bootstrap/operator/refresh/state-publication; Motakamel v1-acquisition; import-orchestrator orchestrator/integration.

The new tests are reader.test.ts, diff.test.ts and application-service/catalog.test.ts. A new reader-fixture.ts is orchestration only; the independent fixture issuer still imports no production encoder/proof implementation. Keys are generated in memory, state/proof files and reports are new synthetic/private artifacts, not copied V1/Preview1/customer data. Existing built-public-export and S3 fault-worker tests still run; rerunning those regressions is not a new S5 implementation.

Publish only the sanitized manifest, source/docs and original report digests. Raw reports, SQLite/WAL/proof files, owner receipts and personal paths remain private. Revert/stop only the S4 development code if defective; preserve failed states/evidence. Do not down-migrate, strip markers or alter immutable accepted history. Sources and approval rows remain synthetic.

## Still unqualified

No S5 contention/full crash/public-bypass matrix; physical power loss; independent whole-state restore anti-rollback; real ERP/company/stable-key/complete extraction; operational key/mapping upgrades; Desktop/IPC hardening and human approval UX; actual customer data privacy/ACL/Defender qualification; commercial readiness. The reference/cursor trust boundary is an application capability, not OS authorization against same-owner arbitrary raw DB/code access. A locally trusted lying issuer remains undetectable from internally consistent signed bytes alone.
