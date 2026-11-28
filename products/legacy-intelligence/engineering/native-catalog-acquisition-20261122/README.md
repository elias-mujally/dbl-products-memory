# أول اقتناء Native Catalog حقيقي محدود داخل VM — 2026-11-22

**VERIFIED — REAL TOP(5) ERP → Native helper → acquireSharedMemoryCatalog → Canonical في RAM فقط.**

[الحالة الحالية](../../CURRENT_STATUS.md) · [تسلسل التقدم](../../PROGRESS_HISTORY.md) · [الخطوة المقترحة](../../ROADMAP.md) · [ADR-001 المعتمد، دون تعديل](../../DECISIONS/ADR-001-SQL-SERVER-DUAL-TRANSPORT.md) · [فهرس الإيصالات والبصمات المنقح](EVIDENCE_INDEX.json).

هذا هو المرجع المركزي لسلسلة تجارب Native Catalog المنتهية في 22 نوفمبر، وليس إعادة تدقيق لكل تاريخ ERP/PKI. **لم تُشغّل SQL أو VM أو helpers أو اختبارات المنتج في مهمة تسجيل الذاكرة.** VERIFIED هنا يعني قراءة إيصال أصلي محفوظ والتحقق من بصمته أو قراءة كود محدد؛ ونميز التنفيذ الحي عن الاختبار Offline/الاصطناعي. FAILED محفوظ ضمن تجربته؛ NOT VERIFIED لا يعني صفرًا أو نجاحًا.

نطاق «الأول» هو **Native Catalog Connector داخل DBL-MotakamelPlus-lab-V1**؛ تبقى اقتناءات الملفات والمضيف وItem identity الأقدم في [تاريخ المنتج](../../PROGRESS_HISTORY.md) بنتائجها الأصلية.

## الأساس ومصدر الحقيقة

