# AI Handoff — Legacy Intelligence

## الحالة الحالية المزامنة — 2026-10-14

**آخر نتيجة: ONE EXISTING OUTBOUND ACQUISITION 001 = BLOCKED / NO QUALIFYING EVENT عند preflight، وليس نتيجة بحث حي.** [التقرير](ONE_EXISTING_OUTBOUND_ACQUISITION_001_REPORT_2026-10-14.md) و[القرار التالي](ONE_EXISTING_OUTBOUND_ACQUISITION_001_NEXT_DECISION_2026-10-14.md): وافق المالك على read-only live acquisition، لكن prerequisite ربط عائلة مستند الصرف غير مؤهل في الأدلة السابقة؛ SQL/ERP attempts=0. لا تطلب التفويض العام ذاته، ولا تستبدل Reader المجمد بإداري أو تفترض صلاحيات على EFA الأصلية. يلزم mapping/metadata أصلي مؤهل أو قرار اكتشاف metadata-only محدد؛ لا جداول/joins/status بالتخمين، لا grants/transaction أو تنفيذ منتج. STOP.

**آخر نتيجة: OFFLINE OUTBOUND EVIDENCE HANDOFF 001 = BLOCKED / EVIDENCE UNAVAILABLE.** اقرأ [تقرير التوفر والمصفوفة والبصمات](OFFLINE_OUTBOUND_EVIDENCE_HANDOFF_001_REPORT_2026-10-14.md) و[القرار التالي](OFFLINE_OUTBOUND_EVIDENCE_HANDOFF_001_NEXT_DECISION_2026-10-14.md) قبل أي عمل منصرف. لا حزمة إضافية محفوظة في النطاق المحلي؛21 مصدرًا عامًا كلها مفحوصة سابقًا و5pins مطابقة. لا تُعد Discovery أو مسودة5، ولا تحوّل النقص إلى صفر/32 أو تبدأ تنفيذًا. يلزم توفير مسار حزمة أصلية أو تفويض استحواذ مستقل عند الحاجة إلى اتصال جديد. لا SQL/ERP أو كود/استيراد/merge في هذا التسليم؛ STOP.

ابدأ بالحالة المدمجة وسجل الأدلة ثم نتيجة التسليم والقرار التالي أعلاه. لا تستأنف STOP أو helpers التاريخية باعتبارها أمرًا حاليًا. PR17 merged؛ المنتج يملك Arabic application preview، وليس GUI. Discovery اكتملت، وHandoff توقف عند غياب الحزمة؛ الخطوة التالية توفير أدلة أصلية بتفويضها المحدد، وليس تكرار البحث نفسه أو تنفيذ منصرف.

[الحالة والقبول والمخاطر](MERGED_STATE_2026-10-14.md) · [PRs/milestones/evidence](EVIDENCE_REGISTER_2026-10-14.md) · [NEXT](OUTBOUND_EVIDENCE_DISCOVERY_001_PLAN.md) · [تدقيق الملفات](MEMORY_AUDIT_2026-10-14.md)

## السياق السابق المحفوظ — historical, superseded where inconsistent

الفقرات التالية تعكس زمن تدوينها، حتى حيث تقول «أحدث» أو «التالي» أو STOP. لا تتجاوز الحالة الحالية أعلاه؛ فشل SQL/identity السابق لم يُعَد تصنيفه.

## الهدف

هذا الملف يتيح لأي مساعد AI أو مطور استعادة سياق Legacy Intelligence بسرعة دون إعادة اختراع المنتج أو تغيير معماريته من الذاكرة الجزئية.

## اقرأ أولًا

**أحدث نتيجة14 أكتوبر06:47+03 — OFFLINE HISTORICAL INTEGRATION PASSED:** [One real file-source import and complete DBL readback](DBL_FIRST_HISTORICAL_INVENTORY_OFFLINE_IMPORT_001_2026-10-14.md). المالك وافق على harness fix فقط؛ databasePath/constructor-only audit تحقق typed/runtime memory مع424pins. actual Orchestrator calls=1/attempts=1، fresh SQLite، reopen/SnapshotReader/app/full observation/Arabic preview passed؛37 UA scoped historical as-of2026-10-09، liveRead=false، no general quantityOnHand.4 negative DB copies exact errors؛ successDB unchanged، integrity/FKs/audit pass. Product HEAD unchanged `0c325c8`؛ old failed harness/SQLite/results retained unchanged؛ no successful test/build rerun أوSQL/ERP/credentials/production/security/merge/deploy/sales. لا تعِد تشغيل harness أو import؛ ليس proof لرصيد اليوم/current FindAvQty أو قبول identity؛ source live NOT PROVEN وcurrent definition NOT TESTED. **STOP للمراجعة المستقلة**؛ الفقرات السابقة أدناه تاريخية، `.vscode` خارجcommit.

