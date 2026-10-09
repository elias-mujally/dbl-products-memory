# Host W11 — S2 Targeted A/B Evidence & Reconciliation — 2026-10-09

## Decision and bounded claim

**EVIDENCE GAP — implementation Gate A is not passed by these live observations.** The positive S2 case remains **PASSED — LAB-PROVEN**. S3 is explicitly **FROZEN / ACCOUNTING-BLOCKED**; no expense account, further chart discovery or issue is needed for the first narrower item/inventory/inbound capability. Controlled Zero remains **PARTIAL**, accepted as non-blocking for this case; its historical row provenance was not reopened.

The confirmed claim is one saved **cash immediate purchase**, not all purchase states or a latest-purchase algorithm: company/year database **EFA12026**, physical Host **DESKTOP-8QRQT7R\\YSEDU**, Branch1, Warehouse1 / DBL_WAREHOUSE_A, Item DBL_P001_ITEM_A / DBL_ITEM_A, UA / primary package1, quantity37, unit purchase cost100 SAR, document amount3700 SAR, PKDoc **1-44-1-0-1**. No supplier was created or associated. No PARTNER-VALIDATED or PILOT-QUALIFIED claim follows.

## Context and implementation reality

Refreshed the current Product Memory/Host evidence and the Pilot #001/Controlled Dataset plans, retaining Purchase Attention + Item Intelligence, Motakamel Plus as the first specific connector target, read-only V1, exact decimal/currency boundaries and implement-first/abstract-second. The September10 strategy and Controlled Dataset plan supersede older representative-data-before-any-code sequencing; the later Host record supersedes historical Reference/September25 not-started/empty-dataset statements. They do not erase those historical observations.

Build **origin/main**, freshly fetched, is **95bf225e1523e0fd0f72cdf3da8393df18d635cc**. The local checkout remains on **fix/canonical-closed-world-validation / 0fb18e982e90ae09b5e68f306c406ee97a7f29ff**; a tracked-content diff against origin/main was empty. No checkout/reset/build edit, install or test run occurred. The prior local main/ref at5028dc4 was stale, not current implementation evidence.

Directly inspected source:

- `packages/core/src/model.ts`, `connector.ts`, `validation.ts`: Product/Customer/Sale only; Product has scalar quantityOnHand and Money prices, no inventory unit/location representation and no Purchase domain. Connector capability flags are products/customers/sales/inventory, not purchases. Exact-key validation rejects unknown canonical fields; it is not safe to attach arbitrary purchase/scope fields. Optional sku/phone runtime-type coverage is still incomplete in inspected validation.
- `packages/import-orchestrator/src/orchestrator.ts`: buffered validation and staged batched append/commit/abort; validateHeader and beginSnapshotWrite precede its batch iteration/cleanup try. Source-resource ownership before iteration needs a focused failure-path qualification; storage abort does not by itself release a source session.
- `packages/connectors-reference-sqlite/src/index.ts`: SQLite read-only/query_only and transaction snapshot, keyset pages and generator-finally cleanup are real, but not transferable SQL Server isolation proof. Child line loading uses `.all()` for a chunk of invoice IDs; ID batching alone is not a child-row/byte bound.
- `packages/application-service/src/service.ts`, insight rules: pinned local SnapshotReader and connector/snapshot provenance; existing low-stock is a configured scalar threshold, not a qualified demand/depletion rule. Current SalesSummary must not consume purchases.

Preserve the existing path: specific Connector → Import Orchestrator → SQLite → SnapshotReader → Query/Insight → Application Service. Source consistency must be established **before** local atomic publication; local pinning cannot repair a mixed-time acquisition. No generic DSL, SQL adapter abstraction, movement framework or speculative Canonical expansion is proposed.

## Evidence provenance and observation bounds

This is a targeted reuse of the genuine before/after S2 evidence, **not a second A/B transaction**. Historical A is the pre-Save snapshot at **2026-10-08 20:24:52.3946408+03:00**. Historical B includes the one authorized Save, independent reload and scoped Crystal preview on October8. The current round reloaded that invoice through **First** in view mode and selected its line; no Add/Edit/Save or report generation occurred.

