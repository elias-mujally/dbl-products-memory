# Historical Inventory Integration #001 — legacy-reader gate BLOCKED

> Historical checkpoint preserved. [Merged state 2026-10-14](MERGED_STATE_2026-10-14.md) and [evidence register](EVIDENCE_REGISTER_2026-10-14.md) supersede earlier implementation/next-step gaps only within the qualified offline case. PR13/14/16/15/17 are merged; one inbound37 is qualified separately from historical balance37. No current stock, outbound, physical count, final GL posting, generalized ledger or live ERP qualification follows. Original failures/results/hashes below remain their original evidence; no raw re-verification or helper execution in this memory update.

**FIRST HISTORICAL INVENTORY OFFLINE INTEGRATION = BLOCKED / NOT PASSED.** المالك وافق على optional observation وadditive JSON storage بعدbe8eff3، واشترط ضمان منع إسقاطها بواسطة قارئ قديم، معSTOP عند تعذر ذلك ضمن النطاق. أُجري اختبار توافق مستقل قبل تعديل العقد: **القارئ القديم والتطبيق أسقطا observation بصمت فعلًا رغم رفعالإصدار**. توقفت قبل implementation/import بدلاً من تقديم ضمان غير مثبت.

لا يُلغى اعتماد الحقل السابق أو يُطلب اعتماد37 مجددًا؛ المطلوب الإضافي فقط هو قرار **حاجز تخزين ملزم للقارئ القديم**. FACT/HISTORICAL EVIDENCE BINDING ما زالا مؤهلين، والاختبار الحي السابق NOT PROVEN محفوظ.

## الاختبار الفعلي، معزول وليس import ناجحًا

النتيجة2026-10-13T20:59:17.773Z =23:59:17.773+03؛ توثيقها14 أكتوبر. سكربت جديد في `outputs/host-historical-inventory-compatibility-001-20261013`، syntax check ناجح، تنفيذ واحد، Node22.23.2. تحققت31 بصمة runtime/native/old compiled modules المستخدمة منmanifest التأهيل، tree51f15b2a1113fc3742559f7d76dab350fb8bb83c؛ هذه **نسخة DBL القديمة الفعلية** لاmock لقارئ مفترض. ImportOrchestratorCalls=0.

FACT hash الكامل0DE22CE4… والأصل7D742175… طابقا. identity baseline في SQLite جديدة أخذid/name منFACT الحقيقي دونquantityOnHand. بعد إغلاقها، أضيفت عموداJSON إلى committed/staging **داخل ملف الاختبار فقط**، ووضع محتوىFACT الأصلي في العمود التشخيصي. هذا تمهيد لاختبار القراءة وليس Canonical mapping أو مرورًا صالحًا للحقيقة عبرOrchestrator. لم تُدخل37 يدويًا أو تُستبدل بfixture.

سُجل future migration4 تجريبي، ثمschema_version2.1.0 و3.0.0 لاختبار أثر minor/major داخل الملف المعزول نفسه. ليسا إصدارين معتمدين أوmigration تطبيق؛ migrations1–3 الأصلية أنشأت baseline جديدة دون تعديل مصادرها أو إعادة كتابتها. لا opening/upgrade/كتابة لSQLite الإنتاجية أوsnapshot FIRST LIVE DATA.

| المقارنة | المتوقع لمنع الفقد | الملاحظة الفعلية | شرط التوافق |
| --- | --- | --- | --- |
| payload كامل في العمود الجديد | وجود دليل فعلي للبيانات قبل قراءة القديم | quantity/evidence reference منFACT محفوظان | PASS لإعداد الاختبار فقط |
| initialize القديم معmigration4 غيرمعروفة | رفضlayout غيرالداعم أو حاجزقراءة | قبلها واستمر | FAIL |
| SnapshotReader القديم،2.1.0 | منع خروجProduct ناقصobservation | أعادid/name بلاobservation | FAIL |
| getLatestSnapshot القديم،2.1.0 | منعmaterialization ناقصة | أعادid/name بلاobservation | FAIL |
| SnapshotReader القديم،3.0.0 | major mismatch يمنعفقدالمعنى | أعادid/name بلاobservation | FAIL |
| مسار التطبيق القديم،3.0.0 | منعquery ناقصة | openReadScope/query أعاداid/name بلاobservation | FAIL |
| getLatestSnapshot القديم،3.0.0 | رفضmajor غيرمتوافق | رفض برسالةmajor mismatch المحددة | PASS لهذا المسار فقط |

FAIL هنا يعني فشل **شرط منع الفقد**، لا انهيار الاختبار أو أنSQL أخفق. اكتمال هذا التشخيص لا يعني تكاملًا ناجحًا. لا renderer منDBL لquantity ولا نموذجtyped جديد أو round-trip صحيح بعد إضافةالحقل؛ تلك المراحل لم تبدأ.

## السبب المحدد

