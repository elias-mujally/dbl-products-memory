# Next Decision — Missing Outbound Linkage Precondition

## Existing live read-only acquisition approval is acknowledged

[Acquisition001 result](ONE_EXISTING_OUTBOUND_ACQUISITION_001_REPORT_2026-10-14.md): **BLOCKED / NO QUALIFYING EVENT**, at Phase A before SQL/ERP. This is not a live absence finding. Do not ask the owner to repeat the same broad access approval. Its mandatory safe-linkage precondition is not met by retained purchase mappings or S3 table counts.

## Smallest evidence input to proceed

Have the authorized ERP source custodian identify the exact test database/company/year and **previously approved restricted read access for that database**, then supply verified metadata for the selected outbound family:

- Actual header table/view, stable/composite source key and document discriminators.
- Actual selected line identity and exact header-to-line relationship.
- Exact line/document-to-inventory movement relationship and event cardinality.
- Saved/cancelled/void/reversal/review/inventory-effective fields and their proven interpretation; financial posting kept separate.
- Business date basis, quantities/free/subcomponents, UOM/package conversion, branch/warehouse fields.
- Metadata origin/time/version and the authoritative workflow/report that qualifies the meaning. Table names, historical counts, a negative number or purchase type26 do not suffice.

If this already exists in an authorized export/mapping package, provide its original bytes/manifest/path. Inspecting that package under a precise handoff is preferable to altering DBL Reader or improvising an administrator connection. No new transaction/image is needed merely to deliver metadata.

## If mapping must be obtained: proposed distinct metadata-only qualification

Owner decision needed to permit a **bounded outbound-family metadata discovery** rather than requiring an already-verified mapping. This is proposed, not run. Pin the source and existing restricted identity/access method first. Limit reads to the selected objects' names/types, columns/keys/foreign-key or view relationships and existing documented status semantics; no business row search, function/procedure execution, grants, accounts, configuration or schema changes. Verify test identity and effective read-only permissions before metadata access.

Use existing Reader visibility only if it covers the correct source/objects. The historically qualified Reader target is the Post-S2 frozen DB10 with nine SELECT objects; do not assume those grants reach the original writable DB7 or ordinary issue tables. If required metadata is hidden/inaccessible, **STOP without permissions expansion or administrative fallback** and request the custodian's qualified metadata export. Do not restart old identity diagnostics silently.

Approval of metadata discovery does not preapprove a guessed schema/status decoder. Only once source/access and safe linkage are qualified can a separately bounded one-existing-event acquisition use fixed, parameterized capped SELECTs and independent same-event reconciliation. No new backup/restore/source image or transaction is implied. No report regeneration is assumed side-effect-free; prefer an already-produced authorized report where needed.

**Success for the prerequisite:** complete authenticated source/access/family/key/status mapping with sufficient restricted visibility. **Failure:** unavailable/contradictory metadata, unresolved company/year/source, hidden object, unknown join/status or need for a new privilege/identity/image/transaction. Stop; do not claim outbound=0, subtract draft5 or implement a movement.

No product change/import/merge/release is proposed. Historical balance37 and inbound+37 remain scoped to their original image. **STOP at this exact decision.**
