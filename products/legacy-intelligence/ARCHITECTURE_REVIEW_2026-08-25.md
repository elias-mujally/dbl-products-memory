# Legacy Intelligence — Independent Architecture Review — 2026-08-25

## Purpose

هذه الوثيقة تسجل خلاصة المراجعة المعمارية المستقلة التي أُجريت بعد PR #9 وقبل أول market connector فعلي.

المراجعة كانت Review Only في البداية، ثم تحولت إلى Targeted Remediation Plan. لم تُستخدم لإعادة تصميم المنتج من الصفر.

## Verified baseline at review time

Build repository:

`elias-mujally/dbl-legacy-intelligence`

Baseline reviewed:

- PR #5 Foundation Hardening Round 2.
- PR #6 Persistent Audit + Deterministic Insight Foundation.
- PR #7 Local Query Foundation.
- PR #8 V1 Application Service Boundary.
- PR #9 Real Connector Foundation + SQL Reference Adapter.
- Main baseline before remediation: `5028dc48db331574168c2658afee2c8206913a52`.
- PR #9 CI #192 green on Ubuntu + Windows.

## Executive verdict

**Needs targeted fixes.**

لا توجد حاجة إلى re-architecture شاملة.

الأساس أصغر وأكثر تماسكًا مما قد توحي به كثرة أسماء الطبقات. القرارات الأساسية حول local-first، read-only، SQLite، no-free-form-SQL، pinned scopes، exact decimals، currency safety، DB-specific isolation، وsource-specific connectors بقيت سليمة.

## Main architectural lesson

أقوى finding:

> النظام يثبت structural/contract correctness بدرجة جيدة، لكنه لا يثبت وحده business/accounting semantic correctness.

Connector يمكن أن ينتج canonical data صحيحة شكليًا بينما تفسر source semantics بشكل خاطئ، مثل:

- canceled invoices؛
- returns؛
- sign convention؛
- warehouse aggregation؛
- balance semantics؛
- document status/type؛
- timezone؛
- multi-currency meaning.

لذلك لا يجوز اعتبار نجاح contract test kit وحده production readiness.

## Accepted readiness model

لأول market connector، نستخدم ثلاث طبقات مفاهيمية:

### 1. Contract Conformance

يتحقق من contract mechanics والـcanonical shape والبروتوكول والسلوك الذي يستطيع generic connector test kit ملاحظته.

### 2. Semantic Reconciliation

System/version/dataset-specific evidence يثبت أن mapping يمثل الواقع التجاري الصحيح.

يشمل عند الحاجة:

- source table/column؛
- joins؛
- filters؛
- status/type meaning؛
- returns/cancellations؛
- sign conventions؛
- currency semantics؛
- timezone؛
- null/default behavior؛
- excluded/rejected rows؛
- source counts/totals؛
- golden records traceability.

### 3. Operational Qualification

يثبت readiness التشغيلية:

- DB-enforced read-only؛
- source isolation/snapshot behavior؛
- concurrent writes؛
- cancellation/cleanup؛
- restart/Windows lifecycle؛
- performance/memory behavior؛
- resource budgets؛
- no source mutation.

### Important constraint

هذه الثلاثة **ليست** دعوة لبناء ثلاث packages أو readiness framework عام الآن.

Generic abstraction تنتظر repeated evidence.

## What was genuinely strong

- Read-only first.
- Database-enforced read-only treated separately from metadata declarations.
- Exact decimal strings.
- Money bound to explicit currency.
- No implicit FX.
- Atomic staged imports.
- Persistent audit and restart behavior.
- SnapshotReader separation.
- Typed closed-world QueryPlan.
- No free-form SQL.
- Pinned Application Read Scopes.
- Explicit provenance.
- SQLite isolation documented as SQLite-specific, not portable SQL behavior.
- Windows + Ubuntu CI.
- Reference connector tests for concurrent writes, cancellation, handle release, and N+1 prevention.
- Implement first, abstract second.

## Main finding that required immediate remediation

### Canonical silent field loss

Before PR #10, canonical validators checked known values but did not enforce exact object keys.

A connector could emit, for example, an unsupported `warehouseId`. The object could pass validation; SQLite persistence would write only known columns; the unsupported field would disappear silently.

This violated the declared closed-world invariant and could make real connector evidence misleading.

### Classification

- Severity: High.
- Type: Actual defect.
- Timing: Fix before/alongside Evidence Acquisition.
- Motakamel dependency: None.
- Correct response: minimal exact-key validation only.

## PR #10 remediation

PR:

`#10 — Close canonical validation against silent field loss`

PR head:

`0fb18e982e90ae09b5e68f306c406ee97a7f29ff`

CI:

Run #194 green on Ubuntu + Windows.

Squash merge commit:

`95bf225e1523e0fd0f72cdf3da8393df18d635cc`

### What it changed

- Exact-key validation for Snapshot, SnapshotHeader, SourceRef, Batch, Product, Customer, Sale, SaleLine, Money.
- Unknown enumerable own keys fail with `UNKNOWN_CANONICAL_FIELD`.
- Buffered invalid data cannot commit.
- Batched invalid data aborts staging/cleanup and does not become visible.
- Unknown fields no longer reach fingerprint/persistence.

### What it deliberately did not change

- No ERP-specific fields.
- No Canonical Model expansion.
- No Mapping DSL.
- No schema inspector.
- No connector architecture redesign.
- No Query/Application/Storage redesign.
- No fingerprint/migration changes.

## Findings that must wait for first real source evidence

Do not solve these generically in advance:

- warehouse/branch semantics؛
- document status/type؛
- returns/cancellations؛
- tax/discount/UOM؛
- balance/sign conventions؛
- multi-currency document semantics؛
- source timezone؛
- source paging/query strategy؛
- child-row bounds؛
- snapshot identity/watermarks؛
- full vs incremental refresh؛
- query optimization/pushdown؛
- Arabic normalization؛
- business aggregations.

## Before-first-pilot concerns

These are real but do not block Evidence Acquisition:

- semantic reconciliation complete;
- connector readiness terminology clarified;
- cancellation/deadline behavior؛
- UI non-blocking verification؛
- retention/disk safety or manual bounded imports؛
- storage schema-too-new guard؛
- local backup/restore procedure؛
- secure credentials/config handling؛
- packaging/clean-machine verification؛
- representative performance/memory qualification؛
- Windows lifecycle/restart behavior؛
- release/branch protection appropriate for pilot.

## Explicitly deferred

- Generic Mapping DSL.
- Automatic Schema Inspector.
- Universal SQL dialect layer.
- AI semantic mapping.
- Generic query pushdown framework.
- Generic incremental framework.
- LAN/multi-process semantics.
- Plugin marketplace/loader.
- Package consolidation.
- Audit database redesign.
- Second storage implementation.

## Final recommendation accepted

**Proceed with Motakamel Plus Evidence Acquisition immediately.**

Do not delay source discovery for unrelated cleanup.

After evidence arrives:

1. Produce mapping/reconciliation artifacts first.
2. Change Canonical Model only where evidence proves a semantic gap.
3. Build the Motakamel system/version-specific connector.
4. Validate Contract Conformance.
5. Validate Semantic Reconciliation.
6. Validate Operational Qualification.
7. Only then treat the connector as pilot-ready.