**أحدث STOP14 أكتوبر — storage gate PASSED، integration NOT PASSED:** [Implementation and local harness failure](DBL_HISTORICAL_INVENTORY_STORAGE_GATE_AND_INTEGRATION_STOP_001_2026-10-14.md). المالك وافق على versioned layout؛ نُفذت العقود/JSON/جداول `_v4` وcompatibility guard محليًا عند `0c325c8` دون push/merge. actual old reader/app/writer/cleanup rejected؛ build/typecheck/258 tests passed وlive test skipped. فشل harness المحلي باستخدام audit API خاطئة قبل `importFrom`؛ **OrchestratorCalls=0**، لا committed historical snapshot أو Arabic DBL preview. لا تعِد تشغيله أو تصلحه تلقائيًا؛ الأصل والـSQLite الخالية محفوظان. أصغر تفويض لاحق: تصحيح databasePath/constructor-only audit، تأهيل offline typed/API shape، ثم أول import مستقل في مجلد جديد. لا SQL/ERP أو صلاحيات/هوية/production/live qualification changes، لا sales/merge. الفقرات الأدنى تاريخية؛ `.vscode` خارجcommit.

**أحدث STOP14 أكتوبر = legacy-reader compatibility gate BLOCKED، بعدموافقةالحقل وليس تكرارطلبه:** [الاختبار الفعلي](DBL_HISTORICAL_INVENTORY_LEGACY_READER_COMPATIBILITY_001_2026-10-14.md). نسخةDBL القديمة31pins رأتSQLite تشخيصيةمعJSONFACT وتجاهلتobservation فيSnapshotReader2.1/3 وapp query3؛ bufferedgetLatest رفضmajor3 فقط، initialize تجاوزmigration4. لا تدّعأنschema version الجديد وحدهيحميالقارئالقديم. حاجةإضافية إلىحاجزlayout: جداولProduct أسماءversioned دونlegacyviewsمتساهلة، أوتضييقمعيارموافقعليه؛ **مقترح فقط يحتاجموافقةمستقلة**. لاrepo/code/Canonical/migration تغيّر، OrchestratorCalls0، لاproductionDB/SQL/ERP/secret أوintegration preview؛ historical bindingPASSED، الهدفNOTPASSED. STOP، لاmerge أواستئنافadmin/sales، `.vscode` خارجcommit.

**أحدث STOP = historical offline integration BLOCKED / design approval needed:** [العقود والاقتراح](DBL_FIRST_HISTORICAL_INVENTORY_OFFLINE_INTEGRATION_001_2026-10-13.md). FACT والأصل pins/reference PASS، لكنالـclosed-world Canonical وexplicitSQLite columns لا يدعمان scope/time/meaning/provenance/liveRead كحقيقة كاملة. لا37 فيquantityOnHand العام ولاضمFACT خارجي بعدidentity import وادعاءنجاحintegration. المالكاشترطSTOP عند عدمكفايةالعقود؛ لاcode/tests/SQLite/import نُفذت. optional historicalObservation + additive JSON committed/staging + fail-closed version/read + scoped presenter مقترح فقط يحتاج تفويضًا مستقلاً. historical binding PASSED باقٍ، live sourceNOT PROVEN، admindiagnostics مؤجلة؛ STOP، `.vscode` خارجcommit.

**أحدث نتيجة = HISTORICAL INVENTORY EVIDENCE BINDING PASSED، لا تنفيذ داخلDBL:** [Historical fact evidence](DBL_HISTORICAL_INVENTORY_EVIDENCE_BINDING_001_2026-10-13.md). المالك اعتمدhistorical claim بدل current FindAvQty لهذه المرحلة فقط. FACT محلي واحد37 UA/B1/W1/package1 من نتيجةReader الأصلية، matched0/+37، pinned evidence/source/backup/time، liveRead=false؛58checks/55negative مع إعادة حسابBigInteger مستقلة. لاSQL/ERP/secret/import أوcode/Canonical/SQLite changes؛ تعريفحالي NOT TESTED والاختبار الحي السابق NOT PROVEN. لا تستخدم replay الهوية لنقلquantity يدويًا أوتعتبرالمعاينة واجهةDBL. الربط داخلالمنتج وFIRST INVENTORY INSIGHT يحتاجان تفويضًا مستقلًا؛ STOP، تشخيصadmin مؤجل، `.vscode` محفوظ خارجcommit.

