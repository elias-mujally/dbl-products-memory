# Procurement Operations Wedge Study

**Product:** DBL Legacy Intelligence  
**Date:** 2026-09-01  
**Status:** Strategic research / candidate vertical wedge  
**Decision level:** Study and validate before changing the core roadmap

## Executive conclusion

Procurement Operations is currently the strongest candidate for the first commercial vertical wedge of Legacy Intelligence.

The opportunity should **not** be treated as a separate procurement suite and should **not** attempt to replace ERP/P2P systems. The strategic fit comes from using the existing Legacy Intelligence thesis: keep the customer's current system and add an intelligence/action layer above it.

The recommended first workflow is deliberately narrow:

> **PO Follow-up & Exception Agent for wholesalers/distributors using existing or legacy ERP systems.**

This workflow has strong overlap with the current Legacy Intelligence architecture and the Distribution Pack vision, while solving a measurable operational problem involving open purchase orders, supplier follow-up, confirmations, delays, discrepancies, approvals, and ERP updates.

**Current assessment:** 9.4/10 strategic fit with Legacy Intelligence.

---

## Why this opportunity matters

Recent market validation indicates significant investment and product activity around agentic procurement and supply-chain operations. Companies such as Didero, Lio, Freehand, and major ERP vendors are validating the broader thesis that procurement workflows can be automated by agents operating across ERP systems, email, documents, and supplier communications.

The important conclusion for DBL is not simply that "procurement + AI" is attractive. That positioning is becoming crowded quickly.

The more defensible Legacy Intelligence positioning is:

> **Make operationally important legacy/current business systems intelligent without forcing the company to replace them.**

This is especially relevant to SMB and mid-market wholesalers/distributors that may have functioning ERP software, local/custom systems, SQL databases, spreadsheets, email-driven supplier processes, and limited appetite for expensive enterprise procurement transformations.

---

## Relationship to Legacy Intelligence

Procurement Operations is not conceptually separate from Legacy Intelligence. It maps naturally onto the existing platform model:

```text
Existing / Legacy ERP
+ Email
+ Excel / CSV
+ PDFs
+ Supplier communications
        ↓
Legacy Intelligence Connectors
        ↓
Semantic Business Model
        ↓
Intelligence / Detection
        ↓
Recommendation / Draft
        ↓
Policy + Permission + Approval
        ↓
Controlled Action Engine
        ↓
ERP / Email execution
        ↓
Audit Log
```

This means much of the required infrastructure should remain reusable platform infrastructure rather than procurement-specific code.

### Existing concepts that can be reused

- Connector Framework
- Semantic Mapping / Semantic Business Model
- Controlled Action Engine
- Policy and Permission Engine
- Human Approval flows
- Auditability
- Offline/online execution concepts
- Industry Packs
- Distribution-oriented entities and workflows

The procurement-specific layer should primarily contain domain semantics, rules, workflows, prompts/models, exception definitions, and connector mappings.

---

## Recommended target customer

### Initial ICP

A small or mid-market wholesaler/distributor that:

- already has an ERP or internal business system;
- does not want to replace it;
- manages meaningful purchase-order volume;
- communicates with suppliers heavily through email and documents;
- uses spreadsheets/manual checks around the ERP;
- has employees repeatedly checking PO status and supplier confirmations;
- suffers from late deliveries, missing confirmations, data mismatches, or fragmented supplier communication;
- cannot justify or does not want a large Coupa/Ariba-style transformation.

### Avoid initially

- Fortune 500 procurement transformations;
- customers requiring a complete source-to-pay suite;
- greenfield companies with no operational system to integrate with;
- highly customized enterprise deployments requiring months of professional services before value can be demonstrated.

---

## Killer workflow candidate

# PO Follow-up & Exception Agent

The first version should solve one operational loop extremely well rather than trying to automate procurement end-to-end.

### Proposed workflow

1. Read open purchase orders from the customer's ERP/database.
2. Identify unconfirmed POs.
3. Identify overdue supplier confirmations.
4. Identify approaching promised delivery dates.
5. Identify overdue deliveries.
6. Retrieve relevant supplier email history where available.
7. Understand the latest supplier response.
8. Draft an appropriate follow-up message.
9. Route the message through the configured approval policy.
10. Send automatically only where policy explicitly permits it.
11. Read incoming supplier responses.
12. Extract structured information such as:
   - confirmed delivery date;
   - quantity changes;
   - price changes;
   - partial shipment;
   - substitutions;
   - delays;
   - unavailable items.
