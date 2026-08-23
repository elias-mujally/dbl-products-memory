# Legacy Intelligence — Decisions

## Accepted strategic decisions

1. Do not build a full ERP first.
2. Do not treat Offline + Arabic + AI as the primary moat.
3. Use local-first/offline operation as a baseline requirement for the initial market.
4. Target existing legacy/local systems instead of forcing migration.
5. Prefer wholesalers/distributors over tiny shops as the first ICP unless field evidence changes this.
6. Start read-only.
7. Start with one real legacy system.
8. Do not allow unrestricted LLM writes to customer databases.
9. Use typed actions, deterministic validation, permissions, preview, approval, execution, and audit.
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
