# Trusted source enrollment and full-capture evidence

2026-10-25 · [Proposal index](README.md) · **All mechanisms below are proposed, not implemented.**

## 1. Enrollment is an owner-controlled operation

Never auto-create or amend a registration from an import file. The owner selects a source in DBL; the service resolves an opaque local source handle. No path, connectorId, company name or public key in a payload can redirect that handle to another company.

An immutable registration version binds:

- A locally issued source ID and company ID, independently matched to authorized company/source records; a display name is not identity.
- Actual ERP product, edition/version and source instance identity, documented company-selection mechanism and full-catalog scope. This is vendor/version-specific; no SQL database, table, GUID or API is assumed universally.
- Qualified producer ID/build digest, connector/mapping version and extraction-method profile; supported input/envelope versions and exact field semantics.
- Key policy: stable non-reused product key, case/encoding rules, scope coverage including inactive/blocked products, and epoch continuity. SKU is mutable and cannot substitute for the key.
- A local namespace generated from the registration/epoch, not accepted from the file; an allowed trust class (`synthetic` or separately qualified ERP), producer public-key fingerprint and proof-policy version.
- Owner authorization/evidence references, status (`pending`, `enabled`, `suspended`, `revoked`), validity and registry revision. No passwords/private keys in receipts, documentation or GitHub.

Initial status is pending. Activation needs a reviewed qualification record: correct source/company identification, known full-set extraction, consistent observation, completion/error handling, stable-key behavior and read-only source authorization. For Stage C tests only a synthetic profile can be enabled; it must never be presented as ERP-qualified in outputs or Desktop.

Changes create a new binding version, never mutate the identity of historical admissions. A connector upgrade with identical qualified semantics can retain the source/key domain after review. A change of company, key interpretation, scope or continuity requires explicit requalification/new domain, not a convenient epoch reset or silent merge. On revocation, block new admissions. Old evidence remains readable with its original decision and current revocation warning; do not rewrite history as though current authorization existed at the time.

## 2. Request-bound manual acquisition

Before a fresh full capture, DBL durably issues one active request for that source/epoch: random challenge, request ID, registration/proof-policy revisions, scope/mapping, expected parent admission ID, last sequence and bounded validity window. Issue/cancel/supersede is auditable; it does not change current. A new request invalidates an older unconsumed one. Correctness comes from transactional uniqueness/rechecks, not a UI mutex.

A qualified producer receives the request through a separately approved channel. Manual file delivery remains valid; no SQL connection from DBL, service installation, network opening or scheduler is required by this design. Request/receipt transport and actual producer deployment are not authorized here. An old arbitrary CSV without qualified acquisition evidence cannot be retroactively marked trusted by an operator checking a box.

The producer authenticates the configured source, reads its actual instance/company identity by the qualified method, verifies it against enrollment and performs a consistent full-scope observation. It must fail closed if identity, scope or consistency cannot be established. Secrets remain with the producer/source, not in the exported package or Desktop.

## 3. Authenticated receipt and payload

Proposed artifacts: a bounded catalog payload and a detached signed acquisition receipt. The receipt binds all of the following in one authenticated statement:

| Binding | Evidence required |
| --- | --- |
| Registration | Local source/company IDs, observed source identity, epoch, binding revision, scope digest, connector/mapping/proof-policy version |
| Request | Challenge/request ID, expected parent admission, issue context and validity; not merely an import-time timestamp |
| Capture | Immutable capture ID, positive monotonic sequence, start/finish UTC, consistent observation token/method and completion status |
| Full set | Independently source-derived row/key counts and normalized product-set digest from the same consistent observation, full page/chunk coverage and successful exporter end marker |
| Transfer | Exact payload byte length and SHA-256; named payload role, not arbitrary source-controlled output paths |
| Producer | Pinned issuer key ID, qualified producer build/method and signature; a file-supplied key never becomes a trust anchor |

Prefer a detached **Ed25519** signature using the approved Node crypto runtime after compatibility tests, rather than a shared secret in the importer. The producer's private key stays outside the input package and importer. Key provisioning, safeguarding/rotation and producer qualification are separate operational approvals. A signature authenticates the enrolled producer, not the truth of its SQL query or export method.

