# Trusted Local SQL Maintenance Preflight — blocked; presented certificate identified

Date: **2026-10-09**. Host: **DESKTOP-8QRQT7R**. Source instance: **YSEDU**.
Previous checkpoint: [network-enablement stop at526a4e8](MOTAKAMEL_HOST_W11_YSEDU_NETWORK_ENABLEMENT_2026-10-09.md).
Decision: **TRUSTED MAINTENANCE CONNECTION = BLOCKED; RESTART SAFETY = NOT VERIFIED**.

This task authorizes existing-channel discovery and strictly validated, read-only maintenance access,
not a restart, network activation, trust-store/certificate change, credential/grant change, connector
run or business operation. The source host is experimental; that does not waive the explicit safety gate.
The previous report was read at the specified Git commit, not assumed from remembered context.

## 1. Existing local channels: observed, not assumed qualified

At **19:21:54+03:00**, the operator was `DESKTOP-8QRQT7R\user`, with a non-elevated Windows token.
Process enumeration found SQL Server PID**5072** in session0, but no visible running `ssms`, `sqlcmd`,
`SQLPS` or `AzureDataStudio` process. This does **not** prove that no SQL sessions exist: application
connections, other tools and idle transactions cannot be excluded by process-name enumeration.
No existing authenticated SSMS channel was identified or used. `Invoke-Sqlcmd` was not resolved on PATH.

An already installed, unmodified maintenance tool was found:

```text
C:\Program Files (x86)\Microsoft SQL Server\Client SDK\ODBC\110\Tools\Binn\SQLCMD.EXE
Version12.0.6024.0; actual connection error identifies Microsoft ODBC Driver11 for SQL Server.
```

