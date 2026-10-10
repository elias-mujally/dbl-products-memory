# First Live Data #001 — authorized bounded lab maintenance, pre-change hold

Date: 2026-10-10, Asia/Aden (+03:00). Owner authorization follows Product Memory `1bb30a4`.

## Current decision

**MAINTENANCE AUTHORIZATION ACCEPTED; SINGLE-HOST CA EXCEPTION NOW APPROVED AND CA CUSTODY PASSED at21:32+03.** [Current custody result and fresh maintenance handoff](DBL_FIRST_LIVE_DATA_001_CA_CUSTODY_EXECUTION_GATE_2026-10-10.md). Below's approval-hold/issuer statements are historical. SQL leaf/network/service mutations remain unexecuted; fresh administrative original-settings/combined rollback gate is pending before those operations. Do not rerun CA issuance or reopen the paused archive.

**Browser firewall-policy static qualification = PASSED**, from the owner's administrative read-only result. Actual Browser activation, listener scope, SSRP/TCP, certificate issuance/loading and Node live acquisition remain **NOT TESTED**.

**FIRST LIVE DATA #001 = NOT PASSED.** No SQL→Connector→SQLite→DBL evidence yet. Recovery qualification stays **PAUSED BY OWNER**; previous evidence/files preserved, not resumed.

## Owner scope now accepted

The owner explicitly accepts the experimental outage, potential loss of uncommitted lab work and historical S2 recovery point **without waiting for the paused encrypted archive**. This resolves the former need for that specific outage/recovery-risk decision; do not ask for the same acceptance again or reinstate full-instance capture as an automatic prerequisite.

Authorized prospective actions: the previously designed lab CA/one YSEDU leaf with private CA key outside repositories/workspaces; YSEDU-only binding; TCP on one verified local address, not all interfaces; Browser only with qualified/accepted exposure and no Firewall change; one normal YSEDU stop/start with combined rollback prepared; strict Node public-CA/name validation and the existing frozen reader/import path. No ForceEncryption/other-instance/Windows-policy/business-data change.

Reader-secret rotation is **explicitly excluded**. At the credential gate, use a safely supplied current secret or stop for separate reader-only rotation approval. Archive password is unrelated.

## Current pre-change observations

At **20:16:26.7882916+03:00**, non-elevated tool inspection showed:

- YSEDU Running/Auto, PID5072, LocalSystem, expected executable.
- Browser Stopped/Disabled, LocalService, expected Shared/sqlbrowser.exe; no UDP1434 endpoint.
- The SQL Database Engine instance mapping contains only YSEDU. This is not a universal inventory of every possible SSAS/external application.
- No GL/inv/pr/RepDes/SSMS/sqlcmd process in the bounded client-name check; not proof of zero SQL sessions or transactions. The owner accepts incomplete transaction visibility; recheck near any actual shutdown.
- Domain/Private/Public Windows Firewall profiles enabled, default inbound Block/outbound Allow; active Wi-Fi Public.
- Current local IPv4 addresses include 192.168.56.1, 192.168.43.196, 172.17.80.1 and loopback. Hostname resolution returns the three non-loopback addresses and link-local IPv6. Do not reuse historical Wi-Fi192.168.43.200 or claim the unchanged hostname profile is loopback-only. Address selection still needs the exact Node resolver/listener checks before changing TCP.

Two associated sample firewall-rule reads succeeded under the non-elevated token. The complete bulk PortFilter read then returned **Access is denied**. No repeated denied bulk query or ACL/UAC change followed; a bounded administrative read-only helper was prepared.

## Owner-returned administrative Browser result

[Structured transcription](research/DBL_FIRST_LIVE_DATA_001_BROWSER_POLICY_RESULT_2026-10-10.json), not a byte-original attachment, observed **20:20:45.0647508+03:00**, operator DESKTOP-8QRQT7R\\user, Elevated=true, PID91020:

| Check | Actual result |
|---|---|
| Effective enabled inbound Allow rules |261 inspected |
| Missing port/application/service/address filter joins |None reported |
| Rules potentially permitting Browser UDP1434 |None, after protocol, port/range, executable, service and package filtering |
| Firewall profiles |All3 enabled; default inbound Block |
| Browser executable signature |Valid, Microsoft Corporation |
| Service account |LocalService; unchanged |
| SQL instance map |YSEDU only |
| Known experimental client processes |None in the bounded list |
| Browser / UDP1434 |Stopped/Disabled, no endpoint |
| YSEDU |Running/Auto, original PID5072 |
| Mutations / SQL connection |All false |

**Qualified claim: static Windows Firewall-policy exposure check only.** This is not loopback binding, an observed running socket, an external packet-reachability test, third-party-filter audit or permanently enforced exposure guarantee. Browser may listen beyond the selected SQL address; restricting YSEDU TCP does not automatically restrict Browser. Refresh the policy before activation and observe actual IPv4/IPv6 endpoints afterward. No new Allow rule, service-account change, instance hiding or access-policy workaround is permitted.

