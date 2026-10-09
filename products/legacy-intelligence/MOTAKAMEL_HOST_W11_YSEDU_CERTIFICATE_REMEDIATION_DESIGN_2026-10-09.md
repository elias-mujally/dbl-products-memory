# YSEDU Certificate Remediation Design & Qualification — design only

Date:2026-10-09. Host **DESKTOP-8QRQT7R**, experimental Motakamel/DBL use only.
Authority: design/theoretical qualification following [maintenance evidence at26a3180](MOTAKAMEL_HOST_W11_TRUSTED_LOCAL_SQL_MAINTENANCE_PREFLIGHT_2026-10-09.md).
**DESIGN COMPLETE — OWNER DECISIONS REQUIRED; NO CERTIFICATE / TLS / HOST CHANGE EXECUTED.**
This is a conditional deployment design, not SQL/Windows/Node live qualification or permission to execute.

## 1. Existing issuer investigation and limitations

Read-only observations at **19:41:22+03:00**, retained as dated evidence rather than current restart proof:

| Observation | Evidence / meaning |
| --- | --- |
| Computer / enrollment |WORKGROUP, PartOfDomain=false, DomainRole0; machine/user Cryptography PolicyServers keys absent; no local CertSvc service |
| Machine Personal |LocalMachine/My0 certificates |
| Operator Personal |CurrentUser/My4 certificates; no CA=true candidate; none identifies the SQL host |
| Trust inventories |LocalMachine/Root49; CurrentUser/Root49; machine intermediate CA5; user intermediate CA11. Counts may include inherited/shared visibility, not49 independent user-installed roots |
| Local issuing authority |No CA=true certificate with an associated private key was demonstrated in inspected stores; no configured enrollment channel found |
| Existing hostname certificate |Root-store leaf FCEB8D98C83523546C5C8B4509A277C14C585875: subject=issuer CN=DESKTOP-8QRQT7R, RSA2048/SHA256, no SAN/CA extension, end date3025-12-30; associated key metadata present, ownership/use/provider not qualified |

The hostname certificate is **not a demonstrated issuing CA** and is not a suitable certificate to copy,
repurpose or use as a signer. Its private key was not opened/exported or used. Its trust-store presence
does not establish SQL2014 compatibility, consent to reuse or a safe lifetime. Leave it and the unrelated
operator certificates untouched.

