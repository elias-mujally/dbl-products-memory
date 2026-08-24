# Legacy Intelligence — Current Status

آخر تحديث: **2026-08-24**

## الحالة

**BUILD IN PROGRESS — Foundation hardening completed and merged**

تم الانتقال رسميًا من مرحلة الدراسة والتخطيط إلى التنفيذ، ثم بناء وتقوية الأساس الهندسي لـV1 قبل التوسع في الميزات.

## Milestone المنجز — 2026-08-24

تم إنهاء **Foundation Hardening Round 2** في مستودع البناء:

`elias-mujally/dbl-legacy-intelligence`

ثم تمت مراجعة الإصلاحات مراجعة مركزة إضافية ونجحت CI النهائية على Ubuntu وWindows قبل الدمج.

تم دمج PR #5 إلى `main` بنجاح باستخدام Squash Merge.

- PR: `#5 — Foundation Hardening Round 2`
- Merge commit: `ab3db09c5afebaea1db741087af146c9771b32cc`
- الحالة بعد الدمج: لا يوجد blocker معماري معروف يمنع البناء فوق الأساس الحالي في نطاق المرحلة الحالية.

## ما تم تقويته وإغلاقه

تم إغلاق ست نقاط هندسية رئيسية بالكود والاختبارات:

1. **Canonical decimal contract**
   - تشديد التمثيل canonical للأرقام العشرية.
   - رفض تمثيلات غير canonical مثل `10.10` و`-0` حيث لا يسمح العقد بها.

2. **Bounded batch imports**
   - فرض حدود واضحة على عمليات batch لمنع مدخلات غير محدودة أو سلوكيات ذاكرة خطرة.

3. **Runtime connector validation**
   - التحقق الفعلي من شكل وقدرات الـConnector وقت التشغيل بدل الثقة في metadata أو TypeScript فقط.
   - دعم Semantic Versioning المتوافق للـConnector API بدل ربط النوع بقيمة literal واحدة.

4. **Mechanical migration checksum / drift detection**
   - جعل تغير ملفات migrations ينعكس ميكانيكيًا على checksum بدل الاعتماد على تحديث يدوي قابل للنسيان.

5. **Crash recovery for staging**
   - إضافة تنظيف/استعادة لحالات staging المتروكة بعد crash أو restart.
   - تم توثيق invariant أن SQLite الحالية مصممة كـsingle-writer desktop store في هذه المرحلة.
   - أي توسع مستقبلي إلى LAN أو multi-process يجب ألا يفترض أن semantics الحالية كافية دون تصميم جديد مناسب.

6. **Deterministic read-only CI/build discipline**
   - إزالة خطوة npm global غير الضرورية التي سببت تعطل Windows runner.
   - الاعتماد على locked install عبر `npm ci`.
   - الحفاظ على build/typecheck/tests كحواجز قبل الدمج.

## نتيجة التحقق

الجولة النهائية قبل الدمج نجحت على:

### Ubuntu
- `npm ci` ✅
- فحص الثغرات الحرجة ✅
- build ✅
- strict TypeScript typecheck ✅
- tests ✅

### Windows
- `npm ci` ✅
- build ✅
- strict TypeScript typecheck ✅
- tests ✅

النتيجة: **Foundation Hardening Round 2 passed and merged.**

## الهدف التنفيذي الحالي لـV1

نواصل بناء أول نسخة Demo-ready مع الحفاظ على Scope ضيق:

- تطبيق Windows محلي.
- Offline-first.
- Read-only في V1.
- Connector واحد فقط في البداية.
- Canonical Business Model أولي.
- دعم Products / Inventory / Customers / Sales.
- واجهة عربية بسيطة لاحقًا فوق الأساس.
- Query/Search فوق البيانات الفعلية.
- Basic reports.
- لا Voice في V1.
- لا WhatsApp في V1.
- لا Write Actions في V1.
- لا Multi-industry implementation في V1.

## قاعدة السلامة

الـLLM لا ينفذ SQL حر على قاعدة العميل ولا يكتب في ERP في V1.

المسار المستهدف:

`User Query -> Intent/Query Plan -> Validated Read Operation -> Connector -> Canonical Result -> Answer`

## الفصل بين المستودعات

مستودع البناء:

`elias-mujally/dbl-legacy-intelligence`

ذاكرة المنتج والقرارات الاستراتيجية:

`elias-mujally/dbl-products-memory/products/legacy-intelligence/`

يجب إبقاء ذاكرة المنتج منفصلة عن كود التنفيذ، وتسجيل milestones والقرارات المهمة هنا بعد التحقق من مستودع البناء.

## Milestone التالي

**Continue V1 implementation on top of the hardened foundation without reopening solved invariants unless new evidence requires it.**

الأولوية الآن هي التقدم الوظيفي المنضبط فوق الأساس الحالي، مع الحفاظ على حدود Core / Connectors / Canonical Model / Storage / AI واضحة وقابلة للتوسع.
