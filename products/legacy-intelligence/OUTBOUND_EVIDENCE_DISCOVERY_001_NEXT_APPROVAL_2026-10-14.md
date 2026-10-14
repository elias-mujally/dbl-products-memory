# Outbound Discovery 001 — Exact Next Owner Gate

## Decision

[Discovery completed, outbound NOT QUALIFIED](OUTBOUND_EVIDENCE_DISCOVERY_001_REPORT_2026-10-14.md). Do not implement an outbound contract/presenter from draft5, historical zero or a negative cash/journal amount. Historical balance37 and inbound37 remain intact.

**One recommendation:** authorize a bounded **offline evidence handoff for one existing saved outbound**, not product development or resuming accounting diagnostics. First establish whether the owner/source custodian actually has such an existing event/export. No account creation, permission expansion, SQL/ERP operation or new stock event is implied.

## Minimum evidence package missing today

1. Genuine saved outbound header, stable source document key/composite discriminators, document class and reliable business date with original timezone/wall-time basis; explicit saved/cancelled/void/reversal/review/inventory-effective state.
2. Exactly one selected line linked to that header, stable line identity/number, item identity/name, branch, warehouse, unit, package/conversion, quantity and relevant free/subquantity components. Do not assume a generic FK or reuse purchase mappings for issue tables.
3. Inventory movement linked to the exact document/line within the same recorded source image; its stable serial/identity, sign/direction/type and complete selected components. Sign alone or a balance difference is insufficient.
4. Independent source/official-workflow corroboration and a same-scope reconciliation before/after or qualified report/calculation. Accounting posting is tracked separately: final GL-posted is not silently required for inventory-effective, nor inferred from it.
5. Original byte hashes/manifest, export method and authorized custodian, exact ERP profile/company/year/database/source-as-of/acquisition interval and backup/image identity if applicable. Preserve the original bytes outside Git; publish only selected non-sensitive evidence findings.
6. Cardinality/duplicate/orphan checks: one business event even if document, receipt/dispatch and item_mov all represent it; extra/unknown rows cause STOP, not arbitrary first/distinct or fallback0.

The current frozen post-S2 retained projection contains only zero/+37; it cannot prove an unperformed or later outbound. Do not use this backup UUID/as-of to label a later export unless independently bound to the same image. A later real event requires its **own** source/time binding, not an invented current37 or subtraction to32.

## Exact approval sought now

Owner approval for **OFFLINE OUTBOUND EVIDENCE HANDOFF 001 ONLY**:

- identify an existing saved outbound and give authorized access to its retained bounded exports/provenance;
- hash and inspect those files read-only and qualify/reject the event;
- no SQL/ERP connection, no new transaction/account/permission, no product/Canonical/SQLite change, no import, no original writes;
- STOP if the package is missing, contradictory or cannot establish document → line → inventory linkage.

If obtaining the package actually requires live SQL/ERP, preparing another source image or creating a controlled lab event, **stop and submit a separate exact acquisition/transaction plan first**. Do not treat this proposed handoff as authority for those operations. Do not start by granting Reader VIEW DEFINITION or reusing an admin connector.

## Conditional fallback: second genuine inbound

A second inbound could be useful to exercise document identity/date/state/cardinality beyond the single hard-scoped current profile, but **no second genuine document has been qualified in the reviewed files**. Generated receipt1 and movement2 already belong to purchase1; zero is not inbound2. The present connector intentionally accepts only the pinned case and will not generalize automatically.

If the owner already holds a different genuine saved inbound document/export, it can undergo the same bounded offline evidence handoff under a **separate named inbound qualification authorization**. This avoids guessing the currently unresolved ordinary-issue debit/account route. It would test a different document but would **not solve or count as outbound qualification**. If no second event exists, its creation/acquisition also needs separate approval; do not perform a new purchase merely to obtain green product tests.

## Only after qualification: proposed implementation, not authorized

Should one outbound later qualify, define the smallest typed versioned observation carrying the proved document/line/movement, direction, exact quantity/UOM/scope/date/state and provenance; keep historical/live distinction and quantityOnHand separation. Determine whether existing whole-JSON storage remains sufficient and prove old-reader fail-closed before deciding a schema/migration delta. Use an independent file-only profile, no live SQL driver.

Acceptance would require original-file extraction and dedup/reconciliation; synthetic negative cases for missing keys/state/scope/date/provenance and double counts; ImportOrchestrator → isolated SQLite → close/reopen → SnapshotReader → pinned application Arabic preview. Display only the proved meaning, not sales/physical/current stock. Cross-platform build/typecheck/tests and bounded Worker/WAL plus independent review would follow a **new implementation authorization**, not this discovery.

**Owner gate now is evidence handoff, not implementation/merge/release. STOP.**
