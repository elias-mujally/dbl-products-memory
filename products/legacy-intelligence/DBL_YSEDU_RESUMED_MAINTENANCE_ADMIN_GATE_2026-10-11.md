# Resumed one bounded YSEDU maintenance — administrator gate

## Final execution result — BLOCKED / single cycle consumed / recovered

The owner executed the pinned maintenance launcher once. The returned JSON exactly
matches the local [preserved result](research/DBL_YSEDU_DIRECT_MAINTENANCE_001_RESULT_2026-10-11.json)
at **2026-10-11T20:40:55.8308270+03:00**. Local result SHA256:
`86DD4D7C3B4BED4627931CE0D10AC67BABFB59AE43447DBC9CA1ECB5AC1CB0F6`.
Attempt began20:40:51.7986736+03; attempt-file SHA256:
`3F5ACB96A5DFDC7000F8D469154885687CB0D4ED7DB7D5B7E1C642A48333F984`.
The administrative pre-stop gates passed, followed by **one normal stop and one
normal recovery start**. This consumed the authorized cycle; there is no automatic retry.

Failure was **AcceptExistingLeaf / CertreqAcceptExitZero**, exit
`-2146762486 = 0x800B010A = CERT_E_CHAINING`. A read-only invocation of the installed
Microsoft `certutil -error` independently decoded it as inability to build a
certificate chain to a trusted root authority. This is Windows enrollment acceptance,
not an observed Node TLS handshake failure, SQL2014 key-loading failure, bad Reader
password or rejection of the previously qualified isolated pinned-CA chain.
[Microsoft HRESULT meaning](https://github.com/MicrosoftDocs/win32/blob/docs/desktop-src/appxpkg/how-to-troubleshoot-app-package-signature-errors.md).
The exact missing issuer/trust-engine scope was not independently localized; no
claim that adding CurrentUser/Root alone would suffice is justified by this result.

No owned binding/TCP registry writes occurred (`RegistryChanges=0`). Verified
certificate acceptance was not reached. The helper applied **rollback#002 while SQL
was already stopped**, with result OWNED_SETTINGS_RESTORED_KEY_PRESERVED, then used
the **only** authorized normal start to recover the original configuration. No second
stop/start, new key, private-key deletion, CA unlock/reissue, Firewall/ForceEncryption
change or explicit Root/ACL import occurred. Enrollment history is not claimed to
have been restored byte-for-byte; rollback's documented limits remain applicable.

Fresh independent outside-sandbox read-only verification after recovery found:

- YSEDU Running/Auto/LocalSystem, new PID **82368**, original executable/instance.
- SQLBrowser **Stopped/Disabled/PID0**, original service path/account.
- Machine My returned no certificates; certificate binding is the original empty string.
- ForceEncryption0; TCP Enabled0 and ListenOnAllIPs1 (original TCP is disabled).
- IP4 still192.168.56.1, Enabled0, dynamic sentinel0 and empty static port.
- No TCP listening endpoint was returned for the new YSEDU PID.

The output field KeyDaclUnchanged=true refers to the successful **pre-acceptance**
key-DACL check; it is not an independent post-failure full security-descriptor replay
proof. Rollback did not modify/delete the key and reread its owned settings/trust
baseline, but a blanket five-store/enrollment/NTFS byte-identical-after claim is not
made. Historical transaction/catalog/recovery limitations remain unchanged.

Final classifications:

| Gate | Actual result |
| --- | --- |
| Administrative preflight | PASSED |
| One bounded maintenance activation | BLOCKED at Windows certificate acceptance |
| Recovery of original operational configuration | PASSED within rollback#002 scope; YSEDU Running |
| Correct leaf loading / approved TCP listener | NOT TESTED; forward activation not reached |
| Strict Node TLS / Reader login | NOT TESTED; no connection or password request |
| SQL → Connector → SQLite → SnapshotReader | NOT TESTED |
| FIRST LIVE DATA #001 | NOT TESTED / BLOCKED |

The owner separately confirmed the Reader password is available for a later hidden
prompt. No password was supplied, searched, guessed, recorded or used; no rotation
is required solely because it is absent from the agent session. No import/SQLite
artifact was created, and no SQL/ERP business data was queried or modified by the
maintenance helper. Normal SQL shutdown/startup can perform its ordinary engine
recovery/checkpoint operations; no claim of unchanged physical database bytes.

**STOP.** The smallest next decision is a separately authorized bounded Windows
chain-availability/trust remedy for accepting this **existing** signed leaf and CA,
not a new key/CA or TLS bypass. Current authority expressly forbids trust-store
changes and the one cycle is consumed. Any trust installation must state exact
public certificate, store/owner, additive scope and rollback before approval; do
not assume user-root sufficient or silently promote to machine-root. A further
stop/start needs new explicit authority after resolving acceptance. No additional
certreq attempt, chain-repair series or maintenance is performed here. Archive work
remains paused; S3 ACCOUNTING-BLOCKED. Source/helper/attempt evidence preserved.

The operator-preparation and initial administrator hold sections below are historical.

Preserved review copies (not alternate execution paths):
[one-cycle helper](research/DBL_YSEDU_DIRECT_MAINTENANCE_001_Invoke-YseduDirectMaintenance001.ps1),
[pinned administrative launcher](research/DBL_YSEDU_DIRECT_MAINTENANCE_001_Start-YseduDirectMaintenance001.ps1),
[non-mutating source/budget tests](research/DBL_YSEDU_DIRECT_MAINTENANCE_001_Test-YseduDirectMaintenance001.ps1).
The existing signed leaf, CSR, CA custody and rollback#002 artifacts were not edited.

## Operator update — original administrator gate resolved

The owner ran the read-only refresh at **2026-10-11T20:31:57.7934926+03:00**.
`ACTIVATION_ADMIN_READONLY_PREFLIGHT_PASSED` matches the local new JSON (SHA256
`D1F849335CFA6328B7F019A006BB5103396904B1D933F2CEF1DB3C9E114D2451`).
Baseline intact, LocalSystem/PID5072, Preferred192.168.56.1/IP4 on the Up VirtualBox
host-only adapter, original pending public key/leaf match, and key DACL fingerprint
`119EE2FB1E288527CD7128D069EC147F2C5E203DB8709B655A0B2A5FDDA2ED82`
were freshly verified. Five stores were unchanged; no certificate/service/network
mutation occurred. Static Browser policy passed, but is not packet reachability
evidence and is not needed to start Browser: Browser must stay stopped/disabled.
The initial missing-token report below is retained as history, not the current
preflight result. The agent itself remains non-administrative.

The one-cycle execution helper is now prepared for the owner's administrative
console, **execution result pending**:

| Local helper | SHA256 |
| --- | --- |
| Invoke-YseduDirectMaintenance001.ps1 | AF849B3844CF34E8F0C16F76DD6B0440CE7E056368DC604CD86F62B8DEAD7771 |
| Start-YseduDirectMaintenance001.ps1 | B759336DD3A206AAB3658F0AAA71F4C404B3BDC1354C53A5A345423617023253 |

Pins/parse CheckOnly and13 independent allowlist vectors passed. The actual Start-Once
function was tested with an in-memory failing service double: one failure consumes
the start budget; a second call is rejected. Static source contains one Stop call
site. No service or registry operation was executed by these tests. Initial test
harness scope/array-expression errors were corrected before qualification, not on
the host. These tests do not prove certreq acceptance, rollback Apply or SQL loading.

The helper refreshes baseline/client/dependent/service/address/key gates immediately
before its one normal stop (120 seconds). It accepts only the exact signed leaf
against the existing pending machine key using Microsoft-signed `certreq -accept
-machine -q` (-q suppresses dialogs only; no -f or validation override), verifies
the association and unchanged DACL/trust, and permits exactly four owned writes:
leaf binding, TCP ListenOnAllIPs0, IP4 Enabled1 and TCP Enabled1. Dynamic/static port
values are not written. The installed tool's read-only help confirmed these flags.
[Microsoft certreq acceptance](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/certreq_1).
[SQL certificate requirements](https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/certificate-requirements?view=sql-server-ver17)
remain subject to the actual SQL loading gate, not satisfied by helper syntax.

While already stopped, a setup failure may apply only pinned rollback#002, then use
the single normal start if unconsumed. A failed/consumed start never triggers a second
stop/start. Certreq timeout is STOP without killing it or racing rollback. After a
successful start, the helper requires exact leaf loading in current ERRORLOG and a
single192.168.56.1 TCP listener owned by the verified new YSEDU process, then checks
owned settings and unchanged trust/Browser state. Unexpected listeners or evidence
failure are STOP, not automatic correction. No credentials or SQL login are used.
Separate TLS, reader-secret and full live import gates remain **NOT TESTED**.

## Initial pre-handoff observation (superseded above only where stated)

Date: 2026-10-11. Fresh read-only observations and handoff recorded by17:30:51Z.
Owner explicitly authorized resuming the one bounded maintenance after PR #12 merge.
**Execution authority exists; an actual administrative execution token is still missing.**

## Verified now

- Fresh fetch: build `origin/main` remains
  `aa234dfbeb38ce738718957d739af348406c293a`. The existing local clean feature
  checkout is `84eadfddfd064ada961e36675ceffe24e33f2f3a`; its entire tree is
  identical to merged main. No reset/checkout/code change was needed.
- Actual adapter source has validated direct-port transport, no instanceName in
  direct mode, direct transient-login retries0, encrypt=true and
  trustServerCertificate=false. No fallback to SQLBrowser is authorized.
- Sandbox token was `DESKTOP-8QRQT7R\CodexSandboxOffline`, not administrative.
  A separately permitted outside-sandbox **read-only** command ran as
  `DESKTOP-8QRQT7R\user`, also **Elevated=false**. Outside-sandbox access is not
  Windows administrator elevation; no RunAs/UAC bypass was attempted.
- That command observed MSSQL$YSEDU Running/Auto/LocalSystem, PID5072, at the
  original YSEDU executable path. SQLBrowser remains Stopped/Disabled/PID0 at
  its original executable path. No GL/inv/pr/RepDes/SSMS/sqlcmd process was
  returned by the bounded name check; this is not SQL session/transaction proof.
- `192.168.56.1` remains present on the host, prefix24, interface alias Ethernet2
  (localized). This limited observation is not fresh administrative proof of
  adapter description, IP4 registry binding, all network settings or listener ownership.
- Exact local file hashes still match the qualified evidence:

| File | SHA256 |
| --- | --- |
| Read-YseduActivationReadiness001.ps1 | 1D5F4407B3EDF64D1A44427F14F91CAD3661216D9593CD49A3E9AC83072C68A5 |
| Restore-YseduLeafNetwork002.ps1 | 3F1E4FEF5BB3FF0845014E4893155FE9A13059D7F593C6F1DA9066FCD1059D87 |
| YSEDU_LEAF_MAINTENANCE_ORIGINAL.json | BB3BF707DCEEDB99396BF2C598B3A0E9BF2E02E83F3FD7AE3A8DB27CF1931BD5 |
| YSEDU_LEAF_SIGNING_001_RESULT.json | 756917FF89B109902D5E88CBDDC487B121C1B830B9EECAEF302DE441E6C505C4 |
| YSEDU-Leaf-Signed-001.cer | 522C79FD31F0422D3988FB00CC4EF0A51B4042DEED72A435A6519237AC548DFE |
| YSEDU_ACTIVATION_READINESS_001_RESULT.json | 82E590F881ECF7EBC34B48865F5580D0C552220BAFECE730725789C81C4AEEAE |
| YseduKeyStorageReadiness001.cs | 957DC651000AB683D2F679CF8ED844864BB4A075C0DDC2FF469598524D2E3784 |

Prior certificates/keys/security qualifications are retained, not rerun or promoted
to current SQL loading evidence. Full original-registry/key-DACL/admin preflight
has **not** been performed in this resumption yet.

## Minimal operator handoff

The owner must manually open an administrative Windows PowerShell console.
A small local wrapper `Start-YseduResumedAdminPreflight001.ps1` was prepared at the
existing task output directory. SHA256:
`0943E09CC303E01DE63ACB707DC2BA6C995879BC50DE27A0996E9A6772818698`.

It validates the existing runtime signature/hash and original qualified readiness
helper hash, checks the actual administrator token, and launches that helper in
fresh PowerShell7. The only in-memory helper substitution is the single output
filename: `YSEDU_RESUMED_ADMIN_PREFLIGHT_001_RESULT.json`. CreateNew/no-overwrite
and every original read-only guard remain intact. Historical evidence is not removed
or replaced. The original helper's static Browser/Firewall reads do not start Browser
or perform discovery; runtime exposure is not a prerequisite in direct-port mode.

Launcher pins/child-command parse CheckOnly passed, without launching a child or
executing administrative checks. The new result file was absent at handoff.
This is not a fresh administrative PASS or a maintenance execution tool. No password
is requested, no CA/PFX is opened, no certificate is accepted, and no service stops.
Do not rerun the old readiness launcher: its historical output already exists.
Failure is STOP, not permission to erase evidence or rerun automatically.

## Current result and next gates

- SQL Maintenance: **NOT STARTED — BLOCKED AT ACTUAL ADMINISTRATOR GATE**.
- Stop/start counts this resumption: **0/0**; authorized cycle not consumed.
- Certificate acceptance/binding, TCP activation and rollback Apply: **NOT EXECUTED**.
- SQLBrowser: **remained Stopped/Disabled**; no SSRP/discovery.
- Strict live Node TLS: **NOT TESTED**.
- Reader credential: **UNCONFIRMED**; no secret search, guessing, rotation or login.
- FIRST LIVE DATA #001: **NOT TESTED**.

Await the operator's fresh JSON before proceeding. If it passes, compare it with
the qualified baseline, then execute only the authorized one-cycle direct-port
procedure with rollback#002 while already stopped if needed. Refresh stop-sensitive
conditions immediately before interruption; no old report substitutes for that.
No second stop/start, Firewall/ForceEncryption/trust/ACL change or Browser startup.
Unknown drift is STOP. Missing reader password later requires separate reader-only
rotation approval, not an administrative Connector identity.

No host mutation, SQL connection, source-data read/write, ERP action, archive work,
Canonical/connector expansion or S3 occurred in this round. Existing recovery risk
acceptance is retained without claiming SQL restore success. `.vscode` excluded.
**STOP at the missing execution prerequisite; preserve owner authorization.**