Current source reads: **2026-10-09 07:22:44.1671491**, document read07:22:50.1643778; metadata07:25:25.322751; final reads **07:29:11.2367506 / 07:29:16.4042374+03:00**. Same server/database/DB_ID7 throughout. Sequential live SELECT/catalog observations, **not** an atomic/frozen snapshot or exhaustive database audit. The exact full-row comparisons used the preserved historical inputs; the new local artifact records the bounded projections, complete movement rows, selected catalog and comparison results.

Local evidence, outside Product Memory:

| Artifact | SHA-256 |
|---|---|
| outputs/host-motakamel-s2p-save-20261008/SAVE_EVIDENCE.json — original full S2 stages/UI observations | 938D31CA336A765F231C9E95EE474C170CBC415C5322C769809754C64D006A61 |
| same folder/GATE_A_EVIDENCE.json — historical authorized pre-Save oracle | 8D15D6B0BB5B22A62FAD15A04E6EF4F4F6DA1CC4269132AAD6CA504B235EDF87 |
| outputs/host-motakamel-s2-targeted-reconciliation-20261009/READ_ONLY_EVIDENCE.json | 32E187E8AC71F0895EC2E93BBF78FACC46AA8CB17088776E1F4DB208E222BCA4 |
| same folder/Read-S2Metadata.ps1 — bounded SELECT/catalog-only reader | BCADE136CEB5E69AA50CA16BD9833A378AA4275D44ADE2D9BA538242016E07ED |

Existing SELECT-only Read-PurchaseDraft.ps1/Read-CashboxSave.ps1 and Read-S2Purchase.ps1 supplied the fresh full comparison inputs. Read-S2Metadata.ps1 is evidence tooling only, not a connector or production acquisition implementation. One oversized metadata response was truncated and could not be parsed; no conclusion used it. A bounded output selection succeeded without a source change. No credentials, screenshot payload, database binary or raw private row dump is committed here.

## S2 A/B Evidence Matrix

Official master-screen evidence below is the **accepted prior independent reload**, not a claim that all masters were reopened in this round. Current UI corroboration is the saved purchase view; current SELECT corroboration covers the protected master records. The October8 stock report is reused at its recorded as-of, not presented as a fresh October9 preview.

| Fact / official comparison surface | A — before S2 | B — saved/reloaded S2 and current source | Qualification / limit |
|---|---|---|---|
| Inventory → Inputs → item data / بيانات الأصناف | Accepted S1 Item A with Group001, UA, primary package1 | item_detail.i_code/i_a_name/g_code/i_measure/i_size/p_code/p_size; same saved master | Item identity/bindings confirmed for this DB; not cross-company/year global uniqueness |
| Inventory → Inputs → warehouse data / بيانات المخازن | Accepted Warehouse A number normalized001→1, Branch1 | W_DETAIL.(W_CODE,Branch_no)=(1,1), w_a_name=DBL_WAREHOUSE_A; unchanged | Warehouse scope independently exists; Branch1 is not assumed to mean Warehouse1 |
| Unit form / بيانات الوحدات and Item unit binding | Accepted UA / DBL_UNIT_A | Measure.Measure_Code=UA; Item_Detail_Units: I_Code=P_Code=Item A, Measure_Code=UA, I_Size=1, Main_Unit=true, Unit_Level=1 | Base conversion1 confirmed for this case only; alternate/fraction units unsupported |
| Purchases → Operations → فواتير مشتروات فورية → saved record via First | Bills/Bill_detail0; no purchase | Invoice1, date08/10/26, key1-44-1-0-1; one line ItemA/UA/Warehouse1/37/cost100; totals3700 | Purchase meaning is official workflow + saved line + source, not table-name/code guesses |
| Same purchase header payment/currency | No document | Cash1 / Cashbox1; SAR and document/stock rates1; Bills.cash_no1, extra_code97070103 | Cash-purchase binding confirmed; not external physical payment settlement proof |
| Same purchase line and source event | No receipt; one zero movement | gr_note/gr_detail1 each; item_mov new serial2, +37, matching event key; receipt is Save-created | One purchase effect, NOT execution of S2-R; do not add three representations as111 |
| Inventory → Reports → Stock / تقرير المخزون → native Crystal preview | Explicit scoped UI0 accepted, Controlled Zero PARTIAL | October8 preview title المخزون حتى تاريخ2026/10/08: DBL_ITEM_A / UA / package1 / Branch1, whole-unit quantity37; current FindAvQty37 | Report filters exact Item from/to, W1 from/to, Branch1, UA, unit-level1, grouping حسب الوحدة, available-quantity mode; printed item code clipped, warehouse scope in parameters |
| Purchase selected-line footer | Historical B showed0 in this context | Fresh First reload left footer blank; one view-mode line selection showed SAR/qty37/aggregate37/average100/last supply100 dated08/10/26 | New UI observation supersedes historical footer value **for this observation only**; no persistence/cache cause or general authority inferred |
| Accounting rows linked to invoice | journal0 / Journal_Master0 | journal2 / master1; samePKDoc, inventory+3700 and cash−3700 SAR | Link and arithmetic verified; Posted=false / Bill_post=false; not final GL posting correctness |

