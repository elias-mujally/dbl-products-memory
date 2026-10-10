# Host W11 — Security Metadata Access Diagnosis #001

Date: 2026-10-10 (+03:00). Baseline: Product Memory `c85dc70`.
Owner scope: bounded read-only diagnosis and a safe read-method correction test only.

## Current decision

**OPERATOR EXECUTION PENDING — SECURITY METADATA GATE REMAINS BLOCKED.**
No successful protected-object read, root cause, corrected gate or recovery capture is claimed from preparation tests.

The prior operator failure was `GetNamedSecurityInfoW` requested through `Descriptor`, with `BACKUP_SECURITY_INFORMATION=0x00010000`, Win32=5 and CompletedRecords=0. It omitted the failing path and effective privilege observations. Source code constructs a sorted list of the approved 23 files and their parents, so a parent can be first; this ordering is a hypothesis until the instrumented operator observation. Do not name a SQL file or C: root as the proven denied object yet.

## Evidence collected without elevation

At 2026-10-10T17:19:30.4227417+03:00 the agent process was `DESKTOP-8QRQT7R\\user`, PID28156, non-elevated, using the bundled PowerShell7 executable. `MSSQL$YSEDU` was Running. No automatic UAC elevation was attempted.

The new diagnostic source passed PowerShell7 parsing/C# compilation and Windows PowerShell5.1.22621.6133 parsing/C# compilation. Native observation of those separate test processes showed TokenElevation=false, TokenElevationType=3 (limited), SeSecurityPrivilege absent, no thread impersonation token, and SeBackup/SeRestore disabled. No privilege was adjusted; no protected object was probed during these preparation tests.

The native `QuerySecurityAccessMask(0x10000)` returned `0x01020000` in both runtimes. This agrees with [Microsoft's BACKUP query rights](https://learn.microsoft.com/en-us/windows/win32/secauthz/security-information): READ_CONTROL plus ACCESS_SYSTEM_SECURITY. [Named reads](https://learn.microsoft.com/en-us/windows/win32/api/aclapi/nf-aclapi-getnamedsecurityinfow) require the SACL privilege enabled. [Handle reads](https://learn.microsoft.com/en-us/windows/win32/api/aclapi/nf-aclapi-getsecurityinfo) additionally require appropriate access granted when opening the handle. The original zero-access metadata handle was not passed to GetNamedSecurityInfoW, so its zero desired access alone is not a proven cause of the named API failure.

## One bounded operator round

Executed local helper proposed:
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

Waiting for the owner's JSON/error from the fresh administrative session. The new runtime result must be recorded before upgrading security qualification or calling diagnosis complete. Real capture remains NOT STARTED and is excluded from this task. No SQL stop/start, database content read/copy, E: write, crypto/backup test rerun, TLS/network/CA or ERP action occurred.
