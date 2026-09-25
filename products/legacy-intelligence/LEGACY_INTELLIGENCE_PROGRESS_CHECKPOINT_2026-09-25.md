# Legacy Intelligence — Progress Checkpoint — 2026-09-25

**Status:** Stage A Windows 11 Computer Use qualified; Motakamel Stage B blocked by host storage. This is a lab/platform milestone, **not** Motakamel connector, partner, or pilot qualification.

## Product and pilot direction

DBL remains a local/offline-first, V1 read-only intelligence layer:

`Legacy ERP -> system-specific connector -> import/orchestration -> local SQLite snapshot -> deterministic query/insight layer -> Application Service -> focused UI / future constrained AI`

Keep system-specific connectors and implement first, abstract second. Preserve exact decimals, currency-safe semantics, bounded processing, source/snapshot provenance, a consistent acquisition snapshot, and deterministic authority over AI. No universal SQL connector, generic mapping DSL, or schema-inspector product expansion is authorized. A DBL reader must not use FMMA or `WITH (NOLOCK)` as a shortcut to access or consistency.

The primary first connector target remains **YemenSoft Motakamel Plus ERP**. [Pilot Learning Contract #001](PILOT_LEARNING_CONTRACT_001_PURCHASE_ATTENTION_ITEM_INTELLIGENCE_2026-09-06.md) remains **Purchase Attention + Item Intelligence**: help a human identify an item worth review, assemble its purchasing context, decide the next human action, and reduce navigation across ERP screens. DBL does not purchase autonomously or choose the supplier/quantity. [Multi-Lens Product Direction](MULTI_LENS_PRODUCT_DIRECTION_2026-09-06.md) remains broader product direction, not a scope expansion for this pilot.

The later [Controlled Dataset to Design Partner Strategy](CONTROLLED_DATASET_TO_DESIGN_PARTNER_STRATEGY_2026-09-10.md) supersedes the September 6 *representative-data-before-any-code* sequencing. A narrowly reconciled educational capability may be implemented as **LAB-PROVEN**; representative authorized partner data is still required for **PARTNER-VALIDATED**, and an operational/user-value pilot for **PILOT-QUALIFIED**. These levels must not be collapsed. The [Controlled Dataset #001 plan](CONTROLLED_MOTAKAMEL_DATASET_001_PLAN_2026-09-10.md) separates per-capability implementation gates from an early end-to-end lab demo and a broader declared lab slice. Neither the plan nor Stage A claims a qualified Motakamel mapping.

## Controlled Motakamel Dataset #001 — current facts

These are **official-UI educational-lab observations**, not yet an SQL-to-canonical mapping or connector claim. The source/reference lab is `DBL-MotakamelPlus-Lab`; no manual SQL business writes or direct FMMA-based DBL modifications were used for the listed records.

| State | Observed value and limit |
|---|---|
| Unit A | `UA` / `DBL_UNIT_A`, created and verified through the official UI. |
| Group A | `001` / `DBL_GROUP_A`, created and verified; existing inventory account `1141010001` used. No new account or Account Numbering workflow was required. |
| Inventory currency | `SAR` in the investigated educational context. |
| Item A (S1) | `DBL_P001_ITEM_A`; Arabic name `DBL_ITEM_A`; Group `001`; Unit `UA`; primary-unit package `1`. Saved once and reloaded/verified through official UI. |
| Item numbering | The manual item identifier was accepted; no group-numbering change or Account Numbering setup was needed. Item type was left empty; no supplier, price, cost, barcode, or unrelated master data was added. |
| Pre-/post-S1 preservation | `P001-S1-Pre-Item-A` and `P001-S1-Post-Item-A` are registered Standard checkpoints. The post-S1 checkpoint ID is `2d045664-b5d4-41a7-851f-4889e18a3b37`. |

The S1 persistence check proves the bounded UI-created item identity in this lab. It does **not** by itself prove the source row/column mapping, frozen-snapshot reconciliation, stock balance, purchase semantics, or a production connector capability. Those gates remain per capability.

**S0b status correction:** inbound-only UI/help discovery **began** after the post-S1 checkpoint on 2026-09-21, then paused when work shifted to the Agent Lab. The official supply-order help was observed to say stock changes on save and accounting effects follow posting; no inbound form/required-prerequisite qualification was completed. **S0b is partial, not “not started” or READY FOR S2. S2 has not started; no inbound transaction was saved.** S0c and S3 have not started. Do not advance a quantity or purchase capability from this partial discovery.

## Direct Computer Use experiments

### Windows 10 Agent Lab — preserved diagnostic, not root-cause closure

`DBL-MotakamelPlus-Agent-Lab` is an independent clone of the controlled post-S1 Motakamel state. Guest Codex exposed `mcp__node_repl__js -> @oai/sky -> Windows application`. `GL.exe` was directly enumerable and activation worked, but screenshot/state capture failed globally, including Explorer, with `SetIsBorderRequired`, `0x80004002 / E_NOINTERFACE` (“No such interface supported”). No Motakamel input was sent in the blocked direct-input PoC. Windows.Graphics.Capture / Windows 10 build compatibility is a hypothesis, **not** a proven sole cause. The Windows 10 Agent Lab remains preserved; its retirement has not been approved.

### Windows 11 Stage A — qualified only for Windows app capture/input

`DBL-MotakamelPlus-W11-Agent-Lab` is a separate Generation 2 VM (ID `e2054379-aaac-4a6b-9703-c9ec8c22ab96`) with 4 vCPU, 8 GiB RAM, Secure Boot, vTPM, and independent storage. The official Windows 11 25H2 Arabic x64 medium was identified as build `10.0.26200.8037`, ISO SHA-256 `10BF2F86F148D6CF06BDFFE3010C413187C72516A49EB61B3643977EFFC52D14`. The installed edition is Windows 11 Pro 25H2.

**`W11 COMPUTER USE QUALIFIED — STAGE A`:** Guest Codex and `mcp__node_repl__js` were available; `@oai/sky` imported. Explorer enumeration/activation and screenshot capture worked. Notepad screenshot capture, mouse input, keyboard input, and visibly exact text `DBL_W11_COMPUTER_USE_POC` were demonstrated. The test content was not intentionally saved. The earlier `SetIsBorderRequired / 0x80004002` failure was not reproduced in this Stage-A environment. This is evidence for the Windows 11 Computer Use surface, not proof that Windows 10 alone caused the earlier failure.

Registered checkpoints, rechecked on 2026-09-25:

| Checkpoint | ID | Parent |
|---|---|---|
| `W11-C0-Clean-PostInstall` | `10f06fd3-8ddf-4ff2-acf2-292a727abd72` | None |
| `W11-C2-StageA-ComputerUse-Qualified` | `c76de620-6025-4e5a-a896-c35086d5218c` | `W11-C0-Clean-PostInstall` |

**Not yet demonstrated:** Motakamel installation or GL.exe capture/input on Windows 11. Stage A must not be promoted to Motakamel compatibility.

## Storage gate and lab preservation

Stage B is the later Windows 11 educational Motakamel/SQL installation followed by direct `GL.exe` capture/input qualification. **Stage B has not begun.** Host `D:` capacity is its immediate gate, not S0b/S2.

After verifying no registered VM, checkpoint, attached disk, or VHD parent depended on an orphan VHDX from a failed earlier Windows 11 install, that **one orphan file** was deleted. The measured recovery was approximately `24.816 GiB`; no registered active VM/checkpoint disk was deleted. Latest measured `D:` free space was approximately `31.339 GiB` versus a Stage-B planning target of at least `50 GiB`, leaving approximately `18.661 GiB`. These are capacity-planning measurements, not a license to delete another lab.

A subsequent read-only retirement/partition audit concluded **`ALMUHASEB1 RETIREMENT DOES NOT SOLVE D CAPACITY`**. `DBL-AlMuhaseb1-Lab` remains Off and preserved. Its verified VHDX/AVHDX chain occupies at least `28.332 GiB` on `C:`; VMRS/VMGS/configuration footprint was not measurable with the available read permissions. Both volumes are partitions of the same NVMe disk, but normal Windows extension geometry does not turn freed C: files into D: capacity. The key AlMuhaseb1 Product Memory and proof-of-path outputs exist outside the VM, yet full preservation of every unique guest/checkpoint state has **not** been established. Retirement is therefore not evidence-safe now.

The Windows 10 Motakamel Agent Lab and the Motakamel Reference Lab remain preserved. The Reference Lab remains network-disconnected. Storage alternatives require a separate decision: supply other/external D: capacity, or independently qualify any future Windows 10 Agent Lab retirement. Neither lab is approved for deletion by this note.

## Explicitly open gates and next sequence

- No Motakamel-specific connector implementation or Motakamel business mapping is qualified by these experiments. The existing DBL backend/reference adapter is not a Motakamel connector.
- No representative Design Partner data has been obtained, and no supervised customer pilot has occurred.
- The Windows 11 Agent Lab has no Motakamel or SQL Server educational installation yet, and `GL.exe` has not been tested there.
- S0b is partial; S2 has not started. No controlled purchase/receipt, outbound movement, or Purchase Attention demand semantics are proven by Item A.
- Customer Account Numbering is not required for the proven Item A path and remains off the current Pilot #001 critical path.

Current order: **resolve Stage-B host capacity -> retain the qualified W11 Stage-A checkpoint -> install the educational Motakamel/SQL environment in the W11 Agent Lab under separate authorization -> qualify direct GL.exe capture/input -> then resume the controlled Pilot #001 evidence path at the appropriate incomplete capability.** No connector, Canonical Model, or broader ERP workflow change is authorized by this checkpoint.

## Evidence anchors and precedence

- Product direction: the linked Pilot Learning Contract, September 10 Controlled Dataset-to-Design-Partner Strategy, Controlled Dataset #001 plan, and [Independent Full Product Review](INDEPENDENT_FULL_PRODUCT_REVIEW_2026-09-06.md).
- Earlier Motakamel access/isolation and topology: [Motakamel V1 Evidence Progress Checkpoint](MOTAKAMEL_PLUS_PROGRESS_CHECKPOINT_2026-09-03.md).
- AlMuhaseb1 historical findings: [AlMuhaseb1 Lab Progress](ALMUHASEB1_LAB_PROGRESS_2026-09-01.md) and separately preserved proof-of-path artifacts in the investigation workspace. Their existence does not certify a full VM/checkpoint backup.
- The S1 official-UI verification and S0b start/pause are recorded in this task history; the post-S1 and W11 checkpoint identities were rechecked in Hyper-V. Storage/free-space and partition conclusions came from the read-only host audit. These operational observations are not partner validation.

Historical 2026-09-03/06 documents retain their original “next step” language. Where sequencing differs, this dated checkpoint and the accepted September 10 strategy describe the later state; historical reports are not silently rewritten.
