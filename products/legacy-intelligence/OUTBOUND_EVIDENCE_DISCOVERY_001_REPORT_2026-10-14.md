# Historical Outbound Evidence Discovery

## Technical summary — discovery completed; outbound NOT QUALIFIED

**OUTBOUND EVIDENCE DISCOVERY 001 = COMPLETED.** **NO QUALIFIED OUTBOUND EVIDENCE FOUND IN THE REVIEWED SET.** This completes the requested discovery, not outbound qualification or implementation. Unknown outbound remains unknown, **not zero**; the historical balance remains **37 UA**, not 32.

Product main and PR #17 merge were independently checked on GitHub at **`415ad8acef5f5754487b83408bad6c9b9c58028e`**. Memory main and PR #2 merge were independently checked at **`1c5a251faa34ed588d45e70467290a6565ac10a3`**. Read AI_HANDOFF, CURRENT_STATUS, MERGED_STATE_2026-10-14, EVIDENCE_REGISTER_2026-10-14 and OUTBOUND_EVIDENCE_DISCOVERY_001_PLAN at that memory revision before investigating. Older STOP/blocked reports were used as historical evidence, not current execution instructions.

The review inspected **33 available retained JSON artifacts**, matched **13 prior document/manifest pins** and **4 additional archived-manifest pins**, and independently cross-checked the files with PowerShell SHA256. Original files were unchanged. No source artifact required for these checks was missing. This does **not** imply that the missing outbound document ever existed or that every ERP table/file was available.

## The retained inventory rows represent zero and one inbound, never an outbound

Recursive inspection of materialized inventory records found **64 appearances of item_mov-shaped rows**, but only **two distinct selected identity/scope/value representations**. These are repeated captures, not 64 ERP events:

- `serial_no=1`, `PKDoc=0-0-0-0-1`, line/record0, `doc_type=11`, signed contribution0, business date `2026-10-07T00:00:00`. Producer/business provenance remains **PARTIAL**. Zero is not an outbound event.
- `serial_no=2`, `PKDoc=1-44-1-0-1`, line1, line ID `0c02c7b5-2210-46f0-a82c-cea2997e6d3a`, signed contribution**+37**, business date `2026-10-08T00:00:00`. This is the already independently qualified saved/inventory-effective purchase inbound, **not a second event or outbound**.

Both have Item `DBL_P001_ITEM_A`, Branch1/Warehouse1/UA/package1. No negative main/free/subquantity signal was found in the materialized inventory rows of this reviewed set. Absence of a negative signal is **not a universal outbound-classification rule**: classification also follows the exact two source identities and the separately qualified inbound linkage. Different document types/sign conventions are not inferred or generalized.

In the pinned frozen Reader projection, the two rows reconcile by independent BigInt/BigInteger arithmetic to the original Reader scalar and FACT **37 UA**. Header/line cardinality is one selected purchase each; repeated, reconnected and preflight-source projections agree exactly. The selected purchase, generated receipt and inventory row corroborate **one** inbound, never 37+37+37. No second genuine inbound was identified in these selected records.

Source boundary: original `DESKTOP-8QRQT7R\\YSEDU / EFA12026`; frozen `DBL_HOST_W11_EFA12026_PostS2_Frozen_20261009`; backup UUID **`2b9d2bde-8d89-4ee7-98de-224fb97060c7`**; recorded backup SHA256 **`E63DF84D2DBB22C5ACD535DC5881D2DCF417F420665502927EBD9AD66731E572`**; source as-of **`2026-10-09T08:12:11+03:00`**. Backup binding was checked inside the original pinned records; the BAK/current SQL database were **not** opened or rehashed. Business dates are SQL wall-time values without offset, not acquisition or UTC instants.

## Candidate classification and document → line → movement gate

**OUT-C001 — ordinary inventory issue draft5: NOT QUALIFIED as an event.** The retained UI record shows Item A, Warehouse1, UA/package1, quantity5, proposed number1/date08/10/26, but account/currency unresolved and accountChosen=false. SaveCalls=0; official Cancel returned Add enabled / Save disabled. The proposed number/date are **discarded draft values**, not saved source identities. The draft workflow's eligibility remains PARTIAL, but there is no saved outbound header/line, persisted line key or linked negative inventory row to qualify. Do not join this proposed number1 to the saved purchase number1.