## Confirmed Source Mapping — tables, fields, keys and joins

| Required information | Confirmed source / key or relationship | Reader rule for the proposed narrow case |
|---|---|---|
| Item identity/code/name | item_detail PK i_code; i_a_name; g_code FK→i_group.g_code; i_measure FK→Measure.Measure_Code | Resolve exact Item A in exact company/year DB; preserve code strings, leading zeros and Arabic; reject missing/duplicate required identity |
| Unit/package | Item_Detail_Units PK(I_Code,P_Code,Measure_Code); FK to item_detail/Measure; item_detail primary root p_code='0', i_size=p_size=1 | Line P_Code=Item A is **not** master p_code='0'. Keep role-specific columns; no generic same-name join |
| Warehouse | W_DETAIL PK(W_CODE,Branch_no), w_a_name | Join movement/receipt actual w_code + Branch_no to warehouse; do not use Bills.W_C_Code=0 as Warehouse0 |
| Purchase header | Bills PK(Bill_no,Bill_Pay_Type,Bill_Type,W_C_Code,Branch_no); unique index PKDoc | Prefer observed uniquePKDoc within scoped DB, retain composite/raw discriminators. HeaderUKeyID90738420-a882-4071-b63e-7640509a724e observed; not a catalog-proven unique header key |
| Purchase line | Bill_detail.PKDoc FK→Bills.PKDoc; unique index(UKeyID,Branch_no); record_no1, I_code/p_code/Measure_Code/I_measure/I_qty/p_qty/p_size/I_price/cost_cur/cost_rate | One line with UKeyID0c02c7b5-2210-46f0-a82c-cea2997e6d3a, Branch1. FK(I_code,p_code,Measure_Code)→Item_Detail_Units. Do not use document-number-only or labels as join |
| Receipt corroboration | gr_note uniquePKDoc; gr_detail.PKDoc trusted/enabledFK→gr_note.PKDoc; gr_detail unit/itemFKs; pi_no1/pi_type26, line record_no1/W1 | SamePKDoc and row scope corroborate this case. Receipt lineUKeyID9aa94621-dbf5-4702-9a98-4c17a6df3876 differs from invoice line; never equate these UKeys |
| Inventory impact | item_mov.PKDoc=selectedPKDoc, UKeyID equals selected Bill_detail line **in this case**, record_no1, serial2, Branch1/W1/UA/p_size1; inout_qty37, all free/sub sums0 | No catalog FK from item_mov to purchase/receipt was found; no unique index on item_mov or gr_detail in inspected catalog. Require scoped one-to-one cardinality/duplicate guards, not assumed global UKey/serial uniqueness |
| Available quantity | SELECT-only dbo.FindAvQty branch/item/warehouse/date/expiry/batch arguments; this base-unit path sums item_mov.inout_qty+inout_fqty; result37 | Official scoped available-quantity report is comparison authority. Movement basis corroborates selected scope. Do not call this all physical/reserved inventory; no missing-row→0 generic rule |
| Cost/amount | Bills.bill_amt3700 / Bill_currencySAR / rates1; Bill_detail.I_price100 / cost_curSAR / rate1; gr_detail.c_price/stk_cost100 | Transaction unit purchase cost, not automatically Product.costPrice or universal valuation policy. No implicit FX; base package1/UA controls quantity basis |
| Cash binding | Bills.Bill_Pay_Type1,cash_no1,extra_code97070103; saved cash_in_hand.cash_no1,cash_ac97070103; account/SAR evidence retained | Preserve payment key discriminators; null supplier is not Customer/supplier0. Do not infer settlement from Pay_Done/Cash_Amt_Pay defaults |
| Date and observed lifecycle | Bills.Bill_date2026-10-08 00:00:00; CrtdOn20:26:23.927; Bill_postfalse; receipt InvPosttrue; journal.Postedfalse | Business date is not a UTC instant. Separate saved/inventory-effective/ledger-posted meanings; raw state retained, alternative eligibility unresolved |

