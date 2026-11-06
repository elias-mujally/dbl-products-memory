# Existing synthetic tests — actual exploratory results

2026-10-25 · [الحقائق البنيوية](ENGINE_FINDINGS.md). استُخدمت الاختبارات الموجودة والتبعيات المثبتة في بيئة التطوير المعتمدة. لم نضف أو نعدل اختبارًا أو موصلًا أو مخططًا أو نبنِ Preview1.

قواعد SQLite المؤقتة أو in-memory هي بيانات الاختبارات الاصطناعية، وليست ERP أو حالة DBL الأصلية أو بيئة VM جديدة. لا تُقرأ ملفات أدلة خاصة أو مصادر عميل. التقارير الخام للاختبارات محلية؛ ينشر الملخص وبصماتها فقط.

## التنفيذ الفعلي

| الاستدعاء | الملفات/الحالات الحالية | ناجح | فشل | خارج التحديد |
| --- | --- | ---: | ---: | ---: |
| Generic | storage: sqlite-store/batched-store/schema-version-agreement؛ application-service؛ orchestrator: integration/orchestrator |51|0|0|
| V1 selected | refresh.test: changed balances، fresh unchanged observation، unseen older/same-time، hash/unsupported |5|0|10|
| Replay selected | refresh.test: independent-process replay، post-commit trouble/retry |2|0|13|

**58 نتيجة نجاح، صفر فشل.** الأعداد 10 و 13 حالات استبعدها testNamePattern في استدعاءين مختلفين، وليست 23 حالة مستقلة تخطاها غياب بيانات. شُغلت 7 من 15 حالة في refresh عبر مجموعتين؛8 بقيت خارج النطاق. هذه ليست full-suite أو CI أو اختبار أداء.

## النتائج وحدودها

| السيناريو | المثبت فعليًا | مرجع الاختبار |
| --- | --- | --- |
| أقل من 5 وهويات عامة | موصل mock بصنفين دخل ImportOrchestrator و SQLite الحقيقية؛ كما نجح commit ذري لصنفين عبر batches | [integration.test:83](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/import-orchestrator/test/integration.test.ts#L83) |
| مجموعة 2→1 بهوية مختلفة | اللقطة الجديدة تحوي p-9 وحده؛ القارئ الجديد يراه، والقارئ المثبت على القديمة يواصل صفحتها ويرى p-2 | [application-service.test:61](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/application-service/test/application-service.test.ts#L61) |
| لقطة عادية فارغة | store قبل ordinary snapshot فارغة؛ لا فرض عالمي للخمسة أو لاكتمال المصدر | [schema-version-agreement.test:51](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/storage-sqlite/test/schema-version-agreement.test.ts#L51) |
| تعديل كمية داخل عينة V1 | T03 صار 51 والقيمة 1475 بدل 1470؛ لقطة ثانية، و old replay أبقى الأحدث | [refresh.test:55](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/apps/v1-file-import/test/refresh.test.ts#L55) |
| رصد أحدث وصفوف أعمال ثابتة | checkpoint زاد إلى 2، current ظل خمسة والقيمة 1470؛ لا جمع كميات متكرر | [refresh.test:68](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/apps/v1-file-import/test/refresh.test.ts#L68) |
| المصدر نفسه عبر عمليتين | applied ثم replayed؛ checkpoint واحد وأرشيف مصدر واحد، وفحص integrity لقواعد الحالة | [refresh.test:40](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/apps/v1-file-import/test/refresh.test.ts#L40) |
| هوية لقطة واحدة بمحتوى مختلف | رفض DATA_INTEGRITY_CONFLICT؛ لا تحديث صامت للتاريخ | [sqlite-store.test:54](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/storage-sqlite/test/sqlite-store.test.ts#L54) |
| duplicate/sequence/batch budget | رفض هوية مكررة عبر batches أو تسلسل غير صحيح أو batch يتجاوز الحد؛ لا لقطة منشورة بعد abort | [batched-store.test](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/storage-sqlite/test/batched-store.test.ts) |
| فشل batch لاحق | أُجهض الاستيراد المرحلي دون إظهار بيانات جزئية | [orchestrator.test:184](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/import-orchestrator/test/orchestrator.test.ts#L184) |
| مشكلة بعد commit | إعادة المصدر ظلت idempotent دون بيانات مكررة | [refresh.test:109](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/apps/v1-file-import/test/refresh.test.ts#L109) |
| readOnly=false | الموصل رُفض قبل health/persistence؛ لا يثبت ذلك DBgrants حقيقية عندما يكون true | [orchestrator.test:216](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/import-orchestrator/test/orchestrator.test.ts#L216) |

## غير المختبر هنا

انتقال 2→1 يثبت اختلاف العدد وظهور هوية جديدة وغياب القديمة عن latest مع بقاء قراءة اللقطة السابقة. لكنه ليس اختبار إضافة صنف ثالث مع إبقاء الاثنين، ولا تصنيف deleted/missing. تعديل كمية ثبت داخل V1؛ لم نشغّل تسلسل تعديل name/SKU لهوية مستقرة عبر لقطتين.

لم نشغّل ملف raw V1 بعد تغيير count إلى 4 أو 6. شرط رفضه محدد بالشيفرة، لكنه **استنتاج ثابت وليس اختبارًا تنفيذيًا**. اختبارات v1-inventory.test المرتبطة بملف مالك حقيقي غير مشمولة؛ لم نقرأ ذلك الملف. إنشاء حالات 4/6 أو تسلسل catalog جديد يحتاج harness/اختبارًا جديدًا، فتوقفنا عند هذا الحد وجهزنا [خطة منفصلة للموافقة](NEXT_STEP_AND_TEST_PLAN.md#test-plan).

قبول لقطة فارغة يوضح أن صحة التخزين وذريته ليست إثبات اكتمال business. إذا قدم موصل غير مؤهل جزءًا من المصدر كلقطة كاملة، فلن يستنتج store أنه ناقص. الحل بوابة قبول جديدة، لا حظر كل لقطة فارغة أو إضعاف شروط V1. لم يتغير أي حارس أو مصدر أو صيغة تخزين لإنجاح الاختبار.
