# YSEDU — Revocation Policy Decision Review (read-only)

Date: 2026-10-11, Asia/Aden. Baseline Product Memory **fea06e401d2f739ccaa428e7d38f6a22bca17f3b**.
Status: **REVIEW COMPLETE — PROPOSED LAB POLICY, OWNER DECISION REQUIRED**.
**No policy change adopted or host operation executed. FIRST LIVE DATA #001 remains NOT TESTED.**

## 1. Decision and provenance of the retention requirement

**Recommendation:** explicitly separate one ordinary Windows acceptance test of the
existing leaf, while YSEDU remains running, from the maintenance helper's additional
revocation-success condition. Do not require new CRL/OCSP infrastructure merely to
test enrollment. This is a proposed laboratory risk decision, not proof of successful
revocation, guaranteed acceptance, or authority to change the previous tool now.

The reviewed DBL governance/product decisions and Connector contract do **not**
document a general rule that CRL/OCSP must pass before retaining this lab CA or before
every TLS connection. This is a bounded repository finding, not proof that no external
organizational policy exists. More specifically:

| Evidence | What it actually established |
| --- | --- |
| [Certificate design at 5dc9c3e](MOTAKAMEL_HOST_W11_YSEDU_CERTIFICATE_REMEDIATION_DESIGN_2026-10-09.md), lines 153–164 | Strict TLS meant certificate/name/chain validation, TLS1.2/TDS7_4, no bypass. It expressly did not claim automatic CRL/OCSP assurance; manual incident response and renewal remained owner responsibilities. |
| [Implementation readiness at dda7f90](MOTAKAMEL_HOST_W11_YSEDU_CERTIFICATE_IMPLEMENTATION_READINESS_RECOVERY_GATE_2026-10-09.md), lines 80–85 | Compromise requires withdrawal/replacement of trust, not reliance on a nonexistent automatic CRL service. |
| [Signed leaf qualification at c1500d1](DBL_YSEDU_EXISTING_CSR_LEAF_SIGNING_001_2026-10-11.md), lines 13 and 61 | Offline cryptographic profile/chain qualification explicitly excluded revocation; no live-client policy was changed. |
| [Activation readiness at 901afd0](DBL_YSEDU_ACTIVATION_READINESS_2026-10-11.md), line 80 | Revocation was NOT TESTED, not a claimed successful prerequisite. |
| Owner's Machine Root Remedy scope | Required a separate revocation result, forbade treating UNKNOWN as success or bypassing checks, and required STOP/owned rollback if gates failed. It did not establish a portfolio-wide revocation policy. |
| [Root helper recorded at fea06e4](research/DBL_MACHINE_ROOT_REMEDY_001_Invoke-MachineRootRemedy001.ps1), lines 47–51, 115, 122–136 | Added a concrete retention gate: request cache-only revocation in both engines, require chain/BASE/SSL errors all zero, reach `retained=true` only afterward; otherwise remove the owned Root entry. |

**Conclusion:** success-before-retention was a **conservative, task-specific helper
condition**, stated before owner execution and binding for that attempt. Its rollback
was correct under that declared condition. It must not be retrospectively renamed a
universal Windows/SQL/Node requirement, nor silently dropped under old authorization.
The proposed separation requires a new explicit owner policy decision. UNKNOWN stays
UNKNOWN; changing the decision threshold is a reduction in revocation assurance, not
a discovery that revocation has passed. No active DECISIONS/security policy was edited.

## 2. Three separate validation boundaries

| Boundary | Documented requirement / inspected behavior | Evidence limit |
| --- | --- | --- |
| Windows `certreq -accept -machine` | Enrollment associates the issued certificate with the existing private key/pending request in machine context. A matching request can be removed. The installed tool previously rejected the leaf with `0x800B010A`. | Microsoft's command reference does not establish our helper's two-engine cache-only revocation gate as an unconditional acceptance requirement. Exact internal policy on this Windows build was not traced. Actual acceptance after trusted-Root availability is NOT TESTED; a later attempt may still reject revocation or another condition. |
| SQL Server 2014 SP3 certificate loading | Correct store/binding, valid certificate, ServerAuth, SAN/name, legacy CSP/AT_KEYEXCHANGE and service access to the existing private key; actual loading must be verified after separately authorized maintenance. | The documented SQL certificate prerequisites do not list this helper's cache-only CRL/OCSP test as a universal loading condition. That absence is not proof that no installed component can enforce extra policy. SQL2014 loading/effective LocalSystem key use remain NOT TESTED. Enrollment success is not loading success. |
| Node22 / mssql12.7.4 / Tedious20.3.3 | The inspected direct-port adapter requires encryption, rejects untrusted certificates, verifies DESKTOP-8QRQT7R with the default hostname verifier, supplies only the pinned CA and minimum TLS1.2; TDS7_4, no Browser fallback. | These flags do not themselves provide a CRL/OCSP qualification. No real handshake/login/import has occurred. Windows Root availability is not Node CA exclusivity, and a future Node handshake is not revocation proof. |

