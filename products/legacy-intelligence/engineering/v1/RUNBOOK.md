# V1 — reproduce, operate, retain and recover

Current operator workflow: [package decision and acceptance](OPERATOR_PACKAGE.md), with the product Arabic guide in [PR20](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/20). Existing detailed steps below remain historical/source-reference context; use the new command guide for ordinary operation.

[Index](README.md) · [Decision](ADR-V1-001-FILE-REFRESH.md) · [Evidence registry](EVIDENCE.json)

## Source prerequisites

Use V1 only: standalone non-elevated VMConnect; Windows10 build19045 per the established history; the owner-pinned local guest SQL instance/test database; endpoint selectors are retained privately. The original host ERP databases and old labs are separate and not required. Do not rerun old setup, repair FMMA, create test transactions or enable networking for an import.

The existing native backups are guest-local and not restore-tested. Retain the successful raw/reference/readback files and local code bundle before changes. File evidence cannot restore the whole ERP database.

## Acquisition and transfer

1. Open product `tools/v1/Acquire-V1Inventory.txt` on the host. Its exact R3 SHA-256 is listed in EVIDENCE.json. Copy its complete text into the owner's current PowerShell session inside V1. Do not execute the TXT pathname, change ExecutionPolicy or elevate.
2. Avoid simultaneous ERP edits during the short SERIALIZABLE read. The code validates VM/server/database identity, reads metadata and fixed bounded tables, checks row completeness and rolls back the SELECT transaction. No ERP table write, user-defined function or stored procedure is executed.
3. Preserve the newly generated JSON and record the SHA-256 displayed independently. Transfer/attach that file by an authorized operator route. The guest Public Documents path is not the same file as a similarly named host path. Current automation does not qualify a transfer channel.
4. Hash the received bytes and reject mismatches. Do not repair/trim/reformat JSON to force a match. Do not use the reference report JSON as an acquisition source.

## Development and repeatable import

In the product checkout, use the qualified Node22 compiled build and pinned dependencies. `npm run verify` builds/checks/tests the workspace. Operator syntax:

```text
npm run v1:refresh -- SOURCE_JSON SOURCE_SHA256 PRIVATE_STATE_DIRECTORY
```

Run the command in a normal host session against files only. Reuse one new dedicated state directory for all repeated imports. The initial successful run-02 is preserved separately. No old reference balances are required by this entry point.

Advisory-review requirements: use owner-private local storage, outside shared/network/cloud-synchronized locations. New POSIX state uses0700/0600 and refuses broad/non-owned directories without chmod; Windows privacy requires owner-provisioned ACLs, not a mode-bit assumption. A permanent empty bootstrap reservation permits resuming recognized incomplete initialization; do not delete it as a stale lock. Atomic final-name publication requires local hard-link support. Process interruption is tested; power-loss guarantees are not implied. At16 interrupted pending files the app stops for owner review without automatic cleanup. Unknown/corrupt final metadata remains blocked. See [the measured advisory review](ADVISORY_REVIEW.md).

`applied` means a supported later/new observation committed; `replayed` means an existing acquisition was verified without a new checkpoint; neither alone means a fresh ERP read occurred. Inspect source/current capturedAt, snapshot/hash, current products/value and checkpoint count. Exit2 / committed-needs-attention means a committed snapshot requires follow-up, not a proven rollback.

## Failure handling

- Hash/profile/schema/sign/cost/linkage mismatch: reject; do not edit ERP, alter stored quantities or substitute GUI expected numbers.
- BUSY: another admitted import may be running; do not steal a lock or delete control.sqlite. Retry after the other process completes. OS releases the transaction on a process exit.
- Hard exit after commit: retry the same pinned source. A deterministic snapshot ID reconciles to the existing checkpoint; the new receipt links an unfinished run. Never manufacture a new hash just to retry.
- Unseen older/equal-time or future-skew capture: inspect the actual source clock/acquisition; no timestamp rewrites.
- Corrupt retained bytes, unsupported state/control format or migration drift: stop and preserve files. No automatic repair, metadata checksum reset or archive overwrite.
- Retention cap: 32 snapshots / 256 attempts; preserve a complete quiescent state and review archival before new state. No automatic deletion/pruning.