**أحدث قرار = SIMPLIFICATION REVIEW COMPLETED، لا تنفيذ:** [First Inventory decision](DBL_FIRST_INVENTORY_INSIGHT_001_SIMPLIFICATION_REVIEW_2026-10-13.md). أوقف المالك سلسلة identity diagnostics مؤقتًا؛ لا تستأنفها أو تغيّر بوابتها تلقائيًا. يوصي التقرير بدليل SQL مؤهل سابقًا لحقيقة تاريخية scoped/as-of، لا تعريف حالي أو رصيد اليوم أو live import. يحتاج الادعاء ومعياره موافقة صريحة، ثم تجربة offline evidence binding المحدودة. لم تُقرأ raw business exports ولم تُشغّل SQL/helpers/tests. FIRST LIVE DATA يبقى identity-only؛ ربط quantity/provenance والعرض يحتاج تنفيذًا لاحقًا محدودًا، لا إعادة بناء عامة. Inventory/source NOT PROVEN؛ الأدلة والكود محفوظة و`.vscode` خارج commit. **STOP قبل أي تجربة أوSQL أوتعديل.**

**أحدث مراجعة لإشارة المصادقة = COMPLETED، offline فقط:** [Contained authentication signal review](DBL_CONTAINED_AUTHENTICATION_SIGNAL_REVIEW_001_2026-10-13.md). `authenticating_database_id>0` ثابت منCASE السابق، لكن actualID/containment غير محفوظين. هناك اختلاف بينLearn الحالي0 للـLogin ومقالMicrosoft تمهيديDenali CTP1 يذكرmaster؛ لا تفترضSQL2014=1 أوcontained مثبتة. Windows/SID PASS تثبت المقارنات لا نطاق المصادقة. reason code السابق تصنيف أداة؛ FAIL التاريخي والبوابة unchanged/BLOCKED. مقترح واحد self-session وصفي لحسمMASTER/TARGET وcontainment/authscheme، غير منفذ ويحتاج تفويضًا مستقلًا؛ لا tool/policy edits أو SQL/host/function/business/Reader/import. attestation/inventory NOT PROVEN، `.vscode` خارجcommit؛ STOP. التفسير السابق أدناه تاريخي وتحدّثه هذه المراجعة دون تغيير الأدلة.

**أحدث تشخيص جلسة = COMPLETED22:11+03، لا قبول ناجح:** [One actual self-session diagnostic](DBL_SESSION_IDENTITY_DIAGNOSIS_001_2026-10-13.md). أصل/current/session/SQL SID comparisons الأربعPASS وWindows integratedPASS؛ noncontainedFAIL منpositive authenticating_database_id، exact name equality السابقFAIL، current SID/sysadmin السابقانPASS. لا ترخّصالبوابة بالـSID وحده ولا تفسرإشارةcontained تلقائياً؛ gate unchanged/BLOCKED وattestation/inventoryNOT PROVEN.80checks محلية جديدة، اتصال/SELECT واحد، لا أسماء/SIDs/hashes مشتقةمنها، no grants/elevation/function/business/Reader/import/SQLite/security changes أو retry، cleanup خالٍ. أي تفسيرللإشارة أو تعديلpolicy أو attestation يحتاج موافقة مستقلة؛ STOP.

**أحدث مراجعة أمنية للهوية = COMPLETED، دون SQL:** [Offline policy review](DBL_ADMINISTRATIVE_IDENTITY_SECURITY_REVIEW_001_2026-10-13.md). البوابة الأصلية unchanged/BLOCKED؛ لا تعتبر SID الحالي PASS إثباتًا لـSID الأصلي أو اسمين FAIL دليلاً تلقائيًا على impersonation/benign alias. النص الصارم قد يرفض نفس الهوية لكن إسقاطه الآن غير مصرح وآثاره غير مثبتة. مقترح one self-session SID/auth diagnostic غير منفذ يحتاج تفويضًا جديدًا؛ أي استبدال للشرط يحتاج قرار سياسة مستقل وتأهيل سلبي/إيجابي، ثم attestation وربطReader لاحقين بموافقات مستقلة. لا SQL/host probes، لا أدوات تنفيذ/صلاحيات/TLS/function/business/Connector/import changes؛ STOP.