ذاكرة `main` تحققت قراءةً من GitHub عند [`bd09d568986c1cb588fc2e8df624c4ad80f0667b`](https://github.com/elias-mujally/dbl-products-memory/commit/bd09d568986c1cb588fc2e8df624c4ad80f0667b)، دمج PR35. المنتج `main` عند [`2f24efa50b71c4d91667dc12049c7a6ecc9e70b8`](https://github.com/elias-mujally/dbl-legacy-intelligence/commit/2f24efa50b71c4d91667dc12049c7a6ecc9e70b8).

تنفيذ Shared Memory/Native/Desktop اللاحق **تطوير محلي غير ملتزم به** فوق main على `codex/direct-erp-workspace-20261114`. النجاح يخص الحزمة الجانبية المثبتة أدناه، ولا يُنسب إلى شريحة Workspace/C0 المدمجة أو إلى التثبيت القديم. فُحصت بصمات ملفات C# الأربعة وملفات Node الثلاثة من BUILD_RECEIPT مقابل المصدر المحلي؛ مراجعها في الفهرس دون نسخ كود أو اعتماد.

## تسلسل التجارب

كل التواريخ أدناه في **عدن، UTC+03:00**؛ أوقات UTC الأصلية محفوظة في الفهرس. معرفات التشغيل مستهلكة ولا تُعاد استخدامها.

| التاريخ/المرحلة | RunId أو المواد | النتيجة وحد الإثبات | الأدلة |
|---|---|---|---|
| 22 نوفمبر، 00:05 — Controller v3 | `8e2856c19b65431390415164fff4411f` | **FAILED preflight:** READER_SECURITY_BASELINE_DEVIATION. Start/Stop واحدان؛ runner=0، لا استدعاء منتج أو قراءة أعمال. | C01 |
| تشخيص serialization ثم v4 Offline | `reader-security-baseline-fix-20261122` | **VERIFIED Offline:** مجموعات الأمان السبع الأصلية متطابقة. PS7 حوّلت `.250` إلى `.25`؛ المقارنة النصية رفضت قيمة الوقت المتساوية. v4 قارنت المخطط والأنواع والوقت دلاليًا مع بقاء SID/الأسماء/المنح دقيقة؛ 85/0 على PS7 و85/0 على PS5.1، وتسليم فعلي بين المحركين 6/0. لا SQL في التصحيح. | C02–C05 |
| 22 نوفمبر، 06:34 — v4 الحية | `d40492827ec94ae9bec626d8a8b7ddea` | **FAILED:** بوابة الأمان المصححة مرّت، ثم runner/API الحقيقيان مرة واحدة؛ exit2 وCATALOG_SOURCE_IDENTITY. SQL عادت Stopped. المرحلة/الحقل غير مسجلين؛ عدد الصفوف وبدء المعاملة/rollback **NOT VERIFIED**. | C06 |
| إثبات النوع الرقمي وتصحيحه Offline | `native-catalog-identity-fix-20261122` | **VERIFIED Offline:** Int16/Int32 متساويان عدديًا لكن Equals القديمة ترفضهما. تجميع كود الإنتاج الأصلي مع ISession اصطناعية أعاد الخطأ قبل استعلام الأعمال الاصطناعي؛ الكود المصحح اجتاز تسلسل الاقتناء/rollback نفسه بتلك الأنواع. هذا مرشح قوي لفشل v4، لا إثباتًا للحقل الحي آنذاك. | C07–C09، C24 |
| تشخيص مرحلي وحزمة v5 | الحزمة الجديدة/Controller v5 | **VERIFIED Offline:** مخططات محددة ومراحل ثابتة في C#/Node مع إبقاء رمز الخطأ الخارجي. اختبارات Node124/0 وC#113/0 والحزمة31/0 وController/SID21/0 لكل من PS7 وPS5.1. لم تشحن test mode في EXE الإنتاجية. | C09–C16 |
| 22 نوفمبر، 07:37:57 — v5 الحية | `7a25380bc21d4cb5b0bb6e76fe8ede08` | **VERIFIED تنفيذ حقيقي:** runner/API مرة واحدة، exit0، خمسة منتجات Canonical في الذاكرة، partialPreview=true وcompleteCatalog=false؛ لا persistence أو Workspace/head. SQL Stopped ثم تحقق حفظ مستقل 28/0. | C17–C23 |

مصادر Cxx هي إيصالات/سجلات أصلية محددة بالمسار وSHA256 في [EVIDENCE_INDEX.json](EVIDENCE_INDEX.json)، وليست نجاحات مشتقة من عنوان تقرير أو موافقة المالك وحدها.

### العيب المصحح وحدوده

`helpers/native/Acquisition.cs` كان يستخدم `actual.Equals(pair.Value)` بين قيم SqlDataReader وقيم سياسة JSON. حُددت مخططات Local/Inspection/Authority؛ تقبل الحقول العددية المعتمدة Int16/Int32 فقط مع مجال صريح ومساواة القيمة، وترفض السالب/overflow/التحويلات غير المرخصة وnull/DBNull والحقول الناقصة أو الزائدة. الأسماء والهوية نصوص ordinal؛ الأدوار والمنح تظل مطابقة للقيم المتوقعة قبل/بعد. لا تحويل عام إلى string أو مساواة متساهلة أو SQL جديد. GeneratedSql وسياسات inspection/authority مطابقة بايتًا للحزمة السابقة.

الـSID ليس حقلًا في Native inspection/profile القائمة؛ لم يُضف فحص SID داخلي مزعوم. بقي فحص Login/User/SID المطابق في Controller كما هو، واختُبرت تغييرات SIDs والمنح سلبًا. المخطط Native يرفض حقلًا زائدًا بدل تجاهله؛ هذا لا يساوي فحص SID فعليًا داخله.

المراحل المغلقة: TRANSPORT_IDENTITY وPRE_ACQUISITION_INSPECTION قبل استعلام C#؛ POST_ACQUISITION_TRANSPORT_IDENTITY وPOST_ACQUISITION_INSPECTION بعده؛ NODE_ENVELOPE_IDENTITY وNODE_PRE_ACQUISITION_INSPECTION وNODE_POST_ACQUISITION_INSPECTION لفحوص Node بعد استجابة المساعد. PRE/POST في Node يصفان مجموعة inspection المحمولة، ولا يعنيان استعلامًا جديدًا. الخطأ الخارجي بقي CATALOG_SOURCE_IDENTITY، ولا تُرسل values/details/stack أو raw stdout.

**لا تُعدَّل نتيجة v4 بأثر رجعي:** وجود العيب المثبت Offline ونجاح v5 متسقان مع الترشيح، لكن المصدر القديم لم يسجل stage أو failing field. الصفر في C08 خاص بالجلسة الاصطناعية فقط؛ لا يُنقل إلى صفوف الجولة الحية الفاشلة.

## نتيجة v5 وضمانات الأمان وحدودها

- المصدر: VM المختبر المحددة، SQL المحلي YSEDU، EFA12026/ID7/READ_WRITE؛ Shared Memory/LPC. نجح loader وEXE على Windows10 Pro/build10.0.19045 وNode22.23.2 الفعليين. source ID جديد ومثبت بالـhelper/config pins، دون إعادة ربط تسجيل قائم.
- قارئ SQL محدود: CONNECT وSELECT لعمودي `dbo.item_detail.i_code` و`i_a_name` فقط، دون توسيع دور أو كتابة. ميتاداتا الحساب وربط SID والمنح طابقت baseline قبل/بعد؛ استخدم الاقتناء SqlCredential المحدد، واتصال Windows التشخيصي بقي للميتاداتا فقط. لا كلمات سر/أسماء حسابات/مسارات اعتماد منسوخة إلى هذا السجل.
- استعلام أعمال واحد TOP(5)، لا COUNT_BIG أو أعمدة/جداول أعمال إضافية أو DML. فحوص COUNT على ميتاداتا النظام لا تعني مسح جدول الأعمال. خمسة صفوف مسترجعة لا تحد قراءات التخزين المادية للخطة.
- **VERIFIED بالمسار المثبت والاستجابة المقبولة:** المصادقة وهوية machine/transport/database/schema/reader والسلطة قبل/بعد، nonce وتوقيت/مخطط envelope، assertCanonicalSnapshot، rollback ثم Dispose قبل قبول النجاح. لا SQL trace مستقل أو COUNT لإثبات العدد؛ الخمسة مستنتجة مباشرةً من mapCatalogRows 1:1 بلا تصفية ومن الملخص الناجح.
- **VERIFIED إعدادًا وفتح اتصال:** Encrypt=true وTrustServerCertificate=false، بلا pooling أو retry أو fallback. **NOT VERIFIED بقياس مستقل جديد في هذه الجولة:** TLS protocol/cipher أو شهادة handshake/hostname/revocation أو encrypt_option؛ لا تُنسخ قياسات A9 السابقة إلى v5 كقياسات جديدة.
- **VERIFIED حفظًا:** ملفات الاعتماد المحمية وملكيتها/ACL بقيت كما هي؛ بقي DPAPI محليًا دون نقل السر. لا سياسة Restricted أو إعداد PKI/TLS/بروتوكول أو CONFIG/source.enabled أو checkpoint تغير. حفظ 366 ملف تطبيق و254 ملف حالة DBL، والمستودعات والعمل السابق. لا ادعاء تطابق MDF/LDF بايتًا؛ بدء/إيقاف SQL له كتابة تشغيلية عادية.
- Start واحد وStop نظيف واحد؛ آخر حالة موثقة Stopped عند `2026-11-22T04:38:08.0980244Z`/07:38:08 عدن، وفحص منفصل عند `04:38:13.1910622Z`/07:38:13. هذا ليس فحصًا لحالة الخدمة في مهمة التوثيق الحالية.
- captureId=`998c0a19-4728-4782-9889-1ab72453e801`؛ capturedAt=`2026-11-22T04:37:57.613Z`؛ mappedProductCount=5، rowLimit=5، partialPreview=true، completeCatalog=false، persistencePerformed=false، workspacePublished=false، businessValuesIncluded=false.

**NOT VERIFIED / خارج الإنجاز:** Catalog كاملة أو بقية الصفوف، inventory/financial semantics، Workspace/SQLite/Audit persistence أو head publication/reopen/refresh في هذه الجولة، Desktop Live Catalog Preview، الاستبدال الإنتاجي أو النشر العام. انتهت القيم مع عملية RAM؛ لا snapshot أعمال محفوظة لفتحها لاحقًا. لا تعرض هذه البيانات المحدودة ككتالوج مكتمل.

## البصمات الأساسية

| المادة | SHA256 |
|---|---|
| Controller v3 | `36E6C75FF08CB9586FF56CA10587FEBD431E9CEE7FECC749150917AF835489F4` |
| Controller v4 | `3279DFAF571A4370FE67103D651E10C69DD1A35494CF52AC1564A1D8DDA225E0` |
| ZIP الأولى المستخدمة في v3/v4 | `38486BE5E623AB3D4ECFB73A927E0A8335771EE6C4712372D02BBDCE2CA2BB84` |
| Controller v5 | `7D86CD0FF7447AFBEA5FBF434A46BAE3EDD19E12A731DB0319178E40851337B5` |
| Native Identity ZIP المؤهلة | `9F8120E539179DD9E5424B04584213AEB8E5C6F27934A39B9E695241061A10FB` |
| Manifest المؤهلة، 8274 ملفًا | `91C74C5E34B9CDC70E0408041BD2435A760F7C4CC7CD6938B60F44FA418A52B5` |
| EXE المؤهلة | `EB5DDBB08CA9A49A272664544D1125B817CB91F90FAC2359765EBFAE31F56530` |
| إيصال v5 الأصلي C19 | `D4D4378333267510B838C6ECCF45F591C768D52E03DB00510DC19E56DA6407EA` |
| تحقق v5 المستقل C22 | `D31349BDA5A224082FB2AB744FDAAA42BE2CBFAAFE653F64129699A15C346AF3` |
| فهرس أصل v5 C23 | `4B1B9DDE14990AC3FE33D1863B6442615120FF3621E35542D1AC334B5977F65A` |

الفهرس المنقح يربط الأدلة الأصلية عبر `workspace_relative` إلى جذر محلي مماثل للجذر الموثق في [سجل توحيد الذاكرة](../memory-consolidation-20261116/README.md). تلك الأصول خارج المستودع وليست روابط GitHub منشورة؛ إذا غابت فلا تدّع إعادة تحقق منها. الملخص المنقح محمول داخل الذاكرة، ولا يحتوي queries/صفوف/اعتماد أو stdout. لم تُرفع ZIP/EXE أو logs خام إلى مستودع الذاكرة.

### قيود الاختبارات المحفوظة

نتائج 85/6/113/124/31 و21/21 اختبارات Offline/اصطناعية؛ قبول التشغيل الحي يأتي من C17–C23 وحدها. أُدرج ملف sql-driver عرضًا في أمر اختبار أولي:171 PASS/2 FAIL عند تهيئة SQLite `:memory:`، دون ملف قاعدة؛ استُبعد من المجموعة النهائية وحُفظ C14. لا تعميم لنجاح Workspace/SQLite من الأرقام النهائية. كذلك حفظت المراجعة الأصلية توقع خطأ ملف مفقود غير صحيح وZIP أولية غير مكتملة، وتصحيح نمط Git status في تدقيق v5؛ تلك إخفاقات أدوات محلية منفصلة، وليست محاولات SQL أخرى أو أدلة نجاح ERP.

## اتساق الذاكرة والكود

حالة 16 نوفمبر التي تقول إن VM لم تتأهل أو لا توجد leaf/Root/binding تقرأ **كتاريخ مؤرخ**؛ تحفظها هذه الإضافة دون حذف، ويقدم تحديث 22 نوفمبر أسبقية الحالة للاتصال المحدود. لا نعيد تدوين إجراءات PKI الوسيطة هنا؛ إيصالات v5 تثبت فحص ثقتها/ربطها وحفظها ونجاح الاتصال المحدد. لا تعديل لـADR-001 أو إعادة تفسير للـdual-transport أو شروطه.

main المنتج ما زالت شريحة Workspace/C0 بحدودها، بينما الحزمة المؤهلة مبنية من العمل المحلي؛ نجاحها لا يثبت أن التثبيت أو main تحتوي واجهة الاقتناء نفسها. الكود المحلي `apps/desktop/src/engine/erp-workspace.ts:133–169` يربط refresh بالحفظ والاستيراد ونشر head؛ عينة RAM الحالية لا تُنشر عبره كـCatalog كاملة.

## التالي كما اقتُرح في 22 نوفمبر 2026

التجربة الجانبية اللاحقة موثقة في [سجل Desktop Live Catalog Preview](../desktop-live-catalog-preview-20261128/README.md)، مع إيصال عرض مستقل وفحص إغلاق مؤرخ في 28 نوفمبر.

**Desktop Live Catalog Preview:** اقتراح ربط معاينة جزئية في RAM عبر backend/Worker موثوق وقائمة العرض القائمة، مع مصدر مثبت وcaptureId/وقت وحد الخمسة وpartial coverage، دون حفظ أو head. يحتاج تطويرًا واختبارات وموافقة نشر جانبي منفصلة؛ وعرض بيانات حقيقية لاحقًا يحتاج اقتناءً جديدًا مصرحًا به، لأن بيانات هذه الجولة لم تُحفظ. لم يُنفذ الربط أو تُحدّث النسخة المثبتة أو تُفعّل source.enabled.

**STOP FOR OWNER REVIEW:** هذه إضافة ذاكرة معدة للمراجعة فقط؛ لا تفويض تشغيلي جديد أو commit/push/merge.
