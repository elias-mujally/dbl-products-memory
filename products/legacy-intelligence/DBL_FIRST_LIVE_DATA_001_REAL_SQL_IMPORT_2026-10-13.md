# FIRST LIVE DATA #001 — October13 authorized real SQL import

## Authorization and current status

Owner separately approved the first real bounded import after the verified reader rotation at `01e0386`. Use only the existing frozen database `DBL_HOST_W11_EFA12026_PostS2_Frozen_20261009` and Reader `DBL_HOST_W11_S2_Reader_20261009`, current Bitwarden-held password via hidden local input, and merged production Connector → ImportOrchestrator → SQLite → SnapshotReader. Target only `DBL_P001_ITEM_A` / `DBL_ITEM_A`, counts products1/customers0/sales0. No source/account/permissions/service/network/TLS/trust/Connector/Canonical changes, expanded business reads or automatic retries.

**Preparation PASSED; actual TLS/Reader/item acquisition/import/SnapshotReader outcome PENDING, not PASSED.** Reuse the qualified existing execution harness; no new connector or backup/PKI project.

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
