# Legacy Intelligence — Current Status

آخر تحديث: **2026-09-03**

## الحالة

**BUILD IN PROGRESS — Motakamel Plus Evidence Acquisition is active; installation, official provisioning, launch, and the pre-login architecture baseline are proven, but connector evidence gates remain incomplete.**

مستودع البناء:

`elias-mujally/dbl-legacy-intelligence`

آخر `main` موثق:

`95bf225e1523e0fd0f72cdf3da8393df18d635cc`

## Milestones المندمجة

### 1. Foundation Hardening Round 2

- PR #5
- Merge commit: `ab3db09c5afebaea1db741087af146c9771b32cc`

### 2. Persistent Audit + Deterministic Insight Foundation

- PR #6
- Merge commit: `1db738aae59c8b61e95cac99975d9864ab306947`

### 3. Local Query Foundation

- PR #7
- Merge commit: `54301b5ea3e0756b9935e6a3df31f954118c1c10`

### 4. V1 Application Service Boundary

- PR #8
- Merge commit: `4d2e8fa59914c371c21b2176663dda38e39fd67f`
- Final verified CI: Run #173 على Ubuntu وWindows.

### 5. V1 Real Connector Foundation + SQL Reference Adapter

- PR #9
- Merge commit: `5028dc48db331574168c2658afee2c8206913a52`
- Final verified CI before merge: Run #192 على Ubuntu وWindows.

أضاف:

- `@dbl/connector-test-kit`.
- `accepted / smoke-passed / rejected` semantics.
- observed capability evidence.
- read-only batched Reference SQLite connector.
- lifecycle-neutral health probe.
- keyset paging.
- database-specific snapshot/isolation proof.
- early cancellation cleanup/restart coverage.
- bounded chunking لخطوط الفواتير بدل N+1.
- end-to-end SQL reference path إلى Application Service / Query / Insights.

### 6. Closed-world Canonical Validation Remediation

بعد مراجعة معمارية مستقلة للكود، تم اكتشاف defect فعلي: unknown canonical fields كان يمكن أن تمر runtime validation ثم تُسقط بصمت عند SQLite persistence/fingerprinting.

تم تنفيذ remediation واحد فقط وإبقاؤه focused:

- PR #10 — `Close canonical validation against silent field loss`
- PR head: `0fb18e982e90ae09b5e68f306c406ee97a7f29ff`
- Final verified CI: Run #194 على Ubuntu وWindows.
- Squash merge commit: `95bf225e1523e0fd0f72cdf3da8393df18d635cc`

#### ما تم إصلاحه

- Exact-key validation للـSnapshot / SnapshotHeader / SourceRef / Batch / Product / Customer / Sale / SaleLine / Money.
- unknown enumerable own keys تُرفض الآن بخطأ ثابت `UNKNOWN_CANONICAL_FIELD`.
- unknown fields لا تصل إلى staging أو fingerprint.
- Buffered import يفشل بدون committed snapshot عند field مجهول.
- Batched import يعمل abort/cleanup ولا يجعل snapshot جزئية مرئية.
- لا Canonical Model expansion.
- لا ERP-specific fields.
- لا architecture redesign.
- fingerprint algorithm وschema/migrations لم تتغير.

## نتيجة المراجعة المعمارية المستقلة — 2026-08-25

الحكم: **Needs targeted fixes**, وليس re-architecture.

القرارات الأساسية التي بقيت صحيحة:

- Local/offline-first.
- Read-only V1.
- SQLite local store.
- Exact decimal strings.
- Currency-bound Money ولا implicit FX.
- Atomic staged import.
- Database-specific isolation tests.
- No free-form SQL.
- AI ليست execution authority.
- Pinned read scopes.
- Source-specific connectors.
- Implement first, abstract second.

أهم gap كشفته المراجعة:

> Contract/structural correctness ليست كافية لإثبات business/accounting correctness.

لذلك readiness لأول market connector يجب أن يُفهم على ثلاث طبقات بدون بناء framework عام مبكر:

