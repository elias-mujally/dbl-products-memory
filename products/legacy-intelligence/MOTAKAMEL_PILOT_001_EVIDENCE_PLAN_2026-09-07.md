# Motakamel Pilot #001 Evidence Plan — Purchase Attention + Item Intelligence

**Date:** 2026-09-07  
**Status:** READY TO EXECUTE WHEN REPRESENTATIVE AUTHORIZED DATA IS AVAILABLE  
**Target:** Motakamel Plus, exact observed system/version/profile only  
**Pilot:** Learning Contract #001 — Purchase Attention + Item Intelligence

## 1. Purpose and scope

This plan defines the smallest evidence program needed to decide whether a trustworthy Motakamel connector slice can support Pilot #001.

It must prove, from representative populated records, which source facts let a user:

1. identify an item that deserves purchasing review;
2. open that item and understand its relevant stock, purchase, movement, supplier and purchase-order/request context;
3. trace every displayed fact and deterministic attention reason back to a qualified source snapshot and a trusted Motakamel comparison;
4. make the next decision themselves.

The plan does **not** attempt to prove:

- all Motakamel modules, tables, flags or versions;
- Sales Intelligence, Customer Intelligence or Pilot #002;
- a complete accounting, purchasing, inventory or warehouse ontology;
- automatic supplier selection, order quantity optimization or purchase-order creation;
- a universal connector, SQL framework, mapping DSL or schema inspector;
- production administration of customer backup/restore by DBL;
- that a table or column name is its business meaning;
- that the current Canonical Model already represents the required slice.

The immediate acquisition boundary under evaluation is:

`Authorized representative Motakamel source`
`-> customer/DBA-approved acquisition`
`-> isolated frozen EFA12026 copy where applicable`
`-> independent least-privilege read identity`
`-> targeted evidence queries`
`-> trusted UI/report reconciliation`

`FMMA` is never the DBL read identity. `WITH (NOLOCK)` is never a consistency mechanism. Backup/restore preparation remains an operator/DBA responsibility unless a later production qualification explicitly proves a safer supported boundary.

## 2. Evidence vocabulary and proof standards

### Evidence classes

| Code | Acceptable proof | What it can establish |
|---|---|---|
| A | Direct schema, key, trusted constraint or dependency proof | Structure, enforced cardinality or a real local reference; not business meaning by itself |
| B | Observed populated records from a qualified snapshot | Actual values, recurrence, nullability patterns and candidate relationships |
| C | Controlled official-UI A/B transaction with before/action/after capture | Direction, lifecycle effect, generated linkage or field transition |
| D | Reconciliation to a trusted Motakamel screen, document or report for the same source identifiers and scope | Business interpretation and calculation agreement |
| E | Confirmation by a knowledgeable Motakamel operator/accountant, recorded with the exact case and terminology | Operational meaning and workflow context; strongest when combined with B or D |
| F | Legitimately available view, function, stored-procedure or application logic tied to the observed records | Selection, calculation or status logic; input/posting logic is not automatically an extraction rule |

No question is considered semantically proven by any of the following alone:

- a table or column name;
- an empty flag or a default value;
- a guessed Arabic/English label;
- UI label similarity;
- equal numeric codes in different dictionaries;
- a generic ERP expectation;
- one unexplained record that merely fits the desired interpretation.

### Confidence and status

- `PROVEN`: required proof combination is satisfied and reconciled for the supported profile.
- `PARTIAL`: useful evidence exists, but at least one material interpretation or edge remains open.
- `UNKNOWN / NOT YET PROVEN`: candidate only; implementation must not rely on it.
- `DEFERRED`: outside Pilot #001 or explicitly omitted from the first slice.
- `BLOCKED`: missing evidence would make the intended output misleading or irreconcilable.

## 3. Pilot semantic questions and required proof

