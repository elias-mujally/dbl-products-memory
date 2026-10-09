# PR #11 — Independent final remediation verification

Date: 2026-10-09. Decision: **APPROVE FOR MERGE**, scoped to the exact reviewed head.
This is a technical review decision, not a merge operation or live SQL qualification.

## Scope and immutable references

- [PR #11](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/11), still OPEN, not merged, no auto-merge.
- Prior reviewed head: `67876966c0683eb954e8eedba908701fa4656ebf`.
- Reviewed repaired head: `3fd128d2b49f439f24fe19fa7e3cc1c2e8d12e6e`.
- Base/main: `95bf225e1523e0fd0f72cdf3da8393df18d635cc`.
- Prior independent review: Product Memory `f91902a`, [report](MOTAKAMEL_CONNECTOR_SLICE_001_PR11_INDEPENDENT_REVIEW_2026-10-09.md).
- Author remediation: Product Memory `9635192072b5ca7e5d9e6e9301c48a36301f8817`, [report](MOTAKAMEL_CONNECTOR_SLICE_001_PR11_REMEDIATION_2026-10-09.md).

The review compared implementation, changed tests, unchanged Core/Import/Storage contracts,
the dependency graph and actual exact-head CI. It also reran checks and independent adversarial
probes rather than treating the author's green report as proof. No implementation edits were made.

## R1–R4 verdicts

| Finding | Verdict | Evidence and boundary |
| --- | --- | --- |
| R1 / snapshot identity and replay | VERIFIED | Fresh observations mint an acquisition identity once using profile/time binding plus UUID; replay retains the exported identity, actual capturedAt and source. SQLite fingerprint and conflict checks are unchanged. Three separate Node processes with persistent SQLite pass acquisition, replay and changed-content rejection. |
| R2 / dependencies and CI | VERIFIED | Vitest 4.1.11 across test workspaces; Tinypool absent; source-map-js 1.2.2; supported Vite 7.3.6 retained. Exact-head Linux and Windows CI pass. Original critical audit gate passes without weakening. Residual moderate SQL-driver-chain advisory remains disclosed, not fixed by assertion. |
| R3 / cleanup diagnostics | VERIFIED | Primary qualification/read/connect failure survives simultaneous close failure; independent cleanupFailure contains fixed safe fields only. Combined-failure tests and an independent permission-rejection/close-failure probe pass. |
| R4 / concurrency | VERIFIED | Pending source qualification blocks new cached streams/exports with BUSY. Already returned and completed cached streams hold independent copies without SQL handles. Close prevents future calls and waits for pending cleanup. Tests cover cached/uncached contention, isolation and export/close races. This is not a promise of concurrent SQLite writers. |

### R1: no storage-conflict bypass

Implementation anchors at the reviewed head:
[acquisition.ts](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/3fd128d2b49f439f24fe19fa7e3cc1c2e8d12e6e/packages/connectors-motakamel-plus/src/acquisition.ts#L6),
[index.ts](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/3fd128d2b49f439f24fe19fa7e3cc1c2e8d12e6e/packages/connectors-motakamel-plus/src/index.ts#L64),
[unchanged fingerprint](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/3fd128d2b49f439f24fe19fa7e3cc1c2e8d12e6e/packages/storage-sqlite/src/fingerprint.ts#L73).

There is no conflict-driven re-identification or capturedAt removal. A new acquisition is explicitly
different from retrying an existing acquisition, even for identical content or a colliding clock.
Restart replay requires preserving the exported canonical artifact before importing it; the adapter
does not automatically find or persist that artifact. Lost artifacts cannot recover their original
timestamp. Old content-only IDs are rejected rather than silently relabelled.

The restart test executes real production Import/SQLite/Application packages in three distinct Node
processes, not three connector objects in one process. The third process changes the name under the
same identity and proves DATA_INTEGRITY_CONFLICT while retaining the original canonical result.
An additional independent in-memory SQLite probe confirmed actual capture-time bounds, idempotent
sequential replay, rejection of changed content, and a storage conflict for a changed capturedAt under
the same ID. The latter deliberately tested Storage directly, separately from replay validation.

Replay is a caller-owned local artifact, not signed proof of source authenticity. The digest/nonce
does not prevent a trusted caller from manufacturing a different artifact. Existing import identity
equality is enforced, but an unseen altered artifact cannot be authenticated against SQL by replay.
This is explicitly documented and is not a new security guarantee or live-health claim.

### R3/R4: failures, lifecycle and actual concurrency boundary

[withSession/exclusive](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/3fd128d2b49f439f24fe19fa7e3cc1c2e8d12e6e/packages/connectors-motakamel-plus/src/index.ts#L113)
and [connect cleanup](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/3fd128d2b49f439f24fe19fa7e3cc1c2e8d12e6e/packages/connectors-motakamel-plus/src/source.ts#L78)
preserve sanitized primary errors. cleanupFailure is a separate fixed code/operation/retryable object;
raw provider/driver messages and secrets are not attached. A failed close is reported, not falsely
claimed to prove physical resource release. No successful stream is emitted when acquisition cleanup fails.

Cached streams can be consumed independently; this does **not** mean two imports of the same identity
may simultaneously stage writes in SQLite. An independent Promise.allSettled probe observed one
successful import and one SQLITE_STAGING_BEGIN_FAILED from the existing unique staging identity index.
Sequential retry succeeded and retained exactly one checkpoint. This is an unchanged single-writer
storage boundary, not an R4 regression or data corruption. Callers must serialize imports. Concurrent
process ownership of one SQLite file remains unsupported; the restart proof is sequential, not concurrent.
See [existing storage invariant](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/3fd128d2b49f439f24fe19fa7e3cc1c2e8d12e6e/docs/FOUNDATION_HARDENING_ROUND_2.md#sqlite-deployment-invariant).

The initial independent probe assumed both parallel imports would succeed; that assumption was corrected
after tracing the existing staging constraint. A separate probe initially supplied snapshot entities to
the header-only Storage API and was correctly rejected; the corrected probe used snapshotHeader and passed.
Neither diagnostic mistake was treated as a product defect. No test or implementation was edited.

No new cancellation API was introduced. close waits for pending source work; a password provider or
cleanup promise that never settles can still delay it. This is an existing documented lifecycle limit,
not proof of bounded cancellation or a new R1–R4 regression.

## Test independence, source and transport limits

The inspection fixture now transcribes the qualified profile independently instead of importing the
implementation's expected guard object. Tests reject both null and differing non-null values for the
guard fields. Independent probes used literal facts and expected errors, not production guard constants.
Accessor/non-enumerable replay rejection prevents validation succeeding before structuredClone drops data.

Mocks remain mocks: simulated inspection results do not execute the SQL permission/schema queries.
Query/configuration assertions and code inspection establish the fixed parameterized, bounded read path,
not actual SQL Server 2014/TDS/TLS interoperability. The frozen DB identity, READ_ONLY and selected permission
guards are not a cryptographic backup attestation or exhaustive permission audit. Real qualification
requires the independent reader and valid TLS; no sysadmin/FMMA or trust-certificate fallback is authorized.

No regression was found in the existing Connector → Import → SQLite → SnapshotReader → Application Service
path. Core, Canonical, Storage source, migrations/fingerprint and CI workflow were unchanged between the
two heads. Runtime changes are confined to the Motakamel identity adapter; workspace manifest/lock changes
are the coordinated test-tool upgrade. The slice still exposes only Product.id/name, not stock or purchases.

## Residual sprintf-js advisory

Fresh critical audit passes but reports **three moderate entries in one dependency chain**:
`mssql@12.7.4 → tedious@20.3.3 → sprintf-js@1.1.3`. The SQL-driver versions were not downgraded.
[GHSA-hp3w-g68c-fv3c](https://github.com/advisories/GHSA-hp3w-g68c-fv3c) remains unpatched and concerns
attacker-controlled numeric format precision causing denial of service.

Inspection of the installed Tedious JavaScript found 12 sprintf calls, all with literal format arguments;
an AST cross-check found zero nonliteral formats. External data is passed as values rather than format
strings at these inspected sites. The adapter accepts no user SQL/format string and does not expose a
demonstrated trigger for this advisory. Thus no reachable exploit was established for this pinned slice.
This does not prove the whole dependency universally safe, fix the advisory, or replace live testing.
Reassess on driver upgrades, new formatting/debug paths or expanded input surfaces. No forced audit fix,
old mssql downgrade, TLS weakening, severity reduction or audit bypass was performed.

## Independent verification performed

- Windows / Node 22.23.2; live test opt-in disabled.
- In-memory TypeScript compilation: 134 emitted artifacts matched existing dist exactly, with no files written.
  This independently validated current source/build agreement without changing the read-only build checkout.
- All workspace typechecks passed.
- Full suite rerun with cache disabled: **187 passed / 1 live skipped**, including 90 Motakamel tests and the
  persistent-SQLite three-process restart test.
- Fresh `npm audit --audit-level=critical`: exit 0; three disclosed moderate chain entries remain.
- Independent negative/control probes described above passed after correcting harness assumptions.
- `git diff --check` passed; build worktree stayed clean.
- [Exact-head CI run 37933388599](https://github.com/elias-mujally/dbl-legacy-intelligence/actions/runs/37933388599)
  was independently queried: head exactly 3fd128d2b49f439f24fe19fa7e3cc1c2e8d12e6e, conclusion success.
  [Ubuntu](https://github.com/elias-mujally/dbl-legacy-intelligence/actions/runs/37933388599/job/113829358974)
  and [Windows](https://github.com/elias-mujally/dbl-legacy-intelligence/actions/runs/37933388599/job/113829358691)
  both passed locked install, build, typecheck and tests. Ubuntu critical audit passed. Windows audit is skipped
  by the original, unchanged matrix condition; it was separately run locally, not claimed as a Windows CI step.

A later redundant CLI check encountered a local process-start/memory failure; direct Node inspection and
the subsequent exact-head CI query succeeded. It did not invalidate the completed checks above and prompted
no host/configuration changes. No live SQL session or credential retrieval was attempted.

## Findings and final decision

- New confirmed P0: **none found**.
- New confirmed P1: **none found**.
- New confirmed P2: **none found**.
- R1/R2 prior merge blockers: resolved within reviewed scope; R3/R4 verified.
- **Merge Readiness: APPROVE FOR MERGE at 3fd128d only.** No merge or GitHub approval action executed.
- **Live SQL Qualification: NOT TESTED.** Source evidence remains LAB-PROVEN; implementation is fixture-tested.
  Do not promote this to PARTNER-VALIDATED, PILOT-QUALIFIED or production/deployment approval.

Remaining conditions are explicit operational/evidence limits, not newly invented remediation scope:
trusted preserved replay artifacts, serialized SQLite import, unpatched moderate advisory with no established
trigger in the inspected path, and real reader/TDS/TLS qualification pending safe credentials and authorization.
S3 remains ACCOUNTING-BLOCKED; Controlled Zero remains PARTIAL; Pilot #001 and Canonical scope unchanged.

Only this report and README status are published to Product Memory after the passing review.
No code fixes, SQL/Windows/ERP changes or merge. `.vscode` remains outside the commit. STOP.
