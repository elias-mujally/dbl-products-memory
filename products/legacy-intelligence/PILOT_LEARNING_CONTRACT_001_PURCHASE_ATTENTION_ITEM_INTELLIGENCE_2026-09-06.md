# Pilot Learning Contract #001 — Purchase Attention + Item Intelligence

**Date:** 2026-09-06  
**Status:** ACTIVE PRODUCT HYPOTHESIS — TO BE VALIDATED WITH REPRESENTATIVE AUTHORIZED DATA AND A REAL PILOT USER  
**Primary first connector target:** YemenSoft Motakamel Plus ERP, system/version-specific only

## Why this contract exists

The independent full-product review concluded that DBL Legacy Intelligence needs a locked operational pilot hypothesis before more connector work. This document records the first concrete hypothesis derived from a real purchasing workflow rather than from ERP architecture alone.

This is **not** a permanent definition of the whole product and is **not** a healthcare-only product decision. It is the first narrow learning contract used to decide what evidence, semantics, connector slice, and UI should be built next.

## Real problem observed

A purchasing user often needs several pieces of context about one item before taking the next purchasing step, but the legacy ERP distributes those facts across multiple screens and reports.

The deeper problem is not only screen fragmentation. The ERP may also require the user to already know **which item deserves attention**.

In the observed hospital purchasing workflow, attention commonly starts through an external human signal:

- pharmacists send messages that a medicine may need ordering or may run out soon;
- a supplier representative asks about or reminds the buyer about an item;
- or the purchasing employee manually monitors stock and orders, which becomes expensive in time and effort when many screens must be inspected per item.

Therefore the current workflow is approximately:

`External hint or manual monitoring -> identify item -> inspect multiple ERP screens -> reconstruct context -> decide next action`

## Target user definition

The first user is **not defined by a corporate job title**.

The relevant user is any person who is wholly or partly responsible for monitoring items and preparing or making purchasing decisions. Depending on the business this may be:

- a purchasing employee;
- a business owner operating alone;
- a manager;
- a store or inventory operator;
- or another person performing the same decision workflow.

This keeps the product compatible with a hospital, wholesale business, grocery store, small shop, home business, or other inventory-based activity while keeping the first pilot problem narrow.

## Core pilot hypothesis

DBL can reduce the effort required to identify and understand items that deserve purchasing attention by doing two things:

1. **Purchase Attention:** surface items that deserve review, with a deterministic and explainable reason.
2. **Item Intelligence:** when the user opens an item, assemble the purchasing context that is otherwise scattered across ERP screens.

Proposed DBL workflow:

`DBL surfaces items needing attention -> user opens an item -> DBL assembles Item 360 context -> human decides the next action`

DBL V1 remains decision intelligence / decision support. It does **not** autonomously decide that an order must be placed, select a supplier, or invent an order quantity.

## First Item Intelligence value slice

When a user searches for or opens an item, the first pilot should attempt to provide the following only where source semantics are independently proven.

### 1. Current inventory context

- current quantity;
- authoritative unit;
- warehouse/scope where required for semantic correctness.

Inventory is treated as foundational context even though it was not one of the original five scattered-information pain points.

### 2. Previous ordered/purchased quantity and subsequent movement

The user needs to answer the practical question:

> Last time we brought this item, how much did we bring, and how much of it has moved since then?

Required semantics must distinguish the relevant purchase event from unrelated inventory movement and must define what "moved" means for the pilot.

Potential displayed facts include:

- quantity in the relevant previous purchase/order event;
- quantity moved/issued since that event;
- remaining quantity only if it can be derived authoritatively and without false attribution.

### 3. Bonus on the relevant previous purchase

Show the bonus/free quantity associated with the relevant previous purchase only if Motakamel source semantics prove how bonus is represented and tied to the item/document/line.

### 4. Item movement profile

The user wants a quick, explainable indication of whether an item is strongly moving, moderately moving, weak, or stagnant.

The healthcare workflow supplied useful domain examples, including:

- 200+ units exhausted in roughly 2–3 months may indicate a moving item;
- some exclusive medicines may have 1000+ units exhausted in less than one month;
- 100–200 units exhausted in roughly 3–6 months may indicate medium-to-strong movement;
- 100–200 units taking roughly 8 months may indicate medium-to-weak movement;
- an old last order, such as more than a year, may be a weak-signal depending on actual movement context;
- no movement for six months or more is treated operationally as stagnant in the observed workflow.

These examples are **domain evidence, not universal hard-coded DBL thresholds**.

The product should model an explainable movement profile using evidence such as:

`incoming/purchased quantity + outgoing movement + elapsed time + last movement + current stock`

Classification thresholds may need to be configurable or industry/profile-specific. A visual indicator such as an icon may be used in UI, but no particular icon is a product requirement.

### 5. Supplier context

Where source semantics support it, show:

- how many suppliers have historically supplied the item;
- supplier identities;
- the most recent supplier used for the item;
- enough provenance to explain how "most recent supplier" was determined.

