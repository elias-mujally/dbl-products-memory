# Session identity diagnosis #001 — completed; acceptance unchanged and blocked

**SESSION IDENTITY DIAGNOSIS = COMPLETED.** All nine requested conditions have independent known PASS/FAIL results from one actual self-session SELECT. This is diagnostic completion, **not** successful identity acceptance, function metadata attestation, inventory source qualification or inventory insight. The original acceptance gate remains **BLOCKED / UNCHANGED**.

## Authorization and independent local qualification

Owner separately authorized this diagnosis following [offline security review](DBL_ADMINISTRATIVE_IDENTITY_SECURITY_REVIEW_001_2026-10-13.md), Product Memory `4869b7ac8a2779cce68ace40a9afc3bfa7e88a3a`. No grant, alternate identity, elevation, function/business read, Reader run, import, policy change or retry was authorized or performed.

Prepared only the independent task-local `outputs/host-session-identity-diagnosis-001-20261013/Read-SessionIdentityDiagnosis001.ps1`, SHA256 `95283B8494BEEFA0AC1A1D00F2D5C533F3F10CE8C8D31BA3744FB4ED30E42F03`. Existing attestation and administrative-diagnostic helpers/results were not edited or rerun. Parsing passed. One new CheckOnly execution passed at2026-10-13T22:10:52.0683098+03, with **80 recorded local verification entries**, including repeated negative-value cases, not80 distinct live experiments.

Local qualification covers all-pass and independently failed flags; missing fields, null, unexpected integers, string and boolean flags; missing/empty/nonstring identity names; case-sensitive name mismatch that keeps the old gate blocked; contradictory identity observations; a known different original SID represented by safe flags; zero/multiple self rows; frozen-source/endpoint drift; invalid ports; safe serialization; and unchanged original criteria. No SQL connection, actual SID read, real name read or old test execution occurred in CheckOnly. These tests validate client classification and source/builder controls; they do not execute the new CASE expressions on a SQL engine or prove live SID/authentication values.

The original IdentityChecks function, including the expression `WindowsTokenSidMatches=1 AND IsSysadmin=1 AND Operator -ceq EffectiveOperator`, was compared with the pinned previous diagnostic function after newline normalization and is unchanged. New comparisons supplement diagnostic evidence only; they do not replace a failed original condition or authorize a subsequent operation.

## Single actual diagnostic, scope and secrecy

ATTEMPT and RESULT are new CreateNew files; the helper refuses an existing attempt/result and requires the qualified source hash. Used the same approved local owner Windows integrated System.Data.SqlClient method, **WindowsAdmin=false**, without UAC elevation or an alternative account. Strict connection settings retain observed direct port/approved hostname, Encrypt=true, TrustServerCertificate=false, Pooling=false, ConnectRetryCount=0, PersistSecurityInfo=false, MARS=false,15s connection/query budgets. No credential prompt or password.

Actual **ConnectionOpenCalls=1, SqlQueries=1**. One fixed SELECT joins sys.dm_exec_sessions and sys.dm_exec_connections on session_id and restricts **both aliases to @@SPID**. No listing of other sessions, EXECUTE AS, free-form SQL, account metadata expansion, token inventory or name-to-SID lookup. Cardinality must be exactly one row, with no extra result set; missing/unexpected values or contradictory flags cause UNKNOWN/STOP and no retry.

The expected Windows SID is a process-local parameter. SQL returns comparison flags, **not raw original/current SIDs**. Original/effective SQL names exist only in memory to evaluate the unchanged previous name condition and are removed before evidence serialization. No raw names/SIDs, identity-derived hashes or raw exceptions were published. Memory reference/buffer cleanup is not a comprehensive process-memory erasure guarantee.

Actual identity observation: **2026-10-13T22:11:29.147688+03:00**; final result22:11:29.3698854+03. [Selective nonsecret evidence](research/DBL_SESSION_IDENTITY_DIAGNOSIS_001_REVIEW_2026-10-13.json).

