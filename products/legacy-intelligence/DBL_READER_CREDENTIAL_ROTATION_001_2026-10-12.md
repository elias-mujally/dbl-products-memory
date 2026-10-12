# Reader-only credential rotation and secure handoff #001

Owner authorized rotation of existing `DBL_HOST_W11_S2_Reader_20261009` only. No new login, permissions, source data, service, network, certificate or Connector changes are authorized. FIRST LIVE DATA remains a separate, paused operation.

## Actual read-only preflight

At `2026-10-12T12:16:14.3102655+03:00`, the current Windows owner's integrated SqlClient connection passed with `Encrypt=true`, `TrustServerCertificate=false`, pooling disabled and connect retries zero. Server was `DESKTOP-8QRQT7R\YSEDU`, version `12.0.6024.0`, local address `192.168.56.1`, DMV-owned port `52952`. Existing owner SQL principal is sysadmin for preparation only; SQL SID equals the current Windows token SID. No administrative identity is used by the Connector.

Database ID10 `DBL_HOST_W11_EFA12026_PostS2_Frozen_20261009` is ONLINE/READ_ONLY, TRUSTWORTHY and cross-DB chaining false. Existing reader is enabled SQL_LOGIN, CHECK_POLICY/CHECK_EXPIRATION enabled, default database unchanged, user SID matches login, no server/database role memberships, CONNECT SQL only at server level. Its 23 explicit database permissions exactly match the original qualification evidence, including nine SELECT grants, one scalar EXECUTE and write/DDL denies. No secret or password hash was queried.

Login catalog creation time was `2026-10-09 08:12:13.763`; last modification `2026-10-09 08:17:00.370`. Original preparation generated/rotated its password only in process memory and did not retain or deliver it. Prior owner availability confirmation was not evidence of a credential handoff.

Preflight initially rejected two incorrect diagnostic assumptions: SQL names the owner's existing Microsoft-account principal differently from the Windows display name; identity is now verified by SID, not assumed name equality. SQL2014 CONNECTIONPROPERTY returned signed port `-12584`; independent `sys.dm_exec_connections.local_tcp_port` returned `52952`, matching the current OS/service listener. No guessed port normalization was used. A local inventory-query column typo was corrected to documented `event_name`. These were read-only tool corrections, not password-change retries. No credential was generated during these checks.

Logging inventory: one active default trace, no enabled server audits, no extra Extended Events sessions beyond system sessions. This is a point-in-time inventory, not protection against later monitoring or a compromised host.

## Qualified preparation; interactive execution pending