| Pilot capability | Exact semantic question | Minimum acceptable proof |
|---|---|---|
| Stable item identity | Which source key remains unique and stable across item, stock, purchase, movement and order records, including branches/years where relevant? | A + B; D for at least two selected items |
| Item code/name | Which fields are the operator-recognized code and name, and can either be duplicated, reused or changed? | B + D; E for reuse/change policy if not encoded |
| Unit semantics | What is the authoritative unit for stock, purchase quantity, bonus and movement, and how are whole/sub-units converted? | B + D plus A or F for conversion; C if ambiguous |
| Warehouse/location scope | Is stock held by warehouse, branch, store, batch or another grain, and what identifier labels each scope? | A + B + D; E if UI terminology differs |
| Current inventory | Which value is authoritative for the pilot: physical, available, opening, reserved or derived quantity, at what grain and as of what time? | B + D for multiple items/scopes; F or C for derivation/direction |
| Purchase identity | Which document family and composite/internal key identify a qualifying completed purchase without colliding with another type? | A + B + D; F for type/eligibility logic |
| Purchase header-line relationship | What exact keys join each purchase line to one header, and what identifies a line independently? | A where enforced, otherwise B across multiple documents + D; C if collisions remain possible |
| Purchase quantity | Which fields represent purchased quantity, sub-unit quantity and free/bonus quantity, and in what unit? | B + D plus F or C for formula/sign |
| Relevant transaction date | Which date represents the purchase event used by the user: order, receipt, invoice, posting or another date? How are ties ordered? | B + D + E; F if business logic selects it |
| Supplier identity/link | Which stable supplier key belongs to the purchase header/line, and how are cash/one-off or changed supplier records represented? | A + B + D; E for operational exceptions |
| Multiple-supplier history | Can the same stable item be linked to purchases from different suppliers and ordered deterministically by event time plus tie-breaker? | B for one multi-supplier item + D; A/F for join/order where available |
| Bonus | Is bonus a separate quantity, sub-quantity, line, discount or another construct, and is it tied to the relevant purchase line without double counting? | B + D and C or F; E alone is insufficient |
| Outgoing movement | Which source event families constitute movement out for the pilot, and which must be excluded or shown separately? | B + D + F; C for at least one unclear family |
| Movement direction/sign | Are incoming/outgoing quantities stored by sign, document family, separate columns or calculated logic? | B across opposing events + D; C or F required |
| Returns/cancellations/adjustments | How do purchase returns, cancellations, reversals and stock adjustments affect qualifying purchase history, current stock and movement since purchase? | B + D; C or F for each case that occurs in the supported slice |
| PO/request identity | Which source object and key represent the purchase order/request relevant to an item, rather than a sales order, warehouse request or unrelated workflow? | B + D + E; A/F for structure and family |
| PO/request header-line link | What exact key connects order/request lines to their header and item? | A, or multiple B examples + D |
| Status lifecycle | Which states mean draft, approved, active, partially received, completed, cancelled, expired/stale or rejected, and which transitions matter to the user? | B + D + E, supported by F or C; labels/defaults alone do not qualify |
| Item to outstanding PO/request | What makes a PO/request line outstanding for a given item after partial receipts, cancellations and closure? | B + D plus F or C; a non-null row is not enough |
| Currency/rate | If money is displayed, which currency and rate apply, in what direction, and is the value line, document, tax-inclusive or adjusted? | A + B + D; F for calculation. Otherwise omit amounts and mark `DEFERRED` |
| Source/as-of semantics | What instant or closed transaction boundary does the acquired copy represent, and which source timestamps may legitimately be later/earlier? | Acquisition record + backup metadata/hash where applicable + source reconciliation |

## 4. Minimal representative dataset requirements

The preferred source is a genuinely used, authorized Motakamel company/year with a knowledgeable user and trusted reports. It need not be large, but it must contain enough variation to disprove naive mappings.

### Required to begin

- more than one item, with distinct recognizable source identifiers;
- more than one supplier;
- one item purchased from at least two suppliers;
- multiple qualifying purchase dates for at least one item;
- an item with movement after a purchase;
- items with materially different movement patterns;
- enough history to distinguish recent from old activity without inventing a universal threshold;
- one item with no recent movement;
- more than one warehouse/location if the actual user workflow is warehouse-scoped;
- at least one order/request believed by the operator to be active and one believed to be closed/completed/cancelled, if PO/request context is included in the first UI slice;
- trusted Motakamel screens/reports or source documents for the selected examples.

### Required when supported and present in the pilot business

- at least one bonus/free-quantity purchase case;
- one purchase return or cancellation affecting a selected item;
- one partial receipt or partial return if the user relies on partial-state decisions;
- one stock transfer or adjustment if it contributes to the movement quantity the pilot will show;
- one multi-unit item if such items exist in the pilot's selected catalog.

