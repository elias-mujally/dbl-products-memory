# Motakamel Plus V1 — engineering memory

**Current V1 review —2026-10-24:** [Windows10 clean compatibility](WINDOWS10_CLEAN_ACCEPTANCE_20261024.md) passed within its synthetic/owner-assisted scope:18actual wrapper calls,5products1450SAR, history/replay/recovery, attributed owner browser review and four-file retention outside VHDX. Private originals remain owner-only. [Risk-prioritized remaining gates](V1_REMAINING_GATES_20261024.md) block customer-data onboarding pending supported/licensed endpoint, operational ACL/protection/component and source-scope qualification; human handover and [encrypted off-host recovery](OFFHOST_ENCRYPTED_BACKUP_PLAN.md) remain unqualified. PR21/product and PR10/memory were verified merged; no merge or release here. Earlier unavailable-environment/open-PR statements below are historical.

**Updated: 2026-10-23. PR20/PR9 were observed merged in GitHub; this stage did not merge them. Immutable Preview1 remains pinned. New18-call actual DBL.cmd prepared-host rehearsal, fresh Arabic-path ZIP extraction and8delivery controls passed. No independent clean environment is available; human/private ACL/Defender/browser/production qualification remains open.**

هذا الفهرس يربط التاريخ والقرارات والأدلة بدل تكرار التقارير. النطاق هو المختبر الجديد the isolated V1 test VM وقاعدته التجريبية فقط. لا يعيد تأهيل مصادر original host/historical sources التاريخية ولا يلغي قيودها.

## ابدأ من هنا

1. [تسلسل الإنجاز والعوائق](TIMELINE.md): من تشغيل الضيف إلى العينة المحفوظة والاستيراد الحقيقي.
2. [بنية البيانات والدلالات المؤهلة](DATA_SEMANTICS.md): الحقول والروابط والحسابات وأعلام الترحيل.
3. [قرار التكامل المتكرر وبدائله](ADR-V1-001-FILE-REFRESH.md): لماذا ملفات قراءة موثقة وتخزين دائم الآن.
4. [إعادة الإنتاج والتشغيل والاستعادة](RUNBOOK.md): شروط التشغيل وحدود التفويض وحالات الفشل.
5. [فهرس الأدلة والبصمات](EVIDENCE.json): مصادر كل حقيقة ومعرّفات الأدلة وبصماتها؛ المسارات الدقيقة محفوظة لدى المالك دون نشر.
6. [حالة التكامل المتكرر](RECURRING_STATUS.md): آخر إثبات عملي، وما بقي غير مؤهل. يُحدّث عند كل إنجاز مؤثر.
7. [نطاق الاختبار الثالث المعتمد](THIRD_CAPTURE_PLAN.md) و[نتيجته الفعلية](THIRD_CAPTURE_RESULT.md): صرف واحد محفوظ، T01=29 والإجمالي1450SAR، مع إثبات التاريخ وعدم التكرار والتراجع.
8. [مراجعة النشر ونطاق التفويض](PUBLICATION_REVIEW.md): سجل الإصلاحات والاختبارات قبل الموافقة اللاحقة على دمج PR19/PR8؛ PR9 ما زال للمراجعة.
9. [سجل النشر وروابط PR وCI](PUBLICATION_RECEIPT.md): ما نُشر للمراجعة، ونتائج الفحص، والحدود المتبقية.
10. [مراجعة ملاحظات Graphify](ADVISORY_REVIEW.md): الأعطال المعاد إنتاجها، والإصلاحات، والتحذيرات المستبعدة وحدود الخصوصية والتشغيل.
11. [نتيجة الدمج وبوابة الاستعادة للاختبار الثالث](MERGE_AND_RECOVERY_GATE.md): commits الدمج المؤكدة، إغلاق الملاحظات، والتوقف التاريخي الذي سبق تأهيل الاستعادة.
12. [تأهيل الاستعادة ونتيجتها المتحققة](RECOVERY_QUALIFICATION.md): طابق تقرير التنفيذ بصمته الأصلية، ونجحت الاستعادة المنفصلة وCHECKDB وتطابق الجداول الأحد عشر والأرصدة والقيود. أُعيد حساب بصمات الجداول من الاستخراج الأول فطابقت جميعها. تحقق لاحقًا الاحتفاظ بنسخة مطابقة خارج VHDX ثم نُفذ الصرف الثالث؛ تبقى استعادة المضيف كاملة غير مؤهلة.
13. [تقييم الاحتفاظ خارج VHDX](EXTERNAL_RETENTION.md): نتيجة النسخ الفعلي وبصمته، والمحاولات السابقة، وحدود استقلال النسخة عن VHDX وعن الجهاز المادي.

14. [حزمة التشغيل للمشغّل](OPERATOR_PACKAGE.md): دليل عربي، فحص المصدر والحالة، تقرير محلي، نسخ حالة DBL واستعادتها إلى مسار جديد، ونتائج قبولها وحدود تسليمها.
15. [اختبار التسليم المستقل](OPERATOR_HANDOVER.md): وكيل ثانٍ دون سياق سابق، نتائج منفصلة عن اختبارات المهندس، وفجوات التسليم وردود المراجعة والتحسينات وحدود التأهيل.
16. [حزمة Windows المحلية](WINDOWS_DELIVERY.md): الإصدار والمكونات والبصمات، إعادة البناء والتشغيل خارج التطوير، عطل النسخ في الاختبارات ومعالجته وحدود اختبار الجهاز النظيف والقبول البشري.

