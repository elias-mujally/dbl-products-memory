# Live SQL Gate A — read-only connectivity and TLS preflight

Date: 2026-10-09. Observation session began at **17:03:49+03:00** on **DESKTOP-8QRQT7R**, operator `user`.
Decision: **BLOCKED WITH EXACT PREREQUISITES**.

Authorization: read-only Gate A after PR11 merge8c22f7b and the
[plan at Product Memory b4a45e2](MOTAKAMEL_CONNECTOR_SLICE_001_PR11_MERGE_AND_LIVE_SQL_PLAN_2026-10-09.md).
No SQL login, SQL query, TDS/TLS handshake, credential retrieval/rotation, live connector test or ERP action
was attempted. Service/registry/certificate/network observations were read-only. Only this report and
README are published. Existing untracked `.vscode` is preserved outside the commit.

## Readiness results

| Gate | Result | Current evidence |
| --- | --- | --- |
| Node Runtime Readiness | PASSED with explicitly selected Node22 | Runtime22.23.2, matching main tree/build, locked installed versions and native/module loads verified |
| Named Instance Network Readiness | BLOCKED | SQLBrowser Stopped/Disabled, TCP Enabled0, no SQL-process TCP sockets, one SSRP discovery timeout |
| SQL Certificate & Node TLS Trust Readiness | UNRESOLVED / NOT QUALIFIED | Empty configured thumbprint and empty machine My store; actual SQL certificate inaccessible; no handshake possible on the observed transport |
| Reader Credential Readiness | BLOCKED for this execution context | No supplied reader secret; prior qualification says secret was not retained/delivered; current login enabled/expiry state not inspected |
| Overall | BLOCKED WITH EXACT PREREQUISITES | Network activation, certificate/trust proof and secure reader handoff needed before an authorized live test |

## 1. Code, runtime and locked dependency evidence

Build repository: `work/dbl-legacy-intelligence`. Remote main freshly read as
**8c22f7b2a1dc251928adc9c7590b551dffddbd5e**. The existing checkout remains on the reviewed PR head
**3fd128d2b49f439f24fe19fa7e3cc1c2e8d12e6e**; `git diff HEAD origin/main` is empty. It is the same
tracked content as merged main, not a claim that the local branch label/commit changed. Worktree is clean.

Selected executable:
`C:\Users\user\Documents\Codex\2026-08-25\files-pasted-by-the-user-dbl\work\node-v22.23.2-win-x64\node.exe`.
It reports Node**v22.23.2**, OpenSSL**3.5.7**, win32/x64. The default PATH executable at
`C:\Program Files\nodejs\node.exe` reports **v24.18.0** and must not be used for this pinned qualification.
No PATH, runtime installation or global npm configuration was changed.

Package-lock version3: **153 present installed package versions matched their lock entries**, no required
nonoptional package missing; **60 absent optional packages** were classified separately, including platform
variants. This version check is not a hash audit of every installed dependency file.

| Package | Locked and installed |
| --- | --- |
| mssql | 12.7.4 |
| tedious | 20.3.3 |
| vitest | 4.1.11 |
| vite | 7.3.6 |
| source-map-js | 1.2.2 |

The production connector, ImportOrchestrator, SQLite store and Application Service modules all loaded
under Node22 without opening SQL or a local database. In-memory TypeScript compilation matched **134**
existing emitted artifacts exactly, with **zero file writes**. No install, rebuild-to-disk or test suite
was needed. Prior source qualification JSON SHA256 freshly matched
**7D742175B6652860C7974115F8A1CBB789F49D86ACAD4FC5DD40CFCE310E7BAC**; that confirms the retained evidence file,
not the current SQL login/database state.

## 2. Name resolution, instance discovery and TCP

The pinned hostname matches this physical host. Windows and Node resolvers both returned local interface
addresses for DESKTOP-8QRQT7R: IPv4 **192.168.56.1**, **192.168.43.200**, **172.17.80.1**, plus three link-local
IPv6 addresses. This proves usable local name resolution in this execution context, not an authoritative
DNS-record or remote-client test. No hosts/DNS setting was changed.