### Optional/deferred at first execution

- foreign-currency purchase, unless the pilot intends to show monetary values or such purchases are common in the selected business;
- negative stock, unless it occurs in representative records;
- batch/expiry tracking, unless it changes the selected item's stock or movement interpretation;
- full purchase-order lifecycle coverage beyond states used by the pilot company;
- every supplier or warehouse in the database.

If the source lacks a required populated example, record the gap. Do not synthesize its meaning from empty schema. A controlled educational case may be created later only for that named gap through the official workflow.

## 5. Initial evidence matrix

Candidate names below are evidence anchors only. They are not approved mappings. Existing evidence proves that several objects/columns exist or bind; it does not prove their purchase-domain authority.

| Pilot question | Source object(s) | Candidate tables/views/procedures | Required populated example | Proof method | Reconciliation target | Confidence | Status | Notes / unresolved semantics |
|---|---|---|---|---|---|---|---|---|
| Item identity/code/name | EFA12026 | `item_detail` (`i_code`, observed name-shaped fields) | Two recognized items referenced by transactions | A+B+D | Item master/search screen | Medium for candidate | NOT YET PROVEN | Stable key and rename/reuse policy unknown |
| Item unit/conversion | EFA12026 | `item_detail.i_size`; `Units_types`; line `Measure_Code` candidates | One normal-unit item; multi-unit item if used | A+B+D+F/C | Item/unit setup and transaction display | Low | UNKNOWN | No dictionary equality inferred |
| Warehouse/location grain | EFA12026 | `item_detail_Dtl.Branch_No`; `item_store`; `abranch`; other warehouse identifiers only after observed linkage | Same item in two scopes if relevant | A+B+D | Warehouse stock screen/report | Low | UNKNOWN | Branch, warehouse and store are not assumed equivalent |
| Current stock | EFA12026 | `item_store.actual_qty`, `avail_qty`, sub-unit candidates; `opn_stock` candidates | Item with known current balance and movements | B+D+F/C | Stock balance screen/report at identical scope/as-of | Low | UNKNOWN | Names do not establish authoritative balance |
| Purchase header | EFA12026 | `Bills` is a generic document-header candidate | Two purchases recognized by operator | A+B+D+F | Purchase document/report | Low | UNKNOWN | Purchase `Bill_Type`/eligibility not decoded |
| Purchase line | EFA12026 | `Bill_detail` generic line candidate | Multi-line purchase with selected item | A+B+D | Purchase detail screen/report | Low | UNKNOWN | Header/line key and stable line ID unproven |
| Purchase quantity/date | EFA12026 | `Bill_detail` quantity-shaped candidates; header date candidate must be discovered from actual record/metadata | Two purchase dates, known quantities | B+D+F/C | Purchase line and document date | Low | UNKNOWN | Do not choose invoice/order/post date by name |
| Supplier identity/link | EFA12026 | No supplier master/link object is yet qualified | Same item from two suppliers | A+B+D+E | Supplier master + purchase header | None | UNKNOWN | Discover from the selected populated purchases only |
| Supplier count/most recent | EFA12026 | Derived only after purchase/supplier/date keys are proven | One multi-supplier item | B+D | Item purchase history/report | None | BLOCKED | Tie-breaking and eligibility required first |
| Bonus/free quantity | EFA12026 | `Bill_detail.free_qty`, `free_sqty`, `gr_flag`; `item_detail.fre_prc` are historical candidates | One operator-confirmed purchase bonus | B+C/D+F | Same purchase line/report | Low | UNKNOWN | Candidate fields were observed in prior document evidence, not proven for purchases |
| Outgoing movement | EFA12026 | `V_Trans_Dtl`, movement-related views/procedures, document/stock objects discovered from selected item | Item with known post-purchase issue/sale/transfer | B+D+F/C | Item movement/card report | Low | UNKNOWN | Earlier logic was not qualified as Pilot #001 movement recipe |
| Movement sign/direction | EFA12026 | Quantity projections and document-family discriminators | At least one incoming and one outgoing event | B+C/D+F | Movement report running quantities | Low | UNKNOWN | Positive return must not be mistaken for sale/purchase |
| Return/cancellation/adjustment | EFA12026 | Generic `Bills`/`Bill_detail` family candidates; exact purchase-return objects unknown | One present representative case | B+D+F/C | Return/cancellation document and stock effect | None | UNKNOWN | `RT_BILLS` evidence concerns sales returns and is not assumed to be purchase-return evidence |
| PO/request identity/status | EFA12026 | `S_Order`, `Order_detail`, `pr_SaveOrder_detail`, `pr_SaveS_Order`, `Req_whse` are object-existence/name candidates only | Operator-selected active and closed examples | A+B+D+E+F | Official PO/request screen/report | Very low | UNKNOWN | Do not infer purchase semantics from `Order`/`Req` names |
| Outstanding item PO quantity | EFA12026 | Unknown until header/line/status/receipt links are proven | Open partially/unreceived item line | B+D+F/C | PO status plus receipts | None | BLOCKED | Naive existence boolean prohibited |
| Currency/rate if shown | EFA12026 | `Bills.Bill_currency`, `Bill_rate`; `ex_rate` local FK is historical evidence | One selected purchase, foreign currency only if relevant | A+B+D+F | Purchase totals/currency display | Low | UNKNOWN | Existing FK evidence does not prove purchase amount basis/rate direction |
| Source as-of | Acquisition layer + EFA12026 | Backup/header metadata and selected record timestamps | Every evidence run | Acquisition proof + D | Report generated for same cutoff | Medium for frozen-copy technique | PARTIAL | Lab technique qualified; representative production operation remains unqualified |

