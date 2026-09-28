# Motakamel Windows 10 Agent Lab — Computer Use and Retirement Evidence — 2026-09-25

**Final state (2026-09-28):** `WINDOWS 10 AGENT LAB RETIRED + STAGE-B STORAGE GATE SATISFIED`. Retirement followed separate explicit authorization and fresh Hyper-V dependency checks. The preceding evidence qualification recovered the guest Computer Use bundle identifier and checked narrow diagnostic locations; some exact runtime versions remain unknown. The retired VM's exact disk/session state is intentionally no longer available. The technical findings remain preserved below and in the task history.

## Identity, lineage, and pre-retirement storage

| Property | Read-only observation |
|---|---|
| VM before retirement | `DBL-MotakamelPlus-Agent-Lab`; ID `647826a6-bd48-4a1f-9776-a6064075e4d0`; Off after the final normal shutdown; Generation 2; configuration version 11.0; 4 vCPU; startup RAM 4 GiB. Registration and dedicated storage were removed on 2026-09-28. |
| Network before retirement | Independent dynamic-MAC adapter, formerly on Default Switch and disconnected (`SwitchName` empty) before removal, like the separately preserved Reference Lab. |
| Configuration/checkpoint storage | Dedicated `D:\Hyper-V\DBL-MotakamelPlus-Agent-Lab` tree; smart-paging location also points inside that tree. |
| Checkpoint | One registered Standard checkpoint: `AGENT-C0-Post-S1-Pre-Codex`, ID `6ff58e5d-1f31-49d3-a0aa-9c2a3b258377`, created 2026-09-21. |
| Active disk | One independent differencing AVHDX (**21,833,449,472** file bytes after final shutdown) whose parent is the base VHDX (15,908,995,072 file bytes), **both inside the Agent Lab tree**. The base has no parent. Each advertises a 100 GiB virtual capacity; that is not consumed host storage. |
| Other files | Two VMRS, two VMGS, and two VMCX files. The dedicated tree totaled **39,916,240,048 bytes = 37.174895 GiB** by file length after the final shutdown. |

The VM ID, directory, disk chain, and checkpoint differ from `DBL-MotakamelPlus-Lab` and `DBL-MotakamelPlus-W11-Agent-Lab`. Their registered disk paths remain in their own directories. The Agent Lab VHDs were not attached during the final check.

The Agent Lab was cloned independently from the controlled post-S1 Motakamel state to test direct in-guest Computer Use. The disconnected Reference Lab remains Off and retains `P001-S1-Post-Item-A` (ID `2d045664-b5d4-41a7-851f-4889e18a3b37`) and the prior controlled lineage. The externally documented S1 state comprises Unit `UA` / `DBL_UNIT_A`, Group `001` / `DBL_GROUP_A`, and Item `DBL_P001_ITEM_A` / `DBL_ITEM_A`. No later Agent Lab business action is documented; the controlled state is not uniquely required from this clone on available evidence. This is **not** a byte-level database comparison.

## Externally preserved experiment result

The intended topology was **Guest Codex -> `mcp__node_repl__js` -> `@oai/sky` -> local Windows application / `C:\EFA\GL.exe`**, avoiding host VMConnect/RdpViewer as an input intermediary.

The task history and [Legacy Intelligence Progress Checkpoint](LEGACY_INTELLIGENCE_PROGRESS_CHECKPOINT_2026-09-25.md) preserve the following bounded observations:

- `@oai/sky` imported, reported a Windows target, and could list apps/windows. `GL.exe` appeared directly with the Motakamel window title `Main Menu`.
- Window activation worked for Motakamel and Explorer. Screenshot/state capture failed for **both** applications, so the capture failure was global to those tested Windows targets, not demonstrated to be GL-specific.
- The observed failure was `SetIsBorderRequired failed: No such interface supported (0x80004002 / E_NOINTERFACE)`. Reset/reimport/reacquisition did not resolve it. No Motakamel mouse/keyboard input was sent after the capture failure.
- The result was `DIRECT MOTAKAMEL COMPUTER USE BLOCKED`, later narrowed to `CAPTURE FAILURE IS GLOBAL`. A Windows.Graphics.Capture / Windows 10 build compatibility relationship is plausible, **not proven as the sole root cause**.
- Later Windows 11 Stage A demonstrated Explorer/Notepad capture and input; it did **not** test Motakamel or prove Windows 10 alone caused the earlier failure.

The historical run's exact `@oai/sky`, Node, and ChatGPT app versions were not recovered; the later guest inventory below identifies the installed Computer Use bundle seen at harvest time. Do not silently promote a later cache version into proof of the earlier failing run's exact version.

## Rebuildability and preservation gap

| Dimension | Assessment |
|---|---|
| Exact VM state | Lost upon the separately authorized retirement; not byte-for-byte reconstructible from this record. Guest-local bundle identity and narrow diagnostic-location observations were harvested; exact application/session state was not retained. |
| Functional experiment | Rebuildable in principle from the preserved Reference Lab/S1 checkpoint, independent clone procedure, verified educational installer (`EFA6_EDU_Gold.exe`, SHA-256 `1DE2B3556E43465EDDEE847BA194024CFA7AFE9400C6523D510869A22CE2994C`), available Windows 10 installation media, and documented guest-Codex/Sky path. This does not guarantee the same plugin/runtime failure on a later build. |
| Useful knowledge | The tested target, API path, successful enumeration/activation, failure boundary/code, cross-app scope, and unproven causality are preserved externally here and in the task history. |

