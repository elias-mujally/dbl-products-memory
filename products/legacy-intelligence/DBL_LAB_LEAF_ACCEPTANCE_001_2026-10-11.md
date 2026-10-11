# YSEDU — Lab revocation policy + one ordinary Leaf acceptance

Date: 2026-10-11, Asia/Aden. Previous Product Memory: `0bbaab6`.
Status: **OWNER POLICY ADOPTED; TOOL QUALIFIED; OWNER ADMIN EXECUTION PENDING**.
**Root addition / Leaf acceptance NOT EXECUTED in this preparation turn.**
SQL certificate loading, TLS/login and FIRST LIVE DATA #001 remain **NOT TESTED**.

## Explicit laboratory decision

The owner's new authorization supersedes only the previous helper's requirement
for positive CRL/OCSP evidence before retaining this exact lab CA. UNKNOWN remains
an accepted **revocation-assurance gap**, never GOOD/not-revoked, PASSED or production
readiness. Required signature, trust, validity, ServerAuth and hostname checks stay
strict. No Windows revocation policy, TLS flag or Connector behavior changes.

The experiment permits one ADD_NEW of the exact public CA to LocalMachine Root,
followed by one ordinary `certreq -accept -machine` for the current leaf while
YSEDU remains running. No CA private key/PFX, new key/cert/CRL, SQL interruption,
binding, network/Firewall/Browser, ACL, Connector, Canonical, login or import.
Machine Root is **additive machine-wide trust**, visible to Windows consumers,
not YSEDU-only or Node-exclusive trust. Accepted single-host CA custody risks remain.

| Pinned input | Identity |
| --- | --- |
| Public CA thumbprint | `121CDC9857488ED95F4BC62106D7672BB0DBC6C3` |
| Public CA DER SHA256 | `A3FBC7905425B2E8C10F3A070B8713F876B94FC42B8D1243DEAD5D0F42889472` |
| Leaf thumbprint | `A51BD253B6083D0114428FCFBAD57D008CD102F5` |
| Leaf DER SHA256 | `522C79FD31F0422D3988FB00CC4EF0A51B4042DEED72A435A6519237AC548DFE` |
| Existing CSR SHA256 | `61B48D26A1AFB37B27ACF0EFDFAA1D90A29B9A39B2F012E0DA7367046E19B889` |
| Existing pending request thumbprint | `079AF9D20802BD4A16B862928194A77BC14B93F4` |

## Qualified implementation, not enrollment proof

New bounded scripts reuse the previously qualified, unchanged native chain
reader, exact owned Root writer and CSP24 existing-provider metadata reader.
No diagnostic framework or new native crypto implementation was introduced.

- [Execution helper](research/DBL_LAB_LEAF_ACCEPTANCE_001_Invoke-LabLeafAcceptance001.ps1)
  SHA256 `6543E75163B28413FE7276C1E291DA6F9ECB2A900A3CA3EAEA513B683102C4F9`.
- [Owner administrator launcher](research/DBL_LAB_LEAF_ACCEPTANCE_001_Start-LabLeafAcceptance001.ps1)
  SHA256 `7E4D86FDC02F45166EF630E164623BED0A2E1A722081ED2A0BDF70E526D0F6EC`.
- [Pure guard tests](research/DBL_LAB_LEAF_ACCEPTANCE_001_Test-LabLeafAcceptance001.ps1)
  SHA256 `E09DD17188EC5D0602DBCEE0B1FB2B05C29C5447D20421EA380E37EF89B562B9`.
- [Preparation observations](research/DBL_LAB_LEAF_ACCEPTANCE_001_PREPARATION.json).

The review copies above are byte-identical to the three executable task files
under `outputs/host-first-live-data-001-20261010/`; hashes were compared.
The launcher is not portable setup: it is pinned to this owner/host/runtime and
the existing task artifacts, requiring a manually opened administrator console.

35 pure guard tests passed: independent seven-store vectors, strict hostname/
trust/element errors, separate actual captured revocation observations, rejection
of revoked/mixed errors, and no rollback after pending-request consumption.
These tests execute extracted pure guards only, not the operational script body.
Helper and launcher CheckOnly passed without stores/services/native mutations or
certreq. Public CSR signature parsing and CSR/Leaf public-key equality passed
with RSA2048 and no private-key access. Previously qualified native calls were
not replayed to manufacture a new acceptance result.

