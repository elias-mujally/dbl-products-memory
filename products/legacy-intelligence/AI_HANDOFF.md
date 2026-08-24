# AI Handoff — Legacy Intelligence

## الهدف

هذا الملف يتيح لأي مساعد AI أو مطور فهم مبادرة Legacy Intelligence بسرعة دون قراءة بقية منتجات DBL.

## اقرأ أولًا

1. `README.md`
2. `CURRENT_STATUS.md`
3. `VISION.md`
4. `ROADMAP.md`
5. `MARKET_STUDY_2026-08-21.md`
6. `MULTI_INDUSTRY_VISION_2026-08-21.md`
7. `DECISIONS.md`

## الوصف الحالي

DBL يبني **Local-First Legacy ERP Intelligence Layer**: طبقة ذكاء وتشغيل محلية فوق ERP/POS/Accounting/Custom Systems القديمة، تعمل بدون اعتماد دائم على الإنترنت، وتتحول تدريجيًا من Read-only intelligence إلى controlled actions ثم automation.

الرؤية تتضمن Agent برمجي deterministic يعمل Offline حتى بدون AI. في هذا الوضع يستخدم العميل أوامر جاهزة ذات Parameters قابلة للتعديل مثل الكمية والتاريخ والفرع والمورد والمخزن والمنتج وصيغة التقرير ووجهة الطباعة.

## المبادئ الثابتة

- لا تبنِ ERP كاملًا أولًا.
- لا تجعل Offline + Arabic + AI هي الـmoat الوحيدة.
- ابدأ بنظام قديم حقيقي واحد وعميل حقيقي واحد.
- Read-only أولًا.
- AI لا يكتب مباشرة في قاعدة البيانات.
- استخدم Typed Actions + Validation + Permission + Preview + Approval + Deterministic Executor + Audit.
- Cloud اختياري، وليس dependency لازمة لاستمرار العمل المحلي.
- Agent التنفيذ يجب أن يعمل بدون AI عبر Ready-made Parameterized Commands.
- AI دوره فهم intent والتحليل وتحويل الطلب إلى Structured Action، وليس امتلاك سلطة التنفيذ.
- لكل Action مستوى حساسية، وقد ترتفع الحساسية حسب القيمة المالية أو السياق.
- التقارير والتصدير والطباعة عادة Low-risk، بينما طلبات الشراء والإجراءات عالية التأثير تحتاج Confirmation أو Authorized Approval، وقد تحتاج Multiple Approvals.
- Policy Engine deterministic هو صاحب قرار السماح بالتنفيذ.
- خدمة Agent مخطط لها كاشتراك مستقل، لا كشراء دائم تابع للمنتج.
- Offline subscriptions يجب أن تدعم License/Entitlement موقّعًا يمكن التحقق منه محليًا خلال مدة الاشتراك دون اتصال دائم.
- Implement first, abstract second.
- Connector knowledge وCanonical Business Model وSchema Intelligence هي أصول دفاعية مستقبلية.
- الرؤية متعددة القطاعات، لكن الـMVP رأسي وضيق.

## الحالة الهندسية الحالية — 2026-08-24

مستودع البناء:

`elias-mujally/dbl-legacy-intelligence`

### Milestone 1 — Foundation Hardening Round 2

- PR #5 merged.
- Merge commit: `ab3db09c5afebaea1db741087af146c9771b32cc`

أهم invariants:

- strict canonical decimals.
- bounded batch imports.
- runtime connector validation.
- mechanical migration drift detection.
- staging crash recovery.
- SQLite الحالية single-writer desktop store.
- locked CI على Ubuntu وWindows.

### Milestone 2 — Persistent Audit + Deterministic Insights

- PR #6 merged.
- Merge commit: `1db738aae59c8b61e95cac99975d9864ab306947`

ما أصبح منفذًا:

- persistent SQLite Audit Sink.
- runtime audit validation.
- audit migrations + checksum/drift detection.
- defensive audit reads and resource cleanup.
- Deterministic Insight Engine يعمل بدون AI/Internet.
- Low Stock / Outstanding Receivables / Sales Summary.
- presentation-neutral insight output.
- exact decimal arithmetic وعدم خلط العملات.
- Streaming `SnapshotReader` من SQLite.

### Milestone 3 — Local Query Foundation

- PR #7 merged using Squash Merge.
- Merge commit: `54301b5ea3e0756b9935e6a3df31f954118c1c10`

أهم Query invariants:

- `QueryPlan 1.0.0` فقط حاليًا.
- لا free-form SQL أو generic expressions.
- Closed-world runtime validation.
- Money filters تربط amount + currency.
- لا implicit FX comparisons.
- exact decimal comparisons من Core المشترك.
- canonical UTC timestamps.
- pagination بدون OFFSET.
- cursors مرتبطة بـconnector + snapshot + entity + query fingerprint + last ID.
- page size bounded: default 50 / max 200.
- max 20 filters.
- Sale list queries تعيد summaries ولا تحمل `lines[]` في الصفحة.
- Query execution streaming فوق `SnapshotReader`.
- AI مستقبلاً يترجم intent إلى QueryPlan فقط؛ validator/executor deterministic هو authority.

### Milestone 4 — V1 Application Service Boundary

- PR #8 merged using Squash Merge.
- Merge commit: `4d2e8fa59914c371c21b2176663dda38e39fd67f`
- Final verified CI: Run #173 passed on Ubuntu and Windows.

هذه الطبقة أصبحت الحد الرسمي للقراءة الذي يجب أن تستخدمه UI / Reports / future AI Planner.

المسار الحالي:

`Legacy ERP -> Connector -> Import Orchestrator -> SQLite -> SnapshotReader -> Query/Insight Engines -> Application Service -> UI/Reports/AI`

