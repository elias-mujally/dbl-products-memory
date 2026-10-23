# V1 backup outside its virtual disk — verified retention

Date:2026-10-23. **PASS_OUTSIDE_VHDX_EXACT_BACKUP_RETENTION**.

[Index](README.md) · [Recovery qualification](RECOVERY_QUALIFICATION.md) · [Third actual result](THIRD_CAPTURE_RESULT.md) · [Evidence metadata](EVIDENCE.json)

## Measured current result

The owner copied only the pinned native BAK through the already active session to an empty private host folder, without moving the source, replacing a file or changing networking/resources/security/permissions. Codex independently read the resulting regular host file: **25,612,288bytes**, SHA-256 **88F028A3C2C562413797639357C775DA74B67EE36FFB197C269C6B5A59C127FC**. This equals the guest before/after hashes and the exact backup used in the approved separate restore/CHECKDB/eleven-table comparison. Exact locators and the receipt remain private; no BAK/raw report enters Git.

**FACT:** there is now a byte-verified host copy outside VHDX. **NOT PROVEN:** a different physical device, full-host recovery, native backup checksums, SQL-logins/Windows/licensing recovery or full-database row equality. The independent copy plus separately exercised fixture restore closed the scoped recovery gate for the approved one-unit stock change. No restore over the source was attempted. The successful recovery database and all source/copy files remain retained.

## Prior attempts and limits

An earlier Codex clipboard attempt to transfer a small report did not produce a host file, including after a bounded focus retry. No permission denial or root cause was established. Enhanced session had been observed checked, but that observation was not treated as transport proof. The exact report was instead reconstructed from owner-pasted text and matched its supplied SHA-256. The later owner-assisted BAK copy succeeded and was byte-verified; this does not retroactively establish why the earlier attempt failed or qualify unattended binary transport.

Copy-VMFile had only been qualified host-to-guest and was not misused as reverse export. PowerShell Direct, VHD mounting, VM export, shutdown/restart, new shares, drive mapping and networking were not used. Computer Use prohibits guest terminal automation; the owner ran inspection/restore/acquisition commands manually under their scoped approvals.

The later third raw JSON also arrived via owner-assisted existing-session copy and matched its independently recorded SHA-256. Automated capture/transfer remains unqualified. See the linked third result for the business change and persistent import, rather than interpreting transport alone as an integration pass.

Primary references retained from the earlier design: [Enhanced Session clipboard/file sharing](https://learn.microsoft.com/en-us/windows-server/virtualization/hyper-v/enhanced-session-mode), [Copy-VMFile](https://learn.microsoft.com/en-us/powershell/module/hyper-v/copy-vmfile?view=windowsserver2025-ps), [PowerShell Direct](https://learn.microsoft.com/en-us/windows-server/virtualization/hyper-v/powershell-direct). Documentation describes mechanisms; the bytes/hash above are the measured retention evidence.