**OUT-C002 — historical zero row: NOT QUALIFIED as outbound; producer provenance PARTIAL.** An actual row identity exists, but contribution0 is not a genuine outbound. Its doc_type11 is not decoded into an invented transaction. No corresponding producer document/line was independently established.

**OUT-C003 — financial opposite-sign purchase entry: NOT QUALIFIED as inventory outbound.** The actual retained S2 journal contains `amt=+3700` and `amt=-3700` for the same purchase PKDoc; both `Posted=false`. These are accounting entries, not item quantities or a second inventory event. The linked item movement is +37 only. No expense/consumption/physical payment/final-GL-posting claim follows.

### Qualification matrix

The matrix checks the eight requested conditions at **outbound event grain**, not whether some fields exist somewhere in the file. PASS for an evidence file's integrity is not PASS for the absent outbound event.

| Required condition | OUT-C001 draft5 | OUT-C002 zero | OUT-C003 financial entry |
| --- | --- | --- | --- |
| Genuine saved outbound source document | FAIL: never saved | UNRESOLVED producer | FAIL: saved document is a purchase |
| Inventory-effective outbound movement | FAIL: none established | FAIL: quantity0 | FAIL: accounting grain, linked inbound+37 |
| Stable saved document/line/movement linkage | FAIL: proposals only | PARTIAL row identity, no producer link | FAIL for outbound; purchase link only |
| Verified outbound item/quantity/UOM/scope | PARTIAL: unsaved UI scope only | Row scope known, no outbound quantity | Not an inventory quantity |
| Reliable outbound business date | FAIL: discarded proposal | Row date known, no outbound event | Purchase date, not outbound date |
| Saved/cancelled/inventory/final-posting state | Cancel confirmed; no Save | Producer state UNRESOLVED | Purchase financial rows unposted; not outbound |
| Traceable proof of a genuine outbound | FAIL; pinned draft record only | PARTIAL historical row provenance | FAIL; traceable purchase/accounting proof only |
| No duplicate counting across representations | No event to count | Do not count zero as a new event | Never convert cash/journal or receipt into an extra event |

No candidate is promoted from PARTIAL to QUALIFIED. The positive inbound control remains QUALIFIED only within PR #17's established historical scope.

## S3 equality was recomputed, not accepted from report flags

For all three SHA-pinned S3 artifacts, complete bounded before/after protected rows match after excluding **only ObservedAt**, all **21 monitored table counts** match, and their two saved movement rows equal the frozen Reader movement rows. This was recomputed from the objects in Node and independently from before/after serialization and counts in PowerShell; recorded booleans alone were insufficient.

- Issue discovery: before `2026-10-08T21:21:06.9666107+03:00`, after `2026-10-09T00:27:50.5672647+03:00`; draft cancelled, SaveCalls0.
- Debit-account qualification: before `2026-10-09T00:40:53.595182+03:00`, after `2026-10-09T00:45:27.365253+03:00`; account/issue SaveCalls0, no fresh issue draft. Proposed expense account was not created.
- Expense-route discovery: before `2026-10-09T05:28:36.3301106+03:00`, after `2026-10-09T05:38:33.0174701+03:00`; unsaved account inspection cancelled, S2 and quantity unchanged.

These are retained historical **bounded/sequential** observations, not a newly executed atomic/exhaustive ERP audit. The 21 table anchors do not themselves define the actual issue-header/line tables or all issue states. No live query/UI/Help session was performed now.

## Exact evidence identity and availability

All paths below are relative to the original investigation workspace `C:/Users/user/Documents/Codex/2026-08-25/files-pasted-by-the-user-dbl/`, **not** relative to this memory repository. Full inventory with verified fingerprints is [SOURCE_MANIFEST](research/OUTBOUND_EVIDENCE_DISCOVERY_001_SOURCE_MANIFEST_2026-10-14.json); it contains file metadata only, not raw ERP exports. Its null recordedPin means fingerprinted now without a prior pin in that first pass, never silently authenticated as original. The four supplemental archived-manifest checks are recorded below and locally separately.

