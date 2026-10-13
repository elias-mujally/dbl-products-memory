# FIRST LIVE DATA #001 — October13 authorized real SQL import

## Authorization and current status

Owner separately approved the first real bounded import after the verified reader rotation at `01e0386`. Use only the existing frozen database `DBL_HOST_W11_EFA12026_PostS2_Frozen_20261009` and Reader `DBL_HOST_W11_S2_Reader_20261009`, current Bitwarden-held password via hidden local input, and merged production Connector → ImportOrchestrator → SQLite → SnapshotReader. Target only `DBL_P001_ITEM_A` / `DBL_ITEM_A`, counts products1/customers0/sales0. No source/account/permissions/service/network/TLS/trust/Connector/Canonical changes, expanded business reads or automatic retries.

**FIRST LIVE DATA #001 = PASSED**, actual execution completed at `2026-10-13T16:04:51.618Z` (`19:04:51.618+03:00`). Strict production-driver TLS, limited Reader guards, real SQL Item acquisition, production import and SnapshotReader all passed. The pending entries below are preserved preparation history; the final evidence section supersedes them. No new connector or backup/PKI project.

## Current verified preparation

- Remote `main` independently read as `aa234dfbeb38ce738718957d739af348406c293a`. Local clean approved head `84eadfddfd064ada961e36675ceffe24e33f2f3a` has the exact merged tree `51f15b2a1113fc3742559f7d76dab350fb8bb83c`. No code/config edit or rebuild was needed. The existing Node22.23.2 runtime, locked mssql12.7.4/Tedious20.3.3/better-sqlite3 11.8.1, all46 build/native/helper/CA pins and original launcher/wrapper/runner hashes match the [qualified execution report](DBL_FIRST_LIVE_DATA_001_BOUNDED_READ_2026-10-11.md).
- Actual runner `check` passed pin/module/native SQLite loading without TCP probe or SQL connection. Wrapper CheckOnly and launcher pins/child parse passed without requesting a password or opening a child.
- Fresh read-only environment at `2026-10-13T18:01:28.6308869+03:00`: YSEDU Running, Auto, LocalSystem, PID101852; sole owned listener `192.168.56.1:52952`, dynamic, registry matches exact endpoint, other IPs disabled / ListenOnAllIPs0. Browser Stopped/Disabled. Approved certificate binding/Root/Leaf DER/current validity match; ForceEncryption0 unchanged. No SQL login in this environment check. The wrapper repeats fresh environment/DNS and one no-auth TCP probe before its password request, and the runner refreshes again before live execution.
- Source review confirms direct port with no instanceName/Browser discovery, encrypt=true / trustServerCertificate=false, approved hostname, pinned-only approved public CA, minimumTLS1.2, transient-login retries0. Production fixed metadata query validates server/version/database10/READ_ONLY/reader/least privileges/schema/PK before any business row. The only Item query is fixed parameterized TOP2 for the single approved item; exact single row/name and empty other streams required. Cached acquisition is reused by the production import; separate health checks are metadata-only, not new item acquisitions.
- Fresh local evidence review proves no existing live ATTEMPT/RESULT/canonical/SQLite/audit files and no known previous live-wrapper/runner process. Previous owner preflight from `2026-10-11T20:58:48.798Z` was pre-credential/pre-SQL (`TLS/Reader/FirstLiveData=NOT_TESTED`), not an actual import attempt.

## Historical preparation evidence preserved

To use the unchanged qualified fresh-owner-preflight path without replacing old evidence, the stale public owner preflight was moved within the same exact task directory to `FIRST_LIVE_DATA_001_OWNER_PREFLIGHT_20261011_PRESERVED_BEFORE_READER_ROTATION.json`. Before/after SHA256 `536827CF64CD7E806E1868C5CCA9578AFA4C25971184057448DB18A4BA1B9900` matched; no destination overwrite or deletion. Existing earlier general preflight remains untouched.

An initial preparatory shell timestamp comparison rejected a typed `System.DateTime` produced by PowerShell's default JSON parsing. A separate read-only raw-string comparison proved the exact original timestamp and all NOT_TESTED fields unchanged; the file was still unmoved and no SQL/secret/live attempt had occurred. Preservation then used `ConvertFrom-Json -DateKind String` and the exact verified hash. This is an evidence-bookkeeping comparison correction, not a connection/identity/TLS failure, helper change or retry of live SQL. All executable harness files remain byte-identical.

## Owner secret and single execution boundary

Visible ordinary owner PS7 console requires unredirected input/output, existing transcription/environment guards and absent live outputs; fresh no-auth prerequisites precede `READER_READY` and `Read-Host -AsSecureString`. Owner supplies only the newly saved Reader password, not a CA/archive/Windows/admin value. It is transferred to the owned Node child's private stdin pipe, never tool arguments/env/file/public output. No clipboard automation, vault inspection, screenshot or secret-derived hash. Immutable managed/process-memory erasure is not guaranteed.

