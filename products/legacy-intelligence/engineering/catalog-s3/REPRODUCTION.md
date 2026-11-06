# Reproduce and review S3

2026-10-25 · Synthetic fixtures only; no private data or evidence vault needed.

## Prerequisites and branch order

Use the product S3 review commit and its exact S2 parent, existing Node 22-compatible runtime and provisioned repository dependencies. This task installed nothing. Build core then storage using their existing TypeScript build configs, then typecheck them. The public export/lost-response child tests load built package code, so build before running tests.

S3 is stacked on S2 PR24, which is stacked on S1 PR23. Both remain unmerged. Do not cherry-pick S3 onto product main while omitting its S1/S2 dependencies. The S3 tree is assembled from the verified S2 tree using an explicit file allowlist; unrelated local Stage B files/notes and prior work are excluded. No force push or merge is required.

## Test procedure

- Run `packages/storage-sqlite/test/catalog` with the existing Vitest runner and one worker. The new S3 suite creates fresh independent directories, invented companies/products and ephemeral in-memory Ed25519 keys, issues requests through the owner API and signs from a separate fixture producer.
- API acceptance tests import the new facade. They inspect only their own new SQLite files to check original/updated rows and linkage. The public read surface is still metadata/replay, not S4 history/diffs.
- `fault-worker.mjs` is test-only. Parent creates a synthetic source/request and public proof files, child uses the built package and sees no signing private key. Faults are injected around new-state statement execution and commit; no production fault flag is exported. The final abrupt-exit case is the S3 lost-response boundary immediately after commit, not a general S5 crash matrix.
- Run the bounded regression selection in VERIFICATION.md. Do not invoke actual-V1/historical/customer/owner-private suites locally. Keep raw Vitest reports/new SQLite/proof fixtures private; publish only sanitized counts, source/document digests and reproducible test code.

## Decisions and errors

No schema conflict blocked the one-transaction design. Existing head trigger and deferred foreign keys worked with real signed synthetic admissions. S2 parent/request checks and validators were factored into internal helpers, keeping the public proof result non-authorizing. No generic LocalStore adapter or raw verified-token import was added.

The first S3 run had one **test** failure caused by relying on implicit row order for request assertions; the fix adds `ORDER BY issued_at_ms`. A later populated-Catalog guard test incorrectly expected synchronous throw from the asynchronous V1 inspection API; the fix awaits promise rejection. Neither fix modifies a V1 guard or weakens its assertion. A test-only TypeScript overload error in the statement fault wrapper was fixed with an explicit callable type; runtime interfaces were not broadened.

The initial child harness also executed two extra pre-commit abrupt-exit probes on disposable synthetic states. They were excluded from the final S3 selection to preserve the C27/S5 review boundary; they are not counted as S5 qualification and no S5 modules/services were implemented. Their original reports are retained privately. The final suite retains C28 lost response immediately after commit, expressly part of S3.

## Recovery and rollback

Preserve failed new states and raw reports. On unknown commit outcome, retry the same capture identity and byte-identical proof/payload, never invent another ID or delete journals. Transport corruption may be corrected back to the original signed bytes. Re-signed changed content under the same identity is a conflict; suspended synthetic sources require a separate owner decision, not a file-provided override.

Code rollback reverts only the S3 development change or stops using the new admission API. Do not down-migrate accepted states, edit admissions/head or strip Catalog markers. S1/S2 reference states, V1 and Preview1 remain untouched. Further missing-set approval/history/diff work is S4, and contention/crash qualification is S5; both await separate authorization after S3 review. Real ERP discovery/enrollment requires its own permission and evidence.
