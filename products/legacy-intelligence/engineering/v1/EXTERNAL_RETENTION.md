# V1 backup outside its virtual disk — measured feasibility

Date:2026-10-23. **ENHANCED SESSION OBSERVED ACTIVE / FILE TRANSFER AND BACKUP VALIDITY UNQUALIFIED.**

[Index](README.md) · [Recovery inspection](RECOVERY_QUALIFICATION.md) · [Third-test gate](THIRD_CAPTURE_PLAN.md) · [Evidence metadata](EVIDENCE.json)

## What was measured

The intended standalone VMConnect window was rediscovered. An initial screenshot disagreed with the returned VMConnect accessibility identity; no input used that image. Fresh selection/activation yielded the correct guest. A menu element-index action then failed with a cached-element error; after fresh observation, a coordinate action opened the **host View menu**, where Enhanced session had a visible checkmark. The menu was closed without toggling modes/resources or sending guest terminal input. This is a current mode observation, not a clipboard-transfer test or a new explanation of historical approval failures.

The backup Properties view still showed the previously observed25,612,288bytes. The host filesystem inventory showed approximately51GiB available on the system volume and105GiB on the other visible local volume. These are transient capacity observations, not restore-size or physical-disk-independence proof. No additional removable-drive letter was established. No original ERP files or historical-lab directories were scanned.

## Recommended next narrow test

Use the **already active** Enhanced Session clipboard file capability if its present policy permits it. Microsoft documents clipboard/file sharing for this mode. Do not enable host drive redirection, shares or networking. Preserve the owner's clipboard while the inspection script is being pasted. No file has been copied by this evaluation.

After the owner completes the sealed probe, copy only the generated private report to an owner-private host output directory and hash/read it. Then scope copying only the selected backup to a new hash-addressed name outside the VM image/lab folder. Refuse collisions/overwrite and compare host bytes/SHA-256 against the guest probe's independently reported source. Record source set/position/hash and destination verification privately. Raw backup/report content remains outside Git; publish only sanitized evidence IDs/hashes. A checkmark or successful text paste alone cannot qualify file-copy policy/functionality.

The existing inspection script remains pinned to SHA-256 `2E09D358A4115C9E9C665E688C7BDC0E345E75AB13491F9B9B9C7EFDEEB1ACE2`. No runtime source hash, HEADERONLY/FILELISTONLY/VERIFYONLY result or checksum coverage is available yet. The current probe execution requires one owner paste: Computer Use prohibits terminal automation even when VMConnect is allowed. This is a tool workflow limit; the owner has authorized inspection. No new application approval, elevation, credential extraction or repeated denied Hyper-V query is used as a workaround.

## Alternatives and limits

- **Copy-VMFile:** official FileSource accepted value is Host; the cmdlet is host-to-guest. It is not a reverse-export method.
- **PowerShell Direct:** Microsoft requires Hyper-V administrator context and guest credentials. It supports guest-to-host Copy-Item, but that is not an established ordinary-user route here. No connection, credential prompt, service change or bypass was attempted.
- **Separate physical retention:** a verified host file removes dependence on the particular VHDX, while host/disk failure remains a separate risk. The physical relationship of the host volumes and an independent removable device were not qualified. Agree an additional owner-selected separate device before claiming broader disaster recovery; no media path is invented.

If existing clipboard policy blocks the narrow copy, stop and choose a separately authorized route instead of altering security settings. No VM export, VHD mount, shutdown, restart, network, drive mapping or permission change was performed. Same-instance database recovery and independent byte retention remain separate gates; neither permits the pending stock issue alone.

Primary references: [Enhanced Session clipboard/file sharing](https://learn.microsoft.com/en-us/windows-server/virtualization/hyper-v/enhanced-session-mode), [Copy-VMFile direction](https://learn.microsoft.com/en-us/powershell/module/hyper-v/copy-vmfile?view=windowsserver2025-ps), [PowerShell Direct prerequisites and file copy](https://learn.microsoft.com/en-us/windows-server/virtualization/hyper-v/powershell-direct). Documentation is distinct from measured transfer success.
