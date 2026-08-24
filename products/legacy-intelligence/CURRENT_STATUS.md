# Legacy Intelligence — Current Status

آخر تحديث: **2026-08-24**

## الحالة

**BUILD IN PROGRESS — Hardened read-only intelligence foundation + local query layer merged**

تم الانتقال من مرحلة الدراسة والتخطيط إلى التنفيذ الفعلي، ثم تقوية الأساس الهندسي، ثم إضافة أول طبقات الذكاء المحلي والاستعلام الآمن فوق بيانات الأنظمة القديمة.

مستودع البناء:

`elias-mujally/dbl-legacy-intelligence`

## Milestones المنجزة — 2026-08-24

### 1. Foundation Hardening Round 2

تم إنهاء وتقوية الأساس الهندسي لـV1 ثم دمج PR #5 إلى `main` باستخدام Squash Merge.

- PR: `#5 — Foundation Hardening Round 2`
- Merge commit: `ab3db09c5afebaea1db741087af146c9771b32cc`

أهم ما أصبح ثابتًا بعد هذه الجولة:

- canonical decimal representation صار strict.
- batch imports أصبحت bounded.
- Runtime connector validation أصبح فعليًا.
- migration drift/checksum أصبح ميكانيكيًا.
- staging لديها crash recovery/cleanup.
- SQLite الحالية موثقة كـsingle-writer desktop store.
- CI تعتمد locked `npm ci` مع build + strict typecheck + tests على Ubuntu وWindows.

---

### 2. Persistent Audit + Deterministic Insight Foundation

تم بناء ودمج PR #6 إلى `main` بعد مراجعة معمارية وإصلاحات إضافية.

- PR: `#6 — Persistent Audit + Deterministic Insight Foundation`
- Merge commit: `1db738aae59c8b61e95cac99975d9864ab306947`

أهم ما تم إدخاله:

#### Persistent Audit

- SQLite-backed Audit Sink دائم.
- Runtime validation لأحداث التدقيق.
- Audit migrations مع checksum/drift detection.
- defensive read path للأحداث المخزنة.
- Resource cleanup صحيح عند فشل initialization/migration.
- تكامل فعلي مع Import Orchestrator.

#### Deterministic Insight Engine

أول طبقة ذكاء محلية تعمل بدون AI وبدون إنترنت.

القدرات الأولية تشمل قواعد deterministic مثل:

- Low Stock.
- Outstanding Receivables.
- Sales Summary.

قرارات مهمة:

- الـInsight Engine presentation-neutral ولا يحتوي نصوص UI/لغة إنجليزية ثابتة.
- الحسابات المالية تستخدم exact decimal arithmetic.
- لا يتم خلط العملات.
- الـInsight Engine يعتمد Streaming عبر `SnapshotReader` بدل materializing snapshot كاملة.

#### Streaming SnapshotReader

تم تثبيت مسار قراءة streaming من SQLite:

`SQLite -> SnapshotReader -> Insight Engine`

ويستطيع قراءة Products / Customers / Sales بترتيب canonical بدون تحميل كامل تاريخ العميل في الذاكرة.

تم اختبار المسار end-to-end:

`Multi-batch Connector -> Import Orchestrator -> SQLite -> SnapshotReader -> Deterministic Insight Engine`

---

### 3. Local Query Foundation

تم بناء ومراجعة وتقوية ثم دمج PR #7 إلى `main` باستخدام Squash Merge.

- PR: `#7 — V1 local query foundation: typed plans, safe filters, snapshot-bound cursors`
- Merge commit: `54301b5ea3e0756b9935e6a3df31f954118c1c10`

هذه الطبقة أصبحت الحدود الرسمية للاستعلام المحلي الآمن فوق البيانات الملتزمة.

المسار المعماري الحالي:

`Legacy ERP -> Connector -> Import Orchestrator -> SQLite -> SnapshotReader -> Query Engine / Insight Engine`

#### QueryPlan v1

- Typed QueryPlan.
- Supported entities في V1: Product / Customer / Sale.
- Closed set of filters.
- لا Free-form SQL.
- لا generic expressions.
- لا arbitrary sorting في V1.
- لا OFFSET pagination.

#### Closed-world Runtime Validation

أي input مجهول يتم رفضه، بما في ذلك unknown keys على:

- QueryPlan.
- Filter.
- Page.
- Cursor.
- nested Money objects.

الهدف: أي input قادم مستقبلًا من UI أو AI يعتبر untrusted حتى يجتاز validator deterministic.

#### Money-safe query semantics

المقارنات المالية أصبحت Currency-bound.

لا يجوز مقارنة مبلغ وحده بدون عملته.

مثال صحيح:

`{ amount: "100", currency: "USD" }`

