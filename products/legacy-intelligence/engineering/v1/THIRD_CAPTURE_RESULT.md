# Third actual V1 acquisition — changed business data qualified

Date:2026-10-23. **PASS_ACTUAL_THIRD_CHANGED_DATA_PERSISTENCE_HISTORY_AND_REPLAY**.

[Index](README.md) · [Execution contract](THIRD_CAPTURE_PLAN.md) · [Recovery](RECOVERY_QUALIFICATION.md) · [Independent retention](EXTERNAL_RETENTION.md) · [Source semantics](DATA_SEMANTICS.md) · [Evidence IDs/hashes](EVIDENCE.json)

## Recovery and baseline before Save

**FACT:** the owner copied the previously tested native backup through the existing session. Codex independently read the regular host file outside the VM image:25,612,288bytes, SHA-256 `88F028A3C2C562413797639357C775DA74B67EE36FFB197C269C6B5A59C127FC`. This exactly matches the backup used in the approved new-database/two-new-files restore, non-repair CHECKDB and eleven-table comparison. That trial's exact execution report has SHA-256 `A82A759562DB254F9E0335DC24B27A9B32D8CCBCF0FE4315934BB25F95571504`. These combined observations closed the scoped recovery gate before the authorized stock change. The restore target and original source were retained; neither was overwritten or cleaned up.

**BOUNDARY:** a host-retained copy is independent of this VHDX, not proof of a separate physical device, whole-host disaster recovery, full-database row equality, Windows/SQL-login/licensing recovery or native backup checksum coverage. Native backup checksums were absent. Original report flags remain immutable historical evidence; the later combined qualification is recorded separately.

A fresh ERP available-quantity/cost report for branch1/warehouse1, itemsT01–T05, as of23October confirmed30/3/50/2/12, values600/240/250/80/300 and1470SAR. Zero/no-movement mode remained excluded. The last saved issue was2. The existing owner approval covered the single new consumption issue; no new chart, warehouse, supplier, opening stock, network or security configuration was needed.

## One actual GUI transaction

Standalone ordinary VMConnect was used, without elevation or a new guest connection method. One new normal consumption issue was created and saved **once**:

| Field | Observed persisted value |
|---|---|
| Issue number/key | 3 / `3-23-0-0-1` |
| Date | 2026-10-23 |
| Branch / warehouse / unit | 1 / 1 / 1 |
| Item / quantity / cost | DBL-T01 / 1 /20SAR |
| Counterpart | Existing consumption expense301 |
| Financial entry | Dr30120 / Cr10120, balanced |
| Memo | DBL-V1-CAPTURE3-T01-I1 consumption |

The issue screen was closed, reopened from Operations and navigated to Last. Number/key, item/unit/warehouse/quantity/cost/memo persisted; modification count remained0. A newly generated ERP report at08:46:15 guest local time showed **29/3/50/2/12**, values **580/240/250/80/300**, total **1450SAR**. The prior report at08:29:55 is retained separately and was not reused as post-change evidence. GUI financial-entry evidence and later acquired journal rows agree; no batch final GL posting was performed or claimed.

## Actual third acquisition and source reconciliation

The owner ran the unchanged reviewed R3 SELECT-only collector in V1, with ordinary Windows execution and no concurrent ERP edit. The new full JSON was copied through the existing session and independently byte-hashed on the host:

- Bytes: **1,079,921**.
- SHA-256: **`92AD9A1C1AC75A0697DE081BBC7294AF22E5BD615BFA5509B25FD784AD092D94`**.
- Start:2026-10-23T07:10:37.6617000+00:00; finish:2026-10-23T07:10:38.7557361+00:00. Canonical finish normalizes to milliseconds.
- Same qualified identity/scope; SELECT-only serializable acquisition rolled back; sourceWrites=false and no UDF/procedure calls. Existing SQL identity remains privileged; this does not prove database-enforced least privilege.

Independent row comparison and the existing compiled connector established:

| Table/effect | Actual difference from second acquisition |
|---|---|
| item_mov | 10→11; exactly one newT01 signed−1, cost20, document3; all old rows unchanged |
| journal | 10→12; Dr30120 / Cr10120; all old rows unchanged |
| Journal_Master | 5→6; one new issue3 master |
| gr_detail | Same6 rows; receipt1/T01 c_qty and pc_qty30→29 only |
| Other seven acquired tables | Row values/counts unchanged |
| Net accounts101 /201 /301 | 1450 /−4625 /3175, sum0 |