1. **Contract Conformance** — ما يثبته test kit الحالي بدرجة كبيرة.
2. **Semantic Reconciliation** — mapping evidence + source totals/counts/status/currency/timezone semantics.
3. **Operational Qualification** — read-only enforcement، isolation، cancellation، Windows lifecycle، performance/resource behavior.

`result="accepted"` في test kit لا يجب تفسيره وحده كـproduction readiness.

## First Connector Target الحالي

تم اختيار **YemenSoft Motakamel Plus ERP** كـPrimary First Connector Target، بشرط evidence acquisition ناجحة على product/version/schema محدد.

لم يتم بعد بناء Motakamel connector.

ما ثبت سوقيًا/تقنيًا حتى الآن:

- Motakamel Plus مناسب جدًا لـProducts / Inventory / Customers / Sales.
- تم الحصول على حزمة `EFA6_EDU` التعليمية الحقيقية وتثبيتها في مختبر Windows معزول وقابل للتخلص.
- تم إثبات SQL Server 2014 Express instance `YsEDU` وقواعد `Multi_Lang` و`DbRepDes` و`EFA12026` و`EFAARC10`.
- تم إثبات مسار pre-login: `GL.exe → YsEDU → FMMA → Multi_Lang`، من دون ادعاء أن `EFA12026` تُستخدم قبل الدخول.
- لا يوجد schema رسمي عام لدينا، ولم يبدأ Source Schema Inventory بعد.
- لا نفترض أسماء الجداول أو semantics.
- لا نبني `YemenSoftConnector` عام.

مسار التنزيل القديم ومراسلة YemenSoft أصبحا سياقًا تاريخيًا وليسا blocker حاليًا. `AlMuhaseb1` يبقى acquisition/evidence lab فقط، وليس بديلًا لـMotakamel Plus أو مصدرًا لـschema الخاصة به.

## Motakamel Plus evidence milestone — 2026-09-02

- `GL.exe` build `8.03.0812` ومسار التثبيت `C:\EFA` مثبتان.
- فشل provisioning الأول أعيد إنتاجه في VM نظيفة؛ المسار الرسمي `Maintenance Create` أكمل `FMMA` وأنشأ `EFAARC10` مع mutations مرجعية موثقة.
- تم إثبات نجاح التشغيل والوصول إلى شاشة الدخول.
- `FMMA` SQL login ممكّن وعضو `sysadmin` و`dbcreator`؛ لا يوجد database principal مستقل له في `EFA12026`، وسلوك `dbo` مفسّر بعضوية `sysadmin`.
- **DBL must not assume FMMA is an appropriate connector identity.**
- التفاصيل وتصنيف الأدلة في `MOTAKAMEL_PLUS_EVIDENCE_MILESTONE_2026-09-02.md`.

### Access and frozen-backup qualification — reviewed 2026-09-03

- هوية SQL مستقلة ذات CONNECT وobject-level SELECT نجحت في القراءات المحددة دون FMMA؛ منع CONTROL SERVER مثبت بفحوص الصلاحية الفعلية الآمنة. هذا ليس allowlist كاملة لـV1.
- live READ COMMITTED أظهر blocking وغياب transaction-wide repeatability؛ لم تتغير RCSI/SNAPSHOT options على المصدر.
- **BACKUP-RESTORE SNAPSHOT QUALIFIED** داخل المختبر لقاعدة EFA12026 واحدة: COPY_ONLY+CHECKSUM، restore إلى DB/files مستقلة، READ_ONLY، ثلاث قراءات متطابقة مع تغيّر المصدر الاصطناعي بعد backup.
- المسار أصبح مرشحًا حقيقيًا لـoffline/fallback acquisition باستخدام backup يوفره العميل/DBA ونسخة قراءة يجهزها مسؤول مستقل؛ ليس قرارًا بأن DBL سينفذ backup/restore بصلاحيات مرتفعة عند العميل.
- Read-only Access & Isolation يبقى **PARTIAL**: حدود قواعد V1، الأداء التمثيلي، فصل الصلاحيات والتشغيل لم تكتمل. رُصدت91 dependency rows ذات database name دون حسم أهدافها أو ضرورتها لـV1.
- Source Schema Inventory وMapping وBusiness Reconciliation تبقى **NOT STARTED**. البيانات الاصطناعية لهذا الاختبار ليست Motakamel Golden Dataset.
- لا Connector implementation ولا Canonical Model change. Motakamel Plus يبقى Primary First Connector Target، وAlMuhaseb1 مختبر أدلة فقط.

