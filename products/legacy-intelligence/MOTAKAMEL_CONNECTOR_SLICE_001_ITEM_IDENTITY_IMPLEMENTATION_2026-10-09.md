# Motakamel Connector Slice #001 — Item Identity implementation — 2026-10-09

**Status: IMPLEMENTED / FIXTURE-TESTED END-TO-END; LIVE NODE SQL INTEGRATION NOT TESTED.**

Review [build PR #11](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/11), **OPEN, non-draft, not merged**.
Head **67876966c0683eb954e8eedba908701fa4656ebf** on `codex/motakamel-item-identity`;
build `origin/main` remains **95bf225e1523e0fd0f72cdf3da8393df18d635cc**.
PR is ready for bounded review, **not cleared for merge/deployment**: CI Linux critical-dependency
audit FAILED before build/typecheck/tests; **Windows CI build/typecheck/tests PASSED** on the same head.
No merge, broad audit fix, deployment or scope expansion is authorized by this record.

## Authority and context

User accepted `e7ec147`: frozen snapshot / independent reader / S2 reconciliation PASSED — LAB-PROVEN,
and separately authorized coding **Item A identity only**. Product Memory/core documents were refreshed,
then actual build repository API/model/validation/import/storage/application/test code inspected.
Older pre-acquisition “no coding / EVIDENCE GAP” statements are historical for this capability only.
The [frozen qualification](MOTAKAMEL_HOST_W11_POST_S2_FROZEN_READER_QUALIFICATION_2026-10-09.md)
is preserved unchanged, including its credential, numeric, transport and evidence limits.

Pilot #001 remains **Purchase Attention + Item Intelligence**; exact Motakamel Plus educational profile
remains the Primary First Connector Target. No generic YemenSoft/universal SQL/mapping DSL,
Canonical expansion, purchase-as-Sale or new product architecture. S3 remains ACCOUNTING-BLOCKED;
Controlled Zero remains PARTIAL. This increment is not a useful purchase/inventory demo (Gate B),
broader Gate C, representative performance, PARTNER-VALIDATED or PILOT-QUALIFIED result.

## Implemented mapping and source boundary

New build workspace **`@dbl/connector-motakamel-plus`**, Node22, existing **BatchedLegacyConnector**:

| Selected source field | Proven contract mapping |
| --- | --- |
| `dbo.item_detail.i_code`, sole PK, `nvarchar(20)` | `Product.id = DBL_P001_ITEM_A` |
| `dbo.item_detail.i_a_name`, nullable `nvarchar(255)` | `Product.name = DBL_ITEM_A` in qualified fixture |

Only id/name are emitted. SKU, stock, unit/location/package, cost, price, source update timestamp,
purchase/supplier/movement facts are absent, never fabricated as zero or coerced into Sales.
Existing canonical contract represents identity without any change. Products capability true;
inventory/customers/sales false. No low-stock/Purchase Attention claim from absent quantity.

Default transport pins server **DESKTOP-8QRQT7R\YSEDU**, engine12.0.6024.0,
frozen **DBL_HOST_W11_EFA12026_PostS2_Frozen_20261009 /ID10**, reader
**DBL_HOST_W11_S2_Reader_20261009**. Fixed SELECT guard checks profile/READ_ONLY/original-effective
login/user/selected permissions/mapped column lengths-types/single-column PK before acquisition,
and profile again afterward. Unknown/NULL/mismatching guard values stop. This is not an exhaustive
new security audit of every permission/role/database or proof against privileged snapshot replacement.

Only business query is explicit **TOP(2) i_code/i_a_name**, parameterized `@itemCode` as nvarchar20;
one required identity, no silent missing record or deduplication. Two source rows maximum,
mapped string sizes constrained by checked schema and runtime types/lengths; one canonical Product
batch. No arbitrary SQL/database/reader config, live EFA access, quantity function, other table reads,
NOLOCK, SQL writes or claim that READ COMMITTED supplies snapshot consistency.
Other original ERP columns are not acquired; unknown **projection** / Canonical fields reject,
without pretending an unmapped ERP table column is an unknown Canonical field.

Every health/acquisition session closes before handing the generator to Import; failed connect/read,
malformed mapping, close errors, abandoned iteration and pre-iteration staging failure are tested.
Pool1 and connection/request10s; busy operations reject and close waits for pending cleanup.
Fixed sanitized errors do not attach/print raw driver/provider exceptions or credentials.
No core P1/framework rewrite was needed for this exercised lifecycle/bounds path.

## Provenance / duplicate handling

Sanitized pinned profile references backup UUID **2b9d2bde-8d89-4ee7-98de-224fb97060c7**,
backup SHA **E63DF84D2DBB22C5ACD535DC5881D2DCF417F420665502927EBD9AD66731E572**,
qualification artifact SHA **7D742175B6652860C7974115F8A1CBB789F49D86ACAD4FC5DD40CFCE310E7BAC**,
source backup interval **2026-10-09 08:12:11 +03**, mapping0.1.0 and exact item/profile.
This is preserved qualification evidence, not live backup-file/msdb authentication by the connector.
Profile/manifest plus mapped Product are hashed into snapshot ID; SourceRef contains connector,
frozen DB and profile identity. Existing `capturedAt` is acquisition-completion UTC, not backup/event time.
No new Canonical provenance field or fabricated business timestamp was added.

Same connector instance pins first acquisition and replay copies: repeated Import idempotently
retains one checkpoint/Product. New instance acquiring the same content at a later time has same
snapshot ID but different capture time; existing SQLite fingerprint correctly rejects
**DATA_INTEGRITY_CONFLICT**, leaving the prior snapshot unchanged. Persisted cross-process replay/
refresh policy is explicitly not implemented; no time relabeling or duplicate-connector workaround.

## Actual tests and limits

**Local `npm run verify` PASSED on Node22.23.2:** complete runtime build, all workspace typechecks,
**154 tests passed / 1 live test skipped**. New package **57 passed**: connector/mapping50,
actual pipeline4, default adapter mocked transport3; live test1 skipped.

Fixture derives only the two identity values from `IndependentReader.ReaderProjectionFirst.Item`
in preserved `QUALIFICATION_EVIDENCE.json`; checksum re-read remained exactly the pinned SHA.
Guard fixtures are synthetic expected-profile responses, not a fresh SQL observer.
Counterfactual malformed/null/empty/type/unknown/duplicate/oversize/Unicode cases are test inputs,
not new ERP observations. One initial SQL allowlist assertion mistakenly matched a permission-name
string literal; fixed assertion and complete successful rerun are implementation-test correction,
not an ERP Save retry.

Real **Connector → ImportOrchestrator → SQLite → repeatable SnapshotReader → Application Service**
fixture path returns exactly `{id:"DBL_P001_ITEM_A",name:"DBL_ITEM_A"}` with matching connector/snapshot
provenance; no customers/sales/stock fact or low-stock signal. Retry idempotence, changed-acquisition
conflict, invalid acquisition/no partial commit, audit redaction and staging-failure cleanup are tested.
Default SQL adapter uses mocked mssql transport tests for exact SELECT/parameter/config/cleanup.

**LIVE NODE SQL INTEGRATION NOT TESTED.** Prior reader secret was not retained/delivered; approved
secret environment was absent. No admin fallback, secret search/reset/provisioning or live SQL
connection was attempted. External password callback and explicit opt-in live test are implemented;
no secret or secret-bearing connection string in code/Git/evidence. Future secure handoff is a
separately authorized operator prerequisite, not connector responsibility.

Transport requires TLS with certificate validation (encrypttrue/trustServerCertificatefalse),
named-instance TCP/SQL Browser reachability. These Node/TDS prerequisites on this SQL2014 Host
remain unqualified; do not change server/Windows/services/UAC/ACL or bypass certificate validation
to make a test pass. No SQL permission/database/Windows/ERP change occurred during implementation.
No fresh whole-source preservation claim is made: no source/ERP action was performed at all.

## Dependency / CI gate

2026-10-09 npm audit reports7 affected packages: critical2, high1, moderate4.
Baseline origin/main already locks **vitest3.2.7 / tinypool1.1.1** (critical) and
**source-map-js1.2.1** (high); unchanged here. Added mssql/tedious chain reports moderate
sprintf-js advisory. No sweeping npm audit fix, test-framework major upgrade or old SQL-driver
downgrade was made. Linux CI job113697926035 in run37893007806 completed with **Audit critical
dependency vulnerabilities FAILED**, preceding build/typecheck/tests skipped. Windows job
113697926358 completed **PASSED** (locked install, build, typecheck, tests), with audit skipped
by the existing Linux-only policy. Initial pending observation is superseded; overall CI is
still not green. [Actual run](https://github.com/elias-mujally/dbl-legacy-intelligence/actions/runs/37893007806).

Review [scope/usage/limitations in build docs](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/67876966c0683eb954e8eedba908701fa4656ebf/docs/MOTAKAMEL_ITEM_IDENTITY_SLICE_001.md).
**Next decision: review PR#11, security/dependency gate and credential/transport/replay limits;
no Merge, inventory/purchase work, S3 or ERP action now.** Product Memory update only; `.vscode` excluded.
