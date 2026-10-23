# V1 recovery qualification — preparation only

Date:2026-10-23. **OWNER CONFIRMS NO QUALIFIED ERP BACKUP / INSPECTION PREPARED, NOT EXECUTED.**

[Index](README.md) · [Prior gate](MERGE_AND_RECOVERY_GATE.md) · [Third-test contract](THIRD_CAPTURE_PLAN.md) · [Evidence hashes](EVIDENCE.json)

The owner answered the missing-evidence question: no recovery-qualified backup exists, and preparation of the verification step is authorized. The previous one-unit transaction approval remains valid subject to recovery. This does not authorize silently restoring over the source database or creating a recovery target before its scope is known.

## Prepared first step

A private, fixed-scope owner-paste TXT inspects the previously observed guest backup. It checks expected guest/model/OS before SQL, then local instance/version/database identity. It hashes the regular file before/after, reads backup headers and logical file metadata, selects only an unambiguous complete full backup, and runs VERIFYONLY with STOP_ON_ERROR. Present backup checksums require CHECKSUM; missing checksums are reported explicitly. No secrets are requested.

The probe reads target-existence, original file paths, default paths, logical file sizes and guest free-space metadata for a later proposal. It writes one new private guest report, never overwrites an existing report, and does not copy the backup, create/restore a database, make a backup or alter ERP rows/configuration/permissions. Normal SQL diagnostic activity is not misrepresented as zero system writes. Refusal, unsupported format, encryption, changed bytes or ambiguous backup sets stop the probe; none is automatically repaired.

**Executed evidence:** Windows PowerShell5.1 parsed the TXT with zero syntax errors; separate static checks passed eight allowlisted SQL literals and the command boundary. The probe itself was **not executed**, no SQL connection opened and no backup integrity/runtime success claimed. The exact pinned script and private plan have IDs/hashes in EVIDENCE.json; internal selectors and precise locators stay in the private custodian register. A validator initially counted two report labels as SQL; filtering complete FROM statements corrected the static classifier without changing candidate SQL. No actual backup error was observed.

## Interpretation and later approval

VERIFYONLY checks readability/completeness and available checksums; it is not a restore/data-structure proof. An inspection pass is deliberately named inspection-only and keeps recoveryQualified=false. Microsoft documents CREATE DATABASE permission for backup inspection since SQL2008; if existing authorization is insufficient, stop instead of granting it.

After actual results arrive, prepare one new uniquely named database and new noncolliding files inside V1. Derive MOVE mappings from FILELISTONLY and size requirements from restored data/log sizes, not compressed backup bytes. Verify guest capacity and host backing-volume headroom. No executable RESTORE DATABASE command is prepared with guessed logical names, original destination paths or REPLACE.

The approval proposal must name its target/files/resource effects. Only after approval: restore to that separate target, check ONLINE, run non-repair DBCC CHECKDB there and compare bounded business evidence against the qualified/current fixture through SELECT. Do not repoint ERP, alter the active database or label recovery reads a third ERP acquisition. Retain the target pending an explicit cleanup decision; no automatic drop/delete is included.

Independent backup retention/transfer is still unresolved. Do not assume a reverse guest-to-host Copy-VMFile route or enable networking/shares/drive mappings. Same-instance database recovery also does not prove recovery of Windows, SQL logins, licensing or a failed host. The earlier recovery condition is not silently weakened. A fresh native backup is required if the candidate cannot represent the current baseline.

## Current result

The owner subsequently authorized completing the inspection with existing ordinary-user permissions. Re-review confirmed the exact sealed script hash and eight allowlisted SQL literals, with no database restore/data-modification/delete statement. The intended new JSON report and normal SQL diagnostic activity remain disclosed. No runtime SQL permission level or backup validity is inferred from static review. Computer Use prohibits terminal automation, so one manual owner paste was requested; no privileged guest execution channel was established or attempted. Actual SQL inspection outcomes/errors are still pending, not classified as success or access denial.

[Independent retention evaluation](EXTERNAL_RETENTION.md) observed Enhanced Session already checked and adequate host capacity for the small candidate backup, without testing file transfer or changing resources. This does not close backup integrity, independent-copy or restore gates. An executable restore plan still requires actual logical-file/backup-position results and target review; none is generated with guessed mappings.

**PREPARED_NOT_EXECUTED / ERP THIRD TEST STILL BLOCKED.** No source mutation, recovery database, third acquisition or changed-business-row import has occurred. Next input is the owner's actual inspection report/hash, not another approval of the already authorized consumption issue. The independently verified DBL-state copy remains separate from ERP-recovery evidence.

Primary references: [VERIFYONLY semantics/permissions](https://learn.microsoft.com/en-us/sql/t-sql/statements/restore-statements-verifyonly-transact-sql?view=sql-server-ver15), [backup header fields](https://learn.microsoft.com/en-us/sql/t-sql/statements/restore-statements-headeronly-transact-sql?view=sql-server-ver15), [logical file metadata](https://learn.microsoft.com/en-us/sql/t-sql/statements/restore-statements-filelistonly-transact-sql?view=sql-server-ver15), [restore to a new name/location](https://learn.microsoft.com/en-us/sql/relational-databases/backup-restore/restore-a-database-to-a-new-location-sql-server?view=sql-server-ver15). Documentation supports the proposed procedure; it is not executed recovery evidence.
