# V1 operator package — engineering decision and acceptance

Date:2026-10-23. **PASS_OPERATOR_KIT_THREE_ACTUAL_ARTIFACTS_AND_LEGACY_STATE_RECOVERY**. This builds on [the actual changed-data result](THIRD_CAPTURE_RESULT.md); it is not a fourth extraction or another ERP transaction.

[Index](README.md) · [Runbook](RUNBOOK.md) · [File-path ADR](ADR-V1-001-FILE-REFRESH.md) · [Current status](RECURRING_STATUS.md) · [Evidence registry](EVIDENCE.json)

## Decision and delivered interface

**DECISION:** wrap the already qualified compiled file path with a small operator command surface and an Arabic runbook, rather than introduce guest networking, SQL transport, a service, a new desktop application or an installer. Existing `v1:refresh` remains compatible. No connector semantics, Canonical schema, migrations or ERP source data are changed; no new dependency is installed.

The product entry point is `npm run v1:operator -- help`. Commands:

| Command | Scope and output |
|---|---|
| check | Independent source SHA-256, bounded identity/profile qualification, quantities/value and limitations; no DBL state creation |
| import | Existing durable refresh protocol, write-once run receipts, archive/audit, replay and ordering guards |
| status | Existing-state admission lock, inventory/history versus retained sources, audit and integrity checks; no migration, source repair or data update |
| report | New private escaped Arabic HTML with current quantities/value, capture time/history/hashes/audit; no scripts or external resources |
| backup | New private complete recovery-content copy, manifest published last, per-file hash/size validation; no overwrite or pruning |
| verify-backup | Requires independently recorded manifest SHA-256, then validates bounded paths/files/hashes and business/history consistency |
| restore | Requires pinned manifest; copies DBL state only to a new separate directory and validates it. Never replaces an active state or restores ERP |

Product guide: `docs/V1_OPERATOR_GUIDE_AR.md`; source is `apps/v1-file-import/src/operator.ts` and `operator-cli.ts`. The unchanged reviewed collector remains `tools/v1/Acquire-V1Inventory.txt`. Operator copies its full text into ordinary guest PowerShell, retains JSON/hash independently and transfers the original bytes through an already permitted route. No elevation, policy change, credentials, network/shares or terminal automation through Computer Use is implied. Fixed source guards are retained; this is not a configurable connector for other ERP databases.

## Data safety and recovery choices

The operator package coordinates with the existing control.sqlite admission transaction and refuses a concurrent writer. Diagnostics use bounded serialized SQLite images in memory, with integrity/FK checks and comparisons of each persisted product observation to its exact retained qualified source. They do not initialize or migrate unknown storage. Missing successful audit completion for a saved snapshot, unresolved started attempts or pending publication evidence prevent a healthy-state claim. The package does not delete evidence to make a check pass.

**FACT — development finding:** a normal SQLite readonly disk open created empty WAL/SHM files in synthetic tests. Initial unchanged-file and backup assertions failed. Switching to memory inspection initially exposed SQLITE_CANTOPEN for WAL-format headers. SQLite's documented deserialize adaptation of bytes18/19 was then applied **only to the private RAM copy**, after refusing nonempty WAL or any rollback journal. Original files and backup bytes remain unchanged. [SQLite primary reference](https://www.sqlite.org/c3ref/deserialize.html).

**DECISION:** refuse live/uncheckpointed WAL rather than infer main-file freshness, checkpoint, merge or remove sidecars. Empty WAL and derivative SHM are omitted from recovery content without deleting originals; all database/archive/qualification/receipt bytes are copied exactly. The state must be quiescent under the managed writer protocol, with no external writer bypassing it. A failed/incomplete backup without its final manifest is retained but not qualified. Existing/overlapping destinations, redirected ancestors, unexpected files, traversal paths, limits or hash mismatches stop without overwrite/repair.

