# Host W11 — Explicit Security Descriptor Qualification #001

Date: 2026-10-10 (+03:00). Baseline: Product Memory `1dd4679`.
Owner authorization: explicit complete security-component qualification, fixtures first, then metadata-only reads of the approved 23 files and required original parent directories. No source security change, policy change, SQL stop/copy or real capture.

## Decision

**SECURITY METADATA GATE = BLOCKED — INHERITED FIXTURE RECONSTRUCTION MISMATCH. STOP.**

The explicit alternative made material progress: the protected file fixture passed full component reconstruction, independent-source comparison and native replay, including an actual Audit SACL and Medium mandatory integrity label. It did not qualify the inherited fixture, so it is not a complete preservation method for Recovery Capture #001. No approved real-source security reads were attempted. Do not downgrade comparison, drop inheritance/control bits or treat the protected case as a full gate pass.

## Actual administrative operator result

[Retained JSON](research/EXPLICIT_SECURITY_DESCRIPTOR_QUALIFICATION_001_RESULT_2026-10-10.json) was supplied by the owner at **2026-10-10T19:44:25.8991275+03:00**, on DESKTOP-8QRQT7R, operator DESKTOP-8QRQT7R\\user, PID 29760, Windows PowerShell 5.1.22621.6133. This is owner-returned administrative execution evidence, not independently witnessed elevated execution. The retained JSON is a structured transcription of the returned fields, not an original-byte attachment.

| Check | Observed result |
|---|---|
| In-memory parser/encoder and negative vectors | PASSED, 10 checks; not filesystem qualification |
| Protected fixture full explicit read/reconstruction | PASSED; handle and independent GetFileSecurityW references agree before/after |
| Protected fixture serialized descriptor and native replay | PASSED; source and restored canonical SHA-256 both `42BFB6983CA5666AA4D79BC3452EC72EF6269AD007F99019D499EC7ABC594502` |
| Protected security content | Control 0xB014; DACL ACE types [1,0,0,0], SACL [2,17]; deny/allow order and audit/MIC preserved; fixture assertions established SYSTEM owner and Administrators group |
| Other explicit SACL component probes | Resource attributes, scope, process trust and access filter absent with successful explicit reads in the protected fixture only |
| Inherited fixture | BLOCKED during Read, before its replay: explicit reconstruction/control/ACE-order mismatch |
| Empty/no-audit fixture and directory replay | NOT REACHED |
| Approved real files and required original parents | NOT REACHED; completed real records 0 |
| BACKUP_SECURITY_INFORMATION | Not used; its success was not required |

Failing path:
`C:\Users\user\Documents\Codex\ESDQ-20261010-a42c190d\fixture-tree\inherited-source.txt`.

FailurePhase was `FixtureReadAndReplay`; NativeStage was `GetSecurityInfo mask=0x1F8`. The exact returned reason was:

`Exception calling "Read" with "1" argument(s): "STOP: explicit reconstruction/control/ACE-order mismatch"`

Code inspection localizes this to the logical reconstruction check after component reads: the same error is emitted if the rebuilt descriptor fails IsValidSecurityDescriptor **or** if it differs from the explicit full reference. The returned result does not distinguish those two branches. NativeStage records the last API operation; it is not evidence that that API returned Win32=5. No new native access-denied result was reported. The result contains no source/rebuilt inherited descriptor pair or detailed difference. Invalid reconstruction versus unequal control/ACL content/order remains **UNRESOLVED**. No diagnostic retry or correction was executed after STOP.

PersistentCount and ExpectedSecurityRecordCount were 0 because the real allowlist preflight was intentionally deferred until all fixture tests passed. They do not mean that the approved 23 files disappeared, nor establish their success/failure.

## Privileges and operational boundary

Actual process token was elevated, type 2, non-impersonating. SeSecurity attributes changed **0 → 2 → 0**; SeRestore was **disabled → enabled for fixture owner replay → disabled**. SeBackup remained disabled. PrivilegeRestoreFailure was null; before/after enabled states agreed. ProcessTokenDuringRealRead was null: real reading never began.

The helper can adjust only existing process privileges; it does not assign account privileges, change UAC/policy or auto-elevate. Fixture-only writes are constrained to the new fixed synthetic root and sealed before any real phase. Native source query handles request only READ_CONTROL and ACCESS_SYSTEM_SECURITY, not file-data or source security-write rights. The real reader has no source ACL setter call.

