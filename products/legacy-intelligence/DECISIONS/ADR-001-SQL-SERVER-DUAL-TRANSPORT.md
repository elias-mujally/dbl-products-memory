# ADR-001 — SQL Server عبر Shared Memory وTCP/IP

## Implementation status clarification — 2026-11-16

**DECIDED:** the dual-transport decision dated 15 November remains unchanged: preserve TCP and PowerShell, explicit transport/helper registration, one acquisition and processing pipeline, least privilege, strict trust checks and no security-failure fallback. This update records implementation progress; it grants no infrastructure or deployment authorization.

**VERIFIED — local code and saved offline evidence:** after the initial PowerShell slice described below, a separate .NET Framework 4.8 C# candidate was developed with explicit Node selection, EXE/config pins, CurrentUser DPAPI credential-file/path/owner/ACL checks and bounded source/authority/transaction logic. See the [parity record](../engineering/native-helper-parity/README.md). Its 94 C# fake-session, 269 connector and 178 Desktop passes belong to that later offline phase; they do not prove live SQL behavior. The initial 246/178 counts below remain the earlier phase's historical results, not the current combined test total. Product implementation remains local and uncommitted above main `2f24efa`; this documentation commit does not merge or deploy it.

**SUPERSEDED as current implementation status only:** the wording below about a future executable and its initial remaining implementation describes the original slice. The C# candidate now exists; ordinary execution-policy restrictions on the PowerShell path were not bypassed or removed. Integrated Windows authentication remains an unimplemented architectural option.

**VERIFIED — saved laboratory evidence, not a fresh check:** V1's strict SqlClient LPC Open failed with `0x80090325` before queries. A replacement CA was accepted on 16 November at 13:49:49 UTC, with SQL stopped in the last system-state receipt. No SQL leaf, Root installation, SQL binding/start, successful subsequent TLS or ERP acquisition inside V1 is established. PKI's in-memory verification DLL is separate from the ERP acquisition EXE. See [current state](../CURRENT_STATUS.md) and the [PKI record](../engineering/self-contained-lab/PKI_PHASE1_20261116.md).

**UNVERIFIED:** actual guest ERP database/session identity, reader authentication/effective permissions, live helper SQL/TLS behavior, side-by-side deployment and production qualification. The original decision and evidence below are retained within their dated scope; the [roadmap](../ROADMAP.md) contains proposals, not new execution authority.


Status: **ACCEPTED — OWNER APPROVED ARCHITECTURE**. Date: **2026-11-15**.

Implementation status: limited local development; not merged, published, deployed or production-qualified. Architecture approval is not authorization to change a customer's SQL/Windows environment.

[Decision index](../DECISIONS.md) · [Product](../README.md) · [Historical local-source work](../engineering/self-contained-lab/README.md)

## Context / problem

DBL integrates with existing ERP installations. Some Windows installations allow only local Shared Memory; other deployments require an authorized network endpoint. Treating the TCP implementation or one laboratory's enabled protocol as the only product architecture would impose an unnecessary restriction. Historical file acquisition, saved snapshots and earlier blocked experiments remain evidence with their original scope.

## Owner decision

Support both as product capabilities:

- **Shared Memory:** DBL and SQL Server on the same Windows machine.
- **TCP/IP:** local or network deployment through an explicitly authorized endpoint.

Both use the existing acquisition boundary and processing contracts: qualified source → Canonical validation → ImportOrchestrator → SQLite and Audit → Application Service → Desktop Workspace. Preserve accepted snapshots, source identity and provenance; transport selection does not invent inventory/financial data or authorize writes. File imports remain a distinct supported acquisition route within their existing scope; unifying every UI is not claimed by this decision.

## Transport-specific trust and authorization

- Register one transport explicitly in the backend. No automatic fallback, retry with weaker trust, protocol discovery or alternate source after identity, TLS, authentication or authorization failure.
- Both require an authorized least-privilege SQL identity and effective permission inspection; local OS access or an existing login does not establish read access. Never acquire using sysadmin. A READ_WRITE ERP database can be read with restricted credentials; the frozen READ_ONLY profile remains unchanged.
- TCP retains the existing connector, hostname/CA verification and separation of transport address from SQL/TLS identity. No certificate-validation bypass.
- Shared Memory requires Windows/local-machine identity and actual SQL transport verification. The limited helper uses SQL credentials protected by Windows CurrentUser DPAPI and owner/SYSTEM ACLs. It requests encryption and certificate validation through SqlClient/Windows certificate-store trust; this is distinct from TCP's explicit CA bundle. Source registration records the required external TLS qualification reference; it does not prove qualification occurred. TLS negotiation/provider behavior still requires live qualification.
- Windows integrated authentication is an architectural option requiring its own constrained identity/client qualification; it is not implemented by the initial helper. Do not inherit a privileged desktop user's SQL identity.
- Ordinary approved helper execution only. Do not bypass PowerShell execution policy, silently change trust stores or move a rejected script into an alternate invocation. A future approved executable client is a separately reviewed packaging choice.

## Current implementation versus capability

The working Desktop branch `codex/direct-erp-workspace-20261114` preserves TCP and adds a narrow Shared Memory Catalog path for the existing SQL Server 2014 operational schema. It uses explicit source registration, generated/pinned helper, bounded identity-only SELECT, source/permission checks before and after, and the shared persistence/audit/Workspace pipeline. Local development and contract tests are distinct from actual helper/ERP acceptance.

The initial local path supports SQL authentication, named local instances, READ_WRITE source qualification, and Catalog code/name within the existing 1,000-row bound. It does not claim arbitrary SQL versions/schemas, local frozen-profile support, all authentication mechanisms, completed native Desktop acceptance, or a deployed dual-transport product. No new generic connector framework, Canonical schema migration, alternate persistence engine, or automatic trust setup is introduced.

Local validation on this date: repository build/typecheck passed; connector tests246 passed/29 optional skips; Desktop tests178 passed. These include fixture/helper-process contracts and real local SQLite/Audit/Application Service integration. PowerShell5.1 syntax parsing passed; ordinary helper invocation on the development host stopped at Restricted policy, with deliberately invalid non-credentials and no SQL access. None of these results proves the new helper's SQL/TLS behavior or VM acceptance. The execution-policy gate remains open.

## Alternatives considered / rejected

| Alternative | Decision |
|---|---|
| TCP-only | Rejected as a permanent product restriction; would require unnecessary ERP changes for some local customers. |
| Shared-Memory-only | Rejected; cannot connect directly across machines or serve all authorized network deployments. |
| Replace TCP with a native/ODBC or .NET client everywhere | Deferred pending concrete compatibility, packaging and support evidence; do not discard working TCP. |
| Separate product/database per transport or generalized connector framework | Rejected; reuse existing contracts and one processing pipeline. |
| Disable TLS/permission checks or automatic transport fallback | Rejected; success through weaker verification is not acceptance. |

## Consequences / separate approvals

Maintain transport-specific client/process tests alongside shared source, Canonical, persistence, audit, history and Workspace tests. Keep implementation/transport pins explicit; never silently rebind an existing source ID or migrate the old application's state to accommodate a different transport.

Actual ERP database identity, reader login/user/SID/permissions, certificate trust/provider behavior, approved helper execution and side-by-side deployment remain gates. Any SQL accounts/grants/configuration, certificates, Windows policies, VM networking, ERP data changes, existing installation replacement, deployment, merge or publication needs separate owner approval. The owner's architecture/development approval grants none of those infrastructure changes.
