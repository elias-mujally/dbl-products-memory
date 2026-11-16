# Native Shared Memory helper evaluation — 2026-11-15

## Later development and laboratory status — 2026-11-16

**DOCUMENTED / SUPERSEDED as current remaining-work list:** this evaluation records the original isolated prototype. Its 13 offline tests, lack of SQL Open/Execute or real credential-file input, build-size and startup measurements still describe that prototype only. The prototype was preserved, not silently turned into the production candidate. Its original text remains below.

**DECIDED + VERIFIED — later local development and saved offline evidence:** the owner subsequently approved functional/security parity development, not production replacement. A separate C#/.NET Framework 4.8 candidate and explicit Node selection now implement the credential-file, source/authority, bounded-query, transaction and timeout/cancellation paths listed as future work below. The [parity record](../native-helper-parity/README.md) documents the 94 C# fake-session, 269 connector and 178 Desktop passes and their limits. These are distinct from the prototype's 13 tests and are not actual SQL authentication, negotiated TLS, live permissions or SQL rollback/cancellation evidence. The code remains local and uncommitted above product main `2f24efa`.

**VERIFIED — saved execution evidence:** the Windows 10/net48 guest inventory and strict LPC Open failure `0x80090325` were followed by acceptance of one replacement CA on 16 November. Acceptance is not Root trust, a SQL leaf, binding/start or successful TLS. The C# DLL used for PKI verification is not the ERP helper EXE. See [current state](../../CURRENT_STATUS.md) and the [PKI sequence](../self-contained-lab/PKI_PHASE1_20261116.md); no live checks were repeated for this documentation review.

**PLANNED / UNVERIFIED:** signing and trusted distribution, target Windows/SQL qualification, actual guest ERP/source and reader authentication/permissions, approved side-by-side deployment and end-to-end acquisition/persistence/reopen/refresh remain gates. Retain PowerShell and TCP; no automatic helper/transport fallback or production replacement is authorized. The dated engineering recommendation below remains a historical evaluation, not a new architecture decision or authority for the next laboratory phase.


Status: **ISOLATED OFFLINE PROTOTYPE; NO REPLACEMENT APPROVED OR DEPLOYED**.

Owner scope: evaluate a standalone Windows executable and implement an isolated proof of concept, with offline tests. No SQL/environment changes, production-helper replacement, VM deployment, merge or publication are authorized. The [accepted dual-transport ADR](../../DECISIONS/ADR-001-SQL-SERVER-DUAL-TRANSPORT.md) remains unchanged.

## Evidence and implementation

Code repository: `elias-mujally/dbl-legacy-intelligence`, experiment `experiments/native-shared-memory-helper-poc/`. Baseline HEAD `2f24efa50b71c4d91667dc12049c7a6ecc9e70b8`, working branch `codex/direct-erp-workspace-20261114`, including existing uncommitted Shared Memory work. This record does not claim that the experiment or the prior Shared Memory work is merged into main. Memory baseline HEAD: `99bb8dc7054244a245feedb64fc1280fa6f9f44e`.

The small C# 5 executable targets Windows x64/.NET Framework 4.8 and is built with the existing Framework compiler. It launches without a PowerShell script. It is managed IL/JIT, not Native AOT or runtime-self-contained. No SDK installation was needed. Native AOT was evaluated from primary documentation, not compiled or measured.

13 offline tests passed: actual EXE launch and JSON contract, synthetic CurrentUser DPAPI and tamper checks, explicit LPC/TLS connection-string settings, existing Node source/authority/nonce/canonical rejection checks, malformed input/error redaction, EXE/config hash mismatch, and synthetic acquisition through the existing persistence/audit/application/Desktop services with two snapshots, failed-refresh preservation and reopening. No visible GUI test or actual SQL connectivity is established.

There is deliberately no SQL Open/Execute path, real credential-file input or live mode. A distinct synthetic response wrapper is unwrapped only by the experiment's offline test adapter. No production routing imports that adapter. DPAPI self-test is not real credential-store compatibility. SqlClient settings are not negotiated TLS evidence. Fixture rollback/authority fields are fabricated test material, not SQL observations.

Two builds had identical source hashes and probe behavior but different EXE bytes/timestamps. The available legacy compiler lacks deterministic mode. Build procedure repeatability is established; byte reproducibility is not. The unsigned EXE plus CLR config totaled 13,986 bytes (EXE 13,824); this is a synthetic prototype, not a production size estimate. Twelve host-only startup samples per process, after warm-up exclusion and alternating order, gave EXE median 185.5 ms and PowerShell 280.6 ms. Unequal probe work and host-only measurements prevent SQL/VM performance conclusions.

## Evaluation recommendation, not a new approved architecture decision

Prefer a narrow C#/SqlClient executable port as the next engineering candidate. Retain the current PowerShell implementation unchanged until parity and live acceptance are explicitly approved. Do not add permanent automatic dual-helper fallback or a generalized connector framework. A Framework-targeted candidate minimizes the current laboratory's runtime/deployment gap; provider, target OS and SQL Server support/servicing still require qualification before a product support commitment. Modern .NET/self-contained/AOT should be revisited if supported deployment requirements justify their SDK, package and compatibility costs.

Remaining implementation: actual source/transport/effective-permission checks before and after the bounded read, least-privilege SQL authentication, same-user protected credential-file handling and ACL checks, transaction/timeout/cancellation, strict TLS/provider qualification, approved executable signing and trusted bundle/config pin distribution, explicit Node selection and source provenance compatibility. Preserve the TCP connector and the existing Canonical/SQLite/Audit/Application Service/Desktop pipeline.

Remaining laboratory gates: verify the ERP application's actual database and source identity; verify reader login/user/SID/grants and authentication; qualify certificate chain/name/negotiated TLS; authorize executable delivery and side-by-side installation; then prove live read, persistence, restart, refresh and failure safety. Prior laboratory certificate/policy observations are historical and were not refreshed by this evaluation. No execution-policy change is required by the candidate packaging, but application-control restrictions still need ordinary approval.

Local review artifacts are `outputs/NATIVE_SHARED_MEMORY_HELPER_EVALUATION_AR.md`, `NATIVE_HELPER_POC_TESTS.log`, `NATIVE_HELPER_PIPELINE_BUILD.log`, `NATIVE_HELPER_MEASUREMENT.json`, the build manifests and baseline/final preservation records in the evaluation workspace. Raw private laboratory inventory and credential material are not copied into product memory. Effort estimate in the report is planning judgment, not a delivery commitment.