| Requested condition | Actual result | Safe meaning |
| --- | --- | --- |
| original_security_id matches expected Windows SID | PASS | Initial session identity SID matched the approved Windows identity. |
| security_id matches expected Windows SID | PASS | Current session identity SID matched the approved Windows identity. |
| security_id matches SUSER_SID() | PASS | Session SID and current SQL-context SID matched. |
| Original/current session SIDs match | PASS | Their binary identity comparison matched. |
| Windows integrated authentication (NTLM/KERBEROS) | PASS | Current connection's auth_scheme matched the permitted integrated set; no raw scheme/name was retained. |
| Noncontained authentication | **FAIL** | The fixed CASE returned0 for authenticating_database_id>0, not1 for zero. |
| Previous current-SID/Windows-token check | PASS | Original SID-match predicate returned1. |
| Previous sysadmin check | PASS | Original current-context role predicate returned1. |
| Previous exact original/effective SQL-name equality | **FAIL** | Nonempty in-memory names failed the unchanged case-sensitive comparison. |

ObservationConsistency=PASS means these results did not contradict the client's tested equality relationships; it is not an acceptance override. No required comparison returned UNKNOWN. Known FAIL results do not prevent completion of this **diagnosis**, whose purpose is to report the actual independent conditions, but cannot be relabelled acceptable.

## Source, TLS and unchanged environment

Same SELECT verified SQL12.0.6024.0 on DESKTOP-8QRQT7R/YSEDU, exact frozen DB10 `DBL_HOST_W11_EFA12026_PostS2_Frozen_20261009`, ONLINE/READ_ONLY, nonempty valid database GUID, TCP192.168.56.1:52952 and encrypt_option=TRUE. Successful connection used normal hostname/trust validation, not TrustServerCertificate or an alternate certificate policy. Negotiated cipher/peer socket were not separately captured. Lab revocation UNKNOWN was not retested or claimed successful.

Read-only environment checks before22:11:28.923+03 and after22:11:29.364+03 passed: YSEDU Running/PID101852, exact existing certificate binding, observed dynamic52952, SQLBrowser Stopped/Disabled, ForceEncryption0 unchanged. Connection disposed, CleanupFailures empty. Source/session evidence is point-in-time; future unchanged configuration or identity is not guaranteed.

## Interpretation and mandatory STOP

The four new SID comparisons support **the same observed original/current Windows SID despite the differing SQL name representations**. They do not establish the exact naming cause, identical full permission/token attributes, or absence of any earlier switch followed by restoration. No actual raw name was retained to diagnose a case-only, alias or mapping cause.

The noncontained condition also **failed independently**. Microsoft's documented authenticating_database_id is zero for server logins and a database ID for contained authentication; our SQL CASE tests precisely that distinction. [Microsoft session fields](https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-sessions-transact-sql). This evidence retains only the flag: the positive numeric value, database containment configuration, original/current principal mappings and cause were **not** obtained or qualified. Do not infer a specific contained account, reinterpret the flag as PASS, change any configuration or assume the SID matches resolve this separate discrepancy. Any focused interpretation/diagnosis of that signal requires separate authorization; none was started.

The old gate is still BLOCKED because its exact name-equality condition failed. Even a future owner decision about name-versus-SID acceptance must also address the newly failed noncontained check; the current evidence is not all proposed safeguards passing. No acceptance-policy amendment or administrative attestation is implied. FunctionMetadataQueries=0, FunctionInvocations=0, BusinessQueries=0, ReaderAttempt=false, Import=false, SQLiteOpened=false; no balances or insight. Prior evidence preserved and `.vscode` excluded from publication. **STOP.**

## Artifact integrity

- OFFLINE_QUALIFICATION.json SHA256: `66FA43B57E6A7CA3F660824F928491C5EFB8BAA2A34E4BBE88CDCB2D7712F85E`.
- ATTEMPT.json SHA256: `D713CDA1F20C9AE1D973C4BFCF2417F34A88FC3BC04A287A9B30B8BD7776AB62`.
- RESULT.json SHA256: `84F25B7CBC686E29134BFA1F0AFA4F29A94CEFD28D212A623B7C03F8701E47CE`.
- Previous diagnostic helper/result re-read unchanged: `DC647B14E09FF99D3C10DF1E86F0B2470866564AC8FEAD80DBD58EC93B6CD24C` / `1D112804D0798CD49304B8810ADA9A1240D85B6B8CDC52FE51647552FD96DFA5`.

These digests cover public source/evidence artifacts, not SIDs, names or passwords.
