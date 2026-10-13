# First Live Data #001 — bounded live execution

Owner authorization follows SQL activation at `b086af6`. Historical preparation was **PREREQUISITES PASSED / OWNER READER SECRET PENDING; FIRST LIVE DATA = NOT TESTED**. It was superseded by the separately authorized October13 execution: **FIRST LIVE DATA #001 = PASSED**; see the [final actual evidence](DBL_FIRST_LIVE_DATA_001_REAL_SQL_IMPORT_2026-10-13.md). Preparation checks alone did not prove live success.

## Verified preparation

- Remote main still `aa234dfbeb38ce738718957d739af348406c293a`; clean local approved head `84eadfddfd064ada961e36675ceffe24e33f2f3a` has identical tree `51f15b2a1113fc3742559f7d76dab350fb8bb83c`. No source/Connector/Canonical edits.
- Rebuilt existing workspaces successfully with explicit retained Node22.23.2, not current bundled/default Node24. Node executable SHA256 `0D0F5E39F9F3D9587BC19F73EAB3C2C9C4903FD02D6DBF9C853DD81B3D95FAD4`. Existing installed mssql12.7.4, Tedious20.3.3, better-sqlite3 11.8.1; lock and46 build/helper/native/public-CA files pinned.
- Current service identity is independently read via `sc queryex/qc`, not guessed from an old port: YSEDU Running/Auto/LocalSystem, PID101852. Sole PID-owned SQL TCP listener `192.168.56.1:52952`; Registry32 IP4 dynamic port agrees, fixed port empty, ListenOnAllIPs0, other IPs disabled. Browser Stopped/Disabled. Binding/public Root/Leaf DER hashes and certificate current validity match approved evidence; ForceEncryption0 unchanged.
- Node prerequisite record `2026-10-11T20:53:15.966Z` proves one successful **no-authentication TCP probe** to the approved IPv4 endpoint with before/after PID/port unchanged. This is not a TLS or login test. Normal hostname resolution includes the approved address; Node's process-local `--dns-result-order=ipv4first` selects the approved first route without changing DNS/hosts/Windows settings. Further DNS/socket fallback remains a driver behavior, not a stronger single-socket guarantee.
- Production module imports and native SQLite load succeeded; a temporary in-memory SQLite handle was opened/closed only to qualify the native module. No synthetic product data or fixture/mock/sessionFactory/replay is used to prove live data. The public CA PEM happens to reside in existing test/support; its exact DER matches the real approved Root, and it is trust material only, never a business-data fixture.

## Narrow one-off execution harness

The reviewed harness lives in the existing task output directory, outside the implementation repository. It invokes existing production APIs, without altering them. Public review copies are in `research/DBL_FIRST_LIVE_EXECUTION_001_*`; original executable hashes below apply to local bytes, not Git newline-normalized copies.

| Tool | Local SHA256 |
| --- | --- |
| Read-FirstLiveEnvironment001.ps1 | `A11CBCAB8EF1B189343D8ADCA62AC572F945C9D3EA463B5D4BDC94BCCCF7B78A` |
| Run-FirstLiveData001.mjs | `4BAFFF5BE383EE0620C6A58E0A8C55E654279B9FAAE1CA4A91FC9B13E57A142B` |
| FIRST_LIVE_DATA_001_BUILD_PINS.json | `5002A188956FCF07B3C271ED143C5C007C388075E0A8D4F4920E1E1EDC6E846A` |
| Invoke-FirstLiveDataInteractive001.ps1 | `A956DC9ADED8EDFCC33CAD46AA8F1EBC2434A741A6B098EE53F473F40BA854AB` |
| Start-FirstLiveData001.ps1 | `797B3038C0B0DC8FFF9259D12A9BDCFC1674B810E13E2F375B448941D8F2B0C1` |

Node check mode passed module/pin/native guards with no TCP or SQL connection. PS wrapper CheckOnly and launcher pins/child parse passed without prompting or launching. No new encryption/backup/security framework or dependency was built.

### Secure owner handoff