وبصيغة dependency direction من الأعلى للأسفل:

`UI / Reports / future AI Planner -> Application Service -> pinned Read Scope -> Query/Insight Engines -> SnapshotReader -> LocalStore`

أهم Application Service invariants:

- upper layers لا تصل مباشرة إلى SQLite أو engine internals في مسار القراءة الطبيعي.
- القراءة تبدأ عبر `openReadScope({ connectorId })`.
- الـscope تثبت committed snapshot واحدة عند الفتح وتحتفظ بنفس `SnapshotReader` طوال عمرها.
- pagination داخل scope لا تتغير إذا وصل Import أحدث.
- multi-query reports داخل scope ترى نفس snapshot.
- runtime connector isolation لا يعتمد على TypeScript وحده.
- application requests تعامل كـ`unknown` وتخضع closed-world validation.
- missing/empty/ambiguous/unknown-field connector requests تفشل قبل storage.
- Query provenance تتحقق مقابل pinned scope.
- Application-level insight envelopes تحمل `connectorId + snapshotId` صراحة.
- scope/context/source/insight envelopes frozen Runtime لمنع mutation العرضي للـprovenance.
- لم نضف arbitrary historical snapshot lookup إلى LocalStore؛ V1 تمسك القارئ المفتوح نفسه بدل توسيع التخزين بلا use case.

اختبارات حرجة مثبتة:

- page 1 -> newer import -> page 2 من نفس scope تستمر على snapshot الأصلية.
- عدة queries في نفس scope تبقى على snapshot واحدة.
- malformed runtime requests مرفوضة.
- connector isolation مثبتة.
- insight provenance صريحة ومختبرة.

CI #173:

- locked `npm ci` ✅
- Ubuntu critical vulnerability audit ✅
- runtime build including application service ✅
- strict TypeScript typecheck ✅
- all tests ✅

## ما أصبح موجودًا فعليًا في `main`

1. Core contracts + Canonical Model.
2. Mock/connector contracts.
3. Import Orchestrator.
4. Durable SQLite local storage.
5. Bounded/staged imports + recovery.
6. Persistent Audit.
7. Streaming SnapshotReader.
8. Deterministic Insight Engine.
9. Local Query Engine.
10. Shared exact decimal arithmetic.
11. V1 Application Service Boundary.
12. Pinned Application Read Scopes.
13. Runtime connector isolation at application boundary.
14. Explicit query/insight provenance at application layer.
15. Cross-platform CI on Ubuntu + Windows.

## قاعدة مهمة لأي AI أو مطور يكمل العمل

لا تعِد فتح invariants المحسومة أعلاه أو تضعفها لتسهيل Feature جديدة إلا إذا ظهر دليل تقني واضح يستوجب تغيير القرار.

خصوصًا لا تُدخل أي Feature بطريقة تكسر:

- no free-form SQL.
- read-only-first.
- closed-world validation.
- currency-safe semantics.
- bounded-memory/streaming behavior.
- snapshot-bound pagination.
- pinned read-scope consistency.
- explicit connector/snapshot provenance.
- deterministic validation/execution authority.
- strict package/runtime boundaries.
- normal upper-layer reads must go through Application Service.

أي توسع مثل LAN، multi-process، write actions أو multi-industry يجب أن يضيف تصميمًا مناسبًا بدل افتراض أن قيود V1 الحالية تغطيه.

## حدود مؤجلة عمدًا وليست Bugs حالية

- Predicate/seek pushdown لتحسين deep pagination والبحث الواسع على قواعد ضخمة.
- Signed/opaque cursors فقط عندما تعبر cursor حدود API غير موثوقة.
- LAN/multi-process semantics تحتاج storage design جديدًا؛ SQLite الحالية ليست multi-process foundation.
- Persisted/cross-process read-scope tokens عند ظهور use case فعلي.

## أوضاع التشغيل المستهدفة

1. Offline Basic: deterministic intelligence + Agent commands، بدون AI.
2. Offline Intelligent: Local AI + deterministic Agent.
3. Hybrid: Local Core + Agent + Cloud اختياري.

## الفصل بين البناء والذاكرة

مستودع البناء الحالي هو `elias-mujally/dbl-legacy-intelligence`، بينما `elias-mujally/dbl-products-memory` هو المرجع الاستراتيجي وذاكرة المنتج.

لا تنقل الرؤية أو القرارات الاستراتيجية إلى مستودع البناء إلا إذا أصبحت متطلبات تنفيذية فعلية. وبالمقابل، milestones التنفيذية المهمة يجب تلخيصها هنا بعد التحقق منها حتى لا تضيع حالة المشروع بين الجلسات.

## التسلسل المقترح

V1: أول Connector حقيقي + Canonical Model + Local read-only intelligence + query/search/reporting foundations + stable Application Service boundary.

V2: فصل mapping عن connector.

V3: Generic SQL Schema Inspector.

V4: AI-assisted semantic mapping.

V5: Capability detection.

V6: Industry Packs وتجربة شبه عامة على أنظمة وقطاعات متعددة.

Controlled actions وOffline Agent تأتي بعد إثبات الأساس Read-only، ولا يجب أن توسع نطاق V1 قبل أوانه.

## التحذير التنفيذي

لا تدّعِ أن Capability منفذة لمجرد وجودها في الرؤية أو الRoadmap. تحقق من مستودع الكود أولًا.

**آخر نقطة تنفيذية موثقة:**

PR #8 `V1 application service boundary above query and insights` تم دمجها بنجاح في `main` بتاريخ 2026-08-24 عند commit:

`4d2e8fa59914c371c21b2176663dda38e39fd67f`

ابدأ أي عمل V1 لاحق من هذا `main`، وابنِ UI / Reports / AI Planner فوق Application Service بدل تجاوزها.
