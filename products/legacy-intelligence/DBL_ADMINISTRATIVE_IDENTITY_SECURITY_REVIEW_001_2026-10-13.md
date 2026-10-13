# Administrative identity security review #001 — offline review completed, acceptance still blocked

**ADMINISTRATIVE IDENTITY SECURITY REVIEW = COMPLETED.** This is a source/evidence and acceptance-policy review, not a new SQL diagnostic or a successful administrative attestation. **ApprovedIntegratedAdministrativeIdentity remains BLOCKED and unchanged.** Function metadata attestation and inventory source qualification remain NOT PROVEN.

## Scope, provenance and unchanged controls

Owner authorized review only after Product Memory `b0275c2011c58432eb34c65d2b37f36f44faa66a`. Reviewed the saved [actual diagnosis](DBL_ADMINISTRATIVE_IDENTITY_DIAGNOSIS_001_2026-10-13.md), its selective JSON, the task-local diagnostic source and result, and the original attestation identity-query/guard excerpts. No execution helper was run, including CheckOnly. No SQL connection, service/network probe, function definition/parameter/dependency read, business read, retry, Reader change, import or execution-tool edit occurred. Public Microsoft documentation was consulted for semantics; this was not a live database review. Historical host/SQL observations below were not refreshed and are not asserted as current.

Read-only SHA256 verification matched the published artifacts:

- Diagnostic helper: `DC647B14E09FF99D3C10DF1E86F0B2470866564AC8FEAD80DBD58EC93B6CD24C`.
- Diagnostic RESULT.json: `1D112804D0798CD49304B8810ADA9A1240D85B6B8CDC52FE51647552FD96DFA5`.
- Original attestation helper: `7F7502045437BF93F8189FC77635770885E99FA12BFFF2D2FD19C3BBE2EB0B35`.

Source anchors relative to the local workspace: `outputs/host-administrative-identity-diagnosis-001-20261013/Read-AdministrativeIdentityDiagnosis001.ps1` lines15–17 (integrated strict TLS/direct port/no pooling/no connection retries),25–31 (safe recording and unchanged gate),33–50 (identity SELECT and expected Windows SID parameter),83–91 (record before interpretation). Original `outputs/host-inventory-function-attestation-001-20261013/Read-FindAvQtyAdminAttestation001.ps1` lines74–77 contain the actual acceptance guard. No EXECUTE AS or impersonation operation is present in the reviewed diagnostic path; that does not rule out server-side context effects.

The relevant existing SELECT projections are:

```sql
ORIGINAL_LOGIN() AS Operator, SUSER_SNAME() AS EffectiveOperator,
CASE WHEN SUSER_SID()=@OperatorSid THEN 1 ELSE 0 END AS WindowsTokenSidMatches,
IS_SRVROLEMEMBER('sysadmin') AS IsSysadmin
```

`@OperatorSid` is the binary SID of the approved caller's Windows token, supplied as VarBinary(85), not an account-name parameter. The full SELECT also checks source/server/version/DB/READ_ONLY/ONLINE and the actual encrypted endpoint; those guards remain required. The acceptance expression remains:

```powershell
$r.WindowsTokenSidMatches -eq 1 -and $r.IsSysadmin -eq 1 -and $r.Operator -ceq $r.EffectiveOperator
```

This is PowerShell case-sensitive string comparison, not a comparison of the original and effective binary SIDs. No trimming, case folding, name allowlist or substitute condition was introduced. Missing/unexpected identity observations must not become PASS.

## SQL Server function semantics

