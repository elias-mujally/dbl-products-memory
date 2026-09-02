# AI Handoff — Legacy Intelligence

## الهدف

هذا الملف يتيح لأي مساعد AI أو مطور استعادة سياق Legacy Intelligence بسرعة دون إعادة اختراع المنتج أو تغيير معماريته من الذاكرة الجزئية.

## اقرأ أولًا

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

## الحالة الهندسية الحالية — 2026-09-02

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

حالة البوابات في 2026-09-02:

- System and Version Profile: `PARTIAL`؛ pre-login baseline مكتمل، والـmodules/customization/schema version غير محسومة.
- Read-only Access & Isolation Record: `PARTIAL`؛ المختبر معزول، لكن هوية read-only المستقلة لم تُثبت.
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

**آخر نقطة evidence موثقة:** Motakamel Plus installation/provisioning/launch وpre-login baseline مثبتة في `MOTAKAMEL_PLUS_EVIDENCE_MILESTONE_2026-09-02.md`. الخطوة التالية الوحيدة هي **Read-only Access & Isolation Record** بهوية SQL منفصلة قليلة الصلاحيات في disposable VM، وليس schema mapping أو generic abstraction.
