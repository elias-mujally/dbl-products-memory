# Legacy Intelligence — First Connector Target — 2026-08-25

## Decision

**Primary First Connector Target: YemenSoft Motakamel Plus ERP.**

هذا القرار تنفيذي لكنه conditional: لا يبدأ connector production mapping قبل الحصول على evidence كافية عن product/version/schema حقيقي محدد.

## Why Motakamel Plus

### Commercial attractiveness

- YemenSoft ذات حضور قوي في اليمن والسوق العربي.
- Motakamel Plus مناسب لقطاع الشركات التجارية/التوزيع/الخدمات الذي يطابق wedge الحالي.
- scope الوظيفي يطابق Canonical V1 بدرجة جيدة: Products / Inventory / Customers / Sales.
- احتمالية الوصول إلى Pilot محلي أعلى من بدائل إقليمية كثيرة.
- local/on-prem heritage مناسب لقيمة Legacy Intelligence أكثر من SaaS cloud-first targets.

### Technical connectability

- YemenSoft توثق استخدام Microsoft SQL Server لعائلة Motakamel Plus.
- هذا ينسجم مع read-only SQL connector path الذي أثبته PR #9.
- مع ذلك، exact SQL Server version/schema/access model غير مثبت بعد للتركيب الذي سنستهدفه.
- لا يوجد لدينا public official database schema موثقة.
- لا نفترض table names أو joins أو semantics.

## Alternatives retained

- **YemenSoft Onyx ERP**: strategic second target، جاذبية تجارية كبيرة لكن technical complexity أعلى مبدئيًا.
- **Al-Ameen ERP**: fallback قوي إذا تعذر الحصول على Motakamel evidence؛ SQL Server/documentation/accessibility تبدو جذابة.
- **SMACC**: large regional target لاحقًا، لكن local database/access path يحتاج evidence أفضل.

هذه ليست قائمة نهائية لكل السوق؛ هي ترتيب عملي لأول wedge.

## Important implementation rule

لا نبني:

- `YemenSoftConnector` عام؛
- Universal SQL Connector؛
- Generic Schema Inspector؛
- Mapping DSL قبل evidence.

أول adapter يجب أن يكون أقرب إلى:

`Motakamel Plus + Exact Product Version + Exact Schema/Deployment`

ثم نرى ما يتكرر قبل abstraction.

## Current Evidence Acquisition status

### Official download problem

تم العثور على Gold Plus Educational/Beta package في موقع YemenSoft، لكن download mechanism العام لم يعمل فعليًا.

تمت مراسلة YemenSoft رسميًا عبر البريد لطلب:

- direct download link للـGold Plus Educational/Beta؛ أو
- أحدث Motakamel Plus Educational Edition المتاحة.

### Silver package

محاولة تنزيل Silver Educational Edition واجهت المشكلة نفسها، لذلك لم نعتمدها artifact فعليًا.

### AlMuhaseb1 artifact

تم الحصول على YemenSoft `AlMuhaseb1` installer artifact وفحصه استكشافيًا.

ظهر فيه:

- YemenSoft MSI package؛
- `mohaseb1.exe`؛
- `muhaseb.mdb`؛
- Crystal Reports and legacy data components.

هذا يثبت legacy Access/ODBC heritage لبعض منتجات YemenSoft القديمة فقط.

**لا يجوز استخدام `muhaseb.mdb` أو AlMuhaseb1 schema كبديل أو proxy مباشر لـMotakamel Plus.**

## Evidence package required before connector coding

### 1. System and Version Profile

- exact commercial product name؛
- version/build؛
- enabled modules/options؛
- database/schema version؛
- install topology؛
- branch/warehouse/accounting/fiscal configuration؛
- base/secondary currencies؛
- local timezone settings؛
- customization indicators.

### 2. Read-only Access & Isolation Record

- SQL Server version/edition؛
- instance/database names؛
- authentication mode؛
- compatibility level؛
- collation؛
- feasible least-privilege read-only user/grants؛
- snapshot/MVCC/isolation settings؛
- behavior under concurrent writes؛
- cancellation/failure lock behavior؛
- no source mutation requirement.

### 3. Source Schema Inventory

- tables/columns/data types/nullability؛
- PK/FK/unique/indexes؛
- views/computed columns؛
- status/code dictionaries؛
- relationships relevant to Products / Inventory / Customers / Sales؛
- branch/warehouse/currency/UOM structures if present؛
- version/customization markers.

### 4. Mapping Evidence Table

For every emitted canonical field:

- canonical entity/field؛
- source database/schema/table/column؛
- join path؛
- selection filters؛
- transformation؛
- null/default rule؛
- status/type rule؛
- returns/cancellations treatment؛
- sign convention؛
- currency rule؛
- timezone rule؛
- excluded/rejected rows؛
- known unsupported semantics؛
- evidence reference؛
- confirmed/unresolved state.

### 5. Reconciliation Baseline

On a fixed representative dataset:

- source row count vs emitted count؛
- excluded/rejected counts + reasons؛
- totals by currency + period؛
- totals by document status/type؛
- returns/cancellations counts؛
- product/customer counts؛
- orphan/null/duplicate diagnostics؛
- golden records traceable from Motakamel UI/report to DBL canonical output.

All reconciliation differences must be zero or explicitly explained and accepted.

### 6. Unsupported / Unresolved Semantics List

No critical unresolved semantic issue may remain when the connector is declared pilot-ready.

### 7. Dataset Size & Performance Profile

- DB size؛
- largest tables؛
- history range؛
- row counts؛
- invoice-line distribution؛
- relevant indexes؛
- representative query duration؛
- target Windows hardware؛
- memory/runtime observations.

### 8. Exact V1 Connector Scope Decision

State precisely what this first version supports and explicitly what it does not support.

## Canonical Model rule

Do not pre-add warehouse/status/returns/tax/UOM/branch fields based on generic ERP expectations.

If Motakamel evidence proves that losing a semantic dimension makes V1 incorrect, add the smallest necessary Canonical Model delta with tests and migration impact reviewed separately.

## Connector readiness gate

A Motakamel connector is not pilot-ready because test kit returns `accepted` alone.

Readiness requires:

1. **Contract Conformance**.
2. **Semantic Reconciliation**.
3. **Operational Qualification**.

Operational qualification includes:

- source-enforced read-only؛
- SQL Server isolation under concurrent writes؛
- cancellation/cleanup/restart؛
- Windows handles/lifecycle؛
- representative performance/memory؛
- no accidental N+1/unbounded child loading؛
- end-to-end Import -> LocalStore -> Application Service -> Query/Insights؛
- no source mutation.

## What must wait

Do not use this first connector as an excuse to build:

- Generic Mapping DSL؛
- Universal SQL Layer؛
- Automatic Schema Inspector؛
- AI Semantic Mapping؛
- Generic Incremental Framework؛
- Generic Query Pushdown Framework.

These remain post-evidence abstractions.

## Next action

Obtain an official Motakamel Plus installer/demo/schema/sample/sanitized DB or read-only installation access.

Then build the evidence artifacts above **before** writing production connector mapping code.
