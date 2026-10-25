# Catalog S3 — atomic synthetic admission

2026-10-25 · **Synthetic Catalog only. S4/S5 and real ERP remain unqualified.**

Implementation: [product Draft PR25](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/25), commit `49d2f0c1a7c2fa61f410f0050c05348c994f033b` ([admission](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/49d2f0c1a7c2fa61f410f0050c05348c994f033b/packages/storage-sqlite/src/catalog/admission.ts), [API/fault tests](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/49d2f0c1a7c2fa61f410f0050c05348c994f033b/packages/storage-sqlite/test/catalog/admission.test.ts)).

- [Transaction, identity and replay](TRANSACTION_AND_REPLAY.md)
- [Executed tests, fixes and open gates](VERIFICATION.md)
- [Reproduction, recovery and review sequence](REPRODUCTION.md)
- [Sanitized manifest](S3_MANIFEST.json)
- [C1 plan PR16](https://github.com/elias-mujally/dbl-products-memory/pull/16), [S2 product PR24](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/24), [S2 evidence PR18](https://github.com/elias-mujally/dbl-products-memory/pull/18), [S1 product PR23](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/23).

## What S3 adds

The separate public Catalog facade adds `admitSyntheticCatalogCapture(directory, selectedSourceHandle, filePaths)`. It accepts no rows, SQL, preverified result, trust flag, namespace choice or caller transaction. S2 owner registration/challenged requests and independently signed full-fixture evidence remain prerequisites. All new state/data/keys are synthetic; there is no ERP extractor, network synchronization, operator delivery or V1 migration.

One synchronous SQLite immediate transaction saves snapshot metadata, product rows, exact signed receipt/signature, admission and sequence, mandatory local accepted event, head advancement and request consumption. The head derives from immutable admissions via the existing SQL trigger, not an external current pointer. Deferred foreign keys require the whole linked unit at commit. Stored rows are rehashed before sealing and the complete saved linkage is checked before success is returned.

Authenticated observations/conflict records use a separate short transaction as designed in C1. They are **not** acceptance and cannot publish products or move head. Unauthenticated claims cannot reserve a capture/sequence or suspend a source. An authenticated fork records rejection and suspends new admissions without editing the last accepted unit. The pending request remains for diagnosis; cancellation is explicit owner action.

## Demonstrated boundaries

API tests accept A/B, then revised stable A plus B/C; old rows remain immutable. Reopen and exact replay return the durable admission without creating another snapshot/event or advancing an older capture. Expired/consumed requests do not block exact accepted replay; current source suspension/key expiry is reported as a warning, never silently reversed. New captures still require current authority and a fresh valid pending request.

Missing keys, including nonempty-to-empty, **hold** with `CATALOG_MISSING_KEYS_REVIEW_REQUIRED`. S3 does not implement the owner missing-set approval/read interface planned with S4/C39. No missing key becomes a deletion or zero quantity; no carry-forward inventory is fabricated. An initially attested empty synthetic catalog is supported. The bound remains 1,000 products/1 MiB; products have only stable key, SKU and name, without stock, costs or currency.

There is no S4 public product-history/difference reader. S3's private bounded stored-unit check is needed for safe replay/admission; tests additionally inspect their own disposable SQLite state to confirm historical rows. That inspection is not presented as a shipped historical API.

## Trust and review status

S2 commit `b0e012d88743f6ad56db884713bd2ac607c27fdd` is the exact parent. S2 remains based on unmerged S1 `d76bc71f1cf5320c43edbde4c4d6076436d5bb1a`; product main remains separate. S3's PR is stacked on S2 and contains S3 changes only. Review in dependency order; no PR is merged automatically.

A locally trusted issuer can lie about an unseen full source. Signature verification does not eliminate that S2 trust limit; no real issuer/extractor/company is qualified here. Same-owner raw database/code modification is outside API access isolation. Whole-state rollback to an earlier backup, physical power loss, multi-process admission contention, real key lifecycle and customer/production operation remain open gates.
