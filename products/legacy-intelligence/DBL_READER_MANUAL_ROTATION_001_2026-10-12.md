# Reader credential rotation #001 — clipboard-free real integration

## Authority and current decision

Owner explicitly approved one existing-reader password rotation after the qualified synthetic handoff at `8eb7175`. Target is only `DBL_HOST_W11_S2_Reader_20261009` on `DESKTOP-8QRQT7R\YSEDU`; database is `DBL_HOST_W11_EFA12026_PostS2_Frozen_20261009`. Owner accepted bounded local visual exposure and independently accessible Bitwarden custody. No clipboard or Bitwarden API, service/network/TLS/trust/ACL/policy/grant change, replacement reader or FIRST LIVE DATA is authorized here.

**Latest completed attempt: BLOCKED on handoff deadline; no password-changing RPC was attempted.** On October13 the owner separately approved the proposed timing remedy and a new bounded handoff. Its timing qualification and fresh administrative preparation passed; actual new handoff/rotation/reader login remain pending. Preparation success is not rotation success.

## Bounded implementation review

New independent sources preserve all old tools and failed/cancelled artifacts. The old real tool was not repinned or executed. New public records have the prefix `READER_MANUAL_ROTATION_001_`; CreateNew writes and launcher absence checks prevent overwrites/automatic retries. The old password-attempt marker must also be absent.

The qualified UI was adapted to accept the existing generator's candidate instead of its fixed public fixture. No generator, database, vault or persistence code is in the UI. It retains masked default, owner-drawn display without accessible text payload, display-affinity API/readback and session registration, 90-second reveal / 180-second total visibility / five-minute handoff, permanent display-buffer clearing at Saved, one masked exact-match verification, transfer-key/native-message blocking, interruption/cancellation/timeout STOP and resource disposal. Successful manually retrieved input is transferred once as a read-only SecureString for reader login; mutable comparison/display buffers are cleared. Generalization is covered by distinct public candidate tests, not by creating a real credential during qualification.

Before generation: ordinary approved owner SID/STA/local session, unredirected console, known transcription/profiling/secret-log environment checks, actual blank capture API probe and fresh trusted administrative SQL metadata gates. Actual secret display repeats capture checks. After match: dialog disposal must pass, then the public final-consent token, then another unchanged-identity/policy/port prewrite refresh. No secret is entered at a console prompt.

Source comparison against the old approved tool passed: `FreshPreflight`, `PolicyFingerprint`, `Builder`, 36-byte cryptographic RNG/Base64 48-character generator and complexity check, parameterized `sys.sp_password` RPC declarations, reader metadata query and rights assertions are unchanged. One RPC is allowed, with an attempt marker written before invocation; no password-policy/role/grant options or business statements. Strict encryption, hostname validation, no certificate bypass, observed direct port, disabled pooling/retries and separate SqlCredential remain. Unknown runtime exceptions are converted to fixed safe error identifiers, never raw secret-bearing messages. Parameter/resource cleanup is required. Failed or ambiguous write has no automatic retry or reset to an unknown prior password.

## Actual preparation evidence

- Public-only CheckOnly passed **43** state/transfer/resource/shape checks, including different expected candidates and SecureString ownership, plus strict admin/reader connection-builder assertions. No SQL, real generator, real dialog or clipboard call occurred in that mode. Timeout/session negative vectors use injected clocks/messages, not actual elapsed duration/session interruption.
- Actual owner-context, STA read-only preflight at `2026-10-12T14:50:17.7922715+03:00`: `MANUAL_ROTATION_READONLY_PREFLIGHT_PASSED`. Observed direct port **52952**; trusted integrated SQL identity matched the current approved Windows SID. Frozen database10 ONLINE / READ_ONLY / TRUSTWORTHY=false / chaining=false. Existing reader enabled, SQL_LOGIN, policy and expiration both true, same default database; last modification `2026-10-09T08:17:00.370`. **23 exact historical grants**, no expanded roles or permissions. Known custom SQL capture absent; default trace inventory retained. Actual blank capture-affinity/session registration/readback/release passed. No reader login or credential generation/change in this preflight.
- Static comparison returned `MANUAL_ADAPTATION_SQL_GENERATOR_BOUNDARIES_UNCHANGED`: three functions, generator, RPC parameter types, reader metadata query and assertion identical. This proves source boundaries, not actual rotation success.
- New launcher CheckOnly returned `MANUAL_ROTATION_LAUNCHER_PINS_PARSE_PASSED`, no child or credential generation. An initial invocation used the wrong relative directory and never found the file; corrected absolute-path CheckOnly passed. No real attempt was initiated by either check.

