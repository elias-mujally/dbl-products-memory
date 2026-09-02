# Legacy Intelligence — Roadmap

آخر مزامنة مع حالة المنتج والأدلة: **2026-09-02**

## المرحلة الحالية

**V1 BUILD IN PROGRESS — Motakamel Plus Evidence Acquisition is active; installation, provisioning, launch, and pre-login baseline are proven.**

آخر نقطة تنفيذية موثقة:

- PR #10 — Close canonical validation against silent field loss.
- Squash merge commit: `95bf225e1523e0fd0f72cdf3da8393df18d635cc`.
- Final verified PR CI: Run #194 passed on Ubuntu and Windows.

## V1 — First real system / demo-ready

**الحالة: IN PROGRESS**

### تم إنجازه ✅

#### Foundation / Core

- [x] Core contracts + initial Canonical Model.
- [x] Connector contract + mock connector.
- [x] Import Orchestrator.
- [x] Durable local SQLite storage.
- [x] Bounded batched imports.
- [x] Staging + crash recovery/cleanup.
- [x] Runtime connector validation.
- [x] Mechanical migration checksum/drift detection.
- [x] SQLite V1 semantics موثقة كـsingle-writer desktop store.
- [x] Exact-key closed-world validation على persisted canonical objects.
- [x] Unknown canonical fields fail with stable `UNKNOWN_CANONICAL_FIELD` بدل silent loss.

#### Audit / Deterministic Intelligence

- [x] Persistent SQLite Audit Sink.
- [x] Runtime audit validation.
- [x] Streaming SnapshotReader.
- [x] Deterministic Insight Engine يعمل بدون AI/Internet.
- [x] Low Stock / Outstanding Receivables / Sales Summary foundation.
- [x] Shared exact decimal arithmetic.
- [x] Currency-safe financial semantics.

#### Local Query Foundation

- [x] Typed `QueryPlan 1.0.0`.
- [x] Product / Customer / Sale query support.
- [x] Closed-world query validation.
- [x] No free-form SQL.
- [x] Bounded filters and page sizes.
- [x] Streaming query execution.
- [x] Snapshot-bound cursor pagination.
- [x] Query fingerprint binding.
- [x] Money filters require amount + currency.

#### V1 Application Boundary

- [x] Stable `@dbl/application-service` read boundary.
- [x] `openReadScope({ connectorId })`.
- [x] Pinned snapshot consistency across queries/pages.
- [x] Runtime connector isolation.
- [x] Explicit query/insight provenance.
- [x] Runtime-frozen scope/provenance envelopes.

#### Real Connector Foundation

- [x] `@dbl/connector-test-kit` real-connector contract validation/acceptance harness.
- [x] Explicit `accepted` / `smoke-passed` / `rejected` semantics.
- [x] Smoke runs cannot produce full contract acceptance.
- [x] Observed capability evidence.
- [x] Strict representative-fixture capability certification option.
- [x] Read-only batched Reference SQLite Legacy Connector.
- [x] `readonly + fileMustExist + query_only` protection for reference SQLite.
- [x] Lifecycle-neutral health probe.
- [x] Keyset source paging.
- [x] SQL legacy mapping proof for Products / Inventory / Customers / Sales fixture data.
- [x] Pinned SQLite read snapshot with concurrent-write coverage.
- [x] Early stream cancellation cleanup/restart coverage.
- [x] Invoice-line batch loading with bounded chunking instead of N+1 per invoice.
- [x] End-to-end reference path through Import -> DBL SQLite -> Application Service -> Query/Insights.
- [x] Database-specific isolation rule documented: no portable SQL snapshot assumption.

#### Independent Architecture Review / Remediation

- [x] Independent package-by-package architecture red-team review completed.
- [x] Verdict: targeted fixes, not re-architecture.
- [x] Product/structural correctness distinguished from business semantic correctness.
- [x] Phase 0 reduced to one actual defect only.
- [x] PR #10 merged to close silent canonical field loss.
- [x] No generic abstractions added during remediation.

#### Engineering Quality

