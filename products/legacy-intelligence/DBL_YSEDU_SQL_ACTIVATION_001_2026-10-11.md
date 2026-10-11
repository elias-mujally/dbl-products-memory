# One bounded YSEDU SQL activation #001

## Decision and current evidence

Owner approved one **new** natural maintenance cycle after accepted Leaf evidence at `7fcc034`. Status: **TOOL QUALIFIED / ADMIN EXECUTION PENDING**. No new stop/start, certificate enrollment, registry change, SQL connection or import has been executed by this preparation. SQL certificate loading and actual TCP port remain **NOT TESTED / UNKNOWN**.

At `2026-10-11T23:24:49.5011124+03:00`, nonadministrative ServiceController reads observed YSEDU Running and SQLBrowser Stopped/Disabled. All new activation baseline/attempt/write/start/result markers were absent. These observations are not the fresh administrative pre-stop gate; the owner console must perform that gate immediately before the authorized stop.

The local Connector checkout is clean at `84eadfddfd064ada961e36675ceffe24e33f2f3a`; tree `51f15b2a1113fc3742559f7d76dab350fb8bb83c` equals merged PR #12 main `aa234dfbeb38ce738718957d739af348406c293a`. No Connector or Canonical changes.

## Accepted identities and retained policy

- Existing Leaf: `A51BD253B6083D0114428FCFBAD57D008CD102F5`; DER SHA256 `522C79FD31F0422D3988FB00CC4EF0A51B4042DEED72A435A6519237AC548DFE`.
- Public CA: `121CDC9857488ED95F4BC62106D7672BB0DBC6C3`; DER SHA256 `A3FBC7905425B2E8C10F3A070B8713F876B94FC42B8D1243DEAD5D0F42889472`.
- Acceptance result SHA256: `80A38357E94790A5DDE33B714BEBDAE08AC020DEF5F64E91F337244ED5DF25EB`. Existing Request was consumed by successful Windows acceptance; do not recreate it or invoke certreq again.
- Original settings SHA256: `BB3BF707DCEEDB99396BF2C598B3A0E9BF2E02E83F3FD7AE3A8DB27CF1931BD5`.
- CRL/OCSP remains **UNKNOWN**, accepted only as an explicit lab assurance gap; not GOOD, PASSED, revoked, or production-qualified. No revocation or system policy is altered here.

## Corrected forward and rollback scope

Historical rollback #002 was written before successful acceptance and can delete Leaf. It is preserved as historical evidence and **must not be used for this cycle**. The new pinned retained-certificate revision inspects the actual acceptance result's seven store views and never writes certificate stores, deletes certificates/keys, enrolls, or changes key ACLs.

Only these four YSEDU Registry32 values may be changed, with a CreateNew intent journal tied to the fresh baseline hash before each write:

| Value under YSEDU SuperSocketNetLib | Pinned original | Authorized forward |
| --- | --- | --- |
| Certificate | empty String | exact lowercase existing Leaf thumbprint |
| Tcp / ListenOnAllIPs | DWORD 1 | DWORD 0 |
| Tcp / IP4 / Enabled | DWORD 0 | DWORD 1 |
| Tcp / Enabled | DWORD 0 | DWORD 1 |

All other pinned values, TCP subkeys, startup/service settings, protocols and seven certificate-store inventories must match. In particular IP4 remains `192.168.56.1`, dynamic port `0` before start, fixed port empty; other IPs disabled. After start, only SQL's IP4 dynamic-port value matching the actual PID-owned listener may differ. IPAll or other unexplained drift is a STOP, not automatically repaired.

Rollback application is limited to exact journal-owned binding/TCP differences **while YSEDU is already stopped and before the single Start attempt marker exists**. It proves original settings and retained certificates before using the remaining one natural recovery start. It never stops or starts a service itself. After the single start budget has been consumed, no automatic rollback/second stop/start is performed; new authorization is required for further recovery. Timeout/unfinished stop does not authorize Force/Kill/Reboot.

## Owner-console procedure and gates

