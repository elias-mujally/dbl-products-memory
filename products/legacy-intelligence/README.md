# Legacy Intelligence — Product Memory

هذا المجلد هو الذاكرة المرجعية لمبادرة **Local-First Legacy ERP Intelligence Layer** داخل DBL.

آخر مزامنة مع مستودع البناء: **2026-08-25**

آخر تحديث بحثي/مخبري: **2026-10-07**

## الحالة

**V1 BUILD IN PROGRESS — CONTINUE WITH CORRECTIONS. Pilot #001 remains Purchase Attention + Item Intelligence. Controlled Item A remains preserved in the Reference Lab. The current development target is the existing physical-host Windows 11 Motakamel installation, explicitly designated by the user for DBL experimentation. Its active EFA12026 baseline and new COPY_ONLY/CHECKSUM backup are established and SQL-verified; physical backup size and SHA-256 are documented from the user's manual administrative read. Following an authorized normal direct launch and manual authentication, GL/inv are Medium and direct inventory-window mouse/keyboard effects are proven: HOST DEVELOPMENT ENVIRONMENT READY at this bounded backup/input gate. A Reports transient-surface capture crop error remains unresolved; this is not qualification of every ERP surface or authorization for mutations. The historical W11 Agent Lab installer failure is outside the critical path; no repair is authorized. No Motakamel connector or customer pilot is qualified.**

مستودع التنفيذ:

`elias-mujally/dbl-legacy-intelligence`

آخر milestone مدموج في `main`:

- PR #10 — Close canonical validation against silent field loss.
- Squash merge commit: `95bf225e1523e0fd0f72cdf3da8393df18d635cc`.
- Final verified PR CI before merge: Run #194 على Ubuntu وWindows.

PR #10 أغلق defect حقيقيًا في الـclosed-world canonical boundary: unknown canonical fields لم تعد تمر validation ثم تختفي بصمت أثناء SQLite persistence/fingerprinting.

## ابدأ من هنا

