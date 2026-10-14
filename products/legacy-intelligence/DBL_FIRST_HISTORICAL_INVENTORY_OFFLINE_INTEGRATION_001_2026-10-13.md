# First Historical Inventory Offline Integration #001 — BLOCKED / design decision required

> Historical checkpoint preserved. [Merged state 2026-10-14](MERGED_STATE_2026-10-14.md) and [evidence register](EVIDENCE_REGISTER_2026-10-14.md) supersede earlier implementation/next-step gaps only within the qualified offline case. PR13/14/16/15/17 are merged; one inbound37 is qualified separately from historical balance37. No current stock, outbound, physical count, final GL posting, generalized ledger or live ERP qualification follows. Original failures/results/hashes below remain their original evidence; no raw re-verification or helper execution in this memory update.

**FIRST HISTORICAL INVENTORY OFFLINE INTEGRATION = BLOCKED / NOT PASSED.** توقفت مراجعة التنفيذ عند شرط المالك5: العقود الحالية لا تحفظ حقيقة المخزون التاريخية مكتملة عبر Canonical/SQLite/SnapshotReader، دون اختزالها إلى quantityOnHand عام أو protocol جانبي جديد. لم يبدأ تعديل أو استيراد أو اختبار تكامل. [نجاح historical evidence binding السابق](DBL_HISTORICAL_INVENTORY_EVIDENCE_BINDING_001_2026-10-13.md) عند5374af0 محفوظ، والاختبار الحي السابق NOT PROVEN لم يتغير.

## الفحص الفعلي قبل STOP

- FACT.json طابق SHA256 الكامل `0DE22CE4304839AC2D9807A45F448900C598F55177596A374D5A8E230A6FD670`.
- الأصل QUALIFICATION_EVIDENCE.json طابق `7D742175B6652860C7974115F8A1CBB789F49D86ACAD4FC5DD40CFCE310E7BAC`.
- قراءة مرجعية فقط أثبتت تطابق fact.evidence.sha256 وbackupUUID وrecordedBackupSHA256 وfrozenDatabase وsourceAsOf مع أثر backup/restore التاريخي، وتطابق quantity مع ReaderProjectionFirst.Balance[0].AvailableQty، وliveRead=false. لا إعادة استخراج أو تشغيل اختبارات الربط السابقة أو ادعاء قراءةSQL جديدة.
- مستودع البناء نظيف عند `84eadfddfd064ada961e36675ceffe24e33f2f3a`، tree `51f15b2a1113fc3742559f7d76dab350fb8bb83c`. راجعت source contracts وvalidation والاستيراد وstaging/storage/read/fingerprint والقواعد/application query. لا ادعاء تحقق جديد من remote build main.

## سبب التعطل — من الكود لا من افتراض

المراجع التالية تحت `packages/` في مستودع البناء `work/dbl-legacy-intelligence`:

| الطبقة | الدليل | الأثر |
| --- | --- | --- |
| Canonical Product/SourceRef | core/src/model.ts:12،18؛ storage.ts:37 | Product.quantityOnHand بلا scope/unit/sourceAsOf/balanceKind/liveRead؛ SourceRef ثلاثة حقول هوية/version فقط؛ SnapshotReader يعيد Product/Customer/Sale |
| Canonical validation | core/src/validation.ts:19،21،140،197 | closed-world keys؛ حقول FACT الإضافية ليست مدعومة وتُرفض بـUNKNOWN_CANONICAL_FIELD |
| ImportOrchestrator | import-orchestrator/src/orchestrator.ts:147،168،271 | يطبق Canonical validation، لا يدعم حقيبة FACT مستقلة تمر عبره تلقائيًا |
| SQLite write/read | storage-sqlite/src/sqlite-write-session.ts:138،387؛ sqlite-store.ts:151،310؛ migrations.ts:81،177 | أعمدة ونقل وإعادة بناء explicit؛ ليست product JSON payload عامة. FACT nested data لا تُحفظ بمجرد إضافتها إلى كائن |
| المستهلكون العامون | insights/src/rules.ts:43؛ query-engine/src/executor.ts:69 | يستهلكون quantityOnHand مباشرة دون تحكيم scope/as-of/liveRead. الرقم37 لن يولد low-stock افتراضيًا، لكن **غياب التأويل التاريخي قائم**؛ ليس ادعاء حدوث تنبيه فعلي |
| التطبيق | application-service/src/service.ts:openReadScope؛ types.ts | snapshot/connector context عام، لا عقد لقراءة observation تاريخي مكتمل وتقديمه بهذا المعنى |

إذن لا يُنقل37 إلى quantityOnHand العام، ولا تُخفى معلومات النطاق فيname/sku/sourceVersion أو capturedAt وحده. sidecar/manifest مرجع versioned كان **مقترحًا** في readiness؛ لا توجد الآن معاملة موحدة أو validation/read contract تثبت اكتماله في جميع المستهلكين. نقلid/name عبرDBL ثم ضم الرقم منFACT خارجيًا قد يصلح معاينة جانبية، لكنه لا يثبت مرور الحقيقة عبر الطبقات المطلوبة، فلا يُنفذ كحل ناجح صامت.