17. [بوابة Windows النظيفة](WINDOWS_CLEAN_GATE.md): إجراء تسليم مستقل،18أمرًا فعليًا عبر DBL.cmd وفك ZIP جديد، مع فصل بوابات البيئة والخصوصية والحماية والرؤية والإنسان عن نجاح المضيف.

## أحدث نتيجة فعلية

**FACT — PASS_ACTUAL_THIRD_CHANGED_DATA_PERSISTENCE_HISTORY_AND_REPLAY:** ثلاث عمليات استخراج حقيقية؛ صرف استهلاكي واحد أنقصT01 من30 إلى29 وقيمته من600 إلى580SAR. تقرير ERP والاستخراج الثالث وDBL تتفق على29/3/50/2/12 وإجمالي1450SAR. أربع عمليات CLI أضافت لقطة واحدة فقط؛ إعادة الثالث والأقدم لم تكرر الأصناف أو تُرجع الحالة الحالية. بقي التاريخ1470/1470/1450، ونجح إعادة فتح التخزين والتحليلات والتدقيق وفحص سلامة قواعده الثلاث. لا تغيير لكود المنتج ولا ادعاء SQL حي أو ترحيل GL نهائي. [الأدلة وإعادة الإنتاج والحدود](THIRD_CAPTURE_RESULT.md).

**FACT — حزمة التشغيل:** اجتازت430اختبارًا مع42تخطيًا معلنًا، و19تشغيلًا مستقلًا باستخدام الاستخراجات الثلاثة المحفوظة ونسخة من الحالة التشغيلية الناجحة. لم يحدث استخراج رابع أو تعديل ERP؛ بقي الأصل دون تغيير. [النطاق والقرارات والقبول](OPERATOR_PACKAGE.md)؛ [PR20 للمنتج](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/20).

## نتيجة الأساس المثبتة — تسلسل تاريخي

**FACT — PASS_ACTUAL_V1_IMPORT_PERSISTENCE_AND_ANALYSIS:** ملف ERP حقيقي تطابقت بصمته، 5 أصناف بكميات **30 / 3 / 50 / 2 / 12** وقيمة **1470 SAR**؛ ImportOrchestrator → SQLite → إغلاق وإعادة قراءة من عملية أخرى → Application Service والتحليلات. التكرار أبقى checkpoint واحدًا. لا اتصال SQL حي من DBL ولا استيراد مستندات ككيانات Canonical عامة.

**FACT — local code checkpoint:** `e82e5d003f7c546f170698ef2a107773d0837488`، tag محلي `codex/v1-inventory-pass-20261022` وGit bundle. هذه ليست main على GitHub؛ آخر أساس منتج مستعمل `415ad8acef5f5754487b83408bad6c9b9c58028e`.

**FACT — repeated integration:** التطبيق المحلي عند 471d104f8e5965229bf420f259fb7d47a94d391c استقبل استخراجين فعليين يقدمهما المالك، وتطابقت بصمتاهما. سبع عمليات مستقلة إلى التخزين نفسه أبقت لقطتين تاريخيتين وخمسة أصناف حالية وقيمة1470SAR؛ إعادة الملف الأقدم لم تتراجع بالحالة الحالية. استعادة نسخة حالة DBL السابقة نجحت. النقل الآلي وSQL الحي وتحديث صفوف أعمال تغيرت فعليًا لم تُؤهل؛ صفوف الاستخراجين متطابقة. [التفصيل وحدود الاختبارات](RECURRING_STATUS.md).

## كيف نقرأ درجات الإثبات

- **FACT:** سلوك أو صفوف أو ملفات فُحصت فعلًا، مع مرجع. حدد هل الدليل GUI أو SQL acquisition أو اختبار اصطناعي أو استيراد فعلي.
- **DECISION:** اختيار هندسي/محاسبي محلي مع السبب؛ لا يتحول إلى اشتراط موثق من YemenSoft لمجرد قبول الواجهة.
- **HYPOTHESIS:** تفسير مرجح لم يُحسم سببيًا.
- **UNQUALIFIED / PROPOSED:** لم يُختبر أو يحتاج قرارًا أو موافقة مستقلة. نجاح اختبار مصدر ملف ليس نجاح SQL حي.

## سياسة تحديث هذه الذاكرة

كل إنجاز يغير النتيجة أو النطاق أو مسار التشغيل يستلزم تحديث RECURRING_STATUS وفهرس الأدلة، ثم الملف المتخصص المتأثر فقط. قرارات البنية طويلة الأمد تُحدّث في ADR؛ لا تكدّس سجل المحادثة في AI_HANDOFF. اربط نقطة الدخول من فهرسي المستودع؛ تبقى ملفات handoff التاريخية المنشورة دون تعديل. لا تحفظ بيانات اعتماد أو مفاتيح أو قواعد/ملفات raw أو بيانات عملاء. تبقى ملفات العينة الخام الخاصة خارج مستودعي الكود والذاكرة.

بعد مرحلة المراجعة، وافق المالك صراحة على دمج PR19 وPR8 وعلى صرف وحدة تجريبية بشروط الاستعادة. دُمج الطلبان مع حفظ التاريخ؛ تفاصيل commits في سجل الدمج أعلاه. كان الصرف والاستخراج الثالث متوقفين حتى تأهيل الاستعادة؛ ثم نجحا في23أكتوبر وفق سجل النتيجة الأحدث. النسخة العامة منقّحة؛ المسارات الدقيقة للأدلة في سجل خاص لدى المالك. تحديث سجل ما بعد الدمج يُعرض في PR توثيقي جديد، دون دمج تلقائي إضافي.
