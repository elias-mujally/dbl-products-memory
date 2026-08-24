# Legacy Intelligence — Product Memory

هذا المجلد هو الذاكرة المرجعية لمبادرة **Local-First Legacy ERP Intelligence Layer** داخل DBL.

آخر مزامنة مع مستودع البناء: **2026-08-24**

## الحالة

**V1 BUILD IN PROGRESS — hardened read-only foundation + local intelligence/query stack + stable Application Service boundary implemented and merged.**

لم يعد المنتج مجرد concept أو strategic hypothesis. التنفيذ الفعلي جارٍ في:

`elias-mujally/dbl-legacy-intelligence`

وآخر milestone موثق ومندمج في `main` هو:

- PR #8 — V1 Application Service Boundary.
- Squash merge commit: `4d2e8fa59914c371c21b2176663dda38e39fd67f`.
- Final verified CI: Run #173 على Ubuntu وWindows.

## ابدأ من هنا

1. `AI_HANDOFF.md` — أسرع نقطة لفهم أين توقف البناء وما الذي لا يجب كسره.
2. `CURRENT_STATUS.md` — الحالة التنفيذية التفصيلية والميلستونات المندمجة.
3. `VISION.md` — الرؤية طويلة المدى.
4. `ROADMAP.md` — ما تم إنجازه وما تبقى من V1 ثم V2–V6.
5. `MARKET_STUDY_2026-08-21.md` — الدراسة السوقية المرجعية.
6. `MULTI_INDUSTRY_VISION_2026-08-21.md` — الرؤية متعددة القطاعات.
7. `DECISIONS.md` — القرارات الاستراتيجية المقبولة.

## الفكرة في سطر واحد

> **Make existing businesses intelligent without forcing them to rebuild their technology.**

طبقة ذكاء وتشغيل محلية، vendor-neutral، تُركب فوق الأنظمة القديمة أو المحلية وتضيف البحث والتحليل ثم الإجراءات والأتمتة تدريجيًا دون فرض migration كامل.

## أول Wedge

ابدأ بنظام قديم واحد حقيقي لدى موزع/تاجر جملة، Read-only وLocal-first، ثم وسّع تدريجيًا إلى Connectors وCanonical Business Model وSchema Intelligence وIndustry Packs.

الرؤية طويلة المدى متعددة القطاعات، لكن V1 تبقى ضيقة عمدًا ولا تحاول تنفيذ Pharma/Clinics/Industry Packs الآن.

## ما تم بناؤه فعليًا حتى الآن

داخل `main` في مستودع البناء توجد حاليًا:

1. Core contracts + Canonical Model.
2. Connector contract + mock connector.
3. Import Orchestrator.
4. Durable SQLite local storage.
5. Bounded/staged imports + recovery.
6. Persistent Audit.
7. Streaming SnapshotReader.
8. Deterministic Insight Engine يعمل بدون AI أو Internet.
9. Local Query Engine مع typed QueryPlan وclosed-world validation.
10. Shared exact decimal arithmetic.
11. V1 Application Service Boundary.
12. Pinned Application Read Scopes.
13. Runtime connector isolation على application boundary.
14. Explicit query/insight provenance.
15. Cross-platform CI على Ubuntu وWindows.

## المسار المعماري الحالي

من مصدر البيانات إلى المستهلك:

`Legacy ERP -> Connector -> Import Orchestrator -> SQLite -> SnapshotReader -> Query/Insight Engines -> Application Service -> UI/Reports/future AI`

Dependency direction للطبقات العليا:

`UI / Reports / future AI Planner -> Application Service -> pinned Read Scope -> Query/Insight Engines -> SnapshotReader -> LocalStore`

الـApplication Service أصبحت الحد الرسمي للقراءة. لا ينبغي بناء UI أو Reports أو AI Planner بمسارات موازية تصل مباشرة إلى SQLite أو تفاصيل المحركات الداخلية.

## Invariants أساسية لا يجب كسرها

- Offline/local-first للـcore operation.
- Read-only toward customer legacy systems في V1.
- No free-form SQL.
- Closed-world runtime validation للمدخلات غير الموثوقة.
- Currency-safe financial semantics ولا implicit FX.
- Exact decimal arithmetic.
- Streaming/bounded-memory behavior.
- Snapshot-bound pagination.
- Pinned read-scope consistency عبر عدة queries وpagination.
- Explicit connector/snapshot provenance.
- AI ليس execution authority.
- Strict package/runtime boundaries.
- Normal upper-layer reads تمر عبر Application Service.

## ماذا يعني Pinned Read Scope؟

`openReadScope({ connectorId })` تثبت committed snapshot واحدة عند الفتح. كل Query وInsight داخل نفس scope ترى نفس snapshot حتى لو حدث Import أحدث أثناء العمل.

هذا يمنع تقارير أو pagination من خلط لحظتين زمنيتين مختلفتين للبيانات.

## V1 الحالي باختصار

المستهدف ما زال:

- Local Windows application.
- Offline-first.
- Read-only connector لنظام حقيقي واحد في البداية.
- Products / Inventory / Customers / Sales.
- Arabic query/search experience.
- Basic reports.
- Deterministic insights.

غير داخل V1 حاليًا: Voice، WhatsApp، unrestricted write actions، multi-industry implementation، LAN/multi-process semantics.

## الفصل بين الذاكرة والكود

هذا المستودع هو **ذاكرة المنتج والقرارات والحالة الموثقة**، وليس مستودع التنفيذ.

- Product memory: `elias-mujally/dbl-products-memory/products/legacy-intelligence/`
- Build repository: `elias-mujally/dbl-legacy-intelligence`

عند أي جلسة جديدة: تحقق من مستودع البناء قبل ادعاء أن Capability منفذة، ثم حدّث `CURRENT_STATUS.md` و`AI_HANDOFF.md` و`README.md` و`ROADMAP.md` عند تغير milestone رئيسي.