## أصغر تغيير مقترح لموافقة منفصلة — غير منفذ

اعتماد **حقل اختياري typed واحد** على Product، مثل `historicalInventoryObservation`، وليس quantityOnHand أو نموذج مخزون عام جديد:

- observation schema/version وfactId؛ quantity DecimalString مستخرجة من FACT؛ branch/warehouse/unit/package؛ balanceKind ثابت لتأهيل ERP available/book التاريخي؛ source-as-of؛ historical acquisition interval؛ provenance بمراجع FACT/الأصل/backup؛ وliveRead=false إلزاميًا.
- scope/provenance/time تُخزن مع القيمة كوحدة واحدة؛ غيابها أو تعارضها يمنع الحفظ/العرض. Product.id/name يجب أن يطابقا observation، ويُمنع quantityOnHand في هذا profile التاريخي حتى لا يُستهلك الرصيد كعام/حي.
- migration additive واحدة تضيف عمود JSON اختياريًا **لكل من committed وstaging product tables**، مع writer/commit/reader/materialization/fingerprint round-trip. لا إعادة كتابة migrations السابقة أو مسحDB، ولا migration على snapshot الإنتاجي. لا collection عامة أو صلاحيات أوSQL جديدة.
- version/compatibility gate واضحة؛ لا نفترض أن optional field أو minor version وحدهما يضمنان توافق قارئ قديم: core/version.ts يقارن major فقط، وrunMigrations الحالي لا يرفض كل future migration غير معروفة. يجب تأهيل منع القراءة الناقصة/الإسقاط الصامت على مسار observation. تفاصيل version وفشل المستهلك القديم جزء من قرار التصميم، لا تُطبّق الآن.
- file-only profile/connector مستقل بهوية versioned، دون تحميل SQL driver أو تغيير الموصل الحي؛ إعادة استعمال ImportOrchestrator معattempt واحد، SQLite **تجريبي جديد ومعزول**، ثم SnapshotReader وقراءة التطبيق/مقدم عربي محدود يقرأ observation كاملة من الناتج، لا يحقن FACT في العرض بعد التخزين.

هذا يغيّر Canonical وSQLite ولذلك يتطلب موافقة صريحة وفق STOP الحالي. ليس اقتراح توسعة شاملة أو إعادة بناء Connector؛ الطرق القديمة وquantityOnHand العام وsnapshot الهوية السابق تبقى كما هي.

## ما سيُختبر بعد اعتماد التصميم فقط

Positive: بصمةFACT وربط الأصل → file connector → Canonical observation → ImportOrchestrator → isolatedSQLite → close/reopen → SnapshotReader/application → «الرصيد المتاح المؤهّل تاريخيًا»، مع37 **مستخرجة من الدليل** وUA/B1/W1/package1 والتوقيت والمصدر وliveRead=false؛ quantityOnHand غائب وcounts1/0/0.

Negative: provenance ناقص/متغير أو FACT hash مختلف؛ scope/item/unit/package غير مطابق؛ fact/product مكرر؛ write/commit/read يفقدmetadata؛ attempt liveRead=true أوquantityOnHand عام؛ source-as-of مفقود/مغير/مستقبلي أو خلطه بوقت الاستيراد؛ consumer/schema قديم يسقطobservation. التاريخ القديم نفسه **ليس فشلًا تلقائيًا** لأن المالك اعتمد historical claim؛ يجب إبقاء العمر والتوقيت ظاهرين، ولا اختراع TTL أو تحديثas-of إلى اليوم. حدود العدد/bytes ونumeric exact-integer profile تبقى؛ حالات الاختبار الاصطناعية ليست مصدر الحقيقة.

هذه اختبارات **مقترحة وغير منفذة**. Build/typecheck/CI/audit/round-trip/DBL preview لم تبدأ بسبب STOP التعاقدي؛ لا تُسجل PASSED أو fixture-as-integration proof. معاينةPREVIEW.md السابقة ليست مخرجًا من مسارDBL ولا تستوفي الهدف الجديد.

## الحدود والقرار المطلوب

في هذه المهمة: SQL/ERP/function/admin/credentials=0؛ لا code/Canonical/SQLite/host/security/source changes، ولا newSQLite أوimport أوsnapshot mutation أوtests. الأدلة التاريخية الأصلية محفوظة و`.vscode` خارجcommit؛ SALES & INVENTORY لم يبدأ، وتشخيصadmin لا يُستأنف.

**القرار المطلوب:** موافقة تصميم وتنفيذ مستقلة على optional historical observation typed field، ومigration additive للـstaging/committed storage، وversion/reader fail-closed، والعرض التاريخي المحدود. أو اختيار إبقاءFACT معاينة خارجDBL دون تسمية ذلك integration PASSED. **STOP.**
