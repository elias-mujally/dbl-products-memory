# Multi-Lens Product Direction — 2026-09-06

**Status:** PRODUCT DIRECTION CLARIFICATION — NOT A NEW IMPLEMENTATION SCOPE

## Why this note exists

Pilot Learning Contract #001 deliberately focuses on **Purchase Attention + Item Intelligence** because it came from a real purchasing workflow. That pilot must not accidentally redefine DBL Legacy Intelligence as a purchasing-only product.

A second real-world perspective exposed the complementary seller-side problem: a pharmaceutical agency using an ERP may care much less about purchasing and much more about what it sold, which pharmacies/clinics/centers/hospitals buy each product, returns, bonuses, discounts, customer behavior, and sales movement.

This confirms that the deeper DBL problem is broader than a single ERP module or department.

## Product-level problem

Legacy ERP data is commonly organized around modules, screens, reports, and transaction structures. Users think in terms of an entity, a business question, and a decision.

DBL should therefore aim to reorganize proven source data around **decision context**, without forcing a migration away from the legacy system.

The recurring pattern is:

`Entity / Question -> Gather relevant context across ERP domains -> Explain what deserves attention -> Human decision`

The same item can be viewed through different business lenses.

## Multi-lens model

### Item -> Purchasing Lens

Example questions:

- How much stock remains?
- How much was previously purchased and how much has moved?
- What bonus was received?
- Who supplied it?
- Is there already a relevant purchase order/request?
- Does the item deserve purchasing attention now?

This is the focus of Pilot #001.

### Item -> Sales Lens

Example questions:

- How much of this item was sold?
- Which customers buy it most?
- Which customers used to buy it but have stopped or slowed down?
- What returns occurred?
- What bonus was given?
- What discounts were given?
- Is sales movement increasing, decreasing, or stable?

These are hypotheses to validate with a real seller-side workflow before becoming implementation requirements.

### Customer -> Customer Intelligence Lens

For a pharmacy, clinic, medical center, hospital, retailer, or other customer, potential questions include:

- what do they buy?
- how much do they buy?
- when did they last buy?
- what have they returned?
- what bonuses/discounts have they received?
- how is their purchasing behavior changing over time?

Again, these are product-direction hypotheses, not yet committed V1 semantics.

### Supplier -> Supplier Intelligence Lens

Potential context includes purchase history, items supplied, prices, bonuses, recent transactions, and other evidence-backed supplier behavior relevant to the user's decision.

## Important distinction

**Pilot != Product.**

Pilot #001 is the first narrow wedge used to learn and deliver value. It does not define the permanent boundary of Legacy Intelligence.

Do not respond to this broader direction by expanding Pilot #001 into purchasing + sales + customers + suppliers at once. That would destroy the learning value of the narrow pilot.

Instead:

- keep Pilot #001 narrow;
- preserve seller-side workflows as a separate validated opportunity;
- allow repeated real use cases to reveal which canonical concepts deserve to become stable;
- abstract only after evidence repeats across lenses/systems.

## Candidate future pilot

A possible second learning contract is provisionally named:

**Sales Attention + Customer/Item Intelligence**

It should not be fully specified until a seller-side user workflow is interviewed in the same way Pilot #001 was derived from purchasing experience.

A promising real-world candidate is a pharmaceutical agency/wholesaler whose operator follows:

- sales by medicine;
- buying pharmacies/clinics/centers/hospitals;
- returns;
- bonuses per customer;
- discounts per customer;
- customer/product activity over time.

No implementation priority is assigned to Pilot #002 yet.

## Architectural implication

This clarification strengthens, rather than changes, the current architecture.

DBL should not mirror ERP module navigation in a new UI. The long-term opportunity is to expose evidence-backed views centered on entities and decisions through the Application Service while retaining system-specific connectors underneath.

Potential conceptual pattern:

`Legacy ERP domains -> System-specific semantic mapping -> DBL entities/context -> Decision-oriented lenses`

Do not create a generic lens framework, universal ontology, or new abstraction layer merely because this note uses the word "lens". Implement the first proven experiences, then abstract only after repetition.

## Canonical Model implication

Do not expand the Canonical Model now to anticipate every purchasing or sales question.

Use Pilot #001 representative Motakamel evidence to make the smallest necessary changes. If a later seller-side pilot independently needs overlapping concepts such as Product, Customer, Sale, Return, bonus, discount, or source-line identity, that repetition becomes stronger evidence for stable canonical semantics.

## Strategic product statement

A more accurate product direction is:

> DBL Legacy Intelligence helps users understand and act on business context trapped across legacy ERP screens by gathering evidence-backed information around the entity and decision they actually care about.

Purchasing is the first validated learning wedge, not the product category.

## Current execution decision

No change to the immediate execution sequence:

`Pilot #001 -> Representative Authorized Motakamel Data -> Targeted Purchasing/Inventory Evidence -> Semantic Mapping + Reconciliation -> Minimal Canonical/P1 Corrections -> Narrow Motakamel Connector -> Minimal Purchase Attention + Item Intelligence UI -> Supervised Pilot`

The seller-side opportunity is recorded so future work does not mistakenly narrow the product thesis to purchasing only.
