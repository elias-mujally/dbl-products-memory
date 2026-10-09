# PR #11 merge outcome and bounded Live SQL Qualification plan

Date: 2026-10-09. **PR #11 MERGED; Live SQL Qualification NOT TESTED.**
This record publishes the authorized merge and an execution plan. No host discovery, SQL connection,
credential retrieval/rotation, certificate installation, service change or live test was performed.

## Verified merge

- Accepted review: Product Memory `98bad576e4034f3d64989fd9a5e8be8f604e5152`,
  [independent final verification](MOTAKAMEL_CONNECTOR_SLICE_001_PR11_FINAL_VERIFICATION_2026-10-09.md).
- Approved and rechecked head: `3fd128d2b49f439f24fe19fa7e3cc1c2e8d12e6e`.
- Base before merge: `95bf225e1523e0fd0f72cdf3da8393df18d635cc`.
- PR was OPEN / MERGEABLE / CLEAN; Linux and Windows checks both SUCCESS at that head.
  [PR CI](https://github.com/elias-mujally/dbl-legacy-intelligence/actions/runs/37933388599).
- GitHub review list and issue comments were empty; no newer blocking review was returned.
- `gh pr checks --required` reported no required checks. Branch protection/rule inspection returned
  HTTP403 with the repository-plan upgrade message. This is a visibility limit, not proof of a configured
  protected branch or permission to bypass it. All reported CI checks were green.
- Used normal merge with `--match-head-commit` set to the approved full SHA; no force/admin bypass,
  auto-merge, rule change, squash/rebase or branch deletion.
- [PR #11](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/11) now **MERGED**, closed by merge
  at **2026-10-09T13:50:20Z** / **16:50:20+03:00**.
- [Merge commit](https://github.com/elias-mujally/dbl-legacy-intelligence/commit/8c22f7b2a1dc251928adc9c7590b551dffddbd5e):
  **`8c22f7b2a1dc251928adc9c7590b551dffddbd5e`**.
- Remote `refs/heads/main` returned that exact commit. Fetch verified its two parents are the prior base
  and approved head, the approved head is an ancestor, and the tree diff against the approved head is empty.
  The existing clean local PR checkout was preserved; `origin/main` was updated without resetting files.
- Post-merge main CI: [run37939729079](https://github.com/elias-mujally/dbl-legacy-intelligence/actions/runs/37939729079).
  **Completed SUCCESS at merge8c22f7b**: Linux and Windows install/build/typecheck/tests passed; Ubuntu
  critical audit passed, Windows audit skipped by the unchanged workflow. This independently confirms
  the merged main build, separately from the passing PR checks.

## Fixed execution target

| Property | Approved value |
| --- | --- |
| Build | Merged main `8c22f7b2a1dc251928adc9c7590b551dffddbd5e` |
| Node | Node22, >=22.12; use the pinned dependency lock |
| Driver | mssql12.7.4 / Tedious20.3.3; no alternate driver/admin identity |
| Server / instance | DESKTOP-8QRQT7R / YSEDU |
| Frozen DB / ID | DBL_HOST_W11_EFA12026_PostS2_Frozen_20261009 / 10 |
| Reader | DBL_HOST_W11_S2_Reader_20261009 |
| Item | DBL_P001_ITEM_A / expected DBL_ITEM_A |
| Output | Product.id/name only; one product, no customers/sales/inventory |

The frozen-source and independent-reader evidence remains
[LAB-PROVEN at e7ec147](MOTAKAMEL_HOST_W11_POST_S2_FROZEN_READER_QUALIFICATION_2026-10-09.md).
It does not prove current Node/Tedious connectivity or certificate trust. The reader was previously
qualified through SqlClient and has SELECT on nine bounded lab tables plus a specific scalar function;
this identity slice accesses only item_detail and its fixed metadata/permission checks. No new grants
or attempts to exercise write privileges are needed in this connection test.

## Gate A — prerequisites before supplying a secret or connecting

1. An operator confirms the retained frozen source/profile provenance and that no restore/thaw/replacement
   occurred since qualification. Use existing evidence and, in a separately authorized execution,
   bounded read-only observations. Do not turn a matching DB name/ID into backup authenticity proof.
2. Confirm the available runtime is Node22 >=22.12, approved main and locked dependencies. Future isolated
   workspace build/install writes are local test artifacts, not host configuration changes. Do not install
   runtime packages globally or silently substitute versions. Confirm space for one small local SQLite test file.
3. Read-only checks establish resolution of DESKTOP-8QRQT7R, existing YSEDU named-instance discovery and
   TCP reachability. The adapter uses instanceName, not a guessed fixed1433 port. Tedious documents SQL Browser
   discovery through UDP1434 and a TCP endpoint. If disabled/unreachable, stop; do not start services or change
   firewall/TCP settings. A direct-port/profile change is a separate proposal, not an automatic workaround.
4. Read-only certificate evidence must establish the certificate actually used by SQL, its validity period,
   server-authentication purpose, name coverage for DESKTOP-8QRQT7R and a chain trusted by the exact Node process.
   Windows trust alone is not assumed to prove Node trust. Do not install a CA, select another certificate,
   override the hostname, alter process trust roots, restart SQL or change Windows TLS policy in this task.
5. Confirm SQL/TLS compatibility through the existing configuration/evidence and, only after these gates,
   the bounded driver handshake. The recorded engine12.0.6024.0 is SQL2014 SP3; Microsoft documents SP3 TLS1.2
   support. That is a compatibility basis, not proof of the host's negotiated protocol/cipher/certificate.
   Do not lower TLS versions, cipher security or OpenSSL policy if negotiation fails.

**TLS contract:** preserve `encrypt:true`, `trustServerCertificate:false`, TDS7_4, pinned server/instance/DB
and reader, private poolmax1 and10-second connection/request timeouts. No NODE_TLS_REJECT_UNAUTHORIZED=0,
certificate-validation callbacks accepting failures, unencrypted connection, administrator fallback or FMMA.

## Gate B — secure credential handoff

The qualification record states the reader's generated secret was neither persisted nor delivered.
This plan has no usable secret and does not search for one. If an approved operator has the current secret,
it must be handed to the reader process through an existing secure channel. If it is unavailable/expired,
stop and obtain separate authorization for an operator to rotate **this reader only** and deliver its secret;
the connector must not provision/rotate logins or use an administrative password.

Prefer an operator-controlled, non-echoed prompt or existing secret broker that feeds an in-memory
passwordProvider in the future one-off test runner. No password in chat, command arguments, script literals,
Git, .env, evidence, transcript, driver debug output or saved connection string. Do not dump process environments.
If using the existing opt-in test, supply DBL_MOTAKAMEL_READER_PASSWORD only in the test child process environment,
with DBL_MOTAKAMEL_LIVE_TEST=1; remove both in finally and close the process after the test. Do not use setx or
machine/user-persistent environment variables. This environment route has same-user/process exposure limits;
it is not a vault or memory-erasure guarantee. A direct passwordProvider avoids inheritance where practical.

Success criteria: non-secret confirmation of approved reader handoff, no persisted password, and operator
confirmation the secret belongs to the retained reader. Do not test bad passwords or induce lockout.

## Gate C — bounded real driver qualification

After A/B pass in a future authorized execution, instantiate the merged production adapter with a real
passwordProvider and **no injected sessionFactory, replay payload, fixture or synthetic clock**.

1. Call testConnection once. This opens the real mssql/Tedious transport and executes the fixed inspection:
   exact engine/server/DB/ID, READ_ONLY, original/effective login/user, selected least-privilege checks,
   nvarchar column lengths/types and sole i_code PK. Unknown/null/mismatch fails closed.
2. Call exportAcquisition once; the adapter opens a bounded new session, checks before/after, and selects
   TOP2 with itemCode parameterized as nvarchar20. Require exactly DBL_P001_ITEM_A / DBL_ITEM_A.
3. Retain the actual snapshotId/capturedAt/source and one-product canonical export as a local lab artifact
   before import; it contains no credentials. Hash it and record the pinned build/runtime/profile.
   Do not turn acquisition completion UTC into an ERP business timestamp or backup as-of timestamp.
4. Close via finally; record only fixed adapter error codes and separate cleanupFailure if present.
   A close failure blocks a success claim. No raw error object/driver payload is printed or committed.

The existing `test/live.test.ts` is a conditional connection/projection smoke test and skips without
both opt-in and secret. A skipped test is NOT TESTED, not PASSED. It does not execute the full Import/SQLite/
Application path. Running it and running a full-path test are separate evidence claims; avoid duplicate
connection attempts merely for repetition. The full-path runner may cover the same smoke assertions once.

On failure, stop at the first bounded attempt. Distinguish DNS/discovery/TCP/TLS/authentication/profile
using approved read-only observations and sanitized codes. The adapter intentionally sanitizes connection
errors to MOTAKAMEL_READER_CONNECTION, so that code alone does not identify the failed layer. Do not enable
packet/payload debug or claim a root cause without evidence. Any remedy requiring a certificate/trust-store,
service, firewall, SQL configuration, permission or password change needs separate authorization.

## Gate D — real acquisition through the full DBL path

A future bounded one-off harness should reuse existing production APIs and the fixture pipeline structure;
the merged live test alone is insufficient. No connector/Core/Canonical change is needed to design it.
The harness is not implemented or executed by this planning task.

1. Use one fresh, explicitly named local SQLite file in the lab output directory, without overwriting
   an existing DB or opening it from parallel processes. Initialize SqliteLocalStore and a local sanitized
   AuditSink; feed the **same real acquired connector instance** to ImportOrchestrator.
2. Assert one committed checkpoint, recordCounts products1/customers0/sales0, original snapshotId/capturedAt,
   and sourceSystem=frozen DB / sourceVersion=pinned identity profile. No new SQL acquisition is required.
3. Open SnapshotReader and require the exact sole Product {id: DBL_P001_ITEM_A, name: DBL_ITEM_A}; repeated
   canonical reads match. Call DefaultLegacyIntelligenceApplication.openReadScope and query product by its ID
   using the current QUERY_PLAN_VERSION contract. Require the same product, snapshot and provenance.
4. Import the same acquisition again sequentially and require one checkpoint and identical content.
   Optional separate restart phase reopens the SQLite file only after the prior process closes, and uses
   the preserved acquisition for offline replay. Label this OFFLINE REPLAY OF LIVE ACQUISITION, not another
   live SQL connection. Do not change the ID or capturedAt to evade a conflict.
5. Finish the reader/scope iterables, then close connector and store independently in finally, preserving
   the primary error and sanitized cleanup diagnostics. SnapshotReader/ApplicationReadScope do not expose
   close methods in the current contracts. Retain local SQLite/canonical artifacts; do not auto-delete them.

Local SQLite/audit/artifact writes are expected test outputs. All SQL activity is the adapter's fixed
read-only queries against the frozen DB. No source/live EFA business reads/writes, Inventory/Purchase
implementation, quantity validation, ERP Save, S3, standalone posting or master-data changes are included.
Do not infer stock-zero, purchase readiness or useful Purchase Attention from a Product identity.

## Qualification outputs and present decision

Future evidence must identify build/Node/driver/profile, gate results, sanitized failures, actual canonical
hash/identity/time, committed checkpoint counts and Application query equality, plus cleanup outcome.
Keep passwords/raw driver data/database exports out of Git; publish only reviewed bounded evidence summaries.

| Status now | Result |
| --- | --- |
| PR merge | VERIFIED — remote main8c22f7b, approved head retained |
| Fixture implementation | PASSED, as independently reviewed; source proof remains LAB-PROVEN |
| Secure reader-secret handoff | NOT AVAILABLE TO THIS TASK / NOT QUALIFIED |
| Host certificate + Node trust + named-instance transport | NOT QUALIFIED; no host inspection performed here |
| Live Node/Tedious projection | NOT TESTED |
| Live Connector→Import→SQLite→SnapshotReader→Application | NOT TESTED |
| Next execution readiness | WAITING FOR SECURE PREREQUISITES; no live test attempted |

The next narrow decision is authorization for read-only connectivity/certificate prerequisite discovery
and operator-managed secure reader handoff. If a missing prerequisite requires host/SQL changes, present
that exact change for separate authorization. No Inventory/Purchase/S3 or contract expansion follows the merge.

## Primary references checked for the plan

- [Merged adapter transport and inspection](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/8c22f7b2a1dc251928adc9c7590b551dffddbd5e/packages/connectors-motakamel-plus/src/source.ts).
- [Merged live smoke test](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/8c22f7b2a1dc251928adc9c7590b551dffddbd5e/packages/connectors-motakamel-plus/test/live.test.ts).
- [Merged fixture full-path example](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/8c22f7b2a1dc251928adc9c7590b551dffddbd5e/packages/connectors-motakamel-plus/test/end-to-end.test.ts).
- [Tedious connection options](https://tediousjs.github.io/tedious/api-connection.html): instance discovery,
  encryption, certificate-name validation and TDS options; observed2026-10-09.
- [Microsoft SQL TLS1.2 support](https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/connect/tls-1-2-support-microsoft-sql-server): SQL2014 SP3 support; observed2026-10-09.
- [Microsoft certificate requirements](https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/certificate-requirements?view=sql-server-ver17): certificate validity/purpose/name requirements, not current host evidence.

Only Product Memory/README documentation is updated in this task; `.vscode` remains excluded. STOP.