A temporary **read-only** mount of the Off Agent Lab's active AVHDX was attempted during the 2026-09-25 review, but Windows refused it before attachment with `0x80070522` (“A required privilege is not held by the client”). The disk remained unattached and the VM remained Off during that review. No fallback mount or credential access was attempted.

### Bounded guest boot and harvest attempt — 2026-09-26

The Agent Lab alone was started for a manually authenticated, offline guest inspection; its network adapter was disconnected before inspection. Hyper-V Data Exchange reported `Windows 10 Pro`, OS version `10.0.19045`, and x64 architecture. It did not establish the precise update revision. The Reference Lab and Windows 11 Agent Lab remained Off, and the Reference Lab's adapter remained disconnected.

The newly opened VMConnect connection was observable through the supported host Computer Use path, but harmless `View`-menu and guest Explorer clicks produced **no visible effect**. Process metadata showed this connection was again a child of `mmc.exe` (Hyper-V Manager), the same launch topology as the earlier unresponsive connection. A separate VMConnect process launched through `@oai/sky` was a child of `codex-computer-use.exe`, but its window could not be reliably activated while the Manager-launched connection remained open. This is a host-to-guest inspection limitation in this harvest attempt; it does **not** reproduce or resolve the original *in-guest* `SetIsBorderRequired` capture failure. No Motakamel business UI or SQL operation was performed.

At that point guest-local ChatGPT/Codex/Computer Use/Sky version identifiers and narrowly relevant diagnostic logs remained **UNKNOWN / NOT INVENTORIED**. The Agent Lab was then shut down through the guest OS using default `Stop-VM` (without `-TurnOff`, `-Save`, or `-Force`). It returned to `Off`; the registered checkpoint remained present, the AVHDX still referenced its dedicated base VHDX, and neither disk was attached. The Agent Lab adapter remained disconnected. No checkpoint, installer, application, database, or business-data change was requested.

### Final bounded guest inspection and corrected VMConnect diagnosis — 2026-09-28

The intervening read-only host security diagnostic found the interactive `user` token in session 17 to be non-elevated/medium-integrity with effective `Hyper-V Administrators` membership. The Sky-launched VMConnect's initial accessibility text (“No virtual machines could be found”) was **not** a true enumeration denial: opening its VM-selection list displayed all four registered DBL VMs, including this Agent Lab. No group, UAC, WMI/DCOM, or Hyper-V permission change was needed. The earlier ineffective Manager-launched connection and the later successful Sky-launched connection are different host input paths; neither result determines the root cause of the *in-guest* capture failure.

Using that qualified Sky-launched VMConnect path, only the Agent Lab was booted and authenticated **manually**. The adapter remained disconnected. In the guest's file UI, `%USERPROFILE%\.codex\plugins\cache\openai-bundled\computer-use` contained a version directory `26.915.31945`, with `.codex-plugin`, `assets`, `docs`, and `skills` below it. This proves a cached Computer Use bundle identifier **at harvest**, not the version active when `SetIsBorderRequired` failed. The guest's `%USERPROFILE%\.codex\computer-use` showed `config.json` and `config.toml`; neither was opened because configuration may contain secrets. `%USERPROFILE%\.codex\node_repl` showed `active_execs` at its top level, with no evident diagnostic log there. No credential, token, cookie, or personal account file was opened or recorded. This was a **narrow inspection**, not proof that no diagnostic log exists anywhere on the disk.

The supported runtime path itself remains established by the preserved experiment: `mcp__node_repl__js` could import `@oai/sky`, report a Windows target, enumerate and activate Explorer/GL.exe; capture then failed with `SetIsBorderRequired / 0x80004002`. Exact `@oai/sky` package version, Node version, ChatGPT/Codex app version, and Windows 10 update revision remain **UNKNOWN** because they were not safely exposed by this bounded inspection. Windows identity remains `Windows 10 Pro`, `10.0.19045`, x64 from Hyper-V Data Exchange; the often-cited `19045.3803` was not independently verified in this harvest. No capture was retried, and no Motakamel or SQL interaction occurred.

After inspection, default `Stop-VM` performed a normal guest shutdown of **only** `DBL-MotakamelPlus-Agent-Lab`. At this pre-retirement point, all four DBL VMs were `Off`. The Agent Lab's registered Standard checkpoint `AGENT-C0-Post-S1-Pre-Codex` still existed; its active AVHDX was unattached and parented to the base VHDX inside the same dedicated tree. The base had an empty `ParentPath` and was unattached. The Reference Lab retained `P001-S1-Post-Item-A`; its network adapter and the Agent Lab's adapter had no switch connected. The W11 Agent Lab and its `W11-C0`/`W11-C2` checkpoints remained registered and Off.