`Multi_Lang` remains optional. It is added to an evidence run only if a required status or code cannot be interpreted from EFA12026 and a specific binding to `Multi_Lang` is demonstrated. `DbRepDes` and `EFAARC10` are not part of the initial boundary without a named required dependency.

## 6. Reconciliation cases

Every reconciliation uses the same company/year, item, warehouse/location, eligibility rules and as-of boundary. DBL/source calculations must retain the selected source IDs so the operator can open the exact comparison.

| Case | DBL/source calculation | Trusted Motakamel comparison | Must match exactly | Formatting that may differ | Blocking difference |
|---|---|---|---|---|---|
| Current stock | Qualified balance projection at proven grain | Stock balance/item card screen or report for same item/scope/as-of | Item key, scope, unit and exact decimal quantity | separators, trailing zeros, localized label | Different quantity, hidden reservation, unit or scope |
| Previous purchase | Latest eligible purchase under proven date/tie rule | Exact purchase document + purchase history | Header ID, line ID/key, item, quantity, unit, event date | date presentation/time display | Different document family, quantity, date meaning or eligibility |
| Movement since purchase | Sum/classification of proven outgoing events strictly after the selected event boundary | Item movement/card report over identical interval | Included source IDs, direction and exact normalized quantity by unit | row order or displayed sign if normalization is documented | Unexplained event, double count, transfer/adjustment ambiguity |
| Supplier context | Distinct eligible purchase suppliers; latest by proven ordering | Item purchase history and exact purchase headers | Supplier IDs, count and latest supplier/event | localized names | Missing/duplicate supplier or unresolved tie |
| Bonus | Proven bonus quantity/line associated with selected purchase | Exact purchase document/report | Source line relationship, unit and exact bonus quantity | label/zero formatting | Discount confused with quantity, or double count |
| Open PO/request | Select lines satisfying proven active/outstanding lifecycle | Official order/request status and receipts | Document/line/item IDs, ordered/received/outstanding quantity and state | translated status label | Draft/cancelled/closed considered active; partial receipt wrong |
| Return/cancellation impact | Apply only proven return/reversal/eligibility effect | Original and return/cancellation documents plus movement report | Source links, quantity direction and inclusion/exclusion | display sign if semantic normalization is explicit | Original not linked, state ambiguous, stock/purchase history disagrees |

For each case preserve both raw values and normalized values. Normalization may remove proven presentation-only differences; it must never hide changes in identifiers, dates, units, quantities, status, warehouse scope, supplier, currency, rate or business meaning.

## 7. Negative and edge cases

### Must exercise when present in the first pilot's real workflow

