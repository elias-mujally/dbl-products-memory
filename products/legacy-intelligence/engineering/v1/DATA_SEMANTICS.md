# V1 source data and qualified semantics

[Index](README.md) · [Timeline](TIMELINE.md) · [Evidence](EVIDENCE.json)

**FACT scope:** one educational V1 source/fixture, branch=1, warehouse=1, group001, unit1, pack1, SAR; five DBL items; no opening/free/sub-unit stock; constant positive cost per item. This is not a universal Motakamel schema or costing policy.

## Tables and quantities

| Table / field | Observed facts and mapping |
|---|---|
| item_detail | Five unique i_code; Arabic name is i_a_name, not nullable i_name. i_measure='1', p_size=1, g_code='001'. AvailableQty='0' and i_cur_cost=NULL in this source. |
| item_store | Five matching warehouse/branch rows, zero opening fields and avail_qty='0'; actual_qty and stored cost fields are NULL. These cache values are not the report balance. |
| W_DETAIL | One warehouse W_CODE=1 and Branch_no=1; clearing account W_Acc=102. Warehouse is scope/evidence, not a new Canonical entity. |
| item_mov | Ten saved movement rows. **quantity = sum(inout_qty)** with its actual sign. i_qty and p_qty are positive magnitudes, p_size='1'; unit fields m_measure and Measure_Code='1'. free/sub-unit/opening fields are zero or allowed NULL as qualified. |
| opn_stock | Zero rows for the five filtered items at acquisition, corroborating no double-counted opening stock. |
| gr_note / gr_detail | Three headers and six lines, including one issue return. Receipt details corroborate quantity, cost, currency, document/line and inventory-effect flags. |
| rtnincm_note / rtnincm_det | Zero rows. They are not silently treated as proof of an implemented customer-return flow. |
| journal / Journal_Master | Ten entries and five masters; independently reconcile the five stock-document values/account pairs. They are evidence here, not a generic GL import. |

The owner collector filters item-keyed tables to DBL-T01..T05, bounds all row counts and captures metadata/completeness. Header/journal rows are bounded whole-table reads inside this tiny lab. Do not generalize that acquisition to a customer database.

## Type fields are distinct

| Business meaning | item_mov.doc_type | PKTransDocType | journal.doc_type |
|---|---:|---:|---|
| Stock receipt | 5 | 21 | '17' |
| Consumption issue | 6 | 23 | '18' |
| Issue return saved as receipt | 5 | 21 | '17' |
| GUI requisition identifier | not acquired as movement | GUI showed 48 | no acquired journal effect |

Do not infer a shared enum across invoice, stock and journal columns. Item movement PKSubDocType=0; some receipt/master counterpart fields are NULL. Equality assumptions beyond the exercised profile are unsupported.

## Keys and return linkage

- Item identity: i_code, with source primary-key metadata.
- Warehouse identity: W_CODE plus Branch_no, with recorded keys; W_CODE also has a unique index in this version.
- Document: PKDoc preserves number/type/branch discrimination. Receipt1 and issue1 are different documents despite the same printed number.
- Movement: UKeyID and serial_no are unique in this source; document key + record_no is also checked. Receipt detail UKeyID equals its corresponding stock-movement UKeyID.
- Return receipt3 has OutcomRT=1, OutcmPkDoc='2-23-0-0-1', and detail OutcmRecord_No=3, identifying T05's original issue line. Source quantity5, return2, matching cost25; total returns cannot exceed the referenced issue magnitude in this profile.

Issue headers themselves were not included in the first fixed acquisition list. Signed ledger rows, journal pairs and prior GUI observations establish the exercised consumption semantics; do not claim a general issue-header/status mapping.

## Cost, currencies and accounting

**FACT:** i_cost = stk_cost on each movement, matching receipt c_price/stk_cost/wtavg_after; cost and stock rates are 1, currency SAR. Costs are constant per item: 20/80/5/40/25. The connector rejects varying costs rather than inventing weighted-average/FIFO behavior.

Receipt header ExRate is zero in the captured data, while movement i_rate and detail rates are one. The implementation does not multiply by that header zero or silently infer foreign exchange. Foreign-currency/rate scenarios are unqualified.

For each document, signed stock quantity × cost reconciles to account101's signed journal amt; the counterentry is opposite. j_amt is a positive magnitude and j_amt_type true/false corresponds to debit/credit for the exercised rows. Net balances101=1470,201=-4625,301=3155 total zero. Clearing102 is separate from the stock account; supplier202 is separate from the generic goods payable201. Those account numbers are lab-specific decisions.

## Posting fields

- Receipt header/detail InvPost=true is observed with actual stock/report effects.
- Receipt gr_post=false and journal Posted=false remain unchanged. Do not label these documents finally GL-posted.
- journal j_posted is a populated date/time field in the acquisition, not a boolean equivalent to Posted.
- item_store.post_or_not=false and cached quantities zero do not erase the signed ledger/report evidence.
- item_mov.gr_flag=true for all ten baseline rows (and eleven after the third test) is an observed profile condition, not a proven universal posting-state predicate.

ERP accounting-report recognition, stock effect, journal-row presence and final GL posting are separate claims.

## Time, Canonical boundary and unresolved scope

Business dates are SQL DATETIME wall-time strings with no offset, preserved as such in evidence. Acquisition timestamps contain explicit offsets and seven fractional digits. Canonical capturedAt normalizes the acquisition finish to milliseconds; the exact original remains in qualification evidence. No timezone is invented for the business date.

Canonical 2.1.0 persists five Products with sku/name/quantityOnHand/costPrice. It does not gain generic warehouse, group, unit, stock document, requisition or journal entities. Those remain source provenance/qualification evidence. Inventory value is exact decimal quantity × qualified constant cost, with currency separation and declared partial coverage. LowStock threshold5 is a DBL test setting, not an ERP reorder point.

**UNQUALIFIED:** actual requisition rows/status mapping (the first collector captured schema but not their business rows), cancellation/delete/reversal variants, final posting, variable costs, multiple currencies/warehouses/units/branches, commercial invoices/customer returns/tax/payments and production-size performance. The GUI unapproved/unreceived requisition did not change the verified balance; no request quantity is ever added by the connector.


## Third actual change corroboration — 23 October

[Actual third capture](THIRD_CAPTURE_RESULT.md) adds exactly one consumption movement: document3/key3-23-0-0-1, T01, signed−1, unit cost20, warehouse/branch/unit1. All ten old movements and ten old journal rows stayed unchanged. New journal pair Dr30120/Cr10120 yields net101=1450,201=−4625,301=3175; Posted=false remains unchanged. Products now29/3/50/2/12, total1450SAR.

Receipt1/T01 detail fields c_qty and pc_qty changed30→29 in the same source comparison; all other fields of that row and the other receipt-detail rows stayed unchanged. This is a measured correlated maintenance effect, not a second stock event. General allocation semantics remain unknown. Continue deriving stock only from the qualified signed ledger with journal/cost corroboration. R3 still does not acquire issue headers or requisition business rows, so no current status mapping for those is newly proven.