FKs cited above are enabled and trusted in the observed catalog. Metadata proves constraints/types, not business meaning. Bills.Bill_Type26, receipt pi_type26, item_mov.doc_type26 and PKTransDocType44 are separately observed values; no dictionary equivalence/general transform is asserted.

The inspected invoice line does **not** expose a w_code column: B_Code is null, WNum is empty and W_C_Code is0 in this record. Warehouse1 displayed by the official line is corroborated through the **same-event receipt/movement w_code1**, not an invented Bill_detail warehouse field or interpretation of those unrelated values. No catalog warehouse FK or general multi-line invoice-to-receipt pairing is claimed; expanded multi-line support would require its own linkage/cardinality evidence.

## Reconciliation Results

| Check | Result |
|---|---|
| Historical A→B counts | Bills0→1; Bill_detail0→1; gr_note/detail0→1 each; journal0→2 / master0→1; item_store0→1; opn_stock0→0; item_mov1→2; other12 monitored business tables remain0 |
| Header/line identity | One scoped header and line, correctPKDoc, source master identity and unit binding; UI independent reload agrees |
| Quantity/amount oracle | 37 UA ×100 SAR =3700 SAR; persisted receipt37 and one signed+37 movement; no bonus/free/subquantity contribution in this case |
| Scoped balance | Historical explicit report37, current FindAvQty37 and scoped movement sum37; user-accepted prior explicit0/PARTIAL baseline consistent with +37 |
| Deduplication oracle | One inbound business event despite invoice/receipt/movement representations. Counting all three would produce111 and fails the oracle |
| Accounting linkage | Two same-event SAR rows signed+3700/−3700, sum0; creation/link verified; final ledger posting NOT QUALIFIED |
| Historical B vs current pre-UI | All protected snapshot rows excluding observation time, all21 counts, complete document/receipt/journal/cache rows, function definition/parameters/result and movement totals match exactly |
| Current before→after UI view | Same complete comparison scopes match; accounts4/currency links3, Warehouse/Unit/Group/Item/Cashbox1 each, Supplier/Bank0; quantity37; no issue or new purchase |
| Historical zero row | All73 fields unchanged; fingerprintDC1991445F7FB86D40C47D28BDA492C30F550D999D94014C0A427443F1BB2165 retained by equality, not claimed recomputed. No producer/provenance investigation |

These are executed evidence comparisons, not passing connector tests. No source transaction or forced posting was performed. New UI footer behavior did not coincide with a change in the compared source rows.

## Unresolved semantics and explicitly unsupported outputs

- **Authority mismatch preserved:** item_store.avail_qty/p_qty and item_detail.AvailableQty remain0 despite scoped available37. Purchase footer is now selection-dependent/37, not the prior constant0. Do not choose a convenient cache column, claim it repaired, or infer its general role.
- **Numeric fidelity:** critical source amounts/quantities/rates are **SQL float(53)**, not fixed decimal; invoice numbers are bigint. The integers37/100/3700/1 are exact in this control case. General fractional extraction/rounding and large-integer serialization require an explicit evidence-backed policy/test; converting float to decimal text cannot recover lost source precision. Six-place UI display alone is not a universal accounting rounding specification.
- **Ordering:** one purchase cannot prove latest-purchase selection, timestamp ties or mutation ordering. Return selected document context only; preserve business date separately from acquisition time. Do not append UTC Z to source datetime or invent timezone.
- **Eligibility:** this saved cash/immediate/inventory-effective/unposted event is understood locally. Returns/cancelled/service/foreign/multiple-payment/posted variants are not qualified. Unknown/material representations reject or remain unavailable, not silently treated as equivalent.
- Supplier history/latest supplier, active PO/request status, positive bonus cases, outgoing movement, consumption/sales/demand, FIFO/lot depletion and attention thresholds remain unsupported. Missing support must not become zero/no supplier/no PO or a reorder signal.
- No generalized package conversion, multiple warehouse/batch/expiry, historical balance/FX/weighted-cost policy, representative performance or cross-version compatibility follows.

