# Legacy Intelligence — Current Status

آخر تحديث: **2026-08-24**

## الحالة

**BUILD IN PROGRESS — Hardened read-only intelligence foundation + stable V1 application boundary merged**

تم الانتقال من مرحلة الدراسة والتخطيط إلى التنفيذ الفعلي، ثم تقوية الأساس الهندسي، ثم إضافة طبقات الذكاء المحلي والاستعلام الآمن، والآن إضافة الحد التطبيقي الرسمي الذي ستستهلكه واجهة Windows والتقارير وطبقة AI المستقبلية بدل الوصول المباشر إلى التخزين أو المحركات الداخلية.

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

ما أصبح منفذًا:

- Persistent SQLite Audit Sink.
- Runtime audit validation.
- Audit migrations + checksum/drift detection.
- Defensive audit reads and resource cleanup.
- Deterministic Insight Engine يعمل بدون AI/Internet.
- قواعد أولية: Low Stock / Outstanding Receivables / Sales Summary.
- Presentation-neutral insight output.
- Exact decimal arithmetic وعدم خلط العملات.
- Streaming `SnapshotReader` من SQLite.

المسار المثبت بالاختبارات:

`Multi-batch Connector -> Import Orchestrator -> SQLite -> SnapshotReader -> Deterministic Insight Engine`

---

### 3. Local Query Foundation

تم بناء ومراجعة وتقوية ثم دمج PR #7 إلى `main` باستخدام Squash Merge.

- PR: `#7 — V1 local query foundation: typed plans, safe filters, snapshot-bound cursors`
- Merge commit: `54301b5ea3e0756b9935e6a3df31f954118c1c10`

أهم Query invariants:

- Typed `QueryPlan 1.0.0`.
- Supported entities في V1: Product / Customer / Sale.
- Closed-world Runtime Validation.
- لا Free-form SQL أو generic expressions.
- Money comparisons مرتبطة بالعملة ولا implicit FX.
- Exact decimal arithmetic مشتركة من Core.
- Cursor مرتبطة بـconnector + snapshot + entity + query fingerprint + last ID.
- Pagination بدون OFFSET.
- Default page size 50 / hard max 200.
- Hard max 20 filters.
- Query execution streaming فوق `SnapshotReader`.

آخر CI مرجعية قبل الدمج: Run #155 نجحت على Ubuntu وWindows.

---

### 4. V1 Application Service Boundary

تم بناء PR #8 ثم إجراء مراجعة نقدية ما قبل الدمج. المراجعة أعادت PR إلى Draft رغم CI خضراء بعد اكتشاف مشاكل في snapshot consistency وruntime connector isolation وInsight provenance. تم إصلاحها من الجذر، إعادة الاختبار، ثم دمج PR #8 إلى `main` باستخدام Squash Merge.

- PR: `#8 — V1 application service boundary above query and insights`
- Merge commit: `4d2e8fa59914c371c21b2176663dda38e39fd67f`
- Final verified CI before merge: Run `#173` على Ubuntu وWindows.

#### لماذا هذه الطبقة مهمة؟

أصبحت `@dbl/application-service` هي **الحد الرسمي read-only** الذي يجب أن تستهلكه الطبقات العليا مستقبلًا:

`UI / Reports / future AI Planner -> Application Service -> pinned Read Scope -> Query/Insight Engines -> SnapshotReader -> LocalStore`

الهدف هو منع واجهة المستخدم والتقارير وAI من الاقتران المباشر بـSQLite أو `SnapshotReader` أو تفاصيل المحركات الداخلية.

#### Pinned Application Read Scope

الدخول للقراءة أصبح عبر:

`openReadScope({ connectorId })`

ويتم تثبيت آخر committed snapshot **مرة واحدة** عند فتح الـscope، ثم تحتفظ الـscope بنفس `SnapshotReader` طوال عمرها.

هذا يضمن:

- pagination لا تقفز إلى snapshot أحدث إذا حدث Import في المنتصف.
- multi-query reports ترى نفس الصورة الزمنية للبيانات.
- Query وInsights داخل نفس scope تشترك في نفس provenance.
- Scope جديدة فقط هي التي ترى snapshot أحدث.

تم اختبار سيناريو مهم end-to-end: صفحة أولى من snapshot، ثم Import أحدث، ثم الصفحة الثانية من نفس scope تستمر على snapshot الأصلية بلا رفض أو خلط.

#### Runtime Connector Isolation

لم يعد الاعتماد على TypeScript وحده لمنع connector مبهمة.

Application boundary تتعامل مع input كـ`unknown` وتطبق closed-world runtime validation:

- request يجب أن تكون plain object.
- `connectorId` مطلوبة.
- non-empty بعد trimming.
- bounded.
- unknown fields مرفوضة.
- accessor/non-plain inputs مرفوضة.
- لا يتم تمرير connector غير محددة إلى التخزين.

وبذلك لا يمكن لـUI أو JavaScript أو AI تجاوز العزل بتمرير `undefined` ثم السقوط إلى سلوك "latest snapshot from any connector".

#### Explicit Provenance