The operator reported SQLStatus Running; SourceContentsRead, SourceSecurityChanged, SqlStopped, EWrites and RealCaptureStarted all false. A separate **non-elevated** service read at **19:46:15.9087924+03:00** also showed Running. This does not prove SQL transaction/catalog/database-integrity state.

Synthetic files and descriptors remain in the isolated fixture root; no cleanup, source-content read/copy, E: write, crypto rerun, SQL stop/start, source ACL/ownership, Windows policy, TLS/network or ERP change followed the failure. Prior decoder retention and archive qualification are unaffected. **REAL CAPTURE NOT STARTED.**

## Tested method and preservation limits

[Native source](research/EXPLICIT_SECURITY_DESCRIPTOR_QUALIFICATION_001_NATIVE_2026-10-10.cs) and [operator helper](research/EXPLICIT_SECURITY_DESCRIPTOR_QUALIFICATION_001_2026-10-10.ps1) retain the attempted method, not an approved production/capture reader.

- Explicit owner, group and DACL queries; a complete explicit SACL query 0x1F8 preserves native ACE order. Audit, label, resource, scope, process-trust and access-filter probes are separately checked against that SACL.
- A composite explicit 0x1FF descriptor and independent GetFileSecurityW descriptor are queried before/after. Components reconstruct a self-relative descriptor; comparison preserves owner/group SIDs, all control flags, ACL revision, presence/null/empty distinction, complete supported ACE bytes and original order.
- Normalization changes only self-relative offsets and zero unused ACL capacity, not access masks, ACE ordering, inheritance or protection flags. Canonical SHA here is a security-descriptor fingerprint, not a business-data hash.
- Reads must succeed before absence is recorded. Unsupported present ACEs or control state cause STOP, never omission. Present replay support is deliberately bounded to allow/deny/audit/MIC types 0/1/2/17; resource/scope/trust/filter presence and RM/untrusted/server control remain unqualified STOP conditions.
- Protected and inherited file fixtures, a no-audit fixture and directory replay were planned; only the protected case completed. In-memory vectors distinguish absent/NULL/empty DACL and SACL, reject unsupported/truncated descriptors and detect order/control changes. These cannot replace native inherited-file replay.

Microsoft documents the [explicit security-information components and query rights](https://learn.microsoft.com/en-us/windows/win32/secauthz/security-information), [handle queries](https://learn.microsoft.com/en-us/windows/win32/api/aclapi/nf-aclapi-getsecurityinfo), and [GetFileSecurityW](https://learn.microsoft.com/en-us/windows/win32/api/securitybaseapi/nf-securitybaseapi-getfilesecurityw). Those API contracts support the approach, but do not prove this implementation preserves every source descriptor. The failed comparison is retained as an implementation qualification blocker.

## Preparation provenance

Non-elevated preparation on PowerShell 7.6.5 and Windows PowerShell 5.1 compiled and passed the same 10 in-memory vectors. No fixture writes, privileged queries or privilege adjustment were performed by those engine-only tests.

Executed local native SHA-256:
`76FF48475E26BE7DD01A938BE7E2565D1FF5A0A20956F4D9A03786AFAC847056`.

Executed local helper SHA-256:
`CB109B1612C34F30E2CF8A06D02623AD0880A0E8DC50A40146C05B10B648EC17`.

Both matched on recheck at 19:46 +03 after the operator STOP. Retained Git source may undergo newline normalization; local execution digests must be checked separately. The prior real allowlist helper remained hash-pinned but was not invoked in this failed fixture round.

## Remaining gates and next authorization boundary

1. Diagnose the inherited synthetic reconstruction difference with exact component/control comparisons; correct and requalify fixtures without suppressing any information. This is a proposed next bounded task, not executed after this STOP.
2. Only after full fixture success, qualify explicit metadata preservation over all 23 approved files and required original parent directories. Re-evaluate unsupported components rather than assume they are absent.
3. Exact settings/local-evidence allowlist, protected real NTFS stage, fresh storage/tool/custody checks, normal ERP closure and final pre-stop refresh remain required before any separate capture resumption.
4. This task does not authorize SQL outage/copy after success. No real archive, SHA-256 of real capture, or SQL restore proof exists from this round.

Product scope unchanged: S2-P LAB-PROVEN; S3 ACCOUNTING-BLOCKED; Live Connector NOT TESTED. No connector/Canonical/business implementation. STOP.