The agent token is nonadministrative `DESKTOP-8QRQT7R\CodexSandboxOffline`.
A read-only original-registry check reached a protected registry target and
received access denied; CIM service enumeration also received access denied.
Neither is evidence of settings drift. Full current administrative baseline,
existing key metadata/security, and services are **PENDING owner execution**.
No automatic elevation, UAC workaround or substitution of administrative SQL.

## Exact runtime gates and one-call boundary

1. Fresh PS7 x64 7.6.5 owner admin process; pinned runtime/certreq/native sources
   and prior evidence; no existing result/baseline/attempt marker overwrite.
2. Exact public CA/Leaf pins, current validity, SHA256 public signatures and
   existing signed CSR. No secrets needed. CA/Leaf absent from seven store views;
   six historical store fingerprints intact, one exact machine Request certificate.
3. Baseline seven views: CU Root/CA/My; LM Root/CA/My/Request. Save exact entries,
   service PID/state/account/path, original owned SQL/TCP/Browser registry values,
   CSP24 machine KeySpec1 provider linkage and qualified DACL hash. Key locator
   remains memory-only. Recheck before mutation; no source permissions change.
4. CreateNew attempt marker then **one ADD_NEW** pinned CA, with the exact returned
   owned context retained for safe limited rollback. Expected Root-only delta in
   machine Root and its user-visible inherited view; no other store differences.
5. Both native Windows engines, no additional issuer, zero ignore flags: exact
   Leaf→CA, required chain/element/BASE/SSL errors zero and checked hostname
   `DESKTOP-8QRQT7R`. Separately request cache-only revocation excluding Root.
   Only pure UNKNOWN/OFFLINE-UNKNOWN on the leaf is permitted by this decision.
   REVOKED, other validation errors or API failure STOP, not accepted exceptions.
6. Fresh settings/services/key/pins and marker before one ordinary certreq child:
   exact arguments `-accept -machine <current leaf DER path>`. No `-f`, untrusted
   flags, policy suppression, prompt bypass or retry. Bound wait 60 seconds; no
   kill. Timeout preserves state and defers rollback while the process may run.
   Driver/tool raw stdout/stderr are not published; numeric exit status is recorded.
7. Require exit zero, exact LM My Leaf DER/HasPrivateKey, same existing CSP24
   provider/storage linkage and unchanged key DACL, CSR public-key match, exact
   Request consumption, no other seven-view delta, unchanged SQL PID/service/
   registry settings and all prior artifact pins. Then retain Root and STOP.

Marker/result names are `LAB_LEAF_ACCEPTANCE_001_{BEFORE,ATTEMPT,CERTREQ_ATTEMPT,RESULT}.json`.
No marker/result existed during preparation; executing the attempt consumes this
bounded procedure even if a later gate fails. Do not rerun after failure.

## Rollback and later removal

Failure before acceptance or an unchanged failed acceptance permits only removal
of the exact Root context created by this helper **if** seven stores prove a
Root-only delta and services/settings/key are unchanged and certreq is not active.
Verify all seven baseline views afterward. Never delete the leaf, existing key,
original request, prior certificate or recreate an enrollment request.

If certreq consumed the request, installed a partial leaf, is still running, or
any other state changed, **defer cleanup and report the exact safe phase/code**.
Do not pretend enrollment is fully reversible. Disposing certificate/provider
handles is not deleting a persisted key. Cleanup errors remain separate from
the primary failure; they prevent a PASSED result.

On success retain the exact approved Root. Its later removal requires a separate
owner decision after confirming dependencies and exact DER/thumbprint ownership;
remove only that entry, never keys/other roots. Review trust withdrawal on suspected
CA/leaf compromise and renewal before the leaf expires on 2027-04-09. Manual
response is not equivalent to automatic CRL/OCSP protection.

## Current checkpoint

`Lab Revocation Policy = OWNER APPROVED (THIS HOST/EXPERIMENT ONLY)`.
`Leaf Acceptance = NOT EXECUTED — OWNER ADMIN HANDOFF`.
`SQL Certificate Loading / Strict Node TLS / FIRST LIVE DATA = NOT TESTED`.

Next action is owner execution of the pinned launcher once, returning the final
safe JSON. No password required. Result must be verified before updating this
checkpoint. Any later SQL binding/maintenance/live test needs separate approval.
Prior failures/evidence remain intact; archive paused, S3 frozen, `.vscode` excluded.

**STOP pending the authorized administrative handoff/result.**
