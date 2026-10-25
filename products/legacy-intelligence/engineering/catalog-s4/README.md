# Catalog S4 — accepted reads, differences and exact missing-set review

2026-10-25 · **PASS_S4_SYNTHETIC_ACCEPTED_READS_DIFF_AND_MISSING_REVIEW**

- [Read API and cursor contract](READ_API.md)
- [Owner review and narrow S3 gate change](MISSING_REVIEW.md)
- [Executed tests, reproduction and limits](VERIFICATION.md)
- [Source/document/report manifest](S4_MANIFEST.json)
- [Product Draft PR26](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/26), implementation `6eb2a0f41b71d862d33f64563ec501d930307814` ([reader](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/6eb2a0f41b71d862d33f64563ec501d930307814/packages/storage-sqlite/src/catalog/reader.ts), [review/admission](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/6eb2a0f41b71d862d33f64563ec501d930307814/packages/storage-sqlite/src/catalog/admission.ts)).
- Dependencies: [S3 PR25](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/25) / [S3 evidence PR19](https://github.com/elias-mujally/dbl-products-memory/pull/19), [C1 plan PR16](https://github.com/elias-mujally/dbl-products-memory/pull/16). S3's S2/S1 ancestors remain unmerged.

## What is implemented

A host selects one registered company/source/scope/epoch and opens a read-only port. It can open current or a durable admitted historical reference, page products and accepted-capture metadata, and compare two compatible chronological accepted snapshots. Every requested unit is checked against stored signature/receipt, actual rows, admission, request and mandatory local event; missing-set review is checked where applicable. No ordinary namespace label or file-supplied trusted flag can substitute for an admission.

Product and comparison views remain pinned when head changes. References bind state/company/source/scope/epoch and accepted snapshot/admission/sequence/interpretation/digest. They are selectors validated against storage, not secret credentials. HMAC-authenticated page cursors bind the exact view, references, page size and position using a per-port memory key. A new port/process cannot reuse an old cursor; the durable historical reference can reopen and restart paging.

Differences have only `added`, `changed`, `unchanged`, `notObserved`. A stable key that returns after absence remains `added` relative to that pair, with `priorObservation` only when an earlier accepted snapshot proves it. No deletion, zero, carry-forward or persistent `reappeared` lifecycle is inferred. SKU/name changes preserve stable-key identity; reusing a SKU under a different key does not imply a return.

The separately constructed trusted-owner reviewer previews the exact missing set and records approval tied to source, request, current parent, signed receipt/payload and missing-key digest/count. Review never publishes, consumes the request or advances head. S3's existing fully checked acceptance transaction now requires the matching durable review instead of an unconditional missing-set hold. The S3 hold remains when no exact review exists. No DDL/migration, V1 guard or Preview1 change was needed.

An injected application facade projects approved DTO fields and returns sanitized error envelopes. It has no storage runtime import or owner/writer API; no SQLite connection, source-origin/path, key, signature, stack or error cause is passed through that facade. Actual Desktop UI/IPC configuration and a human review workflow are **not** implemented or qualified by these API tests.

## Actual evidence and remaining gates

68 new S4 tests passed; bounded regression **425 passed, 0 failed, 5 explicit inherited Windows skips**. A/B -> revised A/B/C -> absent B -> returning B is exercised through real synthetic SQLite admissions and public read APIs, including reopen and old snapshots. Twenty-two protected S1/S2/S3/legacy application files match the S3 parent.

S5 contention/full crash/public-bypass qualification, operational key rotation, independent restore anti-rollback, actual ERP origin/completeness, supported Desktop operation, performance/service limits and production/customer readiness remain open. No new S5 harness, ERP connector, scheduler/network connection, stock/price/cost/value model, dependency installation or system/security setting is added. Same-owner arbitrary raw DB/code access and a lying locally trusted producer remain external trust limits.

S4's product PR is stacked directly on S3 `49d2f0c1a7c2fa61f410f0050c05348c994f033b`; no PR is merged automatically. Older S3 statements that missing keys always hold or that public history reads do not exist describe S3 at its pinned commit; S4 supersedes those boundaries only with the exact checks documented here.
