# مراجعة PR34 — تكامل واجهة المخزون (2026-10-28)

الحكم عند الرأس e5c820e365b4c3c323848997fe44c9799eb3af3a: **REQUEST CHANGES؛ غير جاهز للدمج أو مراجعة المالك كتطبيق متكامل.**

## مراجع ثابتة ونطاق

- [PR34](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/34)، يستهدف فرع تكامل PR33، لا main.
- [ملاحظات Codex المرسلة إلى Antigravity](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/34#issuecomment-6459348686).
- [رأس التكامل المعتمدf0c384b](https://github.com/elias-mujally/dbl-legacy-intelligence/commit/f0c384b05ddf846094207e1b4991219509e9f94d)، و[عقد IPC التنفيذي](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/f0c384b05ddf846094207e1b4991219509e9f94d/experiments/desktop-d3-integration/IPC_CONTRACT_AR.md).
- تغييرات PR34 ثلاثة ملفات فقط في experiments/desktop-d2: index.html وstyles.css وrenderer.js. لا تعديلات main/preload/IPC/engine/Application Service. الاتجاه المؤسسي وRTL والثيمات محفوظة في المصدر؛ تأهيل العرض الفعلي لهذا الرأس غير منفذ.

Git compare أثبت diverged: ahead1، behind3، والـmerge-base/parent هو2d837f5 (PR32). تعيين base إلى فرع PR33 لا يعني احتواء فرع PR34 على كوده. الرأس لا يحتوي ملفات تجربة IPC. يلزم تحديث فرع Antigravity من التكامل دون force push، ثم إعادة المراجعة على رأس محدد. لا دمج أي PR.

## العوائق المؤكدة

| المعرف | الأولوية | موضع المصدر عند الرأس أعلاه | الخلل والمعالجة المطلوبة |
|---|---|---|---|
| R1 | P1 | renderer.js:344–362،445–492،527–559 | غياب الخدمة يصنع design rows/context/summary وقيمة600 ثم يدعي الاتصال. احذف fallback من وضع التشغيل؛ أي fixture تصميمية تكون صريحة ومنفصلة. |
| R2 | P1 | renderer.js:527–528؛ preload/main D2؛ فرع Git | host D2 لا يعرّض inventory؛ عقد PR33 المنفذ هو window.dblInventory لا window.dblDesktop.inventory المذكور في طلب المالك. sources غير مستدعاة وopenLatest بلا sourceSelectionRef. Codex مسؤول عن host/preload مشترك يحقق namespace المطلوب مع نفس خمس العمليات والتحقق، دون تغيير العقد الخلفي. Antigravity لا يغيّر IPC أو يصنع alias مزيفًا. |
| R3 | P1 | لا listener في renderer | لا معالجة لإشعار انتهاء السياق أو سقوط العامل؛ يجب محو الأرقام فورًا مع حماية السياق الأحدث من إشعار قديم. |
| R4 | P1 | renderer.js:510–575،495–502،364–418 | رد فتح قديم يستبدل أحدث؛ لا ربط كامل لردود page/detail بالـreadRef/snapshot/الصف. اجمع generation + source/read/snapshot لكل نجاح وخطأ. |
| R5 | P1 | renderer.js:157–171،367–373،419–423 | خطأ تفاصيل مبطل يبقي الجدول والإجمالي؛ clear لا يمحو الترويسة/السياق/التغطية كلها. وحّد الفشل وإعادة الفتح الصريحة. |
| R6 | P1 | index.html ولافتات/summary/loading | تأهيل تاريخي/واجهة منتج معتمدة/مخزن رئيسي/تغطية مكتملة قبل الإثبات؛ ادعاء قراءة حركات ومطابقة غير موجودة في DTO. استعمل context الاصطناعي وحدوده، دون تسمية مخمنة أو اعتماد ERP/GL/توقيع. |
| R7 | P2 | renderer.js:25–81،964–966؛ callbacks التبويبين | التنقل يخفي الخطأ ولا يعيده؛ D2 تفتح وتهيئ fixture أثناء D3، والـfooter مشترك بلا ربط بالتبويب. افتح D2 عند طلبها فقط واحفظ حالتي العرض دون خلط. |

صحة تفسير الصفر والإجمالي موجودة جزئيًا في كود العرض: لا جمع مالي من الصفوف، وavailable0 مختلف عنunavailable. لكنها لا تعوّض غياب المسار التنفيذي، وتبقى stale-state/capture binding بحاجة إصلاح. مثال partial design ليس قدرة mixed/partial V1 في Runtime؛ هذا يرفض البيانات الناقصة كليًا.

## أدلة مستقلة وحدودها

ملف renderer المراجع: Git blob a4113afc3ce10addaa87b83f11b64f2d884549f0، SHA256:
3C87AF9A1DFA966ADA4F30625F270B68B12044E6A0C12DA4B3F0D7CEFE32BD4E.

نفذت8 probes على المصدر غير المعدل داخل Node22 VM وDOM اصطناعي محدود. كلها أعادت إنتاج العيوب المستهدفة: fallback بلا خدمة، تجاهل bridge الحقيقي، غياب sourceSelectionRef، انعدام lifecycle listener، بقاء أرقام بعد خطأ تفاصيل مبطل، عرض page غير مطابقة، سباق فتح قديم/جديد، واختفاء الخطأ بعد تبديل التبويب. هذه **إعادة إنتاج عيوب، وليست8 اختبارات قبول ناجحة**. probe الرد المخالف يثبت نقص ربط controller، ولا يدعي اختراق backend المستقل المتحقق.

نتيجة probe محلية محفوظة ببصمة9719245C3CFC5E859853723A809D54CC3091F11608D256D0A4381763FB2FC169؛ أُرفق ملخصها المنقح فقط. no private originals/configs/SQLite/raw acquisitions.

نجح node --check. انحدار D1/D2 المستقل:49 ناجحًا، صفر فاشل/متجاوز، على Node22 وRuntime الموجود دون تثبيت. انحدار قارئPR32 وعاملPR33:71 ناجحًا، صفر فاشل/متجاوز، في fixtures اصطناعية جديدة. مجموع انحدار الخلفية120 ناجحًا؛ لا يُستنتج نجاح UI من ذلك.

[CI العام لـPR34،40621965424](https://github.com/elias-mujally/dbl-legacy-intelligence/actions/runs/40621965424) ناجح على Windows/Ubuntu. CI المتخصص D3 غير موجود في الرأس المتفرع قبلPR33؛ الأخضر لا يثبت اختبار frontend أو inventory IPC.
[CI العام لـPR33 عندf0](https://github.com/elias-mujally/dbl-legacy-intelligence/actions/runs/40621435265) و[المتخصص](https://github.com/elias-mujally/dbl-legacy-intelligence/actions/runs/40621435406) مكتملان بنجاح؛ R2 السابقة16/16 تخص واجهته الهندسية فقط، لا واجهةPR34.

## الاستئناف المشروط

1. Antigravity يصلح UI في فرعه ويرسل الرأس المحدد؛ مسؤولية controller/backend/host تبقى Codex.
2. Codex يعيد مقارنة الأساس والملفات ثم يوفر glue مشتركة محدودة لـwindow.dblDesktop.inventory، بعقد العمليات والـDTO الحاليين، دون هدم تجربةD3 السابقة أو تغيير D2 المرجعية/تهيئتها عند قراءة المخزون.
3. تشغيل حقيقي داخل Electron بنفس أسلوب جلسة المالك العادية معsandbox، بعد تثبيت البصمات: غياب خدمة بلاfixture، المصادر/الفتح، البحث/الصفحات/التفاصيل، ثبات الإجمالي، صفر/غيرمتاح/نسخة ناقصة، expiry/loss/reopen، الردود المتأخرة، D2↔D3 بلا خلط أو تهيئة غير مطلوبة، footprints.
4. فحص الصور الفعلي وLight/Dark والتباين فوق الخلفيات الفعلية، وTab/Enter في التطبيق. لم تُنفذ هذه علىPR34 في هذا السجل؛ لا احتساب صور التصميم/اختبارات المتصفح كقبولElectron.
5. فقط بعد نجاح المعايير ومراجعة النطاق يمكن دمجPR34 في فرع D3 الذي أجازه المالك؛ لا main. تبقى A16/Narrator/Windows والإنتاج وV1 الفعلية غير مؤهلة. إذا استلزم glue تغيير بروتوكول/عقد عام أو سلوك تخزين حساس، يعرض أولًا.

لم نعدّل ملفات المنتج أو الفرعين، ولم نفتح ERP/V1 الفعلية أو Preview1 أو نغيّر صلاحيات/شبكة/حماية/تبعيات. ملاحظات المراجعة أُرسلت؛ لا نفترض رد Antigravity أو اكتمال المعالجة.
