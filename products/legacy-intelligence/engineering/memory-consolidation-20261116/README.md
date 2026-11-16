# توحيد الذاكرة وتدقيق الأدلة — 2026-11-16

[الحالة الحالية](../../CURRENT_STATUS.md) · [التسلسل الزمني](../../PROGRESS_HISTORY.md) · [القرارات](../../DECISIONS.md) · [سجل PKI](../self-contained-lab/PKI_PHASE1_20261116.md).

هذه مراجعة توثيقية معدة للمالك، دون commit أو push أو merge أو نشر. لا كود منتج أو مادة PKI أو SQL أو VM تغيرت في هذه المهمة. أُنشئت worktree مراجعة مستقلة من memory HEAD، ونُقلت إليها التغييرات التوثيقية السابقة كما هي قبل إعداد الإضافة؛ checkout الأصلية بقيت محفوظة.

## معنى التصنيفات

| التصنيف | ما يثبته وما لا يثبته |
|---|---|
| VERIFIED | كود/commit قرئ أو إيصال تنفيذ محفوظ وفُحص. نحدد «كود» أو «تنفيذ» أو «offline/synthetic»؛ لا يعني إجراء تجربة جديدة الآن أو production qualification. |
| DOCUMENTED | نية أو نتيجة تاريخية مسجلة في وثيقة المشروع؛ لا إعادة تحقق من بياناتها الخام أو بيئتها. |
| DECIDED | موافقة مالك صريحة بنطاقها وتاريخها؛ لا تتوسع من architecture/development إلى البنية التحتية أو النشر. |
| PLANNED | ترتيب أو اقتراح غير منفذ، ولا يمنح التنفيذ. |
| UNVERIFIED | دليل ناقص أو غائب، أو اختبار لم يُجر؛ الاختبار المتخطى ليس PASS. |
| SUPERSEDED | وصف/خيار تاريخي تجاوزته أدلة أو موافقة لاحقة في نطاق محدد؛ لا حذف للدليل القديم أو تحويل الفشل القديم إلى نجاح. |

## Coverage and source baselines

**VERIFIED:** قارنت رؤوس GitHub مباشرة في هذه الجولة، بحساب connector `elias-mujally`: المنتج main=`2f24efa50b71c4d91667dc12049c7a6ecc9e70b8`، والذاكرة main=`99bb8dc7054244a245feedb64fc1280fa6f9f44e`. رأسا checkout مطابقان. فحص first-parent history والوثائق الحالية ورؤوس التجارب المختارة يثبت أن S5/variable/native-sync/self-contained صارت ancestors لـ main؛ لا ادعاء بمراجعة كل سطر/فرع/CI في المستودعين.

قُرئت governance والرؤية والقرارات والحالة ومراجع التاريخ، ووصف المحرك والموصل و Workspace في source، والتقارير المحلية المختارة. لم تُشغل tests المنتج أو SQLite أو helpers الاقتناء أو SQL، ولم تُفتح VM. أرقام tests أدناه من سجلات محفوظة؛ لا «نجاح جديد» من تجميعها.

**VERIFIED، تطوير غير ملتزم به:** source على `codex/direct-erp-workspace-20261114` يضم ملفات SharedMemory/native/Desktop محلية فوق main؛ hashes في الجدول أدناه. التغييرات الست السابقة في ذاكرة المشروع (ثلاث إضافات للملفات المرجعية وثلاث وثائق جديدة) حُفظت ونُقلت إلى worktree المراجعة. ليست هذه الإضافة إعادة نسبتها إلى المهمة الحالية.

## Code Atlas

