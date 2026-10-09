# PR #11 — Independent critical review — Motakamel Item Identity Slice #001

Date: 2026-10-09. Decision: **REVISE — NOT READY TO MERGE**.
This is a review, not authorization to implement the repair plan or merge.
**P0: none established. P1: two merge blockers. P2: two confirmed smaller defects; one separately identified dependency risk.**

## Immutable review identity

- Repository: `elias-mujally/dbl-legacy-intelligence`; [PR #11](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/11), OPEN, non-draft, unmerged.
- Base: `95bf225e1523e0fd0f72cdf3da8393df18d635cc`.
- Head: `67876966c0683eb954e8eedba908701fa4656ebf`.
- SHA-256 of exact binary Git range diff: `98d406c26acf9ffe0e619c117964ae60e6491fe4ea1de995f2ed9566fade251b`.
- All 16 changed files inspected, plus actual core/import/storage/application callers and locked SQL-driver paths. Provider/base/head identity rechecked unchanged.
- Product Memory reviewed at `2683028db1f71df0343522714e6fed165ee3ba46`, including implementation, frozen-reader qualification, Pilot #001 and Controlled Dataset Gate A. Product Memory is evidence/intent, not a substitute for code.
- No subject code edits or dependency repairs. Exact-head code was built/tested in an isolated disposable copy, with live-test opt-in disabled and no reader credentials supplied. Independent probes used only synthetic sessions and temporary SQLite, never SQL Server.
- Review artifact/probe retained separately using managed security-artifact storage. Probe SHA-256: `7a4d2bf251b4291dfe75cfe4ad013100114b74ae1f546a572f1b83e11722126c`.

## Confirmed findings

### R1 — P1 — Fresh-process re-import deterministically conflicts with an unchanged frozen item

**Evidence:** [index.ts lines 52–65](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/67876966c0683eb954e8eedba908701fa4656ebf/packages/connectors-motakamel-plus/src/index.ts#L52).
The snapshot ID hashes only the fixed profile and Product, while `capturedAt` is newly generated for each connector instance. The existing storage fingerprint includes the complete header, including capture time
([fingerprint.ts](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/67876966c0683eb954e8eedba908701fa4656ebf/packages/storage-sqlite/src/fingerprint.ts#L33)).
Storage correctly rejects the same identity with different content at `sqlite-write-session.ts:453–459`.

Independent reproduction used three separate Node processes sharing a temporary on-disk SQLite store:

1. First import at 12:00:00Z: success; one checkpoint.
2. Same header/time control from a second process: success; still one checkpoint.
3. Same profile/item at 12:00:01Z from a third process: `DATA_INTEGRITY_CONFLICT`; still one checkpoint.

No data corruption or unwanted duplicate was observed: fail-closed storage works. The defect is the adapter's incompatible identity/time policy: restarting a normal acquisition against this unchanged frozen DB produces a false conflict rather than a usable replay/refresh. The PR explicitly documents the limitation, and `end-to-end.test.ts:48–55` even expects the conflict; that makes the gap disclosed, not resolved. The original persistence contract says identical snapshot identity must be idempotent, with genuinely different content rejected.

**Required narrow repair:** establish one coherent acquisition/replay policy within existing contracts. An identity reused across processes must reproduce the same validated canonical header/content; a genuinely new acquisition must not reuse the old identity. Do not remove capture time from the storage fingerprint, substitute a fabricated timestamp, change connector IDs to escape the conflict, or duplicate snapshots silently. Add restart/persisted-store and concurrent import controls. No Canonical expansion is necessary; the exact policy must be explicit before coding.

### R2 — P1 — Mandatory Linux security gate is red; Linux build/tests have not run

[Exact-head CI run 37893007806](https://github.com/elias-mujally/dbl-legacy-intelligence/actions/runs/37893007806):
Ubuntu dependency installation succeeded; `npm audit --audit-level=critical` failed; build, typecheck and tests were **skipped**, not failed. Windows build/typecheck/tests passed, but that job deliberately does not run the audit. PR status is UNSTABLE.

The critical chain is inherited `vitest@3.2.7 → tinypool@1.1.1`, not a newly introduced SQL vulnerability. The new package additionally pins the same old Vitest version. Inheritance does not satisfy the current mandatory gate. A Windows pass cannot establish Linux runtime compatibility when Linux never reached those steps.

**Required narrow repair:** remove the critical dependency chain through a supported coordinated test-tool upgrade, keep the audit step and severity unchanged, and obtain full green Ubuntu and Windows checks on the repaired head. No `continue-on-error`, omit-dev workaround, threshold reduction or blind `audit fix --force`.

### R3 — P2 — Cleanup failure masks the primary qualification failure

At [index.ts:101–107](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/67876966c0683eb954e8eedba908701fa4656ebf/packages/connectors-motakamel-plus/src/index.ts#L101), a throw from `finally` replaces the original error.

Independent control: READ_WRITE inspection + successful cleanup returns `MOTAKAMEL_SOURCE_PROFILE`.
Same inspection + failing cleanup returns only `MOTAKAMEL_READER_CLOSE_FAILED`.
The caller/audit can no longer distinguish a source-qualification failure from a close-only failure. Both still fail closed; there is no demonstrated data leak or successful unauthorized import.

**Repair:** preserve the sanitized primary error, record a separate sanitized cleanup failure when needed, and test combined failures. Do not attach raw driver causes/secrets. The existing ImportOrchestrator already follows primary-error preservation for staging aborts.

### R4 — P2 — The documented blanket concurrency guarantee is false after acquisition is cached

[index.ts:49–68](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/67876966c0683eb954e8eedba908701fa4656ebf/packages/connectors-motakamel-plus/src/index.ts#L49) bypasses `exclusive()` when `acquired` exists. Independent reproduction: acquire once, hold a later health session pending, then call `openSnapshotStream()`; it succeeds instead of returning BUSY. Documentation says concurrent connector operations fail closed.

This is a **documentation/test-contract defect**, not proof of overlapping SQL reads, corruption or a security bypass: the returned cached payload has independent copies and owns no SQL handle.
**Repair:** explicitly define safe concurrent cached replay versus exclusive source operations, or enforce the stated blanket policy; test the chosen contract. Do not expand concurrency architecture unnecessarily.

## Dependency audit: inherited versus introduced

Fresh npm metadata/audit was queried read-only; no candidate upgrade was installed.

| Locked dependency | Base | PR head | Audit result | Assessment |
| --- | --- | --- | --- | --- |
| vitest | 3.2.7 | 3.2.7 | critical through tinypool; also moderate mocker advisory | inherited; critical merge gate |
| tinypool | 1.1.1 | 1.1.1 | two critical prototype-pollution gadget advisories | inherited; no DBL exploit demonstrated |
| @vitest/mocker | 3.2.7 | 3.2.7 | moderate redirect-mock path traversal | inherited; this slice uses Node tests, not an exposed browser mock server |
| source-map-js | 1.2.1 | 1.2.1 | high source-map DoS | inherited; fix 1.2.2 available |
| mssql | absent | 12.7.4 | moderate via tedious | introduced runtime dependency chain |
| tedious | absent | 20.3.3 | moderate via sprintf-js | introduced runtime dependency chain |
| sprintf-js | absent | 1.1.3 | moderate unbounded precision DoS | introduced; no patched release listed |

These are seven affected **package entries**, not seven independent exploitable vulnerabilities.
Tinypool advisories require additional conditions such as prior prototype pollution; severity alone is not evidence of remote code execution in this application.
See [worker-options advisory](https://github.com/advisories/GHSA-5gmw-xhrv-c9v3) and [run-options advisory](https://github.com/advisories/GHSA-85c8-ppgw-ccpr).

**D1 — P2 potential dependency risk, NOT a confirmed reachable exploit:** `sprintf-js` requires attacker-controlled format strings according to the [advisory](https://github.com/advisories/GHSA-hp3w-g68c-fv3c). Every installed Tedious JS call site found in login7/prelogin/packet/metadata/value parsing uses a literal format string; data is passed as arguments. This slice supplies no format string, and driver debug payload logging is not enabled. Thus the vulnerable package is present, but the required attacker-to-format path was not established. This is not a waiver or proof about future driver use.

Supported repair planning:
- A coordinated **Vitest 4.1.11** upgrade is a narrower candidate than npm's suggested 5.0.3: published engines support Node22, its dependency metadata no longer includes Tinypool, and 4.1.11 addresses the [mocker advisory](https://github.com/advisories/GHSA-82fw-gwwq-j7x9). The official [v4 migration guide](https://v4.vitest.dev/guide/migration.html#pool-rework) confirms removal of Tinypool and documents pool/test API changes. Align all workspace Vitest pins; keep a compatible Vite version rather than accepting an uncontrolled newest-major resolution. **Compatibility and a clean resolved audit are not yet tested.**
- `source-map-js@1.2.2` is a published patch within the current `^1.2.1` parent range. A targeted lock update plus regression tests can address its [advisory](https://github.com/advisories/GHSA-68fv-2mgg-jv7q), without changing product contracts.
- The registry still reports sprintf-js latest 1.1.3 and Tedious 20.3.3 requires ^1.1.3; there is no verified patched release to promise. Do **not** take npm's `mssql@4.2.0` downgrade: it changes the driver/API/security compatibility surface without evidence. Prefer an upstream supported fixed release when available; otherwise an explicitly reviewed narrow patch/fork or explicit bounded residual-risk decision needs separate authorization and tests. Do not weaken TLS or suppress the audit to conceal the package.

## Review coverage and limits of proof

| Area | Source/controls verified | Residual limit |
| --- | --- | --- |
| Existing pipeline/contracts | BatchedLegacyConnector → ImportOrchestrator → real SQLite → repeatable SnapshotReader → Application Service; products only; no parallel import path or Canonical changes | R1 affects restart/re-import semantics |
| Mapping/schema | i_code sole PK nvarchar(20) → id; i_a_name nullable nvarchar(255) → name; checked against frozen/source metadata evidence, not inferred labels | Only this lab profile and item; no cross-year/global uniqueness, SKU, inventory or purchase claims |
| Source authority | Exact server/version/DB name+ID/original+effective login/user/READ_ONLY and selected permissions checked before/after read; null/mismatch rejected | Selected permission checks are not an exhaustive role or cross-DB audit; prior independent-reader proof remains necessary |
| SQL boundary | Fixed SELECTs, bound NVarChar(20) parameter, TOP(2), exact one-row/two-field mapping; unknown fields/getters/symbols/duplicate/missing/null/empty/oversize rejected | No user SQL or arbitrary configuration; tests cannot independently prove server execution |
| Secrets/TLS/2014 | Fixed independent login, external password callback, sanitized public errors, private pool, encrypt=true, trustServerCertificate=false, TDS7_4; no admin fallback | No live Node connection; certificate trust/name, Browser/TCP, exact SQL execution and authentication remain unqualified |
| Lifecycle | Acquisition closes before returning lazy batches; failed connect/query cleanup; iterator abandonment and staging failure do not retain a SQL handle | R3 masks combined errors. close waits, does not cancel; password-provider wait has no adapter deadline/AbortSignal |
| Repetition/concurrency | Same-instance replay, cloned header/product, bounded single identity; existing store preserves first checkpoint on conflict | R1/R4; no proof of live socket cleanup/cancellation under real driver/network failure |
| Provenance | Profile ID and source name preserved; manifest/backup/evidence hashes enter snapshot ID; capturedAt is acquisition completion, distinct from backup as-of | Manifest is operator attestation, not runtime verification of backup bytes; administrator thaw/replace between guards cannot be excluded |
| Financial boundaries | No money/float/inventory/purchase fields emitted | No currency-safe monetary implementation claim from an identity-only slice |
| Tests | Existing contract and pipeline regression tests execute; literal item fixture corresponds to retained projection | Inspection fixtures copy production EXPECTED_INSPECTION; driver mock returns that object without executing SQL, so wrong query/driver/TLS behavior can remain green |

SQL Server 2014 SP3 supports TLS1.2 according to [Microsoft](https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/connect/tls-1-2-support-microsoft-sql-server). That does **not** establish this host's certificate, cipher, transport or driver connection. No demonstrated TLS incompatibility, permission bypass, secret disclosure or SQL injection was found. Live credentials were unavailable and the implementation authorization explicitly allowed fixture-only verification; absence of live testing is a rollout evidence gate, not proof the code fails on SQL2014.

No persistent cancellation contract was added to Core. An independent delayed-session probe confirmed close stays pending until the dependency resolves; no actual stuck socket was induced. Add bounded provider/cancellation controls if required for the operational caller, without claiming the two SQL timeouts already bound the entire lifecycle.

## Actual validation performed

- Isolated exact-head `npm run verify`, Node22.23.2: build and all typechecks PASSED; **154 tests passed, 1 live test skipped**. No test-framework or driver upgrade applied. Offline relinking of workspace packages only in disposable copy.
- Package contributes 57 passing tests (50 connector/mapping, 4 pipeline, 3 mocked-driver); these are not live SQL tests.
- Independent probe, outside the subject checkout: three-process persistent SQLite replay/control; primary+cleanup failure; cached-read/health overlap; pending dependency/close. All assertions reproduced the reported behavior.
- CI exact-head Windows PASSED; Linux audit FAILED and later checks SKIPPED. Fresh registry audit agrees with the relevant locked versions.
- The live opt-in test would check health/projection only; it does not currently provide real SQL → persistent SQLite → application/restart end-to-end evidence.
- Build repository remains clean and at the same PR head. No Motakamel UI, source/frozen SQL session, SQL write, credential rotation, account/ERP/Windows change, S3, implementation fix or merge occurred.

## Prioritized narrow repair plan — NOT executed

1. **P1 replay policy:** repair adapter identity/capturedAt coherence and add multi-process persistent-store regression tests plus same-payload replay and truly-different-content controls. Preserve fingerprint integrity and provenance; no Canonical change.
2. **P1 security gate:** coordinated supported test-tool update and targeted source-map patch; regenerate/review lock deliberately. Run unchanged critical audit, build/typecheck/tests on both OSes. Resolve or explicitly disposition the separate introduced moderate risk; never downgrade SQL driver blindly.
3. **P2 failure/concurrency contracts:** preserve sanitized primary failures and add combined-failure tests; document/enforce and test cached replay concurrency precisely.
4. Strengthen independent guard fixture expectations instead of importing the expected oracle from production; test wrong non-null identity/permission/type values and realistic recordset behavior. Keep rejection tests and actual storage/application tests.
5. Before operational lab connection, separately obtain approved secure reader-secret injection and demonstrate strict-TLS SQL2014 connection/read with this exact independent reader and frozen DB, then the existing end-to-end/restart path. Stop on any certificate/permission/transport prerequisite; do not modify host/security as a workaround.

Risk assessment: impact **high** at dependency/persistent-state contract boundaries; regression likelihood **high** (replay failure reproduced); protection **partial**; recovery **managed** (disable/revert connector, preserve already imported SQLite provenance, no ERP rollback needed); confidence **moderate overall**, high for R1–R4 and exact CI state, limited for live transport.
Status quo: source/S2 lab evidence remains preserved; deferring merge delays only this identity slice. Existing critical test dependencies remain a repository issue independent of PR11.
No automatic merge eligibility: persistent state, public Connector contract, credential boundary and OS-specific transport are involved.

## Product decision preserved

Source/S2 qualification remains **LAB-PROVEN**. Implementation remains **fixture-tested**, not live-tested; no PARTNER-VALIDATED/PILOT-QUALIFIED or Gate B/C promotion.
Pilot #001 stays Purchase Attention + Item Intelligence. No connector generalization, Inventory/Purchase implementation or speculative Canonical expansion. S3 stays ACCOUNTING-BLOCKED; Controlled Zero stays PARTIAL.
**STOP after recording this review. No repair or merge authorized.**
