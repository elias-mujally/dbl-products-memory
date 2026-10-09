# Host W11 — External recovery drive E: read-only qualification

Date: **2026-10-09**. Accepted baseline: Product Memory **067a921**, [elevated known-path inventory](MOTAKAMEL_HOST_W11_ELEVATED_RECOVERY_INVENTORY_2026-10-09.md#6-operator-returned-elevated-inventory--2236-update).

**Decision: BLOCKED for a qualified protected recovery destination.** Physical independence and capacity **PASSED**; E: is suitable in principle as external storage for the observed scope. Protection remains **UNRESOLVED**, and the future capture method must account for exFAT metadata limitations. This is not a capacity failure or a finding that the device is defective. No copying is authorized by this result.

## 1. Authority and fresh device evidence

Observations at **2026-10-09T23:17:00.4604358+03:00** and **23:18:10.8881401+03:00**, host **DESKTOP-8QRQT7R**, operator **DESKTOP-8QRQT7R\user**, actual Windows token **Elevated=false**. Outside-sandbox permission is not UAC elevation. The earlier administrative inventory remains operator-provided evidence, not attributed to this token.

Read-only methods: Get-Volume; Get-Partition/Get-Disk for C:/D:/E:; Win32_LogicalDisk E: and Win32_DiskDrive indices 0/1; one Get-BitLockerVolume attempt for E:; Get-Service for YSEDU/Browser; arithmetic on returned sizes. No E: directory or file-content enumeration. Serial numbers/device unique identifiers are not published.

| Object | Returned mapping and state |
| --- | --- |
| C: | **Disk0 / Partition3**, Basic, 249,365,004,288 partition bytes; IsOffline=false / IsReadOnly=false |
| D: | **Disk0 / Partition4**, Basic, 261,900,730,368 partition bytes; IsOffline=false / IsReadOnly=false |
| E: | **Disk1 / Partition1**, IFS, 251,657,191,424 partition bytes; IsOffline=false; partition IsReadOnly unavailable |
| Physical Disk0 | SAMSUNG MZVLB512HAJQ-000L7; **NVMe / GPT**, 512,110,190,592 bytes; Healthy / Online; disk IsReadOnly=false / IsOffline=false; boot/system |
| Physical Disk1 | ASolid USB; **USB / MBR**, 251,658,240,000 bytes; Healthy / Online; disk IsReadOnly=false / IsOffline=false; not boot/system |
| E: volume | **exFAT / Removable**, Healthy / OK; total **251,647,754,240 bytes**; free **139,640,832,000 bytes** |

**E: is physically independent from both C: and D:** Disk1 versus Disk0, established from partition-to-disk mappings, not letters alone. C:/D: still share Disk0. Earlier absence of independent storage is superseded only for physical availability; recovery/catalog limitations remain.

The second provider returned E: DriveType=2/Removable, exFAT and the same volume total/free. Win32_DiskDrive index1 returned ASolid USB USB Device / USB / Removable Media / Status=OK / one partition. Legacy-provider disk sizes differ slightly from Get-Disk; they are not substituted for usable Get-Volume capacity or treated as damage evidence.

Health/status flags are **not** a surface scan, SMART qualification, cable stability/write test, capacity authenticity test or recovery-copy verification. Disk IsReadOnly=false does not prove effective write permission or successful copying.

## 2. Bounded capacity comparison

GiB uses bytes / 1,073,741,824.

| Measurement / calculation | Bytes | GiB |
| --- | ---: | ---: |
| E: volume total | 251,647,754,240 | 234.365234 |
| E: free | 139,640,832,000 | 130.050659 |
| Prior persistent candidates + three backups | 1,278,906,368 | 1.191074 |
| Same scope +20%, rounded up | 1,534,687,642 | 1.429289 |
| Free minus that bounded budget | 138,106,144,358 | 128.621370 |

**Capacity PASSED for the observed scope plus margin.** Approximately **1.43 GiB is not a complete recovery budget**: full SQL/Windows installation, complete catalog/external paths, server/login/key/configuration recovery, growth, additional copies and restore-test workspace are not established. Refresh capacity before future authorized capture. No copying substantiated these calculations.

## 3. Protection and filesystem boundaries

One `Get-BitLockerVolume -MountPoint E:` failed with **Microsoft.Management.Infrastructure.CimException: Access denied** under the non-elevated token. No bypass, repeated status probing under that token, key-protector enumeration or recovery-key extraction followed.

**BitLocker encryption/protection/lock status = UNRESOLVED**, not disabled. Other protection mechanisms are neither established nor excluded. Historical C:/D: protection observations do not apply to E:.

Microsoft's [filesystem comparison](https://learn.microsoft.com/en-us/windows/win32/fileio/filesystem-functionality-comparison) documents that exFAT lacks NTFS ACL/owner tracking, named streams and metadata journaling. A future plain-file copy must not be described as preserving those properties. Filesystem-level encryption is distinct from volume/container protection; exFAT alone does not prove absence of BitLocker.

**Do not reformat E:.** A later reviewed capture can account for required metadata using an appropriate protected archive/image and manifest/restore mapping. No such method or artifact was created or qualified here; existing drive files were not inspected and no encrypted container was assumed.

The accepted recovery gate requires protection for potentially sensitive system/master/login/permission recovery material. This check proves independent hardware/capacity, not protection. If volume protection is absent, choosing another protected capture method or expressly accepting a defined custody risk requires a separate owner decision. No BitLocker enablement or other security change is mandated or authorized here.

## 4. Outcomes and smallest next step

| Gate | Result / boundary |
| --- | --- |
| Present, online, accessible volume metadata | **PASSED** |
| Physically separate from C:/D: | **PASSED** |
| Observed scope +20% fits | **PASSED** |
| Provider health / filesystem | **Healthy / OK; exFAT**, not integrity-tested |
| Protection | **UNRESOLVED — status read denied** |
| Effective write/copy integrity/restorability | **NOT TESTED**, deliberately outside scope |
| Preliminary storage suitability | **YES for observed scope**, subject to protection and capture-method qualification |
| Protected recovery destination | **BLOCKED**, not fully qualified |

Smallest next non-changing operator step: in an authorized administrative Windows PowerShell session, return only these status fields, not key protectors or passwords:

```powershell
Get-BitLockerVolume -MountPoint E: |
    Select-Object MountPoint,VolumeStatus,ProtectionStatus,EncryptionPercentage,LockStatus
```

Read-only handoff only; no ACL/UAC/encryption change. If still unreadable, return the error and stop. Then agree on protection/custody and capture method, complete recovery scope and its budget. Actual capture remains separately authorized; no write test is implicitly proposed.

**Separate overall recovery gaps:** current complete SQL catalog/outlying paths, frozen READ_ONLY/grants, active transactions and adequate independent recovery capture/restore proof remain unresolved from the accepted inventory. External storage does not resolve these or make shutdown safe. No SQL connection or new database-state proof occurred.

## 5. Preservation and STOP

Services observed **MSSQL$YSEDU Running / Automatic**, **SQLBrowser Stopped / Disabled**. No stop/restart, TLS/certificate/network/firewall/login change, backup/restore, MDF/LDF copy, ERP action or connector test. No claim of byte-identical business rows without a database comparison.

No file on E: or source recovery file was copied, moved, deleted or modified; no formatting/partitioning/encryption/write/repair test or permission/Windows change. Only this non-sensitive Product Memory report and README were edited under explicit documentation authorization. No raw keys, credentials, master contents or recovery archives committed; `.vscode` excluded. **STOP before capture or any host mutation.**
