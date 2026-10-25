# Admission state, publication, recovery and reads

2026-10-25 · [Proposal index](README.md) · **Storage/API/schema designs only; no SQL, migration or runtime code is supplied or executed.**

## 1. Trust invariants

- A catalog current head references exactly one accepted admission, whose immutable source/epoch/registration, canonical snapshot, full-source receipt and digests agree.
- A rejected, held, malformed, incomplete, conflicting, stale or unauthenticated capture cannot insert an accepted admission, advance last sequence, consume a successful request, replace current, or change accepted product rows.
- Accepted snapshots and receipts are immutable. Retry may add an attempt/audit record but cannot duplicate a snapshot. Do not assert byte-for-byte equality of the entire database after rejection: diagnostic attempts may legitimately be written.
- Ordinary canonical import is **not a trusted path**. A new catalog-mode state rejects all generic save/begin/commit paths and generic latest reads unless they use the admission service's checked publication/read operation. Reserved and unregistered namespaces cannot be used as alternate entry points. No fallback on admission failure.
- Cross-source IDs are always scoped. A head, request, admission, snapshot and historical/diff request cannot be joined by SKU, display name or unscoped snapshot ID.
- The acceptance event is durable with the admission, even if report generation or external audit delivery fails afterward.

The storage-level gate must be real code in a future implementation, not just a UI wrapper, a `readOnly` label or a public caller-supplied `trusted=true` token. Its private transaction context may carry verified facts between modules but is not authentication against arbitrary code/database writes by the OS owner. All entry points, including a session begun before a registration/policy change, must recheck at final commit.

## 2. Preferred persistent model

Add catalog metadata **to the same database that holds canonical snapshot/product rows**, in a newly created catalog development state. Logical tables below are proposed entities, not final DDL:

| Entity | Durable content and constraints |
| --- | --- |
| Catalog state descriptor | State kind, supported format/schema and capability versions; prevents treating catalog state as a V1 folder or opening it through a legacy import path |
| Source registration versions | Immutable source/company/scope/epoch/key/mapping/proof-policy/producer bindings and public-key fingerprints; separate transactional active/suspended/revoked status and revision |
| Capture requests | Source/epoch, request nonce, expected parent, binding revision, validity, status; at most one active request per source/epoch |
| Admission attempts / held candidates | Opaque attempt ID, bounded receipt/digest/diagnostic, stage and reason; held candidate/staging linkage. Untrusted labels do not become source identities; no passwords or raw customer rows in logs |
| Accepted admissions | Unique `(source, epoch, capture ID)` and `(source, epoch, sequence)`; registration revision, trust class, signed receipt bytes/signature, proof-policy, payload/source-set/canonical fingerprints, counts, capture times, snapshot reference and accepted time |
| Catalog heads | One `(source, epoch)` -> accepted admission and last sequence/revision, with composite references preventing cross-source head pointers |
| Local acceptance event / outbox | Stable event identity and digest in the same acceptance transaction; delivery state for a separate audit/report sink, never the authority for current |

Use existing snapshot tables and staging where appropriate. Add explicit compound uniqueness and foreign-key/integrity checks between source-domain admissions, heads and snapshots, not merely documentation conventions. Unknown schema/proof-policy versions fail closed. The immutable signed receipt is retained in the database so acceptance provenance does not depend on a file rename succeeding after commit. Raw payload retention is separately bounded and private; raw ERP exports do not belong in GitHub.

Only authentically verified claims can be associated with a registered capture; a malicious unauthenticated filename/ID must not reserve a sequence. Authenticated conflicting producer statements are quarantined and source admission paused. No automatic deletion/retry-with-new-ID workaround resolves conflict. Rejection diagnostics may be unavailable under disk failure; if they cannot be persisted, report that fact without changing the accepted head.

## 3. Admission flow

