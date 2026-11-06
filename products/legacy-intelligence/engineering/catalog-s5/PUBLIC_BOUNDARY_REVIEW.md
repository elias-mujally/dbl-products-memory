# S5 public admission and trusted-read boundary review

2026-10-26 · [Index](README.md)

## Enumerated runtime surfaces

| Surface | Review and exercised guard |
| --- | --- |
| `@dbl/storage-sqlite/catalog` | Exactly seven lifecycle/owner/verify/admit/reader/reviewer exports. Internal state/schema/reader/diff/contracts/encoding/family-probe/registry/proof/admission subpaths all fail Node's real export-map resolver. No DB connection, SQL handle, trusted flag, namespace selector or receipt-token writer is exported. |
| Owner port | Exactly enroll/issue/cancel/suspend. Trusted host provisioning is explicit and fixes synthetic class, profile and generated namespace. A file cannot enroll itself. Arbitrary runtime owner access is not delegated to a renderer. |
| Verification/lifecycle | Schema inspection remains `trustedAdmissionAvailable:false`; proof verification reports `published:false`. Feeding their result back as a publish token, or adding authority fields to file paths, fails. |
| Admission | Only S3 admission publishes. It privately captures bytes, authenticates the registered issuer/request/full-set proof, rechecks authority/order/review in final immediate transaction, validates persisted rows and required local event, and commits linked unit/consumption/head together. S5 adds tests, not another publisher. |
| Reviewer | Exactly preview/approve, bound to source/request/proof/parent/missing digest. Concurrent exact approvals share one event; neither changes head or consumes request. Invalid/incomplete proof cannot be waived. |
| Reader | Exactly current/historical/list/comparison/close; product/difference scope exposes context/page only. References bind state/company/source/scope/epoch/interpretation/receipt. HMAC cursors bind view/kind/refs/page size. Current never falls back silently to an earlier head when its proof/count/event is corrupt. |
| `@dbl/application-service` Catalog facade | Existing S4 tests cover explicit DTO projection and safe errors, no raw SQL/owner/writer/path/key/error cause exposure. No Desktop/IPC is implemented or qualified. |
| Generic `SqliteLocalStore`, audit sink and V1 APIs | Exercised against an already populated admitted Catalog: initialization, V1 lock/inspect/report/refresh/backup/restore refuse before output/file mutation. Marker/header/ancestor checks also cover aliases and copied headers. A legacy state cannot become Catalog current merely by supplying its known source handle. |

Relevant implementation: `packages/storage-sqlite/package.json`, `src/catalog/index.ts`, `state.ts`, `registry.ts`, `proof.ts`, `admission.ts`, `reader.ts`, `diff.ts`, `family-probe.ts`; `packages/core/src/state-family.ts`; `packages/application-service/src/catalog.ts`; `apps/v1-file-import/src/state.ts` and `operator.ts`. The package's existing root generic-store export is protected by the state-family checks, not merely by naming conventions.

## Negative data tests

S5 corrupts **new synthetic fixture** receipt bytes, snapshot count or local event while temporarily removing and restoring the corresponding immutability trigger. Public current/replay/ref reads refuse the damaged unit; explicitly referenced intact earlier history remains readable. Head is not silently changed or downgraded. This is a negative corruption exercise, not a repair workflow for retained state.

Validly signed incomplete/unsupported completion, page count, EOF marker and observation method fail. Signed complete empty catalogs still require exact missing-key review; older rows remain history and differences are `notObserved`, without financial/deletion/zero claims. Distinct Unicode stable keys remain byte-distinct even with shared SKU, with no hidden normalization or identity merge.

Accepted deterministic event identity cannot be updated, deleted, replaced or inserted again under that identity. Real admission races create one event. Deferred links, digest validation, immutability and replay are exercised together. Readers are not silently cleaning/staging or accepting unsealed candidates.

## Important discovered limit — no arbitrary-SQL security claim

The first S5 harness incorrectly expected SQLite to refuse **any differently identified raw event** referencing an existing admission. That assumption is false: a database owner with direct SQL can insert another validly shaped event under a different ID. Existing validation verifies the mandatory canonical linked event, not the uniqueness of every arbitrary owner's invented log row. C1 guarantees one canonical acceptance event **through supported admission APIs**, not resistance to an unrestricted database owner.

The failing assertion is preserved and the corrected test checks the intended deterministic-ID conflict plus independent-process API uniqueness. No production constraint was removed, no runtime result was manufactured and no failing API race was hidden. Expanding protection against same-owner SQL/code mutation would require a separate threat-model/OS boundary decision; it is not silently added as S5 schema work. Missing/corrupt canonical event still blocks trust. An internally consistent lying pinned producer remains another external qualification limit.

## Aliases and platform limits

Hard-link refusal is exercised by header detection and is **not** counted as a symbolic-link test. A normal native file symlink is attempted once per run; unavailable local Windows permission produces an explicit skip without elevation or policy changes. It passes on both hosted Windows/Ubuntu CI systems where creation is permitted. Five older local Windows-specific skips remain visible. CI exercises its own link/POSIX variants; that does not qualify deployed Windows ACL enforcement or untested filesystem configurations.