## Artifacts المطلوبة قبل Motakamel connector coding

1. System and Version Profile.
2. Read-only Access & Isolation Record.
3. Source Schema Inventory.
4. Mapping Evidence Table.
5. Reconciliation Baseline.
6. Unsupported / Unresolved Semantics List.
7. Dataset Size & Performance Profile.
8. Exact V1 Connector Scope Decision.

Mapping/Reconciliation يجب أن يثبت، حسب ما يوجد فعليًا في المصدر:

- source table/column + joins؛
- filters؛
- status/type semantics؛
- returns/cancellations؛
- sign conventions؛
- currency semantics؛
- timezone conversion؛
- null/default policy؛
- excluded/rejected rows؛
- counts/totals against source reports؛
- golden records قابلة للتتبع.

لا Generic Mapping DSL في هذه المرحلة.

## ما أصبح موجودًا فعليًا الآن في `main`

1. Core contracts + Canonical Model.
2. Connector contract + mock connector.
3. Import Orchestrator.
4. Durable local SQLite storage.
5. Bounded batched imports + staging + recovery.
6. Persistent Audit.
7. Streaming SnapshotReader.
8. Deterministic Insight Engine.
9. Local Query Engine.
10. Shared exact decimal arithmetic.
11. V1 Application Service Boundary.
12. Pinned Application Read Scopes.
13. Runtime connector isolation.
14. Explicit query/insight provenance.
15. Real Connector contract validation/acceptance test kit.
16. Read-only batched Reference SQLite Legacy Connector.
17. Proven SQL-to-canonical mapping reference path.
18. Proven end-to-end SQL reference path.
19. Exact-key closed-world persisted canonical validation.
20. Stable rejection of unknown canonical fields.
21. Cross-platform CI on Ubuntu + Windows.

## Invariants لا يجب كسرها

- no free-form SQL.
- read-only first.
- database-enforced read-only حيث يدعم المصدر ذلك.
- exact-key closed-world validation على persisted canonical boundary.
- currency-safe financial semantics.
- exact decimal arithmetic.
- streaming/bounded-memory behavior.
- snapshot-bound pagination.
- pinned read-scope consistency.
- explicit connector/snapshot provenance.
- strict package/runtime boundaries.
- upper layers لا تتجاوز Application Service للقراءة الطبيعية.
- smoke validation ليست full contract acceptance.
- contract acceptance ليست وحدها production readiness.
- SQL isolation assumptions database-specific.
- implement first, abstract second.

## ما لا نصلحه الآن بدون Motakamel evidence

- إضافة warehouse/status/returns/tax/UOM/branch إلى Canonical Model.
- Generic mapping DSL.
- Generic schema inspector.
- AI semantic mapping.
- Universal SQL layer.
- Generic query pushdown framework.
- Generic incremental import framework.
- Reference SQLite performance cleanup غير المفيد مباشرة لـMotakamel.
- package consolidation.
- Audit redesign.

## قبل أول Pilot يجب حسم

- Semantic reconciliation completed.
- Read-only enforcement وSQL Server isolation مثبتان.
- Cancellation/deadline behavior.
- UI responsiveness/non-blocking behavior.
- Snapshot retention أو تعطيل recurring unbounded imports.
- Disk-growth budget.
- Storage forward-version guard.
- Backup/restore + credential/config handling.
- Packaging/clean-machine verification.
- Representative performance + Windows lifecycle.

## Milestone التالي

**Targeted V1 Database Boundary Qualification.**

على disposable restored read-only copy، احسم هل القراءات المرشحة لـV1 تبقى داخل EFA12026، مع فحص الإحالات المسماة إلى قواعد أخرى قبل اختيار single-/multi-database acquisition boundary. هذه خطوة مقترحة وليست منفذة؛ لا mapping ولا Connector coding.