Prior pins independently recomputed and matched:

- `outputs/host-historical-inventory-binding-001-20261013/FACT.json` — `0DE22CE4304839AC2D9807A45F448900C598F55177596A374D5A8E230A6FD670`.
- `outputs/host-motakamel-posts2-frozen-20261009/QUALIFICATION_EVIDENCE.json` — `7D742175B6652860C7974115F8A1CBB789F49D86ACAD4FC5DD40CFCE310E7BAC`.
- `outputs/host-motakamel-s2p-save-20261008/SAVE_EVIDENCE.json` — `938D31CA336A765F231C9E95EE474C170CBC415C5322C769809754C64D006A61`.
- `outputs/host-motakamel-s2p-save-20261008/GATE_A_EVIDENCE.json` — `8D15D6B0BB5B22A62FAD15A04E6EF4F4F6DA1CC4269132AAD6CA504B235EDF87`.
- `outputs/host-motakamel-s2-targeted-reconciliation-20261009/READ_ONLY_EVIDENCE.json` — `32E187E8AC71F0895EC2E93BBF78FACC46AA8CB17088776E1F4DB208E222BCA4`.
- `outputs/host-motakamel-s3-issue-discovery-20261008/READ_ONLY_EVIDENCE.json` — `83C73240BFAE62755D429D0DA6FA00B54C9A74E8AD5ED45FEDF7F8565869000C`.
- `outputs/host-motakamel-s3-expense-route-discovery-20261009/READ_ONLY_EVIDENCE.json` — `B66BFA787897A6E800D8E27B261EAE68284E2FA80E73709C8C2D141E0C03112E`.
- `outputs/host-motakamel-s3-debit-account-qualification-20261009/READ_ONLY_EVIDENCE.json` — `9D3BD5E23B2DF1BB1CDE029A1B4DA88D3032E04FB473162E2E867C8AD8AC1C93`.
- `outputs/host-motakamel-zero-row-review-20261007/READ_ONLY_EVIDENCE.json` — `B281E870DF3ADA47841E3CABE47461BE2E43DACB142CA5444F80B1BAD6BA2F23`.
- `outputs/motakamel-v1-golden-01/B0-host-before.json` — `552336A952C73592307133B5AF1336961EACC4930296B10511446D423FBE2D48`.
- `outputs/motakamel-v1-golden-01/B0-status.json` — `5DD491217DC0F4CE36AC10E00FA78CD867F1C7A792EE737FF7DC8CCCD3F5F3C9`.
- `outputs/host-first-live-data-001-20261010/FIRST_LIVE_DATA_001_RESULT.json` — `DEFA4ECA67EE7798C8837A7E80DD560E3E33254C2D85ADEE71F0F6A06B1A30FC`.
- `outputs/host-first-live-data-001-20261010/FIRST_LIVE_DATA_001_CANONICAL.json` — `E41349ED3B8869D3045BD32746DD696E3CF1C1B53C5465A9DF124E3E11B71F26`.

Four supplemental artifact hashes match the corresponding `RAW_SHA256.txt` entries:

- `outputs/motakamel-v1-boundary-inventory-01/19-bounded-reader-results.json` — `A8A921130DD272C3AC8C493A2C82CA92ED3921B6FF93488BE0CDAA479239E79E`.
- `outputs/motakamel-backup-snapshot-01/stage-09-SNAPSHOT_READ_T0.json` — `FFDBD5F6D5A19722D0440600D6B14BFFA69D7325B5D7223F7A2C2AE8CE193675`.
- `outputs/motakamel-backup-snapshot-01/stage-11-SNAPSHOT_READ_T1.json` — `A2C6520EEA21187213CDA1453969E4A0D3F031A2B46B2131EEDCB4CF631E88E9`.
- `outputs/motakamel-backup-snapshot-01/stage-12-SNAPSHOT_READ_T2.json` — `E07C98E572EC54455085CF6DAF21C57DB171E45ED593F230F1D79EA3BD544D0B`.

