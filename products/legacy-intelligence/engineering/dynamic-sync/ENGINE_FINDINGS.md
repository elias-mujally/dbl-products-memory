# Where restrictions live — code-led findings

2026-10-25 · [الفهرس](README.md). جميع روابط الكود إلى commit المنتج المقروء، لا فرع متغير.

## قيد الخمسة جزء من مسار تأهيل، لا من SQLite

| الموضع | القيد وسببه/أثره | مرجع الشيفرة |
| --- | --- | --- |
| جمع المصدر | اختيار T01..T05 بـ WHERE IN؛ الصنف الجديد لا يُقتنى أصلًا. حارس هوية المختبر مستقل عن العدد | [collector:74–90](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/tools/v1/Acquire-V1Inventory.txt#L74)،[حارس الهوية](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/tools/v1/Acquire-V1Inventory.txt#L7) |
| قارئ envelope | VM/server/database معروفة، sourceWrites=false و SELECT-only، schema/rows/counts متطابقة؛ ليست هوية ERP عامة | [v1-acquisition.ts:44](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/connectors-motakamel-plus/src/v1-acquisition.ts#L44) |
| تعريف profile | قائمة SKU صريحة؛ فرع 1 ومخزن 1 ووحدة/عبوة 1 و SAR وحسابات مختبر ثابتة | [v1-inventory.ts:8](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/connectors-motakamel-plus/src/v1-inventory.ts#L8) |
| تأهيل stock | item count يساوي طول القائمة، stores مساوية، وكل رمز معروف موجود؛ مجموعة 001 وافتتاحي/مجاني/فرعي صفر | [v1-inventory.ts:71](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/connectors-motakamel-plus/src/v1-inventory.ts#L71) |
| الحركات والتكلفة | نوع وإشارة ووحدة وعملة وربط مردود وحسابات وجورنال متحققة؛ تكلفة موجبة ثابتة لكل صنف، لا FX | [v1-inventory.ts:89](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/connectors-motakamel-plus/src/v1-inventory.ts#L89) وما بعدها |
| إخراج المنتجات | يدور على P.productIds نفسها، لا كل صف متاح | [v1-inventory.ts:188](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/connectors-motakamel-plus/src/v1-inventory.ts#L188) |
| فاحص الحالة | LIMIT161، products=snapshots×5، product_count=5، audit metadata.products=5 | [operator.ts:98–127](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/apps/v1-file-import/src/operator.ts#L98) |
| مشغّل refresh | موصل و profile واحد، أرشيف يُعاد تأهيله به، ورفض connector أجنبي | [index.ts:39–92](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/apps/v1-file-import/src/index.ts#L39) |
| قراءة صفحة واحدة | refresh يقارن أول query مع كامل expected؛ default page=50/max=200. إزالة 5 لا تعالج التصفح | [index.ts:89](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/apps/v1-file-import/src/index.ts#L89)،[query types:4](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/query-engine/src/types.ts#L4) |

report/backup/verify-backup/restore تعتمد فاحص الحالة نفسه، فالقيد يؤثر في إعادة القراءة والتعافي أيضًا. ليس مجرد حد عرض أو تعديل قائمة رموز.

**لماذا وُضع؟** تعليقات profile تسميه qualified lab profile، و[ذاكرة الدلالات](../v1/DATA_SEMANTICS.md) تسجل نطاق الإثبات. الحواجز تحمي هوية العينة وصحة تفسير ledger/cost/journal؛ لا تمثل قرارًا منتجيًا بأقصى خمسة أصناف. الأرصدة ليست أرقامًا معادة hardcoded: اختبار كمية T03=51 وقيمة 1475 نجح هنا مع الشروط القائمة. الخلط بين «أعداد متغيرة» و«سياسات تكلفة ومخازن متعددة صحيحة» غير آمن.

## حدود الحجم والاقتناء والتشغيل

- الجمع يحد الجدول 100 صف والحركات 200، ويقارن COUNT بالصفوف في معاملة Serializable ثم Rollback. [collector:84](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/tools/v1/Acquire-V1Inventory.txt#L84). العدد يخص scope المرشح، ولا يثبت كل أصناف ERP.
- القارئ يحد الملف 4MiB وكل جدول 200 صف. [v1-acquisition.ts](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/connectors-motakamel-plus/src/v1-acquisition.ts). هذه حواجز رفض صريح؛ لا نزيدها هنا.
- الحالة تحد 32 لقطة و 256 محاولة، و 16pending يوقف الاستيراد. [state.ts:13](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/apps/v1-file-import/src/state.ts#L13). capture جديد بصفوف ثابتة قد يزيد اللقطات؛ replay نفسه يسجل محاولة. تشغيل دوري يحتاج سياسة سعة واحتفاظ، لا تغيير timer فقط.
- يوجد موصل SQL تاريخي آخر مقيد بصنف وهوية ومصدر مرجعي؛ ليس قارئ V1 حيًا عامًا. [profile.ts](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/connectors-motakamel-plus/src/profile.ts)،[source.ts](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/connectors-motakamel-plus/src/source.ts). قُرئت الشيفرة فقط؛ لا وصول للمصدر التاريخي أو استخدام هويته.

## قدرات عامة موجودة بالفعل

| الطبقة | القابل لإعادة الاستخدام | الفجوة |
| --- | --- | --- |
| [Canonical](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/core/src/model.ts#L12) | Product.id عام و sku اختياري و name و quantity/money/updatedAt، ومصفوفة متغيرة | لا instance/completeness/absence/tombstone/rekey مهيكلة |
| [Validation](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/core/src/validation.ts#L136) | أنواع ودقة وفرادة داخل snapshot، و closed-world keys، و batch حتى 10,000 كيان | لا يثبت أن المصدر كامل أو أن الرصيد صحيح المعنى |
| [Connector API](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/core/src/connector.ts) | file/sql/api/custom، buffered/batched، capability و readOnly | لا بروتوكول full/delta أو instance/epoch/completeness/cursor |
| [Orchestrator](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/import-orchestrator/src/orchestrator.ts#L145) | validation و staging/commit/abort و retry قراءة محدود وتدقيق | readOnly=true إعلان من الكود وليس فرض DBgrants؛ لا detector تغيرات عام |
| [SQLite writer](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/storage-sqlite/src/sqlite-write-session.ts#L269) | حفظ كل مجموعة في snapshot ورفض duplicates والكتابة الذرية | لا master catalog متغير أو سجل غياب أو دمج رموز |
| [Reader API](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/core/src/storage.ts#L71) | latest reader ثابت و checkpoints وفلاتر/cursor عبر التطبيق | لا public openSnapshotReader(id) عام، ولا diff/feed من النوع المقترح |

وجود حد 10,000 لكل batch ليس اختبار حجم أو ضمان دعم 5,000 في المسار الكامل. القراءة المادية الكاملة تختلف عن streaming، ويزداد التخزين مع المنتجات×اللقطات.

## ماذا يعني تحديث DBL حاليًا؟

النسخة الجديدة من الصنف تُحفظ في **لقطة جديدة** لا بتعديل صف تاريخي. قاعدة المنتجات بمفتاح(connector_id,snapshot_id,entity_id)، ولا CHECK لعدد 5. انظر [migrations.ts:27](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/storage-sqlite/src/migrations.ts#L27) ثم rename إلى snapshot_products_v4 في migration4. يكفي المخطط الحالي لعدد مختلف وحقول Product الحالية، لا لكل دلالات sync الجديدة.

الصنف المفقود عن snapshot أحدث لا يُمحى من التاريخ، لكنه يغيب عن latest view. لا يوجد tombstone أو تصنيف missing؛ UI قد يُضلّل المستخدم إن سمى الغياب حذفًا أو حمّل رصيده القديم ضمن إجمالي حديث.

[fingerprint.ts:34](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/storage-sqlite/src/fingerprint.ts#L34) يضم header والتاريخ وهوية اللقطة والصفوف. ليس rowhash أو business-onlyhash. نفس snapshot identity ومحتوى مطابق يعيدان checkpoint؛ تغير المحتوى تحت الهوية نفسها يعطي DATA_INTEGRITY_CONFLICT، لا تحديثًا. في V1snapshotId مشتق من hash الملف، وهي هوية capture لا هوية صنف.

[latestSnapshotRow:270](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/storage-sqlite/src/sqlite-store.ts#L270) يرتب captured_at ثم imported_at. رفض capture أقدم غير معروف و clock-skew في wrapperV1 لا في store كسياسة sync عامة. كما أن id مستقل عن sku في Canonical، لكن V1 يستعمل الرمز كهوية؛ تغير الرمز يحتاج مفتاح مصدر ثابتًا أو rekey policy، لا مجرد تحديث name.

**الخلاصة:** التعميم تدريجي فوق المحرك القائم، عبر اقتناء ومصدر وهوية واكتمال وتشغيل مؤهلين. إزالة حراس V1 أو زيادة الأرقام لا تحقق ذلك.
