# C1 test order, deferrals and bridge to a real source

2026-10-25 · [Index](README.md) · **Plan only: zero new runtime tests, DB initializations or migrations executed.**

## Test protocol for every slice

Use only fresh synthetic directories, independent known full fixtures and ephemeral signing keys in the existing approved developer setup. Do not open ERP, Preview1, private/owner evidence, archives or customer files. No packages installed or existing states copied. C01–C44 identify **scenario families**, not a promised count of Vitest assertions or a pass result.

Before acceptance record logical heads/sequences/capture counts and canonical rows. Refusals may add diagnostic events but cannot change accepted rows/head or consume a request successfully. After each fault close/reopen through the public catalog API, not only raw SQL; keep original failure results and distinguish corrected reruns. Inspect SQLite privately only to test constraints/corruption/fault points, not as the sole acceptance/history oracle. New test helpers and fault hooks are test-only, not public CLI escape switches.

Run S1 -> S2 -> S3 -> S4 -> S5. A family first becomes available in the slice below; concurrency/crash variants repeat relevant earlier families in S5. No result is claimed merely from the design or a skipped test. Re-run affected tests and relevant existing regression/typechecks on a code change, not unneeded historical investigations.

## Mapping of all 44 PR16 families

| Family | First slice / final gate | Concrete C1 treatment |
| --- | --- | --- |
| C01 | S3 / S5 | Full requested A/B accepted with correct source, proof, snapshot, head, event |
| C02 | S4 / S5 | Modified stable A plus new C; historical baseline after reopen |
| C03 | S2 / S5 | Valid signature from issuer, wrong observed company/source rejected |
| C04 | S2 / S5 | Signed company/scope/profile tamper rejected |
| C05 | S2 / S5 | Unknown source/key/namespace cannot auto-enroll |
| C06 | S2 / S5 | Wrong connector/build/mapping/epoch/proof policy rejected |
| C07 | S2 / S5 | Invalid/unknown/revoked issuer or validity; historical warning remains accurate |
| C08 | S2 / S5 | Self-consistent file without independent authenticated proof rejected |
| C09 | S2 / S5 | Truncated payload with recomputed own count/hash fails independent full-fixture signed evidence |
| C10 | S2 / S5 | Incomplete completion/pages/order/EOF fails; do not implement real paged exporter in C1 |
| C11 | S1 + S2 / S5 | Duplicate key/normalization ambiguity/same-count substitution fails |
| C12 | S2 + S4 / S5 | Ambiguous empty fails; attested empty needs exact review if removing prior keys |
| C13 | S2 / S5 | Strict UTF-8/canonical grammar, unknown fields, depth/byte/row/integer bounds |
| C14 | S2 + S3 / S5 | Replace source bytes/path after validation; only privately copied verified bytes can publish |
| C15 | S3 / S5 | No persisted staging in this design; inject row substitution inside transaction before digest/seal, require rollback |
| C16 | S3 / S5 | Exact replay after reopen, one accepted unit |
| C17 | S3 + S4 / S5 | Known older replay preserves newer head; history still readable |
| C18 | S3 / S5 | Same capture identity/different statement/content conflicts |
| C19 | S3 / S5 | Equal-sequence fork or unseen older sequence refuses |
| C20 | S2 + S4 / S5 | File-side epoch/scope/key-domain reset refuses, no rekey guess |
| C21 | S2 + S3 / S5 | Fixed test clock tests capture/request intervals and monotonic finish policy; no host clock changes |
| C22 | S2 + S3 / S5 | Challenge/parent/consumed/cancelled request and exact replay classification |
| C23 | S3 / S5 | Rotate registration/suspend between verify and commit; recheck blocks stale authority |
| C24 | S3 / S5 | Authenticated producer fork: attempted acceptance rolls back, conflict recorded and source suspended |
| C25 | S2 + S3 / S5 | Receive/parse/preflight and rejection-log errors truthfully preserve accepted state |
| C26 | S3 / S5 | Fail each DB statement including deferred commit checks; no half unit |
| C27 | S5 | Child exits before/during commit; reopen old or complete new state, never mixed |
| C28 | S3 / S5 | Lost commit response/exit immediately after commit; retry resolves durable capture |
| C29 | S3 / S5, partial family | **Required:** local event and report/output-failure recovery. **Deferred:** delivery into an external audit DB/service, not implemented |
| C30 | S3 / S5, partial family | **Required:** unique deterministic local event/digest and conflicting event refusal. **Deferred:** external delivery acknowledgement/idempotent sink adapter |
| C31 | S5 | Two child processes, same capture; one unit and replay |
| C32 | S5 | Two captures for same parent/request; one succeeds, loser stale/conflict |
| C33 | S4 / S5 | Two companies same keys/SKUs/capture IDs, then concurrent variants |
| C34 | S1 + S4 / S5 | Reader/open/recovery never performs staging cleanup; pinned scope unaffected by writer |
| C35 | S1 + S3 / S5 | Enumerate updated public API imports and path mistakes; no generic flag/raw writer to publish Catalog; no compile-time-only assertion |
| C36 | S1 / S5 | Catalog/V1 family refusal and reviewed old generic-store compatibility using synthetic fixture/old source in tests, **not executing Preview1**; no universal arbitrary-old-binary claim |
| C37 | S1 / S5 | Failed bootstrap/schema/unknown version/checksum or unsupported family; no adopting/repairing existing state |
| C38 | S3 + S4 / S5 | Deliberately corrupted synthetic linkage/count/digest causes trusted reads/admission to stop |
| C39 | S2 + S4 / S5 | Valid full proof missing B holds; exact owner review permits new capture without deleting B's history/zero stock |
| C40 | S4 / S5 | B reappears; same SKU/different key stays distinct; rename stable key not invented |
| C41 | S4 / S5 | Public accepted-by-ID/pinned paging/diff after reopen, even as head changes |
| C42 | S4 / S5 | Cross-company/epoch/scope/map/ref/cursor/nonadmitted reads fail explicitly |
| C43 | S1 + S2 + S4 / S5 | Synthetic-only schema/proof/read class cannot become ERP-qualified from file or caller flag |
| C44 | Deferred, not a C1 pass | Whole-state backup anti-rollback needs independently current source/anchor/recovery qualification; local restored ledger alone cannot remember later captures |