- cancelled/draft/non-eligible purchase document;
- returned or partially returned purchase if used;
- bonus represented by separate quantity, line or adjustment;
- multiple units if the selected items use them;
- warehouse transfer if it contributes to the displayed movement profile;
- inventory adjustment if it contributes to the displayed movement profile;
- zero stock;
- supplier changed over time;
- open order/request with partial receipt;
- closed/cancelled order/request;
- item with no purchase history;
- item with purchase but no outgoing movement;
- duplicate-looking item codes if they exist across branches/companies/years.

### Conditional

- negative stock, if supported and present;
- stale PO/request, only after “stale” has a user-approved age or lifecycle definition;
- multi-currency, only if money is shown or the pilot source uses it;
- partial return, when partial returns affect a selected item's context;
- batch/expiry, when it changes the stock grain used by the pilot.

### Deferred

- sales/customer analytics;
- COGS and full GL linkage;
- manufacturing/assembly;
- purchasing recommendations and optimized order quantity;
- flags used only for UI, printing or unrelated modules.

Unsupported edge cases must be surfaced as exclusions/warnings. They must not be silently folded into a supported code.

## 8. Purchase Attention evidence boundary

### Facts we must prove

- stable item and scope identity;
- current authoritative stock quantity and unit;
- relevant previous eligible purchase identity, quantity, unit, supplier and event date;
- all included post-purchase movement events, their direction, unit and time boundary;
- last included movement date;
- whether a relevant PO/request is outstanding, only if its lifecycle is proven;
- return/cancellation/adjustment effects that materially change those facts;
- source as-of time and unsupported-state warnings.

### Rules we may later configure

- what “low stock” means;
- how many days of stock imply approaching depletion;
- the time window for recent movement;
- thresholds for strong, medium, weak or stagnant movement;
- whether an active PO suppresses or changes an attention reason;
- industry-, company-, warehouse- or item-class-specific thresholds;
- ordering and severity of multiple attention reasons.

The first deterministic attention rule may be implemented only after its inputs reconcile. Pharmaceutical examples are domain hypotheses, not core defaults. Every rule must expose the facts, rule version/configuration and reason that produced the result. AI may explain a proven result but may not invent the classification or missing facts.

## 9. Provenance requirements

Every evidence run must carry an acquisition manifest containing at least:

- source system/product and observed version/build/profile;
- company, activity, year, branch, warehouse/location and database scope where applicable;
- acquisition method and responsible operator boundary;
- backup identity, backup-set metadata and SHA-256 when a backup is used;
- source “as of” time, acquisition time and timezone, kept distinct;
- restored database identity, file paths and `READ_ONLY` state when applicable;
- independent connector/read identity name and granted-object allowlist, without secrets;
- confirmation that `FMMA` was not the DBL reader;
- evidence-plan version and future mapping/connector version;
- selected item, purchase, movement, supplier and PO/request source identifiers;
- exact query/evidence step identifiers and deterministic normalization rules;
- trusted comparison report/screenshot/document reference, parameters, scope and capture time;
- operator/expert confirmation reference where used;
- unresolved assumptions, excluded states and any cross-database dependency;
- hashes of raw evidence and normalized comparison artifacts;
- cleanup/retention owner and disposition for backup/restored/temporary data.

Credentials, passwords and secret-bearing connection strings must never be written to the manifest or evidence reports.

## 10. Stop conditions

Stop a direction and record the result when any of the following occurs:

- the candidate table has no representative populated row for the selected case;
- a UI workflow requires unrelated master-data or broad ERP provisioning;
- schema plus populated observation still permit two material interpretations: require one controlled A/B case or trusted reconciliation;
- a semantic concept is not required by Pilot #001: mark `DEFERRED`;
- explaining one field requires broad full-ERP reverse engineering: return to the item/document case and narrow;
- a query/view crosses into a live or unqualified database from an isolated restore;
- only FMMA or another privileged application identity can access the candidate path;
- evidence requires changing production isolation options or using `NOLOCK`;
- trusted report scope cannot be aligned with the source query;
- the dataset lacks the edge case required to distinguish competing mappings: switch to another authorized source or a narrowly controlled case;
- a status/quantity/currency ambiguity could change the user's decision: mark the capability `BLOCKED`, not approximately supported;
- an investigation repeats the same result without testing a new hypothesis.

## 11. Go / No-Go gates for connector implementation

