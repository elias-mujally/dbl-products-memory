# Administrative identity diagnosis #001 — completed; original acceptance gate still blocked

**ADMINISTRATIVE IDENTITY DIAGNOSIS = COMPLETED.** The actual three check results are PASS/PASS/FAIL, not UNKNOWN. **ApprovedIntegratedAdministrativeIdentity remains BLOCKED.** FUNCTION METADATA ATTESTATION and INVENTORY SOURCE QUALIFICATION remain NOT PROVEN; FIRST INVENTORY INSIGHT NOT TESTED. Diagnosis completion is not authority to alter acceptance, read function metadata, retry attestation or acquire inventory.

## Owner scope and bounded recording correction

Owner authorized after83da73b: same previously qualified local owner Windows Integrated Authentication, no Windows/SQL elevation or alternative account; correct safe subcheck recording, qualify offline, then one identity-only SQL diagnostic against frozen DB10. No function definition/parameters/dependencies, business data, function invocation, Reader/grant/security changes, old qualification retry or import.

A new independent task-local Read-AdministrativeIdentityDiagnosis001.ps1 was prepared in outputs/host-administrative-identity-diagnosis-001-20261013, SHA256 `DC647B14E09FF99D3C10DF1E86F0B2470866564AC8FEAD80DBD58EC93B6CD24C`. The old attestation helper/result and Reader runner remain unchanged at7F750204/25F54FAE/351FC1D4. This is a diagnostic-only projection, not an edited attestation/Reader path that bypasses a gate. Existing strict System.Data.SqlClient builder is retained: observed direct port, approved hostname, integrated=true, encrypt=true, trustServerCertificate=false, pooling=false and connectRetryCount0; no password or credential prompt.

The new diagnostic retains the original identity SQL text byte-for-byte after newline normalization and the original acceptance expression `WindowsTokenSidMatches=1 AND IsSysadmin=1 AND exact original/effective SQL name equality` (same PowerShell case-sensitive comparison, no trimming, normalization or SID substitute for that equality). Safe three-check results are recorded **before** source/aggregate validation can discard observations. A FAIL remains a FAIL; unknown/missing values are labelled UNKNOWN and cannot make diagnosis complete or authorize acceptance. The aggregate expression is reported, not used to enter a later administrative operation.

PS parse and offline CheckOnly passed:10 vectors cover all-pass; SID-only failure; sysadmin-only failure; SQL-name-only failure; case-sensitive name mismatch; each condition unknown; all-fail; unexpected flag. Success/failure for each condition is independently checked, with exact original gate output and UNKNOWN-not-complete checks. Query/gate text checks and strict connection-builder tests passed without SQL. Synthetic names were public test text; no SID or credential generated/read/published.

## Actual one-connection, one-SELECT result

Local ATTEMPT at2026-10-13T21:02:25.5157076+03; actual identity observation21:02:25.6362925+03; final RESULT21:02:25.8071760+03, SHA256 `1D112804D0798CD49304B8810ADA9A1240D85B6B8CDC52FE51647552FD96DFA5`. [Selective nonsecret evidence](research/DBL_ADMINISTRATIVE_IDENTITY_DIAGNOSIS_001_REVIEW_2026-10-13.json). Same approved Windows owner context, WindowsAdmin=false; no UAC/elevation or different credential. One SqlClient connection and exactly one fixed identity SELECT, no retry.

| Original criterion | Actual status | Safe observed meaning |
| --- | --- | --- |
| SQL SID matches expected current Windows owner token SID | PASS | Parameterized equality flag returned1; neither SID was printed or stored. |
| IS_SRVROLEMEMBER('sysadmin') | PASS | Returned1. SQL administrative membership is present despite non-elevated Windows token; no privilege was added. |
| Original SQL identity equals effective SQL identity exactly | FAIL | ORIGINAL_LOGIN() and SUSER_SNAME() do not satisfy the unchanged case-sensitive name comparison. Neither SQL principal name was printed/stored. |

AllThreeKnown=true; OriginalGateWouldPass=false; AdministrativeIdentityGate=BLOCKED_NO_ACCEPTANCE_CRITERION_RELAXED. Thus the current exact failing predicate is the original/effective SQL-name comparison, not a current SID mismatch or missing sysadmin membership. The previous aggregate failure is consistent with this current observation, but this later query cannot reconstruct its unrecorded historical row. **Do not infer impersonation, aliases, case-only difference, Microsoft-account mapping or a benign-equivalence explanation:** this bounded projection does not establish which explanation applies. Matching SID and sysadmin do not silently override the owner's third condition.

Source identity passed in the same SELECT: DESKTOP-8QRQT7R/YSEDU, SQL12.0.6024.0, frozen DB10 DBL_HOST_W11_EFA12026_PostS2_Frozen_20261009, ONLINE/READ_ONLY, owned192.168.56.1:52952 and actual encrypted connection. Before/after read-only environment at21:02:25.445/21:02:25.802+03 passed, YSEDU PID101852 and BrowserStopped/Disabled unchanged. CleanupFailures empty. No raw error, SID or SQL principal names are in JSON; names used for the in-memory comparison were cleared from the row before serialization. No comprehensive process-memory erasure claim.

FunctionMetadataQueries=0, FunctionInvocations=0, BusinessQueries=0, ReaderAttempt=false, Import=false. No function current hash/parameter/dependency attestation; no new balance, SQLite use, Connector/Canonical change, Reader/grant/account/source/security change. Accepted lab revocation UNKNOWN was not retested or relabelled successful. Existing failed attempts/results remain preserved; `.vscode` excluded from publication.

## Stop and interpretation boundary

The requested diagnostic is complete at its observed time only; it proves the three actual conditions, not future unchanged identity or function integrity. No acceptance-policy change, additional identity query, Windows elevation, admin attestation retry or Reader binding was performed or prepared. Any proposal to explain/evaluate the identity-name discrepancy or revise future attestation acceptance requires independent owner authorization and evidence; none is implied here. **STOP.**
