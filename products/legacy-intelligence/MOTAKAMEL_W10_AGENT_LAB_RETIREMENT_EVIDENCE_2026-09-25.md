# Motakamel Windows 10 Agent Lab — Computer Use and Retirement Evidence — 2026-09-25

**Decision (2026-09-28):** `WINDOWS 10 AGENT LAB RETIREMENT QUALIFIED`. This is an evidence decision, **not** authorization to remove a VM, checkpoint, or disk. A later bounded, manually authenticated guest inspection recovered the Computer Use bundle identifier and checked narrow diagnostic locations. Some exact runtime versions remain unknown; no material unique project evidence was found that requires keeping this disposable clone. Retirement still requires a separate explicit authorization and fresh Hyper-V dependency checks.

## Identity, lineage, and current storage

| Property | Read-only observation |
|---|---|
| VM | `DBL-MotakamelPlus-Agent-Lab`; ID `647826a6-bd48-4a1f-9776-a6064075e4d0`; Off after the final normal shutdown; Generation 2; configuration version 11.0; 4 vCPU; startup RAM 4 GiB. |
| Network | Independent dynamic-MAC adapter, formerly on Default Switch; currently disconnected (`SwitchName` empty), like the separately preserved Reference Lab. |
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
| Exact VM state | Would be lost upon retirement; not byte-for-byte reconstructible from this record. Current guest-local bundle identity and narrow diagnostic-location observations were harvested; exact application/session state is not retained. |
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

After inspection, default `Stop-VM` performed a normal guest shutdown of **only** `DBL-MotakamelPlus-Agent-Lab`. All four DBL VMs are now `Off`. The Agent Lab's registered Standard checkpoint `AGENT-C0-Post-S1-Pre-Codex` still exists. Its active AVHDX is unattached and still parents to the base VHDX inside the same dedicated tree; the base has an empty `ParentPath` and is unattached. The Reference Lab retains `P001-S1-Post-Item-A`; its network adapter and the Agent Lab's adapter have no switch connected. The W11 Agent Lab and its `W11-C0`/`W11-C2` checkpoints remain registered and Off.

**Materiality judgment:** the externally preserved failure boundary, cross-app scope, error code, API path, lab lineage, and later W11 contrast are the useful project evidence. The Reference Lab retains the controlled post-S1 business lineage; there is no documented later Agent Lab business mutation, though this is not a byte-level database comparison. The exact W10 guest session, caches, app installation bytes, and uninspected private logs/configuration would be lost. Their absence is **not** claimed; their unknown contents do not justify retaining roughly 37 GiB of a disposable clone when the experiment result and reproducibility limits are recorded. A future exact-version forensic study would need a new controlled reproduction, not a claim that this clone's current cache reconstructs the past run.

## Conditional storage projection, not deletion approval

At the 2026-09-25 review, `D:` free space was **33,649,692,672 bytes = 31.338718 GiB**, and the Agent Lab tree occupied **39,882,685,616 file bytes = 37.143645 GiB**. After the 2026-09-26 normal guest shutdown, the remeasured values were **33,616,138,240 bytes = 31.307468 GiB** free and **39,916,240,048 file bytes = 37.174895 GiB** in the dedicated Agent Lab tree. The arithmetic retirement projection remains **73,532,378,288 bytes = 68.482364 GiB** free, about **18.482364 GiB** above the 50 GiB Stage-B planning gate. Actual reclaimed allocation must be measured afterward; file length need not equal allocated clusters or account for filesystem overhead. Stage B has not begun.

**Do not remove the VM under this evidence task.** For a separately authorized retirement: confirm all VM/checkpoint identities and disk-parent dependencies again; export any newly identified material evidence first; remove only the registered W10 Agent Lab by a supported Hyper-V retirement operation and its verified dedicated storage, never by deleting an active VHD/AVHDX chain; then verify the Reference/W11 labs and measure actual `D:` free space. The Reference Lab must remain disconnected and preserved; the W11 Agent Lab must remain untouched. The 50 GiB Stage-B gate is a **projection**, not yet achieved free space.
