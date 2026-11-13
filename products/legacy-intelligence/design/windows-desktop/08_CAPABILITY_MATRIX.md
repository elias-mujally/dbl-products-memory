# Feature → Engine Capability Matrix

2026-10-25 · **كل واجهة GUI جديدة Requires Engineering**، حتى حيث أساس المحرك Proven / Existing. التصنيفات التالية تخص الأساس أو الميزة المحددة، وليست شهادة Desktop مكتملة. [خريطة الشاشات](03_SCREEN_MAP_AND_FLOWS.md) · [مصادر الكود](09_SOURCES_AND_VERIFICATION.md).

| ID | الميزة/الشاشة | الأساس الموجود ودليله | التصنيف | العمل/القيد |
| --- | --- | --- | --- | --- |
| C01 | welcome ولغة/مظهر S00 | لا shell أو preferences GUI حالية | Requires Engineering | i18n/resources/theme محلية؛ لا تغيير report Preview1 |
| C02 | إنشاء/فتح workspace S01 | state marker/profile ومسار وقفل موجودة K03 | Proven / Existing للآلية؛ GUI Requires Engineering | registry ومساحة state جديدة واختيار عبر نظام؛ لا تعامل مع SQLite كملف منفرد |
| C03 | ضمان خصوصية Windows | الكود يستثني Windows من استنتاج POSIX mode K03 | Requires Engineering / gate open | فحص ACL فعلي، لا auto-repair؛ لا شارة آمن من ack |
| C04 | اختيار ملف محلي S20 | المحرك يأخذ path/hash، لا file picker K01 | Requires Engineering | native picker و token ونطاق ملف فقط؛ لا مستكشف أقراص عام |
| C05 | تحقق بصمة/هوية/profile S20 | checkV1Source/loadV1RawAcquisition وملف<=4MiB K01/K02 | Proven / Existing | trusted expected hash منفصل؛ أي JSON ليس ملف ERP مدعومًا |
| C06 | معاينة قبل الحفظ S21 | check يعيد products/value/capturedAt/caveats K01 | Proven / Existing للبيانات؛ GUI Requires Engineering | DTO محدود ونعيد تحقق الملف عند import؛ المعاينة لا تحفظ |
| C07 | حفظ المصدر/لقطة S21 | refreshV1File و control admission/audit K03 | Proven / Existing | job orchestration ومراجعة أثر وإظهار outcome، دون تجاوز المحرك |
| C08 | replay/منع الرجوع | actual third-source/import/replay/history؛ code ordering K03/M01 | Proven / Existing | لا snapshot جديدة من نفس المصدر؛ القديم المعروف يراجع دون rollback |
| C09 | الإلغاء/progress/إغلاق النافذة | CLI يعطي نتيجة نهائية لا progress protocol K01 | Requires Engineering | مراحل بلا نسبة مزيفة، cancellation قبل write، unknown outcome بعد انقطاع |
| C10 | ملخص 5 أصناف/قيمة S10 | inspectV1State current/history، قيد 5 لكل snapshot K01 | Proven / Existing | لا تعميم count/fixtures أو تحميل 5000 ضمن هذا wrapper |
| C11 | تكلفة/كمية/قيمة | mapped quantity/costPrice و decimal valuation K02/K05 | Proven / Existing ضمن الملف | لا FIFO/weighted average عام أو FX؛ توضيح partial والتغطية |
| C12 | وقت و provenance | capturedAt/snapshotId/source/hash و observedAt K01/K04 | Proven / Existing للحقول | فصل وقت المصدر والاستيراد والفحص وتجميع UI؛ لا freshness حية |
| C13 | بحث/فلاتر/صفحات S30 | core QueryPlan sku/name/id والكمية و cursor K04 | Proven / Existing في core؛ ربط Desktop Requires Engineering | CLI status ليس query endpoint؛ لا بروتوكول عام مكشوف |
| C14 | فرز أعمدة S30 | لا sort في QueryPlan K04 | Requires Engineering | فرز محلي للخمسة أو API محدود مؤهل؛ لا فرز صفحة وكأنها كامل البيانات |
| C15 | تفاصيل صنف S31 | current/history products K01 | Proven / Existing للحقول؛ GUI Requires Engineering | unit/group/warehouse ليست Canonical entities عامة؛ ما لا يوجد لا يُخترع |
| C16 | مقارنة لقطة بلقطة S40 | history موجود، ApplicationReadScope الحالي latest فقط K01/K04 | Requires Engineering | snapshot-aware DTO/diff دقيق لنفس scope؛ لا claim API تاريخي جاهز |
| C17 | رسم تغير القيمة | history+decimal inputs متاحة K01 | Requires Engineering | نقاط رصد وجدول بديل؛ لا interpolation أو توقع أيام مفقودة |
| C18 | تنبيه كمية<=عتبة | LowStockRule حد DBL الافتراضي 5 K05 | Proven / Existing كقاعدة حسابية | لا عجز/فائض ERP؛ UI تجريبي مسمى أو مؤجل، ليس توصية شراء |
| C19 | تفسير مصدر الرقم | qualification فيه ledger/cost/journal/caveats K02 | Requires Engineering للعرض | لا نرسل raw acquisition؛ تلخيص مسند وربط هوية ونطاق |
| C20 | HTML عربي محلي S50 | reportV1State escaped/CSP/new file K01 | Proven / Existing | GUI destination/result وفتح آمن جديد؛ تقرير المظهر الحالي ثابت |
| C21 | PDF/Excel/طباعة احترافية | ليست أوامر التصدير المؤهلة | Future / Not Qualified | لا زر export يوحي بجاهزيتها؛ HTML فقط في الأولى |
| C22 | تاريخ اللقطات S60 | history وقيمة/منتجات/بصمة لكل snapshot K01 | Proven / Existing | UI اختيار ثابت؛ لا حذف/تعديل تاريخ |
| C23 | قائمة عمليات مفصلة S60 | status يعطي counts/unfinished/pending، runs/audit محفوظة K01/K03 | Requires Engineering | إسقاط آمن ومحدود وتصفح جديد؛ لا مساواة counts بواجهة سجل كاملة |
| C24 | backup/verify/restore S61 | أوامر قائمة سماح، manifestpin، new target K01 | Proven / Existing | معالج وتأكيدات وتحقق/تبديل صريح؛ لا replacement |
| C25 | تشفير أو off-host أو VM/ERP restore | DBL backup محلي فقط؛ بوابات مستقلة M02 | Future / Not Qualified | لا تصويرها كقدرة زر النسخ الحالية |
| C26 | الإصدار/doctor S70 | launcher verify/doctor و Node/ABI/SQLite K06 | Proven / Existing للـ CLI | health DTO/صفحة جديدة؛ لا تثبيت DLL أو كشف process/env عام |
| C27 | Read-only ERP | مصدر ملف؛ لا SQL مباشر في الحزمة K01/K06 | Proven / Existing للنطاق | DBL يكتب ملفاته المحلية؛ لا منح renderer صلاحية SQL أو shell |
| C28 | دعم أي Motakamel/CSV/SQL حي | profile يشترط SKU والنطاقوالهوية/التكلفة K02 | Future / Not Qualified | يحتاج توسيع موصل مستقل؛ لا تخفيف checks خلف UI |
| C29 | مبيعات/عملاء/إيرادات | core abstractions/rules موجودة؛ V1 لم يقتن بياناتها K02/K05 | Future / Not Qualified لهذه العينة | لا بطاقات صفر أو استخدام الصرف كبيع |
| C30 | طلب شراء/تتبع توريد/GL نهائي | requisitions غير مقتناة، Posted=false M01/K02 | Future / Not Qualified | لا مستلم متوقع أو ترحيل محاسبي نهائي مفترض |
| C31 | فائض/عجز/تنبؤ/AI recommendations | لا منهجية/بيانات مؤهلة | Future / Not Qualified | وصف فروق الأرصدة فقط؛ لا تفعيل ذكاء سحابي |
| C32 | Ibdaa/5000/e-commerce | اكتشاف عميل فقط M03 | Future / Not Qualified | لا UI scaffold كادعاء دعم أو مزامنة |
| C33 | RTL/Light/Dark/accessibility | HTML عربي أساسي + إفادة بصرية؛ لا Desktop | Requires Engineering | وصول/موارد/اختبارات UI؛ لا يعادل report browser مرور Desktop |
| C34 | تجميع/حزمة وتحديث Desktop | Preview1 CLI فقط K06/M02 | Requires Engineering | إصدار جديد وتوقيع/manifest/SDK permissions واختبار supportedWindows؛ لا إعادةتغليف Preview1 |

## حدود كمية مثبتة بالكود، لا أهداف منتج عامة

عينة خمسة SKU، فرع 1/مخزن 1/وحدة 1/عبوة 1/SAR وتكلفة ثابتة لكل صنف؛32 لقطة و 256 محاولة بحدود الاحتفاظ، و 16pending يوقف القبول. مصدر raw حتى 4MiB. تحقق/نسخة المشغّل يضع حدود 1024 ملفًا و 128MiB للملف و 512MiB للمجموع؛ ليست اختبارات أداء بهذا الحجم. QueryPlan افتراضي 50 وحد أقصى 200 للصفحة،20 فلترًا وطول 512 للنص. هذه القيود لا ترفع حد wrapper ذي الخمسة، ولا ينبغي إخفاؤها عن خطة التوسع.

**لم تُجر اختبارات تشغيل جديدة في هذه المرحلة.** Proven هنا يربط التنفيذ والمقروء والقبول السابق، و Requires Engineering لا يعني الموافقة على كتابته الآن.
