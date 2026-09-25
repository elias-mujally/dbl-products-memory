# Legacy Intelligence — Product Memory

هذا المجلد هو الذاكرة المرجعية لمبادرة **Local-First Legacy ERP Intelligence Layer** داخل DBL.

آخر مزامنة مع مستودع البناء: **2026-08-25**

آخر تحديث بحثي/مخبري: **2026-09-25**

## الحالة

**V1 BUILD IN PROGRESS — CONTINUE WITH CORRECTIONS. Pilot #001 remains Purchase Attention + Item Intelligence. Controlled Item A exists in the educational Motakamel lab; Windows 11 Computer Use is qualified for Stage A only. Stage B Motakamel/SQL installation is blocked by host D: capacity. No Motakamel connector or customer pilot is qualified.**

مستودع التنفيذ:

`elias-mujally/dbl-legacy-intelligence`

آخر milestone مدموج في `main`:

- PR #10 — Close canonical validation against silent field loss.
- Squash merge commit: `95bf225e1523e0fd0f72cdf3da8393df18d635cc`.
- Final verified PR CI before merge: Run #194 على Ubuntu وWindows.

PR #10 أغلق defect حقيقيًا في الـclosed-world canonical boundary: unknown canonical fields لم تعد تمر validation ثم تختفي بصمت أثناء SQLite persistence/fingerprinting.

## ابدأ من هنا

**أحدث حالة مثبتة:** [Legacy Intelligence Progress Checkpoint — 2026-09-25](LEGACY_INTELLIGENCE_PROGRESS_CHECKPOINT_2026-09-25.md). يميز بين Item A المثبت عبر الواجهة، استكشاف S0b الجزئي، تأهيل Windows 11 Computer Use Stage A فقط، ومشكلة مساحة Stage B. لا يستنتج نجاح Motakamel على Windows 11.

**تأهيل تقاعد مختبر Windows 10 Agent Lab:** [Computer Use and Retirement Evidence — 2026-09-25](MOTAKAMEL_W10_AGENT_LAB_RETIREMENT_EVIDENCE_2026-09-25.md). المساحة المحتملة كافية حسابيًا، لكن قرار التقاعد معلّق حتى يُفحص ما إذا كانت سجلات/إعدادات تشخيصية فريدة بقيت داخل الضيف؛ لم تُحذف أي VM.