Its installed help identifies `-N` as requesting encryption, and `-C` as trusting the certificate without
validation. Both inspected32/64-bit SNI11.0 GeneralFlags had **Force protocol encryption=0** and
**Trust Server Certificate=0**. These are observed Native Client settings, not proof that every setting
is consumed by the ODBC driver. No configuration was modified. The invocation explicitly requested
encryption, omitted `-C`, and ultimately failed with certificate validation, so no unvalidated channel
was accepted. [Microsoft documents the sqlcmd encryption/trust options](https://learn.microsoft.com/en-us/sql/tools/sqlcmd/sqlcmd-use-utility?view=sql-server-ver15).

The prior .NET SqlClient strict-TLS failure remains historical evidence from526a4e8. It was not relabeled
as a new successful or failed SqlClient run in this task. No second provider/login was used to evade
the current certificate failure.

## 2. One bounded, strictly validated maintenance attempt

At **19:24:48.899+03:00**, exactly one connection attempt used the existing Windows identity:

```text
SQLCMD.EXE -S lpc:DESKTOP-8QRQT7R\YSEDU -E -N -d master -l 5 -t 10 -b -X1 -x -Q <read-only maintenance batch>
```

No `-C`, `-U`, `-P`, DAC, connection alias, reader password or FMMA/alternate SQL login was supplied.
Shared Memory was explicitly selected; TCP and Browser were not activated. Startup scripting was
disabled, the query was fixed rather than user-supplied SQL, and no output/credential file was requested.

The prepared batch would first check machine/instance identity, session identity, current metadata
permissions and `encrypt_option=TRUE`. It would reject insufficient VIEW SERVER STATE / VIEW ANY DATABASE
visibility, then inspect other user sessions, requests, active/session transactions, all visible
database states and the pinned frozen database's READ_ONLY flag. Offline-database visibility needs
separate confirmation; a filtered `sys.databases` result is not proof of all databases. No permission
grant was proposed/executed and existing role membership was not assumed.

The connection failed **before the batch executed**, exit code**1**:

```text
Sqlcmd: Error: Microsoft ODBC Driver 11 for SQL Server : SSL Provider: The certificate chain was issued by an authority that is not trusted.
Sqlcmd: Error: Microsoft ODBC Driver 11 for SQL Server : Client unable to establish connection.
```

There was no retry, TLS bypass or insecure provider fallback. **No SELECT ran**, so maintenance session
identity/SQL permissions, sessions/requests/transactions, all database states and current frozen READ_ONLY
status remain **NOT VERIFIED**. A Windows identity is not proof of an authenticated SQL session.

## 3. New direct diagnostic evidence: certificate in correlated Schannel event

The readable Windows System log contains **Schannel36882**, record**21217**, at
**19:24:48.9980992+03:00**, naming **SQLCMD PID84928**, immediately associated with the one explicit
YSEDU Shared Memory attempt. Its message reports an untrusted issuing authority and includes the
server certificate. Public DER bytes were decoded **in memory only**; no private key, process-memory
inspection, trust-store change, certificate import or network certificate-download was performed.

| Public certificate property | Observed value |
| --- | --- |
| Source | Binary payload of correlated Schannel36882 / record21217 |
| DER length |511 bytes |
| DER SHA256 |8C0B9912752A697A7F31297FA5D1728DB9AEBADE341D8980516A3ABD5822EB86 |
| SHA1 certificate thumbprint, identifier only |A61E47849574241A0A4C8BEC3C6A1BDC00E378EF |
| Subject / Issuer |Both `CN=SSL_Self_Signed_Fallback` |
| Validity |2026-09-09 12:16:11+03:00 through2056-09-09 12:16:11+03:00; within validity at observation |
| Public key |RSA1024 |
| Signature algorithm |sha1RSA |
| Extensions |None: no Subject Alternative Name or explicit Server Authentication EKU extension |
| Offline diagnostic chain build |False; single-element chain; `UntrustedRoot` |

The diagnostic X509 chain used **NoFlag**, disabled certificate downloads and offline revocation checking;
it was not attached to any SQL connection and did not alter TLS validation. An offline chain diagnostic
is **not** full online revocation, hostname or Node qualification. The subject/issuer equality establishes
self-issued naming; no independent cryptographic self-signature verification was performed.

This newly identifies the certificate presented to the inspected operational client. It supersedes
the earlier **actual SQL certificate UNRESOLVED** statement for this specific attempt, not for every
SQL endpoint/client. It strongly identifies SQL's fallback certificate, without claiming a successful
Node/Tedious handshake. The first failure was chain trust; no subsequent hostname/algorithm failure
was observed because connection negotiation stopped there.

The certificate does not identify `DESKTOP-8QRQT7R` in its subject or a SAN. Simply trusting this fallback
would not establish the required hostname identity; it also would not qualify its legacy key/signature
for Node. Missing EKU alone is not described as an observed driver rejection. Do not import this fallback
as a blanket workaround or suppress hostname checks.

## 4. Other bounded observations and access limits

- `LocalMachine\My` contained0 certificates. `CurrentUser\My` contained4 UUID-named certificates,
  none identifying the SQL hostname; these belong to the operator store, not a proven SQL service
  certificate channel. Unrelated public identifiers are not published here. The inspected LocalSystem
  My registry inventory path was absent; that is not an exhaustive service-store audit.
- Current SQL binding remains empty, ForceEncryption0, HideInstance0. No configuration was changed.
- ERRORLOG's selective certificate/listener read failed; a follow-up bounded read confirmed **Access
  denied**, not file absence. No ACL or elevation change was attempted.
- The recent YSEDU Application-log search yielded no matching certificate/listener messages. This does
  not cover historical startup or prove the absence of earlier events.
- CAPI2/Operational inspection was denied and explicitly requires elevated read access. It was not
  enabled or reconfigured. Schannel's already-readable public payload provided the useful evidence.
- At **19:27:00+03:00**, MSSQL$YSEDU remained Running/Automatic/PID5072; Browser remained Stopped/Disabled.
  TCP still Disabled. The earlier rollback utility ran **without Apply** and returned `Changes:[]`,
  `NO_CHANGES_TO_RESTORE`. Its original-settings/rollback hashes and artifact paths remain as in526a4e8.

## 5. Remedy options and their authorization boundaries

SQL certificate qualification requires a suitable server identity and a trusted chain, not merely an
encryption flag. For this older SQL version, plan a compatible certificate provider/KeySpec, explicit
Server Authentication usage, valid dates and SAN names covering actual client hostnames, plus service
access to the private key. [Microsoft certificate requirements](https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/certificate-requirements?view=sql-server-ver17)
provide the requirements; compatibility must be checked before any binding/restart.

| Option | When valid | Scope / impact; nothing executed |
| --- | --- | --- |
| Qualified server certificate issued by an already approved/trusted CA | An available issuer and suitable certificate are demonstrated, not assumed | Provision public/private server certificate for YSEDU, narrowly permit its service to read its key if needed, bind YSEDU only and schedule a separately approved restart. No client root addition if the issuing chain is already trusted by each actual client. Node trust must still be verified independently. |
| Dedicated experimental CA and qualified server certificate | No appropriate existing issuer is available and the operator explicitly approves a lab-only trust boundary | Adds a lab trust anchor and YSEDU server certificate/binding. Limit Windows client trust to the necessary maintenance identity where supported; use a separately reviewed process-scoped CA bundle for future Node rather than assuming Windows trust transfers. New trust/key custody/revocation/rollback responsibilities; SQL restart required for binding. |
| Client trust of the current fallback only | **Not qualified/recommended for the stated strict-hostname goal** | Would change trust without establishing the target hostname or adequate key/signature qualification; no evidence this alone can make the required connection valid. No import, bypass or test authorized. |
| Use an existing strictly validated SSMS/SqlClient channel | Only if a current channel and its certificate-validation policy are actually demonstrated | No server/trust mutation needed, but none was found. Merely opening old SSMS or showing an encrypted connection is not proof of certificate validation. |

**Recommended next authorization, before implementation:** a bounded **certificate remediation design /
qualification** for YSEDU only: choose an available approved issuer (or explicitly choose a dedicated
lab issuer), fix SAN=`DESKTOP-8QRQT7R` and any other demonstrated required names, choose SQL2014-compatible
provider/KeySpec and adequate key/signature, document certificate/key ownership and the minimum Windows/
future-Node trust scope, and produce exact install/bind/rollback steps. **STOP before issuing/installing
certificates, changing trust/binding or restarting SQL**, and obtain separate approval for that concrete plan.
This request is not implied approval for a new CA, a host-wide trusted root or a service restart.

A binding change that needs restart must address the current bootstrapping problem explicitly:
current active SQL work is not visible through a trusted channel. A future operator-approved shutdown
window and independently justified quiescence/recovery plan may be necessary; do not describe process
absence as transaction proof or recycle the older restart authorization after this unresolved gate.

## 6. Acceptance and future recheck

| Required maintenance evidence | Result |
| --- | --- |
| Existing trusted channel |NOT ESTABLISHED; installed sqlcmd failed strict validation |
| Strict connection |BLOCKED by untrusted chain |
| Authenticated session identity / metadata rights |NOT VERIFIED |
| Active user sessions / requests / transactions |NOT VERIFIED |
| All database states / frozen READ_ONLY |NOT VERIFIED |
| Presented operational certificate |IDENTIFIED from correlated public Schannel evidence |
| Safety to restart |NOT PROVEN; no restart authorized in this task |

After an approved remedy and successful strict connection, collect the operational report, then **repeat
sessions/requests/transactions and database-state checks immediately before any separately authorized
restart**. This task's service observations and failed connection are not a reusable future safety pass.
No second SQL activity check was attempted through an already-failing channel; no future restart occurred.

No SQL/Windows/ERP setting, certificate, trust store, password, login, grant, business record, TCP/Browser
state or service was modified. No connector run, S3 or data-write query. Only non-sensitive report/README
changes are published; existing `.vscode` remains excluded. S2 remains LAB-PROVEN; Live SQL Qualification
and network readiness are not promoted. **STOP pending the specific certificate-plan authorization.**