**أحدث تشخيص الهوية فقط = COMPLETED21:02+03:** [Actual three-condition evidence](DBL_ADMINISTRATIVE_IDENTITY_DIAGNOSIS_001_2026-10-13.md). SID-match PASS وSQLsysadmin PASS، لكن اسمSQL الأصلي/الفعال غير متطابق بمعيار-ceq الأصلي، FAIL؛ gate يبقىBLOCKED ولم يُخفف. لا تخلطWindowsAdmin=false معSQLsysadmin ولا تستنتجimpersonation أو benign alias/case سببًا بلا دليل.10 اختبارات محلية، اتصال/SELECT واحد؛ no SID/principal-name publication أو privileges/function metadata/business/Reader/import/retry. Attestation وinventory NOT PROVEN. لا تعديلacceptance أو استئنافmetadata/Reader/رفعWindows؛ كلخطوة تحتاجموافقة مستقلة، STOP.

**أحدث إفادة إدارية مستقلة:** [FindAvQty metadata attestation identity STOP](DBL_FINDAVQTY_ADMIN_METADATA_ATTESTATION_001_2026-10-13.md)،20:48+03. اتصال integrated صارم واحد، لكن أولSELECT للهوية فشلApprovedIntegratedAdministrativeIdentity قبل قراءةmetadata للدالة؛ لا تفترض أي شرطSID/sysadmin/effective-name بعينه إذ لم يُحفظ صف الهوية. Offline checks PASSED فقط؛ function attestation NOT PROVEN، no function/business/Reader/import/SQLite calls ولا mutations/retries. لا تُعد helper ولا ترفعصلاحيات أو تغير أدواتReader. أصغر خطوة مقترحة identity-only read-only بالطريقة المعتمدة نفسها تحتاج موافقة منفصلة. SOURCE QUALIFICATION لا يزالBLOCKED؛ لا ربطattestation/Reader أو تجاوزguard، STOP.

**أحدث نتيجة فعلية نهائية:** [Inventory Source Reader metadata STOP](DBL_INVENTORY_SOURCE_001_QUALIFICATION_2026-10-13.md)،20:38+03: TLS وReader/READ_ONLY/SELECT/EXECUTE guards PASSED؛ تعريفFindAvQty غير مرئي وVIEW DEFINITION=0، safe codeREADER_FUNCTION_DEFINITION_UNAVAILABLE. FunctionCalls=0 وBusinessProjectionQueries=0؛ no new balance/import/SQLite، dependencies not reached. التصحيح المحلي ناجح لكن source qualification NOT PROVEN. المحاولة الحية مستهلكة؛ لا تعِد launcher/runner ولا تمس attempt/result أو permissions. إفادة إدارية read-only لتعريف/معاملات/تبعيات الدالة في نفسstage تحتاج موافقة منفصلة، ولا تعني admin acquisition أو إسقاط guard تلقائيًا. كلpending أدناه تاريخي. STOP.

**أحدث تفويض/نتيجة:** تصحيح Inventory helper بإذن مستقل بعدcd29b69 اجتاز التأهيل المحلي دون SQL، [التفاصيل والبصمات](DBL_INVENTORY_SOURCE_001_QUALIFICATION_2026-10-13.md). runner المصحح351FC1D4 وwrapper520B23CD وlauncherDC1D5710 فقط؛ الأول القديمD7F100B4 يبقى محفوظًا ولا يُستخدم. أول محاولة Reader حية مسموحة بعد فحص حديث وإدخال مخفي، لكنها لم تُنفّذ بعد في هذا السجل. لا تدّع PASSED قبل قراءة فعلية ومطابقة؛ metadata invisibility تعني STOP دون grants/admin/function-first أو retry. لا Connector/Canonical/SQLite/import/FIRST LIVE DATA. فقرة STOP السابقة أدناه تاريخية وليست إلغاءً للتفويض الجديد.

