# Private Windows delivery — engineering preview

2026-10-23. **PASS_PRIVATE_PORTABLE_BUILD_AND_RELOCATION_CLEAN_WINDOWS_AND_HUMAN_NOT_TESTED.** This is the engineer's next stage after [independent prepared-checkout handover](OPERATOR_HANDOVER.md), not a second human handover, new ERP acquisition or public release.

[Index](README.md) · [Package](OPERATOR_PACKAGE.md) · [Runbook](RUNBOOK.md) · [Evidence registry](EVIDENCE.json)

**Later update:** [independent Windows gate](WINDOWS_CLEAN_GATE.md) records a new18-call actual-wrapper rehearsal, fresh ZIP extraction and8delivery controls, while clean environment/ACL/Defender/browser/human gates remain open. Live GitHub now shows PR20/PR9 merged; open/local-only wording in the historical preview-stage review below is superseded by that dated observation. The original Preview1 archive/pins remain immutable.

## Final review of the existing PRs

**FACT:** product PR20 at a5faaf02eeec588fb93ef9329341adc52685cdaf is open/unmerged with successful [CI221](https://github.com/elias-mujally/dbl-legacy-intelligence/actions/runs/39931368523). Windows/Ubuntu build/typecheck/tests and10Worker/native-WAL cycles passed; Ubuntu critical-threshold audit passed. Seven coupling advisories remain visible with specific replies; no changes-requested review was present at readback. Memory PR9 at524a2150b77a14ab51d2c565c5ebc2c1a1c68080 is open/unmerged; no configured workflow/submitted approval, not a CI pass. Its140pins/119relative links and documentation match the independent16checks/25calls result and explicit limits.

**RECOMMENDATION:** engineering merge readiness of those exact PRs within their bounded scope, subject to separate owner approval and repository checks. No merge performed. New delivery work lives on separate **local** codex/v1-windows-delivery branches in product/memory; neither reviewed PR head was replaced and no preview/release asset was published.

## Architecture decision

**DECISION:** portable folder/ZIP with a pinned existing Node22.23.2 x64 runtime and physical compiled runtime modules, not an installer or npm setup on the user's machine. No Codex, Git, compiler, npm, service, global PATH, policy/ACL change or network is needed for operation. Builder requires the existing qualified development checkout/runtime/dependencies; it installs/downloads nothing.

The general connector entry eagerly imported mssql through historical SQL transport. The application now uses an explicit v1-inventory subpath exporting the same existing file connector/profile. The old API remains, while the delivery includes only the two file modules and excludes mssql/SQL/Azure dependencies. Accounting, source guards, Canonical/migration formats and existing ERP data are unchanged. Twelve components comprise Node, eight DBL modules and three SQLite loader/runtime packages. Full copied Node/third-party notices are retained; DBL remains private owner evaluation, not implicitly open-licensed.

Files: DBL.cmd; launcher.cjs; runtime/node.exe; app with physical modules; licenses; Arabic START_HERE; NOTICE; BUILD_INPUTS.json; MANIFEST.json. No ERP binaries/collector/raw/state/credentials are shipped. Manifest records version/source revision/tree/compiler inputs/OS architecture/Node ABI/components/normal PE DLL import names and every payload file's SHA-256/size. Manifest itself is pinned outside the folder; ZIP hash is supplied independently before executing Node/launcher. Hashes are not signatures, compiler/bootstrap trust or vulnerability proof.

The wrapper clears inherited Node options/global search settings in its own process. Every data operation verifies the independently pinned manifest and exact bounded file set before forwarding to the existing CLI. Absolute non-UNC data paths outside the payload and explicit private-storage acknowledgement are required. Path syntax/acknowledgement do **not** certify Windows ACL, cloud absence or mapped-drive locality; owner readiness remains necessary. doctor loads SQLite in memory only, and stops on missing DLL/native failure rather than installing anything. Diagnostics/exit codes/retry/recovery constraints remain documented in Arabic.

## Immutable preview identity and measured tests

- Version0.2.0-v1-win-x64-preview.1; assembly source local commit2855006575d0cee38ed4e3007379487de622e076/treec61a94ca97fb6b2c43c8b7a11d9f5c562119cecd. Test-only correction commitcd7d445cdcb6815a3b1b124a6b384b4c891d8c3e did not alter that delivered payload. These are local engineering commits, not published GitHub release identifiers.
- 83payload files/89,327,788bytes; ZIP34,320,900bytes. Manifest SHA-2567F57E60D97F1ECCC16DEAA9DDFE606BCBA63AED377FC33A42EE823F6D7946626; ZIP SHA-2566729624255A3DA224C49E5BD4DF2E6F322C14A2D73F43B6032A580DC31405CB2.
- Two fresh JavaScript builds/assemblies produced identical payload/manifest. Two sorted/fixed-time framework ZIPs matched on this host. This is repeated assembly with identical qualified native inputs, not a from-source Node/native/compiler bootstrap or all-machine bit reproducibility proof.
- Extracted Arabic/space path, system-only PATH and disabled global module search passed. Native doctor showed Node22.23.2/ABI127/SQLite3.51.3 on the existing Windows build22631 host; actual DBL.cmd passed with deliberately invalid inherited NODE_OPTIONS/NODE_PATH. This is a prepared Windows host relocation test, not Windows10/clean-machine qualification.
- 23engineer CLI calls:3retained real checks/imports;5current products29/3/50/2/12 and1450SAR;3histories1470/1470/1450; replay/no rollback; HTML generation/static check; pinned backup/new-path restore/reopen/audit; prior11-import successful-state copy status/backup/restore/replay. All37original state files, source pins and payload files unchanged. No ERP transaction or fourth acquisition.
- Complete workspace build/typecheck/430passed42skipped with3private source gates;6delivery-control tests passed with0skips, including pin/hash/traversal/unexpected-file/privacy/path refusals. These are engineer tests, separate from prior independent handover.
- Two additional readonly DBL.cmd calls accepted quoted Arabic/spaced source paths and current-state status, preserving3snapshots/1450SAR. They supplement, rather than replace, the23-call harness and actual wrapper doctor probe; no old-source import or human acceptance is implied.

## Failure, rejected hypothesis and bounded correction

The first enabled delivery-control suite aborted a test child with exit3221226505. Individual verify/native/pin/privacy cases passed; the changed-payload test alone failed. A standalone recursive fs.cpSync probe reproduced the abort before returning, so Node:test itself was not a necessary cause. Setting NODE_TEST_CONTEXT in a standalone verify probe did not reproduce failure; that hypothesis is not accepted.

The test now copies its bounded regular-file inventory with copyFileSync, retaining the same adversarial assertions. All6controls passed; no delivered runtime file, Node version, security setting or permission changed. The native C++/Windows root cause is **not established**. Failed suite/isolation/probe/fixed logs are retained; do not relabel the initial failure a pass or claim SQL/native-binding causation. Production backup/restore and assembly already use explicit file/content copying, not that recursive test setup.

## Reproduce and recover

Use the preserved assembly revision/qualified runtime and locked existing dependencies. Engineer runs verify, then delivery:build with existing runtime/new absolute output; builder refuses dirty source/existing destination, compiles fresh JS and copies only compiled paths derived from tracked sources. archive.mjs verifies the manifest, uses framework ZIP with sorted/fixed-time entries, leaves failures for inspection and records external ZIP/manifest pins. Run delivery:test with explicit package-directory/pin to enable actual package controls; absent assets yield explicit skips. Exact private paths/harness/command outputs are in the custodian register, not Git.

Human reads the packaged START_HERE only: independently hash ZIP before execution, extract to new trusted local folder, verify/doctor with independent manifest pin, confirm private storage, check/import chronological sources into one new state, status/report, known-current/old replay, backup/independent backup pin/verify/restore to new path/reopen. Package pin and backup pin differ. Never fix an import by repeating an ERP document, changing timestamps/checksums, deleting sidecars or weakening privacy. Preserve previous builds/states; restore chooses a new path and never overwrites/cuts over automatically.

## Open gates and publication scope

**UNQUALIFIED:** clean supported Windows x64 with actual DLL/security-policy readiness, owner-private Windows ACL, human/visual/accessibility acceptance, trusted/signed public delivery process, native-from-source build, production security/scale/general ERP semantics/live least-privilege SQL. Node's [platform reference](https://github.com/nodejs/node/blob/v22.23.2/BUILDING.md) and [full notices](https://github.com/nodejs/node/blob/v22.23.2/LICENSE) inform prerequisites; they do not certify this package on every target or establish latest-patch security. Normal PE imports alone do not prove every runtime/delay-loaded DLL is available.

**NEXT:** provide this local preview plus independently recorded pins to a human on a separate clean Windows x64 environment, after owner privacy/security readiness. Observe startup/DLL behavior, guide-only imports/recovery and Arabic visual report. No additional ERP change is needed. Creating/configuring that environment, installing redistributables, changing permissions/network, public release and merging remain separately authorized actions. New code/docs/evidence are local and sanitized; no new GitHub publication occurred in this stage.
