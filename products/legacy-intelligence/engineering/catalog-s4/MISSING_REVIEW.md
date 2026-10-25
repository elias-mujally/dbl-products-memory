# S4 exact owner missing-set review

2026-10-25 · Acknowledgement of non-observation; never a delete/zero or source-proof override.

## Separate owner capability

Trusted host calls `openSyntheticCatalogReviewer(directory)`; do not give this object to the Desktop read consumer. It exposes only `preview(sourceHandle,paths)` and `approve(sourceHandle,paths,decision)`. Owner handle has exactly `{sourceId,epoch}`; paths are the three S2/S3 payload/receipt/signature files. This is the same trusted owner-host application boundary as enrollment, not a new password prompt, OS role or independently audited human identity.

Preview opens query-only state, validates locally pinned source/company/scope/epoch/profile/registration/key, pending valid request/challenge/parent/time, exact signature/canonical bytes, full-source completion/count/key/product digests, current parent, order and existing authenticated-fork ledger. It validates the accepted parent's actual rows and computes missing stable keys from those rows. No missing keys / no accepted parent means review is not required; an already accepted capture identity or known producer fork refuses.

Proposal contains `{binding,missingKeys}`. Binding has company/source/scope/epoch/registration, request/current parent, capture/sequence, exact receipt/payload hashes and missing-key digest/count. Missing-key SHA-256 uses domain `dbl.catalog.missing-keys.1`, NUL separator and canonical UTF-8 JSON of the BINARY/UTF-8 sorted key list. Product key normalization is not guessed.

The owner reviews the proposal, then supplies exactly `{decision:'acknowledge-not-observed',binding:proposal.binding}`. Tests emulate this approved synthetic owner action; no real human review UI is claimed. Generic booleans, delete decisions, extra authority fields or changed binding values do not qualify.

## Durable approval and admission

Approval recopies/revalidates the files and fresh registry/request/parent under one immediate transaction. It compares every binding field with freshly computed evidence. A deterministic `missing.reviewed` event and the existing `catalog_reviews` row are saved together. Event data/digest and reviewed time are validated, bound to that request and key-validity interval. Identical approval while still valid/pending is idempotent across reopen. No snapshot/product/admission/head is written and the request stays pending. Failure saving the row rolls back its event too.

Approval never performs source observation/fork suspension or accepts a capture. S3 remains the sole publisher and still reauthenticates/revalidates inside its acceptance transaction. Its bounded change replaces unconditional missing-set hold with an exact review lookup for that request, registration, receipt, payload, parent and missing digest. The event binding/digest/time is checked, not merely row existence. Stored accepted reads/replay also verify the review where their direct parent comparison shows missing keys. A direct parent's signed unit is verified for that comparison; this is not a semantic audit walk of every ancestor in the whole database.

Cancellation/expiry/suspension, a different parent/head/request/proof or altered bytes invalidate applicability. Review cannot authorize a source-incomplete payload even if self-count/hash are recalculated; it cannot waive wrong company, signature, sequence, parent or source validity. With no exact durable review, `CATALOG_MISSING_KEYS_REVIEW_REQUIRED` still holds and current remains unchanged. Immutable old snapshots are neither removed nor rewritten.

## Observed scenario

A/B accepted -> A (renamed SKU/name) + B/C accepted -> full fixture A/C is held for B review -> owner acknowledges B not observed and normal S3 accepts A/C -> later full fixture A/B/C accepts. Public historical opens still return old A/B and revised A/B/C after reopen. Pairwise diff identifies B as notObserved, then added with an actual prior accepted reference; no deleted/reappeared lifecycle, zero stock or monetary effect is stored.

An initially signed full empty set needs no missing review. A later nonempty-to-empty capture follows the same exact review rule for all previous keys; S3's existing no-review empty-set hold remains in regression coverage. The S4 scenario specifically qualifies B's absence/return, not a real ERP empty-export extractor. A trusted producer can lie about completeness; local approval/cryptography cannot prove unseen external rows. Real-source qualification, operational owner identity/review UX, cross-process contention, general key rotation and restore anti-rollback remain open.
