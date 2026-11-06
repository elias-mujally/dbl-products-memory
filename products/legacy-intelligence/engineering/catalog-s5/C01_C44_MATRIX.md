# C01–C44 executed qualification matrix

2026-10-26 · [Index](README.md) · [Protocol and journal-mode caveats](PROCESS_AND_FAILURE_PROTOCOL.md)

These are scenario **families**, not 44 tests. PASS below means the stated synthetic C1 treatment was exercised; it does not certify all platforms, hostile OS owners, real ERP or production. The local widened run has 495 passed, 0 failed and 6 **skipped**, not 501 successes. CI outcomes are recorded separately in [verification](VERIFICATION.md).

Evidence paths below are relative to product `packages/storage-sqlite/test/catalog/` unless prefixed otherwise. S1–S4 test evidence is re-executed in the widened S5 selection, not merely quoted from old reports. `concurrency`, `crash`, `public-bypass` refer to the corresponding `.test.ts` files added in PR27.

| ID | Outcome | Executed evidence / precise limit |
| --- | --- | --- |
| C01 | PASS, synthetic | `admission`: A/B snapshot, source/proof, request consumption, head and local event linked; `concurrency` checks same linkage after races. |
| C02 | PASS, synthetic | `admission`, `reader`, `concurrency`: revised stable A plus new C; old A/B survives public reopen and independent reader restart. |
| C03 | PASS, synthetic | `proof`, `admission`: correctly signed wrong company/source rejected, accepted state preserved. |
| C04 | PASS, synthetic | `proof`: company/scope/profile binding tamper cannot qualify. |
| C05 | PASS, synthetic | `registry`, `proof`, `public-bypass`: unknown source/key and caller namespace/authority fields cannot enroll or publish. |
| C06 | PASS, synthetic | `proof`, `reader`: incompatible connector/build/mapping/epoch/policy rejects. No operational upgrade mechanism is claimed. |
| C07 | PASS, synthetic | `registry`, `proof`, `admission`, `concurrency`: bad/unpinned key, invalid interval and adversarial revocation reject new acceptance; accepted replay/history carries current authority warning where supported. Operational key custody/rotation deferred separately. |
| C08 | PASS, synthetic | `proof`: self-consistent payload without independently pinned signature/full-fixture proof refuses. A lying qualified signer is outside this proof. |
| C09 | PASS, synthetic | `proof`, `admission`, `reader`: truncated/changed/same-count substituted payload with recomputed file count/hash cannot match independent signed full-set observation, nor be waived by review. |
| C10 | PASS, synthetic profile | `proof`, `public-bypass`: incomplete completion, unsupported page count/method/EOF, bad order reject. Profile permits one complete fixture, not a real paginated ERP extractor. |
| C11 | PASS, byte-key contract | `schema`, `proof`, `public-bypass`: duplicate/ambiguous encoding and same-count substitution refuse; byte-distinct Unicode keys stay distinct and are not silently normalized/merged. Real-source normalization rules remain unqualified. |
| C12 | PASS, synthetic | `proof`, `admission`, `public-bypass`: malformed/ambiguous empty refuses; signed initial empty may qualify; nonempty-to-empty requires exact missing review, preserves prior history. |
| C13 | PASS, bounded profile | `proof`, `registry`: canonical UTF-8/fields/shape/byte/row/integer bounds; unknown nested structures do not become an extension channel. Limit remains 1MiB/1,000 rows. |
| C14 | PASS, synthetic | `proof`, `admission`, `concurrency`: replace files/bytes after observation; only already copied verified private bytes publish, changed input fails at a new attempt. |
| C15 | PASS, synthetic | `admission`: substituted/omitted actual inserted row inside transaction fails persisted digest/unit validation, rolls back. No durable staging was added. |
| C16 | PASS, synthetic | `admission`, `crash`, `concurrency`: reopen/exact replay preserves one unit and event. |
| C17 | PASS, synthetic | `admission`, `reader`: old accepted capture replays without head regression, old history remains explicit. Whole-state old backup is C44, not this case. |
| C18 | PASS, synthetic | `admission`: same capture identity with different authenticated statement conflicts; preserves accepted data. |
| C19 | PASS, synthetic | `admission`, `concurrency`: equal sequence fork/unseen old sequence refuse; producer fork may suspend both new attempts. |
| C20 | PASS, synthetic | `proof`, `reader`: caller-side epoch/scope/key-domain reset refuses, cannot guess/rebind identity. No operational rekey is implemented. |
| C21 | PASS, fixed test clocks | `registry`, `proof`, `admission`: capture/request/key intervals, clock bounds and monotonic finish; final expiry during write rolls back. No host-clock change/resilience qualification. |
| C22 | PASS, synthetic | `proof`, `admission`, `concurrency`: challenge/parent, pending/consumed/cancelled/superseded request, replay classification and stale-parent refusal. |
| C23 | PASS, independent processes | `concurrency`: source suspend, request cancel/supersede, registration change/revocation after preflight; final transaction refuses stale authority. Existing `admission` tests also alter authority at transaction entry. |
| C24 | PASS, synthetic | `admission`, `concurrency`: authenticated fork records rejection/suspension together without replacing accepted unit; conflict-event/control fault rolls back. |
| C25 | PASS, controlled faults | `proof`, `admission`, `crash`: parse/preflight/observation/rejection-log errors preserve last accepted state. IOERR is explicitly simulated; not a physical device-failure test. |
| C26 | PASS, controlled SQLite faults | `admission` before/after every essential write plus `crash` READONLY/FULL/deferred-FK/IOERR; native COMMIT error followed by public reopen and normal retry, no partial accepted unit. |
| C27 | PASS, bounded process-crash protocol | `crash`: 21 WAL cut points, plus independent-reader/PENDING-lock proof of native COMMIT wait interruption in a separate DELETE fixture. Reopen old or complete only. **Exact internal WAL instruction cut and power loss untested.** |
| C28 | PASS, process output loss | `admission`, `crash`: death/throw immediately after commit, no caller result; public reopen/exact retry resolves one durable accepted unit. |
| C29 | PARTIAL | Required local acceptance event plus output-loss recovery pass. External audit DB/service delivery, report transport and acknowledgement are **DEFERRED / not implemented or tested**. |
| C30 | PARTIAL | Required deterministic local event/digest/conflict and race uniqueness pass (`schema`, `admission`, `concurrency`, `public-bypass`). External sink idempotency/delivery acknowledgement **DEFERRED**. Arbitrary differently identified raw SQL events are not prevented; see boundary review. |
| C31 | PASS, real processes | `concurrency`: same capture, both preflights complete before final release, three rounds: exactly one accept plus replay, one new event/unit. |
| C32 | PASS, real processes | `concurrency`: two captures same request/parent, three rounds: one accepted, loser fails and cannot replace head on retry. Same-sequence fork tested separately, no false one-winner claim. |
| C33 | PASS, synthetic companies | `reader`, `concurrency`: identical keys/SKUs/capture IDs for two companies, concurrent accept and cross-ref/comparison refusal. |
| C34 | PASS, supported reader paths | `family`, `reader`, `concurrency`: no staging/cleanup adoption; accepted head old/new only and pinned history/diff/page stable with writer. No owner raw-write or old-binary universal claim. |
| C35 | PASS, enumerated API boundary | `bootstrap`, `admission`, `public-bypass`, application Catalog tests: seven exports, Node internal import refusals, no public token/writer/flag bypass, populated-state generic/V1 refusal and legacy-to-Catalog refusal. S5 native symlink variant is **SKIPPED locally**, passed on both CI systems; hard-link test is separate, not a substitute. |
| C36 | PASS, reviewed compatibility scope | `family`, `schema`, V1 regressions: state-family/header/migration fence rejects Catalog at reviewed legacy APIs without mutation. Not running Preview1 or arbitrary old binaries. Windows inherited link/POSIX variants remain **SKIPPED** locally. |
| C37 | PASS, synthetic states | `bootstrap`, `schema`, `family`: initialization cuts, incomplete/conflicting markers/schema/hash/fingerprint/unknown future versions refuse adoption/repair. |
| C38 | PASS, injected corruption | `admission`, `reader`, `public-bypass`: row/event/review/receipt/count/digest/link corruption blocks trusted replay/current; no automatic old-head fallback. New fixtures only. |
| C39 | PASS, synthetic absence | `reader`, `public-bypass`: signed complete missing set holds, exact proof/parent/request-bound review permits admission; absence is not deletion or zero. |
| C40 | PASS, accepted history | `reader`, `diff`: B returns with prior accepted evidence only; stable-key rename, reused SKU with another key remains distinct. No invented deletion/reappeared taxonomy. |
| C41 | PASS, public read/restart | `reader`, `concurrency`: current/historical accepted refs, stable pages/list/diff with head changes; independent reader process restart and SQLite reopen. |
| C42 | PASS, bounded interpretation | `reader`, `diff`, application Catalog tests: forged/nonaccepted refs, cross-company/source/scope/epoch/incompatible mapping, wrong/tampered cursor/view/order reject. |
| C43 | PASS, synthetic-only class | `registry`, `proof`, `reader`, `public-bypass`: caller/file cannot claim ERP trust; read DTO always `erpQualified:false`, no runtime operational enroll path. |
| C44 | DEFERRED, NOT PASSED | Entire older-state restore anti-rollback requires an independent current anchor/source/recovery policy. Local ledger alone cannot prove it; no such test or mechanism is claimed. |

**Family summary:** 41 bounded synthetic PASS, 2 PARTIAL (C29/C30), 1 DEFERRED (C44), no required C1 family reported BLOCKED. Platform subcases are explicitly skipped rather than counted as successful assertions. This summary must not be read as 44 fully production-qualified families.

The local six skips comprise the S5 native symbolic-link attempt (permission unavailable), S1 native alias and four inherited V1 POSIX/link-related cases. No permission workaround was attempted. All71 new S5 tests pass in each hosted CI job, including its permitted native symlink test. Windows CI still skips the inherited S1 alias; Ubuntu exercises its own existing POSIX/link variants. Neither closes deployed Windows ACL/privacy gates or retroactively turns the six local skips into passes.
