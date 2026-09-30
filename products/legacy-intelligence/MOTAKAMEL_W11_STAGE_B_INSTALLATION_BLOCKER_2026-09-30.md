# Motakamel Windows 11 Stage B — Installation Blocker and Preservation — 2026-09-30

**Result: `STAGE-B INSTALLATION BLOCKED`. Evidence preservation is PARTIAL.** The educational installer placed Motakamel application files, but the guest diagnostic reports that the SQL Database Engine installation failed. No working `YsEDU` environment, database restoration, FMMA provisioning, or direct GL.exe capture/input qualification is established. Windows 11 Computer Use **Stage A remains qualified**; it is not Motakamel qualification.

This record supersedes the older *current* Stage-B storage-blocked / not-started statements. It does not rewrite historical experiments, change the Canonical Model, or advance S0b/S2/S3 or connector readiness.

## Evidence provenance and limits

| Source | What is preserved | Verification limit |
|---|---|---|
| Host Hyper-V queries on 2026-09-30 | VM/checkpoint IDs, Off state, disk parent chain, attachment state, file lengths, free space and protected-lab registration | Live host observations; not a guest database check or restore test |
| Host file hashing | Historical installer SHA-256, plus the failure-state checkpoint-layer hash recorded below | Hashing does not constitute a standalone VM export or prove every parent file byte |
| Guest Codex diagnostic displayed in VMConnect | GL.exe ownership/shortcut report, SQL service/Registry findings, setup failure sequence and source-log locations | Report read visually by the host agent; original logs were NOT independently opened, copied or hashed on the host |
| User statement | Installation completed without a visible installer error; maintenance opened automatically after launching the shortcut | Does not prove success of the nested SQL installer |
| Microsoft documentation | PowerShell 2.0 removal and SQL/Windows support boundary | Corroborates the compatibility explanation; does not replace the guest logs |

No secrets, connection strings or credentials are included. Reported log references are retained so a later authorized export can verify the exact bytes. The guest diagnostic said it read no secrets/connection strings/credentials and performed no changes; the host cannot independently certify every guest tool operation from screenshots alone.

## Lab identity and pre-install boundary

| Property | Evidence |
|---|---|
| Target | `DBL-MotakamelPlus-W11-Agent-Lab`, VM ID `e2054379-aaac-4a6b-9703-c9ec8c22ab96` |
| Platform | Independently created Generation 2 / configuration 11.0 lab; Windows 11 Pro 25H2, Arabic x64; 4 vCPU, fixed 8 GiB RAM, Secure Boot and vTPM from the preserved Stage-A configuration |
| Media identity | Official Windows 11 ISO previously identified as `10.0.26200.8037`; this is not a fresh verification of the installed guest's current update revision |
| Clean checkpoint | `W11-C0-Clean-PostInstall` / `10f06fd3-8ddf-4ff2-acf2-292a727abd72` |
| Stage-A checkpoint | `W11-C2-StageA-ComputerUse-Qualified` / `c76de620-6025-4e5a-a896-c35086d5218c`, parent C0 |
| Pre-install Standard checkpoint | `W11-B0-Pre-Motakamel-Install` / `3af18406-01ef-44f7-96ad-3de164014d73`, created `2026-09-28T22:08:21.854933+03:00`, parent C2 |
| D: before / after B0 | 73,532,514,304 / 73,523,986,432 free bytes, respectively; historical preparation measurements |
| Educational installer | `C:\Users\user\Downloads\EFA6_EDU_Gold.exe`, previously measured 606,592,022 bytes; SHA-256 reverified on 2026-09-30: `1DE2B3556E43465EDDEE847BA194024CFA7AFE9400C6523D510869A22CE2994C` |
| Guest transfer | Copied to `C:\Users\Public\EFA6_EDU_Gold.exe` using Hyper-V Copy-VMFile; Guest Service Interface was temporarily enabled and then disabled again. Guest destination hash was not separately recovered. |

No source or Reference Lab writable disks/databases were copied. The Windows 10 Agent Lab was already retired under separate authorization; see [retirement evidence](MOTAKAMEL_W10_AGENT_LAB_RETIREMENT_EVIDENCE_2026-09-25.md).