Visible ordinary owner PS7 console (no administrator needed, no impersonation/UAC change) requires nonredirected input/output and disabled/absent transcription policy, safe process environment and no prior live-run artifacts. It reruns fresh prerequisites before requesting `READER_READY` and the **current independent SQL Reader password** via Read-Host -AsSecureString. It sends that one secret to its owned Node child through redirected stdin only; no argv/env/file/log/chat secret. It disposes SecureString, zero-frees BSTR and clears managed references; this is **not** comprehensive memory erasure. No archive or CA password is requested. Do not send a password or screenshots of input.

### Ordered live gates

1. Recheck46 pins, clean merged tree, Node/version/environment, CA, current service/listener and source target. Owner preflight must be recent and same PID/port. CreateNew attempt/evidence/local-output guards prevent overwrite or automatic rerun. No SQL login before the owner hands off the secret.
2. Instantiate `MotakamelPlusItemIdentityConnector` with passwordProvider and closed directTcp only. No dependency overrides, replay, synthetic time or named-instance discovery. Existing Adapter config retains encrypt=true, trustServerCertificate=false, normal host validation DESKTOP-8QRQT7R, explicit pinned-only CA, minimumTLS1.2 and transient-login retries0.
3. Actual testConnection checks fixed server/SQL2014 version/frozen database ID10/READ_ONLY/independent reader names, no administrative or write rights and exact schema/PK. Successful strict production-driver connection supports TLS/Reader qualification separately; no cipher/peer-socket/packet capture is invented. If connection fails, sanitized Adapter code alone may not identify DNS vs TLS vs auth; report only proven cause and STOP without raw driver/debug diagnostics or repairs.
4. exportAcquisition once uses production fixed TOP2 parameterized Item SQL and before/after profile checks; require the sole `{id:DBL_P001_ITEM_A,name:DBL_ITEM_A}`, no customers/sales. Persist local canonical acquisition with actual ID/time/provenance.
5. Same real acquired connector → existing ImportOrchestrator → fresh local SqliteLocalStore and existing SqliteAuditSink. One import invocation; existing retryPolicy option limits attempts1/never retry. Its standard health check is a separate successful source session, not another Item acquisition; cached stream retains acquisition identity. Pool probes/validation are unchanged production behavior, not a promise of one physical socket. Only nonsecret mssql connection-create metadata is observed, never payload/error/credentials.
6. Require one committed checkpoint with products1/customers0/sales0 and actual snapshotId/capturedAt/source. SnapshotReader must return exact Item and empty other streams. Existing Application Service product query must return the same item/snapshot; empty insight engine does not invent stock/price or expand the slice.
7. Recheck source service/port/Browser; close Connector, storage and audit independently. Preserve primary safe code and independent cleanup failures; no PASSED on cleanup or artifact failure. Hash retained SQLite/audit/canonical artifacts and emit nonsecret result. No source writes, grants, service/security/network changes or retry on failure.

Local outputs are `FIRST_LIVE_DATA_001_*` in `outputs/host-first-live-data-001-20261010`. Retain local SQLite and canonical evidence, not SQL database exports in Git. At preparation no live attempt marker, password request, TLS handshake/login, Item acquisition or import exists. CRL/OCSP remains UNKNOWN under owner lab policy; machine Root trust is machine-wide, not production qualification. Source frozen-profile guard is not a fresh backup-authenticity proof. S3 and archival work remain paused. STOP after the actual result; no changes or broader data experiments.

## October13 separately authorized real SQL import

Reader rotation/handoff/login passed at `01e0386`; owner separately approved FIRST LIVE DATA execution. [Final execution record](DBL_FIRST_LIVE_DATA_001_REAL_SQL_IMPORT_2026-10-13.md) independently matches the persisted actual result and local canonical/SQLite/audit hashes. Strict TLS, fixed limited Reader/READ_ONLY guards, actual SQL acquisition, production import and SnapshotReader passed at `2026-10-13T16:04:51.618Z`: exact `DBL_P001_ITEM_A` / `DBL_ITEM_A`, products1/customers0/sales0, one import attempt, no fixture/mock, retry or host/Connector/Canonical implementation changes. All preparation history remains preserved. Revocation UNKNOWN remains the accepted laboratory gap, not success. STOP; no further connection or import.
