# Repeated integration — local execution status

Date: 2026-10-22. **PUBLISHED FOR REVIEW / NOT MERGED.** See [publication receipt](PUBLICATION_RECEIPT.md).

[Index](README.md) · [ADR](ADR-V1-001-FILE-REFRESH.md) · [Evidence](EVIDENCE.json)

**Latest — advisory review:** four synthetic pre-fix failures were reproduced and corrected in bootstrap/control/file publication. Fresh local build/typecheck and412passed/41skipped tests, including actual-source regressions, passed. A separate copy of saved valid DBL state preserved5products/1470SAR through import/replays. The original retained state and ERP are unchanged. Updated CI and merge recommendations are tracked in [the advisory record](ADVISORY_REVIEW.md); earlier counts below remain historical evidence.

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

## Graphify advisory engineering review — no new source acquisition

Reproduced interrupted control/marker/source initialization and concurrent cold-start failures before correcting them. Bootstrap/admission and no-replace publication now cover those process faults. Final local build/typecheck: **413passed/41skipped**, including both actual owner artifacts; the retained actual business result remains five products,30/3/50/2/12 and1470SAR. A verified old-format DBL-state copy also passed later import, replay and historical replay. These are additional temporary-state tests, not new ERP captures or changes to the original seven retained-state invocations.

Use owner-private local storage, outside shared/network/cloud-synchronized locations. New POSIX state uses0700/0600 and refuses broad/non-owned directories without chmod; Windows privacy requires owner-provisioned ACLs, not a mode-bit assumption. A permanent empty bootstrap reservation identifies resumable incomplete initialization. Atomic final-name publication requires local hard-link support. Process interruption is tested; power-loss guarantees are not implied. At16 interrupted pending files the app stops for owner review without automatic cleanup. Unknown/corrupt final metadata remains blocked. See [the measured advisory review](ADVISORY_REVIEW.md) for advisory dispositions, preserved CI216/test-timeout failures, test-harness correction and latest CI gate.

**FACT — CI217 passed** on product head `f5471792a63c08039ebbbc4b96f40f94fd33325d`: Windows and Ubuntu build/typecheck/tests plus10 Worker/native-WAL cycles each. Public CI omits private actual-source fixtures; the local413/41 check includes them. [CI217](https://github.com/elias-mujally/dbl-legacy-intelligence/actions/runs/39843313410). No main merge or ERP change followed; actual changed-business-row refresh remains the next separately approved gate.

## Owner-approved merges and recovery gate — subsequent state

**FACT:** PR19 and PR8 were subsequently merged with explicit owner approval, preserving reviewed source trees/history. Product main was verified at `f79b3549e04eb8e091ed253eac1f5eb090c8ae5b`; memory main at `475f78cb5e30ce3fd679ae6d5c6e0970917f6d46`. The two remaining coupling threads were answered and resolved with recorded technical reasons. No blocking changes-requested review was dismissed.

The owner also separately authorized the one-unit consumption issue, but reliable ERP recovery remained unproven: a guest-native backup was visually rechecked at25,612,288bytes, with no integrity/restore qualification. Execution stopped before an issue draft or Save. No fresh ERP baseline, third acquisition or changed-row import is claimed. A27-file copy of the retained two-snapshot DBL state passed hash/integrity checks without changing the original; this is not ERP recovery. [Merged commits, observations, limitations and next recovery gate](MERGE_AND_RECOVERY_GATE.md). Actual source acquisitions remain2; retained-state importer invocations remain7.