**أحدث تجربة حساب وسيط التحويلات المستقل (2026-10-07):** Save واحدة حفظت `97070102 / DBL_TEST_TRANSFER_INTERMEDIARY_20261007` تحت `970701`، نوع فرعي `2` ورتبة مشتقة `2` وتقرير `Balance Sheet` وربط `SAR` فعالًا وافتراضيًا. أُعيد فتح الدليل وتحميله مستقلًا وتحقق SELECT من القيم/defaults. في Warehouse Add غير محفوظ، عرض F9 الحساب الجديد وأعاد double-click رقمه؛ Tab وحده لم يحسم الاسم/الخروج، ثم نقرة واحدة على الاسم العربي الفارغ للمخزن أظهرت اسم الحساب كاملًا وSAR ونقلت التركيز دون validation. **Transfer Intermediary Account Candidate = QUALIFIED FOR WAREHOUSE SELECTOR** فقط؛ لا Warehouse Save أو Controlled Zero PASSED. أُلغي Add رسميًا؛ SELECT ختامي عند 17:59:38+03:00: `W_DETAIL=0`, `Account=3`, `Account_Cur_Detail=2`، والوحدة/المجموعة/الصنف صف واحد لكل منها دون تغير في الصفوف المفحوصة. حساب المخزون `97070101` وربطه لم يتغيرا؛ رُصد `Acc_Sort` للأب `2→3` بعد إعادة فتح الدليل دون تعديل يدوي، والسبب غير محسوم، فلا ندّعي تطابق جميع حقول الحسابات السابقة. [الحفظ وإعادة التحميل وdefaults واختبار المحدد وحدوده](MOTAKAMEL_HOST_W11_BASELINE_2026-10-06.md#host-dedicated-transfer-intermediary-account-and-unsaved-warehouse-selector--2026-10-07). أضيق اقتراح تالٍ تفويض منفصل لـWarehouse A Save باستخدام الحساب المستقل؛ **Controlled Zero BLOCKED؛ S0b PARTIAL؛ S2/S3 لم يبدآ**. لا stock movement أو SQL writes أو backup/Restore أو حسابات إضافية أو تغيير S1/Connector؛ STOP. نتائج عدم تأهيل اختيار الحساب أدناه تاريخية حيث تختلف.

**أحدث Discovery لحساب Warehouse دون حفظ (2026-10-07):** بعد إغلاق validation السابقة، أعاد Motakamel التركيز مباشرة إلى edit ID 26 بجانب **«حساب وسيط التحويلات المخزنية»**؛ بذلك تحددت خانة طلب رقم الحساب دون Save جديدة. F9 عرض `97070101 / DBL_TEST_CHILD_20261007` فقط، لا Root `970701`؛ لم يُعتمد الصف وأُلغي المحدد وبقي الحساب فارغًا. Help الرسمي v5 يصف وسيط التحويل بين الفروع: مدين عند التحويل مقابل دائن للمخزون، والعكس عند الاستلام. **الدور HELP-DOCUMENTED؛ ظهور Child CURRENT-UI PROVEN؛ جميع شروط الفلترة/الطبيعة/التصنيف/العملة وملاءمة إعادة استخدام حساب المخزون UNRESOLVED**. لا دليل يجعل إنشاء حساب جديد شرطًا مفروضًا من النظام؛ التوصية بحساب تجريبي فرعي مستقل هي عزل للدورين في التجربة، لا semantics أو provisioning مثبتة. [الحقل والمحدد والمساعدة وقرار الحساب](MOTAKAMEL_HOST_W11_BASELINE_2026-10-06.md#host-non-saving-warehouse-transfer-account-requirement-discovery--2026-10-07). أُلغي Add رسميًا مع تأكيد التراجع وعاد النموذج للعرض؛ SELECT الكامل المحدود عند 17:29:37 و17:34:42+03:00 متطابق للحسابين ورابط SAR والوحدة والمجموعة والصنف و`W_DETAIL=0`. المسودة المفتوحة في النتيجة السابقة أدناه تاريخية الآن. أضيق اقتراح تالٍ اعتماد هوية وقيم حساب اختبار مستقل ثم تفويض تجربته، دون استخدام `97070101` تلقائيًا أو إعادة Save للمخزن. **Controlled Zero BLOCKED؛ S0b PARTIAL؛ S2/S3 لم يبدآ**. لا حساب/مخزن محفوظ أو transaction/stock movement أو SQL writes أو backup/Restore أو Connector؛ STOP.

**أحدث Warehouse A — محاولة Save الوحيدة توقفت عند validation (2026-10-07):** بالقيم المعتمدة `001 / DBL_WAREHOUSE_A` والفرع `1 -` المختار من القائمة الرسمية وبقية الحقول/defaults دون تغيير، طلبت Save: **«فضلا أدخل رقم الحساب»**. الرسالة مثبتة بالصورة وaccessibility للحوار نفسه؛ لم يُدخل حساب ولم تُكرر Save أو تُرسل أفعال GUI بعدها، والحوار والمسودة باقيان مفتوحين. **Warehouse A Save = BLOCKED؛ Reload لم يُنفّذ**. SELECT عند 17:05:32 و17:15:20+03:00 أكد `W_DETAIL=0` وتطابق كامل الصفوف المحدودة للحسابين ورابط SAR وUnit A/Group A/Item A قبل/بعد. وُثّق خطأ mapping أدخل الاسم في الفاكس بالمسودة ثم صُحح وفُرغ الفاكس قبل Save؛ لا قيمة خاطئة محفوظة. [المحاولة والدليل وحدود المتطلب](MOTAKAMEL_HOST_W11_BASELINE_2026-10-06.md#host-authorized-warehouse-a-single-save--validation-stop--2026-10-07). أصبح طلب **رقم حساب** مثبتًا من Save الحالي؛ تحديد الحقل ودور/أهلية الحساب ما زال UNRESOLVED، ولا يُفترض أن حساب Group `97070101` صالح لهذا الغرض. أضيق خطوة مقترحة Discovery غير محفوظ لهذا المتطلب بتفويض منفصل، لا حساب إضافي أو Save retry تلقائية. **Controlled Zero BLOCKED؛ S0b PARTIAL؛ S2/S3 لم يبدآ**. لا SQL writes أو stock movement أو backup/Restore أو Connector/Gate advancement؛ STOP. نتيجة Discovery السابقة أدناه تاريخية حيث تجاوزها validation الحالي فقط.

**أحدث Warehouse Add Discovery غير محفوظ (2026-10-07):** المسار الرسمي إدارة المخزون والجرد → المدخلات → بيانات المخازن → إضافة. الرقم والاسم والفرع وبقية الحقول فارغة؛ قائمة الفرع تعرض `1 -` دون اختيار أو توليد Warehouse 1، وجميع أعلام التقييد/الإنتاج غير مفعلة. Help الرسمي الإصدار 5 يجعل المكان/الأمين/الهاتف/الفاكس اختيارية، ويصف حساب التحويلات لغرض التحويل بين الفروع؛ لا يثبت إلزامه لحفظ مخزن عادي، ولا توجد خانة عملة في السطح المرصود. **متطلبات Save الحالية ما زالت UNRESOLVED** لأن Save لم يُنفّذ حتى لاستدراج validation. Cancel مؤكد؛ SELECT الكامل للسجلات المحدودة قبل/بعد عند 16:43:44 و16:49:53+03:00 متطابق للحسابين ورابط SAR والوحدة والمجموعة والصنف، و`W_DETAIL=0`. [الحقول والـdefaults والمساعدة وحدود الإلزام](MOTAKAMEL_HOST_W11_BASELINE_2026-10-06.md#host-non-saving-warehouse-add-discovery--2026-10-07). المقترح فقط اسم `DBL_WAREHOUSE_A`، مع رقم محايد يُعتمد منفصلًا وفرع Host الموجود، لا نسخ Reference. بعد تفويض مستقل، مخزن واحد محفوظ/مُعاد تحميله قد يزيل blocker النطاق لإعادة محاولة Controlled Zero، ولا يضمن نجاح التقرير أو missing-row semantics. **Controlled Zero BLOCKED؛ S0b PARTIAL؛ S2/S3 لم يبدآ**. لا Warehouse/transaction Save أو حركة أو SQL writes أو backup/Restore أو Connector؛ STOP قبل أي حفظ.

**أحدث Host Controlled Zero / S0b — Discovery فقط (2026-10-07):** **Controlled Zero = BLOCKED** عند نطاق المخزن: تبويب مخزون Item A فارغ وليس صفرًا صريحًا، ومحدد المخازن في تقرير المخزون فارغ؛ SELECT أكد `W_DETAIL=0`. عند 16:20:04+03:00 بقيت سجلات S1 وعلاقات `001 / UA / package 1` كما هي، و`item_store/opn_stock/item_mov` المقيّدة بـItem A صفر صفوف؛ هذا لا يثبت I/U/W zero أو missing-row semantics. تقرير المخزون يتيح إظهار الأصناف الصفرية وغير المخزّنة، لكن لم يُنفّذ تقرير بلا scope ثم يُعدّ دليلًا. **Host S0b بدأ جزئيًا فقط**: فُحصت أوامر التوريد والاستلام المخزني وفاتورة المشتريات الفورية في وضع العرض؛ الاستلام الحالي يعرض حقول تحويل، ولا يثبت receipt مستقلًا. Help الرسمي v5 يفرّق بين مورد الشراء الآجل وصندوق النقدي، ويوثق أمر التوريد كبديل للتكلفة المعروفة دون أعباء؛ شروط Save الحالية لم تُختبر. S2-P مفضل بالخطة إذا اجتازت متطلباته، وS2-R عبر أمر التوريد مرشح أضيق لا مسار مؤهّل بعد. [الأدلة والمسارات والحدود](MOTAKAMEL_HOST_W11_BASELINE_2026-10-06.md#host-controlled-zero-and-s0b-inbound-discovery--2026-10-07). أضيق خطوة تالية Discovery غير محفوظ لمتطلبات مخزن واحد رسمي؛ لا اختراع Warehouse 1 أو إنشاءه تلقائيًا. لا Add/Save لمعاملة أو مورد/مخزن، ولا حركة/S2/S3 أو SQL writes أو Connector. يبقى S1 معتمدًا، ولا تغيير لنطاق Pilot أو Gates A/B/C؛ عبارات S0b-not-started التالية تاريخية حيث تختلف.

**أحدث Host bootstrap — Unit A / Group A / Item A (S1) محفوظة ومتحقَّق منها (2026-10-07):** نُفّذت Save واحدة لكل سجل عبر UI الرسمي بالتسلسل المعتمد، ثم إغلاق/إعادة فتح/تحميل مستقل وSELECT read-only: `UA / DBL_UNIT_A`؛ `001 / DBL_GROUP_A` بحساب المخزون `97070101` ذي رابط SAR فعال وافتراضي؛ `DBL_P001_ITEM_A / DBL_ITEM_A` بالمجموعة `001` والوحدة `UA` والعبوة الرئيسية `1`. المصالحة الختامية عند 15:32:02+03:00 أثبتت العلاقات و`Account=2`, `Account_Cur_Detail=1`, `Measure=1`, `i_group=1`, `item_detail=1`. الـdefaults الفعلية موثقة في [Host bootstrap through S1](MOTAKAMEL_HOST_W11_BASELINE_2026-10-06.md#host-controlled-dataset-bootstrap-through-item-a--s1--2026-10-07)؛ هذه سجلات Host جديدة وليست ترحيل Reference، وحسابها `97070101` لا `1141010001`. المهارة وجّهت إعادة اختيار النافذة والمشاهدات بعد انقطاع جلسة الأدوات، والتحقق بعد timeout دون تكرار الإدخال. `item_mov=0` ملاحظة جدول فقط، لا إثبات zero-stock. لا SQL writes أو S0b/S2/S3 أو حركة مخزون أو Connector/Gate A أو PARTNER-VALIDATED/PILOT-QUALIFIED. انتهى التنفيذ عند S1؛ أي مرحلة تالية تتطلب تفويضًا مستقلًا. العبارات التالية عن فراغ Host أو عدم Save للمجموعة تاريخية حيث تختلف.

**أحدث Discovery غير محفوظ لـGroup — أهلية المحدد PASSED ضمن نطاقها (2026-10-07):** بعد اختيار `97070101` بـF9 ثم double-click، أدى النقر مرة واحدة على خانة الاسم العربي الفارغة للمجموعة إلى ظهور `DBL_TEST_CHILD_20261007` في اسم حساب المخزون. مشاهدة لاحقة دون إدخال إضافي أثبتت انتقال التركيز من ID 41 إلى ID 60 دون validation أو تغيير الحساب. إذن الاختيار/ظهور الاسم/الخروج الطبيعي **PASSED**؛ السبب الداخلي لسلوك Tab السابق غير مثبت، ولا Group Save أو اكتمال جميع قواعد العملة/الحفظ. ربط SAR الفعال الافتراضي أُعيد تأكيده ويطابق عملة المخزون المثبتة سابقًا. أُلغي Add رسميًا؛ SELECT ختامي عند 07:51:52+03:00: `Account=2`, `Account_Cur_Detail=1`, `i_group/Measure/item_detail=0`، والحسابان دون تغير في الإسقاط المفحوص. [التسلسل والحدود](MOTAKAMEL_HOST_W11_BASELINE_2026-10-06.md#host-unsaved-inventory-account-picker-and-field-exit-discovery--2026-10-07). أضيق خطوة تالية تفويض منفصل قبل أي Unit/Group/Item Save؛ لا SQL writes أو backup/Restore أو S0b/S1/S2/S3 أو تأهيل Connector. النتيجة السابقة غير المحسومة أدناه تاريخية حيث تختلف.

**أحدث نتيجة Host — Child وSAR نجحا، وأهلية Group بقيت جزئية (2026-10-07):** Save واحدة حفظت `97070101 / DBL_TEST_CHILD_20261007` مباشرةً تحت `970701` بنوع `2 فرعي` ورتبة مشتقة `2` وتقرير `Balance Sheet` ظهر تلقائيًا بعد Parent/Tab. أُعيد فتح الدليل وتحميل Child مستقلًا؛ SELECT أثبت رابط `SAR` فعالًا وافتراضيًا في `Account_Cur_Detail` دون تصنيف/تدفق/رابط محاسبي مخترع أو مستوى ثالث. في Group Add غير محفوظ، عرض محدد حساب المخزون Child باسمه ورقمه، وأعاد اختياره الرقم إلى الحقل؛ **visibility/code selection: PROVEN**. لكن اسم الحساب بقي فارغًا ولم ينتقل التركيز ظاهرًا بعد Tab، دون رسالة validation؛ لذلك **complete Group eligibility: PARTIAL / UNRESOLVED**، لا Group Save أو تأكيد كامل للتحقق من العملة. توقفت التجربة عند هذا السلوك وأُلغي Add؛ SELECT ختامي عند 07:35:51+03:00: `Account=2`, `Account_Cur_Detail=1`, `Group/Unit/Item=0`. عملة SAR تطابق إعداد المخزون المثبت سابقًا، لا فحصًا جديدًا مكتملًا لعملة Group. [تفاصيل Child والحدود](MOTAKAMEL_HOST_W11_BASELINE_2026-10-06.md#host-approved-direct-child-save-sar-binding-and-unsaved-group-picker--2026-10-07). أضيق خطوة تالية Discovery منفصل غير محفوظ لسلوك الاسم/الخروج من الحقل، لا تعديل الحساب أو Group Save. تُحفظ ملاحظات Dr/Acc_Sort دون تحقيق/تصحيح؛ لا S0b/S1/S2/S3 أو SQL writes أو backup/Restore إضافية، ولا تأهيل Connector أو ادعاء minimum عالمي. السجلات التالية تاريخية حيث تختلف.

**أحدث نتيجة Host — الرئيسي فقط نجح وحُمّل مستقلًا (2026-10-07):** باعتماد المستخدم للميزانية العمومية، انتقل التقرير من فارغ إلى هذا الاختيار دون تغير فوري آخر مرصود في قيم الحقول. محاولة Save واحدة حفظت `970701 / DBL_TEST_MAIN_20261007` بأب `0`، نوع `1 رئيسي`، رتبة مشتقة `1` و`A_Report=Balance Sheet`؛ أُغلق نموذج الدليل وأعيد فتحه واختيار السجل من الشجرة، ثم تحقق SELECT من الهوية والقيم. الطبيعة بقيت دائنًا دون تغيير يدوي و`Dr=false`، لا اعتماد semantics محاسبية. عند 07:11:36+03:00: `Account=1`, `Account_Cur_Detail=0`, `Group/Unit/Item=0`, والـChild غير موجود. **Root Save/reload: PASSED؛ Direct Child / activated SAR binding / Group eligibility: UNRESOLVED ولم تُنفّذ.** تصنيف/نوع تدفق/رابط الحساب المخزن NULL؛ عرض `1-أخرى` بعد التحميل ليس رابط مخزون مثبتًا. `Acc_Sort` تغير من NULL فور الحفظ إلى 1 بعد التحميل، والسبب الداخلي غير محسوم؛ لم يُصحح أو يُفسر بالتخمين. [التفاصيل والحدود](MOTAKAMEL_HOST_W11_BASELINE_2026-10-06.md#host-approved-balance-sheet-root-only-save-and-reload--2026-10-07). لا Child تلقائي ولا Unit/Group/Item أو S0b/S2/S3 أو SQL writes أو backup/Restore إضافية. يلزم مراجعة النتيجة وتفويض منفصل قبل Child. السجلات التالية تاريخية حيث تختلف؛ لم يعد Account صفرًا، ولا تأهيل Connector أو تغيير لمعمارية/Pilot #001.

**أحدث Discovery لحقل التقرير فقط — دون Save (2026-10-07):** المساعدة الرسمية المثبتة توثق ترحيل أرصدة الميزانية العمومية إلى الفترة التالية مقابل إقفال المصروفات/الإيرادات في الربح والخسارة. فُحص artifact التاريخي فعليًا: حساب المخزون `1141010001` وآباؤه الخمسة يحملون `A_Report=Balance Sheet`؛ تعريفات تقرير الحساب الحالية تميز هذه القيمة عن `Profit And Loss`. لذلك **الميزانية العمومية اختيار مقترح مبرر للتجربة المحايدة فقط**، ولم يُختر في المسودة ولم تُكرر Save. وراثة التقرير وتأثيره على التصنيف/الطبيعة/النوع وبقية mandatory fields وقبول Group ما زالت UNRESOLVED؛ لا نسخ للبنية المرجعية أو اشتراط رتبة 6. SELECT عند 06:40:40+03:00 أبقى Account/Account_Cur_Detail/Group/Unit/Item صفرًا. المسودة محفوظة بحالتها غير المحفوظة والتقرير فارغ. [الأدلة وحدود الاقتراح](MOTAKAMEL_HOST_W11_BASELINE_2026-10-06.md#host-report-field-only-discovery--2026-10-07). يلزم تفويض منفصل قبل اختيار التقرير/Save؛ لا Child أو Controlled Dataset أو تأهيل Connector.

**أحدث تجربة Host — أول Save توقف عند validation (2026-10-07):** بعد قبول المستخدم **DATABASE RESTORE PROOF PASSED** بحد قاعدة البيانات فقط، نجح pre-check للمصدر الحالي EFA12026 وصفر الحسابات وروابط العملات والهويتين، دون backup إضافية. محاولة Save الوحيدة للرئيسي `970701 / DBL_TEST_MAIN_20261007`، بأب `0` ونوع `رئيسي` ورتبة مشتقة `1`، طلبت: **«ادخل التقرير الذي يجب ان يظهر فيه الحساب»**. لم يُختر تقرير ولم تحصل إعادة محاولة. SELECT عند 06:21:30+03:00 أكد `Account=0`, `Account_Cur_Detail=0`, `i_group=0`, `Measure=0`, `item_detail=0`. **Root Save: BLOCKED** للمرشح ذي التقرير الفارغ؛ **Direct Child Save / persisted SAR binding / Group eligibility: UNRESOLVED، لم تُنفّذ**. لا بنية محفوظة أو Inventory Group مؤهلة ولا Unit/Group/Item أو S0b/S2/S3. أضيق خطوة تالية تحديد اختيار التقرير المبرر بتفويض منفصل، لا تخمين الميزانية العمومية أو إضافة مستوى ثالث. [الدليل وحدود RestoreProof والتجربة](MOTAKAMEL_HOST_W11_BASELINE_2026-10-06.md#host-authorized-two-account-experiment--first-validation-stop--2026-10-07). السجلات التالية تاريخية حيث تختلف مع هذه النتيجة؛ لم تتغير معمارية المنتج أو نطاق Pilot #001.

**أحدث دليل Host — فحص Add غير محفوظ ثم Cancel (2026-10-07):** الأب `0` مع Tab ولّد رتبة `1`، وحقل **نوع الحساب** نفسه يعرض `1 رئيسي / 2 فرعي`؛ هذا يصحح تفسير وضع العرض السابق، ولا يجعل جدول `account_types` الفارغ متطلبًا مفقودًا. الرئيسي المؤقت أظهر العملة المحلية SAR، والفرعي المؤقت سمح بتفعيل SAR في المسودة. التقرير يعرض الربح والخسارة/الميزانية العمومية، بينما نوع التدفق والتصنيف حقول منفصلة. لم يثبت الحفظ أو الفرعي المباشر أو أهلية Group؛ المسودة ذات أب 0/فرعي ليست إثبات حساب تشغيلي منفرد. Cancel مؤكد وSELECT بعده عند 05:40:31+03:00 أعادا `Account=0` و`Account_Cur_Detail=0`. [التفاصيل والتجربة المقترحة لحسابي TEST فقط وخطة الاستعادة](MOTAKAMEL_HOST_W11_BASELINE_2026-10-06.md#host-non-saving-add-inspection--2026-10-07). لا Save/Accept ولا إنشاء حساب/عملة/Unit/Group/Item؛ يلزم تفويض منفصل وحد استعادة مثبت قبل أول Save. السجلات التالية تاريخية حيث تختلف مع هذا الفحص؛ لم يتغير نطاق المنتج أو المسار الحرج.

**أحدث فحص للبنية الدنيا لحساب المخزون — Discovery فقط:** لم تثبت بنية قابلة للحفظ/الاختيار على Host؛ دليل الحسابات وGroup فارغان، وقوائم التصنيف/محدد الحساب معطلة في وضع العرض. المساعدة توثق Root/Main بأب `0` وحسابًا فرعيًا تشغيليًا مع عملة مفعلة؛ `Root/Main → فرعي مباشر SAR` فرضية حسابين لا minimum مثبت. لا دليل يفرض مستويات Reference أو رتبة 6. SELECT المحدود عند 22:28:33 أكد `Account=0` و`Account_Cur_Detail=0` و`i_group=0`؛ قيود metadata لا تثبت قواعد Save أو picker. شروط النوع/الرتبة/العملة المحلية/التصنيف وفلتر Group ما زالت غير محسومة. الخطوة الأضيق فحص Add غير محفوظ بتفويض منفصل؛ إن لزم اختبار حفظ، يكون على نسخة مستقلة قابلة للاستعادة وبقيم محاسبية معتمدة، لا على المضيف اعتمادًا على VERIFYONLY وحده. [تفاصيل البنية الدنيا وحدود الأدلة والتجربة المقترحة](MOTAKAMEL_HOST_W11_BASELINE_2026-10-06.md#host-minimum-account-hierarchy-discovery--no-mutation). لم يُنشأ أو يُحفظ أي سجل.

**أحدث اكتشاف لمسار حساب المخزون على Host — دون mutation:** عملة المخزون الحالية `SAR` مثبتة من الخيارات الأساسية، والدليل المحاسبي يعرض `SAR / Saudi Riyal`. ظهرت الإضافة الفردية، وإنشاء الدليل الافتراضي، وأيقونة الاستيراد؛ المساعدة القديمة توثقها كمسارات بديلة ولا تجعل إنشاء القالب شرطًا للإضافة الفردية. التوليد الآلي وتحديد رتبة فرعية ثابتة غير مفعّلين في الخيارات الحالية؛ لا دليل يعيد Account Numbering أو الرتبة 6 للمسار الحرج. SELECT ختامي أكد `Account=0` و`Account_Cur_Detail=0`. المسار الموصى به مبدئيًا هو حساب مخزون فرعي SAR مع الآباء الضروريين فقط بعد اعتماد بنيتهم، لا قالب كامل تلقائيًا؛ قبول حساب منفرد بلا آباء وشروط الحفظ لم يُختبرا. التفاصيل والفصل بين UI الحالي والمساعدة الإصدار 5 وأدلة Reference في [Host inventory-account route discovery](MOTAKAMEL_HOST_W11_BASELINE_2026-10-06.md#host-inventory-account-route-discovery--no-mutation). لم يُنفّذ Add/Edit/Save أو أي تهيئة.

**أحدث اكتشاف متطلبات على Host — دون حفظ:** فُحصت مسارات الوحدة والمجموعة والصنف ومساعدتها الرسمية. مساعدة المجموعة تجعل حساب المخزون إلزاميًا وتشترط تطابق العملة؛ فحص SELECT جديد ربط GL/inv الحاليين بـEFA12026 وأثبت `Account=0` و`Account_Cur_Detail=0`. أول متطلب مفقود هو حساب مخزون مناسب، فتوقف الاستكشاف دون Add/Edit/Save أو provisioning. إلزام بقية الحقول عند الحفظ لم يُختبر. لا يثبت ذلك ضرورة Account Numbering أو إنشاء قالب دليل كامل، ولا ينقل سجلات Reference إلى Host. التفاصيل والحدود في [Host prerequisite discovery](MOTAKAMEL_HOST_W11_BASELINE_2026-10-06.md#host-prerequisite-discovery--official-ui-no-save). الخطوة التالية قرار منفصل للطريقة الرسمية الضيقة لتوفير المتطلب، لا تنفيذ Controlled Dataset تلقائيًا.

**أحدث حالة مثبتة:** [Host W11 Motakamel Baseline / Backup / Bounded Direct Input Qualified — 2026-10-06](MOTAKAMEL_HOST_W11_BASELINE_2026-10-06.md). المضيف Windows 11 23H2 يشغّل GL.exe 8.03.0812 وSQL Server 2014 SP3 Express x86؛ التشغيل الفعلي لا يثبت الدعم الرسمي. قاعدة المضيف ليست Controlled Dataset الخاصة بالمختبر المرجعي. النسخة الاحتياطية وبصمتها موثقتان، وتأهيل الماوس والكيبورد المحدود داخل inv نجح بعد التشغيل العادي بمستوى Medium دون تعديل أمني. بقي خطأ التقاط قائمة التقارير غير محسوم؛ اكتملت بوابة النسخة الاحتياطية/الإدخال فقط، وأي اكتشاف تالٍ أو تعديل ERP يحتاج تفويضًا منفصلًا.

**سجل تاريخي خارج المسار الحرج الحالي:** [W11 Stage-B Installation Blocker and Preservation — 2026-09-30](MOTAKAMEL_W11_STAGE_B_INSTALLATION_BLOCKER_2026-09-30.md). يميز بين تثبيت ملفات Motakamel وفشل SQL، ويحفظ checkpoint التشخيصي مع حدود مصدر الأدلة وعدم اكتمال إخراج السجلات الأصلية. [Progress Checkpoint — 2026-09-25](LEGACY_INTELLIGENCE_PROGRESS_CHECKPOINT_2026-09-25.md) يبقى مرجعًا تاريخيًا لـItem A وS0b الجزئي وStage A؛ عبارات storage-blocked/not-started فيه ليست الحالة الحالية.

**تقاعد مختبر Windows 10 Agent Lab:** [Computer Use and Retirement Evidence](MOTAKAMEL_W10_AGENT_LAB_RETIREMENT_EVIDENCE_2026-09-25.md). نُفّذ بترخيص مستقل في 2026-09-28 واستُعيدت 37.175022 GiB؛ حُفظت النتائج وحدود إعادة الإنتاج، وليس كامل حالته القديمة. مختبرا Reference وAlMuhaseb1 باقيان محفوظين.

**الاستراتيجية التنفيذية الأحدث:** [Controlled Dataset → Design Partner Strategy](CONTROLLED_DATASET_TO_DESIGN_PARTNER_STRATEGY_2026-09-10.md) و[Controlled Motakamel Dataset #001 plan](CONTROLLED_MOTAKAMEL_DATASET_001_PLAN_2026-09-10.md). الدليل التعليمي قد يؤهل قدرة محدودة بمستوى LAB-PROVEN بعد مصالحتها؛ بيانات الشريك الواقعية مطلوبة لمستوى PARTNER-VALIDATED، ثم تجربة مستخدم تشغيلية لمستوى PILOT-QUALIFIED.

عقد تعلّم الـpilot: [Pilot Learning Contract #001 — Purchase Attention + Item Intelligence](PILOT_LEARNING_CONTRACT_001_PURCHASE_ATTENTION_ITEM_INTELLIGENCE_2026-09-06.md). هذه فرضية قيمة سوقية لا تثبتها بيانات المختبر وحدها: DBL يساعد المستخدم في مراجعة الأصناف وجمع معلوماتها، ولا يقرر الشراء أو المورد أو كمية الطلب بدل الإنسان.

المراجعة الاستراتيجية المرجعية: [Independent Full Product Review — 2026-09-06](INDEPENDENT_FULL_PRODUCT_REVIEW_2026-09-06.md). الحكم هو **CONTINUE WITH CORRECTIONS**: لا rewrite ولا تغيير جذري للمعمارية. قرار 10 سبتمبر اللاحق يسمح ببيانات تعليمية مضبوطة للتنفيذ المخبري المحدود قبل بيانات الشريك، دون خفض معيار التأهيل الواقعي. Account Numbering يبقى unresolved وليس blocker تلقائيًا للـConnector.

آخر checkpoint أدلة قبل المراجعة: [Motakamel Plus V1 Evidence Progress Checkpoint](MOTAKAMEL_PLUS_PROGRESS_CHECKPOINT_2026-09-03.md). آخر قرار دلالي سابق: [Minimum V1 Semantic Scope](MOTAKAMEL_PLUS_V1_SEMANTIC_SCOPE_2026-09-03.md). `EFA12026` REQUIRED، و`Multi_Lang` OPTIONAL للنطاق الأدنى السابق. لا تزال connector readiness غير معلنة.

1. `PILOT_LEARNING_CONTRACT_001_PURCHASE_ATTENTION_ITEM_INTELLIGENCE_2026-09-06.md` — **Current execution anchor**: المشكلة، المستخدم، Purchase Attention، Item Intelligence، حدود V1، success measures، وMotakamel evidence المطلوب.
2. `INDEPENDENT_FULL_PRODUCT_REVIEW_2026-09-06.md` — checkpoint استراتيجي وتقني: verdict، findings، إيقاف Account Numbering كمسار حرج، وخمس حركات نحو أول pilot.
3. `AI_HANDOFF.md` — أسرع نقطة لفهم أين توقف البناء وما الذي لا يجب كسره.
4. `CURRENT_STATUS.md` — الحالة التنفيذية والميلستونات الحالية.
5. `MOTAKAMEL_PLUS_PROGRESS_CHECKPOINT_2026-09-03.md` — checkpoint شامل لأدلة Motakamel: provisioning، least-privilege read، CONTROL SERVER denial، frozen backup snapshot، database boundary، والـGolden Dataset blocker التاريخي.
6. `ARCHITECTURE_REVIEW_2026-08-25.md` — خلاصة المراجعة المعمارية المستقلة السابقة وخطة remediation المقبولة.
7. `FIRST_CONNECTOR_TARGET_2026-08-25.md` — قرار First Connector Target وخطة Evidence Acquisition.
8. `MOTAKAMEL_PLUS_EVIDENCE_MILESTONE_2026-09-02.md` — أول Motakamel حقيقي: النسخة/SQL/المختبر/provisioning/pre-login/gate status.
9. `ALMUHASEB1_LAB_PROGRESS_2026-09-01.md` — سجل مختبر AlMuhaseb1: Golden Dataset، Hyper-V isolation، A/B Proof-of-Path، والـline-level blocker الحالي.
10. `VISION.md` — الرؤية طويلة المدى.
11. `ROADMAP.md` — ما تم وما تبقى من V1 ثم V2–V6.
12. `MARKET_STUDY_2026-08-21.md` — الدراسة السوقية المرجعية السابقة.
13. `MULTI_INDUSTRY_VISION_2026-08-21.md` — الرؤية متعددة القطاعات.
14. `DECISIONS.md` — القرارات الاستراتيجية والمعمارية المقبولة.

## الفكرة في سطر واحد

> **Make existing businesses intelligent without forcing them to rebuild their technology.**

طبقة ذكاء وتشغيل محلية، vendor-neutral، تُركب فوق الأنظمة القديمة أو المحلية وتضيف البحث والتحليل ثم الإجراءات والأتمتة تدريجيًا دون فرض migration كامل.

## First Wedge الحالي

الهدف السوقي الأول المختار حاليًا هو **YemenSoft Motakamel Plus ERP**، بشرط evidence acquisition ناجحة على إصدار/Schema حقيقي محدد.

لا نبني `YemenSoftConnector` عامًا ولا نفترض تشابه كل الإصدارات. أول adapter يكون خاصًا بنظام/إصدار محدد، ولا يطبّق إلا القدرات التي ثبتت دلالاتها بمختبر مضبوط ومصالحة مناسبة. البيانات الواقعية المصرح بها مطلوبة لاحقًا للتحقق لدى الشريك، لا لبدء أول قدرة مخبرية.

تم الوصول إلى نسخة `EFA6_EDU` حقيقية وتثبيتها في مختبر مستقل، وإثبات SQL Server `YSEDU` وdatabase topology ومسار provisioning ونجاح شاشة الدخول. كما ثبتت قراءة least-privilege مستقلة، ومنع `CONTROL SERVER`، وتقنية frozen single-database snapshot من backup متحقق منه. `EFA12026` هي القاعدة الوحيدة المثبتة REQUIRED حاليًا، بينما `Multi_Lang` و`DbRepDes` و`EFAARC10` ليست متطلبات مثبتة للنطاق الأدنى.

محاولات Golden Dataset على النسخة التعليمية كشفت أن إنشاء Customer يتطلب Account، وأن قاعدة التعليم كانت فارغة من دليل الحسابات حتى provisioning رسمي أنشأ 225 صفًا في `Account` و225 صفًا في `Account_Cur_Detail`. لاحقًا توقف مسار Customer عند قاعدة ترقيم sub-account غير المثبتة. بعد المراجعة المستقلة، **لا يُعاد Account Numbering إلى المسار الحرج**. استراتيجية 10 سبتمبر تبدأ بأدلة مخبرية مضبوطة للقدرات المستقلة، ثم تتحقق من تمثيلها وقيمتها ببيانات شريك مصرّح بها وخبير/مستخدم يفسر الحالات الفعلية.

**AlMuhaseb1 مسار مختبري موازٍ لاختبار acquisition boundaries على نظام legacy حقيقي، وليس بديلًا عن Motakamel Plus كـPrimary First Connector Target.** نتيجة Proof-of-Path الحالية له هي `B — PARTIALLY PROVEN`: خمسة domains منظمة مثبتة، بينما Sales Lines وSales Return Lines ما زالتا محجوبتين بفشل runtime في مسار Crystal detail reports. لا يُستأنف كمسار منتج موازٍ دون سبب تجاري/تقني واضح.

## ما تم بناؤه فعليًا حتى الآن

داخل `main` توجد حاليًا:

1. Core contracts + initial Canonical Model.
2. Connector contract + mock connector.
3. Import Orchestrator.
4. Durable SQLite local storage.
5. Bounded/staged imports + recovery.
6. Persistent Audit.
7. Streaming SnapshotReader.
8. Deterministic Insight Engine يعمل بدون AI أو Internet.
9. Local Query Engine مع typed QueryPlan.
10. Shared exact decimal arithmetic.
11. V1 Application Service Boundary.
12. Pinned Application Read Scopes.
13. Runtime connector isolation على application boundary.
14. Explicit query/insight provenance.
15. Real Connector contract validation/acceptance harness.
16. Read-only batched Reference SQLite Legacy Connector.
17. Proven SQL-to-canonical reference path.
18. Exact-key closed-world validation للـcanonical persisted boundary.
19. Stable `UNKNOWN_CANONICAL_FIELD` rejection بدل silent field loss.
20. Cross-platform CI على Ubuntu وWindows.

المراجعة المستقلة 2026-09-06 أكدت أن هذا backend foundation حقيقي، لكنه ليس بعد customer-ready end-to-end product. قبل pilot يجب معالجة targeted P1 trust findings حول runtime field types، source lifecycle cleanup، child-row memory bounds، evidence-driven Canonical Model semantics، provenance/acquisition manifest، deployment security، وstorage forward-version handling.

## المسار المعماري الحالي

`Legacy ERP -> System-specific Connector -> Import Orchestrator -> SQLite -> SnapshotReader -> Query/Insight Engines -> Application Service -> UI/Reports/future AI`

Dependency direction للطبقات العليا:

`UI / Reports / future AI Planner -> Application Service -> pinned Read Scope -> Query/Insight Engines -> SnapshotReader -> LocalStore`

الـApplication Service هي الحد الرسمي للقراءة. لا ينبغي بناء UI أو Reports أو AI Planner بمسارات موازية تصل مباشرة إلى SQLite أو تفاصيل المحركات الداخلية.

## Invariants أساسية لا يجب كسرها

- Offline/local-first للـcore operation.
- Read-only toward customer legacy systems في V1.
- No free-form SQL.
- Closed-world runtime validation، بما يشمل رفض unknown persisted canonical fields.
- `Unknown Source Field != Unknown Canonical Field`.
- Currency-safe financial semantics ولا implicit FX.
- Exact decimal arithmetic.
- Streaming/bounded-memory behavior، مع استكمال bounds على child rows قبل pilot.
- Snapshot-bound pagination.
- Pinned read-scope consistency.
- Explicit connector/snapshot provenance، مع توسيع acquisition manifest قبل pilot.
- AI ليس execution authority.
- Strict package/runtime boundaries.
- Normal upper-layer reads تمر عبر Application Service.
- SQL isolation assumptions database-specific.
- Implement first, abstract second.

## الدرس المعماري الحالي

المراجعات المستقلة لم توصِ بإعادة المعمارية. أحدث الحكم هو **CONTINUE WITH CORRECTIONS**.

الـfoundation قوية في contract/structural correctness. يمكن تنفيذ قدرة Motakamel مخبرية ضيقة بعد إثبات معناها ومصالحتها منفردة؛ أما تأهيلها للاستخدام مع شريك وpilot موثوق فيتطلب **representative semantic evidence + reconciliation + operational qualification + user value validation**.

لا نحول هذا إلى framework عام. لأول Motakamel connector ننتج artifacts خاصة بالنظام/version/pilot slice، ثم نستخرج abstraction فقط بعد evidence متكرر.

صرامة التحقيق لا تُخفض: الحد الأدنى من بيانات المختبر الرسمية يخدم إثبات القدرة، والبيانات الواقعية المصرح بها تخدم التحقق لدى الشريك. لا نهيئ ERP كاملًا فقط لفتح اعتماد خارج شريحة المختبر المختارة.

## V1 الحالي باختصار

المستهدف:

- Local Windows application.
- Offline-first.
- Read-only connector لنظام حقيقي واحد في البداية.
- **First pilot slice: Purchase Attention + Item Intelligence** حول سؤال عمل فعلي، وليس Sales Dashboard مفترضًا.
- Item context مرشح ليشمل inventory، previous purchase quantity + subsequent movement، bonus، movement profile، supplier history، وexisting purchase-order context فقط بعد إثبات semantics.
- DBL يبرز ما يستحق الانتباه ويشرح السبب، والإنسان يتخذ قرار الشراء.
- Arabic query/search experience لاحقًا ضمن الواجهة المناسبة.
- Basic reconciliation / provenance.
- Deterministic insights بعد إثبات semantics.

غير داخل V1 الحالي: autonomous purchasing، automatic supplier selection، automatic order quantity prescription، Voice، WhatsApp، unrestricted write actions، multi-industry implementation، LAN/multi-process semantics، Generic Schema Inspector، Universal SQL Connector، generic mapping DSL، full GL ما لم يثبت pilot الحاجة إليه.

## المسار التنفيذي المفضل الآن

`Host W11 backup + bounded input gate complete -> resolve narrow inventory-account prerequisite without guessed hierarchy -> separately authorize official controlled creation/evidence -> per-capability LAB-PROVEN mapping/reconciliation -> narrow Motakamel connector + focused UI -> Design Partner representative validation -> supervised pilot`

فشل Stage B التاريخي وإصلاح Agent Lab خارج المسار الحرج الحالي، لا إعادة تثبيت أو workaround أو Maintenance Create معتمد الآن. سجلات S1 المرجعية لا توجد على Host؛ حُفظ حسابا TEST رسميًا وثبت SAR وقبول Child في محدد حساب المخزون غير المحفوظ، لكن Group Save وUnit/Group/Item creation لم تُنفّذ بعد. S2 لم يبدأ، وS0b جزئي في Reference كما كان؛ لا يُعلن تأهيل حركة واردة أو Purchase Attention. البيانات الواقعية ليست شرطًا لكل سطر كود مخبري، لكنها شرط لتأهيل الشريك والـpilot. لا يُحذف مختبر قديم لمجرد ضغط المساحة دون إثبات حفظ أدلته وقرار مستقل.

لا نستخدم عدد connectors كمقياس نجاح. الـmoat المحتمل هو تراكم mapping knowledge، semantic fixtures/tests، compatibility profiles، reconciliation knowledge، version/schema drift knowledge، وoperational troubleshooting الذي يخفض تكلفة onboarding والدعم.

## الفصل بين الذاكرة والكود

هذا المستودع هو **ذاكرة المنتج والقرارات والحالة الموثقة**، وليس مستودع التنفيذ.

- Product memory: `elias-mujally/dbl-products-memory/products/legacy-intelligence/`
- Build repository: `elias-mujally/dbl-legacy-intelligence`

في أي جلسة جديدة: تحقق من مستودع البناء قبل ادعاء أن Capability منفذة، ثم حدّث الذاكرة بعد milestones أو قرارات رئيسية.
