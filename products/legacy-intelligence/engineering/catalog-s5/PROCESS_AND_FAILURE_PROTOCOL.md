# S5 process and failure protocol

2026-10-26 · [Index](README.md)

## Independent execution and bounded fault control

`packages/storage-sqlite/test/catalog/s5-process.ts` spawns separate Node processes running `s5-worker.mjs`. Each checks a fresh test-family directory, synthetic marker and expected state ID. Only processes created by this helper are tracked or terminated; no enumeration/killing of host processes or VMs occurs. Test configuration contains public source/proof paths and handles, never signing private keys. The independent fixture issuer retains ephemeral keys in its parent test process and imports no production encoder/proof implementation.

Atomic phase receipts and release files implement barriers, with real monotonic-time deadlines. Fixed clocks are child/test-local; the host clock is untouched. The worker imports the **built public Catalog package**. Test-only instrumentation wraps native database calls; production has no fault flag, raw database export, retry bypass or preverified token API. All files/states are fresh synthetic artifacts, kept private.

## Races and transaction boundaries

- Same capture: two processes finish authenticated observation before either final write is released, repeated three rounds. One accepts, the other replays; exactly one new admission, snapshot and acceptance event. Public reopen/exact retry agree.
- Two different signed captures, identical pending request and parent: both preflight before final publication, repeated three rounds. One consumes the request, the loser fails and cannot change the winner's head. Retrying winner replays; retrying loser refuses.
- Same-sequence authenticated fork is a different policy: durable conflict suspends the source; both new candidates may fail. The previous accepted head remains intact. This is not falsely counted as a one-winner race.
- Independent source suspension, request cancellation/supersession, registration revision change and revocation between preflight and final BEGIN all refuse final acceptance. Registration/revocation mutations are adversarial fixture SQL, not new operational rotation APIs.
- A cancellation process with a 50ms connection-local busy timeout cannot enter a transaction while a writer owns the final lock. A pending writer still verifies all authority inside its own transaction.
- Two companies concurrently use identical stable keys, SKUs and capture IDs without cross-reading/comparing. Two reviewers converge on one exact missing-review row/event and still cannot publish; normal S3 admission remains necessary.
- An independent reader sees the old accepted head while another process has inserted uncommitted products, then the complete new head after commit. Pinned old rows, continuation pages and differences remain stable, including a fresh reader process after restart.

## WAL termination matrix

Twenty-one points are instrumented on normal fresh WAL states:

`ready`, `before-observed`, `after-observed`, `after-preflight`, `before-final-begin`, `after-final-begin`, `before-snapshot`, `after-snapshot`, `before-product-1`, `after-product-1`, `after-product-2`, `after-product-3`, `before-accepted-event`, `after-accepted-event`, `before-admission-head`, `after-admission-head`, `before-consume`, `after-consume`, `before-commit`, `commit-enter`, `after-commit`.

The parent forcibly terminates the paused child (SIGKILL), then reopens using public inspection/read APIs. All points before successful native COMMIT preserve the old accepted unit; `after-commit` exposes the entire new unit even though no result reached the caller. SQL linkage/FK checks supplement, rather than replace, public history/current/diff/retry assertions. Exact retry yields acceptance or replay as appropriate, never a second unit/event.

**`commit-enter` is immediately before the native call. Its name alone is not proof of interruption inside SQLite.** No exact native WAL instruction or actual power interruption is claimed.

## Deterministic native COMMIT interruption supplement

One separate fresh fixture temporarily uses DELETE journal mode. A child writer pauses before COMMIT while an independent reader holds a SHARED lock. A new reader succeeds before COMMIT (writer RESERVED), then fails with BUSY once the writer's PENDING lock blocks new readers. Because the existing reader prevents EXCLUSIVE acquisition, this proves the writer has entered native COMMIT and cannot finish it. The parent terminates only that writer, releases the pinned reader, and lets SQLite itself recover its hot journal via an engine open. No row/journal repair is performed. The fixture is returned to WAL; public old-head/history/retry succeed.

This supplies actual native-commit wait interruption evidence in the stated mode. It does not qualify an exact internal WAL commit cut, storage/controller failure, filesystem power durability or another deployed journal policy.

## Error matrix

| Error | Actual mechanism | Result |
| --- | --- | --- |
| SQLITE_BUSY | Independent holder plus connection-local 50ms busy timeout | No acceptance; release holder and exact retry succeeds |
| SQLITE_BUSY_SNAPSHOT | Old raw read transaction tries to upgrade after another process publishes | Upgrade refuses; fresh public writer revalidates/replays |
| SQLITE_READONLY | `query_only` on this worker connection after final BEGIN | Old accepted unit survives; ordinary retry succeeds |
| SQLITE_FULL | New fixture connection's `max_page_count` equals current page count; larger bounded candidate | Real SQLite quota refusal without filling physical disk; retry on normal connection succeeds |
| Deferred FK at COMMIT | Test inserts an orphan local event inside the pending unit | Commit reports outcome-unknown with FK cause; reopen proves old unit; normal retry succeeds |
| SQLITE_IOERR_WRITE | Explicit test exception before observation and after admission/head write | **Simulated** I/O, not a real host/device I/O error; rollback/reopen/retry succeed |

No OS, disk, permission, network, service or Defender setting is changed. C29 output-loss is demonstrated by termination immediately after a successful commit and durable replay. External audit/report delivery is not an acceptance prerequisite and is not qualified here.
