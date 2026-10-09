# Host W11 — authorized YSEDU network enablement: safety-gate stop

Date: 2026-10-09. Host: **DESKTOP-8QRQT7R**. Final service observation: **17:38:44+03:00**.
Decision: **BLOCKED — NO HOST CONFIGURATION CHANGE APPLIED**.

The operator explicitly confirms this is an experimental host without production systems or important
accounting work. Authorization follows [Gate A at Product Memory7384065](MOTAKAMEL_HOST_W11_LIVE_SQL_GATE_A_PREFLIGHT_2026-10-09.md): preserve settings/rollback, establish restart safety, enable narrowly scoped YSEDU TCP and Browser only as needed, restart conditionally and verify recovery. It does **not** authorize Firewall, certificate/trust-policy, credential/grant, other-instance or business-data changes, or a live connector test.

## Result and exact stopping point

The mandatory pre-restart SQL safety check could not establish current sessions, active transactions or
database states. One operational connection using the current Windows identity `DESKTOP-8QRQT7R\user`
was attempted over **Shared Memory**, with `Encrypt=true`, `TrustServerCertificate=false`, initial
database `master`, connect timeout5 seconds and application name `DBL-YSEDU-Network-Safety-ReadOnly`.
This is a maintenance preflight, not use of an administrative identity as the DBL connector reader.

`Open()` failed before any query ran:

```text
A connection was successfully established with the server, but then an error occurred during the login process.
(provider: SSL Provider, error: 0 - The certificate chain was issued by an authority that is not trusted.)
```

Thus the current operational client rejects the certificate chain. Actual certificate bytes, issuer,
SAN/hostname validity and Node trust remain unqualified; this is **not** proof of a specific self-signed
certificate or a Node/Tedious TLS outcome. No fallback with disabled encryption or certificate validation
was attempted. No reader password was supplied/guessed and no FMMA or alternate SQL login was tried.
The planned session/request/transaction/database SELECTs **did not execute**.

Consequently, no TCP property was set, Browser was not enabled/started, and SQL was not restarted.
Absence of important SQL work is **NOT VERIFIED**, not a claim that active transactions exist.
The non-elevated operator token also cannot perform the later service/WMI writes; no elevation was
attempted because restart safety had already failed. Sandbox host-read permission is not Windows token elevation.

## Before / after observations

| Property | Preserved original | Final observation / outcome |
| --- | --- | --- |
| MSSQL$YSEDU | Running / Automatic / PID5072 / LocalSystem | Running / Automatic / PID5072; no restart |
| SQLBrowser | Stopped / Disabled / PID0 / LocalService | Stopped / Disabled / PID0; no activation |
| YSEDU protocols | Shared Memory enabled; Named Pipes and TCP disabled | No protocol change; rollback comparison has zero differences |
| TCP root | Enabled0; ListenOnAllIPs1; KeepAlive30000 | Unchanged; ListenOnAllIPs1 is not exposure while TCP is disabled |
| IP bindings |16 captured IP nodes, all Enabled0; empty fixed ports; dynamic value `0` | Unchanged; no fixed port chosen |
| IPAll | TcpPort empty; TcpDynamicPorts `0` | Unchanged; configured `0` is not an actual listening port |
| Actual YSEDU TCP listener | No TCP socket objects owned by5072 | None observed; **actual TCP port: NONE** |
| Browser UDP1434 | No endpoint | None observed; one Node22 SSRP request timed out |
| Database state / active work | Current-state SQL query unavailable | **NOT VERIFIED**; no post-restart claim because no restart occurred |
| TLS configuration | Certificate binding empty; ForceEncryption0; HideInstance0 | Untouched; strict operational TLS chain check failed |
| Firewall | All three profiles enabled, inbound Block/outbound Allow | No profile/rule changes |

The service/endpoint inspection was repeated at the end. Empty TCP/UDP enumerations emitted no objects
and the combined command returned exit1; that is recorded as absence of observed endpoints, not a
successful connection. Node**22.23.2** separately sent one password-free SSRP request for YSEDU to
**192.168.56.1:1434** and received no response within**2500ms**. There was no retry, port scan, SQL login
or live connector call. This corroborates the stopped Browser, not a claim of a Firewall-caused failure.

## Preserved settings and executable rollback

Local workspace artifacts, retained outside the build/Product Memory repositories:

```text
C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-ysedu-network-enablement-20261009\ORIGINAL_SETTINGS.json
C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-ysedu-network-enablement-20261009\Restore-YseduNetwork.ps1
```

| Artifact | SHA256 |
| --- | --- |
| ORIGINAL_SETTINGS.json | E1BA78C819F348EC3D84FD8FC65178481D955340683238BD3AD92C3939F6005E |
| Restore-YseduNetwork.ps1 |732298D06C12AF89AFDFC08082FF31369D4437712F04AEC34CA3FB44ECFC70AA |

The JSON captures service identities/executables/start modes and registry Start values2/4; absence of
DelayedAutoStart; SQL WMI instance/protocol properties; every IP name/address/enabled/port setting;
untouched certificate/encryption values; and bounded Firewall observations. This is a **configuration
snapshot**, not a database backup. No backup/restore or database mutation occurred.