Owner explicitly accepted transient same-user clipboard exposure and selected Bitwarden. Handoff uses a local form that never renders the actual secret. Native clipboard publisher requires an empty clipboard, installs Windows history/cloud exclusion formats before CF_UNICODETEXT, verifies exclusion DWORDs and text in memory, permits one copy, expires after30 seconds and clears only the sequence/owner it created. These controls do not exclude other local applications. [Microsoft clipboard formats](https://learn.microsoft.com/en-us/windows/win32/dataxchg/clipboard-formats).

The owner must save the 48-character CSPRNG-derived secret into Bitwarden, confirm the owned clipboard was cleared, retrieve the saved password into a hidden Read-Host prompt and match it in memory, then explicitly confirm rotation. Failure of any handoff gate stops before SQL mutation. Bitwarden custody is owner-controlled and confirmed by retrieval, not inspection of the vault. No archive/CA/Windows password is reused. No comprehensive managed-memory erasure is claimed.

SQL2014-only maintenance uses one parameterized RPC to built-in `sys.sp_password`, targeting the fixed existing login; it calls ALTER LOGIN without supplying any policy/role options. It is deprecated for new development and is not added to the Connector. [Microsoft procedure contract](https://learn.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/sp-password-transact-sql). No secret-bearing SQL batch, command-line argument, JSON, history, environment variable or repository file is constructed. The new reader secret is used through SqlCredential for one login/metadata-only verification; no Item extraction/import occurs.

After a possible write, timeout/failure is treated as potentially ambiguous; no automatic retry or rollback to an unknown old password. Owner already retains the new value before any write. Pre/post checks retain the frozen DB, policy and exact grants. Independent resource cleanup failures prevent success.

CheckOnly compiled the handoff code, rejected malformed handoff input and verified strict direct-port admin/reader builders and credential separation, without opening UI, touching clipboard, generating a secret or connecting to SQL. Launcher pins and parsing passed. Actual clipboard handoff, rotation and reader login are **PENDING / NOT PROVEN** at this preparation record. Owner console PID41116 was launched; no rotation result is inferred from launching it.

| Local helper | SHA256 |
| --- | --- |
| Read-ReaderRotationPreflight001.ps1 | `8A0582C67E9AD2999961DC0F644016C2F06233E4369B5F55F518B42A56C7716A` |
| ReaderHandoff001.cs | `E40923775CFDCAFE07187608D41D42DA42B8614271C1B7E5D2E8CE9B9914F725` |
| Invoke-ReaderRotation001.ps1 | `C686603B6C4D3195D21FC628468CF50582AFB02681D25CCE591D472549E191F3` |
| Start-ReaderRotation001.ps1 | `46142F1AAD4B9744BBFC7088BE60B6331F551D2AC60817B94DF8717C9EAC693C` |

Helpers and future nonsecret `READER_ROTATION_001_*` records are in the existing local `outputs/host-first-live-data-001-20261010` directory. Do not publish any vault/clipboard/password material. CRL/OCSP remains UNKNOWN under the existing explicit laboratory policy. FIRST LIVE DATA is NOT TESTED by this task. Await the owner's result; do not rerun the launcher.

## Owner-requested console reopening

The first console exited at `2026-10-12T12:39:37.6464752+03:00` with `READER_ROTATION_BLOCKED_STOP`, phase `OwnerInteractiveSafety`, code `OwnerReadyAndLivePromptPaused`: the public readiness token was not confirmed. This occurred before the administrative preparation file, secret generation, handoff or any password-change attempt. RotationAttempted/PasswordChanged/AttemptOutcomeUnknown were all false; no cleanup failures. A false result field for permissions qualification is not evidence that permissions changed: the console stopped before its SQL preflight.

Owner explicitly asked to reopen the window after clarification. Prior PID41116 was absent; no BEFORE/ATTEMPT file existed. The nonsecret failure result was moved, without changing bytes or replacing another file, to `READER_ROTATION_001_OWNER_CONFIRMATION_FAILED_20261012T123937.json`, SHA256 `418706BC79B59A761E92DD90EF1F2DA860DD048A9623578E943E6712D4708720`. The unchanged pinned launcher opened owner console PID91516. This is an explicit owner-requested resumption of a pre-secret confirmation failure, not an automatic SQL retry. Actual rotation/handoff/login result remains pending; opening a console proves none of them.

## Actual result: handoff gate BLOCKED, no password write

Owner returned `READER_ROTATION_BLOCKED_STOP` at `2026-10-12T12:52:45.0574298+03:00`; the local nonsecret result matches. Failure phase is `GenerateAndHandoff`, safe code `OwnerHandoffAndOwnedClipboardCleanup`. The fresh BEFORE record at `12:51:31.4152744+03:00` proves DB10 READ_ONLY, same independent reader and policy/expiration, 23 exact historical grants, same authorized Windows SID and port52952. The result's false `PolicyAndPermissionsUnchanged` flag means the final post-rotation verification was not reached, not that permissions were changed.

`RotationAttempted=false`, `PasswordChanged=false`, `AttemptOutcomeUnknown=false`; no ATTEMPT file exists. Thus no password-changing RPC or new reader-login verification was performed, no source business write or service/TLS/network change, and FIRST LIVE DATA was not started. Last reader modification in the fresh preflight remained `2026-10-09 08:17:00.370`. The generated candidate is NOT an active SQL password and must not be used as one, even if the owner saved it in Bitwarden.

The handoff gate aggregates several different conditions (copy/clipboard validation, cleanup, cancellation, or lack of final saved confirmation). This result does **not** identify which failed. `OwnedClipboardExclusionsAndCleanup=false` and an empty resource-disposal failure list do not prove clipboard contents were cleared. No clipboard/vault contents were inspected to investigate. Obtain only the nonsecret status text the owner saw; do not infer clipboard exposure or cleanup success, weaken the gate, or rerun automatically. Retain all artifacts. Any owner-directed remedy/resumption must preserve them and stop before SQL mutation unless a usable, verified handoff succeeds.

Result SHA256 `393A4E2B63EB4A74A79FC40CA506B963480C23FE1306599A6188197EAB067DF8`; BEFORE SHA256 `53551856F439418C0ABEE159B02F14B7E2170EAC3302491E6705366ADFFBFE96`. **Credential Rotation = BLOCKED / Secure Handoff = NOT QUALIFIED / FIRST LIVE DATA = NOT TESTED. STOP.**
