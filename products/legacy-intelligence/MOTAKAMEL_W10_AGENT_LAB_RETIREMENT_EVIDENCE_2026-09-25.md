# Motakamel Windows 10 Agent Lab — Computer Use and Retirement Evidence — 2026-09-25

**Decision:** `WINDOWS 10 AGENT LAB RETIREMENT REQUIRES EVIDENCE PRESERVATION`. This is an evidence inventory, **not** authorization to remove a VM, checkpoint, or disk. The external findings are durable, but a bounded guest-local diagnostic-artifact inventory could not be completed. No VM was started or deleted for this review.

## Identity, lineage, and current storage

| Property | Read-only observation |
|---|---|
| VM | `DBL-MotakamelPlus-Agent-Lab`; ID `647826a6-bd48-4a1f-9776-a6064075e4d0`; Off; Generation 2; configuration version 11.0; 4 vCPU; startup RAM 4 GiB. |
| Network | Independent dynamic-MAC adapter on Default Switch. This is **not** the disconnected Reference Lab. |
| Configuration/checkpoint storage | Dedicated `D:\Hyper-V\DBL-MotakamelPlus-Agent-Lab` tree; smart-paging location also points inside that tree. |
| Checkpoint | One registered Standard checkpoint: `AGENT-C0-Post-S1-Pre-Codex`, ID `6ff58e5d-1f31-49d3-a0aa-9c2a3b258377`, created 2026-09-21. |
| Active disk | One independent differencing AVHDX (21,799,895,040 file bytes) whose parent is the base VHDX (15,908,995,072 file bytes), **both inside the Agent Lab tree**. The base has no parent. Each advertises a 100 GiB virtual capacity; that is not consumed host storage. |
| Other files | Two VMRS, two VMGS, and two VMCX files. Eight files total under the dedicated tree, totaling **39,882,685,616 bytes = 37.143645 GiB** by file length. |

The VM ID, directory, disk chain, and checkpoint differ from `DBL-MotakamelPlus-Lab` and `DBL-MotakamelPlus-W11-Agent-Lab`. Their currently attached disks are in their own directories. The Agent Lab VHDs were not attached during the final check.

The Agent Lab was cloned independently from the controlled post-S1 Motakamel state to test direct in-guest Computer Use. The disconnected Reference Lab remains Off and retains `P001-S1-Post-Item-A` (ID `2d045664-b5d4-41a7-851f-4889e18a3b37`) and the prior controlled lineage. The externally documented S1 state comprises Unit `UA` / `DBL_UNIT_A`, Group `001` / `DBL_GROUP_A`, and Item `DBL_P001_ITEM_A` / `DBL_ITEM_A`. No later Agent Lab business action is documented; the controlled state is not uniquely required from this clone on available evidence. This is **not** a byte-level database comparison.

## Externally preserved experiment result

The intended topology was **Guest Codex -> `mcp__node_repl__js` -> `@oai/sky` -> local Windows application / `C:\EFA\GL.exe`**, avoiding host VMConnect/RdpViewer as an input intermediary.

The task history and [Legacy Intelligence Progress Checkpoint](LEGACY_INTELLIGENCE_PROGRESS_CHECKPOINT_2026-09-25.md) preserve the following bounded observations:

- `@oai/sky` imported, reported a Windows target, and could list apps/windows. `GL.exe` appeared directly with the Motakamel window title `Main Menu`.
- Window activation worked for Motakamel and Explorer. Screenshot/state capture failed for **both** applications, so the capture failure was global to those tested Windows targets, not demonstrated to be GL-specific.
- The observed failure was `SetIsBorderRequired failed: No such interface supported (0x80004002 / E_NOINTERFACE)`. Reset/reimport/reacquisition did not resolve it. No Motakamel mouse/keyboard input was sent after the capture failure.
- The result was `DIRECT MOTAKAMEL COMPUTER USE BLOCKED`, later narrowed to `CAPTURE FAILURE IS GLOBAL`. A Windows.Graphics.Capture / Windows 10 build compatibility relationship is plausible, **not proven as the sole root cause**.
- Later Windows 11 Stage A demonstrated Explorer/Notepad capture and input; it did **not** test Motakamel or prove Windows 10 alone caused the earlier failure.

The exact guest Computer Use plugin build, local configuration, diagnostic logs, and any guest-local screenshots/notes were **not independently inventoried** in this review. Do not silently promote the summarized result into a complete forensic record.

## Rebuildability and preservation gap

| Dimension | Assessment |
|---|---|
| Exact VM state | Would be lost upon retirement; not byte-for-byte reconstructible from this record. The guest-local diagnostic inventory remains unverified. |
| Functional experiment | Rebuildable in principle from the preserved Reference Lab/S1 checkpoint, independent clone procedure, verified educational installer (`EFA6_EDU_Gold.exe`, SHA-256 `1DE2B3556E43465EDDEE847BA194024CFA7AFE9400C6523D510869A22CE2994C`), available Windows 10 installation media, and documented guest-Codex/Sky path. This does not guarantee the same plugin/runtime failure on a later build. |
| Useful knowledge | The tested target, API path, successful enumeration/activation, failure boundary/code, cross-app scope, and unproven causality are preserved externally here and in the task history. |

A temporary **read-only** mount of the Off Agent Lab's active AVHDX was attempted for a bounded diagnostic-file inventory, but Windows refused it before attachment with `0x80070522` (“A required privilege is not held by the client”). The disk remained unattached and the VM remained Off. No fallback mount, guest startup, or credential access was attempted. Consequently, absence of unique guest-local logs/configuration **has not been proved**. The minimum remaining preservation action is a separately controlled read-only inventory of the guest's Codex/Computer Use diagnostic artifacts and version/configuration identifiers, with credentials, tokens, cookies, and personal session data excluded. If a privileged read-only mount remains unavailable, a manually authenticated normal guest boot and graceful shutdown is the supported alternative; do not update Windows, Codex, or Motakamel.

## Conditional storage projection, not deletion approval

The measured `D:` free space at review time was **33,649,692,672 bytes = 31.338718 GiB**. If an independently authorized, proper Hyper-V retirement later removes only the Agent Lab and its checkpoint/disk files, the directory's **39,882,685,616 file bytes (37.143645 GiB)** are the nominal reclaimable footprint. The arithmetic projection is **73,532,378,288 bytes = 68.482364 GiB** free, about **18.482364 GiB** above the 50 GiB Stage-B planning gate. Actual reclaimed allocation must be measured afterward; file length need not equal allocated clusters or account for filesystem overhead. Stage B has not begun.

**Do not remove the VM yet.** First close the guest-local evidence gap and make an explicit decision accepting any loss of exact VM state. Then recheck every registered VM/checkpoint/VHD dependency and current free space immediately before a separately authorized retirement. The Motakamel Reference Lab must remain disconnected and preserved; the W11 Agent Lab must remain untouched.