Conclusion: **NO SUITABLE EXISTING ISSUER DEMONSTRATED**, not proof that no external/private issuer exists.
If the owner supplies an approved private-CA enrollment route with authority to issue this internal name,
prefer it after verifying the policy/template/key profile. Public roots installed on Windows are trust
anchors, not available signing credentials. A publicly trusted web-PKI certificate is not the default
solution for this unchanged single-label internal hostname; see [CA/Browser Forum internal-name rules](https://cabforum.org/working-groups/server/internal-names/).
No domain/hostname/DNS migration is proposed.

## 2. Option comparison and recommendation

| Option | Mutation / administration surface | Decision |
| --- | --- | --- |
| Owner-provided existing private issuer |One dedicated SQL leaf and key/binding; distribute only required public chain; existing client trust may suffice but exclusive Node trust still needs configuration |Preferred if a suitable available issuer is actually supplied; currently unproven |
| Dedicated DBL laboratory CA |One offline signing authority and one SQL leaf; bounded public trust distribution and key custody/expiry/removal responsibilities |**Recommended conditional design with currently demonstrated evidence**; no AD CS service or general PKI deployment |
| Dedicated self-signed SQL leaf |One server key/certificate, direct leaf trust and renewal/pinning consequences |Possible narrower issuance surface, but not selected; CA/leaf separation gives clearer renewal and trust ownership; not a production trust claim |
| Reuse current SQL fallback / existing hostname Root leaf |Reuses unknown/unsuitable key identity or weak/name-mismatched certificate |Rejected for this design; no unrelated certificate modification |

Recommendation is a **lab-only** root→leaf chain, not a generic DBL connector/security abstraction.
No intermediate CA or additional server certificates unless a proved requirement changes the plan.
Proposed descriptive CA name: `DBL YSEDU Laboratory CA 2026`; it is a proposal, not an issued identity.

## 3. Certificate/key specifications — proposed, not generated

| Property | Root CA design | YSEDU server leaf design |
| --- | --- | --- |
| Purpose |Sign this lab's SQL server certificate only |TLS server authentication for the pinned YSEDU host |
| Subject |CN=DBL YSEDU Laboratory CA 2026 |CN=DESKTOP-8QRQT7R |
| SAN |Not a server identity |DNS:DESKTOP-8QRQT7R only; no YSEDU instance suffix, wildcard, guessed FQDN, IP or localhost SAN |
| Basic Constraints |Critical CA=true, pathLen=0 |CA=false |
| Key usage |Critical keyCertSign,cRLSign |DigitalSignature,KeyEncipherment |
| EKU |Issuance policy restricted to this lab/server purpose |Explicit Server Authentication1.3.6.1.5.5.7.3.1, not Client Authentication/code signing |
| Algorithms |RSA3072, SHA256 RSA PKCS#1 v1.5 certificate signature |RSA2048 minimum, SHA256 RSA PKCS#1 v1.5 certificate signature; no SHA1/RSA1024/ECDSA/PSS default substitution |
| Lifetime proposal |2 years, offline renewal/revocation ownership |180 days, within issuer lifetime; rotation reminder/manual ownership before expiry |
| Key provider |Approved offline signing tooling; no SQL CSP requirement for CA key |Legacy **Microsoft RSA SChannel Cryptographic Provider**, **KeySpec=1 / AT_KEYEXCHANGE**, machine keyset, not CNG/KSP KeySpec0 or signature-only KeySpec2 |
| Key export policy |Offline encrypted recovery copy under owner custody if approved |Generate on host as non-exportable where the issuance workflow permits; retain in machine provider, no plaintext/PFX in workspace |

The legacy provider and Enhanced RSA/AES provider are installed as registry-listed providers; **key creation,
CSR generation/import and actual SQL loading were not exercised**. The issuer signs the issued certificate
with SHA256; that is distinct from the leaf key provider/CSR workflow. A compatible SHA256-capable issuance
workflow and resulting KeySpec/provider must be demonstrated before installation; do not silently weaken
signatures, switch to a KSP or bypass a tool failure. The certificate name/lifetime/algorithms above are
design choices for owner approval, not defaults observed in an Add form.

SQL executable version is12.0.6024.0, consistent with the established SQL2014 SP3 profile. TLS1.2 has a
documented support basis; no protocol/cipher negotiation is proven by this design. The hostname/domain
observations show no DNS suffix, so no fabricated FQDN is used. [SQL certificate requirements](https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/certificate-requirements?view=sql-server-ver17),
[legacy provider](https://learn.microsoft.com/en-us/windows/win32/seccrypto/microsoft-rsa-schannel-cryptographic-provider)
and [SQL TLS1.2 support](https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/connect/tls-1-2-support-microsoft-sql-server)
are the compatibility basis, not a guarantee of this host's future handshake.

Root pathLen=0 prevents intermediate CAs, **not** certificates for other names. Lab-only issuance is also
a custody/policy constraint; do not claim cryptographic DNS name containment. If such containment is
required, independently qualify critical name constraints with both clients before adopting them; no
untested constraint or extra CA is added to this minimum design.

## 4. YSEDU-only installation and binding design

Future separately authorized steps:

1. Capture the exact live instance mapping, certificate value/absence, ForceEncryption/HideInstance,
   certificate-store/public-chain inventories and the specific new key object's ACL before changes.
2. Prepare/import the **new leaf with its key** into LocalMachine/My. No unrelated Root/Personal entry
   is replaced. Preserve new thumbprint, serial, DER SHA256, validity and provider/KeySpec evidence.
3. Current SQL service is **LocalSystem**. Check its existing access to the **specific new key**; if
   sufficient, add no ACL. Otherwise narrowly authorize SYSTEM read on that key only through Manage
   Private Keys. No directory-wide MachineKeys ACL, account change or Everybody/Users grant.
4. Use existing **C:\Windows\SysWOW64\SQLServerManager12.msc** → SQL Server Network Configuration →
   Protocols for **YSEDU** → Properties → Certificate. Select only the newly qualified thumbprint.
   The mapped target is the32-bit `MSSQL12.YSEDU` SuperSocketNetLib Certificate property. Verify the
   selected instance/path and exact thumbprint rather than writing both registry views/all instances.
   If the old UI rejects the certificate, STOP; no unreviewed registry workaround.
5. Leave ForceEncryption=0, HideInstance=0, TCP disabled and Browser stopped/disabled. Client-required
   encryption remains mandatory; no server-wide encryption-policy or network activation bundled here.
6. Apply by a separately approved graceful SQL-service stop/start in the maintenance window below.
   Import/binding can affect the next service start; installation alone is not a live certificate proof.

Do not automatically add the CA to LocalMachine/Root for server installation. Direct root→leaf supplies
the server leaf while clients receive the explicitly approved root. **Actual SQL2014 import/selection/
loading without machine-wide root trust remains an acceptance gate**; if server-side trust is demanded
by the installed tooling/service, STOP and present that additional trust scope, not a silent fallback.
The practical installer/key ACL effect is local-machine scoped even though only YSEDU is bound.

[Microsoft's pre-2019 installation/binding procedure](https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/configure-sql-server-encryption?view=sql-server-ver16)
is the procedure reference. No certificate or key was installed and no UI action was taken here.

## 5. Windows and Node trust — do not conflate limited addition with exclusive trust

### Windows native maintenance

Proposed **conditional** minimum addition: only the lab's **public root** in the selected maintenance
operator's CurrentUser/Root; no private CA key, no machine-wide Root addition, no new Windows account.
Use Windows authentication with the existing authorized operator and explicit Encrypt=true /
TrustServerCertificate=false or installed sqlcmd `-E -N` without `-C`. Confirm this particular installed
Schannel/ODBC/.NET channel honors the user root and validates name/chain; it is **NOT TESTED**.
If it requires machine-wide trust instead, STOP for a new decision.

Important boundary: native sqlcmd/System.Data.SqlClient do not expose a demonstrated per-connection
CA-only allowlist here. User-root addition affects other applications under that user, and inherited
machine/system roots remain eligible. It is **limited trust-store mutation, NOT exclusive YSEDU/DBL-CA
trust**. Do not remove/block system roots or install a global Schannel policy to fake exclusivity.
[Microsoft's client chain/trust description](https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/connect/error-message-when-you-connect)
does not establish a CA-only mode for these existing tools.

To honor the requirement literally **without reliance on the system-root set**, this Windows-native
option is **NOT QUALIFIED** and is not approved by this design alone. Owner must either explicitly
accept its user-wide/additive scope for maintenance only, or retain the block pending a separately
reviewed Windows maintenance client with exclusive custom-root validation and suitable operator
authentication. A Node process running on Windows can have exclusive CA trust, but the current DBL
reader lacks maintenance DMVs and Tedious does not automatically reuse the Windows token: no account
substitution, credential extraction or rights expansion is proposed to bridge that gap.

### Node22 / current DBL adapter

Observed runtime22.23.2/OpenSSL3.5.7 has default TLS minimum1.2 and both `tls.setDefaultCACertificates`
and `tls.getCACertificates`; the inspected default root count was145. These were read-only API checks,
**no TLS policy was changed and no connection attempted**.

Current build tree matches merged main8c22f7b. Source `packages/connectors-motakamel-plus/src/source.ts`
pins Encrypt=true / trustServerCertificate=false / TDS7_4 / hostname / reader. It has no CA injection
argument. Installed mssql forwards driver options; Tedious20.3.3 builds a TLS context and uses hostname
verification/rejectUnauthorized when trustServerCertificate is false. No code was changed.

Narrow future test-host plan: a fresh dedicated Node22 process, reviewed preload **before any connector/
TLS context**, replaces its default CA list with the fingerprint-verified **public lab root only** using
`tls.setDefaultCACertificates([approvedRootPem])`, then invokes the unchanged adapter and current import
path. Verify the resulting default list against the approved public certificate, and prohibit workers/
additional TLS consumers in that harness. This is process/thread scoped; it must be reapplied in every
fresh process, and is not inherited automatically by worker threads.

This API **replaces** defaults; `NODE_EXTRA_CA_CERTS` alone only adds to them and is therefore **not** the
exclusive-trust solution. Do not use `--use-system-ca`, rejectUnauthorized=false, a hostname callback
bypass, OpenSSL security-level downgrade or `encrypt:'strict'`/TDS8 against SQL2014. TLS1.2/TDS7_4 with
strict certificate/name validation is the intended meaning of strict here. Node does not automatically
provide a full CRL/OCSP revocation policy; short validity, manual removal and explicit incident revocation
ownership remain necessary, not a claimed production PKI guarantee.

A per-connection `cryptoCredentialsDetails.ca` path could isolate trust more narrowly but needs a
separately authorized adapter change and tests; not implemented or smuggled into this infrastructure task.
[Node22 CA APIs](https://nodejs.org/download/release/v22.23.2/docs/api/tls.html#tlssetdefaultcacertificatescerts)
are a theoretical basis, **not** a successful exclusive-trust TLS/SQL test. Network and secure-reader
credential gates remain separately blocked/unqualified.

## 6. Private-key custody and rollback

- CA signing key remains offline under the named owner's custody; no CertSvc/online signing endpoint,
  no CA private key on the SQL service account, no signing key in Git/PM/workspace/chat/environment logs.
- Generate leaf key in the selected machine CSP where practical; owner records key-container ownership
  privately. Export is not required for rollback to the current empty binding. If encrypted PFX recovery
  is separately approved, protect its password out of band and store outside OneDrive/Git/research; never
  publish it. No encrypted recovery file or password was created in this task.
- Publish only public DER/PEM identifiers, hashes and non-sensitive settings. Preserve every preexisting
  certificate/ACL/trust entry; deletion targets must be the exact newly recorded thumbprints/objects.
- Rollback: in the approved maintenance window restore YSEDU's prior **empty certificate binding** and
  unchanged flags; graceful restart if required; verify recovery. The old fallback may return, so rollback
  restores prior operation **without** promising strict maintenance access or Node readiness.
- Remove only the newly added user public root if it was actually installed; restore only any explicitly
  changed key ACL; remove the new leaf/key only after unbinding and after confirming no other consumer.
  Terminate the Node test process to remove its ephemeral trust. Retain offline signing material according
  to owner decision; no broad certificate-store/key-directory cleanup.
- Earlier `Restore-YseduNetwork.ps1` intentionally **refuses certificate drift** and cannot undo this
  certificate plan. A separate certificate-specific capture/rollback procedure must be reviewed before
  any implementation; do not run network rollback as a certificate workaround. No applying rollback tested.

## 7. Maintenance bootstrapping while transactions cannot be inspected

**The service is not currently proven safe to restart.** No new SQL connection or query was attempted
in this design phase. Existing service/process observations cannot prove no transactions; the historical
sysadmin operator and frozen READ_ONLY/catalog state are not current permission/state evidence.

Future conditional sequence, requiring an explicit owner-approved experimental outage/risk decision:

1. Prefer a newly demonstrated existing strict trusted maintenance channel if available. Otherwise
   record the unresolved SQL-activity visibility and explicitly accept that uncommitted work could be
   rolled back/lost; this is a maintenance risk acceptance, not a false successful preflight.
2. Freeze new test work; close Motakamel and known SQL clients **normally**; arrange a quiet window and
   record current service/client processes twice near shutdown. They reduce risk, not prove SQL quiescence.
3. Declare the recovery point/loss window. Historical post-S2 backup at `C:\EFA\DBL_HOST_W11_EFA12026_PostS2_Frozen_20261009.bak`,
   SHA256 E63DF84D2DBB22C5ACD535DC5881D2DCF417F420665502927EBD9AD66731E572, had checksum/restore/CHECKDB proof
   at08:12–08:17, but **is not a current full-instance backup** and does not preserve later master/login/
   msdb changes or all support databases. Do not claim it alone protects the whole instance.
4. Owner chooses adequate recovery coverage before the stop: an approved current image/backup by an
   available trusted route, or explicit acceptance of the bounded known-lab recovery point. Current full
   file/database inventory and external-file paths are unresolved. No blind live MDF copying or new
   backup tool installation. Insufficient inventory/recovery budget means STOP before interruption.
5. Use a normal Service Control Manager stop, never kill sqlservr, Force stop or force-reboot. If stop
   does not complete within the planned bound, STOP/escalate; no automatic escalation. Normal shutdown
   may roll back open work and cannot certify there was none. Once fully stopped, a separately approved
   offline capture of all verified persistent instance/data/key/config files can protect the post-stop
   committed state; it cannot recover rolled-back uncommitted work or unknown omitted files.
6. Perform approved certificate/key checks and YSEDU-only binding while stopped, then start normally.
   If startup fails, retain evidence and execute the narrow configuration rollback, not a data restore.
   Restore data only under a new, explicit recovery authorization and verified coverage; no WITH REPLACE
   or automatic overwriting of the live/frozen databases.
7. After strict maintenance succeeds, inspect all database states, frozen READ_ONLY, current activity and
   authorized S2/reference evidence. Repeat activity immediately before **any subsequent** restart.
   Do not call the first bootstrap outage an ordinary preflight-passed restart retroactively.

No outage, file backup, data restore, SQL stop/start or client closure was performed here.

## 8. Acceptance gates — all execution tests pending

| Gate | Required proof / fail-closed result |
| --- | --- |
| Owner decisions |Issuer/custodian/lifetimes; Windows additive-trust acceptance **or** exclusive maintenance alternative; recovery coverage/loss window and explicit outage approval |
| Artifact qualification |New public leaf/issuer chain matches approved hash/SAN/EKU/usage/lifetime/key/provider/KeySpec; unrelated stores/ACLs unchanged. Tool incompatibility → STOP, not weaker crypto |
| Service binding |Only YSEDU changed; service has narrowly necessary key access; no machine-wide trust fallback; startup certificate identity equals approved leaf, not SSL_Self_Signed_Fallback |
| Strict Windows |If additive user trust approved, actual Encrypt=true/TrustServerCertificate=false authentication, correct host/instance and full metadata visibility; wrong-name/untrusted/expired cases rejected using isolated fixtures, never live binding swaps |
| Exclusive Node |Fresh process has only approved CA(s); TLS1.2, default hostname validation, no security-level override; positive and wrong-name/wrong-issuer/expired/weak-key negative tests with isolated fixtures; verify selected cipher/peer identity |
| TDS/network |Do not use bare tls.connect to a SQL2014 TDS port as proof; Tedious TDS prelogin/TLS must be qualified in a later authorized task after separate TCP/Browser gate |
| Recovery |All demonstrated persistent databases have expected states; frozen database READ_ONLY; authorized bounded S2/reference facts unchanged. If no full pre-catalog exists, state the limit, do not claim universal before/after equality |
| Reader/application |Separate safe secret handoff; existing least-privilege reader only; later current DBL identity/import path test separately authorized, not covered by a successful operator login |
| Rollback |Exact binding/trust/key scope reversible in approved window; expected old behavior distinguished from strict-TLS readiness; no automatic business-data restore |

**Theoretical qualification:** SQL leaf/provider specification has primary-documentation and local
capability basis; Node exclusive-CA mechanism has runtime/API and installed-driver source basis.
**NOT LIVE-QUALIFIED:** issuance/loading/cipher/Windows user trust/exclusive maintenance/Node SQL/recovery.
If the owner insists on CA-only trust for native Windows tools too, that requirement remains a **design
gap with the inspected clients**, not a silently relaxed policy or permission to build a new client.

**Owner decision requested:** choose the dedicated lab CA unless an approved existing private issuer is
supplied; choose whether native Windows's additive user-root scope is acceptable or maintain the strict
exclusive-trust block; approve key custody/lifetimes and a defined experimental outage/recovery policy.
Do not bundle approval for network, reader rotation or connector execution. A separate implementation
authorization must enumerate issuance/store/key ACL/binding/trust/restart/rollback scope before execution.

Only Product Memory report/README edits are made. Build tree unchanged; `.vscode` excluded. No certificate
or CA issuance, private-key export, trusted-root import, TLS/SQL/Windows/network change, service restart,
SQL/connector connection or business operation. **STOP before implementation.**