No required local acceptance, origin, completeness, event, ordinary process-crash or concurrent-publication behavior is deferred. C29/C30 remain **partial**, not “passed in full”, until the external adapter is implemented and separately tested. C44 is not process-crash recovery: it replaces the entire accepted history with an earlier image and requires independent evidence not present in C1. Physical power loss, hardware faults, supported clean Windows/customer operation and real key custody remain separate qualifications.

## Verification commands to freeze during implementation

Use existing workspace build/typecheck/test scripts. The concrete new suite will live under storage-sqlite/test/catalog and application-service/test; no dependency install, new environment or default test command is to be assumed. A root/workspace test run must demonstrably include those tests. Stage B PR22 may need merge/rebase or deliberate selection of its already-reviewed files first; do not manufacture the appearance that main contains it.

Record source/build hashes, Node/better-sqlite3/SQLite versions, test IDs/outcomes, skipped/blocked parts, initial failure and final rerun, and bounded logical state receipts after reopen. Keep private paths/DBs/keys out of GitHub. The local report must separate syntax/constraint tests, actual API tests, fault-injection tests, existing regressions and unexecuted real-source gates. A syntax-only schema check cannot satisfy C01 or C35.

## Bridge to the first real ERP source — not perpetual synthetic work

C1 exits when the bounded gate is correct and auditable; it cannot itself establish ERP identity/completeness. In parallel with reviewing its final evidence, request a **separately authorized, read-only discovery scope for one product/version and one noncustomer test company**. No general “all ERP” connector or scheduler is needed.

| Discovery result required | Why it is a hard gate | Smallest next deliverable |
| --- | --- | --- |
| Actual product/version and supported export/storage mechanism | Cannot assume SQL Server/API/CDC, especially for another vendor | Vendor/version-specific extraction profile with official/observed evidence |
| Independently checked source and company identity | File labels and filenames are not company proof | Owner-approved binding and qualified method that reads actual origin at extraction |
| Stable non-reused product key and rename/recode behavior | `i_code`/SKU must not be assumed immutable merely from a field name | Demonstrated stable key; if unavailable, limit claimed rename support or redesign mapping with approval |
| Whole-catalog scope including inactive/blocked rows and no hidden filters | A report page or current UI view is not full export | Scope specification, independent census/reference and reject-on-incomplete evidence |
| Consistent observation and failure/completion behavior | Count/digest from different moments can look plausible and be wrong | Qualified read-only collector/vendor export proof method; interrupted/filtered/empty/mutation cases |
| Real least-privilege access and authorization to export/analyze | `readOnly:true` metadata and an earlier sysadmin session are not permissions proof | Permission evidence and approved handling without writing ERP |
| Producer identity, key custody/build qualification and transport | A real signer must be independently enrolled; synthetic keys cannot be promoted | Operational key/issuer provisioning plan, not private keys in files/DBL |
| Independent balance of actual source against received catalog | A correctly implemented verifier can still trust a faulty exporter | At least two genuine full captures with an authorized add/name/SKU change and independent references, then replay/history checks |

Only after those facts and permissions are approved should we implement one producer/export mapping that emits the same admission contract. It must stop on an unmappable row instead of silently dropping it; source count/set evidence must cover the complete defined projection. DBL remains file-based/manual at first, not SQL-connected by default. If no supported consistent extraction is available, document the blocker instead of downgrading proof to file self-attestation. Any alternative such as an isolated authorized source restore needs its own scope and provenance qualification; no archive or existing lab is silently reused.

The real pilot's success is changes observed in an actual authorized test company, correctly attributed and reconciled, not another synthetic PASS. It requires its own approval before ERP changes, collection, credentials, network, producer deployment or data transfer. After that, integrate Windows Desktop with accepted-source/history/diff capabilities and complete human/security/recovery gates. Automatic triggers come last and reuse the same admission path.

## Execution stop/rollback rule

If S1 DDL fails, revise that schema plan and rerun on a new disposable state after approval; do not migrate V1. If S2 proof is insufficient, block admission; do not allow a manual-complete checkbox. If S3 cannot atomically persist the full linked unit, do not split it into two commits. If S4 cannot read accepted history via its public API, do not substitute a private SQL screenshot. If S5 finds a race, keep that failure and fix/revert the bounded slice before proceeding. No test is removed or weakened to declare C1 complete.
