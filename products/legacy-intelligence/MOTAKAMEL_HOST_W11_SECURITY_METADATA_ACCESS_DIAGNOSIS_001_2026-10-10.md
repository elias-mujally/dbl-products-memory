# Host W11 — Security Metadata Access Diagnosis #001

Date: 2026-10-10 (+03:00). Baseline: Product Memory `c85dc70`.
Owner scope: bounded read-only diagnosis and a safe read-method correction test only.

## Current decision

**BOUNDED DIAGNOSIS ROUND COMPLETE — SECURITY METADATA GATE REMAINS BLOCKED; FULL-REQUEST ROOT CAUSE UNRESOLVED.** The first denied object and failure phase are now known. The bounded full handle-based correction was tested and failed, so no qualified full-reader correction or recovery capture is claimed.

## Operator result — 19:07 +03:00

The owner returned [diagnostic JSON](research/SECURITY_METADATA_ACCESS_DIAGNOSIS_001_RESULT_2026-10-10.json), observed **2026-10-10T19:07:20.5437400+03:00**, from `DESKTOP-8QRQT7R\\user`, PID29760, `C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe`, version5.1.22621.6133. This is operator-supplied administrative evidence, not an independently witnessed privileged run. The executed local helper still matched SHA256 `341513816E3FBF2B2DD99D97A2E583A55C9BF8D22BD87FF83B28AA016C836556` when rechecked. The submitted attachment SHA256 is `3109040097ED692A21F46D3958AA3FDF244AEF68D1FE2978F28A94C33544D780`; its machine-specific user SID is omitted from the published JSON, explicitly recorded as an omission. No raw descriptor or SQL content is retained.