Read-only service observations:

- **MSSQL$YSEDU**: Running, Automatic, process**5072**, service identity**LocalSystem**.
- Executable: `C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.YSEDU\MSSQL\Binn\sqlservr.exe`.
- File ProductVersion**12.0.6024.0**; this is file evidence, not a newly queried SQL SERVERPROPERTY result.
- **SQLBrowser**: Stopped, Disabled, process0.

The 32-bit instance mapping at
`HKLM\SOFTWARE\WOW6432Node\Microsoft\Microsoft SQL Server\Instance Names\SQL`
maps **YSEDU → MSSQL12.YSEDU**. At the mapped SuperSocketNetLib/Tcp key:
**Enabled=0**, **ListenOnAllIPs=1**. IPAll shows **TcpDynamicPorts="0"**, **TcpPort=""**.
The string0 is a configuration value, not a listening port. No port1433 was guessed.

Windows socket enumeration found **no TCP connection/listener objects owned by process5072** and
**no UDP endpoint on1434**. One bounded, password-free SSRP request for **YSEDU** was sent to the hostname's
selected IPv4 **192.168.56.1:1434**; **no response within2500ms**. No retry or port scan was performed.

Thus the production `instanceName:YSEDU` discovery path is blocked. No YSEDU TCP endpoint was discovered,
so a TCP connection to a known SQL port could not be tested. The stopped Browser and disabled TCP settings
are corroborated by absent sockets; the UDP timeout alone is not attributed to Firewall. No firewall rule
inspection/change was needed to establish these earlier blockers. Other SQL protocols may still explain
the prior SqlClient evidence; prior successful local access does not prove Tedious TCP readiness.

