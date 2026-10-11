# One bounded YSEDU SQL activation #001

## Decision and current evidence

**Actual execution verified: YSEDU SQL activation = PASSED; Node TLS / Reader login / FIRST LIVE DATA = NOT TESTED.** Owner-admin result at `2026-10-11T23:30:11.8936751+03:00` matches the local result artifact. One stop and one start were consumed. See [actual execution and reconciliation](#actual-execution-and-reconciliation). The preparation status below is historical, not current.

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

## Actual execution and reconciliation

The owner executed the pinned launcher from the administrator console. Actual fresh baseline at `23:30:06.372385+03:00` records the preferred VirtualBox host-only address, existing CSP24/machine/KeySpec1 association, explicit SYSTEM read and unchanged qualified key DACL, original services/settings and all seven accepted-certificate store views. It also records the incomplete transaction inventory and owner-accepted historical recovery limits; no new SQL query or recovery claim was made.

The local eight JSON artifacts were inspected. Baseline SHA256 equals the result, stop/start budget marker and all four write-intent references. The one start marker is not a recovery start. Result flags and startup evidence match the owner's returned JSON: stop=1, start=1, four registry-write attempts/four completed writes, original PID82368 → new PID101852, rollback NOT_NEEDED, no failure or cleanup failure, retained CA/Leaf and unchanged key DACL.

| Reconciled fact | Actual evidence |
| --- | --- |
| SQL certificate loading | Fresh ERRORLOG `23:30:09.83`: exact `A51BD253B6083D0114428FCFBAD57D008CD102F5` successfully loaded for encryption; no self-generated fallback |
| Process and readiness | ERRORLOG `23:30:09.20` PID101852; `23:30:09.84` ready for client connections |
| Qualified current endpoint | `192.168.56.1:52952`, sole TCP listener owned by YSEDU PID101852; dynamic, not SQLBrowser-discovered |
| Services | YSEDU Running/Auto/LocalSystem in administrative execution; Browser Stopped/Disabled throughout |
| Existing accepted certificates | Root and Leaf retained; Request remains consumed, no certreq or new enrollment |
| Prohibited mutations | Report certreq=0; no trust/key ACL/Firewall/ForceEncryption change, no SQL login/data read/import |

Registry before→after reconciliation finds **exactly five scoped deltas**: the four journal-owned writes documented above, plus IP4 TcpDynamicPorts `"0"` → `"52952"` recorded by SQL during startup. IP4 TcpPort remains empty; IPAll dynamic value remains `"0"`; every other captured value matches baseline. No unexpected scoped delta was found. This compares the captured target/value inventory, not an exhaustive audit of all Windows state.

Independent nonadministrative verification at `23:32:15.8171305+03:00` observes YSEDU Running/Automatic, Browser Stopped/Disabled, process101852 named sqlservr, and `netstat -ano -p tcp` showing only `192.168.56.1:52952 LISTENING 101852`. Direct readonly Registry32 reads independently match binding, TCP Enabled1, ListenOnAllIPs0, ForceEncryption0, and IP4 address/dynamic52952/empty fixed port. Direct public certificate reads match both approved DER hashes and Leaf HasPrivateKey=true / public CA HasPrivateKey=false; no private key was opened by this verification.

At `23:33:09.5614504+03:00`, all **four LocalMachine** Root/CA/My/Request fingerprints independently match the owner's administrative baseline. A first comparison of all seven views was invalid for the owner's CurrentUser stores: the verifier runs as `DESKTOP-8QRQT7R\CodexSandboxOffline`, not `DESKTOP-8QRQT7R\user`; sandbox CurrentUser CA/My differ and are **not comparable**. This is not evidence of owner-store mutation. Owner CurrentUser preservation is supported by the qualified administrative helper's post-start gate, not by that sandbox comparison. No store was changed or read permission altered.

Get-NetTCPConnection and independent ERRORLOG content read were Access Denied under the nonadmin verifier; process StartTime was unavailable. Netstat supplied independent listener/PID observation without a connection, while ERRORLOG and executable/start-time qualification rely on the captured owner-admin execution. These limits are explicit; no further elevation, maintenance or probe was attempted.

### Evidence provenance

Original files are preserved in `outputs/host-first-live-data-001-20261010`; public JSON review copies in `research/DBL_YSEDU_SQL_ACTIVATION_001_YSEDU_SQL_ACTIVATION_001_*.json` preserve semantic content (Git line-ending/newline normalization is not claimed byte-identical). Original SHA256:

| Artifact suffix | Original SHA256 |
| --- | --- |
| BEFORE | `AD11661B54F903EB496A4E963C470DF6D2530D6A244ADC547DDBBB4224F432E0` |
| ATTEMPT | `5000D874E3C90F782A4D1A3B0BE01943D7B1827C8C2E2461C1183B5E5DFEB613` |
| START_ATTEMPT | `7928E782F3469342B1670747850D3320D76081E36A7CC760004A5D2DD971072F` |
| WRITE_0 | `C69A7BE9406D42CC3ECDAF42A68362D0989C8A751492BC0C15D5A4DA89A130E7` |
| WRITE_1 | `A815FCF8D0A5B5953317B9C0601DCC68CC39A20464DE3942830010B43982BB53` |
| WRITE_2 | `06A0C95B176B4955A775080F9E81D08D1BCDEDBF0BBF8AF88803B71D455D6FA6` |
| WRITE_3 | `DC9E8CFD2FFBA3C2A36901F24BCA52AD0166ACDD705DDF78ADEE587F3FE1A444` |
| RESULT | `49486668DE19872EB510E9D51C59C7EE91E38570242BCBBC826EF0F42D56CF40` |

### Scope closure and next boundary

**SQL activation PASSED within the authorized lab scope.** The one-cycle budget is consumed; do not rerun this or any historical maintenance helper. Preserve the retained CA/Leaf/key. Historical rollback #002 is still prohibited; the retained-certificate revision cannot apply after the start marker, and further service recovery requires separate approval.

`52952` is the **observed dynamic port for this running PID**, not a configured fixed port or a promise after a future restart. Next separately evaluated step is Node/Tedious direct-port TLS with exact host identity `DESKTOP-8QRQT7R`, pinned public CA and strict validation, followed only if authorized by independent Reader login and the existing Item Identity import path. None was run here. CRL/OCSP remains UNKNOWN, machine-wide Root trust remains owner-approved lab-only, SQL restore remains untested, and frozen database/S2 business contents were not re-read or requalified in this task. STOP.