Those older boundary/snapshot records establish metadata or **synthetic consistency-test** behavior, not a genuine saved Motakamel outbound. The synthetic DBL_SNAP_Q schema/300→550→777 amount experiment is explicitly documented in its retained PROCEDURE.md; it is not an item movement. B0 host/status are host/control metadata, not a business-document export. Historical S0a stopped before item/issue UI actions. None supplies the missing outbound.

Remaining inspected JSON files: cashbox/account/supplier/purchase-discovery evidence and baseline backup-operation metadata, listed individually in the manifest; their current hashes are not mistaken for independent prior pins. They add repeated historical-zero captures, not additional qualified stock events. The prior FIRST LIVE DATA canonical is identity-only. Prior inbound DERIVED_SNAPSHOT and RESULT contain the already-qualified inbound; the closed-hash receipt links its exact original RESULT bytes. Existing SQLite and BAK binaries were not opened; no import or SnapshotReader run was repeated.

## Limits, contradictions and independent validation

- Arithmetic32 versus retained Reader37 is a rejected inference, not an ERP contradiction: draft5 was never saved. The scope/time-qualified evidence is internally consistent.
- `amt=-3700` versus `inout_qty=+37` is not conflicting inventory: accounting and stock have different grain and units.
- Cached quantity0 versus authoritative qualified available37 was already documented; a cache field is not a replacement stock authority. No repair is attempted.
- Installed Help describes issue effects at Save and later GL posting, but old Help/version/workflow documentation does not prove current mandatory fields, current Save eligibility, a saved event or every status/sign rule.
- An administrator may later change a frozen database; this offline review only authenticates available retained bytes against recorded pins, not current database state or global absence of outbound.
- Scan bounds: selected public evidence JSON ≤4 MiB each, materialized structured inventory rows; source SQL/normalized JSON strings are not executed or promoted into business records. No broad disk/ERP absence claim or universal sign decoder.
- A preliminary read of an older PowerShell JSON encountered UTF-8 BOM. After hashing the original bytes, the parser ignored the BOM in memory; the file was unchanged. This was file-format handling, not SQL retry or evidence replacement.

Independent check receipt: **33 source hashes matched**, BigInteger sum equals the historical scalar/FACT37, no negative signal in the two frozen rows, and all **three S3 full-row/count equality checks passed**. Node and PowerShell are independent implementations, **not** separate human reviewers or a fresh SQL acquisition. Data-quality/validation stance: **Ready to share** the bounded NOT QUALIFIED finding with these limits; it is not a readiness verdict for outbound implementation.

New supporting local artifacts (outside Git): `outputs/host-outbound-evidence-discovery-001-20261014/{inspect.mjs,SOURCE_MANIFEST.json,RESULT.json,verify-independent.ps1,INDEPENDENT_CROSSCHECK.json,verify-manifest-pins.mjs,ARCHIVED_MANIFEST_CHECKS.json}`. They write only new discovery receipts, not original files. Product code/build/tests/WAL/SQL/ERP were not changed or executed; prior CI/test successes are historical, not rerun results for this documentation task.

## Owner decision — acquire one existing event before implementation

**Recommend a separately authorized, bounded offline handoff of one already-saved inventory-effective outbound document and its line/movement export**, plus source identity/as-of, units/scope, lifecycle status and independent reconciliation. First ask the owner/authorized source custodian whether such an existing event/export exists; do not assume it does. See [the exact minimal plan and fallback](OUTBOUND_EVIDENCE_DISCOVERY_001_NEXT_APPROVAL_2026-10-14.md).

If none exists in retained evidence, neither outbound nor a second inbound can be manufactured by reusing receipt/zero/purchase1. A controlled new lab transaction or later image/export would require an additional explicit transaction/acquisition authorization, including its genuine mandatory counterpart and independent-read plan. No such action is approved or performed here.

**STOP at owner approval.** Documentation-only Draft PR; no product/contract/storage implementation, SQL/ERP connection, original evidence/production write, permission/TLS/host change, merge, release or deployment.