| Gate | GO | PARTIAL | BLOCKED | DEFERRED |
|---|---|---|---|---|
| Item identity/master | Stable ID, display code/name and selected scope reconcile | Some rename/duplicate policy unknown but selected profile safe | Cross-scope collisions unresolved | — |
| Inventory context | Authoritative quantity, unit, grain and as-of reconcile | One explicitly supported scope only | Physical/available/unit ambiguity changes meaning | Unused warehouse/batch variants |
| Previous purchase | Eligible header/line, identity, quantity, supplier and relevant date reconcile | Narrow supported document family only | Cannot distinguish purchase/state/header-line | Unused purchase variants |
| Movement since purchase | Included event families, direction, units and boundary reconcile | Explicit limited movement families with warning | Double count or missing material movement possible | Unrelated movement modules |
| Supplier context | Stable supplier link and latest-event ordering reconcile | Latest supplier proven; full count withheld | Supplier association/tie ambiguous | Recommendation/scoring |
| Bonus | Quantity/line meaning reconciles | Capability hidden or marked unavailable | Blocks only if pilot user requires it for the learning question | May be deferred by explicit pilot decision |
| PO/request context | Identity, line, lifecycle and outstanding quantity reconcile | Capability hidden with no “no PO” attention rule | Naive boolean would mislead and is still intended | May be deferred by explicit pilot decision |
| Returns/cancellations | Material cases included/excluded correctly | Unsupported rare family causes explicit run rejection | Common case can silently distort facts | Unused modules |
| Currency/amounts | Required monetary values reconcile with currency/rate | Quantities only; money not displayed | Mixed/unknown currency while money is shown | Monetary display omitted |
| Acquisition/provenance | Frozen scope, least privilege, hashes, as-of and cleanup documented | Supervised-only operating limit explicit | Live inconsistent read or privileged DBL identity required | Unattended automation |
| Mapping artifact | Every implemented field has source keys, filters, proof and unresolved policy | — | Guess remains in an implemented field | Non-pilot fields |

Connector implementation may begin only when the core path—item identity, inventory context, previous purchase, included movement, supplier link, acquisition/provenance and all material corrections—is `GO` for the exact supported profile. Bonus and PO/request may be hidden/deferred only through an explicit Pilot #001 scope decision; their absence must also remove any attention rule that depends on them.

Full ERP understanding is not a gate.

## 12. Exact first execution sequence when data arrives

1. Record authorization, custodian, source system/version, company/year and intended pilot scope.
2. Preserve the source artifact; hash it and record source/as-of metadata before inspection.
3. Have the customer/DBA prepare the approved acquisition; restore only into the isolated boundary and freeze it where applicable.
4. Provision/verify an independent least-privilege object allowlist; confirm no FMMA, write, DDL or cross-live-database path.
5. With the operator, select a small item/document corpus that covers the required variations and capture exact Motakamel comparison references.
6. Identify keys and immediate dependencies for those selected records only; cap the first-pass object set.
7. Resolve one semantic hypothesis at a time using A–F evidence; preserve raw rows and source identifiers.
8. Reconcile current stock, previous purchase, movement since purchase, supplier, bonus and PO/request cases that are in scope.
9. Exercise only material negative/edge cases present or required; record unsupported states explicitly.
10. Write the system/version-specific Mapping Evidence Table and acquisition manifest; independently review every `PROVEN` claim.
11. Decide the smallest Canonical Model corrections and P1 trust fixes required by the proven slice—without implementing them in this evidence task.
12. Issue a `GO / PARTIAL / BLOCKED / DEFERRED` decision for each capability and authorize connector implementation only if the core gates are `GO`.

## 13. Time-box and anti-rabbit-hole rules

- Work on one semantic hypothesis and one selected source case at a time.
- Limit the first pass to the selected records and their direct key/dependency path; do not inventory hundreds of tables.
- Cap initial candidate objects at approximately a dozen. Expanding the set requires a named unresolved pilot question and a direct reference from an already relevant object or runtime/report path.
- Spend no more than one focused evidence session on an empty candidate. If it lacks a populated example, switch source or record `UNKNOWN`.
- Use at most one controlled A/B transaction for a specific ambiguity before reviewing whether a trusted populated example/report can answer it more cheaply.
- Do not repeat a runtime experiment unless it tests a different causal hypothesis or acquisition path.
- Do not decode flags that do not change a Pilot #001 fact or exclusion.
- Prefer a documented unresolved semantic over forced certainty.
- If the current source cannot answer a material question, change evidence source in this order: authorized populated backup -> populated official/vendor/partner demo -> expert-led bounded session -> narrowly created educational case.
- End each session with: questions closed, questions still open, new objects introduced, evidence hashes, and the single next hypothesis.

