# Legacy Intelligence — Roadmap

آخر مزامنة مع مستودع البناء: **2026-08-24**

## المرحلة الحالية

**V1 BUILD IN PROGRESS — first actual market connector is the next gate.**

تم دمج خمس milestones هندسية رئيسية في `main` داخل `elias-mujally/dbl-legacy-intelligence`.

آخر نقطة تنفيذية موثقة:

- PR #9 — V1 Real Connector Foundation + SQL Reference Adapter.
- Squash merge commit: `5028dc48db331574168c2658afee2c8206913a52`.
- Final verified CI: Run #192 passed on Ubuntu and Windows.

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

#### Audit / Deterministic Intelligence

- [x] Persistent SQLite Audit Sink.
- [x] Runtime audit validation.
- [x] Streaming SnapshotReader.
- [x] Deterministic Insight Engine يعمل بدون AI/Internet.
- [x] Low Stock / Outstanding Receivables / Sales Summary.
- [x] Shared exact decimal arithmetic.
- [x] Currency-safe financial semantics.

#### Local Query Foundation

- [x] Typed `QueryPlan 1.0.0`.
- [x] Product / Customer / Sale query support.
- [x] Closed-world runtime validation.
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

- [x] `@dbl/connector-test-kit` real-connector validation/acceptance harness.
- [x] Explicit `accepted` / `smoke-passed` / `rejected` semantics.
- [x] Smoke runs cannot produce full acceptance.
- [x] Observed capability evidence.
- [x] Strict representative-fixture capability certification option.
- [x] Read-only batched Reference SQLite Legacy Connector.
- [x] `readonly + fileMustExist + query_only` source protection for reference SQLite.
- [x] Lifecycle-neutral health probe with no retained source handle.
- [x] Keyset source paging.
- [x] SQL legacy mapping proof for Products / Inventory / Customers / Sales fixture data.
- [x] Pinned SQLite read snapshot with concurrent-write coverage.
- [x] Early stream cancellation cleanup/restart coverage.
- [x] Invoice-line batch loading with bounded chunking instead of N+1 per invoice.
- [x] End-to-end real SQL reference path through Import -> DBL SQLite -> Application Service -> Query/Insights.
- [x] Database-specific isolation rule documented: no portable SQL snapshot assumption.

#### Engineering Quality

- [x] Locked `npm ci` workflow.
- [x] Runtime build.
- [x] Strict TypeScript typecheck.
- [x] Automated tests.
- [x] Cross-platform CI on Ubuntu and Windows.
- [x] Final PR #9 CI Run #192 green on both platforms.

### ما تبقى للوصول إلى V1 demo-ready ⏳

#### Next immediate gate: first actual market connector

- [ ] اختيار أول legacy ERP/accounting system حقيقي.
- [ ] الحصول على schema sample أو sanitized local database.
- [ ] تحديد exact source schema/version.
- [ ] توثيق field-level mapping بالدليل الحقيقي.
- [ ] تثبيت Products / Inventory / Customers / Sales المطلوبة على representative data.
- [ ] تحديد واختبار database-enforced read-only credentials/session/mode.
- [ ] توثيق واختبار snapshot/isolation semantics الخاصة بمحرك قاعدة النظام.
- [ ] تنفيذ system-specific connector، بدون generic abstraction مبكر.
- [ ] Exhaustive acceptance/certification عبر connector test kit.
- [ ] Representative-dataset performance test وعدم وجود accidental N+1 shapes.
- [ ] End-to-end import إلى DBL SQLite ثم Query/Insights/Application Service.
- [ ] Windows close/restart behavior على connector الحقيقي.

#### Demo surface بعد/بالتوازي مع ثبات connector الحقيقي

- [ ] Basic Reporting فوق Application Service.
- [ ] Arabic query/search experience فوق Application Service.
- [ ] Local Windows application shell / UI بسيطة قابلة للعرض.
- [ ] End-to-end demo على بيانات/نظام legacy حقيقي.
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
- لا Generic SQL Schema Inspector أو AI semantic mapping قبل evidence من النظام الأول.

### المسار المعماري الذي يجب البناء فوقه

`UI / Reports / future AI Planner -> Application Service -> pinned Read Scope -> Query/Insight Engines -> SnapshotReader -> LocalStore`

مسار ingest:

`Legacy ERP -> System-specific read-only Connector -> Import Orchestrator -> LocalStore`

## V2 — Mapping Separation

**الحالة: NOT STARTED — intentionally deferred until evidence from first real market integration.**

- فصل schema mapping عن connector implementation بعد رؤية ما يتكرر فعليًا.
- جعل mapping artifact قابلًا للاختبار وإعادة الاستخدام.
- تحسين compatibility/version handling.

## V3 — Generic SQL Schema Inspector

**الحالة: NOT STARTED.**

- اكتشاف tables / columns / relationships / data types.
- metadata collection آمن.
- connector diagnostics.
- يبنى فوق المعرفة المكتسبة من V1/V2.

## V4 — AI-assisted Semantic Mapping

**الحالة: NOT STARTED.**

- اقتراح معنى الجداول والحقول.
- confidence scores.
- human confirmation.
- AI يقترح، deterministic validation/human confirmation يحكمان الاعتماد.

## V5 — Capability Detection

**الحالة: NOT STARTED.**

- Business Capability Map.
- اكتشاف القدرات حسب schema الموثق.
- تفعيل الأدوات المناسبة فقط.

## V6 — Industry Packs

**الحالة: NOT STARTED.**

- Industry-specific actions, analytics, views, rules.
- Core sector-agnostic قدر الإمكان، والتخصص في packs المبنية على evidence.

## ما بعد إثبات Read-only Foundation

Controlled Actions وOffline Agent جزء من الرؤية، لكنهما ليسا سببًا لتوسيع V1 الآن.

المسار المستقبلي:

`Typed Action -> Validation -> Permission/Policy -> Preview -> Approval -> Deterministic Execution -> Audit`

AI لا يصبح execution authority.

## قاعدة التنفيذ

**Implement first, abstract second.**

الـReference SQLite connector ليس أول market connector ولا يعني أن V1 انتهت. وظيفته إثبات mechanics/gates. الآن يجب أخذ نظام حقيقي وتطبيق هذه القواعد عليه، ثم فقط استخراج abstraction عندما يظهر تكرار حقيقي.

ولا نهدم invariants التي تم دفع ثمنها بالمراجعات والاختبارات فقط لتسريع Feature مرئية.