# Catalog S5 — synthetic concurrency, failure and public-boundary qualification

2026-10-26. **S5 only; no merge, real ERP qualification, Desktop/IPC or customer readiness.**

Product [Draft PR27](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/27), head `fdafd4c6b84384ca9e9eb093c9eee8beac153fa1`, is stacked on [Draft PR26 / S4](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/26) at `6eb2a0f41b71d862d33f64563ec501d930307814`. S1–S4 are review dependencies, not implicitly merged into main. Five test-only files are added; runtime, schema, versions, dependencies and V1 guards are unchanged. 57 relevant baseline source/package blobs matched S4 exactly.

## Read in this order

1. [C01–C44 outcome matrix](C01_C44_MATRIX.md): family-level outcomes, not an assertion count.
2. [Process races, failure protocol and commit modes](PROCESS_AND_FAILURE_PROTOCOL.md).
3. [Public API review and threat boundary](PUBLIC_BOUNDARY_REVIEW.md).
4. [Actual results, corrections and reproduction](VERIFICATION.md).
5. [Sanitized manifest](S5_MANIFEST.json): heads, test/report digests, environment and remaining gates.

## What is established

Independent Node processes exercise the built public package against new synthetic SQLite states. Same-capture contention yields one accepted unit/event and a replay. Different candidates for one request/parent cannot both publish; a loser cannot replace head. An authenticated same-sequence producer fork can instead suspend both new attempts, preserving the prior accepted state. Final transactions recheck authority, request and sequence rather than trusting preflight.

Forced process death, controlled SQLite errors, public reopen/history/retry, concurrent readers/reviewers and two-company isolation are exercised. All accepted data remains synthetic, Catalog-only and nonfinancial. No ERP/source credentials, raw customer files, retained owner evidence or operational signing key are used.

## What is not established

C29/C30 remain **partial** for external audit delivery/acknowledgement; their required local event gates are exercised. C44 is **deferred**, not passed: an entirely restored old database cannot independently know that a later capture existed. Physical power loss, actual OS/filesystem I/O failure, exact interruption at an internal WAL commit instruction, Windows permission qualification, operational key custody/rotation, supported clean-system acceptance and a true ERP producer remain unqualified.

The native-COMMIT interruption supplement uses DELETE journal mode only on a fresh test fixture. It does not silently replace the runtime's WAL design. Same-owner arbitrary SQL/code writers remain outside the API trust boundary; the database is not an OS security boundary against its owner.

## Decision and next authorization

No runtime fix or schema expansion was required by the executed S5 tests. Stop after review of S5; do not merge any PR automatically. The most useful next separate scope is read-only qualification planning for **one actual ERP product/version and an authorized noncustomer test company**, including independent company identity, stable product key and complete consistent extraction. Synthetic proofs alone cannot qualify those properties. Do not start a connector or Desktop implementation from this evidence.

## Related decisions and evidence

- [C1 design/implementation plan, Draft memory PR16](https://github.com/elias-mujally/dbl-products-memory/pull/16).
- [S1 product PR23](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/23) / [memory PR17](https://github.com/elias-mujally/dbl-products-memory/pull/17).
- [S2 product PR24](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/24) / [memory PR18](https://github.com/elias-mujally/dbl-products-memory/pull/18).
- [S3 product PR25](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/25) / [memory PR19](https://github.com/elias-mujally/dbl-products-memory/pull/19).
- [S4 product PR26](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/26) / [memory PR20](https://github.com/elias-mujally/dbl-products-memory/pull/20).

These links intentionally refer to Draft dependencies rather than assuming their documents are present in memory main. Older S4 statements that S5 was unimplemented remain accurate for their recorded stage and are superseded only by the bounded results here.