`ORIGINAL_LOGIN()` identifies the login that initially established the SQL session; later explicit or implicit execution-context changes do not replace that original identity. `SUSER_SNAME()` without an argument reports the current security-context name. Under EXECUTE AS, it can describe the impersonated context while ORIGINAL_LOGIN still describes the initial caller. A module executing under a different context can also affect identity observed inside that context; REVERT restores the prior context. These functions are applicable to ordinary SQL Server, including the SQL2014 usage under review, not an Azure-specific impersonation model. [Microsoft ORIGINAL_LOGIN](https://learn.microsoft.com/en-us/sql/t-sql/functions/original-login-transact-sql), [Microsoft SUSER_SNAME](https://learn.microsoft.com/en-us/sql/t-sql/functions/suser-sname-transact-sql).

Names are representations, not the SID identity itself. Microsoft documents Windows/SQL login-format and collation differences, including case differences that can affect name-based SID resolution. Consequently a case-sensitive name discrepancy is not, by itself, proof of a distinct Windows principal. Conversely it must not simply be declared a harmless alias. `SUSER_SID()` without an argument measures the **current** security context; it does not independently attest the original caller. A lookup using `SUSER_SID(ORIGINAL_LOGIN())` may be sensitive to Windows-name validation/formatting. We do not recommend adding Param2=0 or normalizing names as an automatic workaround. [Microsoft SUSER_SID](https://learn.microsoft.com/en-us/sql/t-sql/functions/suser-sid-transact-sql).

`IS_SRVROLEMEMBER('sysadmin')` without a login argument tests membership for the current execution context;1 is membership,0 is nonmembership, NULL is unresolved/invalid/visibility failure. It tests the SQL role, not Windows UAC elevation or the origin of that role membership. [Microsoft IS_SRVROLEMEMBER](https://learn.microsoft.com/en-us/sql/t-sql/functions/is-srvrolemember-transact-sql).

## What the actual PASS / PASS / FAIL establishes

Actual observation was **2026-10-13T21:02:25.6362925+03:00**, SQL12.0.6024.0, frozen DB10, one identity SELECT. The later retained result has all three conditions known, not UNKNOWN.

| Evidence | Established at that observation | Not established |
| --- | --- | --- |
| SID match PASS | The current SQL-context SID matched the expected Windows caller SID. | Original session SID independently matched; absence/history of impersonation; cause of differing names. |
| sysadmin PASS | SQL reported sysadmin membership for the current context. | Windows elevation, how membership was obtained, or authority to perform any out-of-scope work. |
| NameEquality FAIL | The two nonempty returned names failed the unchanged case-sensitive comparison. | Different binary SIDs, malicious impersonation, a case-only mismatch, benign alias, or a particular Windows/Microsoft-account mapping. |

The original/effective names and raw SIDs were deliberately not retained in public evidence. They cannot be reconstructed from the safe flags or inferred from the published host/operator label. The result is consistent with the earlier aggregate failure, but does not recover its unrecorded row. It does not qualify FindAvQty metadata or any inventory value.

## Security judgment

The present conjunction is **fail-closed**: the discrepancy blocked the administrative path before function reads. No source-supported acceptance bypass or privilege gain was demonstrated. Keeping it unchanged is safe within the current authorization, albeit operationally blocked.

Exact name equality is defensible as a conservative discrepancy alarm, but is not a necessary identity invariant in every Windows-integrated deployment. It can reject two representations of the same SID; textual equality alone also cannot attest an entire execution-context history. Therefore the third predicate is potentially more restrictive than necessary **for the intended invariant that the original and current Windows principal are both the approved owner**. This case has not yet demonstrated that benign condition. Dropping equality because the other two checks passed, using case-insensitive equality alone, or treating every sysadmin as approved would leave original-caller verification insufficient.

Trust boundary: the administrative helper must bind both the initial caller and current execution identity to the owner-approved Windows principal before narrowly authorized metadata reads. Privileged access is not itself authorization to bypass this boundary. TLS, exact source identity and READ_ONLY guards are separate and cannot be substituted by an identity-policy decision.

## Smallest additional diagnosis — proposal only, not an executable tool

Recommend a **separately authorized, single fresh integrated connection and one fixed identity-only SELECT**, using the same strict transport and source guards, restricted to its own `@@SPID`. Retain the existing three observations, and add comparisons of session-native original/current IDs rather than attempting to resolve the original textual name again:

- Compare `sys.dm_exec_sessions.original_security_id` with the expected Windows-token SID.
- Compare `security_id` with that SID and with `SUSER_SID()`; compare original/current session security IDs with each other.
- Check this connection's `auth_scheme` is Windows integrated (NTLM or KERBEROS), and that session authentication is not a contained-database identity (`authenticating_database_id=0`).

Microsoft documents session-native original and current identity fields and supports restricting the session/connection join to `@@SPID`. This avoids listing other sessions or publishing account names. These proposed projections have **not** been run or locally implemented/qualified here. [Microsoft sys.dm_exec_sessions](https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-sessions-transact-sql).

Publish only independent PASS/FAIL/UNKNOWN flags, safe reason codes, observation time and the already approved nonsecret source provenance. Do not return/store names, SIDs, name/SID-derived fingerprints or a full token listing. Require exactly one self-session/connection row and known nonempty IDs before comparison. Missing columns/rows, null or inconsistent IDs, unexpected auth scheme, permission errors or lookup ambiguity mean UNKNOWN/STOP, not fallback, grant, normalization or retry.

Interpretation:

- All original/current/expected SID comparisons PASS with the names still different supports **same observed Windows identity with differing name representation**. It does not identify the formatting cause or prove there was never an earlier context switch followed by restoration.
- Known unequal original/current IDs provide evidence of a different observed execution identity; do not replace the name gate or proceed to attestation.
- Any UNKNOWN leaves identity unresolved and the gate blocked.

No login-trigger inspection, server trace, account repair, alternate identity or business/function read is included. Those would require a further necessity assessment and authorization, not automatic follow-up.

## Proposed acceptance policy and owner decisions

**Current policy remains unchanged.** Only after a separately approved diagnosis and review of its actual evidence could the owner consider replacing the name-equality predicate for this narrow administrative metadata helper with all-known, binary equality of initial session SID, current session SID, current SQL-context SID and the pinned owner Windows SID. Preserve sysadmin=1, verified integrated authentication, noncontained identity, exact source/TLS/READ_ONLY/endpoint guards and pre/post same-source/context checks on the same connection. Unexpected values or drift fail closed. Do not assume the old observation remains valid for a future connection.

Keep exact name comparison as diagnostic evidence/discrepancy reporting; it must not be silently changed to an unconditional warning today. If the owner's policy instead requires literal names or proof of no context switch ever, retain the present stricter rejection; a point-in-time SID match does not satisfy that stronger historical requirement. Same-SID equality is an identity check, not proof that every permission/token attribute or past action is identical.

Separate decisions are needed for: (1) the one additional identity-only diagnosis; (2) any changed acceptance policy and its bounded helper correction/offline positive and negative qualification; (3) a fresh administrative function-metadata attestation; (4) any later attestation-to-Reader binding and inventory read. None is authorized or prepared by this review. A successful proposed diagnosis would not automatically authorize steps2–4 or make inventory source qualification PASSED.

Residual limits: retained evidence is point-in-time; the actual name-difference cause remains UNKNOWN; server/owner privileged compromise cannot be excluded by these local checks; Windows naming/group resolution can be complex; accepted lab revocation UNKNOWN remains a gap, not a new PASS. No secret was requested, displayed, generated or disclosed. Security-scan guidance was inspected but its full scan/delegation workflow was not opened because this task is a constrained acceptance-policy review, not a repository audit. Publication contains documentation only; previous evidence and `.vscode` are preserved. **STOP.**