[Microsoft Browser behavior](https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/sql-server-browser-service-database-engine-and-ssas?view=sql-server-ver17) documents unauthenticated UDP1434 discovery and shared instance information. That contract does not prove actual exposure while the service is stopped. If actual activation requires broader reachability or produces exposure outside owner acceptance, STOP.

Executed local helper:
`outputs/host-first-live-data-001-20261010/Read-BrowserExposure001.ps1`.
SHA256 **0367AAB24C897A6D7964507AE4E1F0C1D8845A430D50D564115889C11AFD786B**.
[Retained source](research/DBL_FIRST_LIVE_DATA_001_BROWSER_POLICY_READONLY_2026-10-10.ps1).
PS7 and Windows PowerShell5.1.22621.6133 syntax passed before handoff, not prior elevated execution. The owner supplied the actual administrative result. No service/Firewall/certificate mutation in this helper; no credential or raw database data.

## Exact remaining handoff, not a new design project

The accepted [issuance/custody design](MOTAKAMEL_HOST_W11_YSEDU_CERTIFICATE_IMPLEMENTATION_READINESS_RECOVERY_GATE_2026-10-09.md#2-practical-custody-and-issuance-route--proposed-not-executed) requires a nominated offline signing workstation/session and protected signing-key retention outside SQL stores, Git, OneDrive and project workspaces. It expressly says that a local disk path outside Git alone is not adequate offline custody.

Latest authorization permits issuance under the previous design; it does not identify an available offline issuer or explicitly replace that custody constraint. Do not silently generate a persistent signing key on the SQL host, assume E: is reserved/protected/offline for CA storage, reuse the archive password or request a private key/password in chat.

The owner has now identified **E: for retention and no other issuing device**. This is an actual availability answer, not explicit approval to replace the offline-issuer constraint. The previously qualified E: is physically separate but exFAT and unencrypted; an attached drive is not an offline signing workstation, and file ACL protection is not assumed. No fresh disk/security inspection or write was performed for this answer.

**Proposed smallest variation — NOT EXECUTED / APPROVAL REQUIRED:** issue the dedicated CA in a bounded session on this lab host using ephemeral signing objects, retain only an explicitly AES256/SHA256-encrypted private PFX in a new owner-approved non-synchronized E: directory, and never persist the CA private key to Windows certificate stores or the project. Use a new independent CA-key password through qualified interactive no-echo input, not the archive or SQL password; the owner retains it independently. Validate encrypted export/re-import before binding or SQL interruption; keep only public CA/leaf material available to Node. The owner disconnects E: after custody verification/signing, when no authorized operation needs the drive. Qualify exact APIs and secret handling before issuance; any unsupported behavior is STOP, not weaker encryption or persistent-key fallback.

This proposal explicitly waives the separate offline issuer and second encrypted-media copy for this bounded laboratory attempt. It accepts that the host can expose the unlocked signing key during issuance, even if the retained PFX is encrypted; one E: copy cannot survive loss/corruption of that drive. Disconnecting E: later does not retroactively make issuance offline. No guaranteed memory wiping/secure deletion is claimed, no Windows network/security-policy change is proposed, and no Windows Root import is included. Keep this exception confined to the dedicated lab CA, not a production PKI policy. If accepted, the owner remains signing-key custodian and renewal/recovery decision-maker. If not accepted, STOP until an offline issuer is available.

This is the present execution hold; no issuer toolchain or key-generation experiment was started. Historical archive/recovery acceptance remains resolved and is not reopened.

An actual elevated operator will also be needed for approved machine-key/import/binding/service operations. The current agent token remains non-elevated; the successful read-only operator result does not elevate it. Prefer the narrow reviewed native/configuration methods; do not automate UAC or security dialogs.

## Resume sequence within accepted limits

After custody is resolved: prepare target-specific original settings and combined certificate/network rollback **before mutation**, qualify the one public leaf/key/provider, refresh Browser policy/client/address checks, then perform the approved one-window changes. No automatic extra restart loop: if loading/startup or rollback requires an additional stop/start beyond the accepted bounded cycle, stop and request that specific recovery action.

Node trust uses only the approved public CA in a dedicated process; no Windows Root-store addition is silently included merely because the design discussed maintenance trust. If a Windows trust addition or other unenumerated security change proves necessary, ask separately. Strict TLS validation and frozen-reader boundaries remain unchanged.

At the reader-secret gate, if unavailable, STOP for the specifically requested reader-only rotation approval. Only after actual live acquisition, committed SQLite import and exact SnapshotReader identity/name equality may FIRST LIVE DATA #001 be PASSED. No fixture/replay/admin substitute.

This round issued no CA/certificate/key, changed no TCP/binding/Firewall/service/trust/login/ERP setting, stopped no SQL service, connected to no SQL database and wrote no real business data. Existing connector/main unchanged; S2 LAB-PROVEN, S3 ACCOUNTING-BLOCKED preserved; .vscode excluded. **STOP at issuer/custody handoff.**