**DOCUMENTED + VERIFIED، قراءة README فقط:** [DBL Code Atlas](https://github.com/elias-mujally/dbl-code-atlas/blob/main/README.md) متاح. README blob=`66c753263d3305141487cf157559d8a4616b0230`؛ dataset يعلن indexed source=`415ad8acef5f5754487b83408bad6c9b9c58028e`، 12package/49productionTS/432symbol، مع علاقات uncertain مستثناة/موسومة. هذا سياق معماري قديم، ليس graph عند main2f24efa ولا مرجع تنفيذ SharedMemory المحلي. لم يُفتح deployment محمي أو Graphify، ولا refresh أو indexing أو إثبات اكتمال كل calls. لا أسرار أو graph source bodies في هذه الذاكرة.

## Local evidence

الجذر المحلي للأدلة، خارج المستودعين:

`C:\Users\user\Documents\Codex\2026-11-14\dbl-legacy-intelligence-direct-erp-connection`

المسارات في الجدول نسبية لهذا الجذر، ومثبتة بـ SHA256. لم تُنسخ logs أو قواعد أو شهادة أو مفتاح أو raw ERP rows إلى الذاكرة. إذا لم تتوفر الأصول في جلسة لاحقة، فلا تدّعِ إعادة تحقق منها؛ استخدمها كمرجع تاريخي وسجل غياب الدليل. تفاصيل النتائج في الملفات نفسها، لا في اسم الملف أو user prompt وحده.

| ID | المسار من الجذر المحلي | SHA256 | النطاق |
|---|---|---|---|
| E02 | `work/decision-review-ar.md` | `768D7740BAAB2A95B68AC598A1939285ADFCE328622BB49BCAA3F0C203BEDECA` | DOCUMENTED: investigation, no live execution |
| E03 | `outputs/VERIFICATION_SUMMARY.json` | `1D77E64AAC612DEFF07157A2F0266952B051FDD4B7EE42B1E431D118F6D2F39F` | VERIFIED: initial local tests, reader password unavailable |
| E04 | `outputs/READER_ACCOUNT_VERIFICATION_SUMMARY.json` | `6C186436875E8427CB32A72D03E738ACA8D83DEAC3CDB1DC4123A1B71F97690B` | VERIFIED: historical reader metadata; authentication/deletion uncertain |
| E05 | `outputs/OPERATIONAL_LIVE_SUCCESS_SUMMARY.json` | `54F4C01AF115A8883C4C395C107BC2FE64239201C207A590EE0D798C237D8FAE` | VERIFIED: Host READ_WRITE limited TCP workflow; parallel test failure retained |
| E06 | `outputs/OPERATIONAL_PERSISTENCE_AUDIT_EVIDENCE.json` | `09629E7B7094F44FC59D2A151F00978738823B04FBA8BC0303B7819FFA9A3E8A` | VERIFIED: three actual accepted captures and SQLite/Audit preservation |
| E07 | `outputs/NATIVE_SHARED_MEMORY_PARITY_REPORT_AR.md` | `41057012EEFD8B919167275E49A1559D81225C87C21684B89C0E74A39C3A3045` | VERIFIED: local candidate; simulated SQL is separate |
| E08 | `outputs/NATIVE_PARITY_CSHARP_TESTS.json` | `B64FC4BB9DF6B928F6306978BF79EB54A0A097DEA70C6944CA0EFEF9F59017C2` | VERIFIED: fake-session C# tests, not live SQL |
| E09 | `outputs/NATIVE_PARITY_CONNECTOR_TESTS.log` | `941F8EEEC67BFE5BFA0B6ABC5FA4DB509045FD76E86FEB96D4739B7CF86564F4` | VERIFIED: 269 pass/29 skip, run-specific |
| E10 | `outputs/VM_LAB_DIAGNOSTIC_VERIFICATION.json` | `C0CC742AF599B2577EADB83AE26B355037262811028E2C977953D62C2A9C3579` | VERIFIED: guest strict Open trust failure before queries |
| E11 | `outputs/VM_QUALIFICATION_VERIFICATION.json` | `43B3307070D11C05AC2710D1E9C8A59D6EDCB1D43B5BD98558B06AEA8B8B23AB` | VERIFIED: candidate not copied/executed; zero completed SQL commands |
| E12 | `outputs/VM_QUALIFICATION_TLS_ERROR_MEANING.json` | `BC896C825DEEF7D4E99E78A523D8106AE3BCC2FE73C957AD51813583D04B5D36` | VERIFIED: 0x80090325 Windows meaning |
| E13 | `outputs/SELF_CONTAINED_LAB_PKI_PLAN_AR.md` | `921F3A89DA14C5D6456BCF5B0C03855D8B1ABCB84887949BA137E9D412061262` | DOCUMENTED/DECIDED: reviewed VM-only PKI plan; not proof of issuance |
| E14 | `outputs/RECOVERY_0dba227c20094a198f8fdc614383b4be_completion-evidence.json` | `2D7BCB42D340D5D2A79CC2C8DE09BF72885BBA0A4DCC77F8B42B42EA8005543E` | VERIFIED: approved checkpoint completion; no restore test |
| E15 | `outputs/PKI_PHASE1_5983a12590034c32a322691e5cff19da_final-verification.json` | `D01F53360471B3CF344E8EDE2FF45B2CC24374FC05C27D78BBA04F3965CCCBC6` | VERIFIED: original partial CA, missing KU and UTC defect |
| E16 | `outputs/PKI_CA_EVIDENCE_89fda63cb0a04f82ba1118a1de904625_key-metadata.json` | `93C1E8B0C7759A1EE64E50E36C53EC64258568ED18B8A0D9160766675AF0D9B4` | VERIFIED: CSP24/KeySpec2 despite RSACng wrapper |
| E17 | `outputs/PKI_CORRECTION_EVIDENCE_INDEX_20261116.json` | `A3F046E9DFE8C00022CB1C29C9042063B250784720432D939716B8FBA60214C1` | VERIFIED: correction-design scope, no issuance |
| E18 | `outputs/pki-phase1-ready-20261116/guest-cmdlet-static-evidence.json` | `E3A8B59CE96365E3B6C0D7FE7FC22F0DFEB35C957D3DFAAF6D931CCE95698AEC` | VERIFIED: exact guest DLL static UTC bridge |
| E19 | `outputs/pki-phase1-execution-20261116-7a56ae1a65c64294b5f76065bebe79a7/04-issued-result.json` | `B4CE24DC000AF82C198CCC365B3ABE3F1295F91E9AC701AE8078F0B7282CADB6` | VERIFIED: original PRESERVATION_zone/UNKNOWN receipt unchanged |
| E20 | `outputs/pki-phase1-execution-20261116-7a56ae1a65c64294b5f76065bebe79a7/05-guest-receipts.json` | `483AC820DBAACB2B5C760FE24A8875F6FB1CB339B6726D259E93113A5AA6942F` | VERIFIED: attempt directory absent, SQL stopped |
| E21 | `outputs/pki-phase1-execution-20261116-7a56ae1a65c64294b5f76065bebe79a7/07-offline-cause-reproduction.json` | `7CF77DC083B2D2C9729FCD916587E6D5CF93570F32D6CC14164ADC3D90770C99` | VERIFIED: Double/Decimal false textual mismatch |
| E22 | `outputs/pki-phase1-zonefix-v2-20261116/zone-handoff-results.json` | `2D413CED729E7A0CF44C0192004DF23C0B84603EE9A4386563132D8D92BADF78` | VERIFIED: 78 checks in each real local PS process |
| E23 | `outputs/pki-phase1-zonefix-v2-20261116/regression-results.json` | `43C1922B44DDAA8C82B0C827A2F0FDC2A8D2AEAFE9E8FA6C966715559C993BD7` | VERIFIED: 30 regressions, no issuance |
| E24 | `outputs/pki-phase1-zonefix-v2-20261116/manifest.json` | `099BA32DE42D53770E718A194E714125E44961E6DF605E9ACA396A3115B24330` | VERIFIED: approved v2 package identity |
| E25 | `outputs/pki-phase1-execution-v2-20261116-9b3506e967e64a07aa75a3944af4fce1/04-issued-result.json` | `B71C102F6528A559B6CDFEC278891AE3EE6E678019724859631CE9FCE119512D` | VERIFIED: one successful CA issuance and actual identity |
| E26 | `outputs/pki-phase1-execution-v2-20261116-9b3506e967e64a07aa75a3944af4fce1/guest-03-qualified.json` | `0A57ABF91217B58C92F4E5628ECC9F50EA219F81AE43B9C505C59D45F728312A` | VERIFIED: actual certificate/provider/key/ACL/system state |
| E27 | `outputs/pki-phase1-execution-v2-20261116-9b3506e967e64a07aa75a3944af4fce1/07-acceptance-and-preservation.json` | `95638D8927BD939390091AB7B7E57DFE69B2DB10FAF4B1D2593FBE5422FE5F61` | VERIFIED: exact UTC and preservation checks |
| E28 | `outputs/pki-phase1-execution-v2-20261116-9b3506e967e64a07aa75a3944af4fce1/EVIDENCE_INDEX.json` | `739AE270008799AFA0320D22C640119F634B369FFFC5A7A4E35683DCDEC56050` | VERIFIED: execution evidence index |
| E29 | `outputs/pki-phase1-execution-v2-20261116-9b3506e967e64a07aa75a3944af4fce1/RESULT_AR.md` | `4D209492F8445C59BDF0A8755EFCC9FD9C854DD128D2CF9E925EF5DF7FCBF820` | VERIFIED: CA acceptance report; subsequent phases not executed |
| S01 | `work/product/packages/connectors-motakamel-plus/src/source.ts` | `5295A5D2F357A9B0192E27FB20910C428A8F6336DB585373E15E86A703886996` | VERIFIED CODE: frozen READ_ONLY profile; at product main |
| S02 | `work/product/packages/connectors-motakamel-plus/src/catalog.ts` | `4E8685A3DBB8F4B913E384C92F4EEA11981FE0F44AA0F3FA9DFDF198D1B78A40` | VERIFIED CODE: local READ_WRITE Catalog adapter, not committed |
| S03 | `work/product/packages/connectors-motakamel-plus/src/shared-memory.ts` | `523811BAE2004223C45CDD77D4C00574E6826C90CA4A278A3F382675F4783760` | VERIFIED CODE: local explicit helper selection, not committed |
| S04 | `work/product/packages/connectors-motakamel-plus/src/native-shared-memory.ts` | `D94295A1816855B8AD15C79F9C1A303F0BE8B857AA8AE3FF7A2209894C9BAA0F` | VERIFIED CODE: local EXE/config integrity pins, not committed |
| S05 | `work/product/packages/connectors-motakamel-plus/helpers/native/Acquisition.cs` | `E748E8D0047CDA76716F03105F3632F4C72B82A7211C42DB8F7142AFF66AD121` | VERIFIED CODE: LPC/strict TLS/source/transaction candidate, not live qualified |
| S06 | `work/product/apps/desktop/src/engine/erp-workspace.ts` | `D96A53832C3E0F000EE58F644078FAB2EEEB0C37BB1EC8841BD97AB57B46828D` | VERIFIED CODE: local shared pipeline integration, not committed |

## Contradictions and scope corrections

| التباين | الأدلة وطريقة عرضه للمراجع |
|---|---|
| ملفات CURRENT/README القديمة تعرض أكتوبر كأحدث حالة وSTOP عامًا | أضيفت أسبقية قراءة مؤرخة، مع إبقاء النص السابق. نجاحات أكتوبر وأخطاء metadata محفوظة تاريخيًا؛ لا تصف نوفمبر وحدها. |
| Draft/no-merge في S5/variable/native/self-contained مقابل وجودها في main | **VERIFIED، Git:** الرؤوس `fdafd4c…` و`277cea9…` و`ceff7ad…` و`7e195af…` أصبحت ancestors لـ2f24efa. استُبدل وصف الدمج زمنيًا؛ لم تتغير حدود الاختبارات الاصطناعية والبوابات الحية. |
| README المنتج ينفي ERP/persistence في Workspace، لكن E05 يثبت workflow حيًا | الأول يصف main/C0، والثاني تطويرًا محليًا غير ملتزم به على Host TCP. لا تنسب التجربة إلى الشريحة المدمجة. |
| READ_ONLY في الموصل القديم مقابل READ_WRITE التشغيلي | source.ts:82 يثبت قيد frozen profile؛ catalog.ts يثبت READ_WRITE مع حراس الصلاحيات والمعاملة. القراءة المحدودة تختلف عن حالة قاعدة البيانات؛ لم يُزل قيد الملف المجمد. |
| نجاح TLS/SQL على المضيف وفشل الضيف 0x80090325 | بيئتان وهويتان مختلفتان؛ E05 مقابل E10/E11. ثقة وشهادة المضيف في أكتوبر لا تثبتان وجودهما داخل V1 في نوفمبر. |
| ERP native EXE غير منشور، لكن C# DLL حُمّلت داخل VM | أداتان مختلفتان: E11 لا يثبت نشر أو تنفيذ acquisition candidate؛ PKI verifier DLL استُخدمت لخصائص CA فقط. |
| خطة 2 نوفمبر تقترح CA لسنة وCurrentUser trust وتمنع البصمات التشغيلية | موسومة SUPERSEDED حيث تختلف. القرار الأحدث CA180/leaf90، وRoot غير منفذة. طلب المالك الحالي يجيز تسجيل هوية CA العامة صراحة؛ لا مفاتيح أو certificate bytes أو نشر ضمن المهمة. |
| CA الأصلية موجودة لكنها غير مطابقة | E15/E16: KU غائب وUTC أسبق بثلاث ساعات. تبقى محفوظة دون إصلاح؛ قبول البديلة لا يغير تصنيف إخفاق الأصلية. |
| ready ثم PRESERVATION_zone STOP ونتيجة wrapper هي UNKNOWN | E19–E21: الخطأ قبل إنشاء مجلد المحاولة أو CA، والمجلد غائب وإعادة الإنتاج تثبت 180/180.0. استُنتج NO ISSUANCE بأدلة، مع حفظ UNKNOWN الخام. E22 يغطي handoff الفعلي الذي غاب عن الجاهزية الأولى. |
| اختلاف أعداد الاختبارات بين الملخص واللوج والمراحل | E05 يذكر 205 للموصل و171 للـDesktop وlatest-by-suite=1008؛ سجل ACTIVATION_CONNECTOR_TESTS.log يحصي 197 في تشغيل سابق. parity لاحقًا 269/178. لا تُجمع هذه كتشغيل واحد ناجح؛ فشل 19 timeout في parallel محفوظ، و394 pass في serial نتيجة منفصلة. |
| تذكر المالك حذف reader القديم بينما login موجود ومفعّل | E04 يثبت metadata وربط SID، دون اختبار authentication لغياب السر. حذف user أو إعادة إنشاء login أو حذف حساب آخر احتمالات غير محسومة. قارئ READ_WRITE الجديد تفويض لاحق مستقل. |
| checkpoint مكتملة مقابل حماية المادة الحالية | ثبت التسجيل وRealized/ProductionOnly، ولم يُختبر restore. النقطة تسبق الشهادتين؛ استعادتها تفقدهما وإيصالاتهما داخل VM بإقرار المالك. لا restore تلقائي. |

## Failures and lessons retained

**VERIFIED/DOCUMENTED ضمن أدلتها:** كانت unknown canonical fields تضيع بصمت قبل PR10؛ حارس closed-world مطلوب ولا تكفي أنواع TypeScript وحدها. تجاهل قارئ قديم historicalObservation رغم رفع version؛ توافق layout والقارئ يحتاج تحققًا فعليًا. خطأ harness audit API أوقف Orchestrator قبل الاتصال؛ تصحيح أداة الاختبار لا يغير الواقع التجاري. الهوية وmetadata وTLS وcredentials وauthority بوابات مستقلة، ولا تُحل بfallback أو fixtures. مفاتيح Catalog المرصودة لا تضمن الثبات عند إعادة الترقيم أو الاستخدام. نجاح عدة صفوف أو snapshots لا يثبت multisource production.

**VERIFIED، PKI:** تُقاس KU وcriticality وUTC وprovider وACL الفعلية، ولا يكفي splat أو غلاف .NET. يجب اختبار handoff نفسه عبر إصدارات PowerShell. حفظ الفشل الجزئي والأصول يمنع retry عند UNKNOWN؛ إصدار CA لا يثبت Root trust أو SQL leaf أو نجاح TLS.

## Remaining gaps and authorization

- **UNVERIFIED:** قاعدة ERP الفعلية وجلسة التطبيق، والقارئ وصلاحياته ومصادقته، والقراءة الحية داخل VM؛ Windows/TLS بعد leaf والربط، وتنفيذ EXE ومعاملات rollback/cancel على SQL فعلي.
- **UNVERIFIED:** بيانات عميل مأذونة، وتأهيل clean-machine وhuman/accessibility/pilot، والتوقيع والتوزيع. بعض بوابات Catalog الخارجية وC44 عند استعادة old DB دون witness تبقى جزئية أو مؤجلة كما وثق S5.
- **DOCUMENTED:** Oracle وAlMuhaseb مسارا استكشاف واقتناء؛ لا يثبتان دعم موصل Oracle/Access مكتملًا أو ترحيلًا ماليًا عامًا.
- **PLANNED:** مراجعة قبول CA ثم تفويض محدود للخطوة التالية من الخطة. لا leaf أو Root أو SQL start أو TLS أو نشر جانبي أو اقتناء مفوض بهذه الذاكرة. لا تغيير source pin أو helper أو credential تلقائيًا.
- **VERIFIED، حد المراجعة:** الأدلة محلية ولم يُجر قياس حي في هذه الجولة. روابط المنتج الخاص تحتاج وصول المراجع. لا تُختلق موافقة مستقبلية أو نتيجة CI لم تُفحص أو بيانات مفقودة.

النصوص التاريخية الأصلية باقية والرؤية لم تُعد كتابتها. الالتزام والدفع والدمج والنشر متوقفة لمراجعة المالك. وجود هذه الوثيقة لا يمنح سلطة تنفيذية.