Backup limits are1024files,128MiB per file and512MiB total, within the small fixture. POSIX destination privacy is checked without chmod. Windows ACL privacy remains owner-provisioned; `.gitignore`/mode bits are not ACL proof. Use private local storage outside Git/shared/cloud locations. Both backup and restore are DBL-state operations, distinct from the previously qualified ERP BAK restore and outside-VHDX retention. No physical-media, full-host or power-loss durability guarantee is added.

## Measured acceptance

**FACT:** nineteen independent compiled operator CLI processes exercised the three preserved actual acquisitions and a separately copied successful operational state. Source files and all original operational-state file hashes remained unchanged. Actual acquisitions remain3; the original operational state still has11importer invocations and3snapshots, not the invocations made in temporary/copy acceptance states.

- Three source checks and sequential imports admitted the known1470/1470/1450SAR history. Third/second/first replays retained3checkpoints,5current products,29/3/50/2/12 and1450SAR.
- Status independently checked all source/product observations and audit after separate-process import. The new acceptance state has6completed imports/18successful audit events. The Arabic HTML result was generated and byte-hashed; escaped-content controls verify no injected script or external resource.
- A copy of the successful pre-package state, containing11completed imports, passed status without changing its file hashes. Backup produced33recovery-content files and a separately pinned manifest. Verification passed, restore created another separate state, and replaying the oldest actual source there kept3checkpoints/1450SAR. The restored copy has12completed imports; the original remains11. Backup and source bytes stayed unchanged.
- Focused synthetic controls exercise independent hash rejection, data corruption despite structural integrity, retained-source corruption, missing audit completion, competing admission, pending evidence, nonempty WAL refusal, manifest pin/path/hash tampering, destination refusal, offline HTML escaping and sanitized CLI errors. A redirected-ancestor control runs on POSIX; Windows skips it without privilege changes.
- Build/typecheck and the affected application's46passed/4skipped tests passed with all three actual artifact gates enabled. Final complete local workspace build/typecheck and430passed/42skipped tests also passed. Remote CI is tracked separately in the publication receipt; private source files remain absent from public CI.

Private evidence retains the acceptance harness, command outputs, compatibility copy, backup/manifest, restored copy, report, test logs and failed development-iteration explanations. Public memory stores evidence IDs/byte counts/hashes only. Do not infer a fresh SQL extraction, a new ERP change or generic backup compatibility from these existing-file tests.

## Advisory review on product PR20

Graphify submitted seven deterministic coupling/fan-out advisories, without a reported functional failure. They were reviewed against this operator model rather than treated as automatic refactoring requirements:

| Function / metric | Engineering disposition and practical evidence |
|---|---|
| locked / coupling15 | Retain one shared existing-state admission lifetime across diagnostics/copy operations. Busy-writer refusal, no-bootstrap checks and finally-based rollback/close are the practical contract. Splitting entry-point wrappers solely to lower the metric would duplicate the critical-section boundary. |
| inspect /9callees | A bounded source/storage/audit/history verifier intentionally composes independent checks. Corrupt archive/product/audit controls and actual three-source history readback exercise the risks; no cross-layer cycle or ERP writer is introduced. |
| entries /6callees | Manifest construction owns name/type/size/hash/quiescence checks in one path. Traversal/hash tampering, unexpected destination and retention bounds are checked rather than bypassed through separate walkers. |
| backupV1State /11callees | This is an ordered transaction coordinator: admission, source validation, fresh destination, exact copy, recheck, then final manifest. Keep the manifest-last and no-overwrite invariant visible; actual copied-state backup/recovery and refusal controls pass. |
| verifyV1Backup /6callees | Independent external manifest pin, bounded paths/files and internal business/history reconciliation are intentionally separate validations. Coherent internal hashes alone are not trusted. |
| restoreV1State /7callees | Ordered verify/new-directory/copy/recheck orchestration. Existing-state overwrite is forbidden and tested; oldest actual replay into restored state preserves current. |
| reportV1State /7callees | Coordinates a verified read with escaping and write-once offline rendering. Script escaping/CSP/no-overwrite and unchanged-source controls exercise the actual output risks. |

