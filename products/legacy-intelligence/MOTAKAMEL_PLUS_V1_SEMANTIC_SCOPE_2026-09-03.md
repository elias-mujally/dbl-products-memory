# Motakamel Plus — Minimum V1 Semantic Scope

Date: 2026-09-03. Evidence origin: **DBL-MotakamelPlus-Lab**. This milestone is a scope decision from preserved lab captures, not a new runtime experiment, schema inventory or implementation.

## Current architectural decision

**DATABASE BOUNDARY STILL REQUIRES GOLDEN DATASET**

`EFA12026` remains REQUIRED. `Multi_Lang` is now **OPTIONAL for the minimum scoped V1**; no required concept has a proven indispensable S_FLAGS mapping. This removes full lookup/flag decoding as a prerequisite, but **does not prove EFA12026-alone sufficiency**. `DbRepDes` and `EFAARC10` remain OPTIONAL on current evidence. Do not widen grants or backups in anticipation of unproven needs.

The minimum business scope remains customers, products, inventory, sales and sales returns. Full journal/account export is not established V1 scope. Return representation and inventory/amount semantics must still fit the proven canonical boundary; this decision adds no canonical fields or alternate representation.

## Required semantic groups

| Group | Minimum required understanding | Local evidence / remaining proof |
|---|---|---|
| R01 | Actual sales/return document families | Separate bill/return projections and local type predicates; complete decoder needs Golden Dataset |
| R02 | Header/line identity and raw key discriminators | PKDoc join and payment-code grouping/conditional selection exist locally; uniqueness and populated links unproven |
| R03 | Customer/product linkage and master identity | Local item join and customer fallback/projection; cash/null and master-link rules unproven |
| R04 | Document eligibility | Bill_post=0 used by not-posted view; return posting input uses edit/review/post flags; not an export filter or complete state machine |
| R05 | Currency identity and rate/amount basis | Trusted local Bills currency FK to ex_rate; rate direction and document amount basis need records |
| R06 | Whole/sub/free quantities, UOM and sign | Local quantity expression and separate return projections; no global unit/free/sign mapping yet |
| R07 | Authoritative inventory quantity and grain | Local balances/quantity candidates exist; empty probes do not establish actual versus available stock authority |
| R08 | Financial versus stock-movement linkage | Local separate outward movement/document references; avoid double counting and prove timing behavior |
| R09 | Return header/line/product/original-document relationship | Local BillPKDoc and return projections; cardinality and unmatched returns need records |
| R10 | Actual net/gross amounts and material adjustments | Local discount projections and selected tax/burden flags; authoritative amount and flag effects need reconciliation |

Necessity and evidence maturity are separate axes: all ten groups are required concepts, but end-to-end populated proof still requires Golden Dataset. Source fields are candidate evidence anchors, not final mappings.

**Bills.Bill_Type != journal.doc_type dictionary unless independently proven**

## What is not a prerequisite

- Full payment-channel/settlement enum, translated labels or AR-aging features. Preserve raw Bill_Pay_Type in identity/grouping wherever needed; exclusion does **not** mean discarding it or assuming one payment type.
- Active-only customer filtering and customer price-tier engine. Keep historical referenced masters.
- Assembly recipes/manufacturing workflow, full journal/account dictionaries, COGS and stocktake workflow.
- UI captions, printing/layout/localization selections.

These are feature exclusions, never silent business-row exclusions. Quantity effects, material discounts/taxes and referenced products still need preservation. Unknown materially affecting variants must be reported/rejected explicitly, not guessed into supported codes.

Four candidate groups remain UNRESOLVED / REQUIRES GOLDEN DATASET only if they affect the required concepts:

1. item_detail.i_c_type/blocked: item/stock effect versus mere availability.
2. item_detail.fre_prc and Bill_detail.gr_flag: possible amount/quantity effect, no proven decoder.
3. item_store.post_or_not/move_pref: relevance to the selected authoritative balance.
4. RT_BILLS.Replacement/PaymntMethod/BillsKind/PaymentType: relevance to return meaning, not assumed equivalent payment dictionaries.

Do not create a comprehensive flags matrix. A local default or same numeric value across tables is not semantic proof.