## 14. Relationship to the independent-review P1 findings

This plan does not remediate P1 issues. Its outputs determine the smallest remediation required around the first real connector:

| P1 finding | When it must be addressed | How this evidence plan informs it |
|---|---|---|
| Runtime canonical type validation | Before representative Motakamel import is accepted | Provides the exact optional fields/types and negative round-trip cases |
| Connector/source lifecycle cleanup | During connector implementation, before pilot | Defines acquisition lifecycle, early failure, cancellation and cleanup boundaries |
| Child-row memory bounds | During connector implementation, validated before pilot | Representative document/movement fan-out supplies realistic row/byte tests |
| Smallest Canonical Model semantics | After mapping evidence, before implementation | Shows whether unit, warehouse, purchase/movement, supplier, bonus or PO context needs first-class representation |
| Provenance manifest | Designed from this plan and implemented before pilot | Section 9 supplies the minimum manifest contract |
| Deployment security | Qualified before customer data leaves the supervised boundary | Defines role separation, allowlists, retention and secret exclusions |
| Storage forward-version handling | Before distributing a pilot build that may reopen persisted data | Independent trust fix; do not expand it into storage redesign |

These are targeted trust corrections, not a general refactoring program.

## 15. Critical review against over-engineering

This plan intentionally removes the following from the immediate investigation:

- full schema inventory;
- full code/flag dictionary;
- educational Chart of Accounts/Customer/Account Numbering continuation;
- sales/returns/customer-intelligence mapping;
- procurement optimization and write-back;
- generic frameworks and multi-system abstractions;
- comprehensive multi-currency, batch, expiry or manufacturing support unless representative Pilot #001 records require them.

Its only broad-looking area—movement—is constrained to the event families necessary to explain the selected item's post-purchase movement. It is not an inventory-ledger rewrite.

## 16. Product Memory chronology clarification

The 2026-09-03 minimum semantic scope and Decision 53 describe the earlier sales/returns-oriented V1 evidence path. Pilot Learning Contract #001 on 2026-09-06 explicitly supersedes that path as the **immediate pilot execution anchor**.

This is a chronology conflict, not proof that the older evidence is false:

- preserve the older sales/returns findings as historical evidence;
- do not treat their ten semantic groups as Pilot #001 implementation gates;
- reuse a prior source candidate only when the purchasing/inventory evidence independently connects it to the selected populated records;
- do not expand Pilot #001 into Pilot #002 merely because the existing Canonical Model and earlier research are sales-oriented.

The latest README already reflects the new execution path. No README update is required by this plan.

## 17. Final decision

### Readiness for Pilot #001 evidence execution

**READY, CONDITIONED ON THE EVIDENCE SOURCE.**

The procedure, safety boundary, proof classes, candidate anchors, reconciliations and stop conditions are defined. Execution should begin as soon as representative authorized populated Motakamel data arrives with trusted comparison material and access to a knowledgeable operator.

### Readiness for Motakamel connector implementation

**BLOCKED.**

No implementation-safe purchase/inventory mapping has yet been proven. Current schema candidates are insufficient without populated records and reconciliation.

### Single most valuable next evidence source

**An authorized backup from a genuinely used Motakamel environment, accompanied by the exact item/purchase/stock/PO reports or screens for selected records and a knowledgeable operator who can confirm their workflow.**

### Biggest current uncertainty

**Which exact Motakamel document, movement and status semantics jointly define an eligible previous purchase, subsequent outgoing movement and an outstanding purchase order/request for one item—without double counting and at the correct unit/warehouse/as-of grain.**

### Immediate execution path

`Representative authorized data + trusted comparisons/operator`
`-> execute this targeted evidence plan`
`-> Mapping Evidence + reconciliation`
`-> minimum Canonical/P1 decisions`
`-> narrow Motakamel connector authorization`

Account Numbering remains preserved but off the critical path. No application code, Canonical Model, connector, generic abstraction or Pilot #002 work is authorized by this plan.