The pilot does not require supplier recommendation or automatic supplier selection.

### 6. Existing purchase-order context

Answer whether the item already has a relevant purchase order/request in progress.

If semantics can be proven, expose the minimum useful context such as document identity, date, quantity, and status. DBL must not collapse draft, cancelled, completed, or otherwise semantically different states into a misleading boolean.

## Purchase Attention hypothesis

A stronger value proposition than Item 360 alone is that DBL helps the user know **where to look first**.

Candidate attention reasons include, subject to source-semantic proof and pilot validation:

- low stock relative to recent movement;
- an item approaching depletion under a defined movement profile;
- an item needing review while no relevant purchase order is active;
- prolonged lack of movement / stagnation;
- other deterministic conditions discovered from the representative pilot dataset.

Every attention signal must be explainable from source-backed facts. AI is not the authority for these classifications.

## Explicit V1 boundaries

The first pilot does **not** require DBL to:

- autonomously place purchase orders;
- choose a supplier automatically;
- prescribe an optimal order quantity;
- treat healthcare movement thresholds as universal rules;
- understand every Motakamel purchasing/inventory feature;
- implement all industries;
- infer unsupported bonus, status, movement, warehouse, unit, or supplier semantics;
- use AI as execution or accounting authority.

Human judgment remains the final authority for the purchasing action.

## Pilot learning question

The main question is:

> Can a user identify an item that deserves review, understand its relevant purchasing context, and determine the next human action through DBL while materially reducing the need to navigate multiple legacy ERP screens?

## Success measurement

Do not invent an arbitrary success percentage before observing a real pilot.

During the supervised pilot, measure at least:

- time needed to identify and understand an item;
- number of legacy ERP screens/reports the user still needs to open;
- information DBL failed to provide or represented ambiguously;
- semantic/reconciliation mismatches;
- whether the user can explain why an attention signal appeared;
- whether the user voluntarily returns to DBL for the next comparable task;
- qualitative trust in the displayed source/provenance.

Acceptance thresholds should be set after establishing the real baseline with the pilot user.

## Evidence required from Motakamel before implementation claims

The next Motakamel investigation should be driven by this pilot, not by the 516-table schema as a whole.

Representative authorized data must allow targeted proof of:

1. item identity and stable keys;
2. inventory quantity, unit, warehouse/scope, and authoritative balance semantics;
3. purchase/order headers and lines;
4. document status/eligibility semantics;
5. item quantity on the relevant purchase line;
6. bonus representation and linkage;
7. outgoing/movement transactions needed to explain how much moved;
8. supplier identity and item-purchase-supplier linkage;
9. multiple-supplier history and reliable ordering by event time/identity;
10. purchase-order/request existence and state;
11. returns/cancellations/adjustments that could invalidate naive calculations;
12. dates/timestamps required for movement profiles;
13. independent reconciliation against trusted Motakamel UI/reports for the same records.

No Canonical Model field should be added merely because the pilot wants it. Add the smallest field/semantic only after source evidence proves what it means.

## Representative-data priority

Preferred evidence order remains:

1. authorized backup from a genuinely used Motakamel installation, accompanied where possible by trusted reports and an expert/user;
2. populated official/vendor/partner demo data;
3. limited evidence session with a Motakamel accountant/operator who can interpret actual records;
4. creation of new educational cases only for specific semantic gaps that cannot be answered above.

Do not resume Account Numbering as the default critical path. Its rule remains unresolved historical evidence and becomes relevant again only if a proven pilot requirement depends on creating those educational records.

## Architecture implications

This pilot does not justify a rewrite.

Keep the current architecture:

`Legacy ERP -> System-specific Connector -> Import Orchestrator -> SQLite -> SnapshotReader -> Query/Insight Engines -> Application Service -> UI`

The pilot should instead drive:

- targeted schema/mapping evidence;
- the smallest evidence-driven Canonical Model corrections;
- the already-identified P1 trust fixes needed by the real connector;
- one narrow Motakamel connector slice;
- one minimal Purchase Attention + Item Intelligence UI;
- one supervised pilot.

## Next execution sequence

`Pilot Learning Contract #001 -> Representative Authorized Motakamel Data -> Targeted Purchasing/Inventory Schema Evidence -> Semantic Mapping + Reconciliation -> Minimal Canonical/P1 Corrections -> Narrow Motakamel Connector -> Minimal Purchase Attention + Item Intelligence UI -> Supervised Pilot`

## Decision

**ACCEPTED AS THE FIRST PILOT HYPOTHESIS.**

This contract supersedes the earlier tendency to treat Sales / Returns / line drill-down as the assumed first UI slice. Sales/Returns remain potentially useful source semantics and future capabilities, but they are no longer the default pilot merely because they were previously discussed.

The product thesis remains broader than purchasing: DBL should make fragmented legacy-system data easier to understand and act on without forcing a migration. This pilot is simply the first concrete wedge chosen from a real observed workflow.