## Why Multi_Lang is OPTIONAL, not proven REQUIRED

PROVEN within the captured scope:

- 22 selected code probes returned empty sets.
- Only exact-name S_FLAGS match was Bill_Pay_Type: six code pairs across four languages, 24 rows.
- Local credit/noncredit views use payment4 versus non4. Post_Sales_Amt also groups by raw payment code and conditionally filters it under sequenc_bill=2/4/6.
- Currency FK/reference, selected state predicates, bill/item joins and quantity expressions are local to EFA12026.

SCOPE DECISION: translated payment-channel classification is not needed for the minimum requested products/customers/inventory/sales-return semantics. Raw key preservation does not require translating its values. Labels alone would not resolve eligibility, return relationships or inventory authority anyway.

UNRESOLVED: complete required business semantics and populated EFA-only sufficiency. This is not a claim that every Multi_Lang object is presentation-only. If Golden Dataset identifies an indispensable external decoder, prove its binding/behavior and cross-database capture requirement before expanding the boundary.

## Evidence provenance and limits

Investigation-workspace artifacts (not copied wholesale into Product Memory):

- `MOTAKAMEL_PLUS_V1_REQUIRED_SEMANTIC_CODES_SCOPE.md`: detailed 22-group table (10 required, 8 feature exclusions, 4 unresolved).
- `MOTAKAMEL_PLUS_V1_DATABASE_BOUNDARY_QUALIFICATION.md`: current boundary plus preserved historical runtime details.
- `outputs/motakamel-v1-semantic-scope-01/SEMANTIC_SCOPE.json`: necessity/maturity axes and traceability for all 22 earlier candidate columns.
- `outputs/motakamel-v1-semantic-scope-01/SOURCE_MANIFEST.json` and `VERIFICATION.json`: offline revalidation of 72 raw entries from the two flags and two database-boundary runs.
- `outputs/motakamel-v1-flags-01/07-local-foreign-keys.json`, `08-local-semantic-consumers.json`, `11-exact-name-sflags-matches.json`.
- `outputs/motakamel-v1-flags-followup-01/23-local-enum-values.json`, `24-targeted-local-meaning.json`.

Prior boundary evidence: 91 reference rows classified as 63 conditional HMS, 22 master helpers, 3 Multi_Lang and 3 XML-alias artifacts; no blanket multi-database requirement. Sixteen restricted local probes succeeded, but 13 were empty business tables, two were constant reference projections and one was TOP0 binding. This is access evidence, not 16 populated extractions.

Limits: bounded/capped definition scans and sanitized/truncated excerpts; no exhaustive application/dynamic trace. Primary flags capture stopped on a post-query serialization error after saved after-state14; missing original ledger/completion/host-after were not fabricated. Independent focused follow-up completed with eight SELECTs and matching states. Raw evidence remains unchanged. This scope task ran no SQL/VM/application operation and did not touch Host Motakamel/SQL.

## Gates and next step

- System/Version Profile: PARTIAL; observed educational identity/pre-login baseline is documented, but enabled modules, customization and explicit schema version remain unresolved.
- Read-only Access & Isolation: PARTIAL; independent least-privilege read/CONTROL SERVER denial and single-DB frozen-backup technique are proven, final operational/V1 boundary still open.
- Source Schema Inventory: NOT STARTED; bounded candidate metadata is not full inventory.
- Mapping Evidence and business Reconciliation: NOT STARTED.
- Unsupported/Unresolved Semantics: PARTIAL, with focused gaps recorded above.
- Dataset Size & Performance: PARTIAL lab-only measurements, not representative qualification.
- Exact V1 Connector Scope: PARTIAL; minimum intent/codes narrowed, implementation-safe mappings and exclusions not yet proven.

Next single step, **proposed only**: **Motakamel V1 Targeted Golden Dataset Qualification** in the isolated lab using the official GUI and independent frozen EFA-only read evidence. Obtain authorization before entering business data. No Connector, Canonical Model change, blanket lookup acquisition or generalized framework now.

Motakamel Plus remains the **Primary First Connector Target**. AlMuhaseb1 remains an acquisition/evidence lab, not an alternative target or schema substitute.