Current successful synthetic source/result identities were verified against `8eb7175`; all original reader and synthetic evidence was preserved. No Connector or Canonical modification, business-data read/write or SQL service mutation.

## Local source pins

Files are in the existing local `outputs/host-first-live-data-001-20261010` directory, not secret-bearing project artifacts. Hashes below identify source/public evidence only; **no password-derived hash is computed or published**.

| File | SHA256 |
| --- | --- |
| ReaderManualHandoff001.cs | `B0BF5EF737B60CDAC441F32EC3BB8838B33AD238E604FE6D2DA0FBE1B3C69925` |
| Invoke-ReaderManualRotation001.ps1 | `6367F0325C86D69F8A3DF927FAE63957F43BBB6E44C92DAD1917F333D3C5CFA1` |
| Start-ReaderManualRotation001.ps1 | `E1A81276DD5F2CBEC7A0E7C3B0470D9D2143B4E78879D008ECCB0D4DA82032BC` |
| Read-ReaderRotationPreflight001.ps1, unchanged | `8A0582C67E9AD2999961DC0F644016C2F06233E4369B5F55F518B42A56C7716A` |
| Qualified synthetic source, unchanged | `CE62BD22097D63D42525BBF7E8E9F3D6120175C86CE0E3CCC51D7C6656A00A86` |
| Qualified synthetic public result, unchanged | `4F4838C0B1197D47DD20F312D03F423CE972ACC637BA976A613595702EE50D6D` |

## Owner execution and STOP points

1. Prepare the real reader's Bitwarden item labelled **Pending / Not Yet Applied**, not the synthetic test item. Close prior synthetic/live prompts normally. Use the local session without recording/sharing/observers. Do not send screenshots, secrets or vault contents.
2. In the new visible console, type public `READER_ROTATION_READY` only when Bitwarden is ready. Fresh administrative gates run before generation. A failed gate stops.
3. In the protected handoff, check readiness, Reveal locally, manually type the generated 48 characters into Bitwarden and Save. No copy/paste. Saved permanently hides the source display. Close the editor and reopen the saved item; manually retrieve it into the masked handoff field, attest saved/reopened/independent access, then Verify once. Mismatch/cancellation/expiry/capture/session/cleanup failure means no write and no automatic retry.
4. After exact match and UI cleanup, type public `SAVED_AND_ROTATE` in the console only if consenting to the one account-only SQL password change. This is a public control token, not the password. Fresh prewrite gates must still pass.
5. One RPC, post-policy metadata comparison and one strict reader login with metadata-only READ_ONLY/identity/rights verification. No product rows or import. Success requires all three: rotation, handoff, reader login, plus cleanup. On ambiguous/failing result keep the Bitwarden item **Pending**; do not assume its value is effective or retry. On proven success owner may remove Pending / Not Yet Applied.
6. Publish only the final nonsecret JSON. Agent must verify the locally written result without reading the vault/secret UI and document actual outcomes before STOP. No automatic FIRST LIVE DATA.

## Remaining limits

Display-affinity is not a security boundary and does not protect Bitwarden or prevent external cameras/local malicious software. No screenshot guarantee, independent vault inspection, real lock/suspend or real-duration test is claimed. Immutable managed/UI strings, process memory and paging cannot be comprehensively erased. Known capture checks do not prove absence of all compromised local software. CRL/OCSP remains UNKNOWN under the explicit accepted laboratory gap, not revocation success or production qualification. Successful rotation is not proof of business import.

