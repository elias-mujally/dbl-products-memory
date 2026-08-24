# AI Handoff — Legacy Intelligence

## الهدف

هذا الملف يتيح لأي مساعد AI أو مطور فهم مبادرة Legacy Intelligence بسرعة دون قراءة بقية منتجات DBL.

## اقرأ أولًا

1. `README.md`
2. `CURRENT_STATUS.md`
3. `VISION.md`
4. `ROADMAP.md`
5. `MARKET_STUDY_2026-08-21.md`
6. `MULTI_INDUSTRY_VISION_2026-08-21.md`
7. `DECISIONS.md`

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
- Connector knowledge وCanonical Business Model وSchema Intelligence أصول دفاعية مستقبلية.
- الرؤية متعددة القطاعات، لكن MVP رأسي وضيق.

## الحالة الهندسية الحالية — 2026-08-24

مستودع البناء:

`elias-mujally/dbl-legacy-intelligence`

### Milestone 1 — Foundation Hardening Round 2

- PR #5 merged.
- Merge commit: `ab3db09c5afebaea1db741087af146c9771b32cc`

### Milestone 2 — Persistent Audit + Deterministic Insights

- PR #6 merged.
- Merge commit: `1db738aae59c8b61e95cac99975d9864ab306947`

### Milestone 3 — Local Query Foundation

- PR #7 merged using Squash Merge.
- Merge commit: `54301b5ea3e0756b9935e6a3df31f954118c1c10`

### Milestone 4 — V1 Application Service Boundary

- PR #8 merged using Squash Merge.
- Merge commit: `4d2e8fa59914c371c21b2176663dda38e39fd67f`
- Final verified CI: Run #173 on Ubuntu + Windows.

Application Service هو الحد الرسمي للقراءة، مع pinned read scopes وruntime connector isolation وexplicit provenance.

### Milestone 5 — Real Connector Foundation + SQL Reference Adapter

- PR #9 merged using Squash Merge.
- Merge commit: `5028dc48db331574168c2658afee2c8206913a52`
- Final verified CI: Run #192 passed on Ubuntu + Windows.
- Verified PR head: `0d26680b207297491f4ea52eb7661c6ecbbb31b6`.

هذا milestone نقل المشروع من mock-only connector foundation إلى mechanics حقيقية قابلة لاختبار أول تكامل legacy.

أهم ما تم تثبيته:

- `@dbl/connector-test-kit` للـreal connector validation/acceptance.
- acceptance semantics صريحة: `accepted` / `smoke-passed` / `rejected`.
- capped smoke run لا يمكن أن يعيد `ok=true` أو يتنكر كـfull acceptance.
- observed capability evidence + optional strict representative-fixture certification.
- Reference SQLite legacy connector read-only + batched.
- SQLite source connection تستخدم `readonly: true`, `fileMustExist: true`, و`query_only` defense in depth.
- health probe lifecycle-neutral ولا يحتفظ بملف المصدر مفتوحًا.
- keyset paging بدل OFFSET.
- canonical mapping من `items / clients / invoices / invoice_lines` إلى Product / Customer / Sale.
- pinned SQLite read snapshot مع concurrent WAL write coverage.
- early cancellation cleanup + restart coverage.
- invoice lines batch-loaded per invoice page مع bounded chunking بدل N+1 query per invoice.
- end-to-end path مثبت:

`Legacy SQL -> Connector -> Import Orchestrator -> DBL SQLite -> Application Service -> Query + Deterministic Insights`

Critical review findings التي أغلقت قبل الدمج:

1. Smoke validation منفصلة عن acceptance.
2. Health probe source handles لا تتسرب.
3. Snapshot isolation تعامل كـdatabase-specific property، لا universal SQL assumption.
4. N+1 invoice-line loading أزيلت.
5. Capability claims أصبحت قابلة للإثبات من observed representative data.

## المسار المعماري الحالي

`Legacy ERP -> System-specific Connector -> Import Orchestrator -> SQLite -> SnapshotReader -> Query/Insight Engines -> Application Service -> UI/Reports/future AI`

ومن الأعلى للأسفل:

`UI / Reports / future AI Planner -> Application Service -> pinned Read Scope -> Query/Insight Engines -> SnapshotReader -> LocalStore`

## ما أصبح موجودًا فعليًا في `main`

1. Core contracts + Canonical Model.
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
14. Real Connector Acceptance/Certification Test Kit.
15. Read-only batched Reference SQLite Legacy Connector.
16. Proven SQL reference mapping path for Products / Inventory / Customers / Sales fixture data.
17. Cross-platform CI on Ubuntu + Windows.

## قاعدة مهمة لأي AI أو مطور يكمل العمل

لا تعِد فتح invariants المحسومة أو تضعفها لتسهيل Feature جديدة إلا بدليل تقني واضح.

خصوصًا:

- no free-form SQL.
- read-only-first.
- database-enforced read-only where supported.
- closed-world validation.
- currency-safe semantics.
- bounded-memory/streaming behavior.
- snapshot-bound pagination.
- pinned read-scope consistency.
- explicit connector/snapshot provenance.
- normal upper-layer reads go through Application Service.
- smoke validation is not acceptance.
- isolation semantics must be documented/tested per source DB.
- avoid accidental N+1 query shapes.
- implement first, abstract second.

## الخطوة التنفيذية التالية

**اختيار أول legacy ERP/accounting system حقيقي في السوق.**

المطلوب قبل كتابة generic abstractions:

1. الحصول على schema sample أو sanitized local database من النظام المختار.
2. تحديد exact source schema/version.
3. توثيق field-level mapping إلى Products / Inventory / Customers / Sales من evidence حقيقي.
4. تحديد read-only enforcement الحقيقي في source DB.
5. توثيق واختبار database-specific snapshot/isolation semantics.
6. تنفيذ system-specific connector.
7. تشغيل exhaustive acceptance/certification على representative source.
8. تشغيل end-to-end Import -> SQLite -> Application Service -> Query/Insights.
9. اختبار representative performance وWindows close/restart behavior.

**لا تبدأ V2 mapping abstraction أو Generic SQL Schema Inspector قبل أن يعطي أول connector سوقي evidence لما يتكرر فعلاً.**

## حدود مؤجلة عمدًا وليست Bugs حالية

- Generic mapping DSL / universal SQL layer.
- Automatic schema inspector.
- AI semantic mapping.
- Predicate/seek pushdown optimization.
- Signed/opaque cursors خارج trusted boundary.
- LAN/multi-process semantics.
- Persisted/cross-process read scopes.
- Write actions / controlled Agent execution.

## الفصل بين البناء والذاكرة

مستودع البناء: `elias-mujally/dbl-legacy-intelligence`.

ذاكرة المنتج: `elias-mujally/dbl-products-memory/products/legacy-intelligence/`.

تحقق دائمًا من مستودع البناء قبل اعتبار Product Memory دليلًا على implementation state، ثم حدّث الذاكرة بعد milestones المهمة.

**آخر نقطة تنفيذية موثقة:**

PR #9 `V1 real connector foundation and SQL reference adapter` تم دمجها بنجاح في `main` بتاريخ 2026-08-24 عند commit:

`5028dc48db331574168c2658afee2c8206913a52`

ابدأ أي عمل V1 لاحق من هذا `main`. الخطوة التالية هي أول system-specific market connector، وليس abstraction عامة جديدة.