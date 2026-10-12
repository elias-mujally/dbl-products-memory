# Clipboard-free handoff synthetic implementation #001

Owner approved synthetic-only implementation of design `2d5ec74`. **Overall SYNTHETIC HANDOFF = PENDING OWNER INTERACTION**, not PASSED at this record. No Reader password was generated/changed, no SQL connection, no FIRST LIVE DATA, no Connector/Canonical/source/TLS change. Old rotation helpers remain unmodified and unactivated.

## Implemented boundary

Three new local files in `outputs/host-first-live-data-001-20261010`, preserving previous evidence: one independent WinForms source, one bounded test harness and one pinned visible-console launcher. The only candidate is a fixed public 48-character token embedded in source; no CSPRNG, SQL, Bitwarden API/CLI, vault export or credential integration exists. Native imports are display-affinity/DWM, monotonic tick count, session notifications and SendMessage to fixture-owned controls. No clipboard API calls or inspection/clearing/seeding. Transfer-message tests intercept WM_COPY/WM_CUT/WM_PASTE before forwarding to native edit controls; they do not put/read data in the system clipboard.

Default display is blank/masked. Reveal requires the owner's readiness checkbox, actual `WDA_EXCLUDEFROMCAPTURE=0x11` setup/readback and DWM, and is checked again while visible. An owner-drawn nonselectable panel carries no public-token Text/accessibility value. Masked verification input rejects six transfer shortcuts, four direct transfer/context-menu messages and drop, without clipboard access. Temporary display memory is cleared; no full process/GPU/managed-memory erasure guarantee. Same-user attackers can still inspect processes; Bitwarden's separate reveal window is not protected by the helper.

Reveal:90 seconds; cumulative visible budget:180 seconds; entire dialog:300 seconds. Hide keeps the same token; ordinary focus change preserves transcription usability. Saved permanently disables reveal and enters retrieval; owner must attest save/close/reopen and manually type the retrieved token. Exactly one exact-length, case-sensitive in-memory fixed-time byte comparison, no normalization, payload log or payload hash. Mismatch/cancel/expiry is terminal. Native session lock/disconnect/logoff/suspend notifications stop; late timers recheck monotonic deadlines. Session registration is released against the original HWND before its destruction, not a newly created handle; cleanup failure prevents success.

## Executed evidence

At `2026-10-12T14:16:14.5742672+03:00`, final-source automated run returned `SYNTHETIC_CLIPBOARD_FREE_AUTOMATED_PASSED`: **41 checks**, including:

- Fixed public length48, masked default, rejection before Saved and failure of a simulated capture-qualification input.
- Explicit hide, permanently disabled post-Saved reveal, required save/reopen attestation, exact match and second-submission rejection.
- One-character mismatch, case difference, empty/short/leading/trailing-space and non-ASCII entries stop without retry.
- Injected-clock 90-second reveal, 180-second total visibility, five-minute deadline rechecked on Verify, delayed-timer expiry and backwards-clock STOP. These are deterministic deadline tests, not five minutes of real waiting.
- Cancel terminal state; four actual native transfer/context-menu messages delivered only to our fixture TextBox, six transfer shortcuts driven through its command handler, masked/no-drop/no-shortcut settings, accessible-value suppression, input and display clearing.
- Simulated native lock and suspend messages on our unpublished fixture Form. No real workstation lock, disconnect or power operation.

The first automated result at `14:13:58.5348659+03:00` also passed41 checks, then source review identified the need to release session registration using the original HWND before handle destruction and to recheck capture affinity while visible. This was a bounded resource/capture correction before owner UI execution. Its result was preserved unchanged as `READER_CLIPBOARD_FREE_SYNTHETIC_001_AUTOMATED_PRE_HANDLE_RELEASE_FIX.json`, SHA256 `233ADCFDCE4852EC88D6F529AE2FF60067414A005DFD9FA10603E6AF9FAD9CF1`. Repeating automated checks was required because the source changed; no real attempt was retried.

