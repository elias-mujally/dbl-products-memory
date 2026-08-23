# Legacy Intelligence — Vision

## North Star

> **Make existing businesses intelligent without forcing them to rebuild their technology.**

DBL لا يريد أن يبدأ ببيع ERP جديد لكل شركة. الرؤية هي بناء طبقة ذكاء وتشغيل vendor-neutral تعمل فوق الأنظمة الموجودة أصلًا، خصوصًا الأنظمة المحلية والقديمة وبيئات العمل التي لا تستطيع أو لا تريد migration شاملًا.

المنتج يجب أن يبقى مفيدًا حتى بدون إنترنت، وحتى بدون AI. الذكاء الاصطناعي طبقة تحسين للفهم والتحليل، وليس شرطًا لبقاء المنتج أو الـAgent قابلًا للاستخدام.

## مسار التطور

```text
Read
↓
Understand
↓
Explain
↓
Recommend
↓
Draft
↓
Approve
↓
Execute
↓
Automate
↓
Modernize
```

## الرؤية التقنية طويلة المدى

يتطور المنتج من Connector واحد يدويًا إلى:

- Connector Framework؛
- Canonical Business Model؛
- Schema Inspector؛
- AI-assisted Semantic Mapping؛
- Business Capability Map؛
- Industry Packs؛
- Local Runtime + Optional Cloud Control Plane؛
- Controlled Action Engine؛
- Deterministic Offline Agent؛
- Ready-made Parameterized Command Library؛
- Policy / Permission / Approval Engine؛
- Audit and permissions؛
- multi-system / multi-industry platform.

## Offline Agent بدون AI

الرؤية تشمل Agent برمجي محلي deterministic يستطيع العمل مباشرة بدون إنترنت وبدون LLM.

في وضع Offline Basic، يستخدم العميل مكتبة أوامر جاهزة بدل الاعتماد على محادثة AI. كل أمر معروف مسبقًا ويحتوي متغيرات يمكن للموظف تعديلها مثل:

- الكمية؛
- التاريخ أو الفترة الزمنية؛
- الفرع أو المخزن؛
- المورد أو العميل؛
- المنتج أو مجموعة المنتجات؛
- حد المخزون؛
- صيغة التقرير؛
- وجهة الطباعة.

أمثلة للأوامر:

- إنشاء تقرير مبيعات لفترة محددة؛
- إنشاء تقرير مخزون لفرع أو مخزن؛
- تجهيز تقرير كامل وتصديره PDF أو طباعته؛
- تجهيز طلب شراء لأصناف محددة؛
- تجهيز إعادة توريد للأصناف تحت حد معين؛
- إنشاء ملخص موردين أو عملاء؛
- تنفيذ workflows تشغيلية معروفة ومحددة مسبقًا.

عند توفر AI محلي أو سحابي، يمكنه فقط فهم اللغة الطبيعية وتحويل الطلب إلى Action + Parameters منظمة، ثم يظل الـAgent deterministic هو المسؤول عن التنفيذ.

## مستويات حساسية الإجراءات

كل Action له مستوى حساسية مستقل، ويمكن أن تتغير الحساسية حسب السياق والقيمة المالية.

تصور مبدئي:

- **L0 — Read:** قراءة وبحث وعرض البيانات، بلا موافقة إضافية.
- **L1 — Generate:** إنشاء تقارير وملفات PDF وملخصات وعمليات طباعة، غالبًا بلا موافقة.
- **L2 — Confirmed Action:** أعمال تشغيلية مثل تجهيز أو تنفيذ طلب شراء، تحتاج تأكيد الموظف.
- **L3 — Sensitive Action:** أعمال مالية أو عالية التأثير، تحتاج موظفًا مخولًا وقد تحتاج أكثر من موافقة.

المبدأ: **الـAI لا يقرر الصلاحية ولا يتجاوز السياسة.** Policy Engine deterministic هو الذي يحدد هل ينفذ الأمر مباشرة أو يحتاج Confirmation أو Approval أو Multiple Approvals.

## أوضاع التشغيل

1. **Offline Basic:** Intelligence deterministic + Agent Commands، بدون AI.
2. **Offline Intelligent:** Local AI + Deterministic Agent.
3. **Hybrid:** Local Core + Agent + Cloud اختياري للذكاء أو الخدمات المتقدمة.

## نموذج الاشتراك للـAgent

خدمة الـAgent ليست شراءً دائمًا تابعًا للمنتج، بل **اشتراك مستقل**.

ولأن بعض العملاء قد يعملون Offline لفترات طويلة، يجب أن يدعم التصميم Entitlement أو License موقّعًا رقميًا يمكن التحقق منه محليًا، ويحتوي مدة الصلاحية والميزات المفعلة، دون الحاجة لاتصال دائم بالإنترنت.

الاشتراك السنوي مناسب خصوصًا للعملاء Offline، مع إمكانية نماذج أقصر للعملاء المتصلين.

## الرؤية السوقية

الرؤية ليست محصورة بالتجزئة والجملة. يمكن لاحقًا دعم قطاعات مثل:

- retail؛
- wholesale/distribution؛
- pharma؛
- clinics operations؛
- laboratories؛
- manufacturing؛
- service businesses؛
- spare parts / automotive؛
- قطاعات أخرى عندما توجد أنظمة قديمة وworkflow غني يمكن تحسينه.

## قاعدة التوسع

الرؤية أفقية واسعة، لكن الدخول للسوق رأسي وضيق.

ابدأ بقطاع واحد، نظام واحد، وworkflow واحد، ثم استخرج المشترك فقط بعد تكراره فعليًا.