13. Compare supplier information with the original PO.
14. Create exceptions when meaningful differences exist.
15. Recommend the next action.
16. Require human approval for sensitive or financially consequential actions.
17. Update the ERP/system through deterministic controlled execution where allowed.
18. Record all meaningful actions and decisions in the audit trail.

---

## What the MVP should NOT include

The first procurement MVP should not attempt to become a complete procurement platform.

Do not initially build:

- full source-to-pay;
- full RFQ marketplace;
- strategic sourcing suite;
- contract lifecycle management;
- supplier marketplace;
- payment infrastructure;
- corporate cards;
- complete AP replacement;
- full ERP replacement;
- broad autonomous negotiation.

These dramatically increase scope and place Legacy Intelligence directly against mature procurement suites.

The goal is to prove that an intelligence/action layer can remove repetitive operational work from an existing procurement process.

---

## Expansion path after validation

If PO Follow-up & Exception handling produces measurable ROI, expansion can proceed incrementally:

```text
PO Follow-up
    ↓
Supplier Exceptions
    ↓
Reorder Intelligence
    ↓
Supplier / Quote Comparison
    ↓
Invoice vs PO Matching
    ↓
Supplier Performance Intelligence
    ↓
Broader Procurement Operations Agent
```

Each expansion should be justified by customer evidence rather than by feature completeness.

---

## Competitive landscape and implications

### Didero

Didero is strategically important because its positioning overlaps strongly with the Legacy Intelligence thesis: AI agents operating across existing procurement systems and supplier communications rather than simply introducing another standalone system.

**Implication:** DBL cannot claim that the architectural idea of an AI layer above ERP is unique.

Potential differentiation should instead focus on the underserved SMB/mid-market segment, legacy/local/custom ERP compatibility, deployment flexibility, controlled execution, and potentially offline/local-first operation where required.

### Lio / Freehand and other agentic procurement vendors

These companies further validate willingness to invest in autonomous/agentic procurement operations.

**Implication:** market validation is strong, but the generic positioning "AI for procurement" will become increasingly weak as differentiation.

### Coupa / Ariba / broad P2P suites

Large suites demonstrate strong willingness to pay but can carry significant implementation complexity and feature breadth.

**Implication:** Legacy Intelligence should avoid competing feature-for-feature. Its value proposition should be incremental modernization rather than replacement.

### Precoro / Procurify and modern procurement SaaS

Modern mid-market procurement platforms already provide broad purchasing, approval, vendor, invoice, and related workflows.

**Implication:** DBL should not build another conventional procurement UI suite. It should automate work that currently occurs *between* the ERP, email, documents, employees, and suppliers.

### Microsoft Dynamics procurement agents

The addition of procurement-agent capabilities by a major ERP vendor validates workflows such as detecting unconfirmed/late purchase orders and preparing supplier follow-ups.

**Implication:** PO follow-up is a real agent workflow, but Legacy Intelligence should focus on heterogeneous and legacy environments rather than competing inside a single modern ERP ecosystem.

---

## Potential moat

"AI Agent" is not a moat.

Potential defensibility for Legacy Intelligence could come from the combination of:

1. Legacy and custom system connectivity.
2. Semantic normalization across different ERP/database schemas.
3. Controlled deterministic write-back.
4. Permission and approval policies independent of the LLM.
5. Auditable actions.
6. Reusable Industry Packs.
7. Fast adaptation to local/older systems that enterprise procurement platforms may not prioritize.
8. Offline/local-first capability where technically and commercially justified.
9. Accumulated mappings and workflow knowledge across similar distributors.

The long-term advantage should be the reusable modernization infrastructure, not one procurement prompt or model.

---

## Pricing hypothesis for validation

Pricing is not decided. Initial hypotheses to test with real prospects:

| Tier | Hypothesis |
|---|---:|
| Starter | ~$299/month |
| Operations | ~$599/month |
| Advanced | ~$999+/month |

A base-platform + usage model may fit better than per-seat pricing because the product is intended to sell operational output rather than software seats.

Example hypothesis:

> $399/month base + usage/operation volume.

These numbers are research hypotheses only and must not be treated as final pricing until customer discovery and willingness-to-pay testing are completed.

---

## ROI model

The product should sell measurable operational savings rather than "AI".

Example validation scenario:

- 3 procurement employees;
- approximately 2 hours/day each spent checking POs, chasing suppliers, reading emails, updating ERP/spreadsheets, and handling routine exceptions;
- approximately 22 working days/month.

This represents roughly 132 employee-hours/month.

If the workflow removes 60% of that repetitive workload, it returns approximately 79 hours/month before considering stockouts, delayed deliveries, purchasing mistakes, or discrepancy costs.

The actual ROI model must use customer-specific labor cost and operational-loss data.

