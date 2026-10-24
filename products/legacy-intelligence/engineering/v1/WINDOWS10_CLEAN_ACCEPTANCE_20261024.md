# Windows10 Clean Compatibility — consolidated acceptance

Acceptance dated2026-10-24; review completed2026-10-25. **Bounded compatibility PASS; customer-data pilot NOT YET QUALIFIED.** This curated record supersedes the October23 statement that no independent Windows environment was available. Earlier reports and their qualification flags remain historical evidence, not current pending status.

[Remaining gates and execution order](V1_REMAINING_GATES_20261024.md) · [Off-host backup proposal](OFFHOST_ENCRYPTED_BACKUP_PLAN.md) · [Delivery baseline](WINDOWS_DELIVERY.md) · [Prior independent-agent handover](OPERATOR_HANDOVER.md)

## Proven behavior and source of proof

| Area | Actual result | Proof class and limit |
| --- | --- | --- |
| Independent guest | Windows10 Pro22H2, build19045.3803, x64; separate compatibility VM without ERP/development-tool installation in the exercised handoff | Owner provisioned; GUI observations and runtime receipt. No universal clean-image attestation or security certification |
| Ordinary user | Active Standard account; runtime adminToken=false | Observed account type plus actual runtime token; not an ACL audit |
| Resources and isolation | Generation2;2vCPU/fixed4GiB; dynamic60GiB disk; network disconnected at qualification | Prior exact-target UI observations. No new inventory or settings change in this review; host headroom had been low and needs fresh measurement before another workload |
| Integrity and extraction | ZIP independently pinned before bundled code execution; Explorer extraction to Arabic/spaced path;83payload hashes/84files including manifest matched | Owner-run checks and observed result; package unchanged |
| Native operation | Actual DBL.cmd verify/doctor; bundled Node22.23.2/x64/ABI127 and SQLite3.51.3 loaded | Tested on this image only; not current dependency-security or all-Windows compatibility proof |
| Full file workflow |18calls through DBL.cmd passed in a new state: three source qualifications/imports, current/old replay, history/reopen, HTML, backup verification, separate restore/reopen and restored replay | Owner executed pinned companion; agent inspected terminal/receipt. Fixed authorized synthetic fixtures, not a fourth ERP extraction |
| Business result | Five current products: T01=29,T02=3,T03=50,T04=2,T05=12; total1450SAR; history1470/1470/1450 | Successful pinned companion assertions and inspected receipt summary. Original/restored audit assertions15then18events;5then6completed invocations |
| Report appearance | Arabic connected, RTL correct, five items/value1450,tables/hashes readable, no overlap or unexpected private content | Owner browser attestation only. Browser/version matrix, narrow viewport, zoom, accessibility and independent agent visual inspection not established |
| Four-file evidence retention | ACCEPTANCE.json, current-reopen.stdout.json, restored-replayed-reopen.stdout.json and generated HTML retained outside guest VHDX; guest originals preserved | Owner R3 PowerShell Direct run reports source-before/source-after/host hash equality and private-boundary checks; agent independently pinned and validated only the intentionally shared limited receipt. Owner subsequently accepted closing this gate |

The private vault, originals, full receipts and provenance manifests must **not** be opened, probed, enumerated or hashed by agent tools. They are neither published here nor registered with public locators. Limited receipt validation is not independent agent analysis of those originals. The transfer session was closed according to the owner result; no settings/ACL/network/Defender changes formed part of the approved transfer. Outside-VHDX retention on one physical host is not off-host recovery.

## Immutable baseline and reproduction contract

- Preview version: `0.2.0-v1-win-x64-preview.1`.
- ZIP SHA-256: `6729624255A3DA224C49E5BD4DF2E6F322C14A2D73F43B6032A580DC31405CB2`.
- Manifest SHA-256: `7F57E60D97F1ECCC16DEAA9DDFE606BCBA63AED377FC33A42EE823F6D7946626`.
- Separate companion SHA-256: `9C67B08D9A3332BAD75CFC072B89E25E6818E99BAEBF274F52501F797029B3ED`.
- Follow the [published Arabic procedure](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/tools/windows-delivery/CLEAN_WINDOWS_AR.md) with approved retained synthetic inputs and new output paths only. Independent package pins precede bundled runtime execution. State and package pins have different purposes.

This review did not rerun the package, recalculate originals, rebuild Preview1, perform an extraction, or modify ERP/state. Private custodian metadata resolves evidence IDs `w10-clean-full-acceptance-observation`, `w10-clean-full-acceptance-comparison`, `w10-clean-owner-visual-retention-attestation`, `w10-owner-private-r3-limited-result` and `w10-owner-private-r3-result-assessment`; only sanitized metadata belongs in the public registry. The original automatic qualification flags remain false; attributed supplemental evidence closes only its specific gate.

## Blockers and lessons preserved

- Long VMConnect clipboard text was rejected before DBL execution; no numeric clipboard limit or DBL failure inferred. Guest-local copied text/helper handoff worked; host-to-guest Copy-VMFile did not supply a reverse-copy route. Temporary integration service on the approved helper transfers was restored.
- R1 retention helper wrongly demanded user ownership despite trusted SYSTEM ownership. Read-only metadata established the overstrict guard; no permission repair was needed.
- R2 authentication failed after host credentials were used. The owner confirmed this; it was not proof that PowerShell Direct transport was broken. R3 used privately entered guest credentials and a fresh owner-private destination with a deliberately shared limited receipt.
- Observed inherited sandbox access did not meet the requested private-original boundary. Its origin/timing was not established. The successful separate vault model does not qualify ordinary DBL state/input/report directories.
- The native policy-fixture harness rejected by ExecutionPolicy was not bypassed or passed. Static source parsing/reproduction and actual owner R3 execution are separate evidence classes.

## Boundaries that remain

Windows use rights/activation/security coverage, owner-private operational folders, Defender and target security-policy behavior, current dependency risk, independent human handover, supported-Windows clean acceptance, off-host encrypted recovery and production readiness remain open. A previous no-context second **agent** passed a prepared-build handover; the project-aware owner running this companion is not a blind human operator.

The connector remains file-based and fixture-specific. Consumption issue is not commercial sale; issue return is not customer return; an unapproved purchase request is not received inventory. Direct SQL transport, enforced least-privilege source identity, final GL posting, broad accounting/document support, variable-cost/customer-scale behavior and power-loss recovery are not qualified. No new ERP or historical-source capability is implied.

## Repository verification

Live GitHub readback confirmed product [PR21](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/21) merged as `bccc89ecb077b11ec5476b82a222ed9c4a3487b9` and memory [PR10](https://github.com/elias-mujally/dbl-products-memory/pull/10) as `3d2768680af4483be0412466d67c7785b07d1d04`. Before publication, memory main advanced to `86beaf03cceac4e39acc1d194a1577f41b749d70` through a separate customer-discovery note; this documentation proposal preserves that new work. Those merges were observed, not performed here. Older publication/unavailable-environment statements are historical; this review authorizes a documentation PR only, no merge or binary release.