**DECISION:** no metric-only runtime refactor. These advisories are not proof of data corruption, a security defect or a requirement to dismiss a blocking review. They remain visible for human architectural review; no review submission was dismissed. Future growth or demonstrated testing/lifetime problems can justify splitting modules by responsibility. The code review and CI readbacks are distinct from the actual private-artifact acceptance evidence. Historical-doc staleness hints based only on generic local identifiers such as json/entries/run were checked against scope: these are new operator helpers, not modifications of the old ERP/storage functions discussed by those historical reports. Those reports were not rewritten solely on identifier matches.

## Handover and remaining work

The guide covers prerequisites, guest extraction boundaries, independent hash checking, one state path, pre-import backup, result interpretation, exit codes0/1/2, error actions, retrying the same pinned file and restore to a new path. Receipts/archive locations are described relatively; precise owner locators stay private. Runtime/build/lockfile and capture-time provenance must travel with the handover; do not rewrite migration fingerprints to force compatibility.

**LATER FACT:** a separate agent without inherited investigation context completed16checks/25first-attempt successful CLI calls from the published guide and declared inventory. [Independent handover and gaps](OPERATOR_HANDOVER.md). This differs from the engineer's19processes above. Human, clean-install and browser review remain unqualified. There is no standalone runtime bundle, automated extraction/transfer, service, live least-privilege SQL, broad ERP support or production-scale qualification. Owner-private Windows ACL readiness was not established by the synthetic handover; the prepared-build requirement persists.

Recommended next slice after the independent agent handover: stabilize a versioned Windows delivery/build manifest, then test a human or clean-environment handover with privacy readiness and visual report review separately established. Live constrained SQL is a distinct future authorization. [Product PR20](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/20) and [memory PR9](https://github.com/elias-mujally/dbl-products-memory/pull/9) stay unmerged pending owner approval. At the tested revision, local/published tree61a4729cda90589063b8e0d44fc66ab3cd44300f matched; product commit60a4b36e0e34d24e5ef51afaff01798e7473e733. Initial PR9 readback had no submitted reviews, inline threads/comments or workflow runs; this is not a CI pass or owner approval.


## Portable manifest-order follow-up

The initial operator revision passed429local tests and CI219 on both platforms, with17compiled acceptance calls. Further review identified locale-dependent manifest sorting and strict array-order equality as a portability risk. Two focused tests failed before the fix: canonical ASCII path-order expectation and verification of a trusted same-files manifest in another order. New manifests now use a fixed ASCII comparator; verify/copy compare normalized entry order while keeping the original pinned manifest bytes/hash intact. Identity/uniqueness/path/size/hash checks are unchanged, and no prior backup is rewritten.

Final complete local build/typecheck and430passed/42skipped tests passed, with46passed/4skipped in the app. Nineteen compiled actual-artifact/copy acceptance calls additionally verified and restored the actual initial-revision manifest without changing that backup. New manifest SHA-256F304A6FFEF6F75205B974EB12AFB5B6CA284ED9EB9FB5FC30C5BD27533E8E7F4; prior independently pinned manifest E670502B172836888A5A8E31E3366A92BBA00327FA22FDD2153CA7B8927A79D8 remains valid. This is a backward-order compatibility proof, not a Windows locale/security setting change or a claim of arbitrary future build compatibility. Final-head CI is recorded separately from the superseded CI219 evidence.

**FACT — final CI220 passed** on product head60a4b36e0e34d24e5ef51afaff01798e7473e733: Windows and Ubuntu locked install, build/typecheck/tests and ten Worker/native-WAL cycles each; Ubuntu critical-threshold dependency audit also passed. [Exact final-head CI](https://github.com/elias-mujally/dbl-legacy-intelligence/actions/runs/39925783325). Private actual artifacts remain absent from CI. The bot's partial static COMMENTED review belongs to the initial40351a7 head, not a formal proof or new final-head test. Seven coupling advisory threads remain visible; no changes-requested review was dismissed or merge performed. Product PR20 is ready for owner engineering review within these bounds; memory PR9 is prepared separately and still requires independent merge approval.
