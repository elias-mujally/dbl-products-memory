# V1 third acquisition — one real stock change

Status: **EXECUTED_AND_PASSED on2026-10-23**. The contract below records the original gates and expected results. [Actual execution, exact source hash, observed differences and remaining limits](THIRD_CAPTURE_RESULT.md) supersede all historical pending/not-executed wording below.

[Index](README.md) · [Current proof](RECURRING_STATUS.md) · [Source semantics](DATA_SEMANTICS.md) · [Runbook](RUNBOOK.md)

## Why this next slice

**FACT:** the two received owner acquisitions have identical business rows. Seven persistent-state invocations proved later-observation admission, same-file idempotence and historical replay without rolling back latest. Changed business quantities/value have only synthetic coverage.

**DECISION / PROPOSED:** use the already exercised **consumption issue** route for one unit of DBL-T01, branch1/warehouse1/unit1, at the existing constant20SAR cost, with the established301 consumption counterpart. It changes one item and requires no new accounts, warehouse, supplier, receipt, price, opening stock or commercial sale. It does not use the stock-transfer clearing account102 or reinterpret consumption as sales. Existing account classifications remain the scoped lab decisions documented in TIMELINE, not a general accounting prescription.

## Separately approved owner scope

One new GUI consumption issue of **DBL-T01, quantity1**, inside V1 only, using account301 and the existing warehouse/branch. Save once using the ordinary inventory-effective path observed previously; do not manually finalize GL posting or change flags to satisfy the connector. Document number/key must be discovered from the UI and persisted record; do not assume the next number or reuse an existing document. A distinct description should identify this as the third-capture test.

The owner's later explicit instruction separately authorized this one-unit transaction, conditional on reliable recovery and a fresh baseline. At approval time the recovery prerequisite had not qualified, so execution waited. On23October restore/CHECKDB/fixture and outside-VHDX byte retention qualified the scoped test; the single issue was then executed. The approval includes retaining the authorized test effects; no automatic deletion, reversal, compensating entry, SQL update or restore is part of the scope. The missing gate is recovery evidence, not a request to repeat transaction approval.

## Preparation and evidence gates

1. Reconfirm V1 identity and the latest unchanged baseline: quantities30/3/50/2/12 and1470SAR. If it has changed, stop and reconcile rather than force the planned numbers. Preserve the first/second raw artifacts and hashes unchanged.
2. Preserve the complete quiescent DBL state (two checkpoints), runtime commit/build and dependency lock before accepting a third snapshot. Record hashes and a copy verification. This protects the DBL baseline; it is not an ERP recovery backup.
3. Confirm the owner's acceptable ERP recovery route before the authorized Save. Existing guest-local .bak files and a Production checkpoint have known limits: no externally retained, restore-tested ERP copy was qualified by this task. Do not claim a rollback capability from JSON, silently restore a VM, or change backup infrastructure. An unresolved recovery requirement must be disclosed to the owner before Save.
4. Use standalone non-elevated VMConnect. Check the actual issue screen, warehouse, unit, counterpart, cost and document date; ensure no duplicate test document or concurrent ERP edits. If it requests an unexpected account, posting mode, permission or wider setup, stop before Save.
5. On uncertain Save/timeout, inspect persisted state through the established ERP route before any retry. Never assume failure and create another issue.

## Expected results — now exercised as recorded in THIRD_CAPTURE_RESULT

| Measure | Verified baseline | Expected after one-unit issue |
|---|---:|---:|
| DBL-T01 quantity | 30 | 29 |
| DBL-T02/T03/T04/T05 | 3 / 50 / 2 / 12 | unchanged |
| T01 inventory value | 600SAR | 580SAR |
| Total inventory value | 1470SAR | 1450SAR |
| Signed item_mov rows in scoped extraction | 10 | 11, exactly one new−1 contribution |
| Reconciled journal document count | 5 | 6 |
| Journal rows | 10 | 12, Dr30120 / Cr10120 |
| Net101 /301 /201 | 1470 /3155 /−4625 | 1450 /3175 /−4625 |

These are predictions from the qualified constant-cost profile, not observed third-run results or permission to fabricate SQL. Expected financial Posted=false stays distinct from inventory effect. Independently verify the ERP quantity report and normal journal effect, within the approved UI/report path, before labelling the transaction successful. If a report fails, stop and preserve the message; do not silently alter settings or repeat it.

## Third extraction and DBL acceptance

- Owner runs the reviewed bounded SELECT-only R3 collector in V1 with no concurrent edits; transfer the new full JSON plus independently recorded SHA-256. No network or SQL grants are needed. Do not reformat artifacts or alter acquisition times.
- Verify exact bytes/hash, later capture time, same identity/scope, the single new movement/document/journal effect, all existing movements preserved, and unchanged cost/unit/other-item quantities. Request20 remains unreceived and absent from stock. A hash or timestamp change alone is insufficient.
- Run the compiled operational `v1:refresh` against the same managed DBL state. It requires no fixed balance-reference file. Expect one new checkpoint (3), five current products and1450SAR from persisted Application Service readback. Verify low-stock T02/T04, per-item values and receipt/source provenance; inspect SQLite integrity/FKs and completed audit.
- Replay the third artifact: expect no fourth checkpoint, no duplicate stock effect. Replay the second artifact: expect current still points at the third observation, with29 and1450. Preserve all receipts and source hashes.
- Existing owner-fixture tests intentionally describe the unchanged first/second pair and1470; do not point that pair's variables at changed third data and call a fixture mismatch a connector regression. Use a separate third-capture acceptance report with independent ERP expectations, not hardcoded production mapping. Extend regression coverage with clearly labelled synthetic equivalents if a real mismatch reveals a code defect.

## Acceptance and failure policy

PASS requires the approved single real ERP change, independently observed ERP balance/effect, complete third artifact, matching DBL derivation after reopen, same-file idempotence and historical replay protection. Any extra/missing transaction, unsupported cost/posting state, ambiguous Save, failed recovery prerequisite or divergence stays BLOCKED/PARTIAL. Preserve the evidence and ask before corrective ERP changes. Never edit SQL or weaken qualification to make the expected1450 appear.

The contract was executed on23October after the separately approved restore/CHECKDB/fixture trial and verified independent host BAK retention closed the scoped recovery gate. The original approval remained valid; no new permission or broader source change was inferred. See [actual results](THIRD_CAPTURE_RESULT.md) and [recovery boundaries](RECOVERY_QUALIFICATION.md). Original host ERP and historical labs remained out of scope.
