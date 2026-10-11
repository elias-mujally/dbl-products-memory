# PR #12 — P2 transient-login retry correction

Date: 2026-10-11, Asia/Aden +03. Owner authorized this limited fix/tests/publication,
not merge or YSEDU maintenance. **FIRST LIVE DATA #001 = NOT TESTED.**

## Exact correction

Prior head `3f7fb6d4c07da3185d1eddda0273b3a55569d83b` omitted Tedious's transient-login
retry setting. The default in the locked Tedious20.3.3 driver was3: the previous
"no retry" wording did not establish absence of driver-level retries.

New head **`84eadfddfd064ada961e36675ceffe24e33f2f3a`** adds exactly one production
line inside the **direct-only `options` branch** in `source.ts`:
`maxRetriesOnTransientErrors:0`. mssql12.7.4 `_config()` forwards that options value
unchanged; real Tedious construction observes0. It is not a top-level connection
option or a pool option. [Official Tedious option](https://tediousjs.github.io/tedious/api-connection.html).

The legacy named-instance branch leaves the option absent, with effective driver
default3 and original behavior unchanged. No dependency/lockfile/workflow changes.
TLS encrypt=true/trustServerCertificate=false/name/pinned CA/minimumTLS1.2 and
explicit-port/no-instanceName remain unchanged. No source guard/SELECT/identity,
Canonical, ImportOrchestrator, SQLite or SnapshotReader production change.

## Independent tests and additional retry inspection

- Existing real mssql→Tedious configuration test now requires effective0 in direct
  mode, while retaining exact TLS/port/CA assertions. This is not a mock-only assertion.
- Two real Tedious Login7-handler cases use six independent error-number literals
  (4060,10928,10929,40197,40501,40613). With the actual driver/lookup, initial direct
  errors are not marked transient; legacy errors remain transient with effective3.
  Source inspection confirms that flag controls the transient retry branch. No socket,
  TLS handshake or real login is exercised.
- A real mssql/Tarn pool control-flow test replaces physical create/destroy only with
  virtual resources. It observes the successful probe then one failed acquire, with
  `propagateCreateError:true` and no repeat for that acquire after the scheduling
  interval. This is not a proof of all pool failure/concurrency schedules.
- Default ImportOrchestrator plus real SQLite/mocked source failure observes one
  source call, no `import.retry`, non-retryable error and no committed snapshot.
  An arbitrary external custom retry policy or new caller invocation is not covered.

**Other physical-connection behaviors still exist and were not silently redesigned:**
mssql probes/destroys an initial connection and later acquires pooled resources;
default validation uses `SELECT 1;` and Tarn can replace an invalid free resource.
Tedious can try sequential DNS addresses and follow server-provided routing tokens.
The adapter's health and acquisition sessions are intentionally separate. These
can produce extra sockets/handshakes, not automatic re-execution of failed Item SQL
or replay of a completed import in the inspected default paths.

Inspected files in the locked stack: mssql `lib/tedious/connection-pool.js`
(`_config`, `_poolCreate`, `_poolValidate`), `lib/base/connection-pool.js` (`_connect`,
`acquire`), `lib/tedious/request.js`; Tarn `dist/Pool.js` (`_doCreate`, invalid-resource
validation); Tedious `lib/connection.js`, `lib/token/handler.js`, `lib/connector.js`;
existing adapter and default ImportOrchestrator retry policy.

No automatic failed Item SELECT/import replay was found in those paths. This is
not a blanket **one physical connection attempt** guarantee; live DNS/routing,
validation failures and packet-level retry behavior remain NOT TESTED. A stricter
socket-attempt budget would need a separate decision, not widening this P2 patch.

## Verification and publication

Node22.23.2: `npm run verify` exited0 — Build, all Typechecks, **231 tests passed**,
one live test explicitly skipped. Adapter134 tests include49 transport/control-flow
tests. `npm audit --audit-level=critical` exited0 unchanged; two moderate entries
remain in the unchanged tedious→sprintf-js chain. No forced audit fix or lowered gate.

The same PR was updated: [PR #12](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/12).
New branch head was pushed and verified with `git ls-remote`; build remote main stayed
`8c22f7b2a1dc251928adc9c7590b551dffddbd5e`. No merge/auto-merge.
[CI run for this head](https://github.com/elias-mujally/dbl-legacy-intelligence/actions/runs/38158174952)
completed successfully on the exact new head. Ubuntu build/typecheck/tests and
original critical audit PASSED (finished17:06:16Z); Windows build/typecheck/tests
PASSED (finished17:07:27Z). Windows audit remains skipped by the unchanged original
workflow. PR remains OPEN/CLEAN, autoMergeRequest=null; CI success is not merge approval.
[Non-sensitive evidence](research/MOTAKAMEL_PR12_P2_TRANSIENT_RETRY_FIX_2026-10-11.json).

**P2 correction implemented; final merge decision remains with the owner after checks.**
No YSEDU/SQLBrowser/certificate/network/ACL/ERP action or actual SQL connection.
S3 remains ACCOUNTING-BLOCKED; archive work remains paused. `.vscode` excluded.
STOP after publication; no host maintenance is implied by successful tests.