1. **Resolve:** accept a trusted local source handle chosen by the operator. Load registration and active request. Require compatible enabled proof class, binding, connector/mapping and state kind. New synthetic registrations cannot be relabelled ERP-qualified.
2. **Receive bounded candidate:** open payload/receipt as untrusted inputs. Read from one stable handle or a new private bounded spool, not a path re-opened after validation. No input-controlled destination paths, symlink/reparse traversal, archive extraction, external URLs or network retrieval in the first slice.
3. **Verify:** strict parsing, pinned signature, observed origin/request/scope/profile, source completion/consistency/count/key-set/digest, payload integrity, stable-key uniqueness and canonical mapping. Compute staged-row canonical digest; no unknown quantity becomes zero. Reject a self-consistent truncated payload against the qualified source evidence.
4. **Classify:** exact accepted replay returns its existing result without promotion; conflict/stale/request mismatch fails. Fresh but large missing-set change is held for owner review; review cannot waive source proof and must be rechecked against current registration/head/request before publication.
5. **Stage privately:** persist only candidate rows/attempt state outside accepted queries. Expensive parsing/hashing occurs before the short final writer transaction, but verified digest and row mapping must be recomputed/checked against staged rows inside publication. A precomputed in-memory assertion is not enough against staging substitution.
6. **Publish in one immediate transaction:** reread registration/key/policy revision and status, request and expected head; reclassify exact replay/conflict under the lock; enforce sequence/time and request constraints; check staged canonical content/count/digest; insert canonical snapshot and products, accepted admission and receipt, consume request, update head/last sequence with expected-parent comparison, append local event/outbox, and remove this candidate's staging. All succeed or none become accepted.
7. **Acknowledge:** only after commit report accepted. Receipt/report/audit export uses the committed admission ID. If the caller lost the response, retry finds the accepted tuple and returns it without creating another snapshot or returning current to that tuple.

The current `SnapshotWriteSession.commit()` owns its own transaction and returns a checkpoint. Calling it and then updating metadata in another transaction is **not** this design. A future storage extension must integrate canonical finalize and admission checks under one connection/transaction (or provide a private transaction-bound finalize primitive with no separately exposed trusted commit). The public generic importer must not be used as an import-first/promote-later shortcut.

## 4. Current and source ordering

Trusted current is the committed catalog head, **not** `ORDER BY captured_at` or last arrival. Canonical capturedAt remains the producer's unmodified finish time. The first profile additionally rejects non-increasing capture time for a fresh sequence as a clock-policy hold; it does not synthesize dates to force latest ordering.

Use bounded exact positive integers for sequence (first profile: at most `Number.MAX_SAFE_INTEGER`); reject overflow/fractional/negative values instead of coercion. Sequence gaps are allowed for full captures, but current-parent CAS and request consumption remain mandatory. A known older replay can return its old admission while the head stays newer. Unseen older/equal sequences, same sequence/different identity, wrong epoch or competing producer fork never automatically promote.

If two importers present the same capture, one commits and the other rechecks under the transaction and returns replay. If different captures race for the same request/parent, at most one consumes it; the loser is stale/conflict and needs a new capture request, not blind overwrite. Independent sources have independent heads even though SQLite serializes writers globally. Use bounded busy retry/backoff and stable operation IDs; do not hold a database write transaction while waiting on the filesystem, owner input or producer.

## 5. Failure and recovery matrix

| Failure point | Required state after restart |
| --- | --- |
| Receive/parse/signature/proof failure | Previous accepted head intact; attempt/quarantine record only if writable |
| Before staging ends | No accepted candidate; preserved bounded diagnostics; current unchanged |
| After verification, before transaction | Candidate remains nonvisible; restart revalidates policy/request, not just a `verified` flag |
| During snapshot/admission/head/request/event statements | Transaction rolls back as a unit, or recovery observes the fully committed unit; never a mixed publication |
| Immediately after commit, before response | Accepted admission found by stable identity; retry is replay and current is not reverted |
| After commit, audit/report export fails | Admission remains accepted with a truthful delivery warning; no repeat canonical write to “repair” the report |
| Registry/key/request revoked after preflight | Final transactional recheck refuses promotion; parsing success does not freeze old authorization |
| Competing initialize/recovery process | Cannot delete an active writer's staging or alter head; recovery requires writer ownership/exclusion and revalidation |
| Corrupt/missing accepted linkage | Trusted reads and new admission fail closed with recovery-required diagnosis; no fallback to generic timestamp latest |

Existing initialize normally deletes staging sessions. Future catalog opens need a coordinated startup path: readers must not invoke writer initialization/cleanup, and admission writers must acquire the managed state writer lease **before** recovery. A restarted lease/session can be recovered only after proving the prior writer is absent; never delete a lock/session merely because of age. The lease aids recovery; SQL transaction/constraints/CAS provide publication correctness. Recovery design must not depend on changing file permissions or forcibly terminating a process.

