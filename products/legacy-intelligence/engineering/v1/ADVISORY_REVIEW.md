# V1 advisory review — evidence, fixes and remaining boundaries

Date:2026-10-22. **PR REVIEW ONLY / NO MERGE OR ERP CHANGE.**

[Index](README.md) · [Measured integration](RECURRING_STATUS.md) · [Evidence IDs/hashes](EVIDENCE.json) · [Third test, not executed](THIRD_CAPTURE_PLAN.md)

Source: [Graphify review of product PR19](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/19#pullrequestreview-5618427948). Graphify's observations were advisory and unverified by execution. Engineering reproduced failures before changing the implementation; fan-out metrics and generic symbol matches were not treated as defects automatically. Detailed code-side disposition is `docs/V1_GRAPHIFY_REVIEW.md` in the product PR. No independent human review or formal proof is claimed.

## Proven defects and scoped responses

| Advisory | Actual result / decision |
|---|---|
| Interrupted control initialization | A synthetic child exited between control table creation and metadata completion; retry failed before the fix. Control schema/format/version now initialize in a SQLite write transaction, and only empty owned rollback state is resumable. Unknown nonempty formats stay rejected. |
| In-place source archive | A synthetic partial write left a final source name whose hash prevented retry. Archive writes were already inside the admission lock, but interruption was a real defect. Staged synced bytes now publish atomically without replacing existing finals. |
| Permissions | POSIX defaults could expose new files. New state directories/files use0700/0600 and broad/non-owned POSIX directories are rejected without changing permissions. Windows requires an owner-provisioned private local directory; mode bits do not prove Windows ACL privacy. This is not a production ACL/security certification. |
| Concurrent cold start | A second child saw invalid control format while the first initialized it. The write transaction now precedes metadata checks/creation; contention returns BUSY. Bootstrap commits then reacquires admission, so first-caller priority is not guaranteed. |
| Unlocked state initialization | A synthetic partial marker prevented retry. A permanent empty versioned bootstrap reservation identifies resumable creation; marker/ignore/shared names initialize after admission and use no-replace publication. It is not a PID lock to remove. |

The preserved pre-fix run had **4 failures/1skip**, demonstrating control, marker, source-write interruption and cold-start contention. The same four cases passed after correction. Expanded tests add ignore interruption, crash after final link, existing-final preservation, valid old-format state, invalid-control preservation, orphan-budget stopping and safe CLI diagnostics. These are synthetic process/filesystem faults in temporary state, not ERP transactions or new acquisitions.

## Accepted constraints and non-defects

- The coordinator's fan-out spans source, storage, audit and readback. Filesystem/bootstrap ownership was separated to address the real faults. No metric-only decomposition or broad application rewrite was performed.
- The inventory qualifier remains a cohesive bounded evidence graph for signs, units, receipts, issue returns and journal agreement. Its callee count has maintenance cost but did not establish a runtime defect. Revisit when profiles grow.
- The four unbounded-fetch patterns are false positives for this file path: a shared loader limits source bytes to4MiB, verifies SHA before parse and caps rows/metadata. Four matching-hash oversized-input tests exercise all wrappers. There is no network/SQL fetch.
- Historical-document suggestions matched generic names such as run/product/products. Original historical source contracts, query contracts and dated results are unchanged. They are preserved rather than overwritten with this review's test counts.
- CLI failures now include safe next steps without echoing private source/state locations. Unknown failures still admit the possibility of a committed checkpoint.

## Current verification

First corrected Windows/Node22.23.2 build/typecheck: **412 passed/41skipped**. Final verification after the test-harness correction below: **413 passed/41skipped**, including both retained actual artifacts. Application suite29passed/3POSIX-only skips; the remaining38 skips retain historical-artifact/live-SQL gates. Windows skips are not proof of POSIX controls; Ubuntu CI216 exercised them successfully. Private-source tests remain gated in public CI, never replaced with fabricated positives.

The revised compiled app also opened a separate copy of the verified previously successful format1 DBL state without a bootstrap reservation. Later actual file import, same-file replay and historical replay preserved two snapshots/five products/1470SAR with clean integrity/FK checks. These three compatibility-copy calls are distinct from the original retained state's seven calls. Original source captures remain two, both unchanged-business-row captures. The original state, sources and backup are unchanged; no ERP restore or third acquisition was performed.

Product implementation review commit: `db709081e15039507d50c4320a98f7b44b7cffd9`, tree `05ee9218edc1a7b53e69816aaf8b5ec9aabba010`, matching the reviewed local source tree. Core storage migrations and their checksum protection remain unchanged. This targeted compatibility result does not qualify arbitrary build/platform interchange of existing stores.

## CI feedback — test harness, not fabricated application results

[CI216](https://github.com/elias-mujally/dbl-legacy-intelligence/actions/runs/39836041311) passed Ubuntu including the POSIX cases and10 WAL cycles. Windows build/typecheck/full tests passed, but WAL repeat cycle4 failed because the normally closed helper worker exited while work was unfinished. The unchanged96-snapshot workload took about18seconds; its helper had a competing fixed15-second lifetime independent of the parent's configured budget. This established a harness lifecycle defect, not application data corruption. The failed run remains part of the evidence.

The test-only helper now uses a monotonic fail-safe based on configured startup/work/shutdown/termination budgets. The native test has explicit30-second work/45-second outer limits. A worker-local synthetic wall-clock jump reproduced the same premature-close error before correction and passed afterward; an actual CI clock jump was not established. The21-test lifecycle suite retains failure/termination/early-exit coverage. No runtime SQLite implementation or migration metadata was changed.

A later local full run hit the app's5-second test timeout while five app test files ran concurrently. Its log is preserved. App files now execute sequentially; deliberate competing processes and WAL threads still run concurrently. No retry, reduced workload or removed quantity/value/hash/integrity assertion was introduced. App-only and final full verification succeeded after this scheduling change. The test-only follow-up is `f5471792a63c08039ebbbc4b96f40f94fd33325d`, tree `a1c5fe0d0011c95f944ffd80b5a18aa0a80099f8`, exactly matching the reviewed local tree.

**FACT — [CI217 passed](https://github.com/elias-mujally/dbl-legacy-intelligence/actions/runs/39843313410)** on that head: Windows383passed/71skipped and Ubuntu386passed/68skipped workspace tests, plus10 fail-on-first-error Worker/native-WAL cycles on each (23passing tests per cycle). Both completed locked dependency installation, build, typecheck and tests; the Ubuntu critical-threshold dependency audit passed. The count difference from local413/41 reflects missing private owner artifacts and platform-only controls, not substituted source data. The CI summary and preserved failures are pinned as evidence metadata in EVIDENCE.json; raw logs and exact locators remain private.

## Operational limits and merge decision

Local owner-private storage and a supporting atomic hard-link primitive are prerequisites. Shared/multi-tenant/NAS/cloud-synchronized state, hostile same-user writers and power-loss durability are outside qualification. No unsafe overwrite fallback is used. Interrupted private pending files are preserved; at16 the app stops for owner review, without automatic cleanup. Existing32-observation/256-attempt caps remain. Corrupt final files, malformed published markers and unknown nonempty control formats are not automatically repaired.

**Recommendation:** product PR19 is ready for owner merge review within the narrow operator-assisted file-integration model: corrected failures are covered and CI217 is green. Memory PR8 is ready for owner merge review once the published tree matches this sanitized record and its51evidence hashes/relative links validate. No advisory was automatically dismissed solely because CI passed, and no coupling thread is auto-resolved on behalf of the reviewer. Neither recommendation authorizes merge, deployment or ERP operations. The [next business-change test](THIRD_CAPTURE_PLAN.md) remains a one-unit consumption proposal, expected quantity29/value1450SAR, pending separate owner approval and recovery/evidence gates.

Platform rationale is supported by [SQLite transaction semantics](https://www.sqlite.org/lang_transaction.html), [Node filesystem mode caveats](https://nodejs.org/docs/latest-v22.x/api/fs.html#file-modes), and [Windows hard-link constraints](https://learn.microsoft.com/en-us/windows/win32/api/winbase/nf-winbase-createhardlinkw). API documentation is distinct from actual test evidence. Public memory retains only safe facts, evidence IDs/hashes and repository references; precise private locators remain with the owner.
