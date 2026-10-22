# Repeated integration — local execution status

Date: 2026-10-22. **PUBLISHED FOR REVIEW / NOT MERGED.** See [publication receipt](PUBLICATION_RECEIPT.md).

[Index](README.md) · [ADR](ADR-V1-001-FILE-REFRESH.md) · [Evidence](EVIDENCE.json)

## Preserved baseline

Actual V1 acquisition/import/persistence/analysis passed at local code checkpoint e82e5d003f7c546f170698ef2a107773d0837488. Five quantities30/3/50/2/12, total1470SAR. Original source hash6487315E…B4547E; exact pins are in the public registry; private artifact locators are held separately by the owner. This does not update GitHub main by itself.

## New implementation

`apps/v1-file-import` implements explicit repeated file import into a managed persistent state, with content-addressed raw retention outside Git, local SQLite admission locking, checkpoint replay, capture-order/skew checks, persistent audit, close/reopen verification and bounded retention. The baseline verification script remains available unchanged; the operational entry point requires no fixed balance reference.

## Proven locally

- Fifteen synthetic operational tests passed, including independent processes, later changed/unchanged observations, known replay, rejection of unseen older/equal-time captures, concurrent-writer refusal, hard exit after commit and recovery without duplicate records, damaged-archive refusal, source-clock skew, retention stopping and exclusion of retained raw JSON from normal Git staging. These are not new ERP captures.
- A mixed-runtime check encountered migration2 checksum drift. The existing hash uses function.toString(); the transformed test representation differs from the compiled representation. Compiled-process repetition works. No migration/checksum guard was weakened.
- Full build/typecheck and **396 passed / 38 skipped** tests. Skips preserve the pre-existing external historical-evidence/live-SQL gates; they were not replaced with fabricated positives. The application has 17 tests: 15 synthetic operational controls, one actual-owner-artifact repeated-process test and one code-fingerprint diagnostic.
- **Actual retained artifact:** four separate CLI processes produced applied/replayed/replayed/replayed, one checkpoint, five current products and value1470SAR. The source was copied once by hash into the private state archive; replay never added quantity or rolled back latest. SQLite integrity and foreign-key checks passed; audit contains four successful imports. These all replay the one real acquisition, not four source reads.
- **DBL-state recovery:** a quiescent complete state ZIP (50,060 bytes) was expanded to a different directory. All15 constituent file hashes matched before replay; the restored compiled process returned replayed, checkpoint1, five products and1470SAR. This is not an ERP .bak or VM restore test.

At the original local seal, code was `471d104f8e5965229bf420f259fb7d47a94d391c`, tag `codex/v1-recurring-local-20261022`, branch `codex/v1-inventory-import`; no PR had yet been opened. The preserved pre-recurring tag/bundle remains available. Publication now has separate open PRs recorded in the linked receipt; no main merge occurred.

The runtime app uses no fixed ERP balance-reference file. It records exact source bytes/hash, source/snapshot scope and acquisition time; applies strict supported-data checks and reopens the committed DB for verification. State files have an automatic `*` .gitignore guard, but this is not encryption or a substitute for owner file access control.

## Second actual owner acquisition — acceptance result

**FACT — PASS_SECOND_ACTUAL_V1_REFRESH_AND_IDEMPOTENCE:** the owner supplied a second complete artifact, 1,063,450 bytes, finished 2026-10-22T11:59:46.8205388+00:00. Received SHA-256 independently matched E10B8A753C02CD27BB71026D7CAF20E86315707F38EA7824001E4469959E9DC7. Compared with the first artifact, only startedAt/finishedAt changed; all table rows, schema and identity are identical. This is a later owner-provided acquisition, not a direct SQL session observed by DBL.

The unchanged compiled code applied the new file to the **same persistent state**, replayed it, then replayed the first file: applied/replayed/replayed in separate processes. Latest stayed at11:59:46.820Z and the new source hash. Checkpoints advanced from1 to2 only once; current products stayed5, quantities30/3/50/2/12, value1470SAR and low-stock T02/T04. Ten versioned product rows represent five products across two historical observations, not duplicate current items. All three SQLite integrity/FK checks passed, staging remained empty, and each operation completed its audit. Total persistent-state invocations are now7 (the previous4 plus3).

The existing actual-artifact automated test was rerun against the second file: **1 passed**, using separate temporary state. The preceding full-suite396/38 result was not rerun or relabelled. No runtime code change was required. New private source/comparison/receipts/results/test log are pinned in EVIDENCE.json. Earlier one-source reports/manifests and the pre-refresh DBL-state backup remain preserved unchanged.

## Open acceptance boundary

Two actual owner-assisted acquisitions/imports are qualified. Automatic capture/transfer and actual changed-business-row refresh remain unqualified: the two actual sources have identical rows, while changed balances were exercised synthetically. No network, SQL grants, guest command automation, scheduler or old-lab action is authorized as a workaround.

Unknowns remain: automatic capture/transfer; DB-enforced least-privilege SQL identity; general stock-document/GL/purchasing Canonical support; variable costs and wider scope; build/migration compatibility beyond the qualified artifact; actual owner-artifact operation on other machines/platforms; restore-tested external ERP backup and Windows security/licensing coverage. Fresh Windows/Ubuntu CI control runs passed after publication; they do not include the private actual artifacts.

## Publication engineering review — owner authorized; no merge

The owner's later instruction authorizes branch publication and two PRs. Fresh review verification passed build/typecheck and397tests/38skips; application tests18, including a new actual two-artifact compiled-process regression. A separate second-source connector run passed28tests. These are new test invocations in temporary state, not more ERP captures or additional invocations into the retained operational state: source acquisitions remain2 and retained-state invocations7. See [publication review](PUBLICATION_REVIEW.md) for test-only fixes, failed-log preservation, scoped privacy inspection, transport/history decisions and publication receipts. The proposed [third acquisition](THIRD_CAPTURE_PLAN.md) remains unexecuted and requires separate ERP approval.
