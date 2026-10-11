# Motakamel Item Identity — direct-port transport only

**Later P2 correction:** [direct transient-login retries disabled and limits verified](MOTAKAMEL_PR12_P2_TRANSIENT_RETRY_FIX_2026-10-11.md)
at `84eadfddfd064ada961e36675ceffe24e33f2f3a`, same PR12, not merged. The original
head/tests/CI below are preserved historically. Broad "no retry" wording is qualified:
direct driver transient-login retries are0, not a guarantee of a single socket.

Date: 2026-10-11, Asia/Aden +03. Owner explicitly approved adapter transport and
maintenance-procedure changes only. **NO YSEDU MAINTENANCE / NO LIVE SQL TEST.**
FIRST LIVE DATA #001 remains **NOT TESTED**. Archive qualification remains paused;
S3 remains ACCOUNTING-BLOCKED. Pilot #001 and Canonical scope are unchanged.

## Implementation boundary

Build baseline is merged PR #11, origin/main `8c22f7b2a1dc251928adc9c7590b551dffddbd5e`.
Implementation is on separate branch `codex/motakamel-direct-port`, commit
`3f7fb6d4c07da3185d1eddda0273b3a55569d83b`, in
[PR #12](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/12) (OPEN, not merged).
This is not a new connector or
import path and does not imply qualification of other Motakamel editions.

The existing `MotakamelPlusItemIdentityConnector` accepts optional `directTcp` with
exactly two data properties: integer `port` (1..65535) and one public
`caCertificatePem`. Unknown keys, accessors, symbols, extra/malformed certificates,
non-CA certificates and invalid ports fail before credentials or pool creation.
There is no default direct port, coercion, arbitrary connection string, host override
or automatic discovery. Caller mutation cannot change the validated copied values.

The supplied CA DER must match the qualified public certificate SHA256
`A3FBC7905425B2E8C10F3A070B8713F876B94FC42B8D1243DEAD5D0F42889472`.
No PFX/password/private key is read or included in this change. Public CA and signed
leaf fixtures are retained only for deterministic tests; the future operator supplies
the separately verified public CA and actual listener port at execution time.

Direct mode sends top-level mssql `port` and **omits `instanceName`**. There is no
SQLBrowser/SSRP fallback or adapter-level retry on failure. The P2 follow-up explicitly
sets direct Tedious transient-login retries to0; other physical connection behaviors
are documented separately. Fixed server `DESKTOP-8QRQT7R`, frozen
database `DBL_HOST_W11_EFA12026_PostS2_Frozen_20261009`, reader
`DBL_HOST_W11_S2_Reader_20261009`, fixed SELECTs, schema/READ_ONLY/permissions guards,
identity mapping, acquisition/replay and cleanup contracts remain unchanged.

TLS retains `encrypt:true` and `trustServerCertificate:false`; explicit
`serverName:DESKTOP-8QRQT7R`, minimum TLS1.2 and a connection-scoped CA list containing
only the approved CA are used. No hostname-check callback or Windows/global Node
trust-store change. Node's explicit `ca` replaces default roots for that connection;
this is not an assertion that certificate loading or real handshake has passed.
[Tedious transport options](https://tediousjs.github.io/tedious/api-connection.html),
[Node22 TLS semantics](https://nodejs.org/docs/latest-v22.x/api/tls.html).

The old named-instance configuration remains compatible when `directTcp` is absent;
it is **not** the selected Host W11 activation path. The legacy opt-in live test was
skipped and must not be presented as a direct-port live qualification. The adapter
does not discover or authenticate administrative listener metadata itself.

## Tests and limits

Node22.23.2 was selected process-locally instead of the agent's default Node24.
No dependency/lockfile, CI severity or Core/Storage/Canonical changes.

- `npm run verify` exited0 on the final full run: build, all workspace typechecks and
  **227 passing tests**, one live test skipped (130 passing in this adapter package).
- 45 SQL transport/config tests cover valid boundaries, invalid ports, CA identity,
  forbidden TLS/host/discovery overrides, immutable input and no retry/Browser
  fallback after a failed direct connection.
- The actual locked mssql12.7.4 → Tedious20.3.3 configuration was inspected through
  real constructors **without connecting**. Only the existing public leaf is used
  with Node's normal hostname verifier (correct name accepted, wrong name rejected).
  This is not a TLS chain/handshake or SQL2014-loading test.
- Mock-wire direct mode uses production adapter code and existing
  Connector → ImportOrchestrator → SQLite → SnapshotReader, yielding only
  `DBL_P001_ITEM_A / DBL_ITEM_A`. Existing restart/replay and regression tests remain.
  **Mock-wire-tested is not live SQL evidence.**
- `npm audit --audit-level=critical` exited0 unchanged. Current registry response
  reports **two moderate entries**, sprintf-js and tedious, in the unchanged
  sprintf-js1.1.3 chain. Prior three-entry audit is historical, not a changed lockfile.
  No forced audit fix/driver downgrade; prior limited reachability analysis is retained,
  not a universal safety claim. The first sandbox audit request failed to reach the
  registry; the subsequent authorized audit completed successfully.
- Initial config-only test timed out while dynamically importing actual SQL libraries.
  Imports were moved to collection; no timeout/TLS/audit gate was weakened.

## Maintenance amendment — supersedes Browser step, NOT execution

This amends step5 of the [activation procedure](DBL_YSEDU_ACTIVATION_READINESS_2026-10-11.md)
and resolves only the architectural Browser dependency in the
[pre-stop hold](DBL_YSEDU_ONE_BOUNDED_MAINTENANCE_2026-10-11.md).
It does not claim NETWORK READY or consume a stop/start cycle.

1. Before a separately authorized execution, review the deployed direct-port code and
   refresh the original settings/signing/DER/key-DACL/service/client/address pins.
   Signed leaf remains `A51BD253B6083D0114428FCFBAD57D008CD102F5`, DER SHA256
   `522C79FD31F0422D3988FB00CC4EF0A51B4042DEED72A435A6519237AC548DFE`.
   Do not re-sign or create a key. Check SQLBrowser is still Stopped/Disabled; do not
   run SSRP, start Browser or change its startup mode. Unknown drift remains STOP.
2. Retain the reviewed one normal YSEDU stop/start cycle (stop limit120 seconds),
   exact existing certificate acceptance/key association, and rollback#002 ownership
   limits. No Force/Kill/Reboot, ACL/trust/Firewall/ForceEncryption or other-instance
   changes. The owner accepted historical recovery and unfinished-transaction limits;
   no new archive work is required or implied.
3. Retain dynamic port selection: YSEDU TCP Enabled1, ListenOnAllIPs0, only IP4
   Enabled1 at freshly verified192.168.56.1, dynamic sentinel0 and empty static port.
   All other IP/protocol settings stay original. **Do not configure a fixed SQL port.**
4. Keep SQLBrowser **Stopped/Disabled throughout**. Absence of Browser discovery or
   an SSRP response is **not a failure/rollback trigger in direct-port mode**.
   No Browser exposure investigation is needed when it is not started. Original
   Browser identity/config drift is still an operational STOP, not permission to repair it.
5. After the one authorized start, independently verify actual SQL ERRORLOG leaf loading
   (not fallback), fresh YSEDU service executable/PID and active TCP listeners.
   Match the SQL listener's owning process to that fresh PID and verify its bound address
   is192.168.56.1, not all interfaces/an unapproved address. Resolve any multiple-port
   ambiguity before choosing a port; capture the actual listener port1..65535. A registry
   port alone or TCP reachability alone is not ownership/certificate proof. Any
   unexpected listener/failed loading is STOP under the existing rollback limits.
6. Supply that **observed** port to the adapter with the qualified public CA; keep
   exact hostname validation. DNS previously had multiple addresses: do not silently
   use an IP hostname/hosts-file override. Qualify the actual route to the approved
   listener; unreachable or differently routed hostname is a specific STOP, not
   permission to enable more SQL addresses or open Firewall.
7. Rollback#002 stays pinned and unmodified; its original Browser Stopped/Disabled
   baseline is compatible with this path. The older guard's allowance for an owned
   Manual/start difference does not authorize that difference in the direct forward
   procedure. Apply is still NOT TESTED, only while SQL already Stopped, with owned
   leaf/network differences only, no private-key deletion, and no unapproved second
   stop/start. Failures needing another cycle require a separate decision.
8. Only after successful loading/listener and strict Node TLS, use the existing
   independent reader. Missing reader password requires explicit reader-only rotation
   approval; never substitute CA/archive/admin credentials. Run only Item Identity
   through ImportOrchestrator→SQLite→SnapshotReader. FIRST LIVE DATA passes only
   from actual SQL evidence of the approved code/name, not these tests.

Remaining gates: fresh administrative maintenance preflight, actual SQL2014 loading,
observed listener/PID/route, strict live TLS, reader secret readiness and actual SQL
import. Revocation and SQL restore remain NOT TESTED within existing lab limitations.

## Publication / outcome

Transport implementation/tests and procedure amendment are complete. Build commit
`3f7fb6d4c07da3185d1eddda0273b3a55569d83b` was pushed and `git ls-remote`
confirmed the same feature-branch head; remote build main remains merged PR11
`8c22f7b2a1dc251928adc9c7590b551dffddbd5e`. PR12 is review-only, no merge/auto-merge.
[CI run](https://github.com/elias-mujally/dbl-legacy-intelligence/actions/runs/38156422172)
completed successfully on that exact head: Ubuntu build/typecheck/tests and original
critical audit all PASSED (finished16:41:22Z); Windows build/typecheck/tests PASSED
(finished16:41:57Z). Audit is skipped on Windows by the **unchanged original workflow**,
not by this change. PR12 remains OPEN/CLEAN, autoMergeRequest=null. CI success is not
independent merge approval or live SQL qualification.
[Non-sensitive local evidence](research/MOTAKAMEL_DIRECT_PORT_TRANSPORT_2026-10-11.json)
distinguishes config/mock tests from live qualification. Final local service reread:
YSEDU Running/Automatic, SQLBrowser Stopped/Disabled. No host action occurred.
**STOP before any YSEDU action.** `.vscode` remains outside commits.