The driver documentation explicitly requires named-instance Browser discovery/UDP1434 for instanceName.
See [Tedious connection options](https://tediousjs.github.io/tedious/api-connection.html).

## 3. Certificate, encryption and trust evidence

Mapped instance SuperSocketNetLib values: **Certificate=""**, **ForceEncryption=0**.
No configured certificate thumbprint was exposed. This does not prove plaintext-only SQL: client-requested
TLS remains the adapter requirement even when server-wide ForceEncryption is0. ForceEncryption need not
be changed merely to satisfy the adapter's encrypt:true policy.

Read-only enumeration of **Cert:\LocalMachine\My** returned **0 certificates**. No host/SQL subject or
server-authentication EKU candidate appeared in that store. Together with the empty binding, this leaves
no installed/bound certificate evidence for strict Node validation in the inspected configuration.

However, **the actual certificate SQL loaded/presents remains UNRESOLVED**. SQL can use a generated
certificate; configuration absence does not identify its bytes, issuer, SAN, validity or trust status.
Reading the current instance `MSSQL\Log\ERRORLOG` was denied by existing permissions. A subsequent
path-not-found message after access denial is not proof that the file is absent. Existing Application
events exposed only historical client-ready events datedSeptember1/2/9, with no current certificate
identity. No permission elevation/ACL change or alternate SQL login was used to read that log.

Node22 reports default TLS minimum**TLSv1.2**, maximum**TLSv1.3** and **145 default CA certificates**.
Presence-only checks showed NODE_OPTIONS, NODE_TLS_REJECT_UNAUTHORIZED, NODE_EXTRA_CA_CERTS,
SSL_CERT_FILE and SSL_CERT_DIR absent in this process. No trust override or secret value was printed.
This proves the inspected runtime baseline, not that SQL's unknown certificate chains to one of those CAs.
Windows trust and Node trust are not assumed equivalent.

The adapter still pins **encrypt:true / trustServerCertificate:false / tdsVersion7_4** and the existing
server/instance/reader. Microsoft documents SQL2014 SP3 TLS1.2 support, so there is a protocol compatibility
basis; no cipher negotiation or certificate validation occurred here. No TLS bypass, legacy provider,
lowered security level, certificate installation or trust-root modification was attempted.

Primary references: [Microsoft TLS1.2 support](https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/connect/tls-1-2-support-microsoft-sql-server),
[certificate requirements](https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/certificate-requirements?view=sql-server-ver17),
[Node22.23.2 TLS/CA documentation](https://nodejs.org/download/release/v22.23.2/docs/api/tls.html).

## 4. Reader state and credential boundary

Reader remains the pinned **DBL_HOST_W11_S2_Reader_20261009**, database
**DBL_HOST_W11_EFA12026_PostS2_Frozen_20261009**, Item**DBL_P001_ITEM_A**.
Retained qualification proves this reader existed and passed least-privilege tests at that earlier
observation; the secret was generated in memory and not persisted/delivered. The qualification artifact
is unchanged. **Current login existence/enabled status, policy/expiry/lockout, current grants and frozen
DB status were not queried**, because this task supplies no reader secret and excludes a live SQL test.
Do not turn prior evidence into confirmation of current account health.

DBL_MOTAKAMEL_READER_PASSWORD and DBL_MOTAKAMEL_LIVE_TEST were absent from the inspected process environment.
No credential store/repository/password hash was searched, no password was guessed and no login attempt
occurred. An operator may possess a secret outside this task; that is unknown, not claimed impossible.
If no current secret is available, a separately authorized operator must rotate **this reader only** and
inject it safely into the future process/passwordProvider. Rotation, Login changes and grant changes were
not authorized or executed. No sysadmin/FMMA substitute connection was used.

## Exact blockers, unknowns and smallest next actions

| Evidence classification | Prerequisite | Smallest next action; not executed |
| --- | --- | --- |
| Confirmed blocker | YSEDU TCP disabled; no SQL-process TCP endpoint | Separate authorization for the operator to enable TCP for this instance and schedule any required SQL-service restart; verify the actual listening endpoint afterward. No automatic firewall rule or broad exposure. |
| Confirmed blocker | SQLBrowser Disabled/Stopped; SSRP unavailable | For the current instanceName contract, separately authorize enabling/starting SQLBrowser with bounded reachability. A fixed-port alternative needs an explicit reviewed adapter/profile decision and still requires TCP; it is not an automatic workaround. |
| Confirmed execution caveat | Default Node is24 | Invoke the verified Node22 executable explicitly; no global runtime/PATH change needed. Runtime gate otherwise passed. |
| Confirmed evidence gap; actual certificate unresolved | No bound thumbprint or machine My certificate; protected ERRORLOG inaccessible | Operator obtains only the startup certificate/listener lines via an authorized read-only log inspection. Establish actual public certificate, validity/SAN/EKU/issuer chain. If unsuitable/generated-untrusted, request separate approval for narrow certificate binding and Node trust setup; never disable validation. |
| Confirmed credential gap for this task | No supplied reader secret | Secure operator handoff if available; otherwise separate authorization for reader-only rotation, followed by in-memory injection. Verify current login status through an authorized read-only operator report, without using that operator as the connector identity. |
| Not examined beyond absent endpoint | Actual TCP reachability, Firewall needs and TLS/cipher/chain negotiation | After authorized prerequisites exist, perform bounded read-only endpoint/certificate verification. No claim that Firewall is currently blocking and no guessed-port test. |
| Not currently queried | Reader disabled/expired/locked/grants or frozen DB changed | Obtain non-secret current-state evidence through the appropriate authorized operator; do not infer a login failure without trying the correctly supplied reader in a later approved test. |

An operator TCP/service/certificate change is a **new authorization decision**, not part of this read-only
preflight. Keep the current adapter, strict certificate validation, least-privilege identity and frozen
source scope. No immediate live test is possible through its current named-instance configuration.

**Final decision: BLOCKED WITH EXACT PREREQUISITES.** Runtime is ready with explicit Node22; network is
blocked; certificate/trust and reader handoff are not qualified. No connection/test/ERP mutation or source
business data change was performed. Controlled Zero stays PARTIAL, S3 stays ACCOUNTING-BLOCKED; no
Inventory/Purchase implementation or Canonical expansion. Publish documentation, verify remote main, STOP.