At `2026-10-12T14:16:20.4746560+03:00`, a normal owner-context/STA blank top-level window passed the same native Set/Get display-affinity and DWM gate used by the UI, plus real session-notification registration and release: `SYNTHETIC_CAPTURE_API_PREFLIGHT_PASSED`, `CleanupPassed=true`. No token was drawn and no screenshot was taken. This is API readiness, **not empirical screenshot-exclusion evidence**. [Microsoft scope/limitations](https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-setwindowdisplayaffinity), [readback](https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-getwindowdisplayaffinity), [monotonic time](https://learn.microsoft.com/en-us/windows/win32/api/sysinfoapi/nf-sysinfoapi-gettickcount64).

Launcher runtime/signature/source/evidence pins and child parsing passed without launching in CheckOnly. Owner was then explicitly asked to prepare a clearly labelled public synthetic Bitwarden item, type the public readiness token into the console, manually save/close/reopen and type the saved value into masked verification. Approved visible console was opened as existing owner (no UAC/impersonation) with PID90312. Launching it proves no actual Bitwarden save, retrieval match or final cleanup. Five-minute dialog deadline begins when its instance is constructed after owner readiness, not while waiting at the public console prompt. Any STOP is terminal; no automatic retry.

## Artifact identity

| Local artifact | SHA256 |
| --- | --- |
| ReaderClipboardFreeSynthetic001.cs | `CE62BD22097D63D42525BBF7E8E9F3D6120175C86CE0E3CCC51D7C6656A00A86` |
| Test-ReaderClipboardFreeSynthetic001.ps1 | `A01B873E38CC20CF6E5CA196EF5E499A132835F4D0A42E5D98A6655B41A159C0` |
| Start-ReaderClipboardFreeSynthetic001.ps1 | `4B8FD3C981B8E4522C1CAF5F95BE712780E5A38C3BE4CF2B83731FBF772F2F9C` |
| READER_CLIPBOARD_FREE_SYNTHETIC_001_AUTOMATED.json | `A2600B978873214E792307A5584518AC30A923D718067D6B337CE2D8DE4162DF` |
| READER_CLIPBOARD_FREE_SYNTHETIC_001_CAPTURE_PREFLIGHT.json | `80D3139859CC840996E874106890F7885F77E1C812C19488BF907A776D9138C5` |

Fresh hashes of `Invoke-ReaderRotation001.ps1` (`C686603B...`), `Start-ReaderRotation001.ps1` (`46142F1A...`) and the prior clipboard source (`9C6626E9...`) matched their existing evidence. No new source pin was installed in either real helper. Previous source/results and the pending historical real-rotation evidence were not overwritten.

## Pending and explicit limits

Await final `READER_CLIPBOARD_FREE_SYNTHETIC_001_RESULT.json` and owner's report. Qualify overall synthetic success only if matching automated evidence, actual dialog affinity/session qualification, owner save/close/reopen attestation, exact manual retrieval match and actual dialog cleanup all pass. No independent vault inspection is performed: matching input plus owner attestation cannot prove where the value came from or independent-device vault recovery.

Actual Bitwarden flow, interactive Hide/focus/minimize behavior and interactive transfer-key attempts are pending. Actual screenshot exclusion, real lock/disconnect/suspend and real-duration timeout wait are NOT TESTED; their API/simulated/injected-clock coverage is separately identified. A simulated capture failure is not an induced Windows policy failure. No real secret can be inferred from these public-fixture tests. No screen capture of a real credential is authorized. Later real-handoff integration requires separate approval; no automatic SQL rotation or FIRST LIVE DATA. `.vscode` remains outside commit.

## Actual first dialog outcome and owner-requested reopening

Owner reported running out of five minutes and explicitly requested reopening with clearer instructions. The actual result at `2026-10-12T14:25:03.1193682+03:00` is **`SYNTHETIC_HANDOFF_BLOCKED_STOP / RetrievalMismatch`**, not `DeadlineExpired`. It records actual capture-affinity qualification, session registration and cleanup passed, owner save/close/reopen attestation true, two reveals and one unsuccessful verification. Four transfer shortcuts were actually intercepted during interaction; no transfer messages or clipboard APIs were used. The input itself was neither logged nor inspected. A timing misunderstanding or transcription cause cannot be inferred from these flags.

The result was preserved without overwrite or byte change at `READER_CLIPBOARD_FREE_SYNTHETIC_001_MISMATCH_20261012T142503_RESULT.json`, SHA256 `FF3577A29E3EA5D3E653B170FB492148324520D7556F3F5E5E2EB2A21E914321`. The result proves the modal test returned; prior PID90312 still exists only at the final public console prompt and the owner was told to close it normally, not rerun a command or kill a process. No password or SQL action occurred.

Unchanged launcher/source/evidence pins and CheckOnly passed. A fresh synthetic-only console PID105768 was opened at the owner's explicit request after preservation; this is not an automatic failed-write retry. No time limit was extended: owner can prepare Bitwarden before entering the public readiness token, then has five minutes after dialog construction, 90 seconds per reveal and 180 seconds total reveal budget. Expanded instructions distinguish manual transcription into Bitwarden Password, Save, irreversible Saved/hide, closing/reopening the vault item, manually typing its retrieved value into the masked helper input and only then Verify once. No copy/paste, no real credential and no payload sent to chat. New overall result remains **PENDING**, not PASSED. No automated vectors were repeated; no source/helper pins or real rotation integration changed.