## Authorized owner-console launch; outcome pending

Preparation was pushed and verified at `66e20924a6228f21b4e0b468c1ed6af98296925a`. The new hash-pinned launcher then opened one visible local owner console, PID72588, returning `OWNER_MANUAL_ROTATION_CONSOLE_STARTED_RESULT_PENDING`. No secret-bearing argument, clipboard access or SQL change was made by the launcher. Detailed manual Bitwarden instructions and the distinction between public readiness/final-consent tokens and the masked secret field were provided to the owner.

First metadata-only follow-up found the console running and new BEFORE/ATTEMPT/RESULT records all absent, consistent with waiting at public owner readiness. No secret window, vault, clipboard or process memory was inspected. **Actual handoff / rotation / reader-login outcome remains PENDING**, not PASSED; do not launch again. Only the verified final nonsecret result can change this decision. FIRST LIVE DATA remains NOT STARTED.

## Actual outcome: owner transfer timed out before SQL

Owner reported that the window closed before finishing manual transcription of the long mixed-character candidate. Local final result independently confirms `READER_MANUAL_ROTATION_BLOCKED_STOP` at `2026-10-12T15:10:35.1311678+03:00`, phase `GenerateAndManualHandoff`, fixed safe code **DeadlineExpired**. Source has a five-minute overall handoff deadline; this is not evidence of a SQL, TLS, Bitwarden or password-policy rejection. Capture API/readback and session registration succeeded, with two reveals and zero verification submissions. Actual generation occurred, but saved-item retrieval equality and final consent did not.

`RotationAttempted=false`, `PasswordChanged=false`, `AttemptOutcomeUnknown=false`; the new ATTEMPT file is absent and console PID72588 is no longer running. No new reader-login check, business-data access/change, service/TLS/trust change, clipboard operation or FIRST LIVE DATA occurred. Any candidate saved or partially entered in Bitwarden is **not the active SQL password**; keep it clearly Pending / Not Yet Applied, do not use it for SQL or disclose it. The tool no longer holds a reusable display and the agent cannot recover that candidate.

`HandoffCleanupPassed=false` is the success-path UI-cleanup flag not reached after the failed match gate; `CleanupFailures=[]` records no resource-disposal error in the final cleanup. Neither field establishes comprehensive erasure of immutable/process-memory artifacts. Likewise the false final policy comparison flag means post-rotation verification was not reached, not proof permissions changed.

Public result SHA256: `2CF97B12D869FBE4131E65E556A4370AA3030D2061B7DD3CF441DC6AE4552DD8`; BEFORE record SHA256: `56C93DECDCF97E93081F47E252B502CCFECC1C1A33DA8918E1F62B586563D81B`. These identify nonsecret result/metadata files, not passwords. All artifacts remain at their original paths without overwrites or deletion; no automatic resumption or SQL diagnostic connection.

**READER ROTATION = NOT PERFORMED; SECURE HANDOFF = BLOCKED; READER LOGIN = NOT TESTED. STOP.** Smallest proposed remedy, not implemented or authorized by this failure report: retain the generator, 48-character candidate, capture/interruption/one-shot gates and SQL logic; extend only overall manual handoff from five to ten minutes and cumulative visibility from three to six minutes (individual Reveal still 90 seconds). This increases potential visual exposure, so obtain explicit owner acceptance, test only affected public timeout vectors, preserve the failed run, and authorize a new pre-write handoff before another generated candidate. Do not silently shorten/change the generator or reopen the unchanged workflow.

## October13 owner-approved timing remedy and new run preparation

Owner answered the specific proposed remedy with permission to begin. New local `ReaderManualHandoff002.cs`, `Invoke-ReaderManualRotation002.ps1` and `Start-ReaderManualRotation002.ps1` preserve all001 sources and evidence unchanged. Their002 naming is a fresh pre-write execution record for the same account-only authorization, not authority for a second password write. Old timeout result/before hashes are pinned; old result must prove no attempt/change/ambiguity/final consent or cleanup error, old console must be absent, and every previous password-attempt marker must remain absent. New BEFORE/ATTEMPT/RESULT files use CreateNew and the002 prefix; old files are not moved, deleted or overwritten.