## Read-only acquisition and snapshot consistency gate

The fresh observer session is integrated Windows diagnostic access, **dbo / IsSysadmin1 / CONTROL SERVER1**. It is not FMMA, but that does **not** make it an independent least-privilege DBL reader. Only SELECT/catalog commands were issued; no write permission test, grant/login change, or source isolation change was executed.

Current EFA12026 is ONLINE/**writable**, compatibility120/Arabic_CI_AS, SQL12.0.6024.0 Express; SNAPSHOT isolation **OFF**, RCSI **false**, observed session transaction_isolation_level2. There is no claim that READ COMMITTED grants transaction-wide repeatability. Repeated equality while idle does not prove concurrent-write isolation. NOLOCK is forbidden.

The only DBL-named candidate seen in the bounded catalog query is **DBL_HOST_W11_EFA12026_RestoreProof_20261007**, ONLINE/writable. The accepted Host baseline/RestoreProof was prepared before these accounts and S2 and remains valid **for its documented recovery boundary**; it is not evidence of a frozen post-S2 source image. This round neither inspected its business contents nor changed it. Historical Reference Lab frozen/read-identity technique is a reusable hypothesis/procedure, not current Host qualification.

**Narrowest next gate, separately authorized:** have the authorized preparation operator preserve an exact post-S2 EFA12026 image and independently prepare an isolated frozen/read-only evidence stage, then use a distinct object-SELECT-only DBL reader to repeat the selected item/unit/warehouse/purchase/movement projections and reconciliation. Record source as-of distinct from acquisition time, backup/stage identity/hash, exact profile/company/year, selection scope, reader allowlist, mapping/build version and retention/cleanup owner. No reader-owned administrative backup/restore, no permission shortcut, no live option change. Validate dependencies on that isolated stage; the actual FindAvQty definition is local SELECT, but full EFA-only sufficiency for every proposed UI capability is not declared.

This proposal is **not executed** and does not authorize another backup/restore in this task. It requires bounded independent-read/consistency evidence for the chosen slice, not restarting broad provisioning or unrelated isolation research.

## Current Canonical Model — smallest proven needs, no edits

| Proposed capability | Existing fit | Minimum evidence-backed requirement for a later authorized decision |
|---|---|---|
| Item identity only | Product.id/name fit; optional SKU may be omitted rather than invented | No new business field needed for identity alone; exact source/company/profile and frozen acquisition provenance still required |
| Scoped available inventory | Product.quantityOnHand can hold37 but discards basis | Retain authoritative **available quantity** meaning, UA/package1 and Branch1/Warehouse1 scope, at snapshot context or record grain as appropriate. This is necessary context, not permission to design a generic multiwarehouse model now |
| Selected purchase context | No Purchase header/line representation; Sale is the wrong domain | Distinct purchase meaning, scoped source document and line identities, item relationship, business date, quantity/unit/package/warehouse and optional qualified currency-bound transaction cost/total; keep inventory-effective vs final-ledger state separate. Exact contract shape/version remains a later decision, not an invented Purchase API here |
| Purchase→stock reconciliation | No source line identity/link in current SaleLine; inventory scalar cannot explain origin | Preserve traceable selected source IDs and reconciliation/provenance. This first display need not create a generic movement entity or claim all ledger families |
| Acquisition manifest | SourceRef + capturedAt is insufficient for this discrepancy investigation | Bound source/as-of/profile/scope/acquisition hash/reader/evidence/mapping identity; don't label acquisition timestamp as business snapshot as-of |

No status enum, tax/FX framework, supplier fields, broad stock ledger or speculative canonical domain is added. Do not encode purchases in `sales`, unit price as Product.costPrice by convenience, or use arbitrary extra keys that exact-key validation will reject. Money can be omitted in the first quantity-focused implementation if its numeric policy is not yet qualified; this does not hide the proven3700 case evidence.

## Minimum Connector Slice — proposal only

One **Motakamel Plus educational profile / EFA12026 / company-year2026**, prepared frozen stage, independent bounded reader. First implementation increment can be **Item A identity only** after its Gate A; S3 is not required. The smallest useful later Item Intelligence display is **Item A + scoped available37UA/Warehouse1 + selected saved cash purchase1-44-1-0-1 with inbound37**, with100/3700SAR only under the explicitly qualified numeric policy.

Use the existing architecture with specific fixed/parameterized SELECTs, exact scoped keys and cardinality guards. Persist only proven supported facts; no free-form SQL, generic mapping, receipt double-count, Customer stand-in, latest-purchase selection or demand signal. Unsupported capabilities are visibly unavailable. Specific one-event allowlist is a lab slice, not an unattended/general reader for arbitrary Motakamel companies. A future expanded record must meet new evidence/eligibility tests.

Before authorized implementation of this useful slice: close its frozen/constrained-read gap, approve only the necessary contract/provenance delta and exercised P1 corrections (runtime fidelity, pre-iteration cleanup, early child-row/byte limits). Reconcile through local storage/pinned Application Service; contract acceptance alone does not prove business truth. Storage forward-version, deployment security, cancellation/deadline/Windows lifecycle and representative performance remain directly exercised trust or later pre-pilot gates, not a reason for unrelated framework refactoring.

## Required acceptance and failure tests — not implemented/run here

1. Golden positive: exact Item/code/name/unit/W1, one selected header/line,37 and optional SAR100/3700, available37; source IDs survive staging/storage/read scope.
2. Dedup: invoice + generated receipt + movement produce one inbound37, never111. Duplicate/multiple line/event candidates must fail rather than arbitraryFirst/Distinct dropping evidence.
3. Identity joins: header PKDoc + scoped line UKey/Branch, unit composite FK, warehouse Branch/W; missing/null/duplicate/orphan IDs rejected; code001 never silently numeric1 for Group or SKU.
4. Scope: warehouse or branch mismatch, wrong UA/package, additional unit/expiry/batch or unknown event invalidates this narrow claim rather than aggregate globally. Missing stock rows do not automatically imply0.
5. Authority: cached0 cannot replace the reconciled available37; if trusted scoped UI/source diverge, withhold quantity and classify evidence gap, never repair ERP.
6. Lifecycle eligibility: expected saved/unposted+inventory-effective case accepted only within supported profile; unknown returns/cancellation/service/payment/state explicitly unsupported/rejected. No blanket filterBill_post=true that drops the proven inbound.
7. Currency/numeric: matchingSAR/rate1; null/different currency or unsupported FX rejected for monetary display. Float fractions/rounding, nonfinite values and bigint precision tested before support; exact-decimal string transport/arithmetic, no implicit conversion or fallback0.
8. Date/provenance: source business date separate from captured/as-of; same-day latest-event/tie logic unsupported, no guessed UTC or vendor linkage.
9. Acquisition: independent constrained identity and frozen repeatable projections; concurrent/source change cannot mix pages. No NOLOCK/READ COMMITTED snapshot assumption or cross-live dependency escape.
10. Runtime: unknown canonical field rejection, identifier-type fidelity, row/byte bounds before allocation, header/staging failure before iteration, early cancellation/deadline/close/restart cleanup and last-known-good atomic visibility.
11. Application: queries/pages/insights share one local snapshot and acquisition scope; changing latest import does not change an already pinned read scope. No SalesSummary/Purchase Attention signal synthesized from this selected purchase alone.

## Stop and next action

**S2 A/B reconciliation for the selected control event: PASSED — LAB-PROVEN.**
**Requested implementation decision: EVIDENCE GAP**, primarily the unqualified frozen post-S2 independent-read path; the useful purchase/inventory slice also needs a compatible minimal contract/provenance decision and numeric/runtime policy. This is not a request for S3, more accounts, full chart setup, every Pilot capability or Design Partner data before identity-only code.

Authorize only the **post-S2 frozen-stage + independent constrained reader evidence gate** next. After it succeeds, decide the minimal exercised contract/P1 change separately. Gate B remains NOT MET (no implemented end-to-end Motakamel path); Gate C is not claimed; S3 stays frozen. No ERP Save, SQL write, report regeneration, posting, account/master change, backup/restore, security/configuration change, connector/canonical implementation or build mutation occurred. **STOP.**