The utility defaults to **read-only comparison**. Syntax parsing passed, and its actual non-applying
run returned `ApplyRequested:false`, `Changes:[]`, `NO_CHANGES_TO_RESTORE`. **Applied rollback NOT TESTED**:
there was nothing to restore. Execution policy was not changed. The equivalent direct script-text
invocation, suitable without changing the current policy, is:

```powershell
$rollbackDir = 'C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\outputs\host-ysedu-network-enablement-20261009'
$rollbackBody = [scriptblock]::Create([IO.File]::ReadAllText((Join-Path $rollbackDir 'Restore-YseduNetwork.ps1')))
& $rollbackBody -Snapshot (Join-Path $rollbackDir 'ORIGINAL_SETTINGS.json')
```

Only if a later authorized enablement actually changes settings, an authorized elevated operator may
append `-Apply` after reviewing the displayed diff and passing operational safety. The utility refuses
target/identity/IP-inventory/security drift; restores only the captured TCP and service configuration
through SQL WMI/service APIs; never starts Browser or changes Firewall/TLS/login/data settings; and
requires strict-TLS SQL safety before interrupting a running SQL service. The current certificate failure
would stop that applying path too: it is **not** a bypass for the failed safety gate. On success it reports
`RESTORATION_ATTEMPTED`, not full recovery. Rerun the non-applying comparison, check listeners/services,
then verify database states against the pre-restart SQL baseline before claiming rollback complete.

## Narrow network plan evaluated, not executed

The existing adapter pins `server:DESKTOP-8QRQT7R` with `instanceName:YSEDU`. The hostname resolves to
non-loopback local addresses. Loopback-only listening would not satisfy that unchanged hostname path;
no hostname/hosts/connector change was silently substituted.

One narrow **candidate**, subject to fresh reachability and protection checks after safety clears:
`ListenOnAllIPs=false`, enable only existing TCP node**IP4 /192.168.56.1**, keep the other15 disabled,
use that node's dynamic-port configuration and discover the actual port after restart. The address exists
on InterfaceIndex21, **VirtualBox Host-Only Ethernet Adapter**, Up. This is a single host-only interface,
**not** loopback isolation; attached virtual peers still matter. Several captured SQL IP nodes contain
stale addresses relative to current interfaces, so they must not be enabled/copied blindly. No listening
address or port was changed in this task.

For the unchanged named-instance route, Browser discovery is needed rather than a guessed1433 port.
Browser is a shared UDP1434 service, not a supported per-YSEDU/loopback-only listener demonstrated here.
If eventually used, Manual startup would avoid unnecessary automatic activation, and reachability must
remain bounded. No unsupported binding hack or service activation was attempted. An explicit-port
alternative would be a separately reviewed connector/profile decision, not an automatic workaround.
See [Microsoft SQL Browser behavior](https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/sql-server-browser-service-database-engine-and-ssas?view=sql-server-ver17)
and [per-IP TCP properties/restart requirements](https://learn.microsoft.com/en-us/sql/tools/configuration-manager/tcp-ip-properties-ip-addresses-tab?view=sql-server-ver17).

Initial broad Firewall port-filter enumeration raised access denied; its partial output was not treated
as complete. A later targeted application-filter query succeeded:733 filters, no sqlbrowser-program
filter; after excluding package-restricted AppContainer rules, no enabled inbound Allow rule matching
Browser/general service and UDP/Any with local1434/Any was found. Enabled profiles default to inbound
Block. This is **not an exhaustive rule/range audit or remote packet test**. No Firewall opening is
currently established as necessary. If protected local discovery/listening later needs a rule or other
security change, stop and present exact program/interface/address/profile/port scope before applying it.

## Remaining gates and smallest next action

1. Obtain a current authorized **read-only operational report** through an already verified/trusted
   operator session: SQL identity, other user sessions/requests, active transactions and every database's
   state/read-only/access mode. The frozen database must be checked currently, not inferred from prior
   qualification or a Running service. Close experimental clients gracefully as necessary and recheck
   immediately before any restart; a stale report is not restart authorization.
2. If no trusted operator channel is available, separately authorize a narrowly specified certificate/
   trust investigation/remedy. Do not turn this error into authorization to install certificates,
   disable verification or change encryption policy. No specific certificate remedy is proven yet.
3. After safety evidence exists, the already authorized YSEDU network scope can proceed under an
   elevated operator, with fresh settings/protection checks and rollback ready. No redundant authorization
   for the same TCP/service scope is implied; any additional security change still requires approval.
4. Later network verification must prove the actual listener, SSRP and password-free Node TCP
   reachability, then post-restart database recovery. TLS qualification and secure reader handoff remain
   separate prerequisites for an explicitly authorized live connector test.

**NETWORK READY: NO. Result: BLOCKED before mutation.** No ERP Save, SQL business write, login/grant/
password change, certificate change, Firewall change, other-instance change or live connector test.
Business fingerprints were not reread because no SQL query executed; the claim is **no business-write
operation performed**, not independent byte-for-byte data verification. S2 LAB-PROVEN evidence is not
promoted; S3 remains ACCOUNTING-BLOCKED. Build repository unchanged. Existing untracked `.vscode`
preserved outside the documentation commit. STOP.