وبالتالي لا يمكن خلط 100 USD و100 YER و100 SAR في مقارنة واحدة دون تحويل صريح خارج هذه الطبقة.

#### Exact Query Protocol Gate

الإصدار المدعوم حاليًا:

`QueryPlan 1.0.0`

أي إصدار مستقبلي مثل `1.1.0` يُرفض حتى تتم إضافة دعمه عمدًا.

#### Safe cursor pagination

الـCursor مرتبطة بـ:

- connectorId.
- snapshotId.
- entity.
- canonical query-plan fingerprint.
- last returned entity ID.

الـCursor لا يمكن إعادة استخدامها مع Snapshot أو Query Plan مختلفة دون رفض صريح.

V1 cursors تعتبر internal local-process contract. التوقيع/opaque external tokens يؤجل حتى تعبر cursors حدود API غير موثوقة.

#### Bounded query execution

- Default page size: 50.
- Hard maximum page size: 200.
- Hard maximum filters: 20.
- Text filters محدودة الطول.
- executor يعتمد streaming.
- Sale list pages تعيد Sale summaries فقط ولا materialize `lines[]` داخل الصفحة.

#### Shared exact decimal arithmetic

تم نقل exact decimal arithmetic إلى Core ليستخدمها كل من:

- Insight Engine.
- Query Engine.

وذلك لمنع اختلاف semantics المالية بين أجزاء المنتج.

#### CI verification

آخر CI قبل دمج PR #7 كانت Run #155 ونجحت على Ubuntu وWindows:

### Ubuntu
- `npm ci` ✅
- critical vulnerability audit ✅
- runtime build ✅
- strict TypeScript typecheck ✅
- tests ✅

### Windows
- `npm ci` ✅
- runtime build ✅
- strict TypeScript typecheck ✅
- tests ✅

## ما أصبح موجودًا فعليًا الآن

المنتج لم يعد مجرد Foundation فقط.

داخل `main` توجد حاليًا طبقات فعلية تشمل:

1. Core contracts + canonical model.
2. Connector contract + mock connector.
3. Import Orchestrator.
4. Durable local SQLite storage.
5. Bounded batched imports + staging + recovery.
6. Persistent Audit.
7. Streaming SnapshotReader.
8. Deterministic Insight Engine.
9. Local Query Engine.
10. Shared exact decimal arithmetic.
11. Cross-platform CI على Ubuntu وWindows.

## الهدف التنفيذي الحالي لـV1

نواصل بناء أول نسخة Demo-ready مع الحفاظ على Scope ضيق:

- تطبيق Windows محلي.
- Offline-first.
- Read-only في V1.
- Connector واحد حقيقي فقط في البداية.
- دعم Products / Inventory / Customers / Sales.
- واجهة عربية بسيطة لاحقًا فوق الأساس الحالي.
- Query/Search فوق البيانات الفعلية.
- Basic reports.
- Deterministic insights.
- لا Voice في V1.
- لا WhatsApp في V1.
- لا Write Actions في V1.
- لا Multi-industry implementation في V1.

## قاعدة السلامة

الـLLM لا ينفذ SQL حر على قاعدة العميل ولا يكتب في ERP في V1.

المسار المستهدف الآن أصبح أكثر تحديدًا:

`User Text -> Intent/Query Planner -> Runtime-validated QueryPlan -> LocalQueryExecutor -> SnapshotReader -> Result -> Answer`

الـAI مستقبلًا يمكنه ترجمة intent إلى QueryPlan، لكن authority تبقى للـvalidator/executor deterministic.

## تحسينات مؤجلة غير مانعة حاليًا

- Predicate/seek pushdown لتحسين deep pagination وcontains-search على البيانات الضخمة.
- Signed/opaque cursors عندما تخرج cursors عبر API غير موثوق.
- LAN / multi-process storage semantics تحتاج تصميمًا جديدًا؛ SQLite الحالية لا تعتبر multi-process foundation.

## الفصل بين المستودعات

مستودع البناء:

`elias-mujally/dbl-legacy-intelligence`

ذاكرة المنتج والقرارات الاستراتيجية:

`elias-mujally/dbl-products-memory/products/legacy-intelligence/`

يجب إبقاء ذاكرة المنتج منفصلة عن كود التنفيذ، وتسجيل milestones والقرارات المهمة هنا بعد التحقق من مستودع البناء.

## Milestone التالي

**Continue V1 on top of the merged local query + deterministic intelligence foundation.**

الأولوية هي التقدم الوظيفي المنضبط بدون كسر invariants المحسومة، خصوصًا:

- no free-form SQL.
- read-only first.
- closed-world query validation.
- currency-safe financial semantics.
- streaming/bounded-memory behavior.
- strict package/runtime boundaries.