**أحدث STOP لتأهيل المصدر:** [Inventory source preparation failure](DBL_INVENTORY_SOURCE_001_QUALIFICATION_2026-10-13.md)، قبل SQL بسبب قراءة خاطئة لشكل array في أدلة تعريف الدالة. لا تنفّذ runner المحلي غير المؤهل أو تصلح وتعيد تشغيله تلقائيًا. لا تفسره كفشل Reader metadata أو كرصيد جديد؛ يلزم موافقة التصحيح المحدود ثم أول محاولة Reader.

**توجيه المالك الأحدث (2026-10-13):** اقرأ [FIRST INVENTORY readiness review](DBL_FIRST_INVENTORY_INSIGHT_001_READINESS_2026-10-13.md) و[نجاح FIRST LIVE DATA الحقيقي](DBL_FIRST_LIVE_DATA_001_REAL_SQL_IMPORT_2026-10-13.md) قبل استئناف التنفيذ. الجاهزية اكتملت بالمراجعة فقط؛ لا اختبار inventory جديد مصرح به. شراء37 محفوظ، صرف5 مسودة ملغاة، لا تفترض32. Connector الحالي لا يقرأ كمية؛ لا تستأنفS3 أو الأرشفة أو تغيّر Canonical تلقائيًا. Sales & Inventory مؤجلة حتى نجاح Inventory وتفويض جديد. STOP عند طلب تنفيذ خارج مراجعة الأدلة.

1. `README.md`
2. `CURRENT_STATUS.md`
3. `ARCHITECTURE_REVIEW_2026-08-25.md`
4. `FIRST_CONNECTOR_TARGET_2026-08-25.md`
5. `VISION.md`
6. `ROADMAP.md`
7. `MARKET_STUDY_2026-08-21.md`
8. `MULTI_INDUSTRY_VISION_2026-08-21.md`
9. `DECISIONS.md`

## الوصف الحالي

DBL يبني **Local-First Legacy ERP Intelligence Layer**: طبقة ذكاء وتشغيل محلية فوق ERP/POS/Accounting/Custom Systems القديمة، تعمل بدون اعتماد دائم على الإنترنت، وتتحول تدريجيًا من Read-only intelligence إلى controlled actions ثم automation.

## المبادئ الثابتة

- لا تبنِ ERP كاملًا أولًا.
- ابدأ بنظام قديم حقيقي واحد وعميل حقيقي واحد.
- Read-only أولًا.
- AI لا يكتب مباشرة في قاعدة البيانات.
- AI طبقة intent/analysis اختيارية؛ deterministic validation/execution هي authority.
- Cloud اختياري وليس dependency لازمة للعمل المحلي.
- Implement first, abstract second.
- Connector knowledge وbusiness semantics أصول دفاعية مستقبلية.
- الرؤية متعددة القطاعات، لكن V1 رأسي وضيق.

## الحالة الهندسية الحالية — 2026-09-03

مستودع البناء:

`elias-mujally/dbl-legacy-intelligence`

آخر `main` موثق:

`95bf225e1523e0fd0f72cdf3da8393df18d635cc`

### Milestones

- PR #5 — Foundation Hardening Round 2 — `ab3db09c5afebaea1db741087af146c9771b32cc`
- PR #6 — Persistent Audit + Deterministic Insights — `1db738aae59c8b61e95cac99975d9864ab306947`
- PR #7 — Local Query Foundation — `54301b5ea3e0756b9935e6a3df31f954118c1c10`
- PR #8 — V1 Application Service Boundary — `4d2e8fa59914c371c21b2176663dda38e39fd67f`, CI #173 green Ubuntu + Windows.
- PR #9 — Real Connector Foundation + SQL Reference Adapter — `5028dc48db331574168c2658afee2c8206913a52`, CI #192 green Ubuntu + Windows.
- PR #10 — Close canonical validation against silent field loss — `95bf225e1523e0fd0f72cdf3da8393df18d635cc`, PR CI #194 green Ubuntu + Windows.

## PR #10 المهم جدًا

مراجعة معمارية مستقلة كشفت defect فعليًا: unknown canonical fields كان يمكن أن تمر validation ثم تُسقط بصمت عند SQLite persistence/fingerprinting.

تم إصلاح ذلك فقط، بدون architecture expansion:

- exact-key validation للـSnapshot/Header/Source/Batch/Product/Customer/Sale/SaleLine/Money؛
- error ثابت `UNKNOWN_CANONICAL_FIELD`؛
- buffered import لا يلتزم عند invalid field؛
- batched staging يعمل abort/cleanup؛
- لا Canonical Model fields جديدة؛
- لا schema/migration/fingerprint changes.

هذا يجعل invariant `closed-world runtime validation` مطبقًا فعليًا على persisted canonical boundary.

## نتيجة المراجعة المعمارية المستقلة

الحكم: **Needs targeted fixes**، وليس إعادة معمارية.

ما بقي صحيحًا ويجب الحفاظ عليه:

- Local/offline-first.
- Read-only V1.
- SQLite local store.
- exact decimals + currency-safe Money.
- atomic staged imports.
- DB-specific isolation testing.
- no free-form SQL.
- AI ليست execution authority.
- pinned read scopes.
- source-specific connectors.
- implement first, abstract second.

أهم درس جديد:

**Contract correctness != business/accounting correctness.**

لذلك readiness لأول connector يجب أن يحتوي عمليًا على:

1. Contract Conformance.
2. Semantic Reconciliation.
3. Operational Qualification.

لا تحول هذه الثلاثة الآن إلى generic packages/framework. الـtest kit الحالي يثبت contract conformance بدرجة كبيرة؛ semantic reconciliation وoperational qualification تكون evidence خاصة بأول system/version.

## المسار المعماري الحالي

`Legacy ERP -> System-specific Connector -> Import Orchestrator -> SQLite -> SnapshotReader -> Query/Insight Engines -> Application Service -> UI/Reports/future AI`

ومن الأعلى للأسفل:

`UI / Reports / future AI Planner -> Application Service -> pinned Read Scope -> Query/Insight Engines -> SnapshotReader -> LocalStore`

## ما أصبح موجودًا فعليًا في `main`

1. Core contracts + initial Canonical Model.
2. Connector contracts + mock connector.
3. Import Orchestrator.
4. Durable SQLite local storage.
5. Bounded/staged imports + recovery.
6. Persistent Audit.
7. Streaming SnapshotReader.
8. Deterministic Insight Engine.
9. Local Query Engine.
10. Shared exact decimal arithmetic.
11. V1 Application Service Boundary.
12. Pinned Application Read Scopes.
13. Runtime connector isolation + explicit provenance.
14. Connector contract validation/acceptance test kit.
15. Read-only batched Reference SQLite Legacy Connector.
16. Proven SQL reference mapping/end-to-end path.
17. Exact-key canonical closed-world validation.
18. Cross-platform CI on Ubuntu + Windows.

## First Connector Target الحالي

**YemenSoft Motakamel Plus ERP** هو Primary First Connector Target حاليًا.

لم يتم بناء connector بعد.

تم الحصول على `EFA6_EDU` التعليمية الحقيقية وتثبيتها في VM معزولة. تم إثبات:

- `GL.exe` build `8.03.0812` وSQL Server 2014 Express instance `YsEDU`؛
- قواعد `Multi_Lang` و`DbRepDes` و`EFA12026` و`EFAARC10`؛
- المسار pre-login: `GL.exe → YsEDU → FMMA → Multi_Lang`؛
- إكمال provisioning عبر `Maintenance Create` الرسمي ونجاح الوصول إلى شاشة الدخول؛
- `FMMA` هو SQL login عالي الصلاحية وليس connector identity مقبولة مفترضة.

لم يثبت استخدام `EFA12026` قبل الدخول، ولم يبدأ Source Schema Inventory أو Golden Dataset. راجع `MOTAKAMEL_PLUS_EVIDENCE_MILESTONE_2026-09-02.md`.

القواعد:

- لا تبن `YemenSoftConnector` عامًا.
- لا تفترض schema أو table names.
- لا تفترض أن Silver/Gold/Pro أو الإصدارات المختلفة متطابقة.
- استهدف product/version/schema محددًا من evidence حقيقي.
- SQL Server موثق للعائلة، لكن exact engine/version/configuration للتركيب المستهدف يجب إثباته ميدانيًا.

مشكلة التنزيل ومراسلة YemenSoft سياق تاريخي؛ ليست blocker حاليًا بعد الحصول على الحزمة الحقيقية.

Artifact `AlMuhaseb1` من YemenSoft تم فحصه فقط كـecosystem evidence وظهر فيه Access `.mdb`. لا يُستخدم كبديل لـMotakamel Plus schema.

