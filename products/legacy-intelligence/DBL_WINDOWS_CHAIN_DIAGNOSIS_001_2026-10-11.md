# YSEDU existing leaf — bounded Windows chain diagnosis

## Decision and authority

**DIAGNOSIS COMPLETE — issuer availability and Windows root trust gap reproduced.**
**ACTIVATION / FIRST LIVE DATA remains BLOCKED / NOT TESTED.**

Owner authorized read-only diagnosis of the acceptance failure documented at
Product Memory `6b589464c6ed7e5c93e613c75d644fe59c40ce4b`. No store import/removal,
certreq acceptance, private-key access, SQL connection, shutdown, network, ACL,
Connector or Canonical change was performed. Archive work stays paused; S3 frozen.

Fresh observation **2026-10-11T21:01:32.4269902+03:00**, host DESKTOP-8QRQT7R,
operator DESKTOP-8QRQT7R\user, **non-elevated owner token** (not sandbox account).
Native Windows `crypt32` engines HCCE_CURRENT_USER and HCCE_LOCAL_MACHINE were used.
The latter selects machine chain trust; it is **not LocalSystem impersonation**.
The old failed command was not repeated or instrumented internally.

## Public certificate relationships

| Property | Existing leaf | Existing CA |
| --- | --- | --- |
| Thumbprint | A51BD253B6083D0114428FCFBAD57D008CD102F5 | 121CDC9857488ED95F4BC62106D7672BB0DBC6C3 |
| Subject | CN=DESKTOP-8QRQT7R | CN=DBL Laboratory YSEDU CA 001 - 20261010 |
| Issuer | Exact CA Subject, including raw name bytes | Self-issued; self-signature verified |
| DER SHA256 | 522C79FD31F0422D3988FB00CC4EF0A51B4042DEED72A435A6519237AC548DFE | A3FBC7905425B2E8C10F3A070B8713F876B94FC42B8D1243DEAD5D0F42889472 |
| RSA / signature | 2048 / SHA256-RSA | 3072 / SHA256-RSA |
| Valid UTC interval | 2026-10-11 14:28:03 to 2027-04-09 14:28:03 | 2026-10-10 18:27:21 to 2028-10-10 18:32:21 |
| Basic Constraints | critical CA=false | critical CA=true, path length0 |
| KU | critical DigitalSignature + KeyEncipherment | critical CertSign + CRLSign |
| EKU / SAN | Server Authentication / DNS DESKTOP-8QRQT7R | No EKU constraint |
| SKI / AKI | Neither extension present | SKI=4C845EF2946D4B594E4F0FE15A2DCC5C6B2E0EC2; AKI absent |

Both public signatures were freshly verified directly over DER TBSCertificate with
the CA's public RSA key. Both certificates are time-valid at observation. Public
hashes match the signed/custody evidence before and after diagnosis. No PFX or
server private key was read. Existing CSR/key association remains supported by the
earlier qualified evidence, not a new private-key test here.

The CA **directly signs the leaf**; there is no intermediate in this qualified
chain. Missing leaf AKI/SKI is an observed profile detail, not the demonstrated
blocker: Windows built the exact two-element leaf→CA chain when given the public
issuer in memory. There were no signature/time/usage/basic-constraint error bits
in that non-revocation chain; the sole error was untrusted root. No reissue is
justified by the present evidence. Native SSL policy returns its trust error first;
this is not a successful TLS handshake or proof of every downstream policy check.

## Store inventory — all opened ReadOnly / OpenExistingOnly

| Location | Store | Certificates | Exact CA | Exact signed leaf |
| --- | --- | ---: | ---: | ---: |
| CurrentUser | Root | 49 | 0 | 0 |
| CurrentUser | CA | 11 | 0 | 0 |
| CurrentUser | My | 4 | 0 | 0 |
| LocalMachine | Root | 49 | 0 | 0 |
| LocalMachine | CA | 5 | 0 | 0 |
| LocalMachine | My | 0 | 0 | 0 |