### Key metrics to instrument

- manual hours avoided;
- POs monitored;
- supplier follow-ups automated/drafted;
- average confirmation time;
- overdue POs detected;
- exceptions detected;
- ERP updates completed;
- human approvals required;
- AI extraction correction rate;
- action failure rate;
- stockout/delay impact where measurable;
- monthly economic value generated.

---

## Build-time hypothesis

Assuming the reusable Legacy Intelligence core components exist or are developed as part of the main roadmap:

### Prototype

Approximately **10–14 days** for a constrained demonstration with sample/test data and limited integration.

### Customer-testable MVP

Approximately **4–6 weeks** for a narrow PO Follow-up & Exception workflow suitable for testing with a real distributor, depending heavily on connector maturity and the target ERP/database.

### Commercial hardening

Approximately **2–3 additional months** may be required after MVP validation for stronger reliability, onboarding, observability, connector robustness, permissions, security, deployment, and operational tooling.

These estimates are directional and should be recalculated against the actual implementation state of Legacy Intelligence before roadmap commitment.

---

## Main risks

### 1. Rapid competitive movement

Procurement AI is developing quickly. Generic AI procurement functionality will commoditize.

### 2. Integration complexity

Different legacy ERP schemas and deployment environments can destroy margins if every customer requires bespoke engineering.

**Mitigation:** build a reusable connector/mapping framework and measure onboarding effort as a core product metric.

### 3. AI reliability

Supplier emails can be ambiguous. Financial and operational updates cannot rely blindly on probabilistic interpretation.

**Mitigation:** deterministic validation, confidence thresholds, policy controls, human approval, and audit logs.

### 4. Scope explosion

Procurement contains many adjacent workflows that can turn the project into a full procurement suite.

**Mitigation:** maintain a strict wedge and require customer evidence before expansion.

### 5. Weak willingness to pay in very small companies

Some small distributors may have the pain but insufficient transaction volume or labor cost to justify the product.

**Mitigation:** validate the minimum PO/supplier/workload threshold that creates compelling ROI.

---

## Validation gates before roadmap promotion

Procurement Operations should not automatically replace the current roadmap merely because the market signals are promising.

Promote it from **candidate wedge** to **committed wedge** only after evidence such as:

1. Interviews with at least 10 relevant wholesalers/distributors.
2. At least 5 report frequent manual supplier/PO follow-up as a meaningful problem.
3. At least 3 are willing to provide sanitized workflow/data examples or participate in a pilot.
4. At least 2 demonstrate credible willingness to pay at a commercially useful price.
5. A prototype can integrate with one realistic legacy/current system without excessive custom work.
6. The workflow demonstrates measurable time savings or operational improvement.
7. Human approval and deterministic execution can keep material error risk acceptable.

These are validation targets, not proof already obtained.

---

## Strategic decision

**Current recommendation:**

Keep the broad Legacy Intelligence vision unchanged, but treat **Wholesalers/Distributors → Procurement Operations → PO Follow-up & Exceptions** as the leading candidate for a narrow commercial wedge.

Do not fork it into a separate DBL product at this stage.

Do not expand the core into procurement-specific architecture.

Build procurement-specific capabilities as an Industry/Workflow Pack on top of reusable Legacy Intelligence infrastructure.

The strongest strategic message remains:

> **Keep your existing system. Legacy Intelligence makes the operational layer around it intelligent, controlled, and actionable.**

---

## Research references captured during the 2026-09-01 study

These sources should be rechecked before future strategic decisions because pricing, product scope, and market positioning can change:

- Didero — company/product and 2026 Series A announcement: https://www.didero.ai/
- Lio — agentic procurement platform and 2026 Series A announcement: https://lio.ai/
- Freehand — AI teams for supply-chain spend: https://www.freehand.ai/
- Microsoft Dynamics 365 documentation — Procurement Agent supplier communication follow-up: https://learn.microsoft.com/en-us/dynamics365/supply-chain/procurement/procurement-agent-supplier-com-follow-up
- Precoro pricing: https://precoro.com/pricing
- Procurify pricing/product information: https://www.procurify.com/pricing/
- Coupa: https://www.coupa.com/

Community complaints and anecdotal reports observed during research should be treated as discovery signals, not as statistically representative market evidence.

---

## Related future research

The same market scan identified two additional opportunities with architectural overlap:

1. **Freight Operations Agent** — potential future Logistics/Freight Industry Pack.
2. **Accounting Exception Agent** — potential future Accounting/Finance Industry Pack operating above existing accounting/ERP systems.

These should remain secondary research opportunities while Procurement Operations receives deeper validation.