For consistent backups of DBL state, stop refresh invocations and copy the complete closed directory, not one live SQLite file without its WAL. Code baseline is recoverable via local tag/bundle; code/evidence rollback does not restore ERP itself. No destructive reset instruction is provided.

## Qualification discipline

Actual ERP rows, GUI report comparisons, synthetic negative cases and actual repeated CLI invocations are separate evidence classes. Current business results are five products and 1470 SAR only for the pinned fixture. New supported rows may produce different quantities/value. No sales/customer return/requisition receipt is inferred. Final GL posting, live SQL, automatic capture/transfer, Windows license/ESU status and broad/production workload remain open unless independently qualified.

When changing code or learning a new source fact, update RECURRING_STATUS/EVIDENCE plus the affected semantics/ADR; keep this runbook concise. Publication of these local drafts is a separate owner decision.


## Qualified third-source reproduction

The one-unit issue has already been saved; never repeat it as an import retry. Use [the actual third result](THIRD_CAPTURE_RESULT.md) and evidence hashes to reproduce using a verified private copy of the preserved two-snapshot state. Four independent compiled CLI invocations (third/third/second/first) must return applied/replayed/replayed/replayed, keep three checkpoints and latest29/3/50/2/12/value1450SAR. Old snapshots remain1470SAR; compare all existing snapshot/product/audit rows, reopen store/Application Service/audit and check integrity/FKs. Three audit actions per invocation are expected, not two. Preserve failing receipts; do not reset metadata or fabricate capture times. The fixture after change has11movements,12journal rows and6documents. This workflow remains owner-assisted and offline; no new source account, service, network or automatic schedule is qualified.


## Operator recovery contract

Use v1:operator check before import, status for source-verified retained history/audit, report for a new private offline Arabic HTML, and backup before significant DBL imports. Retain the returned manifest SHA-256 independently and supply it to verify-backup/restore. Restore only creates a new separate DBL state; it never restores ERP or replaces current storage. Nonempty WAL/journal, unresolved starts, missing audit completion, pending evidence, corrupt/foreign state, unsafe paths or mismatched hashes stop without cleanup/repair. The original refresh entry point and narrow source profile remain unchanged. [Exact command surface, failure cases and evidence](OPERATOR_PACKAGE.md).

For retained-file handover, require private runtime/build/revision/tree/lock/native fingerprints and source pins/locations; owner-private Windows directory readiness is separate. Use one new state and chronological files; no VMConnect/extraction/ERP action is needed. Windows npm.cmd/current-process runtime selection avoids ExecutionPolicy/persistent PATH changes. Replay current/oldest-known files, retain3snapshots/5products1450SAR, then pinned backup/verify/new-directory restore/separate-process status. Record operator identity, first-attempt errors and any assistance. [Independent second-agent acceptance](OPERATOR_HANDOVER.md) differs from engineer tests and unperformed human/clean-install/browser review.

The [local Windows preview](WINDOWS_DELIVERY.md) replaces development-tool prerequisites for the delivered operator only: independently hash ZIP before running it, extract to a new trusted folder, DBL.cmd verify/doctor with package pin, then run with owner-private-storage acknowledgement and external absolute local data paths. Package pin and state-backup pin are different. Keep the exact compatible build and prior states; do not install DLLs, alter policies/ACL or repair manifests on failure. Engineer assembly still requires its declared prepared toolchain. The preview's repeat assembly/relocation tests do not qualify a clean machine or human acceptance; no public release is authorized.


## Independent Windows acceptance

Follow [the independent gate](WINDOWS_CLEAN_GATE.md) and its linked Arabic product procedure. Preserve Preview1; use the separately pinned companion, fixed synthetic source hashes and new Arabic/spaced data paths. A passing18-call actual-wrapper rehearsal leaves clean/human/ACL/Defender/browser/production flags false pending separate evidence. No independent environment is available now; do not substitute V1/historical labs or create infrastructure without approval. Defender/browser refusals remain blockers without bypass.