One local SQLite transaction is preferred because [WAL does not give group atomicity across multiple attached databases](https://www.sqlite.org/wal.html). Audit SQLite, spool files and HTML cannot share this commit. Use the local acceptance event/outbox as authority; external delivery is retryable. Current SqliteAuditSink's ordinary INSERT is not an idempotent delivery API: future delivery must treat identical event ID/digest as acknowledgement and different content as conflict. This also needs tests and separate API changes, not an assumption about existing behavior.

Crash tests use child-process termination and injected write errors in disposable state. They do not prove real hardware power-loss durability. Preserve WAL/SHM and use an approved closed-state/SQLite backup procedure for recovery; never copy only a live DB file or delete its journal to repair acceptance. Disk full/I/O errors must fail closed. No journal pragma, Defender, host ACL or power-setting changes are proposed for this task.

## 6. Schema and protocol decision

**Recommend a versioned catalog-state schema extension plus explicit admission/read APIs.** New durable facts and transactional constraints cannot be obtained from current SourceRef or an external JSON ledger. Canonical Product/schema stays unchanged for the first catalog-only slice; the separate admission envelope and capture proof policy get their own version. Do not claim runtime protocol unchanged: the future accepted-catalog application/storage protocol is new, even though ordinary canonical rows are reused.

The migration must add registration/request/admission/head/event structures and compatibility gates; exact DDL and the next unused version number need implementation review. Use a **fresh catalog state only** for the first slice, with opt-in initialization before generic `initialize()` can migrate or clean anything. Existing V1/Preview1 folders must be rejected as targets, not silently upgraded or copied into this format. Version routing/preflight and older-reader/writer rejection are required; today's v4 triggers are compatibility evidence, not a catalog trust mechanism.

Do not silently append a universal auto-migration to every existing V1 open. A reviewed state-kind dispatcher/catalog migration route must preserve legacy-state behavior. Catalog schema must be visibly unsupported to old binaries (including the existing future-migration guard), and new generic writers/readers must reject catalog mode. Do not rewrite applied migration bodies or checksums. Any eventual conversion of an existing state needs an independently approved backup/restore/upgrade plan.

Rollback is use of a verified pre-upgrade/empty separate state with the compatible binary, never removal of catalog metadata from an accepted state. No downgrade/migration code is included here. For the first fresh synthetic state, failure can leave the new state preserved for diagnosis without impacting V1. Model schema/integrity tests, explicit version refusal and migration-failure recovery precede adoption.

## 7. Missing products and history

An accepted full capture is a set at its own observation. Missing B means `notObservedInCapture` relative to a specified older accepted capture with the same qualified scope/epoch. Retain historical B; do not write `deleted`, generate a zero quantity or carry B into the new full set. Reappearance under the same guaranteed stable key is the same identity. A key/domain change is not a SKU rename and must not be silently reconciled.

Compare snapshots, not an unbounded mutable product cache. Derived differences are `added`, `changed` with explicit field changes, `unchanged`, `notObserved`, and `reappeared` only when the accepted history actually supports that label. The first slice can return added/changed/unchanged/notObserved between two accepted snapshots; otherwise report insufficient history instead of inventing a lifecycle event. No persistent deletion lifecycle is needed initially.

## 8. Proposed trusted read contract for Windows Desktop

Conceptual interfaces, **not implemented method names or code**:

- List registered sources and accepted captures with explicit trust class/status; no raw file-provided namespace selection.
- Open a pinned accepted read scope by local source handle and either current or an admitted snapshot reference. Resolve head/admission/registration under one consistent read, then bind every product page/query to that immutable snapshot.
- Read bounded product pages by stable-key cursor; cursor binds source/epoch/admission/filter/order. Reject cursor tampering, cross-source snapshot references and unsupported schema/proof versions. No unscoped “latest across all companies”.
- Compare two accepted snapshots from the same source/scope/epoch and compatible mapping. Return both admission contexts, stable key, old/new field values and classified differences. Reject incomparable scope/epoch/mapping, rather than call them removals/additions.

Each read context carries source/company handle, epoch, registration/proof-policy version, admission/snapshot ID, sequence, source observation and accepted time, trust class, trust-at-acceptance and current source revocation state, plus audit-delivery warning. Payload values are escaped at rendering; no private paths, receipt internals, secrets or source connection strings in UI errors/HTML. Product name/SKU are untrusted text.

Desktop receives DTOs/capabilities and opaque references, not SQLite paths/connections or a write-capable store. No renderer module can invoke the generic importer to bypass source admission. Catalog-only DTOs expose no computed quantity/value; missing fields are unavailable, not zero. Existing V1 reports/read semantics remain in their existing qualified path. Public historical-by-ID and diff APIs require future core/application tests; Stage B's read-only SQL inspection is not a substitute.

The first slice retains all accepted synthetic snapshots. Retention/GC, backup rollback anti-replay after restoring an older whole state, multi-user authorization, signed builds and customer production hardening are later qualifications. Restoring an older state does not magically remember captures committed after that backup: mark a real restored state recovery-required until an independently current source checkpoint/reconciliation is established. Do not claim rollback resistance against replacement of the entire local state from the local ledger alone.