في البناء القديم، `packages/storage-sqlite/src/sqlite-store.ts:139` يفتحSnapshotReader بلاassert لheader schema؛ products():151 يحدد الأعمدة القديمة، وproductFromRow():310 يعيدها فقط. `getLatestSnapshot():224` يجمعها ثمassertCanonicalSnapshot، ولذلك وحده يرفضmajor3. `packages/query-engine/src/executor.ts:191` يتحقق منquery plan، لاschema snapshot؛ application-service يستخدمذلكالقارئ. `migrations.ts:252` يتحقق منالمigrations التييعرفها ويتجاوز مستقبليةغيرمعروفة. `core/version.ts` يقارنmajor فقط.

**إضافة عمود ورفع رقم الإصدار وفحوص في كود جديد لا تغيّر تعليمات binary قديم بالفعل.** هذه ليست دعوةلتخفيف المعايير؛ هي دليل أنالضمان المقترح السابق لم يكن كافيًا. الاختبار لا يثبت استحالة كل تصميم، لكنه يُسقط الاعتماد علىversion bump/additive columns وحدهما. لا تعدّل checksums/names لمigrations قديمة لإجبار نسخةقديمة علىالرفض، ولا تُخفىmetadata فيحقولعامة.

## أصغر قرار إضافي مقترح — لم يُنفّذ

**حاجز أسماء جداول versioned في ملف التاريخ التجريبي**: ضمنmigration جديدة غيرمدمرة، تحتفظبكلالبيانات وتضيفJSON ثم تعيدتسمية committed/staging Product tables إلى أسماءlayout جديدة، مثل `snapshot_products_v4` و`snapshot_staging_products_v4`. writer/commit/reader الجديد يستخدمهذهالأسماء؛ **لا legacy view permissive** يعيدالأعمدةالقديمة. بذلك تفشل استعلامات binary القديم علىاسم الجدول القديم بدل نجاحها معProduct ناقصة. يلزم تأهيل هذا الحاجز فعليًا؛ لم يُختبر أو يُعلن ناجحًا هنا.

هذا يوسّع تعديلlayout من«إضافة عمودين» إلى«عمودين معتغيير سطحالجداول ومساراتالوصول»، ولذلك يُطلب قرارتصميم صريح قبل التنفيذ، لا rename ضمنيًا. نطاقه المقترح fresh experimentalSQLite فقط؛ لا تغييرmigration سابقة أوترحيلDB الإنتاجية أوquantityOnHand/Insights أوinventory model عام. حفظFKeys/transactions/fingerprint/old-content regressions ورفضold streaming/application/writer كلها شروطاختباره. اعتمادهبعدذلك يسمح باستكمالالحقل/fileconnector/Orchestrator/testpreview المصرح بها، ولا يرخصSQL/ERP أوmerge.

البديل هو قرار صريح يضيّق الضمان إلى APIs/نسخ مدعومة ومحدّثة فقط، ويعزل ملفاتlayout الجديدة عنالنسخ القديمة تشغيليًا؛ **هذا تغيير لمعيارالمالك الحالي**، وليس ضمانًا بأنbinary قديم أعطيالملف نفسه سيرفضه. لم يُعتمد أو يُطبّق. لا يُختار تخفيفالضمان تلقائيًا.

## الأدلة المحفوظة والحدود

| الملف المحلي | SHA256 |
| --- | --- |
| probe-old-reader.mjs | `E4F3C5944BFF3EB2F805D41D9350632D1E56CDA1022867CDFE195B1A67EC956B` |
| RESULT.json | `A6462AEE9621D37F4A4CF6D9FEF9FE44D5C2DE03B5866A43FC880DCF30E026C8` |
| OLD_READER_COMPATIBILITY_ONLY.sqlite | `AD0B2F9BAB7742CF5288D608C8B6FB28E32D72079BE00AF2CAB60147104495C5` |

SQLite التشخيصية والـFACT والأصل تبقى محليًا؛ لا ملفاتDB أوrawexports فيGit. [النتيجة غيرالحساسة](research/DBL_HISTORICAL_INVENTORY_COMPATIBILITY_001_RESULT_2026-10-14.json). لا حذف أوتنظيف أوإعادةمحاولة؛ الفشل ليسسببًا لإصلاح خارجالنطاق.

مستودع البناء نظيف unchanged84eadfdd/tree51f15b2؛ لا branch/code/Canonical/source migrations/API modifications. SQLServer/ERP/function/credentials/host/TLS/Reader permissions=0. بقيتProductionSQLite وFIRST LIVE DATA دون وصول أوتغيير. الاختبار استخدمSQLite محليةفقط معold APIs وFACT المعتمد؛ لا fixture-as-business proof. لاbuild/typecheck/fulltests أوintegrationpreview بعدfailure؛ لاPASSED للهدف. `.vscode` محفوظة خارجcommit، SALES & INVENTORY وadmin diagnostics مؤجلتان.

**STOP.** مطلوب تفويض مستقل لحاجزlayout المحدد أو قرار قبول أضيق واضح، قبل استكمالالتكامل. لا merge أوproduction نشر.