Live test uses the existing production Connector with no replay/mock/fixture/sessionFactory override, one bounded acquisition and one import invocation (maxAttempts1, never retry), one committed checkpoint, exact acquisition provenance/record counts and SnapshotReader equality. Application-service product query reads the imported SQLite snapshot only. Observe only public driver connection metadata and require the fixed server/database; no credential/payload/error logging. Separate TLS/Reader/acquisition/import/SnapshotReader flags must be reported from actual outcomes. Negotiated cipher/socket capture is not promised by a successful strict driver connection.

CreateNew attempt/evidence/SQLite output guards remain. On any actual gate failure, preserve safe code and partial artifacts, close independently, STOP, no host/code/account remedy or repeat. CRL/OCSP remains UNKNOWN under the accepted laboratory policy, not revocation success or production readiness. No SQL restore/backup claim.

Only final actual result and retained local canonical/SQLite/audit/provenance evidence permit **FIRST LIVE DATA #001 = PASSED**. Opening a console or any earlier reader login alone does not. Await owner interaction and final nonsecret result; do not launch again.

## Authorized visible owner console launched

Preparation was pushed and verified at `1d9f7489fda5ab636477e48d46aed8d5398c98db`. The unchanged hash-pinned existing launcher opened one ordinary visible owner console PID103956, returning `OWNER_READER_CONSOLE_STARTED_LIVE_RESULT_PENDING`. Owner was instructed to prepare the newly applied Bitwarden Reader value, type only public `READER_READY` at confirmation, then enter the password only at the hidden secure prompt. No password/argv/environment/clipboard/vault data was accessed by the agent. **Live outcome remains PENDING, not successful**; no second launcher or automatic retry. Final local nonsecret result must be reviewed before any PASSED decision.

## Explicit owner-requested reopening before any live attempt

Owner reported the console closed without acting and explicitly requested another opening. PID103956 was independently absent; exact known live-console/runner matching found zero active workflow processes, without publishing arguments. ATTEMPT/RESULT/canonical/SQLite/audit outputs were all absent. Thus the previous production live runner/import did not start; no SQL retry is inferred or authorized from this reopening. No wrapper failure/result was persisted, so the exact console-exit cause is unknown rather than attributed to a timeout or credential failure.

Previous fresh owner preflight at `2026-10-13T15:03:33.687Z` proved one no-auth TCP probe, PID101852/port52952, with TLS/Reader/FirstLiveData NOT_TESTED. It was preserved within the same exact task directory, without replacement/deletion, as `FIRST_LIVE_DATA_001_OWNER_PREFLIGHT_CLOSED_BEFORE_INPUT_20261013T180333.json`; SHA256 before/after `45990D4AFA6071DA09EF099B2856004409AEC538D2611CC884E4F9CBB23E4B03`. All prior evidence and qualified executable bytes remain unchanged. Launcher CheckOnly pins/parse passed without connection or prompt.

The one explicitly owner-requested new console opened as PID102888 with `OWNER_READER_CONSOLE_STARTED_LIVE_RESULT_PENDING`. It repeats fresh endpoint/DNS/no-auth TCP gates before hidden current-reader input; identical live attempt/output guards remain. Owner received precise readiness-token vs hidden-password guidance; no secret was requested in chat or inspected. **Live outcome still PENDING; no TLS/Reader/acquisition/import/SnapshotReader success claimed.** No automatic retry, host/credential/code change or broader import. Await final nonsecret result; do not launch again.

## Final actual execution and independently reviewed evidence

The owner returned `FIRST_LIVE_DATA_001_PASSED`. The persisted local `FIRST_LIVE_DATA_001_RESULT.json`, attempt marker and canonical acquisition were independently read and matched to the returned result; retained SQLite/audit/canonical SHA256 values were recomputed and matched the result. This final review did not reconnect to SQL, rerun the launcher/import, initialize a writable SQLite store or request another password. Final artifacts and all previous evidence remain in the original task directory.

| Gate | Actual result and boundary |
| --- | --- |
| Current endpoint / route | Fresh owner preflight and before/after environment passed. YSEDU Running / LocalSystem / PID101852, sole owned `192.168.56.1:52952` dynamic listener. SQLBrowser remained Stopped/Disabled. Port was observed, not assumed. |
| TLS | Successful actual encrypted production mssql/Tedious connection: encrypt=true, trustServerCertificate=false, normal hostname validation `DESKTOP-8QRQT7R`, minimumTLS1.2, pinned-only approved CA DER SHA256 `A3FBC7905425B2E8C10F3A070B8713F876B94FC42B8D1243DEAD5D0F42889472`. Direct port52952, no instance discovery; transient-login retries0. |
| Reader / source guards | Fixed server/SQL2014/frozen database ID10/READ_ONLY/login/schema/permission checks passed for `DBL_HOST_W11_S2_Reader_20261009` and `DBL_HOST_W11_EFA12026_PostS2_Frozen_20261009`. No administrative Connector account, permission expansion or business write. |
| Real SQL acquisition | Production fixed parameterized single-item query returned exactly `DBL_P001_ITEM_A` / `DBL_ITEM_A`. No fixture, mock, manual substitute or other business-data slice. |
| Import | Existing Connector → ImportOrchestrator → SQLite passed: attempts1, batchesProcessed1, products1/customers0/sales0, auditComplete=true, warnings empty. |
| SnapshotReader / application read | Actual SnapshotReader returned the exact product and empty customer/sale streams with matching snapshot/source/header. Existing application product query against the imported SQLite passed. |
| Post-read / cleanup | Same PID101852/address/port/certificate binding/ForceEncryption0 before and after. No host mutation, retry or cleanup failures. |

