# Independent Windows qualification — environment gate open

23 October 2026. **PASS_PREPARED_HOST_CMD_REHEARSAL; BLOCKED_CLEAN_ENVIRONMENT_NOT_AVAILABLE.**

[Index](README.md) · [Immutable preview](WINDOWS_DELIVERY.md) · [Runbook](RUNBOOK.md) · [Evidence](EVIDENCE.json) · [Product acceptance procedure](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/codex/v1-windows-delivery/tools/windows-delivery/CLEAN_WINDOWS_AR.md)

## Decision and boundary

**FACT:** the owner confirmed there is no independent clean Windows machine or empty VM currently available. V1 contains ERP and is not a clean target; historical labs remain out of scope. No VM/account/network/security/permission setup was performed. A new profile or reduced PATH on the prepared host would not establish a clean Windows image.

**DECISION:** preserve Preview1 ZIP/manifest/payload exactly. Add a separately pinned acceptance companion and Arabic procedure outside the archive. It is specific to the three authorized retained synthetic artifacts. This enables later operator execution without a developer checkout while recording each acceptance gate independently. Do not rebuild over the original version or treat a successful harness as human acceptance.

The companion requires the bundled Node, built-in Windows PowerShell, pinned ZIP/unmodified extracted payload, three fixed source hashes and a new local output directory. Every product operation runs through DBL.cmd with System32-only child PATH. No npm/Codex/Git/compiler/SQL Server, package installation or network is used by the delivered workflow. Absolute local paths, no redirected ancestors, no shell expansion characters, fixed fixture sizes/pins and never-existing output are checked before work. All failure outputs are preserved without retry, cleanup or repair. No operational-state original or ERP is touched.

## New measured evidence

**FACT — engineer rehearsal only:** existing prepared Windows11 build22631, AMD64, admin token=false. Eighteen actual DBL.cmd calls passed from Arabic/spaced paths for package, inputs, new state, HTML, backup and restored state. Source checks and three chronological imports produced three snapshots/five products29/3/50/2/12 and1450SAR; historical values1470/1470/1450 remained. Current/oldest replay added no snapshot and did not roll current state back. New backup pin/verify/new-directory restore and separate-process reopen matched15audit events/5imports; restored historical replay then reopen matched18/6. Package/source inventories remained unchanged. This adds no source acquisition or ERP transaction.

**FACT — separate extraction check:** pinned ZIP was freshly extracted with the built-in framework to another new Arabic/spaced path after entry path/count/size checks.84entries/89,345,803expanded bytes including manifest. Actual wrapper verify and doctor passed: Node22.23.2/x64/ABI127/SQLite3.51.3 on this host. The two wrapper checks are separate from the eighteen-call companion, not a second independent operator run. Explorer extraction, another Windows version and absence of development software were not observed.

**FACT — controls:**8passed/0skipped delivery tests with the real package explicitly enabled. Two new guards exercise literal PowerShell operand quoting and refusal of remote/relative/shell-expansion paths; six prior package/native/tamper/privacy controls still pass. An initial asset-disabled run was4passes/4skips, not full qualification. The prior430workspace passes/42skips remain earlier preview evidence; no new whole-suite count is claimed.

**FACT — static report checks only:** Arabic lang/RTL/value markers present; no script/external-resource attribute, server-name marker, Windows path or credential marker in this generated report. These bounded assertions neither replace visual inspection nor establish general customer-data privacy. Exact private report/receipt/command-output pins are retained by the owner.

## Refusals and unresolved requirements

| Gate | Observed result | Remaining action |
|---|---|---|
| Independent Windows | Owner has none available | Arrange clean supported Windows x64 later under separate environment approval |
| Ordinary account | Host token is unelevated | Repeat on the declared clean target with an ordinary user, document provisioning |
| DLL/native compatibility | Loaded on build22631 only | Run verify/doctor on target; do not silently install missing DLLs |
| ACL privacy | Read-only ACL observation of new state/backup/restore/report showed multiple sandbox identities with inherited modify access | Synthetic data only; not owner-only privacy; no permission edits |
| Defender | Get-MpComputerStatus returned Access denied | No retry/elevation/scan success claim; owner records allowed protection/signature/scan evidence on target |
| Browser visual | Browser Use rejected local file protocol; only HTTP/HTTPS allowed and no indirect/alternate-surface workaround permitted | No screenshot or visual pass; owner manual local-browser review requested separately |
| Human | Engineer scripted rehearsal | Guide-only human handover still untested |
| Production | Security/privacy/clean/human gates open | No production or public-release qualification |

**DECISION:** do not start a local web server, switch browser surfaces, disable protection, unblock files or add exclusions to evade refusal. The acceptance JSON deliberately leaves cleanMachineQualified/humanAcceptanceQualified/productionQualified/privacyAclQualified/defenderQualified/browserVisualQualified=false even after PASS. Separate owner attestation can supplement evidence but must retain its source and cannot be relabelled as agent-observed visual evidence. No native/OS root cause is inferred from a policy refusal.

**Subsequent FACT — owner-reported basic visual review:** the owner manually reviewed the new rehearsal HTML and reported Arabic/RTL correct, five-item balances/tables/1450SAR legible and hashes clear without overlap. Record **PASS_OWNER_REPORTED_BASIC_VISUAL_REVIEW** separately from the agent's blocked browser attempt and unchanged earlier automatic receipt. No screenshot/browser name/version/narrow-window/zoom/accessibility observation was provided. This closes the owner's basic visual check only; it does not qualify a full human workflow, clean machine, private ACL, Defender or production.

## Current GitHub correction and publication

Live readback showed product PR20 merged at [34717b6bbdedc473b0cabe1c32ea11004623e204](https://github.com/elias-mujally/dbl-legacy-intelligence/commit/34717b6bbdedc473b0cabe1c32ea11004623e204) and memory PR9 at [0fc051148670444aa9d774a3d9857b8c3e40ea9b](https://github.com/elias-mujally/dbl-products-memory/commit/0fc051148670444aa9d774a3d9857b8c3e40ea9b). Both main branches matched the respective merge, and reviewed heads compared with zero changed files to main. This stage observed, rather than executed, those merges. Prior open/unmerged statements are historical snapshots, superseded here. Current packaging work is prepared as separate PRs on top of these main trees; no force, new merge or binary/public release.

## Reproduce later

Resolve evidence IDs and independent pins from EVIDENCE/private custodian registry. Follow the product Arabic procedure: establish clean environment/security/private storage, hash ZIP before Node executes, hash companion independently, extract to new Arabic/spaced path, use fixed synthetic inputs and a new sibling output. Run the companion using bundled Node. Review18command outputs, native doctor, current/history/audit, backup pin and restore results; manually view the local Arabic HTML in an allowed browser at wide/narrow/zoomed layouts. Retain all output privately. Never repeat an ERP transaction or alter source timestamps to fix acceptance. A later clean-machine pass and later human pass must be recorded independently; neither is implied by this prepared-host rehearsal.