1. Manually open Windows PowerShell as the authorized owner administrator. The launcher verifies host, signed/pinned PS7 runtime, helper pin, and absence of fresh-cycle markers; no automatic elevation.
2. The child PS7 performs fresh administrative readonly inspection: original settings, accepted store inventories, exact public Root/Leaf DERs and current validity, existing CSP24/Machine/KeySpec1 association, unchanged key DACL with explicit SYSTEM read, LocalSystem service identity/PID/executable, Browser Stopped/Disabled, no active dependent/known experimental clients, preferred host-only address and DNS, clean merged code tree. No private-key export/signing or CA/PFX/password required.
3. Save a new nonsecret baseline. Repeat state/address/key/client checks immediately before stopping. Any unexplained drift stops before maintenance.
4. One natural YSEDU `Stop(false)` only, then wait at most120s and prove old PID exited. The installed runtime exposes the Boolean overload. It avoids the parameterless overload's dependent-service stopping behavior ([Microsoft ServiceController.Stop documentation](https://learn.microsoft.com/en-us/dotnet/api/system.serviceprocess.servicecontroller.stop?view=net-11.0-pp)). No active dependent service is permitted at preflight.
5. Journal and apply only the four writes, verify them and unchanged certificates/address/key, then one natural start with a persistent start-attempt marker recorded before calling Start; wait at most120s.
6. Require a different YSEDU PID with the exact executable/start time; fresh current-start ERRORLOG lines for that PID, the exact Leaf loaded for encryption, readiness, and no self-generated fallback. Within the bounded startup observation require exactly one TCP listener owned by that PID at `192.168.56.1`; discover its real port, never assume1433.
7. Recheck settings/stores/key/address/Browser/PID/listener and original evidence pins. Output actual result JSON and STOP. No Node/TLS probe, credential request, SQL login, ERP data read or import follows this helper.

Output artifacts use `YSEDU_SQL_ACTIVATION_001_*` in the existing task output directory and CreateNew writes. Preserve them on any failure. Do not repeat the launcher, manually restart SQL, or invoke historical maintenance scripts if it fails.

## Tool qualification and limits

43 pure guard/source tests passed. Tests cover strict four-target allowlist and DWORD typing, exact dynamic-port scope, protected Root/Leaf/Request store identities, fresh vs stale/wrong PID/wrong Leaf/duplicate/fallback ERRORLOG evidence, actual Start-Once function with a throwing in-memory service proving the consumed one-start budget, actual Write-Owned function with a throwing registry double proving write-intent/recovery accounting, single stop/start callsites and pre-start rollback limits. No native operational body was run.

Helper `-CheckOnly` returned `SQL_ACTIVATION_SOURCE_PINS_PASSED`; launcher `-CheckOnly` returned `SQL_ACTIVATION_LAUNCHER_PINS_PARSE_PASSED`. These checks do not prove SYSTEM effective private-key use, SQL2014 certificate loading, native rollback application, actual administrative comparison or listener qualification. Those remain pending actual execution. Public-source review copies are byte-identical to local executable tools.

| Source | SHA256 |
| --- | --- |
| Retained-cert rollback #002 revision | `BCEE15DACD346B4E6EB6C53F78965C3D9FCC0346AA540FD69FAE8FDF0751E92B` |
| Invoke-YseduSqlActivation001.ps1 | `9B6C1AFD4E7F6F6ECF7232D726EEEE4B6BEA46F2803AA04A79AB9D0AE1237DCF` |
| Test-YseduSqlActivation001.ps1 | `CC66957B00D9CA489ECE563917FDF92355B6DE229A3FF3FC7C53C22EA9F65308` |
| Start-YseduSqlActivation001.ps1 | `490A9F45F488904E6C90ADFDF366772A11901281205D384A302EF4495EB2A74D` |

No `.vscode`, PFX, private key, password, SQL contents or raw key-security descriptor is included. E: and the CA password are not needed: this step uses the already accepted certificates and existing machine key. Archive work remains paused, S3 remains accounting-blocked. Await the actual administrator result; do not record activation or FIRST LIVE DATA as passed from tests.
