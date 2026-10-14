# Outbound Evidence Discovery 001 — NEXT, proposed only

Recommendation after [merged inbound](MERGED_STATE_2026-10-14.md): discover whether owner-retained evidence contains **one real, saved, inventory-effective outbound**. This is a proposed next scope, not execution authority, qualified outbound or a code implementation. No SQL/ERP/production/release is authorized by this document.

## Evidence-first acceptance before implementation

1. Inventory retained original artifacts and their recorded source/as-of/profile/backup identity and existing pins. Record missing originals explicitly; do not invent source files/hashes or substitute synthetic positives.
2. Establish a unique document/header/line/movement linkage, actual item, branch, warehouse, unit/package, signed outbound contribution, business date basis and saved/cancelled/inventory-effective/final-accounting states from qualified evidence. Do not assume all outbound is a sale or that final GL posting is required for every inventory-effective state.
3. Reconcile the selected event against independent qualified source evidence; handle duplicate/orphan/multi-row candidates explicitly. Separate event qualification from historical book/available balance and from today's stock. No missing-row→zero or balance-difference→outbound inference.
4. Reject cancelled/unsaved issue draft 5 as proof; **32 remains unsupported**. Retain zero-row provenance PARTIAL. Invoice/receipt/movement representations cannot multiply one event.
5. Produce a bounded qualification report with source pointers, scope/time/state, eligibility and unresolved gaps. Classify DONE only if the selected event is evidence-qualified; otherwise NOT QUALIFIED with a concrete reason.

## Fallback and later gates

If no qualified outbound exists, explicitly record **NO QUALIFIED OUTBOUND EVIDENCE FOUND** for the reviewed evidence set, not outbound=0. Recommend one additional evidence-qualified inbound case to test scope/identity/date/state/cardinality generalization. Do not promise a generalized ledger, create ERP transactions, or launch live discovery automatically.

After owner review of the discovery result, a separate implementation scope may decide the smallest contract/connector/display delta, offline Canonical→ImportOrchestrator→SQLite→reopen→SnapshotReader→pinned Application Service acceptance, negative tests and Windows/Linux verification. Those gates are NEXT, not already passed for outbound. Current stock, physical count, final GL posting, multi-document ledger and live ERP integration each need their own evidence and authorization. The memory Draft PR must remain unmerged until separate explicit owner approval.
