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

مستودع البناء هو:

`elias-mujally/dbl-legacy-intelligence`

تم الانتهاء من **Foundation Hardening Round 2** ودمج PR #5 إلى `main` بعد نجاح المراجعة والـCI على Ubuntu وWindows.

Merge commit المرجعي:

`ab3db09c5afebaea1db741087af146c9771b32cc`

أهم invariants التي أصبحت مثبتة بالكود والاختبارات:

- canonical decimal representation صار strict.
- batch imports أصبحت bounded.
- Connector shape/capabilities يتم التحقق منها Runtime.
- Connector API versioning يستخدم semantic compatibility بدل literal-only typing.
- migration drift/checksum أصبح ميكانيكيًا.
- staging لديها crash recovery/cleanup.
- SQLite في المرحلة الحالية **single-writer desktop store**؛ لا تعتبر semantics الحالية multi-process أو LAN-safe تلقائيًا.
- CI تعتمد locked `npm ci` وتتحقق من build + strict typecheck + tests على Ubuntu وWindows.

لا يوجد blocker معماري معروف حاليًا يمنع مواصلة V1 فوق هذا الأساس ضمن scope المرحلة الحالية.

## قاعدة مهمة لأي AI أو مطور يكمل العمل

لا تعِد فتح invariants المحسومة أعلاه أو تضعفها لتسهيل Feature جديدة إلا إذا ظهر دليل تقني واضح يستوجب تغيير القرار. أي توسع مثل LAN، multi-process، write actions أو multi-industry يجب أن يضيف تصميمًا مناسبًا بدل افتراض أن قيود V1 الحالية تغطيه.

## أوضاع التشغيل المستهدفة

1. Offline Basic: deterministic intelligence + Agent commands، بدون AI.
2. Offline Intelligent: Local AI + deterministic Agent.
3. Hybrid: Local Core + Agent + Cloud اختياري.

## الفصل بين البناء والذاكرة

مستودع البناء الحالي هو `elias-mujally/dbl-legacy-intelligence`، بينما هذا المستودع `elias-mujally/dbl-products-memory` هو المرجع الاستراتيجي وذاكرة المنتج.

لا تنقل الرؤية أو القرارات الاستراتيجية إلى مستودع البناء إلا إذا أصبحت متطلبات تنفيذية فعلية. وبالمقابل، milestones التنفيذية المهمة يجب تلخيصها هنا بعد التحقق منها حتى لا تضيع حالة المشروع بين الجلسات.

## التسلسل المقترح

V1: أول Connector يدوي + Canonical Model أولي + Local read-only intelligence.

V2: فصل mapping عن connector.

V3: Generic SQL Schema Inspector.

V4: AI-assisted semantic mapping.

V5: Capability detection.

V6: Industry Packs وتجربة شبه عامة على أنظمة وقطاعات متعددة.

Controlled actions وOffline Agent تأتي بعد إثبات الأساس Read-only، ولا يجب أن توسع نطاق V1 قبل أوانه.

## التحذير التنفيذي

لا تدّعِ أن Capability منفذة لمجرد وجودها في الرؤية أو الRoadmap. تحقق من مستودع الكود أولًا.

آخر نقطة تنفيذية موثقة: **Foundation Hardening Round 2 merged successfully on 2026-08-24; continue V1 implementation from the hardened `main`.**