Six thumbprint+DER inventory fingerprints remained identical before/after. These
are logical store views, not a registry/physical-store or enrollment-history audit.
The Root views contain an unrelated self-signed CN=DESKTOP-8QRQT7R certificate,
thumbprint FCEB8D98C83523546C5C8B4509A277C14C585875. It is not the pinned CA or leaf,
was not selected by the observed chains and must not be reused, deleted or changed.

## Native Windows result matrix

Public additional issuer uses a temporary **MEMORY** certificate store only. It
does not add a root trust anchor, use CustomRootTrust, enable peer trust, or ignore
any chain-policy error. BASE and SSL policy ignore flags were0. Requested EKU was
ServerAuth; SSL policy hostname DESKTOP-8QRQT7R. AIA, URL retrieval and automatic
root updates were disabled to keep the diagnosis bounded and non-persistent.

| Native engine | Issuer input | Elements | Chain error bits | BASE policy | SSL policy |
| --- | --- | ---: | --- | --- | --- |
| CurrentUser | Existing stores only | 1 | 0x00010000 PARTIAL_CHAIN | 0x800B010A CERT_E_CHAINING | 0x800B0109 |
| LocalMachine | Existing stores only | 1 | 0x00010000 PARTIAL_CHAIN | 0x800B010A CERT_E_CHAINING | 0x800B0109 |
| CurrentUser | Exact public CA in non-trust memory store | 2 | 0x00000020 UNTRUSTED_ROOT | 0x800B0109 | 0x800B0109 |
| LocalMachine | Exact public CA in non-trust memory store | 2 | 0x00000020 UNTRUSTED_ROOT | 0x800B0109 | 0x800B0109 |

Thus there are **two distinct missing conditions**: Windows cannot discover this
issuer from the observed store inputs, and supplying the issuer does not make it
trusted. The reproduced BASE result matches the old certreq failure. This is strong
evidence for its chain-availability/trust blocker, **not a trace proving the exact
internal chain engine or every condition certreq will require after remediation**.

A separate machine-engine cache-only revocation check, with the public issuer,
returned **0x01000060**: UNTRUSTED_ROOT + REVOCATION_STATUS_UNKNOWN + OFFLINE_REVOCATION.
The leaf has0x01000040; root0x20. No CRL/OCSP success was established. This is not a
revoked-certificate result, nor proof that revocation caused the original0x800B010A.
The four main rows intentionally isolate issuer/root validation without requesting
revocation; they are not advertised as full revocation qualification. Do not hide
these additional bits or assume a Root import cures them. If later acceptance or
the agreed strict policy requires revocation evidence, STOP at that separate gate;
no automatic revocation bypass or new PKI work is authorized.

A bounded attempt to read existing CAPI2/Operational log metadata under the owner
token was unavailable (System.Exception); it supplied no process-level trace. No
logging was enabled, elevation forced or repeated acceptance attempted. No claim
that the log is disabled, or that LocalSystem has been tested, is made.

