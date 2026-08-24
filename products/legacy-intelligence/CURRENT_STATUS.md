# Legacy Intelligence — Current Status

آخر تحديث: **2026-08-24**

## الحالة

**BUILD IN PROGRESS — Real connector foundation merged; next gate is the first actual legacy ERP/accounting integration**

تم الانتقال من mock-only connector behavior إلى أساس هندسي حقيقي لأول تكامل legacy: acceptance/certification harness صار يميز بوضوح بين smoke validation والقبول الكامل، وتم بناء Reference SQLite connector read-only/batched لإثبات mechanics القراءة والمapping والـsnapshot consistency والأداء قبل اختيار أول ERP سوقي فعلي.

مستودع البناء:

`elias-mujally/dbl-legacy-intelligence`

## Milestones المنجزة — 2026-08-24

### 1. Foundation Hardening Round 2

- PR: `#5 — Foundation Hardening Round 2`
- Merge commit: `ab3db09c5afebaea1db741087af146c9771b32cc`

أهم ما ثبت: strict canonical decimals، bounded imports، runtime connector validation، migration drift/checksum، staging recovery، SQLite single-writer desktop semantics، وCI locked على Ubuntu/Windows.

### 2. Persistent Audit + Deterministic Insight Foundation

- PR: `#6 — Persistent Audit + Deterministic Insight Foundation`
- Merge commit: `1db738aae59c8b61e95cac99975d9864ab306947`

أصبح موجودًا Persistent Audit، Streaming SnapshotReader، Deterministic Insight Engine، exact decimal arithmetic، وعدم خلط العملات.

### 3. Local Query Foundation

- PR: `#7 — V1 local query foundation: typed plans, safe filters, snapshot-bound cursors`
- Merge commit: `54301b5ea3e0756b9935e6a3df31f954118c1c10`

أصبح موجودًا Typed QueryPlan، closed-world validation، no free-form SQL، currency-safe filters، streaming execution، وsnapshot-bound keyset pagination.

### 4. V1 Application Service Boundary

- PR: `#8 — V1 application service boundary above query and insights`
- Merge commit: `4d2e8fa59914c371c21b2176663dda38e39fd67f`
- Final verified CI: Run `#173` على Ubuntu وWindows.

`@dbl/application-service` أصبح الحد الرسمي read-only للطبقات العليا، مع pinned read scopes، runtime connector isolation، وexplicit connector/snapshot provenance.

المسار الرسمي:

`UI / Reports / future AI Planner -> Application Service -> pinned Read Scope -> Query/Insight Engines -> SnapshotReader -> LocalStore`

### 5. V1 Real Connector Foundation + SQL Reference Adapter

تم بناء PR #9، إجراء مراجعة نقدية، إرجاعه إلى hardening، إغلاق الملاحظات الحرجة، إعادة CI على المنصتين، ثم دمجه إلى `main` باستخدام Squash Merge.

- PR: `#9 — V1 real connector foundation and SQL reference adapter`
- Merge commit: `5028dc48db331574168c2658afee2c8206913a52`
- Final verified CI before merge: Run `#192`
- Verified PR head: `0d26680b207297491f4ea52eb7661c6ecbbb31b6`

#### ما أضافه هذا الـmilestone

- `@dbl/connector-test-kit` كـvalidation/acceptance harness للـreal connectors.
- نتيجة صريحة: `accepted` / `smoke-passed` / `rejected`.
- `ok=true` محجوز للقبول exhaustive فقط؛ capped smoke validation لا يمكن أن تتنكر كقبول كامل.
- Observed capability evidence، مع representative-fixture certification اختياري عبر `requireObservedDeclaredCapabilities=true`.
- فحوص API compatibility، read-only declaration، batched mode، SQL kind، health، canonical batches، sequence continuity، provenance، capability contradictions، وlifecycle close behavior.
- `@dbl/connector-reference-sqlite` كـreference connector حقيقي ضد legacy schema غير canonical (`items / clients / invoices / invoice_lines`).
- فتح SQLite بـ`readonly: true` و`fileMustExist: true` مع `query_only` defense in depth.
- `testConnection()` lifecycle-neutral: اتصال read-only مؤقت يُغلق دائمًا بدل الاحتفاظ بـsource DB handle.
- Keyset paging بدل OFFSET.
- Canonical decimal/timestamp normalization وأخطاء mapping صريحة.
- Read snapshot مثبتة طوال stream في SQLite، مع concurrent WAL write coverage.
- Early stream cancellation cleanup + restart coverage.
- إزالة N+1 من invoice lines: تحميل خطوط صفحة الفواتير batch-wise مع bounded parameter chunking.
- End-to-end proof:

`Legacy SQL -> Connector -> ImportOrchestrator -> DBL SQLite -> Application Service -> Query + Deterministic Insights`

#### Critical review findings التي أغلقت قبل الدمج

1. Partial smoke validation لم تعد تعيد acceptance.
2. Health probes لم تعد تحتفظ بملف قاعدة المصدر مفتوحًا.
3. SQLite snapshot isolation موثقة ومختبرة كـdatabase-specific behavior وليست portable SQL guarantee.
4. N+1 query shape لخطوط الفواتير أزيلت.
5. Capability declarations أصبح لها observed evidence وstrict representative certification mode.

#### التحقق النهائي

CI Run #192 نجحت على نفس PR head على Ubuntu وWindows:

- locked dependency install ✅
- Ubuntu critical vulnerability audit ✅
- runtime build ✅
- strict TypeScript typecheck ✅
- all tests ✅
- Windows-sensitive health-handle release test ✅
- 405-invoice multi-chunk line-loading test ✅
- concurrent source snapshot isolation test ✅
- early stream cancellation cleanup test ✅
- strict representative connector acceptance test ✅

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
13. Runtime connector isolation at application boundary.
14. Explicit query/insight provenance at application layer.
15. Real Connector Acceptance/Certification Test Kit.
16. Read-only batched Reference SQLite Legacy Connector.
17. Proven SQL-to-canonical mapping path for Products / Inventory / Customers / Sales fixture data.
18. Proven end-to-end real SQL reference path into Application Service / Query / Insights.
19. Cross-platform CI على Ubuntu وWindows.

## الهدف التنفيذي الحالي لـV1

الخطوة التالية ليست بناء abstraction عامة جديدة. الخطوة التالية هي اختيار **أول legacy ERP/accounting system حقيقي في السوق** والحصول على schema sample أو sanitized local database، ثم بناء system-specific connector اعتمادًا على evidence الفعلي.

بوابة القبول لأول market connector:

- source schema/version معروفان ومثبتان؛
- read-only credentials/session/mode enforced بواسطة قاعدة المصدر حيث يمكن؛
- field-level mapping موثق بالدليل؛
- Products / Inventory / Customers / Sales المطلوبة مثبتة على بيانات ممثلة؛
- database-specific snapshot/isolation behavior موثق ومختبر؛
- representative-dataset performance test، وعدم نسخ accidental N+1 shapes؛
- exhaustive acceptance عبر connector test kit؛
- end-to-end import إلى DBL SQLite ثم Query/Insights/Application Service؛
- Windows close/restart behavior مثبت؛
- لا source mutations مطلوبة لتشغيل V1 الطبيعي.

بعد ذلك يستمر الوصول إلى Demo-ready عبر Basic Reporting، Arabic query/search experience، Windows UI shell، packaging/installability، وdemo على النظام الحقيقي.

## Invariants لا يجب كسرها

- no free-form SQL.
- read-only first.
- database-enforced read-only حيث يدعم المصدر ذلك.
- closed-world runtime validation.
- currency-safe financial semantics.
- streaming/bounded-memory behavior.
- snapshot-bound pagination.
- pinned read-scope consistency.
- explicit connector/snapshot provenance.
- strict package/runtime boundaries.
- upper layers do not bypass Application Service for normal reads.
- smoke validation is not connector acceptance.
- SQL isolation assumptions are database-specific and must be proven per connector.
- implement first, abstract second.

## تحسينات مؤجلة غير مانعة حاليًا

- Generic mapping DSL / universal SQL dialect layer.
- Automatic schema inspector.
- AI semantic mapping.
- Predicate/seek pushdown لتحسين deep pagination والبحث الواسع.
- Signed/opaque cursors عند عبور حدود API غير موثوقة.
- Persisted/cross-process read-scope tokens عند ظهور use case فعلي.
- LAN/multi-process storage semantics تحتاج تصميمًا جديدًا؛ SQLite الحالية ليست multi-process foundation.
- Write actions / controlled Agent execution ليست ضمن V1 read-only الحالية.

## الفصل بين المستودعات

مستودع البناء:

`elias-mujally/dbl-legacy-intelligence`

ذاكرة المنتج والقرارات الاستراتيجية:

`elias-mujally/dbl-products-memory/products/legacy-intelligence/`

يجب إبقاء ذاكرة المنتج منفصلة عن كود التنفيذ، وتسجيل milestones والقرارات المهمة هنا بعد التحقق من مستودع البناء.

## Milestone التالي

**First actual market legacy ERP/accounting connector.**

لا نبني generic connector architecture قبل هذه الخطوة. نأخذ النظام الحقيقي، نوثق schema وisolation وmapping، ننفذ adapter خاصًا به، ثم نمرره عبر gate الذي أثبته PR #9.