Query results وApplication-level insight envelopes تحمل provenance صريحة:

- `connectorId`.
- `snapshotId`.

كما تتحقق Application Service من provenance التي تعيدها Query Engine مقابل الـpinned scope وتفشل صراحة عند أي mismatch.

Core `Insight` بقي presentation/domain-neutral؛ provenance أضيفت في application envelope بدل تلويث نموذج الـInsight الأساسي.

#### Runtime Immutability

تم تجميد scope/context/source وInsight envelopes Runtime لمنع upper layers من تعديل pinned provenance بالخطأ بعد الإنشاء.

#### قرار تخزيني مهم

لم تتم إضافة arbitrary historical snapshot lookup إلى `LocalStore` في V1. بدل ذلك يتم تثبيت `SnapshotReader` المفتوحة بالفعل داخل الـRead Scope. هذا يحل consistency الحالية دون توسيع storage API قبل وجود use case حقيقي لـpersisted/cross-process scope tokens.

#### ما بقي خارج Scope عمدًا

PR #8 لا تضيف:

- UI rendering.
- report rendering/export.
- AI prompts/planning.
- write actions.
- permissions/approval execution.
- connector-specific behavior.
- persisted/cross-process read-scope tokens.

#### التحقق النهائي

CI Run #173 نجحت على Ubuntu وWindows وشملت:

- locked `npm ci` ✅
- Ubuntu critical vulnerability audit ✅
- runtime build including `@dbl/application-service` ✅
- strict TypeScript typecheck ✅
- all tests ✅
- pagination remains valid after intervening newer import ✅
- multi-query scope remains on one snapshot ✅
- malformed/ambiguous runtime requests rejected ✅
- connector isolation verified ✅
- explicit insight provenance verified ✅

## ما أصبح موجودًا فعليًا الآن في `main`

1. Core contracts + Canonical Model.
2. Connector contract + mock connector.
3. Import Orchestrator.
4. Durable local SQLite storage.
5. Bounded batched imports + staging + recovery.
6. Persistent Audit.
7. Streaming SnapshotReader.
8. Deterministic Insight Engine.
9. Local Query Engine.
10. Shared exact decimal arithmetic.
11. **V1 Application Service Boundary.**
12. **Pinned Application Read Scopes.**
13. **Runtime connector isolation at the application boundary.**
14. **Explicit query/insight provenance at the application layer.**
15. Cross-platform CI على Ubuntu وWindows.

## الهدف التنفيذي الحالي لـV1

نواصل بناء أول نسخة Demo-ready مع الحفاظ على Scope ضيق:

- تطبيق Windows محلي.
- Offline-first.
- Read-only في V1.
- Connector واحد حقيقي فقط في البداية.
- دعم Products / Inventory / Customers / Sales.
- واجهة عربية بسيطة لاحقًا فوق `Application Service` فقط.
- Query/Search فوق البيانات الفعلية.
- Basic reports.
- Deterministic insights.
- لا Voice في V1.
- لا WhatsApp في V1.
- لا Write Actions في V1.
- لا Multi-industry implementation في V1.

## قاعدة السلامة

الـLLM لا ينفذ SQL حر على قاعدة العميل ولا يكتب في ERP في V1.

المسار المستهدف للـAI مستقبلًا:

`User Text -> Intent/Query Planner -> Runtime-validated QueryPlan -> Application Read Scope -> LocalQueryExecutor -> SnapshotReader -> Result -> Answer`

الـAI يمكنه ترجمة intent إلى QueryPlan، لكن authority تبقى للـvalidator/executor deterministic.

## Invariants لا يجب كسرها في الخطوات القادمة

- no free-form SQL.
- read-only first.
- closed-world runtime validation.
- currency-safe financial semantics.
- streaming/bounded-memory behavior.
- snapshot-bound pagination.
- pinned read-scope consistency.
- explicit connector/snapshot provenance.
- strict package/runtime boundaries.
- upper layers do not bypass Application Service for normal reads.

## تحسينات مؤجلة غير مانعة حاليًا

- Predicate/seek pushdown لتحسين deep pagination وcontains-search على البيانات الضخمة.
- Signed/opaque cursors عندما تخرج cursors عبر API غير موثوق.
- LAN / multi-process storage semantics تحتاج تصميمًا جديدًا؛ SQLite الحالية لا تعتبر multi-process foundation.
- Persisted/cross-process read-scope tokens عند ظهور use case فعلي.

## الفصل بين المستودعات

مستودع البناء:

`elias-mujally/dbl-legacy-intelligence`

ذاكرة المنتج والقرارات الاستراتيجية:

`elias-mujally/dbl-products-memory/products/legacy-intelligence/`

يجب إبقاء ذاكرة المنتج منفصلة عن كود التنفيذ، وتسجيل milestones والقرارات المهمة هنا بعد التحقق من مستودع البناء.

## Milestone التالي

**Continue V1 above the merged Application Service boundary.**

أي UI أو Reporting أو AI Planner قادم يجب أن يبنى فوق هذا الحد بدل إنشاء مسارات قراءة موازية تتجاوز invariants التي تم تثبيتها.
