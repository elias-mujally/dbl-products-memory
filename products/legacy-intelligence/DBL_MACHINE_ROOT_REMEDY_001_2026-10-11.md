# Bounded Machine Root Trust Remedy — applied once, then owned rollback

## Actual result

Owner explicitly approved the existing public laboratory CA in LocalMachine Root,
including its additive machine-wide trust scope. At **2026-10-11T21:26:03.6811736+03:00**
the owner returned the one administrative run's JSON; it matches the preserved local
result. **One ADD_NEW succeeded. Chain trust/profile passed in BOTH native Windows
engines without an additional issuer store. Revocation did not pass. The helper
removed only its newly returned certificate context and restored all six public
store inventories to their pre-operation fingerprints. No automatic retry.**

| Gate | Proven result |
| --- | --- |
| Exact public CA identity/profile and fresh absent baseline | PASSED before the add |
| One native LocalMachine Root addition / expected inherited CurrentUser Root delta | PASSED, 49→50 in each Root view; other four views unchanged |
| Machine and owner BASE + SSL chain/hostname/ServerAuth trust checks | PASSED during addition; no additional issuer or ignore flags |
| Separate cache-only revocation, chain excluding root | BLOCKED / UNKNOWN; CRYPT_E_NO_REVOCATION_CHECK |
| Overall retained-Root readiness | BLOCKED; RootRetained=false |
| Owned rollback | PASSED within six logical-store thumbprint+DER scope; 50→49 |
| YSEDU / Browser | Running/PID82368 unchanged; Browser Stopped/Disabled/PID0 |
| certreq acceptance / SQL loading / live TLS / Reader login / FIRST LIVE DATA | NOT TESTED |

This is **not a failed CA signature/profile or unsupported key conclusion**. It
demonstrates the prior Windows issuer/root gap can be resolved by this exact CA
addition, while the independently requested revocation check remains unresolved.
It does not mean any future enrollment, TLS policy or connection has passed.

## Scope, pins and pre-add gates

The agent token was non-administrative. The owner manually opened the administrative
console; the pinned launcher inherited that token into verified PowerShell7 without
RunAs/UAC bypass. The helper required host DESKTOP-8QRQT7R, exact owner user token,
administrative elevation and x64 PS7. It compiled the pinned previous native chain
reader, verified the CA and leaf signatures using public RSA only, current validity,
RSA3072 CA and exact critical BC/KU plus SKI profile.

- CA thumbprint `121CDC9857488ED95F4BC62106D7672BB0DBC6C3`.
- CA public DER `E:\DBL-Lab-CA-YSEDU-001\ca-public.cer`, SHA256
  `A3FBC7905425B2E8C10F3A070B8713F876B94FC42B8D1243DEAD5D0F42889472`.
- Existing leaf thumbprint `A51BD253B6083D0114428FCFBAD57D008CD102F5`, DER SHA256
  `522C79FD31F0422D3988FB00CC4EF0A51B4042DEED72A435A6519237AC548DFE`.

The exact CA was absent in Root/CA/My for both CurrentUser and LocalMachine before
the attempt. Public thumbprint+DER inventories and service identity/state were
saved locally with CreateNew (no overwrite), then immediately reread before add.
The attempt ledger names the owner authorization, target, certificate pin, baseline
hash, one-add limit and rollback policy. No PFX, CA/private server key or credentials
were opened. The authority does not cover leaf installation, binding or maintenance.

## Expected and actual store delta

| Logical view | Before | During add | After owned rollback |
| --- | ---: | ---: | ---: |
| CurrentUser Root | 49 | 50 | 49 |
| LocalMachine Root | 49 | 50 | 49 |
| CurrentUser CA / My | 11 / 4 | 11 / 4 | 11 / 4 |
| LocalMachine CA / My | 5 / 0 | 5 / 0 | 5 / 0 |

