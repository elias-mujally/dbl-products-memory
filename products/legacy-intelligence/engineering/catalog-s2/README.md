# Catalog S2 — synthetic registry and full-capture proof

2026-10-25 · **S2 only. No trusted admission, current update, ERP connector or operational qualification.**

## Navigation and dependency

- [Byte and authority contract](CANONICAL_PROOF_CONTRACT.md)
- [Actual verification and deferred gates](VERIFICATION.md)
- [Reproduction and next boundary](REPRODUCTION.md)
- [Sanitized file manifest](S2_MANIFEST.json)
- [S2 product Draft PR24](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/24), implementation commit `b0e012d88743f6ad56db884713bd2ac607c27fdd` ([public facade](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/b0e012d88743f6ad56db884713bd2ac607c27fdd/packages/storage-sqlite/src/catalog/state.ts), [proof tests](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/b0e012d88743f6ad56db884713bd2ac607c27fdd/packages/storage-sqlite/test/catalog/proof.test.ts)).
- [S1 product PR23](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/23) and [S1 evidence PR17](https://github.com/elias-mujally/dbl-products-memory/pull/17)
- [Approved C1 plan PR16](https://github.com/elias-mujally/dbl-products-memory/pull/16)

This document records a later authorized slice. Earlier S1 statements that S2 had not begun remain historical statements at their pinned commit, not the current S2 status. S1 is still unmerged; the S2 product review is stacked on its branch so reviewers see only S2 changes. Neither PR is merged automatically.

## Implemented

The separate Catalog facade adds `openSyntheticCatalogOwner` and `verifySyntheticCatalogCapture`. Owner setup creates a local random source identity, epoch and namespace, pins the company/scope/origin/connector/build/mapping/profile/public key, and logs its transaction. Fixed database and API policy permit only the synthetic profile/class. No input file can enroll a source, select a namespace or supply a replacement trust key.

Owner setup issues a durable pending request with a fresh 32-byte random challenge, expiry and null parent. Issuing a new request cancels the previous pending one atomically. Cancellation and suspension are explicit owner operations. All lifecycle mutations include their event in the same SQLite transaction. S2 changes neither the S1 DDL nor V1 state schemas.

Verification reads bounded local files, validates canonical bytes, looks up the independently selected local source and pending request, validates its currently pinned Ed25519 public key and signature, and compares delivered bytes/key set/product set against the signed full-source observation. A result contains metadata only: `S2_SYNTHETIC_PROOF_ONLY`, `published:false`, `trustedAdmissionAvailable:false`. It contains no product rows or authorizing token. Verification is read-only, repeatable, leaves the request pending, and requires the four publication tables to remain empty.

## Proven scope versus open trust

The independent **test producer implementation** imports Node crypto, not the production canonical encoder/verifier. It reads a known full fixture, computes set evidence independently and signs it with a fresh in-memory test key. This is not a separately operated human qualification, a real ERP extractor, a production key workflow, or proof of source consistency under concurrent ERP writes.

A subset with its count/hash recalculated cannot satisfy the signed full fixture evidence. Altering that evidence invalidates the signature. **A lying locally trusted signer can sign a subset as if it were complete; the verifier cannot discover unseen rows from the file alone.** A test explicitly demonstrates this limit without publishing any snapshot. Source/issuer qualification is therefore still required before real use.

Sequence/capture IDs have strict grammar, but there is no accepted replay ledger, head advancement, current ordering or missing-item policy implementation in S2. Repeated successful verification is not an admitted replay guarantee. Those belong to later separately authorized slices. No Windows operator interface, auto-sync, real keys, network/database connection or customer data are added.

## Preserved boundaries

No V1 identity/cardinality guard, ERP data, Preview1 artifact, historical laboratory, private evidence vault, system setting, dependency or schema migration is changed by S2. New tests use disposable synthetic Catalog roots and temporary in-memory signing keys. Raw test reports, state databases, proof files and machine-local paths are excluded from this repository. Main branches and all existing PRs remain unmerged.