## المطلوب قبل كتابة Motakamel connector code

يجب إنتاج:

1. System and Version Profile.
2. Read-only Access & Isolation Record.
3. Source Schema Inventory.
4. Mapping Evidence Table.
5. Reconciliation Baseline.
6. Unsupported/Unresolved Semantics List.
7. Dataset Size & Performance Profile.
8. Exact V1 Connector Scope Decision.

حالة البوابات — محدّثة في 2026-09-03؛ راجع `MOTAKAMEL_PLUS_V1_SEMANTIC_SCOPE_2026-09-03.md`:

- System and Version Profile: `PARTIAL`؛ pre-login baseline مكتمل، والـmodules/customization/schema version غير محسومة.
- Read-only Access & Isolation Record: `PARTIAL`؛ هوية مستقلة ذات CONNECT/object SELECT ومنع CONTROL SERVER وsingle-DB frozen-backup technique مثبتة. حدود V1 الدلالية والأداء/التشغيل لم تكتمل؛ لا FMMA كهوية DBL.
- Source Schema Inventory: `NOT STARTED`.
- Mapping Evidence Table: `NOT STARTED`.
- Reconciliation Baseline: `NOT STARTED`.
- Unsupported/Unresolved Semantics List: `PARTIAL`.
- Dataset Size & Performance Profile: `PARTIAL`.
- Exact V1 Connector Scope Decision: `PARTIAL`.

Semantic evidence يجب أن يغطي حسب المصدر الفعلي:

- source table/column + joins؛
- status/type semantics؛
- returns/cancellations؛
- sign conventions؛
- currency semantics؛
- timezone؛
- null/default policy؛
- exclusions/rejections؛
- counts/totals مقابل تقارير المصدر؛
- golden records يمكن تتبعها end-to-end.

## لا توسع Canonical Model بالتخمين

لا تضف الآن warehouse/status/returns/tax/UOM/branch لمجرد أنها شائعة في ERP.

عندما يكشف Motakamel أن فقد semantics معينة يجعل V1 غير صحيح، أضف أصغر delta مثبت بالدليل.

## حدود مؤجلة عمدًا

- Generic mapping DSL.
- Automatic schema inspector.
- Universal SQL dialect layer.
- AI semantic mapping.
- Generic query pushdown framework.
- Generic incremental import framework.
- LAN/multi-process semantics.
- Persisted/cross-process read scopes.
- Write actions / controlled Agent execution.
- Package consolidation/Audit redesign.

## قبل أول Pilot، وليس قبل Evidence Acquisition

- completed semantic reconciliation؛
- proven DB-enforced read-only + SQL Server isolation؛
- cancellation/deadline behavior؛
- UI responsiveness/non-blocking behavior؛
- retention/disk-growth safety أو manual bounded imports؛
- forward-version storage guard؛
- backup/restore + credentials/config security؛
- packaging/clean-machine verification؛
- representative performance + Windows lifecycle.

## الفصل بين البناء والذاكرة

مستودع البناء: `elias-mujally/dbl-legacy-intelligence`.

ذاكرة المنتج: `elias-mujally/dbl-products-memory/products/legacy-intelligence/`.

تحقق دائمًا من مستودع البناء قبل اعتبار Product Memory دليلًا على implementation state.

**آخر نقطة بناء موثقة:** PR #10 merged via Squash Merge at `95bf225e1523e0fd0f72cdf3da8393df18d635cc`.

**آخر نقطة evidence/قرار موثقة:** `MOTAKAMEL_PLUS_V1_SEMANTIC_SCOPE_2026-09-03.md`. القرار **DATABASE BOUNDARY STILL REQUIRES GOLDEN DATASET**. EFA12026 REQUIRED؛ Multi_Lang OPTIONAL للحد الأدنى فقط، لا globally unnecessary ولا EFA-only sufficiency proven. أبق raw payment-key discriminators، ولا تشترط full translated payment enum. **Bills.Bill_Type != journal.doc_type dictionary unless independently proven**. الخطوة التالية الوحيدة المقترحة **Motakamel V1 Targeted Golden Dataset Qualification** داخل المختبر، بعد إذن إدخال البيانات؛ لم تبدأ Golden Dataset أو Schema Inventory/Mapping الكامل. لا Connector/Canonical Model change.
