# S3 transaction and replay contract

2026-10-25 · Implemented on the unchanged S1 Catalog schema, not on V1 tables.

## Input and authority

The public admission input is exactly the same three bounded local paths used by S2 plus an independently selected local `{sourceId,epoch}`. File bytes are copied into private bounded memory before any write transaction. No asynchronous callback, filesystem import, prompt, external audit call or report generation occurs inside the final transaction. The public package does not export its SQL handle, bound proof objects, internal writer or raw insertion helpers.

S2's receipt grammar is completed as planned for multiple captures: `expectedParentId` can be null for the first capture or an identifier for a later request. Request creation reads the actual head within its own transaction and stores/signs that parent binding. Old first-capture null-parent evidence is unchanged. This is an explicit synthetic Catalog extension, not a change to the legacy/V1 protocol or data. S1 DDL already supports these parents; no migration/checksum change was necessary.

Registration/request/proof/canonical-byte checks are shared with S2, not reimplemented as a permissive shortcut. S3 removes the temporary S2-only empty-publication restriction from the internal connection helper so subsequent requests can be made. Schema/format/family/fingerprint/foreign-key checks and synthetic-only policy remain. The new public `./catalog` facade exports only creation, schema inspection, synthetic owner provisioning, proof verification and gated admission.

## Authenticated preflight

1. Validate exact canonical receipt and pinned Ed25519 signature against the locally bound company/source/scope/epoch/origin/profile/connector/build/mapping/key. File labels do not enroll or select trust.
2. Resolve an already accepted capture before demanding pending/unexpired request status. Exact signed-statement identity plus exact payload and stored-unit integrity yield replay. A consumed request is not reconsumed; head is not updated. Source revocation/expiry warning is current metadata on an acknowledgement of historical acceptance.
3. A newly authenticated request must still be pending/valid and bind the challenge, parent and capture time. Its immutable claimed capture/sequence is recorded as `capture.observed` with receipt/signature and digest. Reobserving the same statement is idempotent. An authenticated changed statement for a previously observed capture/sequence suspends the source transactionally and appends a conflict event; forged/unbound input cannot poison this ledger.
4. Verify full row/key/product-set evidence and transfer hashes against copied payload bytes. A corrupt transfer can be retried with the same original receipt and correct bytes. A producer changing its signed statement under an observed identity is a fork, not a transport retry.

Observation may survive a rejected full payload; it is never a product snapshot. Conflict suspension is an intentional diagnostic/control effect, distinct from the immutable accepted unit. Failures of conflict event/control writes roll back together.

## Single acceptance transaction

Under `BEGIN IMMEDIATE`, on one Catalog connection with foreign keys, recursive triggers and full synchronous durability enabled:

1. Repeat source registration/current authority, signature, request/challenge/parent/time and accepted-replay checks using fresh database facts and private bytes, not an S2 result supplied by the caller.
2. Require exact request parent == current head, strictly increasing source sequence and capture finish time. Revalidate the previous stored accepted unit and hold any missing stable key without exact owner review.
3. Generate deterministic, domain-separated SHA-256 IDs from `[sourceId,epoch,captureId]`: domains `dbl.catalog.admission-id.1`, `dbl.catalog.snapshot-id.1`, `dbl.catalog.accepted-event.1`. Content hashes do not choose snapshot identity.
4. Insert snapshot and products. Re-read actual inserted rows in SQLite BINARY order and reconstruct canonical payload bytes; recheck transfer length/hash and full-source count/key/product-set digests. An inserted-row substitution fails here.
5. Insert the deterministic mandatory local acceptance event with its canonical data hash, then the admission containing exact receipt/signature and registration/request/snapshot/event links. Existing admission trigger atomically advances head.
6. Consume exactly that pending request for that admission. Verify stored signed proof, rows, snapshot, event, request and head linkage; check deferred foreign keys. Check current authority and expiry again at the end of bounded work.
7. Commit, including deferred constraints, before returning `accepted`. There is no second acceptance commit in an audit/control database or filesystem.

Receipt metadata includes source/synthetic trust, capture/sequence, admission/snapshot/local-event IDs, accepted time, count/digests, current head and `isCurrent`. It contains no product rows or reusable publication capability; `erpQualified` is always false. Schema inspection still means schema integrity only and does not certify arbitrary rows as accepted.

## Failure and recovery

Before commit, a statement/constraint/digest/expiry failure rolls back the entire accepted unit; an earlier authenticated observation can remain. Reopen checks Catalog format/schema/integrity without staging cleanup or migration. No marker, WAL/SHM or failed state is deleted to make recovery pass.

A commit exception is `CATALOG_COMMIT_OUTCOME_UNKNOWN`, not a claim that nothing was committed. Preserve state and retry **the same capture and exact files**. Durable lookup resolves accepted/replayed versus a fresh validated attempt. Lost response after commit, including an actual isolated child exit immediately after commit, cannot create a second event or regress head. Optional consumer/output failure after acceptance does not undo the database transaction. No real HTML or external audit transport is added/tested by S3.

Replay validates the saved receipt/signature and actual stored rows/linkage before acknowledging trust, including a newer head when replaying an older capture. Corrupted product/event evidence causes refusal without automatic repair. Current status/key-validity warnings do not disable historical authenticity. Active registration rotation beyond the supported synthetic revision fails closed; an operational key-history/rotation feature is not implied.

Cross-process admission contention, broad abrupt-exit/power-loss sweeps and stronger restore anti-rollback anchoring remain S5/separately authorized work. Current SQLite serialization is used but not advertised as final concurrency qualification.