The two receipt-detail fields changed in correlation with the issue. They were not additional stock receipts and did not contribute a second quantity delta. Their general allocation/costing semantics remain unqualified; do not use them instead of the signed movement ledger. No broader source-table immutability is claimed beyond the eleven acquired tables. Issue headers and requisition rows were not acquired by R3.

The existing profile accepted the new data without code changes or relaxed checks. Quantity remains sum(item_mov.inout_qty); constant item costs, journal corroboration, zero openings/free stock, SAR and one branch/warehouse/unit remain enforced. Journal Posted=false stays false. This is consumption, not a commercial sale. Requisition20 was never imported or counted as received stock; its current GUI status was not reread in this step.

## Persistent DBL acceptance

Before import, the complete quiescent retained two-snapshot DBL state was copied to a new private directory; all27 constituent file hashes matched and the source copy operation left the original unchanged. This is separate from ERP recovery. The compiled CLI then used the **same existing managed operational state**:

| Independent process | Result | Checkpoints | CurrentT01 / totalSAR |
|---|---|---:|---:|
| Third actual artifact | applied | 3 | 29 /1450 |
| Same third artifact again | replayed | 3 | 29 /1450 |
| Second artifact again | replayed | 3 | 29 /1450 |
| First artifact again | replayed | 3 | 29 /1450 |

**FACT:** current remains five products, not fifteen duplicated products. Historical storage has three observations/fifteen product rows. Both old snapshot metadata and all ten old product rows remained byte-for-value unchanged and readable through independent SQLite queries; their T01=30 and1470SAR remain available. The current store/Application Service was separately reopened and returned29/3/50/2/12 and1450SAR; low-stock items remainT02/T04 with test threshold5. There is no newly claimed public historical-query API.

All previous21 audit rows remained unchanged. Four process imports added12 successful audit events, one each of import.started, connector.health.ok and import.completed per process:33 total,11 completed imports. Audit was closed and reopened. All three local databases passed integrity_check and foreign_key_check. Both preserved historical source artifacts, the third raw file and the pre-import state copy retained their hashes. Retained operational invocations are now11, actual source acquisitions3.

## Failed verification iteration and correction

The private acceptance harness initially assumed two audit events per import and asserted8 new events. After all four CLI calls and history/readback checks had succeeded, it observed12 and stopped. Read-only inspection showed the existing three-event contract, including connector.health.ok. A separate corrected readback checked four complete three-action groups, success outcomes, completed metadata and reopen/integrity results. **No CLI import, ERP transaction or source extraction was repeated to correct this harness error.** The original failed harness and corrected receipt are both retained. No product bug or code change resulted.

## Reproduction and remaining gates

Resolve source/result/harness evidence IDs in the owner's private custodian register; obtain actual bytes by their public hashes. Use the existing qualified Node22 compiled runtime and lockfile, never a mixed transformed-test migration representation. To reproduce admission, use a verified copy of the pre-third state in a new private local directory, invoke v1:refresh with the third source/hash, then the same source and older source/hash pairs. Expect the four rows above. Preserve logs; do not repeat the ERP issue or overwrite/reset operational metadata. Compare all prior snapshot/product/audit rows, current Application Service insights after reopen, and SQLite integrity/FKs. The private harness paths and raw source data are not public code or CI fixtures.

Product PR19 merged at `f79b3549e04eb8e091ed253eac1f5eb090c8ae5b`; its reviewed source tree was used unchanged. Memory PR8 merged at `475f78cb5e30ce3fd679ae6d5c6e0970917f6d46`. [CI217](https://github.com/elias-mujally/dbl-legacy-intelligence/actions/runs/39843313410) and413passed/41skipped local suite are prior code qualification, not newly run third-data CI. This step adds actual three-artifact acceptance, not a new full-suite claim. The results are staged in [memory PR9](https://github.com/elias-mujally/dbl-products-memory/pull/9), which remains unmerged for owner review.

**Still unqualified:** unattended acquisition/transport, live least-privilege SQL, general ERP document/GL/purchasing entities, final GL posting, broader accounting/cost/warehouse/unit/currency scenarios, production scale, power-loss durability and whole-system recovery. Recommended next engineering slice is a reproducible operator package for the existing file path, followed by separately scoped least-privilege acquisition qualification. No additional ERP mutation is implied.
