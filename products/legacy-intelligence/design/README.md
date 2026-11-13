# DBL Legacy Intelligence — فهرس التصميم وأدلة التنفيذ

آخر تنظيم للفهرس: 2026-11-13، ضمن قرار المالك بأرشفة الدراسة الأولى. التصميم والتخطيط منفصلان عن التنفيذ والقبول التشغيلي؛ لا يعتمد هذا الفهرس إطارًا جديدًا أو جاهزية لبيانات العملاء.

## ابدأ بالدراسة الأحدث وقرار التصميم

1. [Windows Desktop Experience V1 — دراسة 2026-10-27](windows-desktop-v1-20261027/README.md): مرجع الاكتشاف الأحدث من دراسة أكتوبر25، ويتضمن القدرات وUX والمعمارية والبوابات. تُقرأ مقترحاته في تاريخها، لا بوصفها قبولًا إنتاجيًا أو وصفًا تلقائيًا لكل ما نُفذ لاحقًا.
2. [قرار المالك باختيار الاتجاه البصري الأول في D0](windows-desktop-d0-20261027/OWNER_SELECTION_AR.md)، مع [ملفات المقارنة والنماذج](windows-desktop-d0-20261027/README.md).

## أدلة التنفيذ والتجارب اللاحقة

هذه سجلات مؤرخة بدرجات إثبات وحدود مختلفة؛ لا تجمع نجاحاتها المتداخلة أو تحول الاختبارات الاصطناعية إلى تأهيل مصدر حقيقي.

- [D1 — التكامل التقني الأول](../engineering/windows-desktop-d1-20261027/README.md).
- [D2 — واجهة الأصناف](../engineering/windows-desktop-d2-products-20261027/README.md).
- [D3 — دمج المخزون التاريخي وHost/Preload المشتركين](../engineering/windows-desktop-d3-electron-integration-20261028/README.md).
- [قراءة الملفات المستخرجة المحفوظة](../engineering/desktop-real-v1/README.md) و[التحديث اليدوي والاستقرار](../engineering/desktop-file-refresh/README.md).
- [تجربة الأصناف المتغيرة](../engineering/variable-lab-inventory/README.md)، ثم [المزامنة المحلية وبواباتها](../engineering/native-catalog-sync/README.md) و[تجهيز المختبر وحدود الاستعادة والثقة](../engineering/self-contained-lab/README.md).
- النماذج التصميمية المصححة محفوظة بمعزل عن التطبيق: [النموذج الشامل](https://github.com/elias-mujally/dbl-legacy-intelligence/tree/9b6cc4f8b84af9ea774809bc6bb1bbd7ebc2d0f7/experiments/desktop-d3) و[Workspace V2](https://github.com/elias-mujally/dbl-legacy-intelligence/tree/9b6cc4f8b84af9ea774809bc6bb1bbd7ebc2d0f7/experiments/desktop-workspace-v2). حفظها لا يعني دمج صفحاتها التسع في Electron أو ربطها بـERP.

## أرشيف الدراسة الأولى — 2026-10-25

[Windows Desktop UI/UX — Discovery, Architecture & Design](windows-desktop/README.md) دراسة تاريخية محفوظة للمقارنة وتتبع القرار، بعد الدراسة الأحدث وأدلة التنفيذ أعلاه. اقتراح Electron/React/TypeScript فيها ليس اختيارًا تقنيًا جديدًا أو وصفًا ملزمًا للـRenderer المنفذ. أُبقي محتوى حزمة الدراسة وبصماتها التاريخية دون تعديل؛ ملاحظة تدقيق2026-11-03 الموجودة في README محفوظة أيضًا.

ملف PROPOSAL_MANIFEST.json يصف لقطة الدراسة الأصلية، ولا يعيد تأهيل الفهرس الجامع الحالي أو الملاحظات اللاحقة. تُراجع بصماته عند [التزام النشر الأصلي e6a6156](https://github.com/elias-mujally/dbl-products-memory/tree/e6a615616a0bf8f7b83a1680d51571f1951400b0/products/legacy-intelligence/design)، حيث يوجد الفهرس الأصلي أيضًا؛ لم تُعد كتابة البصمات القديمة لتوحي بتحقق جديد.

## حدود القراءة والقرار

لا يغيّر هذا الترتيب عقود المحرك أو Preview1 أو صلاحيات المصدر. لا يجعل المصدر مؤهلًا لـTrusted Catalog، ولا يثبت الاستعادة أو المزامنة الفعلية، ولا يغلق A16 أوNarrator أو تأهيلWindows أو الإنتاج. يُرجع في الحالة الهندسية إلى الأدلة المؤرخة، ويظل الانتقال إلى تنفيذ أو تأهيل جديد خاضعًا لقرار مستقل.
