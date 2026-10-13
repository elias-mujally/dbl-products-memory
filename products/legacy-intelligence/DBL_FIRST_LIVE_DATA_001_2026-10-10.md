# DBL First Live Data #001 — bounded resumption and prerequisite STOP

Date: 2026-10-10, Asia/Aden (+03:00).
Owner priority shift: pause complex Recovery Capture qualification and preserve all its evidence; seek the first real Item A acquisition through the existing Motakamel adapter and DBL import path.

## Decision

Historical October10 decision: **FIRST LIVE DATA #001 = BLOCKED BEFORE SQL CONNECTION — NOT PASSED.** The separately authorized October13 run subsequently achieved **FIRST LIVE DATA #001 = PASSED**; see the [final verified execution evidence](DBL_FIRST_LIVE_DATA_001_REAL_SQL_IMPORT_2026-10-13.md). The diagnosis and no-action history below remain unchanged.

No fixture/mock result is substituted for live proof. No SQL authentication, source SELECT, TLS/TDS handshake, new acquisition, SQLite import or SnapshotReader read was attempted. The earliest confirmed blocker is disabled YSEDU TCP with no listener. Named-instance discovery, strict certificate trust and reader-secret handoff are also not ready. Per the owner's STOP rule, no host remedy was applied.

Recovery qualification is now **PAUSED BY OWNER**, not complete/cancelled. The reports at `cab9540`, `1dd4679` and `608175e`, isolated synthetic files and decoder-retention artifacts are preserved unchanged. No inherited-fixture diagnosis/replay or backup project was continued. Its metadata gate remains historically BLOCKED, but reopening it is not this task's next action.

## Actual repository and runtime

Fresh origin/main fetch returned **8c22f7b2a1dc251928adc9c7590b551dffddbd5e**, the accepted PR #11 merge. Local branch remains codex/motakamel-item-identity at **3fd128d2b49f439f24fe19fa7e3cc1c2e8d12e6e**; the tracked-tree diff against origin/main is empty and the worktree clean. No reset, branch rewrite or connector rebuild/change.

Existing source inspected: [SQL transport/profile inspection](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/8c22f7b2a1dc251928adc9c7590b551dffddbd5e/packages/connectors-motakamel-plus/src/source.ts), [connector/acquisition lifecycle](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/8c22f7b2a1dc251928adc9c7590b551dffddbd5e/packages/connectors-motakamel-plus/src/index.ts), mapping, replay/acquisition policy, opt-in live test and fixture full-path test. Installed mssql/Tedious transport code was also inspected.

Current runtime check at **20:02:50.823+03:00**:

- Explicit existing Node22 executable under work/node-v22.23.2-win-x64: v22.23.2, OpenSSL3.5.7, win32/x64; no global installation/PATH change.
- 153 installed package versions match lockfile v3; no missing required package or version mismatch; 60 optional entries absent. This is version checking, not a cryptographic integrity audit of all dependency bytes.
- mssql12.7.4, tedious20.3.3, better-sqlite3 11.8.1, TypeScript5.9.2 and Vitest4.1.11 match their lock entries.
- Existing connector, ImportOrchestrator, SqliteLocalStore and Application Service modules loaded without SQL connection or SQLite initialization. This does not establish native SQLite operation in this run or replace the prior build/fixture tests.
- Default TLS minimum TLSv1.2; tls.setDefaultCACertificates is available. No process trust was changed.
- Before runtime launch, NODE_OPTIONS, NODE_TLS_REJECT_UNAUTHORIZED, NODE_EXTRA_CA_CERTS, SSL_CERT_FILE and SSL_CERT_DIR were checked for presence only and were absent. No secret values/environment dump.

The exact installed/emitted artifacts were not rebuilt or re-certified byte-for-byte against TypeScript in this task. Module loading and source review are separately scoped observations.

## Current host evidence — not remembered configuration

[Non-sensitive observations](research/DBL_FIRST_LIVE_DATA_001_PREFLIGHT_2026-10-10.json) transcribe actual tool outputs. Host read at **20:01:12.7040952+03:00** used the non-elevated DESKTOP-8QRQT7R\\user token:

| Layer | Current observation | Meaning |
|---|---|---|
| Instance | YSEDU maps to MSSQL12.YSEDU | Matches intended instance |
| SQL service | Running/Auto, PID5072, LocalSystem, expected sqlservr.exe -sYSEDU | Running is not database/catalog/transaction proof |
| TCP | Enabled0; no SQL-process TCP listener; IPAll dynamic value "0", fixed port empty | **Confirmed earliest blocker**; no actual SQL port, do not guess1433 |
| Discovery | SQLBrowser Stopped/Disabled; no UDP1434 endpoint | Current adapter's instanceName path unavailable; no repeated SSRP test needed |
| Certificate | Empty YSEDU thumbprint; LocalMachine/My certificate count0; ForceEncryption0 | No suitable bound/installed leaf demonstrated; actual presented certificate not collected |
| Reader secret | Not available in current test-process environment; opt-in absent | No password guess, credential-store search or administrative fallback |
| Source state | No SQL connection/query | Current frozen READ_ONLY/grants/login enabled/expiry state **NOT VERIFIED** |

Historical strict Windows-maintenance connection rejected the certificate chain at [526a4e8](MOTAKAMEL_HOST_W11_YSEDU_NETWORK_ENABLEMENT_2026-10-09.md). That evidence and the current empty store/binding justify a certificate prerequisite; they do not identify a freshly presented SQL certificate or a new Node TLS failure. No attempt with disabled encryption/validation was made.

Frozen database and independent reader retain their [qualification at e7ec147](MOTAKAMEL_HOST_W11_POST_S2_FROZEN_READER_QUALIFICATION_2026-10-09.md). The generated reader secret was not retained/delivered in that record. Current existence/permissions/expiry were not re-queried. Source/live EFA12026 and admin/FMMA are not substitutes.

## Existing connector is the intended execution path

Pinned database: **DBL_HOST_W11_EFA12026_PostS2_Frozen_20261009**, ID10; reader **DBL_HOST_W11_S2_Reader_20261009**; target **DBL_P001_ITEM_A / DBL_ITEM_A**.

Production SQL options retain server DESKTOP-8QRQT7R, instanceName YSEDU, encrypt:true, trustServerCertificate:false, TDS7_4, max-one private pool and bounded timeouts. Installed mssql drops port when instanceName is set; Tedious treats port/instanceName as mutually exclusive. There is no Shared Memory fallback or already supported direct-port override. Changing this contract merely to bypass Browser would be a separately reviewed build decision, not the shortest use of the existing adapter.

Fixed inspection checks exact server/engine/DB identity, READ_ONLY, original/effective login/user, selected least-privilege capabilities, nvarchar sizes/types and sole i_code PK. The only business projection is parameterized TOP2 i_code/i_a_name for the pinned item. Unknown/mismatched inspection fails closed. Mapping preserves the actual source name; the future runner must separately assert it equals DBL_ITEM_A. No free-form user SQL, broader data projection, Canonical extension or live-source fallback.

Existing fixture test demonstrates the API sequence but is **not** evidence of this real source:
Connector → ImportOrchestrator → SqliteLocalStore → openLatestSnapshotReader → products(), plus Application Service query. The current opt-in live test alone does not cover the full import path; it was not run or treated as passed/skipped success.

## Smallest practical prerequisite action — approval required, not executed

Recommend **one bounded YSEDU certificate + local transport maintenance window**, reusing the accepted design, then one secure reader handoff. This is an implementation proposal, not another backup/PKI design project:

