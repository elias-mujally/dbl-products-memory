# AI Handoff — Legacy Intelligence

## الهدف

هذا الملف يتيح لأي مساعد AI أو مطور فهم مبادرة Legacy Intelligence بسرعة دون قراءة بقية منتجات DBL.

## اقرأ أولًا

1. `README.md`
2. `VISION.md`
3. `ROADMAP.md`
4. `MARKET_STUDY_2026-08-21.md`
5. `MULTI_INDUSTRY_VISION_2026-08-21.md`
6. `DECISIONS.md`

## الوصف الحالي

DBL يدرس بناء **Local-First Legacy ERP Intelligence Layer**: طبقة ذكاء وتشغيل محلية فوق ERP/POS/Accounting/Custom Systems القديمة، تعمل بدون اعتماد دائم على الإنترنت، وتتحول تدريجيًا من Read-only intelligence إلى controlled actions ثم automation.

الرؤية الآن تتضمن Agent برمجي deterministic يعمل Offline حتى بدون AI. في هذا الوضع يستخدم العميل أوامر جاهزة ذات Parameters قابلة للتعديل مثل الكمية والتاريخ والفرع والمورد والمخزن والمنتج وصيغة التقرير ووجهة الطباعة.

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

## أوضاع التشغيل المستهدفة

1. Offline Basic: deterministic intelligence + Agent commands، بدون AI.
2. Offline Intelligent: Local AI + deterministic Agent.
3. Hybrid: Local Core + Agent + Cloud اختياري.

## الحالة الحالية

مستودع البناء الحالي هو `elias-mujally/dbl-legacy-intelligence`، بينما هذا المستودع `dbl-product-memory` هو المرجع الاستراتيجي والذاكرة الخاصة بالمنتج. لا تنقل الرؤية أو القرارات الاستراتيجية إلى مستودع البناء إلا إذا أصبحت متطلبات تنفيذية فعلية.

## التسلسل المقترح

V1: أول Connector يدوي + Canonical Model أولي + Local read-only intelligence.

V2: فصل mapping عن connector.

V3: Generic SQL Schema Inspector.

V4: AI-assisted semantic mapping.

V5: Capability detection.

V6: Industry Packs وتجربة شبه عامة على أنظمة وقطاعات متعددة.

Controlled actions وOffline Agent تأتي بعد إثبات الأساس Read-only، ولا يجب أن توسع نطاق V1 قبل أوانه.

## تحذير

لا تدّعِ أن أي Capability منفذة قبل التحقق من مستودع الكود الخاص بالمنتج.