| Observation | Actual result |
|---|---|
| First denied object | `C:\` — approved parent-directory scope, not an identified SQL file |
| Original operation | `GetNamedSecurityInfoW`, SE_FILE_OBJECT1, BACKUP_SECURITY_INFORMATION0x00010000 |
| Original failure phase/code | QueryDescriptor / Win32=5; no descriptor returned |
| Process elevation | true before, during and after; TokenElevationType2 (full) |
| SeSecurityPrivilege | present throughout; disabled0 → enabled2 at query/failure → disabled0 after restoration |
| Other token observations | No thread token; SeBackup/SeRestore remained disabled; their presence is not established by the boolean enabled fields |
| Named Owner/Group/DACL request0x7 | Win32=0; self-relative descriptor returned |
| Named SACL request0x8 | Win32=0; self-relative descriptor returned |
| Full handle-based request0x10000 | Win32=5 at GetSecurityInfo QueryDescriptor; no descriptor returned |
| Full scope qualification | 23 persistent paths admitted by preflight; SecurityRecordCount0; Records empty |

The handle trial progressed past OpenSecurityHandle to QueryDescriptor. Given the inspected code, `CreateFileW` therefore succeeded with READ_CONTROL|ACCESS_SYSTEM_SECURITY0x01020000, OPEN_EXISTING, share7 and flags0x02200000; the subsequent full `GetSecurityInfo` request failed. This is not an open-handle denial or a successful corrected full read. The two partial controls returned descriptors but their contents, SACL presence/count and full preservation properties were not published or qualified; success must not be converted into a full security gate pass.

`PrivilegeRestoredAndObserved=true`, `PrivilegeRestoreFailure=null`, and the before/after enabled/default bits agree. The raw SeSecurity attributes were0/2/0. This proves the observed transition/restoration in this operator process, not a global privilege audit. `ServiceStatus=Running`, SourceContentsRead/SourceSecurityChanged/SqlStopped/EWrites/RealCaptureStarted allfalse. An independent non-elevated service read at **2026-10-10T19:09:38.0314272+03:00** also returned Running; it does not establish SQL transaction or database integrity state.

### Diagnosis and limits

Confirmed: the original failure is reproducible at the C: root under an elevated, non-impersonating token with SeSecurityPrivilege enabled. Basic descriptor and SACL-only reads succeed on the same object. Opening a handle with both documented query rights succeeds, yet the complete BACKUP request fails through both named and handle APIs. Missing elevation, failure to enable SeSecurityPrivilege, a general inability to query SACL, and use of a zero-access handle for this corrected query are not supported explanations for this observed failure.

The failure is localized to the full BACKUP request in this tested configuration; its deeper cause (flag/API behavior, an additional full-descriptor component/access condition, or another platform constraint) remains **UNRESOLVED**. Do not infer from the disabled backup privilege that enabling it is the proven cure. Do not diagnose corrupt SQL files, change the C: ACL, take ownership, add account rights or bypass UAC.

No safe complete correction was established: switching to an appropriately opened handle did not solve the full read. A possible narrowly scoped next candidate is explicit querying of every applicable descriptor component instead of the BACKUP aggregate flag, while retaining owner/group/DACL/audit SACL and applicable label/resource/scope/trust/filter components, inheritance/control flags, exact coverage and lossless preservation checks. This is a **proposal only**, not a tested fix or a claim that mask0xF/concatenating the two successful partial reads captures all parts. Supported flags, required rights, completeness and unsupported-component rejection must be qualified before replacing the full reader. No additional candidate, privilege expansion, repeated protected read or preservation fallback was executed after this round's STOP.

## Historical preparation at a5b0dc8

At c85dc70, the prior operator failure was `GetNamedSecurityInfoW` requested through `Descriptor`, with `BACKUP_SECURITY_INFORMATION=0x00010000`, Win32=5 and CompletedRecords=0. It omitted the failing path and effective privilege observations. The sorted parent-directory hypothesis was unresolved at preparation; the operator result above now identifies C:\ as the first failed object. It still does not identify a failed SQL file.

## Evidence collected without elevation

At 2026-10-10T17:19:30.4227417+03:00 the agent process was `DESKTOP-8QRQT7R\\user`, PID28156, non-elevated, using the bundled PowerShell7 executable. `MSSQL$YSEDU` was Running. No automatic UAC elevation was attempted.

The new diagnostic source passed PowerShell7 parsing/C# compilation and Windows PowerShell5.1.22621.6133 parsing/C# compilation. Native observation of those separate test processes showed TokenElevation=false, TokenElevationType=3 (limited), SeSecurityPrivilege absent, no thread impersonation token, and SeBackup/SeRestore disabled. No privilege was adjusted; no protected object was probed during these preparation tests.

The native `QuerySecurityAccessMask(0x10000)` returned `0x01020000` in both runtimes. This agrees with [Microsoft's BACKUP query rights](https://learn.microsoft.com/en-us/windows/win32/secauthz/security-information): READ_CONTROL plus ACCESS_SYSTEM_SECURITY. [Named reads](https://learn.microsoft.com/en-us/windows/win32/api/aclapi/nf-aclapi-getnamedsecurityinfow) require the SACL privilege enabled. [Handle reads](https://learn.microsoft.com/en-us/windows/win32/api/aclapi/nf-aclapi-getsecurityinfo) additionally require appropriate access granted when opening the handle. The original zero-access metadata handle was not passed to GetNamedSecurityInfoW, so its zero desired access alone is not a proven cause of the named API failure.

## One bounded operator round

Local helper subsequently executed by the owner:
`outputs/host-real-recovery-capture-001-20261010/Diagnose-Capture001SecurityAccess.ps1`

SHA-256 before operator handoff:
`341513816E3FBF2B2DD99D97A2E583A55C9BF8D22BD87FF83B28AA016C836556`.

[Retained diagnostic source](research/SECURITY_METADATA_ACCESS_DIAGNOSIS_001_2026-10-10.ps1) is a bounded extension of the prior gate, not a backup framework. Git newline conversion may change retained bytes; verify the executed local digest separately.

- Exact host and actual administrative-token guards; operator manually opens a fresh administrative Windows PowerShell session. The old administrative metadata preflight is hash-pinned and rerun for the same approved file scope.
- Observe identity/SID, process path/PID/version, TokenElevation/type, SeSecurity present/enabled/raw attributes and backup/restore state. A thread token or already-enabled unrelated backup/restore privilege causes STOP rather than a privilege workaround.
- Enable only the existing SeSecurityPrivilege in that process. Observe it during the original read and at its first failure; restore the returned previous state in finally, then observe restoration. Compare present/enabled/default bits; record raw attributes separately. [AdjustTokenPrivileges cannot assign a missing privilege](https://learn.microsoft.com/en-us/windows/win32/api/securitybaseapi/nf-securitybaseapi-adjusttokenprivileges).
- Reproduce the original named full BACKUP query until its first failure, recording path, exact API, mask, native return code and phase.
- At that single failing object only, compare named owner/group/DACL (mask7), named SACL (mask8), and a full handle-based BACKUP query. The two partial reads are diagnostic controls, never a replacement or sufficient gate pass.
- The candidate handle method opens OPEN_EXISTING with only READ_CONTROL|ACCESS_SYSTEM_SECURITY, share read/write/delete, directory-support/open-reparse-point flags. It requests no data-read, write, ACL-write or ownership-write right and never calls ReadFile. It keeps BACKUP_SECURITY_INFORMATION unchanged.
- If the complete handle read succeeds, require its owner/group/DACL and SACL to match independently requested components. Then use this complete method for the remaining approved scope, with unchanged checks for all descriptor components, owner/group/ACE SID resolution, unsupported ACE rejection, SDDL roundtrip, file links/streams and source/parent attributes. Partial results or unsupported metadata STOP.
- Observe privilege state after restoration and service status. Emit only fingerprints/counts/path/error/token diagnostics, not raw descriptors or SQL contents. STOP even if the security gate passes.

There is no bounded retry loop on a failed object, no DACL-only fallback, no added account right, policy/ACL/ownership change or impersonation. A different full API succeeding on the same object supports a read-method-specific result, but does not automatically establish every internal reason why the original API failed.

## Completion boundary

The owner result is now recorded above. The bounded round ended at its full-read STOP; the gate remains BLOCKED and the deeper cause unresolved. The C: root failure prevents qualification of later approved paths; absence of their records is not evidence of failure or success on those files. Real capture remains NOT STARTED and is excluded from this task. No SQL stop/start, database content read/copy, E: write, crypto/backup test rerun, source ACL/ownership/policy or TLS/network/CA/ERP change occurred. Decoder retention and prior synthetic qualification are unaffected. STOP.