Root fingerprint before/final:
`D3FD496E2DE299782B5C5346FC8269C71669075C1F31D85D2FAB20DED7EC6ED9`.
Root fingerprint during add:
`7A2DFD0056B14697F9C06E2A2B65A174B684ECA846ED964E25C360B8B79605DB`.
The helper verified that the only added entry was the exact CA's thumbprint+DER,
with the expected machine Root inheritance into the user's logical Root view.
No separate CurrentUser import or CA/My addition occurred. Comparison retains
duplicate multiplicity and rejects removed/changed/unexpected entries.

The native writer opens only the existing fixed LocalMachine Root store and uses
**CERT_STORE_ADD_NEW**, which rejects an already present matching certificate;
there is no replace/use-existing/add-always disposition. It records success and
keeps the returned context for ownership-based rollback rather than searching and
deleting by Subject/thumbprint. The CA's key/pending request/leaf and the unrelated
existing self-signed root were not deletion targets. Handles were released, no
cleanup or rollback failure reported. These fingerprints do not establish a
byte-identical registry, certificate property/ACL, CRL/CTL or enrollment-history
audit; no such broader claim is made.
[Microsoft ADD_NEW and returned context](https://learn.microsoft.com/en-us/windows/win32/api/wincrypt/nf-wincrypt-certaddencodedcertificatetostore),
[delete consumes the owned context even on failure](https://learn.microsoft.com/en-us/windows/win32/api/wincrypt/nf-wincrypt-certdeletecertificatefromstore).

## Readiness and revocation — do not conflate

| Engine / check | Chain bits | BASE error | SSL error |
| --- | --- | --- | --- |
| HCCE_LOCAL_MACHINE, issuer/root/profile | 0x00000000 | 0x00000000 | 0x00000000 |
| HCCE_CURRENT_USER, issuer/root/profile | 0x00000000 | 0x00000000 | 0x00000000 |
| HCCE_LOCAL_MACHINE, cache-only revocation requested | 0x00000040 | 0x80092012 | 0x80092012 |
| HCCE_CURRENT_USER, cache-only revocation requested | 0x00000040 | 0x80092012 | 0x80092012 |

Each chain has exactly existing leaf→existing CA. Both engines used their ordinary
Windows stores, **no additional issuer store or CustomRootTrust**, ServerAuth requested
usage and SSL hostname DESKTOP-8QRQT7R. BASE/SSL ignore flags were0. No signature,
expiry, hostname, usage or root-trust error was returned in the isolated non-revocation
checks while the Root entry existed. They are not advertised as full validation
including revocation or an actual TLS handshake.

The separate calls request revocation of the chain excluding root, cache-only;
AIA/URL downloads and automatic root updates remain disabled for bounded operation.
Native certificate error bit0x40 is **REVOCATION_STATUS_UNKNOWN**, on the leaf;
the trusted root has0. Installed Microsoft `certutil -error 0x80092012` independently
decoded **CRYPT_E_NO_REVOCATION_CHECK**: unable to check revocation for the certificate.
The current result does **not** include OFFLINE_REVOCATION bit0x01000000 seen in the
earlier untrusted-root diagnosis. It is not a positive revoked status or success.
Existing pinned profiles have no CDP/AIA endpoints, but no online revocation attempt
was made and no claim about all possible future revocation evidence is justified.
No evidence proves that this check is the policy used by certreq internally or that
it will be required identically by every later client. Actual acceptance remains
untested; we did not evade this gate by retrying without it.

Failure phase **Revocation / MachineAndUserCacheOnlyRevocation / ChainPolicyNotPassed**.
The strict failure policy was stated before the operator run: unresolved revocation
is not success and triggers the authorized owned removal. The result therefore
does **not** leave machine trust installed. No user policy, certificate, CRL/OCSP
service, URL, revocation ignore flag or Windows setting was changed to force success.

## Independent verification and limits

At **2026-10-11T21:27:32.8162540+03:00**, a separate non-administrative owner-context
read found the exact CA absent in all six logical views and all fingerprints equal
to the pre-add baseline. Service path/account/PID/state/start mode matched before:
YSEDU Running/Auto/LocalSystem/PID82368; Browser Stopped/Disabled/PID0. No chain call,
root mutation or certreq retry was repeated in this independent verification.
The raw local result and baseline SHA were verified and the returned chain/revocation
matrix, zero-ignore/no-extra-issuer conditions and rollback fingerprints asserted.
Machine chain engine is not LocalSystem impersonation or SQL private-key loading.

No SQL connection/import, ERP operation, YSEDU stop/start, Browser activation,
Firewall/network/TLS-setting change, key/store ACL change or other certificate
installation occurred. Reader password was not requested. Source/helper artifacts
and earlier evidence remain preserved. Archive qualification stays paused; S3 frozen.

## Qualification of the bounded helper (not live-success evidence)

Before the owner run: native writer compiled without native store calls; PowerShell
parse and runtime/helper pins passed. Pure store-delta tests:2 positive and6 negative
vectors (missing inherited Root, extra unrelated entry, removed original, duplicate,
single-user-only delta, wrong DER). Pure chain guards:1 positive and5 negative vectors
(unknown revocation even if policy fields0, policy error, ignore flag, extra issuer,
wrong CA). Static source has one add call and one owned-remove call; no service,
network, enrollment, PFX or ACL operation. These tests do not simulate native Root
write/rollback; the actual operator result above proves this one transaction's outcome.

## Evidence pins and preserved copies

Original local artifact hashes (review copies normalize line endings):

| Artifact | SHA256 |
| --- | --- |
| MACHINE_ROOT_REMEDY_001_BEFORE.json | 2D9F518F5A9DB2A98C63ACF73C16AF3F57F83FB2CD90D160FAE7DF2DD65D4B9E |
| MACHINE_ROOT_REMEDY_001_ATTEMPT.json | D0D2AC87B93294CB7FDAC4B9A8719699E666C06B514A64F12690C50F9DFE7FB1 |
| MACHINE_ROOT_REMEDY_001_RESULT.json | 76A5DB59050B0C9697D10ED244CD8862C4B1369C62141100C01AFF69CCB275A2 |
| Invoke-MachineRootRemedy001.ps1 | 92269382E7B96C3CBFB7D9C681FE6FD11474A584A73709FF4573BF0B91A2E3AD |
| OwnedMachineRoot001.cs | 968CB5C984DF94519871BFAE20B03D7DE01108A7D8546E7CC4B3236041B62CC1 |
| Start-MachineRootRemedy001.ps1 | 37DCC44E561B55B109118F2DA456F1217FFBF5AD597B152A089DC971A1FE6594 |

[Actual result](research/DBL_MACHINE_ROOT_REMEDY_001_MACHINE_ROOT_REMEDY_001_RESULT.json),
[pre-add public metadata](research/DBL_MACHINE_ROOT_REMEDY_001_MACHINE_ROOT_REMEDY_001_BEFORE.json),
[attempt/ownership ledger](research/DBL_MACHINE_ROOT_REMEDY_001_MACHINE_ROOT_REMEDY_001_ATTEMPT.json),
[helper review copy](research/DBL_MACHINE_ROOT_REMEDY_001_Invoke-MachineRootRemedy001.ps1),
[native writer review copy](research/DBL_MACHINE_ROOT_REMEDY_001_OwnedMachineRoot001.cs),
[launcher review copy](research/DBL_MACHINE_ROOT_REMEDY_001_Start-MachineRootRemedy001.ps1).
No private certificate/key/PFX/password is included. Copies are evidence, not alternate
launch paths; original attempts cannot be repeated or overwritten automatically.

## STOP / next owner decision

**The authorized add was consumed and rolled back successfully.** Do not re-add Root,
accept Leaf, stop SQL, change the gate or create revocation infrastructure under
this task. A next decision must separate the required revocation policy/evidence
from already proven issuer/root/profile trust, without treating UNKNOWN as PASSED
or assuming certreq's exact policy. Any new import, acceptance, revocation-material
issuance/installation or maintenance needs explicit scoped authorization; no repair
or broader PKI/backup project is started here. FIRST LIVE DATA remains NOT TESTED.
