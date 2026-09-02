# Legacy Intelligence — Decisions

## Accepted strategic and architectural decisions

1. Do not build a full ERP first.
2. Do not treat Offline + Arabic + AI as the primary moat.
3. Use local-first/offline operation as a baseline requirement for the initial market.
4. Target existing legacy/local systems instead of forcing migration.
5. Prefer wholesalers/distributors over tiny shops as the first ICP unless field evidence changes this.
6. Start read-only.
7. Start with one real legacy system.
8. Do not allow unrestricted LLM writes to customer databases.
9. Use typed actions, deterministic validation, permissions, preview, approval, execution, and audit for future write/control layers.
10. Treat connector knowledge and business semantics as strategic assets.
11. Keep cloud optional for core local operation.
12. Move toward full replacement only if customer behavior pulls the product there.
13. Keep the long-term product sector-agnostic at the core while using narrow vertical Industry Packs.
14. Build reusable abstractions only after repeated evidence from real integrations.
15. Long-term objective: a Universal Legacy Intelligence Runtime that can inspect, map, understand, and activate capabilities for smaller systems with human confirmation where confidence is insufficient.
16. The Agent must remain usable offline even without AI by providing a deterministic library of ready-made parameterized commands.
17. AI is an optional intent/analysis layer, not the execution authority. The deterministic Agent executes structured actions.
18. Commands can expose editable parameters such as quantity, date range, branch, warehouse, supplier, customer, threshold, product selection, output format, and print destination.
19. Every executable action must have a sensitivity/risk level, with approval requirements determined by both action type and context.
20. Read and report-generation actions can be low-risk; purchase requests and higher-impact operations require explicit employee confirmation or authorized approval.
21. High-value or sensitive actions may require multiple approvals. The Policy Engine, not the AI model, determines whether execution is allowed.
22. Future Agent functionality is intended to be sold as a subscription, not as a perpetual entitlement bundled permanently with the base product.
23. Offline subscriptions should support locally verifiable signed entitlements/licenses with expiry and feature flags so customers do not need permanent internet access.
24. Keep V1 read-only toward customer legacy systems. Controlled actions and Agent execution are later layers, not a reason to expand V1 scope prematurely.
25. Keep SQLite as the V1 local store unless real workload evidence disproves it; do not replace it preemptively.
26. Keep the Application Service as the normal upper-layer read boundary; normal UI/report/future-AI reads do not bypass it.
27. Keep pinned read scopes because multi-query reports/pagination must remain snapshot-consistent.
28. Keep no-free-form-SQL as a core safety rule; future AI may produce typed plans/actions, not arbitrary SQL execution authority.
29. Treat source database isolation semantics as connector/database-specific evidence, never as a portable SQL assumption.
30. Treat exact decimal and currency-bound Money semantics as non-negotiable financial invariants; no implicit FX.
31. Closed-world canonical validation means persisted canonical objects must reject unknown fields rather than silently drop them. PR #10 enforces this with exact-key validation.
32. Do not expand the Canonical Model using generic ERP expectations alone. Add the smallest field/semantic delta only when a real integration proves it necessary.
33. Contract conformance is not equivalent to business/accounting correctness or production readiness.
34. For a real connector, readiness must be established conceptually across three evidence dimensions: Contract Conformance, Semantic Reconciliation, and Operational Qualification.
35. Do not turn those three readiness dimensions into a generic orchestration framework or multiple packages before real evidence requires it.
36. Semantic reconciliation for each connector/version must be system-specific and evidence-based: mapping sources, joins, filters, statuses, returns/cancellations, sign conventions, currencies, timezone, null/default policies, exclusions, source counts/totals, and traceable golden records.
37. Connector test-kit `accepted` should be understood as acceptance at the contract-conformance gate, not by itself as production readiness.
38. Evidence Acquisition may proceed before every pre-pilot hardening task; do not delay schema/sample discovery for unrelated cleanup.
39. The only foundation defect identified as independent enough to fix before Motakamel evidence was canonical silent field loss; it was fixed in PR #10.
40. Do not proactively fix or redesign reference-only performance patterns unless they directly affect the first market connector or measurements prove a need.
41. Resource budgets, source paging/chunking, snapshot identity, incremental strategy, retention, query optimization, and Arabic normalization should be decided from representative Motakamel data/use cases, not guessed in advance.
42. Before the first pilot, long operations must have a clear cancellation/deadline story, UI responsiveness must be verified, and unbounded recurring full-history imports must be prevented by retention/disk policy or by keeping imports manual/bounded.
43. First Connector Target is currently **YemenSoft Motakamel Plus ERP**, conditional on obtaining evidence for an exact product/version/schema and feasible read-only access.
44. Do not build a generic `YemenSoftConnector`. The first adapter is Motakamel Plus system/version-specific.
45. Do not treat old YemenSoft Access products or Motakamel variants as schema substitutes for Motakamel Plus. Cross-product similarities are evidence only after direct verification.
46. Before Motakamel connector coding, produce a System/Version Profile, Read-only & Isolation Record, Source Schema Inventory, Mapping Evidence Table, Reconciliation Baseline, Unsupported/Unresolved Semantics List, Dataset Size & Performance Profile, and Exact V1 Connector Scope Decision.
47. Generic Mapping DSL, automatic schema inspector, universal SQL dialect layer, AI semantic mapping, generic incremental framework, generic query pushdown, package consolidation, and Audit redesign remain explicitly deferred until evidence justifies them.
48. The independent architecture review of 2026-08-25 is accepted as a directional checkpoint: **targeted fixes, not re-architecture**.
49. Motakamel Plus remains the **Primary First Connector Target** after direct installation/provisioning evidence; AlMuhaseb1 remains an acquisition/evidence lab and is not a replacement target or schema proxy.
50. `FMMA` must not be assumed to be a suitable DBL connector identity. It is an application SQL login with proven `sysadmin` and `dbcreator` membership; connector access requires a separately proven least-privilege, database-enforced read-only identity.
51. Successful Motakamel provisioning and arrival at the normal login screen establish system reachability, not connector readiness. The eight evidence artifacts remain authoritative gates; do not change the Canonical Model or begin Motakamel connector coding until the relevant evidence justifies it.