- [x] Locked `npm ci` workflow.
- [x] Runtime build.
- [x] Strict TypeScript typecheck.
- [x] Automated tests.
- [x] Cross-platform CI on Ubuntu and Windows.
- [x] PR #9 CI #192 green on both platforms.
- [x] PR #10 CI #194 green on both platforms.

### First Connector Target ✅

- [x] Primary target selected: **YemenSoft Motakamel Plus ERP**.
- [x] Decision remains conditional on obtaining valid evidence for an exact product/version/schema.
- [x] Do not build generic `YemenSoftConnector`.
- [x] Do not treat AlMuhaseb1/Access schema as a substitute for Motakamel Plus.
- [x] Real `EFA6_EDU` educational package obtained and installed in an isolated Windows VM.
- [x] Official provisioning reproduced and completed; Motakamel reaches its normal login screen.
- [x] Pre-login path `GL.exe → YsEDU → FMMA → Multi_Lang` proven.
- [x] `FMMA` rejected as an assumed connector identity because it is a privileged `sysadmin`/`dbcreator` login.

### Next immediate gate: Motakamel Plus Evidence Acquisition ⏳

Before connector coding, produce:

- [ ] System and Version Profile — `PARTIAL`: product/install/OS/SQL/pre-login profile proven; modules, customization, and schema version unresolved.
- [ ] Read-only Access & Isolation Record — `PARTIAL`: disposable isolation proven; separate least-privilege read-only identity and DB enforcement not yet proven.
- [ ] Source Schema Inventory.
- [ ] Mapping Evidence Table.
- [ ] Reconciliation Baseline.
- [ ] Unsupported / Unresolved Semantics List — `PARTIAL`.
- [ ] Dataset Size & Performance Profile — `PARTIAL`: engine/database baseline only.
- [ ] Exact V1 Connector Scope Decision — `PARTIAL`: target retained; exact supported semantics unresolved.

Evidence acquisition should determine:

- [ ] Exact installer/product version/build.
- [ ] SQL Server version/edition/instance/database.
- [ ] Compatibility level + collation + authentication mode.
- [ ] DB-enforced read-only principal/grants/session options.
- [ ] snapshot/isolation behavior under concurrent writes.
- [ ] tables/columns/types/nullability.
- [ ] PK/FK/indexes/views/computed fields.
- [ ] Products / Inventory / Customers / Sales relationships.
- [ ] branch/warehouse/currency/UOM structures if actually present.
- [ ] document status/type dictionaries.
- [ ] returns/cancellations/sign conventions.
- [ ] local/fiscal timezone semantics.
- [ ] source row counts and representative totals.
- [ ] official reports/golden records for reconciliation.
- [ ] largest tables, DB size, history range, invoice-line distribution, representative query durations.

### Evidence-driven Foundation Changes ⏳

Only after Motakamel evidence:

- [ ] Add smallest necessary Canonical Model delta, if any.
- [ ] Define deterministic source timezone policy.
- [ ] Define Motakamel-specific snapshot identity strategy.
- [ ] Define page/chunk sizes from observed indexes/data.
- [ ] Adjust Query/Insight semantics only where source evidence requires it.
- [ ] Add optimized query path only if measurements prove the current path insufficient.

Do **not** pre-add warehouse/status/returns/tax/UOM/branch fields just because they are common ERP concepts.

### MotakamelPlusConnector Implementation ⏳

Connector is not done until:

- [ ] Supported product/schema version is explicit.
- [ ] Read-only enforcement is proven outside connector metadata.
- [ ] SQL Server-specific isolation behavior is tested under concurrent writes.
- [ ] Every emitted canonical field has mapping evidence.
- [ ] Unresolved critical semantics = zero.
- [ ] Contract conformance succeeds exhaustively.
- [ ] Reconciliation counts/totals match or every difference is explicitly justified.
- [ ] Unsupported cases fail or are excluded explicitly.
- [ ] Import -> SQLite -> Application Service -> Query/Insights succeeds end-to-end.
- [ ] Cancellation/cleanup/restart behavior is proven.
- [ ] Windows handle lifecycle is proven.
- [ ] Representative runtime/memory stays within agreed budgets.
- [ ] No accidental N+1/unbounded child allocation.
- [ ] No source mutation required for normal V1 operation.

### Connector Readiness model

