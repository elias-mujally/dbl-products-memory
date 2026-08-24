# Legacy Intelligence — Roadmap

آخر مزامنة مع مستودع البناء: **2026-08-24**

## المرحلة الحالية

**V1 BUILD IN PROGRESS.**

مرحلة `Pre-build validation + architecture definition` انتهت. المنتج دخل التنفيذ الفعلي، وتم بالفعل دمج أربع milestones هندسية رئيسية في `main` داخل:

`elias-mujally/dbl-legacy-intelligence`

آخر نقطة تنفيذية موثقة:

- PR #8 — V1 Application Service Boundary.
- Merge commit: `4d2e8fa59914c371c21b2176663dda38e39fd67f`.
- Final verified CI: Run #173 passed on Ubuntu and Windows.

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
- [x] Initial deterministic rules: Low Stock / Outstanding Receivables / Sales Summary.
- [x] Presentation-neutral insight output.
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
- [x] `openReadScope({ connectorId })` entry point.
- [x] Pinned snapshot consistency across multiple queries.
- [x] Pagination remains on original snapshot after newer imports.
- [x] Runtime connector isolation at application boundary.
- [x] Explicit query provenance.
- [x] Explicit application-level insight provenance.
- [x] Runtime-frozen scope/context/provenance envelopes.
- [x] UI/Reports/future AI have a stable boundary above query/insight engines.

#### Engineering Quality

- [x] Locked `npm ci` workflow.
- [x] Runtime build.
- [x] Strict TypeScript typecheck.
- [x] Automated tests.
- [x] Cross-platform CI on Ubuntu and Windows.

### ما تبقى للوصول إلى V1 demo-ready ⏳

- [ ] أول **Connector حقيقي** لنظام legacy فعلي بدل mock فقط.
- [ ] تثبيت/توسيع mapping الفعلي لذلك النظام إلى Canonical Model حسب البيانات الحقيقية.
- [ ] تغطية Products / Inventory / Customers / Sales المطلوبة من النظام الأول فعليًا.
- [ ] بناء Basic Reporting فوق Application Service.
- [ ] بناء Arabic query/search experience فوق Application Service.
- [ ] Local Windows application shell / UI بسيطة قابلة للعرض.
- [ ] End-to-end demo على بيانات/نظام legacy حقيقي.
- [ ] Packaging/installability المناسبة للعرض المحلي على Windows.
- [ ] مراجعة V1 كاملة قبل إعلان Demo-ready.

### حدود V1 التي لا نوسعها الآن

- Read-only toward customer legacy systems.
- Offline-first/local operation.
- Connector حقيقي واحد في البداية.
- لا Voice.
- لا WhatsApp.
- لا unrestricted write actions.
- لا Multi-industry implementation.
- لا LAN/multi-process assumption فوق SQLite الحالية.

### المسار المعماري الذي يجب البناء فوقه

`UI / Reports / future AI Planner -> Application Service -> pinned Read Scope -> Query/Insight Engines -> SnapshotReader -> LocalStore`

أي Feature جديدة للقراءة يجب ألا تتجاوز Application Service إلى SQLite أو engine internals لمجرد السرعة في التنفيذ.

### تقدير V1

التقدير الأصلي قبل التنفيذ كان **3–5 أسابيع بعد بدء التنفيذ الفعلي**. لا نعيد ضبطه تلقائيًا اعتمادًا على التقويم فقط؛ بعد دخول البناء الفعلي، المرجع الأدق هو قائمة المتبقي أعلاه وحجم أول Connector/النظام الحقيقي. يعاد تقدير Demo-ready عند اختيار النظام الحقيقي ومعرفة schema وحجم mapping المطلوب.

---

## V2 — Mapping Separation

**الحالة: NOT STARTED — intentionally deferred until evidence from first real integration.**

- فصل schema mapping عن connector implementation.
- جعل mapping artifact قابلًا للاختبار وإعادة الاستخدام.
- تحسين compatibility/version handling.
- لا نقوم بتجريد عام مبكرًا قبل أن يعطينا أول Connector حقيقي أدلة كافية.

**التقدير التراكمي الأصلي:** 5–7 أسابيع.

---

## V3 — Generic SQL Schema Inspector

**الحالة: NOT STARTED.**

- اكتشاف tables / columns / relationships / data types.
- metadata collection آمن.
- connector diagnostics.
- البناء فوق المعرفة المكتسبة من V1/V2 بدل محاولة دعم كل SQL schemas مسبقًا.

**التقدير التراكمي الأصلي:** 8–11 أسبوعًا.

---

## V4 — AI-assisted Semantic Mapping

**الحالة: NOT STARTED.**

- اقتراح معنى الجداول والحقول.
- confidence scores.
- human confirmation.
- عدم الاعتماد على AI وحده في business semantics الحساسة.
- AI يقترح، deterministic validation/human confirmation يحكمان الاعتماد.

**التقدير التراكمي الأصلي:** 12–16 أسبوعًا.

---

## V5 — Capability Detection

**الحالة: NOT STARTED.**

- بناء Business Capability Map.
- اكتشاف قدرات مثل Sales / Inventory / Purchasing / Receivables / Patients / Appointments حسب schema الموثق.
- تفعيل الأدوات المناسبة فقط.

**التقدير التراكمي الأصلي:** 16–21 أسبوعًا.

---

## V6 — Industry Packs

**الحالة: NOT STARTED.**

- Industry-specific actions, analytics, views, rules.
- أول packs مرشحة: Distribution/Retail، ثم Pharma، ثم Clinic Operations أو قطاعات أخرى حسب الدليل السوقي.
- اختبار onboarding شبه عام لأنظمة متعددة.
- Core يبقى sector-agnostic قدر الإمكان، والتخصص يتركز في packs المبنية على evidence.

**التقدير التراكمي الأصلي:** 22–30 أسبوعًا.

---

## ما بعد إثبات Read-only Foundation

Controlled Actions وOffline Agent جزء من الرؤية، لكنهما ليسا سببًا لتوسيع V1 الآن.

عند الانتقال لهما يجب الحفاظ على:

`Typed Action -> Validation -> Permission/Policy -> Preview -> Approval -> Deterministic Execution -> Audit`

AI لا يصبح execution authority.

## تحسينات تقنية مؤجلة عمدًا

هذه ليست blockers لـV1 الحالية:

- Predicate/seek pushdown لتحسين deep pagination والبحث الواسع.
- Signed/opaque cursors عندما تعبر cursor حدود API غير موثوقة.
- Persisted/cross-process read-scope tokens إذا ظهر use case حقيقي.
- LAN/multi-process storage semantics تحتاج تصميمًا جديدًا، ولا تُبنى بافتراض أن SQLite desktop الحالية تكفي.

## قاعدة التنفيذ

لا تنتظر V6 للبيع. الهدف أن تكون V1 قابلة للعرض، ثم pilot حقيقي، ثم paid pilot بمجرد ثبات القيمة والأمان.

والقاعدة الأهم أثناء إكمال V1:

**لا نهدم invariants التي تم دفع ثمنها بالمراجعات والاختبارات فقط لتسريع Feature مرئية.** الواجهة والتقارير والـAI القادمة تبنى فوق الأساس الحالي، لا حوله.