**Materiality judgment:** the externally preserved failure boundary, cross-app scope, error code, API path, lab lineage, and later W11 contrast are the useful project evidence. The Reference Lab retains the controlled post-S1 business lineage; there is no documented later Agent Lab business mutation, though this is not a byte-level database comparison. The exact W10 guest session, caches, app installation bytes, and uninspected private logs/configuration would be lost. Their absence is **not** claimed; their unknown contents do not justify retaining roughly 37 GiB of a disposable clone when the experiment result and reproducibility limits are recorded. A future exact-version forensic study would need a new controlled reproduction, not a claim that this clone's current cache reconstructs the past run.

## Pre-retirement storage projection, not deletion approval

At the 2026-09-25 review, `D:` free space was **33,649,692,672 bytes = 31.338718 GiB**, and the Agent Lab tree occupied **39,882,685,616 file bytes = 37.143645 GiB**. After the 2026-09-26 normal guest shutdown, the remeasured values were **33,616,138,240 bytes = 31.307468 GiB** free and **39,916,240,048 file bytes = 37.174895 GiB** in the dedicated Agent Lab tree. The pre-retirement arithmetic projection was **73,532,378,288 bytes = 68.482364 GiB** free, about **18.482364 GiB** above the 50 GiB Stage-B planning gate. File length need not equal allocated clusters or account for filesystem overhead; the actual result is recorded below. Stage B has not begun.

That was a **pre-retirement projection**, not a record of recovered allocation. The separately authorized operation and actual measurement are recorded below.

## Authorized retirement execution — 2026-09-28

Before removal, Hyper-V again returned the exact Agent Lab VM ID `647826a6-bd48-4a1f-9776-a6064075e4d0`, state `Off`, operational status `Ok`, and its sole Standard checkpoint `AGENT-C0-Post-S1-Pre-Codex` / `6ff58e5d-1f31-49d3-a0aa-9c2a3b258377`. The VM's configuration, checkpoint, and smart-paging paths were under `D:\Hyper-V\DBL-MotakamelPlus-Agent-Lab`. Both unique VHD paths in its active/checkpoint parent chain were inside that dedicated tree. A traversal of registered VM and checkpoint drives found **zero** target references outside the tree and **zero** protected references or configuration locations inside it (160 expanded protected disk references). The tree had eight files, two virtual disks, no unexplained disks, and no reparse points. The Motakamel Reference Lab and W11 Agent Lab were `Off`; the Reference Lab network adapter was disconnected. Immediately before removal, `D:` free space was **33,616,138,240 bytes = 31.307468 GiB**.

The registered VM was removed with Hyper-V's `Remove-VM` only after rechecking its VM/checkpoint IDs and `Off` state; it then disappeared from the registered inventory. During removal, the differencing checkpoint file disappeared and the base VHDX grew, consistent with a Hyper-V checkpoint merge. The dedicated tree retained just one dynamic base VHDX, **29,162,995,712 file bytes**, unattached and with an empty `ParentPath`. A fresh check of all remaining VM/checkpoint disk-parent chains found **zero** references into that tree, zero protected configuration locations there, and no reparse points. Only then was the exact dedicated directory `D:\Hyper-V\DBL-MotakamelPlus-Agent-Lab` removed as a unit. No individual active parent/child disk was manually broken; the directory is now absent.

| Storage result | Measured value |
|---|---:|
| `D:` free immediately before retirement | 33,616,138,240 bytes / 31.307468 GiB |
| `D:` free after registration and residual storage removal | **73,532,514,304 bytes / 68.482491 GiB** |
| Actual increase in free space | **39,916,376,064 bytes / 37.175022 GiB** |
| Stage-B planning gate | **Satisfied**: actual `D:` free is at least 50 GiB (18.482491 GiB above gate). |

The difference between recovered free bytes and the earlier sum of file lengths reflects filesystem/Hyper-V accounting; actual free-space delta is authoritative. The other registered DBL VMs remain `Off`: `DBL-MotakamelPlus-Lab` (`c4aa74c8-e0fe-4e37-be93-443635007a3c`), `DBL-MotakamelPlus-W11-Agent-Lab` (`e2054379-aaac-4a6b-9703-c9ec8c22ab96`), and `DBL-AlMuhaseb1-Lab` (`e4dd5174-7f04-4830-8586-27a57c546ce2`). The Reference Lab still has `P001-S1-Post-Item-A` and a disconnected network adapter; W11 still has `W11-C0-Clean-PostInstall` and `W11-C2-StageA-ComputerUse-Qualified`; AlMuhaseb1 still has `C0-Clean-Windows` and `C1-T7-Ready-for-Acquisition`. Post-retirement, every remaining registered VM/checkpoint VHD parent chain resolved successfully and none pointed into the retired tree. These are configuration/disk-chain checks, not guest boots or byte-level checksums.

The exact W10 Agent Lab VM state, installed application bytes, caches, and session state have been intentionally discarded. Its bounded Computer Use finding, uncertainty about the precise cause/version, clone lineage, and contrast with W11 Stage A remain durable in this record and the task history. Meeting the storage gate **does not start Stage B** or authorize installing Motakamel/SQL Server in the W11 lab.