**الاستراتيجية التنفيذية الأحدث:** [Controlled Dataset → Design Partner Strategy](CONTROLLED_DATASET_TO_DESIGN_PARTNER_STRATEGY_2026-09-10.md) و[Controlled Motakamel Dataset #001 plan](CONTROLLED_MOTAKAMEL_DATASET_001_PLAN_2026-09-10.md). الدليل التعليمي قد يؤهل قدرة محدودة بمستوى LAB-PROVEN بعد مصالحتها؛ بيانات الشريك الواقعية مطلوبة لمستوى PARTNER-VALIDATED، ثم تجربة مستخدم تشغيلية لمستوى PILOT-QUALIFIED.

عقد تعلّم الـpilot: [Pilot Learning Contract #001 — Purchase Attention + Item Intelligence](PILOT_LEARNING_CONTRACT_001_PURCHASE_ATTENTION_ITEM_INTELLIGENCE_2026-09-06.md). هذه فرضية قيمة سوقية لا تثبتها بيانات المختبر وحدها: DBL يساعد المستخدم في مراجعة الأصناف وجمع معلوماتها، ولا يقرر الشراء أو المورد أو كمية الطلب بدل الإنسان.

المراجعة الاستراتيجية المرجعية: [Independent Full Product Review — 2026-09-06](INDEPENDENT_FULL_PRODUCT_REVIEW_2026-09-06.md). الحكم هو **CONTINUE WITH CORRECTIONS**: لا rewrite ولا تغيير جذري للمعمارية. قرار 10 سبتمبر اللاحق يسمح ببيانات تعليمية مضبوطة للتنفيذ المخبري المحدود قبل بيانات الشريك، دون خفض معيار التأهيل الواقعي. Account Numbering يبقى unresolved وليس blocker تلقائيًا للـConnector.

آخر checkpoint أدلة قبل المراجعة: [Motakamel Plus V1 Evidence Progress Checkpoint](MOTAKAMEL_PLUS_PROGRESS_CHECKPOINT_2026-09-03.md). آخر قرار دلالي سابق: [Minimum V1 Semantic Scope](MOTAKAMEL_PLUS_V1_SEMANTIC_SCOPE_2026-09-03.md). `EFA12026` REQUIRED، و`Multi_Lang` OPTIONAL للنطاق الأدنى السابق. لا تزال connector readiness غير معلنة.

1. `PILOT_LEARNING_CONTRACT_001_PURCHASE_ATTENTION_ITEM_INTELLIGENCE_2026-09-06.md` — **Current execution anchor**: المشكلة، المستخدم، Purchase Attention، Item Intelligence، حدود V1، success measures، وMotakamel evidence المطلوب.
2. `INDEPENDENT_FULL_PRODUCT_REVIEW_2026-09-06.md` — checkpoint استراتيجي وتقني: verdict، findings، إيقاف Account Numbering كمسار حرج، وخمس حركات نحو أول pilot.
3. `AI_HANDOFF.md` — أسرع نقطة لفهم أين توقف البناء وما الذي لا يجب كسره.
4. `CURRENT_STATUS.md` — الحالة التنفيذية والميلستونات الحالية.
5. `MOTAKAMEL_PLUS_PROGRESS_CHECKPOINT_2026-09-03.md` — checkpoint شامل لأدلة Motakamel: provisioning، least-privilege read، CONTROL SERVER denial، frozen backup snapshot، database boundary، والـGolden Dataset blocker التاريخي.
6. `ARCHITECTURE_REVIEW_2026-08-25.md` — خلاصة المراجعة المعمارية المستقلة السابقة وخطة remediation المقبولة.
7. `FIRST_CONNECTOR_TARGET_2026-08-25.md` — قرار First Connector Target وخطة Evidence Acquisition.
8. `MOTAKAMEL_PLUS_EVIDENCE_MILESTONE_2026-09-02.md` — أول Motakamel حقيقي: النسخة/SQL/المختبر/provisioning/pre-login/gate status.
9. `ALMUHASEB1_LAB_PROGRESS_2026-09-01.md` — سجل مختبر AlMuhaseb1: Golden Dataset، Hyper-V isolation، A/B Proof-of-Path، والـline-level blocker الحالي.
10. `VISION.md` — الرؤية طويلة المدى.
11. `ROADMAP.md` — ما تم وما تبقى من V1 ثم V2–V6.
12. `MARKET_STUDY_2026-08-21.md` — الدراسة السوقية المرجعية السابقة.
13. `MULTI_INDUSTRY_VISION_2026-08-21.md` — الرؤية متعددة القطاعات.
14. `DECISIONS.md` — القرارات الاستراتيجية والمعمارية المقبولة.

## الفكرة في سطر واحد

> **Make existing businesses intelligent without forcing them to rebuild their technology.**

طبقة ذكاء وتشغيل محلية، vendor-neutral، تُركب فوق الأنظمة القديمة أو المحلية وتضيف البحث والتحليل ثم الإجراءات والأتمتة تدريجيًا دون فرض migration كامل.

## First Wedge الحالي

الهدف السوقي الأول المختار حاليًا هو **YemenSoft Motakamel Plus ERP**، بشرط evidence acquisition ناجحة على إصدار/Schema حقيقي محدد.

لا نبني `YemenSoftConnector` عامًا ولا نفترض تشابه كل الإصدارات. أول adapter يكون خاصًا بنظام/إصدار محدد، ولا يطبّق إلا القدرات التي ثبتت دلالاتها بمختبر مضبوط ومصالحة مناسبة. البيانات الواقعية المصرح بها مطلوبة لاحقًا للتحقق لدى الشريك، لا لبدء أول قدرة مخبرية.

تم الوصول إلى نسخة `EFA6_EDU` حقيقية وتثبيتها في مختبر مستقل، وإثبات SQL Server `YSEDU` وdatabase topology ومسار provisioning ونجاح شاشة الدخول. كما ثبتت قراءة least-privilege مستقلة، ومنع `CONTROL SERVER`، وتقنية frozen single-database snapshot من backup متحقق منه. `EFA12026` هي القاعدة الوحيدة المثبتة REQUIRED حاليًا، بينما `Multi_Lang` و`DbRepDes` و`EFAARC10` ليست متطلبات مثبتة للنطاق الأدنى.

محاولات Golden Dataset على النسخة التعليمية كشفت أن إنشاء Customer يتطلب Account، وأن قاعدة التعليم كانت فارغة من دليل الحسابات حتى provisioning رسمي أنشأ 225 صفًا في `Account` و225 صفًا في `Account_Cur_Detail`. لاحقًا توقف مسار Customer عند قاعدة ترقيم sub-account غير المثبتة. بعد المراجعة المستقلة، **لا يُعاد Account Numbering إلى المسار الحرج**. استراتيجية 10 سبتمبر تبدأ بأدلة مخبرية مضبوطة للقدرات المستقلة، ثم تتحقق من تمثيلها وقيمتها ببيانات شريك مصرّح بها وخبير/مستخدم يفسر الحالات الفعلية.

**AlMuhaseb1 مسار مختبري موازٍ لاختبار acquisition boundaries على نظام legacy حقيقي، وليس بديلًا عن Motakamel Plus كـPrimary First Connector Target.** نتيجة Proof-of-Path الحالية له هي `B — PARTIALLY PROVEN`: خمسة domains منظمة مثبتة، بينما Sales Lines وSales Return Lines ما زالتا محجوبتين بفشل runtime في مسار Crystal detail reports. لا يُستأنف كمسار منتج موازٍ دون سبب تجاري/تقني واضح.

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

المراجعة المستقلة 2026-09-06 أكدت أن هذا backend foundation حقيقي، لكنه ليس بعد customer-ready end-to-end product. قبل pilot يجب معالجة targeted P1 trust findings حول runtime field types، source lifecycle cleanup، child-row memory bounds، evidence-driven Canonical Model semantics، provenance/acquisition manifest، deployment security، وstorage forward-version handling.

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
- `Unknown Source Field != Unknown Canonical Field`.
- Currency-safe financial semantics ولا implicit FX.
- Exact decimal arithmetic.
- Streaming/bounded-memory behavior، مع استكمال bounds على child rows قبل pilot.
- Snapshot-bound pagination.
- Pinned read-scope consistency.
- Explicit connector/snapshot provenance، مع توسيع acquisition manifest قبل pilot.
- AI ليس execution authority.
- Strict package/runtime boundaries.
- Normal upper-layer reads تمر عبر Application Service.
- SQL isolation assumptions database-specific.
- Implement first, abstract second.

## الدرس المعماري الحالي

المراجعات المستقلة لم توصِ بإعادة المعمارية. أحدث الحكم هو **CONTINUE WITH CORRECTIONS**.

الـfoundation قوية في contract/structural correctness. يمكن تنفيذ قدرة Motakamel مخبرية ضيقة بعد إثبات معناها ومصالحتها منفردة؛ أما تأهيلها للاستخدام مع شريك وpilot موثوق فيتطلب **representative semantic evidence + reconciliation + operational qualification + user value validation**.

لا نحول هذا إلى framework عام. لأول Motakamel connector ننتج artifacts خاصة بالنظام/version/pilot slice، ثم نستخرج abstraction فقط بعد evidence متكرر.

صرامة التحقيق لا تُخفض: الحد الأدنى من بيانات المختبر الرسمية يخدم إثبات القدرة، والبيانات الواقعية المصرح بها تخدم التحقق لدى الشريك. لا نهيئ ERP كاملًا فقط لفتح اعتماد خارج شريحة المختبر المختارة.

## V1 الحالي باختصار

المستهدف:

- Local Windows application.
- Offline-first.
- Read-only connector لنظام حقيقي واحد في البداية.
- **First pilot slice: Purchase Attention + Item Intelligence** حول سؤال عمل فعلي، وليس Sales Dashboard مفترضًا.
- Item context مرشح ليشمل inventory، previous purchase quantity + subsequent movement، bonus، movement profile، supplier history، وexisting purchase-order context فقط بعد إثبات semantics.
- DBL يبرز ما يستحق الانتباه ويشرح السبب، والإنسان يتخذ قرار الشراء.
- Arabic query/search experience لاحقًا ضمن الواجهة المناسبة.
- Basic reconciliation / provenance.
- Deterministic insights بعد إثبات semantics.

غير داخل V1 الحالي: autonomous purchasing، automatic supplier selection، automatic order quantity prescription، Voice، WhatsApp، unrestricted write actions، multi-industry implementation، LAN/multi-process semantics، Generic Schema Inspector، Universal SQL Connector، generic mapping DSL، full GL ما لم يثبت pilot الحاجة إليه.

## المسار التنفيذي المفضل الآن

`Stage-B storage gate -> preserved W11 Stage A -> W11 Motakamel/SQL installation -> direct GL.exe Computer Use qualification -> resume bounded controlled evidence -> per-capability LAB-PROVEN mapping/reconciliation -> narrow Motakamel connector + focused UI -> Design Partner representative validation -> supervised pilot`

Stage B وS2 لم يبدآ. بدأ S0b كاستكشاف محدود ثم توقف قبل اكتماله؛ لذلك لا يُعلن تأهيل حركة واردة أو Purchase Attention. البيانات الواقعية ليست شرطًا لكل سطر كود مخبري، لكنها شرط لتأهيل الشريك والـpilot. لا يُحذف مختبر قديم لمجرد ضغط المساحة دون إثبات حفظ أدلته وقرار مستقل.

لا نستخدم عدد connectors كمقياس نجاح. الـmoat المحتمل هو تراكم mapping knowledge، semantic fixtures/tests، compatibility profiles، reconciliation knowledge، version/schema drift knowledge، وoperational troubleshooting الذي يخفض تكلفة onboarding والدعم.

## الفصل بين الذاكرة والكود

هذا المستودع هو **ذاكرة المنتج والقرارات والحالة الموثقة**، وليس مستودع التنفيذ.

- Product memory: `elias-mujally/dbl-products-memory/products/legacy-intelligence/`
- Build repository: `elias-mujally/dbl-legacy-intelligence`

في أي جلسة جديدة: تحقق من مستودع البناء قبل ادعاء أن Capability منفذة، ثم حدّث الذاكرة بعد milestones أو قرارات رئيسية.