Primary references: [Microsoft certreq acceptance](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/certreq_1#certreq--accept),
[Microsoft enrollment response restrictions](https://learn.microsoft.com/en-us/windows/win32/api/certenroll/nf-certenroll-ix509enrollment-installresponse),
[SQL certificate requirements](https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/certificate-requirements),
and [pre-2019 SQL configuration procedure](https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/configure-sql-server-encryption?view=sql-server-ver16#computers-with-sql-server-configuration-manager-for-sql-server-2017-and-earlier-versions).
The enrollment API is contextual documentation, **not a trace proving certreq uses
that exact call/flags**. AllowUntrustedRoot/AllowUntrustedCertificate, force acceptance
or equivalent bypasses are not proposed. SQL documentation spans versions; the older
procedure and existing native CSP24/KeySpec1 evidence are the applicable basis here,
not newer Configuration Manager automation or TDS8 encryption mode.

### Actual Node/driver source, not just configuration intent

Local code HEAD `84eadfddfd064ada961e36675ceffe24e33f2f3a` is the approved PR12 head;
the tree diff against locally available merged `origin/main`
`aa234dfbeb38ce738718957d739af348406c293a` is empty. No checkout/fetch/code change was
needed for this review. Locked/installed versions match mssql12.7.4/Tedious20.3.3.

- `packages/connectors-motakamel-plus/src/source.ts:100–116`: explicit port,
  `serverName`, `maxRetriesOnTransientErrors:0`, pinned `ca`, TLS1.2,
  `encrypt:true`, `trustServerCertificate:false`; no `crl` setting.
- `node_modules/mssql/lib/tedious/connection-pool.js:12–42`: driver options flow
  into Tedious configuration; no automatic revocation policy was added here.
- `node_modules/tedious/lib/message-io.js:54–78`: constructs Node's secure context
  from credentials details and calls `tls.connect` with the checked hostname and
  `rejectUnauthorized:!trustServerCertificate`; no `requestOCSP` or OCSP validator.
- [Node22 TLS API](https://nodejs.org/download/release/v22.23.2/docs/api/tls.html#tlscreatesecurecontextoptions)
  exposes CRLs explicitly; requesting OCSP is a separate option/event, not proof
  that a response was obtained or validated.
- [Pinned Node22 implementation](https://github.com/nodejs/node/blob/v22.23.2/src/crypto/crypto_context.cc#L1605-L1634)
  enables CRL_CHECK/CRL_CHECK_ALL when a supplied CRL is installed in the context.
  The current adapter supplies no CRL. Adding one later would require separate
  bounded qualification/code authorization; not a hidden Windows-policy fix.

This is **source-reviewed**, not live TLS-tested. No runtime/network probe or secret
prompt was performed. No driver flag, default hostname check, Canonical contract,
reader identity or source database was changed.

## 3. What CRL/OCSP evidence does and does not say

Pinned identities remain the existing certificates only:

- CA thumbprint `121CDC9857488ED95F4BC62106D7672BB0DBC6C3`; DER SHA256
  `A3FBC7905425B2E8C10F3A070B8713F876B94FC42B8D1243DEAD5D0F42889472`.
- Leaf thumbprint `A51BD253B6083D0114428FCFBAD57D008CD102F5`; DER SHA256
  `522C79FD31F0422D3988FB00CC4EF0A51B4042DEED72A435A6519237AC548DFE`.

The raw diagnostic extension inventories show **no CDP or AIA** in either issued
certificate. The leaf has no advertised OCSP responder; the CA's cRLSign key usage
is permission to sign CRLs, **not a signed/published CRL**. There is no intermediate
certificate in this exact leaf→root chain. Absent AKI did not prevent the proven
Windows chain; no reissue is inferred from that observation.

| Observation | Correct conclusion |
| --- | --- |
| Historical acceptance `6b58946`: `0x800B010A / CERT_E_CHAINING` | Issuer/root-chain failure observed before remediation; not proof that revocation caused that failure. |
| Earlier read-only diagnosis `dba9fe6`: added public issuer in memory, untrusted root, UNKNOWN/OFFLINE bits | Separate diagnostic input/policy state, no successful revocation evidence. |
| `fea06e4`: Root present temporarily; both native engines had exact leaf→CA, BASE/SSL/hostname errors zero, ignore flags zero | Trust/signature/profile/name check PASSED **without requesting revocation**, during the owned addition only. |
| Same attempt: revocation requested cache-only/excluding root; leaf/chain `0x40`, policies `0x80092012` in both engines | Revocation status UNKNOWN / unable to check. Neither GOOD/not-revoked nor REVOKED was established. Current row does not have the earlier OFFLINE bit. |
| Root-only rollback and six baseline-equal inventories | CA not retained; says nothing about a complete inventory of Windows CRL caches or online status services. |

The [Windows chain flags](https://learn.microsoft.com/en-us/windows/win32/api/wincrypt/nf-wincrypt-certgetcertificatechain)
make the revocation request explicit; cache-only prevents network CRL/OCSP retrieval.
No online CRL/OCSP retrieval, signed-response verification, freshness/expiry test,
revoked-leaf negative test, or Node revocation-enforcement test was performed. No
general statement that valid revocation evidence can never be supplied is justified.
Likewise, enabling downloads alone is **not** an established remedy: the certificates
advertise no such endpoints, and no suitable external responder was demonstrated.

## 4. Options — scope, security and cost

| Option | Security assurance / scope | Cost and decision |
| --- | --- | --- |
| Keep the helper's hard revocation gate unchanged | Preserves the strongest declared gate, but neither Root retention nor acceptance can progress on current evidence. No host change. | Low immediate work, indefinite block; valid if the owner requires positive revocation evidence. Do not manufacture PASSED. |
| Explicit lab-only separation of enrollment and revocation assurance | Keep chain/signature/time/EKU/hostname validation strict; preserve UNKNOWN as a recorded residual risk. One ordinary acceptance test while SQL runs, after newly authorized exact public Root addition. No global revocation setting or ignore flags. | **Recommended smallest experiment**, pending owner acceptance of the missing automated revocation protection. Does not guarantee certreq success or production readiness. |
| Existing CA signs a bounded offline CRL; qualify consumer enforcement | Could provide positive current revocation evidence if coverage/signature/issuer/freshness and actual Windows/Node consumption are demonstrated. Needs CA unlock/signing, public artifact distribution/cache decisions and renewal ownership. | Medium extra scope. Without CDP, Windows discovery must be qualified rather than assumed; supplying a Node CRL also needs explicit transport qualification. No new CA/reissued leaf automatically required or promised. Separate authorization; not implemented. |
| Reissue leaf with a qualified CDP/OCSP design and operational delivery | Adds discovery/freshness/responder lifecycle and possibly certificate replacement; a complete policy must cover actual clients and failures. | Highest cost/new PKI scope; not justified for the single lab item-read goal before testing the ordinary enrollment boundary. |

Reject TLS/hostname bypass, accepting untrusted chains, Windows-wide revocation-policy
disablement, ignoring a runtime revocation failure, guessed credentials/admin Connector,
or silent replacement of the existing certificate/key. Merely narrowing EXCLUDE_ROOT
to END_CERT cannot repair this two-element chain: the unknown status is on the leaf.

## 5. Proposed explicit lab policy — NOT ADOPTED

The owner may separately approve the following narrowly scoped decision:

> For FIRST LIVE DATA #001 on DESKTOP-8QRQT7R/YSEDU only, keep the existing
> pinned CA and leaf. Signature, trust chain, current validity, ServerAuth and
> hostname remain mandatory; encryption and default TLS validation remain strict.
> Record CRL/OCSP as UNKNOWN / NOT QUALIFIED, never PASSED or not-revoked.
> Do not make that diagnostic UNKNOWN alone a prerequisite for one ordinary
> machine-context acceptance test. Do not change Windows revocation policy or
> ignore any error produced by certreq, SQL loading or the actual Node handshake.
> Any such error is STOP. No production qualification is implied.

**Answer to the decision question:** positive additional revocation evidence is
not demonstrated to be an unconditional prerequisite for **testing acceptance**.
The test can be separated under this explicit laboratory policy, but **not under
the old consumed authorization**. Confidence is high in helper-policy provenance
and the observed chain results; confidence that the next certreq attempt will
actually succeed is deliberately limited until tested.

This does not lower identity or trust-chain checks. It explicitly accepts **less
revocation assurance** than the failed helper demanded; that security tradeoff
requires the owner's decision and must remain visible in subsequent reports.
If the owner instead requires positive revocation assurance, choose the bounded
CRL-evidence route and keep acceptance blocked until it qualifies.

## 6. Exact next authorization and STOP boundaries

Smallest proposed next execution scope, **not authorized or prepared by this review**:

1. Approve the lab policy above and its manual compromise-response responsibility.
2. Approve one new owned addition/retention of the same exact public CA to
   LocalMachine Root despite separately recorded UNKNOWN. Preserve machine-wide,
   additive trust disclosure; pin absence/DER/thumbprints and refresh ordinary
   machine/user chain/profile/name checks without additional issuer or ignore flags.
   Preserve the old attempts; a new helper/attempt would require bounded review.
3. Approve **one ordinary `certreq -accept -machine` of the existing leaf while
   YSEDU is running**, with the existing matching request/key. No force/untrusted
   flags, private-key replacement, ACL edits, binding, network change or restart.
   Capture fresh My/Request association baselines and expected deltas before it.
4. Success only proves enrollment/association: require exact DER/thumbprint, existing
   key linkage and no unapproved store/key/security delta; then STOP. Any nonzero
   certreq result or unexplained partial state is STOP, not a second attempt.
5. On failure, remove only demonstrably owned additions where safe. Acceptance can
   remove a pending request; deleting the leaf does **not** promise byte-identical
   enrollment rollback. Preserve the existing key and request evidence, do not
   recreate requests/keys or perform broad cleanup under this proposed scope.
6. SQL binding/TCP/another normal stop-start and live Connector qualification remain
   **separate future approval gates**. A historical recovery start or Root policy
   decision does not authorize a new maintenance cycle or SQL login.

### Residual risks that must not disappear from the record

- No automated positive revocation signal for a compromised/later-revoked leaf;
  current validity is not proof of uncompromised keys. Leaf expires
  **2027-04-09T14:28:03Z**; its 180-day lifetime bounds expiry, not timely revocation.
- CA Root addition affects every Windows consumer using that machine trust, not
  just YSEDU. The CA is not name-constrained; pathLen0 does not prevent another
  server certificate. Existing single-host/one encrypted E-copy custody risks remain.
- Owner must withdraw the affected lab trust and stop use upon loss/compromise,
  arrange replacement/renewal under separate authorization and review the decision
  before any production/other-host use. Manual response is not equivalent to CRL/OCSP.
- Actual certreq policy, SQL2014 loading, LocalSystem key use, safe listener,
  strict Node TLS/login and SQL→DBL import remain unproven. Missing revocation
  assurance is not permission to skip these gates or reuse the fallback certificate.

## 7. Review verification and unchanged scope

Re-read actual raw evidence and matched original SHA256 pins in this review:

| Artifact | SHA256 |
| --- | --- |
| MACHINE_ROOT_REMEDY_001_RESULT.json | 76A5DB59050B0C9697D10ED244CD8862C4B1369C62141100C01AFF69CCB275A2 |
| MACHINE_ROOT_REMEDY_001_BEFORE.json | 2D9F518F5A9DB2A98C63ACF73C16AF3F57F83FB2CD90D160FAE7DF2DD65D4B9E |
| WINDOWS_CHAIN_DIAGNOSIS_001_RESULT.json | 5503095912C29FA7753F895DEE96E021BF52A4B33378A012F3BCF3BF7C18BCE6 |
| YSEDU-Leaf-Signed-001.cer | 522C79FD31F0422D3988FB00CC4EF0A51B4042DEED72A435A6519237AC548DFE |

Also read signing result, explicit-key qualification, maintenance failure/recovery,
design/readiness reports, native chain reader and Root helper, governance/DECISIONS,
and actual Adapter/locked drivers. Source-line references identify the committed
review copies, not replacement launch instructions. Primary documentation was
checked for this review; absence of a published requirement is not an observed
internal certreq/SQL trace.

Last **proven historical state** at 21:27+03 from fea06e4: CA absent after rollback,
YSEDU Running/PID82368, Browser Stopped/Disabled. This task did not refresh native
store/service state or replay chain/crypto tests; it makes no fresh-state claim.
Only Product Memory documentation changes in this round: no certificate/store/ACL/
policy mutation, certreq invocation, SQL/Browser interruption, CA unlock/CRL creation,
Connector/Canonical change, login, ERP action or SQLite import. Prior evidence is
preserved, archive work paused, S3 frozen. `.vscode` remains outside commit.

**STOP — await an explicit owner choice and bounded execution approval.**
