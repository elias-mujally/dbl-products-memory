# Legacy Intelligence — Product Memory

هذا المجلد هو الذاكرة المرجعية لمبادرة **Local-First Legacy ERP Intelligence Layer** داخل DBL.

آخر مزامنة مع مستودع البناء: **2026-08-25**

## الحالة

**V1 BUILD IN PROGRESS — hardened read-only foundation merged; first actual market connector evidence acquisition is now the active gate.**

مستودع التنفيذ:

`elias-mujally/dbl-legacy-intelligence`

آخر milestone مدموج في `main`:

- PR #10 — Close canonical validation against silent field loss.
- Squash merge commit: `95bf225e1523e0fd0f72cdf3da8393df18d635cc`.
- Final verified PR CI before merge: Run #194 على Ubuntu وWindows.

PR #10 أغلق defect حقيقيًا في الـclosed-world canonical boundary: unknown canonical fields لم تعد تمر validation ثم تختفي بصمت أثناء SQLite persistence/fingerprinting.

## ابدأ من هنا

1. `AI_HANDOFF.md` — أسرع نقطة لفهم أين توقف البناء وما الذي لا يجب كسره.
2. `CURRENT_STATUS.md` — الحالة التنفيذية والميلستونات الحالية.
3. `ARCHITECTURE_REVIEW_2026-08-25.md` — خلاصة المراجعة المعمارية المستقلة وخطة remediation المقبولة.
4. `FIRST_CONNECTOR_TARGET_2026-08-25.md` — قرار First Connector Target وخطة Evidence Acquisition.
5. `VISION.md` — الرؤية طويلة المدى.
6. `ROADMAP.md` — ما تم وما تبقى من V1 ثم V2–V6.
7. `MARKET_STUDY_2026-08-21.md` — الدراسة السوقية المرجعية السابقة.
8. `MULTI_INDUSTRY_VISION_2026-08-21.md` — الرؤية متعددة القطاعات.
9. `DECISIONS.md` — القرارات الاستراتيجية والمعمارية المقبولة.

## الفكرة في سطر واحد

> **Make existing businesses intelligent without forcing them to rebuild their technology.**

طبقة ذكاء وتشغيل محلية، vendor-neutral، تُركب فوق الأنظمة القديمة أو المحلية وتضيف البحث والتحليل ثم الإجراءات والأتمتة تدريجيًا دون فرض migration كامل.

## First Wedge الحالي

الهدف السوقي الأول المختار حاليًا هو **YemenSoft Motakamel Plus ERP**، بشرط evidence acquisition ناجحة على إصدار/Schema حقيقي محدد.

لا نبني `YemenSoftConnector` عامًا ولا نفترض تشابه كل الإصدارات. أول adapter يجب أن يكون system/version-specific بناءً على schema/sample/sanitized database حقيقية.

## ما تم بناؤه فعليًا حتى الآن

داخل `main` توجد حاليًا:

1. Core contracts + initial Canonical Model.
2. Connector contract + mock connector.
3. Import Orchestrator.
4. Durable SQLite local storage.
5. Bounded/staged imports + recovery.
6. Persistent Audit.
7. Streaming SnapshotReader.
8. Deterministic Insight Engine يعمل بدون AI أو Internet.
9. Local Query Engine مع typed QueryPlan.
10. Shared exact decimal arithmetic.
11. V1 Application Service Boundary.
12. Pinned Application Read Scopes.
13. Runtime connector isolation على application boundary.
14. Explicit query/insight provenance.
15. Real Connector contract validation/acceptance harness.
16. Read-only batched Reference SQLite Legacy Connector.
17. Proven SQL-to-canonical reference path.
18. Exact-key closed-world validation للـcanonical persisted boundary.
19. Stable `UNKNOWN_CANONICAL_FIELD` rejection بدل silent field loss.
20. Cross-platform CI على Ubuntu وWindows.

## المسار المعماري الحالي

`Legacy ERP -> System-specific Connector -> Import Orchestrator -> SQLite -> SnapshotReader -> Query/Insight Engines -> Application Service -> UI/Reports/future AI`

Dependency direction للطبقات العليا:

`UI / Reports / future AI Planner -> Application Service -> pinned Read Scope -> Query/Insight Engines -> SnapshotReader -> LocalStore`

الـApplication Service هي الحد الرسمي للقراءة. لا ينبغي بناء UI أو Reports أو AI Planner بمسارات موازية تصل مباشرة إلى SQLite أو تفاصيل المحركات الداخلية.

## Invariants أساسية لا يجب كسرها

- Offline/local-first للـcore operation.
- Read-only toward customer legacy systems في V1.
- No free-form SQL.
- Closed-world runtime validation، بما يشمل رفض unknown persisted canonical fields.
- Currency-safe financial semantics ولا implicit FX.
- Exact decimal arithmetic.
- Streaming/bounded-memory behavior.
- Snapshot-bound pagination.
- Pinned read-scope consistency.
- Explicit connector/snapshot provenance.
- AI ليس execution authority.
- Strict package/runtime boundaries.
- Normal upper-layer reads تمر عبر Application Service.
- SQL isolation assumptions database-specific.
- Implement first, abstract second.

## درس المراجعة المعمارية — 2026-08-25

المراجعة المستقلة لم توصِ بإعادة المعمارية. الحكم كان **Needs targeted fixes**.

أهم استنتاج: foundation قوية في **contract/structural correctness**، لكن نجاح أول connector الحقيقي سيتطلب إضافة **semantic evidence + reconciliation + operational qualification** قبل اعتبار connector جاهزًا للـPilot.

لا نحول هذا الآن إلى framework عام. لأول Motakamel connector ننتج artifacts خاصة بالنظام/version ثم نستخرج abstraction فقط بعد evidence متكرر.

## V1 الحالي باختصار

المستهدف:

- Local Windows application.
- Offline-first.
- Read-only connector لنظام حقيقي واحد في البداية.
- Products / Inventory / Customers / Sales.
- Arabic query/search experience.
- Basic reports.
- Deterministic insights بعد إثبات semantics.

غير داخل V1 حاليًا: Voice، WhatsApp، unrestricted write actions، multi-industry implementation، LAN/multi-process semantics، Generic Schema Inspector، Universal SQL Connector.

## الفصل بين الذاكرة والكود

هذا المستودع هو **ذاكرة المنتج والقرارات والحالة الموثقة**، وليس مستودع التنفيذ.

- Product memory: `elias-mujally/dbl-products-memory/products/legacy-intelligence/`
- Build repository: `elias-mujally/dbl-legacy-intelligence`

في أي جلسة جديدة: تحقق من مستودع البناء قبل ادعاء أن Capability منفذة، ثم حدّث الذاكرة بعد milestones أو قرارات رئيسية.