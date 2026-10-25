# S2 executed verification and qualification limits

2026-10-25 · **PASS_S2_SYNTHETIC_SOURCE_REQUEST_AND_PROOF_ONLY**

## Actual local results

Windows development environment; existing Node `22.23.2`, better-sqlite3 `12.8.0`, SQLite `3.51.3`; no new dependencies. Core and storage runtime builds and both package typechecks completed successfully.

| Selection | Passed | Failed | Explicitly skipped |
| --- | ---: | ---: | ---: |
| New S2 proof suite | 67 | 0 | 0 |
| New S2 registry suite | 30 | 0 | 0 |
| S1 schema/family/bootstrap | 53 | 0 | 1 |
| Other bounded regression suites | 134 | 0 | 4 |
| **Combined final local run** | **284** | **0** | **5** |

The first narrower Catalog run passed 140 with one skip before adding ten further boundary/rollback tests. No runtime test failure was observed in those runs. Direct UNC/URL acceptance was tightened during pre-test code review, not diagnosed as a reproduced data leak. The ten later tests added transaction rollback, signed noncanonical proof, rehashed partial receipt, explicit synthetic bounds and the lying-trusted-producer limitation.

Final regression selections: `packages/storage-sqlite/test`, `packages/audit-sqlite/test`; V1 `bootstrap`, `operator`, `refresh`, `state-publication`; Motakamel connector `v1-acquisition`; import-orchestrator `orchestrator` and `integration`. These use synthetic fixtures. No actual-V1, historical/customer or owner-private evidence suite was invoked locally. No Preview1 assembly was run.

Windows skips: S1 native file alias; V1 POSIX state-file permissions, broad POSIX directory permissions, redirected backup ancestors, dangling symlink. No privilege elevation or machine security change was attempted to turn them green. Cross-platform CI results are a separate observation recorded in the PR; do not count an unobserved run as passed.

## Assertions exercised

- Owner-chosen company/scope/origin/build/mapping and locally generated namespace/epoch persist across reopen, with only synthetic trust. Extra authority fields, malformed keys/DER, wrong key algorithm, getters/inherited fields and invalid validity windows fail without enrolling a second source.
- Random request IDs/challenges persist; one pending request per source, old request cancelled transactionally, expiry/key-window/source-suspension checks and cross-company cancellation refusal work.
- Injected event-write failures roll back enrollment, request supersession, cancellation and suspension completely. Reopening and a subsequent ordinary owner operation remain usable.
- An independently implemented synthetic fixture producer and runtime verifier agree on exact bytes and Ed25519 verification, including empty full capture, Arabic, escape sequences and supplementary-Unicode key order.
- Truncated, altered and substituted delivered sets fail even when self-count/hash and transfer hash are correctly recomputed and signed against the original full observation. Self-rewriting the entire receipt cannot preserve the old signature.
- Wrong company/source/epoch/scope/origin/build/connector/mapping/registration, unpinned key, altered signature, wrong request/challenge, cancelled/superseded/expired request and invalid capture times fail.
- Byte tests reject BOM/invalid UTF-8/duplicates/unknown fields/depth overflow/alternate numeric spellings/noncanonical signed receipt/unpaired surrogate/duplicate or unsorted keys and bounds violations.
- Verification leaves every inspected row and database bytes unchanged; no product, snapshot, head or admission appears, no request is consumed, and no product rows or publish capability are returned. The public package exposes only schema lifecycle, synthetic owner setup and read-only verification.
- S1/V1 family guards and ten untouched baseline files match the S1 review tree (normalized line endings); no S1 DDL, V1 writer guard or V1 schema change is part of the S2 diff.

## Not qualified

No trusted capture acceptance, current/head update, persisted accepted-sequence/replay ledger, missing-set review, historical Catalog product API, multi-process acceptance concurrency, process crash after acceptance commit, physical power-loss durability, operational issuer enrollment/key management, real ERP completeness or customer deployment is proven. No migration was needed or applied to V1. Temporary synthetic tests do not qualify Windows ACL/Defender or clean-machine human operation.

A deliberately lying locally pinned test issuer can sign a partial fixture as a purported full source; verification succeeds **without publication**. This is a documented cryptographic trust limit, not a passing real-source completeness gate. Independent qualification of an actual full extractor remains mandatory. S2 ends here; S3 requires a new review and authorization.
