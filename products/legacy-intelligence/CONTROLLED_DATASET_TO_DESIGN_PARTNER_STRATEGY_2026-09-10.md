# Controlled Dataset → Design Partner Strategy — 2026-09-10

**Status:** ACCEPTED EXECUTION STRATEGY

## Decision

DBL Legacy Intelligence will not wait for representative real-world Motakamel data before beginning all connector work.

We will use the existing isolated educational Motakamel Plus environment to create a **small controlled Pilot #001 dataset through official application workflows**, prove semantics one hypothesis at a time, reconcile the resulting source data against Motakamel, and build only the connector/UI slice supported by that evidence.

Representative authorized data from a real Motakamel user remains required before claiming real-world connector qualification or a successful customer pilot.

This changes the sequencing, not the trust standard.

## Why the strategy changed

The preferred vendor path was tested. The available training offer provides an empty Onyx environment in which the trainee creates the data. No populated training/demo company was available, including for Motakamel Plus.

Waiting indefinitely for an ideal populated database would now stall learning unnecessarily. At the same time, treating self-created educational data as representative production evidence would overstate confidence.

The correct split is:

1. **Controlled educational evidence** for discovery, A/B semantics, initial reconciliation, and narrow implementation.
2. **Representative real-world evidence** for challenging those mappings, discovering configuration/version/edge differences, operational qualification, and supervised pilot validation.

## Controlled Dataset purpose

The controlled dataset is not intended to simulate an entire company.

Its job is to create known facts through official Motakamel workflows so we can answer specific Pilot #001 questions such as:

- which source identity represents an item;
- how purchase header/line identity is represented;
- how quantity and unit are represented;
- how supplier linkage is represented;
- how current inventory changes after a purchase;
- how subsequent outgoing movement is represented;
- how bonus is represented, if the workflow can be created without unrelated provisioning;
- how purchase orders/requests and statuses are represented, if they can be created without broad ERP archaeology;
- how returns/cancellations/adjustments affect the supported facts.

Every created transaction must have a known expected business result before source inspection.

Example pattern:

`Known UI action -> capture expected business fact -> inspect bounded source changes -> form mapping hypothesis -> reconcile against Motakamel -> record confidence`

## Strict boundary

The educational dataset can authorize implementation of a **lab-qualified narrow connector slice** when the relevant semantics are sufficiently proven and reconciled.

It cannot by itself justify claims such as:

- production-ready Motakamel connector;
- compatibility across Motakamel installations or versions;
- representative performance;
- complete purchase/inventory semantics;
- operational safety on a customer environment;
- successful Pilot #001 validation with a real user.

Those claims require representative authorized evidence.

## Anti-rabbit-hole rule

We are not resuming the old Golden Dataset program as a broad ERP-setup exercise.

The new rule is:

> Create the minimum official transaction needed to answer one named Pilot #001 semantic question. If creating that transaction requires unrelated provisioning or broad reverse engineering, stop that case, record the blocker, and move to another evidence source/question.

Account Numbering remains unresolved and off the critical path unless a later proven Pilot #001 transaction directly requires it.

Do not create customers, GL structures, pricing structures, or unrelated master data merely to make the educational environment feel realistic.

## Design Partner strategy

Once DBL has a credible end-to-end demonstrable slice, begin actively seeking a real organization using Motakamel Plus as a **Design Partner**.

The partner proposition is not "give us your database so we can build an idea."

The intended proposition is:

- DBL already demonstrates a narrow useful Motakamel intelligence workflow;
- DBL is read-only toward the legacy ERP and must not write or modify Motakamel business data;
- customer data access must use an approved isolated/least-privilege acquisition path;
- DBL may create its own local snapshot/evidence artifacts under an agreed retention/security boundary;
- the partner helps validate semantics, reports, workflows, configuration differences, and usefulness;
- in return, the partner receives supervised access to useful early DBL capabilities during the development relationship without charge, subject to an explicit pilot agreement.

Do not promise that DBL "never touches data." The accurate promise is that DBL does not write to or modify Motakamel business data in V1 and that reading/acquisition is constrained and auditable.

## Demo-ready threshold before active Design Partner outreach

Do not wait for a polished product. Begin serious outreach when one end-to-end vertical slice can be demonstrated:

`Controlled Motakamel data created through official UI`
`-> qualified safe read path`
`-> Motakamel-specific mapping/connector slice`
`-> DBL local snapshot`
`-> Purchase Attention and/or Item Intelligence output`
`-> visible provenance/source context`
`-> reconciliation against the known Motakamel case`

Not every desired Pilot #001 capability must be present. Bonus or PO/request may remain explicitly unsupported if their semantics are not yet proven. Unsupported capabilities must never be faked or silently approximated.

## What the first real Design Partner validates

The partner is not merely a source of rows. The relationship should answer:

1. Do lab mappings survive a genuinely used Motakamel environment?
2. Which version/configuration differences break them?
3. Which document/status/unit/warehouse cases were absent from the lab?
4. Do DBL outputs reconcile with the partner's trusted Motakamel screens/reports?
5. Does Purchase Attention + Item Intelligence actually reduce navigation and decision effort?
6. Which missing fact blocks usefulness or trust?
7. Does the user voluntarily return to the workflow?

Failures here are valuable product evidence, not reasons to conceal unsupported cases.

## Qualification levels

Use explicit language to prevent evidence inflation:

### LAB-PROVEN
A semantic mapping or behavior has been demonstrated with controlled official Motakamel transactions and reconciled in the isolated educational environment.

### PARTNER-VALIDATED
The same supported interpretation has been challenged and reconciled against representative authorized data/workflows from a real Motakamel user for an exact system/version/profile.

### PILOT-QUALIFIED
The supported slice has additionally passed the agreed operational, provenance, security, failure/cleanup, and user-value criteria in a supervised pilot.

Do not collapse these levels into a single "supported" label.

## Updated execution path

The preferred immediate path is now:

`Pilot #001`
`-> Controlled Motakamel Dataset #001`
`-> Targeted A/B Evidence + Reconciliation`
`-> Minimum Evidence-Driven Canonical/P1 Corrections`
`-> Narrow Lab-Qualified Motakamel Connector`
`-> Minimal Purchase Attention + Item Intelligence UI`
`-> Demo-Ready Vertical Slice`
`-> Motakamel Design Partner`
`-> Representative Data Validation + Mapping Corrections`
`-> Supervised Pilot`
`-> Pilot Qualification`

Representative real-world data therefore moves from being a prerequisite for **all connector implementation** to being a prerequisite for **partner validation / pilot qualification**.

## Immediate next task

Before entering more transactions, design **Controlled Motakamel Dataset #001**.

It should specify the smallest ordered set of official Motakamel actions required to prove the first useful Pilot #001 semantics, the known expected result after each action, the evidence to capture, and the stop condition for each scenario.

Do not execute the dataset until that design has been critically reviewed for unnecessary ERP setup and hidden scope expansion.

## Product boundary unchanged

Pilot #001 remains Purchase Attention + Item Intelligence.

This strategy does not authorize Pilot #002, seller-side implementation, a generic connector framework, a generic mapping DSL, full ERP archaeology, autonomous purchasing, or write-back to Motakamel.
