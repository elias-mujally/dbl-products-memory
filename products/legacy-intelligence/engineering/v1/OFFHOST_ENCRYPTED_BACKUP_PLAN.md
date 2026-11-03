# Owner-controlled encrypted off-host backup — proposal only

Prepared2026-10-24; review completed2026-10-25. **NOT EXECUTED; NO COPY, ENCRYPTION, KEY CREATION OR MEDIA CHANGE APPROVED HERE.** [Gate G05 and decision sequence](V1_REMAINING_GATES_20261024.md) · [Current bounded evidence retention](WINDOWS10_CLEAN_ACCEPTANCE_20261024.md).

## Decision and threat boundary

Recommend a dedicated owner-controlled removable drive already encrypted with BitLocker To Go, detached after verification and kept separately from the host. Check actual Windows edition/feature support, drive health/capacity/current encryption and organizational recovery-key escrow policy before selecting media. An unencrypted drive requires separately approved encryption/provisioning by the owner; no formatting, automatic enablement or global auto-unlock change is proposed. If the existing environment cannot supply the required encrypted medium without new authority/software, stop and decide, rather than selecting an unreviewed archive tool.

Encryption protects a lost locked medium, not the contents after unlock or against the authorized host process. File SHA-256 verifies bytes, not authorship, encryption or malware absence. An attached encrypted drive is still writable while unlocked. Detachment and separate physical custody supply the off-host boundary; another host folder/VHDX does not. This is a selected-evidence backup proposal, not VM/ERP disaster recovery.

## Separate scopes and approvals

**Stage1 — four evidence originals only:** owner alone identifies the retained four-file set and private provenance records; records exact allowlist and approved destination locally. Codex must not open the vault or learn its paths/contents/full receipts. Package ZIP/manifest already have independent pins and can be separately retained later under an explicit allowlist; they are not implicitly copied in Stage1. No raw sources, SQLite, ERP binaries, databases or VM disks enter this scope.

**Stage2 — optional recoverable DBL kit/state:** separate approval selects the exact kit/independent pins, authorized minimized input archives and a complete quiescent DBL-state backup produced by the supported command, with its independently retained manifest pin. Include the precise compatible version and operating guide. A four-report copy cannot reconstruct DBL state. Do not copy one live SQLite file or omit its required content; do not include ERP backup/VM material implicitly. Agree recovery point and recovery time objectives before promising them; neither is measured now.

## Owner execution plan, after approval

1. Identify an exact physical destination and new empty retention directory; no overwrite or cleanup. Owner verifies encrypted/locked-unlock capability, available space, media identity, no unapproved synchronization/escrow, and private access while unlocked. Do not change host security or mount the guest disk.
2. Owner locally records source identities, sizes and SHA-256 plus a plaintext manifest **inside** the encrypted destination. Before/after source checks detect accidental mutation. Copy only approved files; keep all originals. Never stage plaintext in public/temp/shared/synchronized folders or chat. No new guest transfer is needed for Stage1 because host retention already passed.
3. Owner compares each destination size/hash with its source and independently retained prior pins; validates exact file count and absence of unexpected files. Record failures without deletion or retry/repair. A self-generated digest without independent comparison is insufficient.
4. Safely detach, then reattach/unlock on an approved independently controlled supported device using an existing authorized facility. Owner independently rehashes the selected files; for Stage2 verify the DBL backup pin and restore into a new private directory, then compare current/history/audit after reopen. Never overwrite working state. Transfer to that device and new restored output require their own scoped approval.
5. Detach again and store offline away from the host. Owner retains version/date, verified scope and a sanitized success/failure receipt accessible to Codex only if deliberately shared. Original private records remain owner-only. Establish a proposed monthly readability check and a new generation after meaningful evidence/state milestones; do not schedule automation or delete old generations without approval.

## Key custody and recovery test

The owner enters the unlock password/recovery material privately, outside Codex. Retain recovery information separately from both the host and encrypted medium, such as a physically secured offline record controlled by the owner; no key in GitHub, chat, package, receipt or the same drive. Verify the chosen system's required escrow behavior rather than disabling organizational policy or assuming cloud-free custody. If mandatory cloud escrow conflicts with the approved no-cloud plan, stop and obtain a revised decision. Privately test recovery unlock on an approved device before claiming host-loss recovery; Codex receives only a bounded result, never the key. Any additional custodian must be explicitly approved.

## Completion gates and limits

- **Evidence off-host PASS:** encrypted destination and independent unlock verified; exact approved originals/source-before/source-after/destination/readback pins match; originals preserved; medium detached and separate key custody confirmed by owner.
- **DBL recovery PASS:** additionally Stage2 approved and complete backup verified/restored/reopened on independent target with quantities/history/audit intact. Record actual RPO/RTO; do not infer them from a completed copy.
- Until those actions occur, off-host retention/recovery remains **UNQUALIFIED**. A receipt summarizes owner verification, not independent agent inspection. Two independent encrypted rotating media can later reduce single-device loss, but acquisition/rotation remains a separate decision. No full-machine, ERP or long-term-media guarantee follows.

## References checked 2026-10-24

[Microsoft BitLocker FAQ](https://learn.microsoft.com/en-us/windows/security/operating-system-security/data-protection/bitlocker/faq) describes removable-drive encryption and recovery options; actual drive/policy support must be checked. [Microsoft recovery overview](https://learn.microsoft.com/en-us/windows/security/operating-system-security/data-protection/bitlocker/recovery-overview) covers recovery material and possible organizational escrow. The [CISA ransomware guide](https://www.cisa.gov/stopransomware/ransomware-guide) recommends offline encrypted backups and testing availability/integrity. These references inform the proposed control; they do not certify this host or medium.
