# PR #11 — R1–R4 bounded remediation — 2026-10-09

**Status: R1–R4 FIXED + FIXTURE-VERIFIED; exact-head Linux and Windows CI PASSED.**
**LIVE NODE SQL INTEGRATION: NOT TESTED. PR remains OPEN / UNMERGED / pending independent rereview.**

## Authority and immutable implementation identity

User accepted the [independent review](MOTAKAMEL_CONNECTOR_SLICE_001_PR11_INDEPENDENT_REVIEW_2026-10-09.md)
at Product Memory `f91902a71fd5492a97e511837261f466d0a9c9c8`, then authorized only R1–R4,
stronger independent guard fixtures and related documentation on the same PR branch.
The review's REVISE decision is not silently replaced by an author merge approval.

- [PR #11](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/11).
- Branch: `codex/motakamel-item-identity`.
- Previous reviewed head: `67876966c0683eb954e8eedba908701fa4656ebf`.
- Repaired head: `3fd128d2b49f439f24fe19fa7e3cc1c2e8d12e6e`.
- Build main remains `95bf225e1523e0fd0f72cdf3da8393df18d635cc`.
- [Exact-head CI run](https://github.com/elias-mujally/dbl-legacy-intelligence/actions/runs/37933388599): completed SUCCESS.
  [Ubuntu job](https://github.com/elias-mujally/dbl-legacy-intelligence/actions/runs/37933388599/job/113829358974)
  and [Windows job](https://github.com/elias-mujally/dbl-legacy-intelligence/actions/runs/37933388599/job/113829358691)
  both completed SUCCESS; install, build, typecheck and tests passed on both. The unchanged
  critical audit step passed on Ubuntu; it is skipped on Windows by the original workflow condition,
  not by this patch. Local Windows critical audit separately passed.

No Core/Canonical/Storage contract, fingerprint or CI workflow was changed.
No SQL Server/Windows configuration/ERP change, credentials read/rotation, S3, Inventory/Purchase implementation,
generic connector, mapping DSL or parallel Import path was introduced.
The only supported output remains Item A identity: `i_code/i_a_name → Product.id/name`.

## R1 — acquisition identity and explicit replay

Policy was written before code in
[MOTAKAMEL_ITEM_IDENTITY_REPLAY_POLICY.md](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/3fd128d2b49f439f24fe19fa7e3cc1c2e8d12e6e/docs/MOTAKAMEL_ITEM_IDENTITY_REPLAY_POLICY.md).
A fresh successful source observation captures its actual completion time and mints one UUID nonce.
Its ID binds the pinned profile and capturedAt plus that nonce; a new observation is not replay,
even if content is unchanged or clocks collide. There is no automatic conflict retry/renaming.

`exportAcquisition()` exposes an independent existing CanonicalSnapshot. Caller preserves it locally
before import, then supplies `{ replay: savedSnapshot }` to the same adapter after restart.
Replay preserves the original ID, time, source and content without SQL, password, new clock/nonce
or a claim of fresh source health. Caller-owned local artifacts are not signed source attestations.
Old pre-repair content-only IDs are rejected, not silently relabelled or assigned fabricated times.
Losing an unpreserved artifact does not recreate the original acquisition; a fresh read is explicitly new.

The unchanged SQLite fingerprint still includes capturedAt and all content. Changed name under a
retained ID/time fails `DATA_INTEGRITY_CONFLICT`; storage content-equality enforcement is not bypassed.

**Restart proof:** `restart.test.ts` launches three genuine Node processes, each using built runtime
packages and one persistent temporary SQLite file. Process 1 exports/preserves a fixture acquisition
before importing it. Process 2 loads that artifact with source/time access configured to throw,
imports successfully and retains one checkpoint. Process 3 modifies the name under the same header,
must receive a true conflict, and retains one checkpoint and the original Application query result.
All three preserve the same actual acquisition ID/time; PIDs are distinct. No SQL Server was contacted.
Separate tests prove an explicit new acquisition creates a distinct valid snapshot without mutating
an already opened Application read scope, including same-clock identity separation.

## R2 — dependencies and original security gate

All nine test-owning workspaces exact-pin Vitest `4.1.11`.
[Vitest 4's supported migration](https://v4.vitest.dev/guide/migration.html) removes Tinypool/vite-node;
no unrelated test-framework config or application contract migration was needed.
Root explicitly pins the previously used supported Vite `7.3.6`, avoiding an incidental Vite major
upgrade. Vite requires Node >=22.12 on the Node22 line; local Node is `22.23.2`,
and both exact-head CI logs report `22.23.3`.
`source-map-js` is patched narrowly from `1.2.1` to `1.2.2`
([GHSA-68fv-2mgg-jv7q](https://github.com/advisories/GHSA-68fv-2mgg-jv7q)).

Observed installed/locked tree: Vitest4.1.11, Vite7.3.6, source-map-js1.2.2; no Tinypool.
`mssql@12.7.4`, `tedious@20.3.3` and `sprintf-js@1.1.3` are unchanged.
The original `npm audit --audit-level=critical` passes locally with exit 0.
There is no severity reduction, omit-dev trick, `continue-on-error`, forced audit fix or driver downgrade.

**Residual risk:** audit reports three moderate entries in the SQL-driver chain for unpatched
[`sprintf-js` GHSA-hp3w-g68c-fv3c](https://github.com/advisories/GHSA-hp3w-g68c-fv3c).
The advisory needs attacker-controlled numeric format/precision. Independently inspected Tedious
call sites use fixed literal formats, with external values as arguments, so this inspected path
does not expose that trigger. This is not universal safety, a clean audit, or live transport proof.
The suggested old `mssql@4.2.0` breaking downgrade was not executed.

Tooling incident: npm10.9.8 hit an internal Arborist `edgesOut` resolution error before installation.
A one-off npm11.6.4 invocation generated the candidate lock; the final supported Vite pin was then
resolved, installed and verified with ordinary npm10.9.8. No global npm/system/config change or
legacy-peer-deps relaxation. Final `npm ci` passes from the locked dependency graph.

## R3 — primary error and cleanup diagnostics

The adapter retains the primary sanitized qualification/read/connect error if close also fails.
Its separate `cleanupFailure` records only fixed code `MOTAKAMEL_READER_CLOSE_FAILED`, operation
`close` and retryable=false. No driver/provider message, raw cause, row, password or connection string
is attached. The existing Import audit preserves its primary code; callers may inspect the separate
safe diagnostic without extending Core or a generic logging API.

Tests combine source-profile/permission qualification failure with failing close, and connect/query
failure with failing driver close. They assert primary code, independent diagnostic, one cleanup
attempt and no secret canary in JSON/string diagnostics. Close-only failure remains a close failure.
A driver close error does not prove that all physical resources released successfully; it fails
the operation, does not emit/import a successful acquisition, and is explicitly surfaced.

## R4 — explicit concurrency contract

Source health/acquisition operations are exclusive. New cached stream/export calls now reject BUSY
while a source operation is pending. Completed cached streams can be consumed concurrently through
independent immutable acquisition copies, with no SQL handle. Previously returned streams continue
independently; close prevents new calls and waits for pending source cleanup.
Tests cover pending uncached acquisition, cached health+stream/export contention, parallel cached
copies, mutation isolation, close waiting, and export/close race without dereferencing cleared state.

## Test independence and candidate review

Guard/driver fixtures transcribe the qualified server/version/DB/reader/schema/permission facts
independently of production EXPECTED_INSPECTION. Each sampled guard rejects NULL and a differing
non-NULL value. Mock configuration expectations use independent server/database/user literals.
Fixtures remain synthetic responses, not current SQL permission observations.

The fix-finding workflow used a fresh read-only dependency investigator and a fresh bounded
candidate reviewer. The reviewer found a concrete validation-to-clone defect: non-enumerable
required fields could pass validation then disappear during structuredClone. The final adapter
rejects non-enumerable object fields/array elements (except normal array length) and hidden unknown
fields. An added regression covers sourceSystem/sourceVersion, product.name, array index and hidden
extra property; normal exported JSON remains accepted. No Core change was needed.
No further concrete finding was reported in that bounded review. The final descriptor repair was
verified by regression/full-suite execution, not claimed as a second independent review approval.

## Verification and remaining gate

Ordered local verification, Windows / Node22.23.2, live-test opt-in disabled:

1. Final diff inspected; `git diff --check` passed; Core/Storage source and CI workflow diff empty.
2. Focused connector checks passed, including combined failure, concurrency and replay trigger/control.
3. Final `npm run verify`: build + all workspace typechecks + **187 passed tests / 1 live skipped**.
   Motakamel package: **90 passed / 1 live skipped** (74 connector, 4 pipeline, 5 mocked transport,
   6 replay/concurrency/cleanup, 1 three-process restart).
4. `npm audit --audit-level=critical`: PASSED, exit0; three disclosed moderate entries remain.
5. Exact-head Ubuntu and Windows CI: PASSED in run37933388599, both jobs SUCCESS;
   Ubuntu critical audit PASSED, unchanged workflow. PR head and both check conclusions verified.

**Live Node/TDS/TLS connection = NOT TESTED.** No approved reader secret was available/supplied.
The prior source proof remains LAB-PROVEN; implementation/restart evidence is fixture-tested.
No PARTNER-VALIDATED/PILOT-QUALIFIED or deployment promotion. Pilot #001 and existing architecture
remain unchanged, S3 stays ACCOUNTING-BLOCKED, Controlled Zero stays PARTIAL.

**Next action:** independent rereview of repaired PR #11. No merge/auto-merge or additional coding.