The approved production build tree was `51f15b2a1113fc3742559f7d76dab350fb8bb83c`, identical to merged main `aa234dfbeb38ce738718957d739af348406c293a`; Node v22.23.2 and pinned harness were unchanged. No Connector or Canonical implementation modification was made.

### Actual provenance and committed import

- Operation ID: `2277ba05-7dd9-4288-be7a-7a209ac9798e`.
- Connector ID: `motakamel-plus-host-w11-item-identity`.
- Source system: `DBL_HOST_W11_EFA12026_PostS2_Frozen_20261009`.
- Source version: `motakamel-plus-host-w11-posts2-20261009-item-identity-v1`.
- Snapshot ID: `motakamel-item-cfac40fe0e4cf6f675d79d3909fde18c2371eddd5c7d9561ce973d97e7a051fe-e76f760c-8364-4c14-afe9-c8b80234d820`.
- Captured at `2026-10-13T16:04:50.476Z`; import started `16:04:50.520Z`, checkpoint imported `16:04:50.685Z`, completed `16:04:50.688Z`; schemaVersion `2.0.0`.
- Acquisition content fingerprint: `420a18623f646141158162f71954e16cf8d4308c028f47e090b7f9a2b01254dd` (data identity, not a password-derived value).
- Checkpoint, persisted canonical header and result share the same snapshot/source/capture identity and products1/customers0/sales0.
- Audit actions: `connector.health.ok`, `import.started`, `import.completed`; no retry action.

### Retained local artifacts, independently recomputed SHA256

Exact directory: `C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-first-live-data-001-20261010`. Data artifacts remain local; SQLite and canonical acquisition are not committed to Product Memory/Git. Only nonsecret evidence and the expressly approved test-item identity are documented here.

| File | Bytes | SHA256 |
| --- | ---: | --- |
| FIRST_LIVE_DATA_001_RESULT.json | 4974 | `DEFA4ECA67EE7798C8837A7E80DD560E3E33254C2D85ADEE71F0F6A06B1A30FC` |
| FIRST_LIVE_DATA_001_ATTEMPT.json | 619 | `3036BB853993213D91D822AC5F6DC1C9E9D04D245C5B0ED93FBBFA53E5E05407` |
| FIRST_LIVE_DATA_001_CANONICAL.json | 562 | `E41349ED3B8869D3045BD32746DD696E3CF1C1B53C5465A9DF124E3E11B71F26` |
| FIRST_LIVE_DATA_001_snapshot.sqlite | 122880 | `D80B195FE1F2DE332DDD75A5BF05E00B81C289ABBF20557DF16EDE59BB786470` |
| FIRST_LIVE_DATA_001_audit.sqlite | 28672 | `4BAF74BFD83C7949240B152345DDF6DBCFBA16CBA780B3408D2861D47A6062CE` |
| FIRST_LIVE_DATA_001_OWNER_PREFLIGHT.json | 1263 | `07CF6DBCF570A9874921B7F029DF55B247288988BA92C4D1EE25BE14D2A0B12F` |

### Proof limits, secret handling and STOP

Six production driver connection-create observations (IDs1–6) all name the fixed server/database. These are production pool/probe/validation/health/acquisition sessions, not six item imports or retry proof. The actual import attempts1 and Retry=false are recorded; no claim of a single physical socket is made. Negotiated cipher/peer socket was not separately captured: TLS proof is the successful strict real driver connection with pinned-only CA and normal hostname validation.

Owner's separate wrapper completion reported exitCode0, PasswordPersisted=false, PasswordInArguments=false, PasswordInEnvironment=false and NoAutomaticRetry=true. This wrapper completion was supplied by the owner; the persisted Node result and file hashes were independently verified. The reviewed unchanged hidden-input/private-stdin harness never places the password in Product Memory, command arguments, environment or public artifacts. No password or password-derived fingerprint was read or published during final review. Comprehensive process-memory erasure is not guaranteed.

CRL/OCSP remains UNKNOWN under the explicit laboratory policy, not a successful revocation check or production readiness. Existing machine-wide CA trust and the single-host CA custody risk remain; this run did not change them. This is proof of the bounded item identity slice, not broader ERP correctness, a SQL restore test or archive qualification. Dynamic port must be rediscovered for any separately authorized later run.

**STOP: goal achieved for FIRST LIVE DATA #001. No rerun, extra data experiment, source/security change, credential rotation or resumption of deferred archive work.**