[Microsoft chain engines/additional-store/flags](https://learn.microsoft.com/en-us/windows/win32/api/wincrypt/nf-wincrypt-certgetcertificatechain),
[trust bit meanings](https://learn.microsoft.com/en-us/windows/win32/api/wincrypt/ns-wincrypt-cert_trust_status),
[policy results and BASE/SSL](https://learn.microsoft.com/en-us/windows/win32/api/wincrypt/nf-wincrypt-certverifycertificatechainpolicy).

## Smallest proposed remedy — separate owner approval REQUIRED

**One existing public CA certificate only**, from
`E:\DBL-Lab-CA-YSEDU-001\ca-public.cer`, pinned to the CA thumbprint and full DER
SHA256 above. No private PFX, new certificate, intermediate or key is needed for
the observed missing issuer/root gap.

Recommended machine-context remedy: add that one exact public certificate to
**LocalMachine\Root**, then perform a read-only chain readiness check **while SQL
continues running**. This fills the observed issuer and root-trust gaps for the
native machine engine as well as inherited user trust, without duplicate imports
into CA/My/CurrentUser. **This is a new approval boundary:** original design's
CurrentUser Root approval is not permission for LocalMachine Root.

Its trust effect is additive and **machine-wide for all Windows users/services
using that root store, not YSEDU-only or exclusive trust**. The laboratory CA is
not name-constrained; other suitably issued certificates could be trusted within
their policies. Keep its encrypted signing key custody limits in mind. Future
Node transport must still use the pinned CA exclusively in its dedicated process,
encrypt=true and trustServerCertificate=false; Windows Root import is no permission
to broaden Node trust. [Microsoft store scope/inheritance](https://learn.microsoft.com/en-us/windows-hardware/drivers/install/local-machine-and-current-user-certificate-stores).

Alternative CurrentUser\Root has smaller user-only scope but is **not proven
sufficient for machine-context acceptance**. Putting the CA only into CA or supplying
a response bundle establishes availability, not the missing ordinary root trust.
No proof here justifies choosing those as a guaranteed remedy or weakening policy.

Proposed rollback for a Root-only change: capture fresh absence and all six store
fingerprints, record exact added DER/thumbprint and operation ownership, then remove
**only that exact added LocalMachine Root entry** if needed and compare inventories.
Never remove the unrelated existing root, the pending request, leaf/key, or CA PFX.
If the CA unexpectedly exists or any other store changes, STOP rather than deleting
by Subject or making a broad repair. No SQL/network/service rollback is needed for
this Root-only operation. Acceptance/binding rollback is a separate later scope;
the existing maintenance baseline must be explicitly reconciled with any newly
approved Root delta, not silently relaxed to allow arbitrary trust changes.

## Avoid another wasted maintenance cycle

After separate approval and exact import, **before any stop**, verify pins/profile,
ordinary native machine and owner BASE/SSL policies with **no additional issuer
store** and zero ignore flags. Require the exact leaf→CA chain and no chain errors
for the selected policy; record revocation separately and STOP on a required but
unresolved revocation condition. Use the same owner/admin enrollment context for
the final pre-stop check; machine engine is not a substitute for service key use.

Then, only if separately authorized, **one certreq acceptance while YSEDU is still
running**, followed by public-store association/profile checks, can test the actual
enrollment boundary without another stop. Acceptance changes LocalMachine My and
request association and therefore is not part of a read-only readiness test or
this authorization. No bind/TCP/restart follows without refreshed explicit scope.
If acceptance fails, retain evidence and STOP while the original service continues.
Successful acceptance would still not prove SQL2014 certificate loading, LocalSystem
key use, strict Node TLS/login or FIRST LIVE DATA. No guarantee of future success.
[Microsoft acceptance behavior](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/certreq_1).

## Evidence / unchanged operational state

YSEDU still **Running/Auto/LocalSystem/PID82368**; SQLBrowser **Stopped/Disabled/PID0**.
No SQL authentication, source-data read, import, password prompt or Reader rotation.
No change to the six stores or pinned public files; no private-key opening/PFX read.

Original local evidence SHA256 (review copies may normalize line endings):

| Artifact | SHA256 |
| --- | --- |
| WINDOWS_CHAIN_DIAGNOSIS_001_RESULT.json | 5503095912C29FA7753F895DEE96E021BF52A4B33378A012F3BCF3BF7C18BCE6 |
| Read-WindowsChain001.ps1 | 391181CE22A41367D54CED573B96A5359A2459708175225B89721CF3F358767D |
| WindowsChainReadOnly001.cs | 1E07A72C4A8E6DA06FF8B88A9E98ADCF47E550ACDD91AC0E73DF8294B998EE66 |

Preserved [public result](research/DBL_WINDOWS_CHAIN_DIAGNOSIS_001_WINDOWS_CHAIN_DIAGNOSIS_001_RESULT.json),
[read-only helper review copy](research/DBL_WINDOWS_CHAIN_DIAGNOSIS_001_Read-WindowsChain001.ps1),
[native API source review copy](research/DBL_WINDOWS_CHAIN_DIAGNOSIS_001_WindowsChainReadOnly001.cs).
Copies are evidence, not alternate launch paths. Native chain handles, temporary
non-trust memory store, public certificate objects and unmanaged allocations were
released; no cleanup failure was returned. Initial permission-review timeout did
not launch a process; its one permitted retry ran this single diagnostic round.

**STOP. Request separate approval for the exact public CA LocalMachine Root addition
and no-stop read-only readiness check; do not import or accept automatically.**