Freeze a small, versioned UTF-8 encoding profile before implementation: fixed field schema, no duplicate JSON keys, no invalid UTF-8/unpaired surrogates, no BOM, no nonfinite/fractional sequence/count, no unknown required extensions or implicit type conversion. Verify signature over the exact canonical receipt bytes and compare parsed canonical re-encoding; do not sign one interpretation and import another. Product-set digest uses a specified ordinal stable-key sort and exact field serialization, not locale-dependent sorting or undocumented JSON property order. Stage B's fixture JSON serialization is not the wire specification.

The first synthetic profile may cap payload at 1 MiB, 1,000 rows, 8 levels, key/SKU at 256 Unicode scalar values and name at 1,024; these are proposed safety limits, **not scale qualification**. Reject excess entirely, never truncate to the first N products. Reject key ambiguities/control characters; do not silently trim/case-fold/merge keys. Encoding and canonical digest vectors must be approved and tested before coding the operational path.

## 4. What proves completeness and what does not

The independent evidence is source-side observation performed by a qualified producer, authenticated against local registration. The candidate's own `declaredCount`, hash or `complete=true` is not that evidence. At admission compare independently signed source count/key-set/product digest to the received and mapped full set, in addition to exact transfer hash and completion/page evidence. Two self-consistent documents generated only by counting the received file are still self-attestation.

The source method must demonstrate that the count/digest/identity and exported rows belong to the **same consistent scope and observation**: e.g. a vendor-supported atomic export or an authorized consistent read method whose behavior has been qualified for that specific product/version. If paging can change mid-read, or a failed query yields a partial result with successful-looking metadata, the profile is not qualified. No “count before/count after looked equal” shortcut establishes consistency. The verification algorithm cannot repair a producer that signs an already filtered or inconsistent set.

DBL rejects: missing/unknown/mismatched receipt, unknown issuer, invalid signature, wrong company/source/scope/epoch/build/mapping, failed completion, gap/duplicate page, row/key/hash mismatch, ambiguous zero, stale request or out-of-order capture. A self-consistent truncated payload with its own count/hash recalculated fails against the authenticated full-source evidence. If an attacker can forge a matching receipt under a trusted key, or the trusted producer lies with matching signed evidence, that is outside file-verifier assurance and triggers a signer/source incident; no universal completeness claim is made.

An explicitly attested empty whole catalog is allowed by policy. A sudden major reduction, including a nonempty-to-empty change, is held for owner review after cryptographic/completeness checks; that review may approve the change magnitude only, **never waive missing source proof**. The first slice uses a deterministic test policy holding any missing key. Business thresholds for a real source require separate qualification.

## 5. Exact replay, freshness and forks

Identity domain is `(local source ID, epoch, capture ID)`; sequence is unique within `(source ID, epoch)`. Snapshot ID is derived from that immutable tuple using a specified unambiguous encoding, **not** from mutable SKU or content hash. The canonical fingerprint remains an additional content check. A single capture ID with changed signed content is conflict, not a fresh snapshot with a new ID.

Exact accepted replay uses the stored accepted digest/receipt and returns the prior admission without changing head or sequence, even after a later capture. It does not require a now-consumed request to become active again or upgrade trust after revocation. Different bytes or a different statement for the same accepted identity conflict. Unauthenticated candidates cannot reserve source sequence/capture identities or poison the accepted ledger. Authenticated producer forks pause new admissions for review rather than replacing accepted evidence.

For an unseen candidate require: enabled unchanged registration/key/policy, active matching request, current parent equal to the request's parent, sequence greater than committed last sequence and valid capture time. Equal sequence/different capture, unseen older capture or epoch reset is rejected/quarantined. Gaps are allowed only because this is a **full snapshot**, not a claimed complete event stream. Do not infer missing business events from sequence differences.

Keep the Stage B conservative clock rule for the first profile: a new sequence whose finish time is equal to or earlier than the accepted finish time, outside the allowed request window, or implausibly ahead of the checked local clock is held/rejected; never rewrite source time. Ordering authority is still the accepted sequence/head, not the clock. Clock health/validity windows and any future loosening need explicit policy tests. Two concurrent captures for one request cannot both consume it.

## 6. Real-source qualification still needed

Before enabling any real ERP registration, independently authorize and verify vendor/version, storage/export mechanism, stable key/reuse/rename semantics, company/instance identity, full-scope/inactive coverage, consistent-read/completion evidence, actual read-only privileges, issuer key custody and deployment, limits, operational clocks and failure behavior. No real source was inspected for this proposal. Where any mandatory fact is unavailable, the trusted import stays blocked; do not lower the proof class or borrow V1/historical evidence to qualify another ERP.