1. **Certificate:** use an already available approved private issuer if actually supplied; otherwise execute the previously accepted dedicated DBL laboratory CA + one leaf design. Preserve offline signing-key custody outside Git/workspaces. For the leaf: DESKTOP-8QRQT7R CN/SAN, Server Authentication, RSA/SHA256, legacy SChannel CSP and KeySpec1; install the leaf/key only in LocalMachine/My and bind only YSEDU. Verify the exact new key's LocalSystem access; no broad ACL grant. Keep ForceEncryption unchanged: the client already requires encryption. No fallback certificate trust or system-wide TLS downgrade.
2. **Client trust:** fresh Node22 test process trusts only the fingerprint-verified public laboratory root through tls.setDefaultCACertificates before importing/creating TLS contexts; retain strict hostname/certificate checks. No NODE_EXTRA_CA_CERTS-only claim of exclusive trust. If Windows maintenance needs the already accepted additive CurrentUser/Root trust, explicitly approve that limited user-wide effect; no automatic LocalMachine/Root addition.
3. **Network:** enable TCP only for YSEDU, with ListenOnAllIPs disabled and a single verified local address compatible with the pinned hostname's actual resolver result. Do not promise loopback-only operation while the unchanged adapter resolves another address. Start SQLBrowser only for the retained instanceName discovery contract. Browser is a **shared host service**, not YSEDU-private; its discovery exposure must be reviewed/accepted. No remote access/Firewall opening or other-instance configuration change. If bounded local discovery cannot work within those limits, STOP and present the exact alternative instead of silently widening exposure.
4. **One planned normal SQL stop/start to apply the binding/TCP**, after normal closure of experimental clients and a current operational review. No Force/Kill/Reboot. Prepare combined certificate/network rollback: the old network utility refuses certificate drift and cannot serve as a combined rollback by itself. Restore captured TCP/binding/service settings, prevent auto-selection by removing only the new leaf's certificate entry if rolling back, preserve its private key, and allow only the scoped normal recovery start. Do not repeatedly restart on failure.
5. **Reader:** owner supplies the current constrained-reader secret through a non-echoed process-local channel; never chat/argv/.env/Git/logs. If unavailable, separately approve rotation of **this reader only** by an authorized maintenance operator after trusted connectivity; no grant changes, thaw, admin connector or FMMA. Recovery archive password is unrelated and must not be used.
6. **Current frozen/profile validation:** only after transport/trust/credential readiness, the real production connector performs its fixed checks. Schema/DB ID/version/name/read-only/permission drift → STOP, not a profile rewrite or source mutation.

These certificate/store/key/network/service/login actions are **not authorized for execution by the priority-shift message**. The owner specifically requires a limited procedure for approval first. This task applied none of them.

### Recovery boundary without reviving the paused archive project

A new maintenance approval must explicitly choose whether to accept the existing bounded recovery point **without waiting for completion of the paused encrypted full-instance capture**. Historical post-S2 backup has restore/CHECKDB evidence, but is not a full current master/login/grants/support-database/service recovery image. Its presence does not guarantee independent reader or full-instance recovery. Current transaction visibility remains incomplete under strict TLS; normal experimental shutdown can roll back uncommitted work.

Do not silently infer that pausing the archive either proves restart safety or waives every earlier recovery condition. Conversely, do not restart security-descriptor qualification as an automatic prerequisite project: ask for the narrow laboratory outage/recovery-risk decision alongside the actual implementation scope. If the owner does not accept that bounded maintenance risk, remain STOPPED.

## Once prerequisites pass — actual success proof, not performed now

Use the existing production connector with passwordProvider only; no sessionFactory injection, replay seed or synthetic clock. Acquire once, retain actual snapshotId/capturedAt/source and exact sole Product. Compare code/name to the approved target.

Feed the same acquisition-bearing connector to ImportOrchestrator using a fresh local SQLite output file. Require one committed checkpoint with products1/customers0/sales0 and frozen-source provenance. Open SnapshotReader and require exactly DBL_P001_ITEM_A / DBL_ITEM_A; optionally confirm through existing Application Service product query. Close resources independently with sanitized cleanup results. Retain local evidence/hash without secrets or raw driver diagnostics. SQL activity remains fixed SELECTs against the frozen database; SQLite writes are the intended local import, not ERP mutation.

Only those actual results permit **FIRST LIVE DATA #001 = PASSED**. Module imports, historical reader proof, fixture tests, certificate installation or a successful TCP connection alone do not.

## Primary support and completion

[Microsoft certificate requirements](https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/certificate-requirements?view=sql-server-ver17) support the legacy key exchange/server-auth/name/key-access checks.
[Microsoft TLS1.2 support](https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/connect/tls-1-2-support-microsoft-sql-server) supplies the SQL2014 SP3 protocol basis, not proof of this handshake.
[Node22 process CA API](https://nodejs.org/download/release/v22.23.2/docs/api/tls.html#tlssetdefaultcacertificatescerts) supports the scoped default-CA replacement; actual driver trust/name validation remains to be qualified.

Only documentation/evidence updated. No SQL/Windows/ERP modification, certificate issuance, TLS bypass, port probing/login retries, Connector implementation, backup/capture/fixture work, Inventory/Purchase/S3 or Canonical/product change. Product Memory .vscode remains excluded. **STOP at exact host prerequisites.**