Only production UI changes are the approved cumulative visibility180000->360000ms, overall deadline300000->600000ms and corresponding visible instructions. Individual reveal remains90000ms. Static comparison returned `TIMING_REVISION_PRODUCTION_BOUNDARIES_PASSED`: every other production UI byte, generator, connection/preflight functions and SQL/RPC/post-policy/reader-verification logic are unchanged (except the new public run prefix). Wrapper differences are source/result pins, prior-run/no-write guards and timing-only CheckOnly selection. Neither shortened generator nor clipboard fallback was introduced.

Timing-only public qualification passed **15** assertions: exact constants, before/at90s reveal, remaining three reveals, six-minute cumulative hard cap, permanent Saved clearing at cap, successful match just before ten minutes, no failure at five minutes, deadline at600000ms, Verify cannot extend deadline, delayed overall timer fails and delayed individual tick cannot extend reveal. These use public fixed text/injected clocks, not an actual ten-minute wait, real credential, owner vault or SQL. Unchanged earlier transfer/security vectors were not rerun. Launcher pins/child parse passed without starting a child.

Fresh owner-context STA administrative read-only preparation at `2026-10-13T17:43:01.4982898+03:00` returned `MANUAL_ROTATION_READONLY_PREFLIGHT_PASSED`: observed port52952, trusted integrated identity/current Windows SID match, DB10 ONLINE/READ_ONLY, unchanged enabled SQL Reader policy/expiration/default DB and23 exact historical grants, last reader modification still `2026-10-09T08:17:00.370`. Actual blank capture API/session registration/release passed; known custom SQL capture absent. No candidate generated, password changed, reader login or FIRST LIVE DATA during preparation. Readiness and prewrite gates are refreshed again inside the actual owner execution.

| New local source | SHA256 |
| --- | --- |
| ReaderManualHandoff002.cs | `F787212B32DD068F3679235A9A22280B6F1E15EEF1C056AF1F89F2018FAE1396` |
| Invoke-ReaderManualRotation002.ps1 | `FA6796E5138A9570D6C24B89D074CC69E3D90CC8939CF9257EF2A0865B00FD4C` |
| Start-ReaderManualRotation002.ps1 | `8BFD587F861E7E2E930D6E9BE282AC3BE1F9A356646C09CB606C8BED80B09F52` |

Owner must start a complete new transcription, not continue the expired candidate. Keep the real Bitwarden item Pending / Not Yet Applied until verified rotation+reader login. Readiness token remains `READER_ROTATION_READY`; final console consent after saved-item equality remains `SAVED_AND_ROTATE`. Do not enter passwords into either console prompt or send screenshots. Ten-minute/longer cumulative display adds the explicitly accepted visual-exposure risk; all other residual limits remain. **Timing preparation PASSED; real002 outcome PENDING.** No automatic retry or FIRST LIVE DATA.

## One owner-requested002 console opened

Preparation was pushed/verified at `94ff553ed86acd2bc0593d0ae76d6e6d3df71fd0`. A concurrent non-overlapping owner roadmap-concept commit was fetched/reviewed and preserved by rebasing the unpushed documentation commit; no force push or future-concept implementation. `.vscode` remains uncommitted.

The pinned002 launcher opened one visible local owner console PID104280 and returned `OWNER_MANUAL_ROTATION_CONSOLE_STARTED_RESULT_PENDING`. Detailed new-candidate instructions and public readiness/final-consent tokens were delivered to the owner. First metadata-only status check found the console running with002 BEFORE/ATTEMPT/RESULT all absent, consistent with waiting at readiness; no password write or generated candidate is evidenced at that checkpoint. No vault/secret UI/process-memory/clipboard inspection. **Actual002 handoff, rotation and reader-login outcome remains PENDING**, not successful. Do not launch again; await final nonsecret result. FIRST LIVE DATA NOT STARTED.