## Installation and first-launch observations

The user completed the normal installer manually after host-to-guest VMConnect input produced no visible response. The installer itself was not modified. The user reported no visible error, but later read-only guest diagnostics found a failed nested SQL installation. The distinction is **outer installer completion versus dependency installation success**.

The desktop's Motakamel shortcut opened `System Update And Maintenance` automatically. Host observation showed `Create New EFA DataBase SQL Server` selected, `Next` enabled and `Create` disabled on that initial page. Neither button was pressed by the host agent. This is not a normal authenticated business Main Menu.

The guest diagnostic identified the maintenance window owner and both the desktop/Start shortcuts as `C:\EFA\GL.exe`, without launch arguments, and reported GL.exe running. Exact file-version/hash text is not promoted to a host-verified binary manifest; a future narrow file export/hash check remains open.

## Root-cause evidence table

Times below are **guest-report times on 2026-09-30, stated as Riyadh time (UTC+03:00)**. These are not independently extracted timestamps from archived logs.

| Timestamp | Component | Operation | Expected | Actual | Evidence | Confidence |
|---|---|---|---|---|---|---|---|
| Setup run directory `170246` | SQL Server 2014 setup | Install `INSTANCENAME=YSEDU`, `FEATURES=SQLENGINE` | Install the Database Engine instance | Request was invoked; it was not simply skipped | Guest report of setup Summary | High for reported attempted/failed path; raw log verification pending |
| 17:03:27 | Setup PowerShell/Registry inspection | Inspect Registry | Return relevant configuration | Caught null-reference exception; report says it was handled | `Detail.txt`, line 2683, as reported | Not established as terminal cause |
| 17:03:36 | Sco / Setup | Query managed-service-account information for SYSTEM | Return account information | Win32 1722, as reported | `Detail.txt`, line 9023 | Not established as terminal cause |
| **17:03:53** | Setup prerequisite / Windows feature enablement | Enable `MicrosoftWindowsPowerShellV2` | Make Windows PowerShell 2.0 available | **`0x800F080C` / `-2146498548`; `Feature name MicrosoftWindowsPowerShellV2 is unknown.`** | `MicrosoftWindowsPowerShellV2.log`, lines 50–52; `Detail.txt`, line 10763, as reported | **Strongest reported causal boundary** |
| 17:05:15 | SQL Setup Summary | Finish Database Engine installation | Successful instance/service registration | Failed; report explicitly attributes Database Engine Services failure to the PowerShell component | `Summary_DBL_LAB_20260930_170246.txt`, as reported | High for guest report; host raw-source verification pending |
| Post-install diagnostic | Windows services / Registry / SQL client | Find/use local YsEDU | Database Engine service, registered instance, connection | No engine/Agent service or registered SQL instance reported; Windows-authentication connection to YsEDU returned error 26 | Guest read-only diagnostic | Corroborates missing usable engine; does not identify FMMA state |

Reported source-log directory:

`C:\Program Files (x86)\Microsoft SQL Server\120\Setup Bootstrap\Log\20260930_170246\`

The guest reported SQLBrowser stopped/disabled and SQLWriter running/automatic. Shared components being installed does **not** prove a Database Engine instance exists. The Database/User/role state of `EFA12026`, `Multi_Lang`, `DbRepDes`, `EFAARC10` and FMMA remains **UNRESOLVED**, not “confirmed missing”; SQL metadata was inaccessible.

### Compatibility interpretation

Microsoft documents that [PowerShell 2.0 is no longer included in Windows 11 25H2](https://learn.microsoft.com/en-us/windows/whats-new/whats-new-windows-11-version-25h2). Its [SQL Server / Windows compatibility matrix](https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/install/windows/use-sql-server-in-windows) marks SQL Server 2014 as **not supported on Windows 11**.

This independently supports the reported missing-feature failure. It does not establish that changing one prerequisite would make the entire historical package supported, or that a newer SQL engine is compatible with this Motakamel build. No PowerShell reinstatement, rule bypass, SQL replacement, compatibility hack, manual FMMA provisioning or maintenance Create was attempted.

## Direct Computer Use status

| Capability | Stage-B result |
|---|---|
| GL.exe process / window enumeration | Reported directly by Guest Codex; maintenance owner identified as GL.exe |
| Full GL.exe screenshot/state capture | **UNRESOLVED**: guest report said it could read the window title but could not confirm the maintenance content |
| Direct activation | Not independently established for this Stage-B test |
| Direct GL.exe mouse / keyboard effect | **NOT QUALIFIED / NOT TESTED** through the approved progressive path |
| Historical `SetIsBorderRequired / 0x80004002` | Not reported in these displayed diagnostics; this is **not proof of successful GL capture or absence under a completed reproduction** |
| Motakamel business-data input | No business workflow or record creation was authorized/performed in this task; controlled dataset was not migrated/recreated |

Host VMConnect visibility is not evidence of direct Guest Sky input. The earlier W10 cross-app capture failure and later W11 Stage-A success remain separate observations; the SQL installation failure is a new dependency boundary, not proof of the cause of the W10 capture issue.

## Preservation execution and remaining gap

On 2026-09-30, only W11 was gracefully shut down using default `Stop-VM`, with no Force/TurnOff/Save flags. It reached `Off` with normal status. A guarded mount of its exact active AVHDX with `Mount-VHD -ReadOnly -NoDriveLetter` failed **before attachment** with `0x80070522` / “A required privilege is not held by the client”, despite the permitted escalated command surface. No security change or alternate mount workaround was used. The disk remained unattached.

One Standard checkpoint was then created and re-queried after Hyper-V registration settled:

| Property | Verified value |
|---|---|
| Name | **`W11-B1-SQLInstall-Blocked-PowerShell2`** |
| ID | **`a61c7027-a5d5-461b-aa90-373aa6b961fd`** |
| Creation time | **`2026-09-30T18:10:26.371347+03:00`** |
| Parent | `W11-B0-Pre-Motakamel-Install` / `3af18406-01ef-44f7-96ad-3de164014d73` |
| VM | `e2054379-aaac-4a6b-9703-c9ec8c22ab96`, Off |

The original setup logs remain **inside the preserved guest disk state only**. This document durably preserves the reported boundary, error text, log paths, host metadata and explicit provenance outside the VM. It is **not** an external raw-log archive or a standalone VM backup; recovery still requires the retained parent chain. Exporting redacted source logs and verifying their hashes remains open. No restore/rollback was performed.

### Follow-up external export attempt — 2026-09-30

The ordinary permitted escalated shell still reported `AdminToken=False`. A narrowly scoped UAC-launched process was used instead, without changing group membership, UAC, execution policy, Hyper-V permissions or VM configuration. Windows PowerShell 5.1's effective policy was `Restricted`; its first launch ended without an export result. The official bundled PowerShell runtime, already used by the command tool with its existing `RemoteSigned` policy, then executed the guarded script with a real Administrator token. No `Bypass`/policy override was used.

The script verified the exact Off VM/B1 IDs and source parent chain, mounted the **B1 failure-state layer** with `-ReadOnly -NoDriveLetter`, and verified `Get-Disk.IsReadOnly=True`. It could not access the expected setup-log directory. A separate bounded read-only volume inspection established the cause: guest Windows partition 3 (84,737,523,712 bytes) returned **`BitLocker.LockStatus=Locked`**; its filesystem was not exposed while locked. The disk itself was online, GPT and read-only. Thus mount privilege was successfully supplied, but the remaining export blocker is the **locked offline guest volume**, not lack of an SQL instance or a failure to mount the VHD.

Both elevated operations detached the disk in their cleanup path; `Get-VHD.Attached=False` was rechecked. All three surviving DBL VMs remained Off; Reference Lab remained network-disconnected. No recovery key, password or key-protector material was requested/read, and no unlock, decryption, mount-point assignment, VM boot, SQL action or security change was attempted. **Zero source logs were exported**; preservation remains PARTIAL.

The host-only operational results are retained under investigation-workspace `outputs/w11-stage-b-sql-evidence-20260930/`:

| Artifact | SHA-256 | Meaning |
|---|---|---|
| `export-result.json` | `1A5E1ED875A483459DEFEB8D645F536893CF5BE59799438684B8BB31DDBB829C` | Read-only mount succeeded; expected source directory unavailable; empty exported-log list; disk detached |
| `volume-inspection-result.json` | `3CEDAF90E653F0841CAB68F855F31C6871BDF33417E85735CD24DEC4159C9F85` | Read-only disk/partition metadata and locked BitLocker state; disk detached |

These are diagnostic-result hashes, **not SQL-log hashes**. The guarded scripts export only bounded, credential-filtered error excerpts if accessible; no full raw-log archive or standalone VM export was created.

## Post-preservation storage and integrity

All paths below share the root:

`D:\Hyper-V\DBL-MotakamelPlus-W11-Agent-Lab\Virtual Hard Disks\`

| Disk suffix after `DBL-MotakamelPlus-W11-Agent-Lab-Fresh-20260923` | File bytes | Parent |
|---|---:|---|
| `_92364059-945E-44DF-A096-F033A57C1251.avhdx` (new active layer) | 4,194,304 | A9306D78 layer |
| `_A9306D78-E269-40D5-8CA9-913DCE25C8F5.avhdx` (failure-state layer) | 22,150,119,424 | CF51BA2D layer |
| `_CF51BA2D-BEFF-459A-A8BF-A7E1E027CA3D.avhdx` | 2,099,249,152 | 4F57BC07 layer |
| `_4F57BC07-4A8E-461E-80DF-0B8BC828F230.avhdx` | 16,714,301,440 | Base VHDX |
| `.vhdx` (dynamic base) | 25,908,215,808 | Empty ParentPath |

Every parent resolved under the dedicated W11 tree; every disk was unattached. Each advertises an 80 GiB virtual maximum, **not** current physical allocation.

After B1 creation, the retained failure-state layer `_A9306D78-E269-40D5-8CA9-913DCE25C8F5.avhdx` was hashed while the VM was Off and the disk unattached. SHA-256: **`62862C5EB7DFD25E3A1B0E870402816A75E7EC670FFCDACFFD38C5CBE0ECAB02`**. This layer depends on the recorded parents; its hash is not a standalone full-disk or log-file hash.

Measured after B1: W11 directory file-length sum **71,185,801,493 bytes / 66.296944 GiB**; host D: free **51,369,582,592 bytes / 47.841652 GiB**; C: free **33,256,353,792 bytes / 30.972393 GiB**; host available RAM **17,212,989,440 bytes / 16.030846 GiB**. No further installation capacity claim is made from these changing operational measurements.

`DBL-MotakamelPlus-Lab` and `DBL-AlMuhaseb1-Lab` remained Off. Reference Lab `P001-S1-Post-Item-A` / `2d045664-b5d4-41a7-851f-4889e18a3b37`, AlMuhaseb1 C0 / `5b6a6a3c-977c-45d9-bc80-8c2ec75d3154` and C1 / `f1f44f7a-42ba-4d39-a226-b9e6fb0cf99c` remain registered. Reference Lab adapter `SwitchName` remains empty. No protected VM/checkpoint/network/disk mutation was issued; this is not a byte-for-byte checksum certification of those labs.

## Decision and single next step

**Stage A qualified; Stage B installation blocked; direct Motakamel Computer Use unresolved; evidence preservation partial.** Motakamel remains the Primary First Connector Target; AlMuhaseb1 remains an evidence lab, not a replacement. No architectural/connector/evidence gate is promoted by this installation result.

**Next:** obtain authorization for a bounded boot of W11 only, normal manual Windows authentication, and an in-guest export of targeted credential-filtered source-log evidence, followed by transfer outside the VM and graceful shutdown. Do not request recovery keys or try offline BitLocker unlocking; do not erase/revert the diagnostic checkpoint. After preservation, obtain a supported deployment compatibility decision from YemenSoft before selecting any alternate Windows/SQL combination. No unsupported repair, automatic permission change or switch to a different database engine is authorized by this record.