For the first market connector, distinguish conceptually:

1. **Contract Conformance** — generic test-kit level.
2. **Semantic Reconciliation** — system/version/dataset-specific evidence.
3. **Operational Qualification** — permissions, isolation, cancellation, Windows lifecycle, performance/resource behavior.

Do not create three generic packages/APIs just to mirror these labels.

### Before First Pilot ⏳

- [ ] Clarify test-kit/report terminology so contract `accepted` is not mistaken for production-ready.
- [ ] Completed semantic reconciliation.
- [ ] Cancellation/deadline behavior for long operations.
- [ ] UI responsiveness/non-blocking verification.
- [ ] Snapshot retention/disk policy OR disable unbounded recurring imports.
- [ ] Storage schema-too-new fail-fast guard.
- [ ] Local cache/config/audit backup/restore procedure.
- [ ] Secure credentials/config handling.
- [ ] Packaging + clean-machine install verification.
- [ ] Recovery after interrupted import/restart.
- [ ] Representative performance qualification.
- [ ] Required business questions proven correct on Motakamel data.
- [ ] Branch/release protection appropriate for pilot/release.

### Demo surface بعد ثبات connector الحقيقي

- [ ] Basic Reporting فوق Application Service.
- [ ] Arabic query/search experience فوق Application Service.
- [ ] Local Windows application shell / UI بسيطة قابلة للعرض.
- [ ] End-to-end demo على Motakamel/legacy data حقيقية.
- [ ] Packaging/installability للعرض المحلي على Windows.
- [ ] مراجعة V1 كاملة قبل إعلان Demo-ready.

### حدود V1 التي لا نوسعها الآن

- Read-only toward customer legacy systems.
- Offline-first/local operation.
- Connector سوقي حقيقي واحد في البداية.
- لا Voice.
- لا WhatsApp.
- لا unrestricted write actions.
- لا Multi-industry implementation.
- لا LAN/multi-process assumption فوق SQLite الحالية.
- لا Generic SQL Schema Inspector.
- لا Universal SQL Connector.
- لا AI semantic mapping قبل evidence من النظام الأول.
- لا Generic Mapping DSL قبل repeated integration evidence.

### المسار المعماري الرسمي

`UI / Reports / future AI Planner -> Application Service -> pinned Read Scope -> Query/Insight Engines -> SnapshotReader -> LocalStore`

مسار ingest:

`Legacy ERP -> System-specific read-only Connector -> Import Orchestrator -> LocalStore`

## V2 — Mapping Separation

**NOT STARTED — intentionally deferred until evidence from first real market integration.**

- فصل mapping فقط بعد رؤية ما يتكرر فعليًا.
- جعل mapping artifacts قابلة للاختبار وإعادة الاستخدام عند وجود evidence.
- compatibility/version handling مبني على أكثر من installation/version.

## V3 — Generic SQL Schema Inspector

**NOT STARTED.**

- tables / columns / relationships / data types.
- safe metadata collection.
- connector diagnostics.
- لا يبدأ قبل المعرفة المكتسبة من V1/V2.

## V4 — AI-assisted Semantic Mapping

**NOT STARTED.**

- semantic suggestions.
- confidence/human confirmation.
- deterministic validation remains authoritative.

## V5 — Capability Detection

**NOT STARTED.**

- Business Capability Map.
- capability activation from proven schema/semantics.

## V6 — Industry Packs

**NOT STARTED.**

- Industry-specific actions/analytics/views/rules.
- Core sector-agnostic قدر الإمكان، specialization evidence-driven.

## ما بعد إثبات Read-only Foundation

Controlled Actions وOffline Agent جزء من الرؤية لاحقًا:

`Typed Action -> Validation -> Permission/Policy -> Preview -> Approval -> Deterministic Execution -> Audit`

AI لا يصبح execution authority.

## قاعدة التنفيذ

**Implement first, abstract second.**

الخطوة التالية الوحيدة هي إكمال **Read-only Access & Isolation Record** في disposable Motakamel VM بهوية SQL منفصلة بأقل الصلاحيات. لا يبدأ schema mapping أو connector coding أو abstraction عامة قبل إغلاق هذا الـgate.
