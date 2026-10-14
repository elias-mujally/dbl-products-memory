# FIRST INVENTORY INSIGHT #001 — evidence-only readiness review

> Historical checkpoint preserved. [Merged state 2026-10-14](MERGED_STATE_2026-10-14.md) and [evidence register](EVIDENCE_REGISTER_2026-10-14.md) supersede earlier implementation/next-step gaps only within the qualified offline case. PR13/14/16/15/17 are merged; one inbound37 is qualified separately from historical balance37. No current stock, outbound, physical count, final GL posting, generalized ledger or live ERP qualification follows. Original failures/results/hashes below remain their original evidence; no raw re-verification or helper execution in this memory update.

Date: 2026-10-13, Asia/Aden. Owner direction: FIRST INVENTORY INSIGHT first; FIRST SALES & INVENTORY INSIGHT only after the first stage passes.

**INVENTORY READINESS REVIEW = COMPLETED.**
**FIRST INVENTORY INSIGHT #001 = NOT TESTED / NOT PASSED.** This document proposes a later separately authorized test, not permission to execute it. The historical scoped quantity is 37; 32 is not an established balance. No live SQL query, credential request, FIRST LIVE DATA rerun, ERP/UI operation, host change, Connector/Canonical/SQLite edit or implementation test was performed in this review.

**Later owner-approved source qualification:** [full sequential evidence](DBL_INVENTORY_SOURCE_001_QUALIFICATION_2026-10-13.md): initial pre-SQL preparation STOP at archived array parsing; separately authorized correction passed offline; then the first real Reader attempt connected with strict TLS and passed identity/READ_ONLY/inventory permissions, but stopped at unavailable current function definition (VIEW DEFINITION=0). No business projections or function invocation, dependencies not reached, no new balance/import/SQLite. Source qualification NOT PROVEN; separate read-only administrative metadata attestation would require owner authorization. No automatic retry/grant/fallback. Readiness findings remain intact.

## Evidence and implementation actually reviewed

The starting Product Memory head was `18103493b45e80fc22a3c9f96eb0a1dc044a4ff1`. Reviewed [final real import](DBL_FIRST_LIVE_DATA_001_REAL_SQL_IMPORT_2026-10-13.md), [Host S1/S2/S3 history](MOTAKAMEL_HOST_W11_BASELINE_2026-10-06.md), [S2 reconciliation](MOTAKAMEL_HOST_W11_S2_TARGETED_RECONCILIATION_2026-10-09.md), [frozen-stage/Reader qualification](MOTAKAMEL_HOST_W11_POST_S2_FROZEN_READER_QUALIFICATION_2026-10-09.md), original controlled-dataset sequencing and current architecture decisions. Earlier pending/blocked statements are historical where later evidence supersedes them, not grounds to repeat successful setup.

Local retained evidence hashes below were recomputed in this review. Inspected relevant existing JSON projections, archived function definition/parameters/dependencies, saved report observations and helper query text **without executing the helpers**. Archived FindAvQty definition's UTF8 SHA256 was independently recomputed as `235E8D7379760735FA7E4F3613CD2F67E822EF974B7C990A3E281665659C2628`, matching the frozen qualification.

Local implementation checkout is clean at `84eadfddfd064ada961e36675ceffe24e33f2f3a`, tree `51f15b2a1113fc3742559f7d76dab350fb8bb83c`, the exact merged-main tree verified in FIRST LIVE DATA. No new remote-main freshness or current SQL service-state claim is inferred from this offline review. Actual source inspected: `packages/connectors-motakamel-plus/src/{source,index,mapping,profile,acquisition}.ts`, `packages/core/src/{model,connector,storage,validation}.ts`, and existing insight rules. No source files changed or tests run.

### Evidence identity, preserved locally

Paths are relative to the task workspace, not Product Memory. These database evidence exports stay local; only this selective nonsecret review is published.

| Retained file | Recomputed SHA256 |
| --- | --- |
| outputs/host-motakamel-s2p-save-20261008/SAVE_EVIDENCE.json | `938D31CA336A765F231C9E95EE474C170CBC415C5322C769809754C64D006A61` |
| outputs/host-motakamel-s2-targeted-reconciliation-20261009/READ_ONLY_EVIDENCE.json | `32E187E8AC71F0895EC2E93BBF78FACC46AA8CB17088776E1F4DB208E222BCA4` |
| outputs/host-motakamel-posts2-frozen-20261009/QUALIFICATION_EVIDENCE.json | `7D742175B6652860C7974115F8A1CBB789F49D86ACAD4FC5DD40CFCE310E7BAC` |
| outputs/host-motakamel-s3-issue-discovery-20261008/READ_ONLY_EVIDENCE.json | `83C73240BFAE62755D429D0DA6FA00B54C9A74E8AD5ED45FEDF7F8565869000C` |
| outputs/host-motakamel-s3-debit-account-qualification-20261009/READ_ONLY_EVIDENCE.json | `9D3BD5E23B2DF1BB1CDE029A1B4DA88D3032E04FB473162E2E867C8AD8AC1C93` |
| outputs/host-motakamel-s3-expense-route-discovery-20261009/READ_ONLY_EVIDENCE.json | `B66BFA787897A6E800D8E27B261EAE68284E2FA80E73709C8C2D141E0C03112E` |
| outputs/host-first-live-data-001-20261010/FIRST_LIVE_DATA_001_RESULT.json | `DEFA4ECA67EE7798C8837A7E80DD560E3E33254C2D85ADEE71F0F6A06B1A30FC` |
| outputs/host-first-live-data-001-20261010/FIRST_LIVE_DATA_001_CANONICAL.json | `E41349ED3B8869D3045BD32746DD696E3CF1C1B53C5465A9DF124E3E11B71F26` |

## 1. What S1, S2, S3 and FIRST LIVE DATA proved

| Stage | Established by existing evidence | Not established |
| --- | --- | --- |
| Host S1, October7 | One official Save and independent reload of Item A, UA/DBL_UNIT_A, Group001 and primary package1; keyed item/unit relations. | Item creation, AvailableQty=0 and a table count alone do not establish zero inventory, cost/price correctness or a stock transaction. |
| Controlled Zero | Accepted explicit scoped UI-zero observation with supporting bounded source evidence; remains PARTIAL. | Producer/business provenance of the historical doc_type11 zero movement unresolved. No universal missing-row/zero rule. |
| S2-P, October8 | One saved/reloaded immediate cash purchase, PKDoc `1-44-1-0-1`: 37 UA/package1, Branch1/Warehouse1, cost100 SAR and total3700. Same-event receipt and signed +37 movement; scoped official available-quantity report37. | Not three inbound events; not111. Final GL posting, all payment/lifecycle variants, supplier history and current physical count unqualified. |
| S3, October8–9 | Unsaved ordinary issue draft quantity5 and automatic valuation500; official Help describes its possible non-sale issue role. Cancellation and before/after bounded equality preserved stock37. Later account-route discovery remained ACCOUNTING-BLOCKED. | No saved issue, no qualified -5 movement, no sale, no actual expense posting; no32 balance. Suitable expense-account Save/eligibility unresolved. |
| October9 frozen Reader | Isolated post-S2 READ_ONLY DB10. Independent Reader read FindAvQty37, two scoped movements (zero and +37), matching unit/warehouse/purchase relations; repeated reads and reconnect equal. | Not current writable ERP state, physical inventory, universal stock authority, or a Node inventory Connector result. |
| FIRST LIVE DATA, October13 | Strict actual production-driver TLS/Reader connection; real SQL identity `{id:DBL_P001_ITEM_A,name:DBL_ITEM_A}` through ImportOrchestrator/SQLite/SnapshotReader; counts1/0/0. | The retained canonical Product contains only id/name. No quantity was acquired/imported; no inventory or sales insight passed. |

**37 minus 5 is arithmetic, not source proof.** The 37 inbound was saved; the 5 issue was only proposed and cancelled. Existing evidence shows two movements, signed totals37 and zero free/sub quantities; no -5 event. Do not resume S3/accounting setup to manufacture32. S3 is not required to prove the already-qualified post-S2 balance. The frozen image predates any hypothetical later movement.

## 2. Qualified source and exact meaning

### Preferred authority and scope

Candidate is the existing ERP scalar function, invoked in the **frozen stage only**:

`dbo.FindAvQty(1, N'DBL_P001_ITEM_A', 1, NULL, NULL, NULL)`

Recorded parameter order/types: branch int; item nvarchar20; warehouse int; date nvarchar10; expiry date; batch nvarchar20; return float. Use a fixed, parameterized SELECT later, not arbitrary SQL, stored-procedure execution, warehouse0/all-warehouse mode, or an invented date filter. NULL date selects all applicable movements in that frozen image, not a promise of stock on October13. NULL expiry/batch are part of this qualified untracked profile, not a general batch/expiry policy.

Approved claim: **ERP-computed available inventory in the post-S2 recovered image, Item A, Branch1, Warehouse1/DBL_WAREHOUSE_A, UA/DBL_UNIT_A, primary package1 / unit-level1.** Arabic display must say this scope, for example «الرصيد المتاح المحسوب من نظام المتكامل — صورة ما بعد S2 — الفرع1، المخزن1، UA، العبوة1». It is not independently counted physical stock, stock reserved/free-to-promise, a sales/demand measure, or today's writable ERP balance. A physical-count claim needs separate real-world count evidence/authorization, not more arithmetic.

Historical comparison authority is the recorded official Crystal stock preview for exact item-from/to, Warehouse1-from/to, Branch1, UA, unit-level1, available-quantity mode, report date2026-10-08. It displayed DBL_ITEM_A/UA/package1/Branch1/37; item code was clipped and warehouse was in parameters, not a printed warehouse column. Exact filters plus unique saved master establish the recorded identity. This review reused saved observations; no image payload exists in that artifact and no new visual/report verification is claimed.

### Sources, joins and boundaries

| Source | Qualified role / relationship | Rule for the proposed one-scope test |
| --- | --- | --- |
| item_detail | PK i_code; i_a_name, i_measure, i_size, p_code, p_size; tracked expiry/batch flags | Exactly Item A/name/UA/i_size1/p_size1, root p_code='0', no alternate conversion/tracking path. Master root p_code='0' is not movement/package P_Code. |
| Item_Detail_Units + Measure | PK(I_Code,P_Code,Measure_Code); item/unit FKs; recorded ItemA/ItemA/UA, Main_Unit=true, Unit_Level1, I_Size1; Measure UA/DBL_UNIT_A | One exact primary relation; reject additional unsupported unit/package semantics, not label matching. |
| W_DETAIL | PK(W_CODE,Branch_no), corroborated W1/B1/name | Resolve actual Branch1+Warehouse1. Branch1 alone is not warehouse proof. |
| item_mov | Exact item/Branch1/w_code1; Measure_CodeUA/p_size1; two recorded rows | Signed quantity0 and +37; free/sub components0. Serial1/2, raw PKDoc/UKeyID and event discriminators identify this case, not catalog-proven universal unique keys/FKs. Do not deduplicate by arbitrary DISTINCT/first. |
| FindAvQty | Archived definition and dependencies local item_detail/item_mov only | For root/base package1/no date/expiry/batch path, result is SUM(inout_qty)+SUM(inout_fqty). Function also calculates sub quantities in other branches; those conversion paths are not qualified here. |
| Bills/Bill_detail + gr_note/gr_detail | Previously proven saved purchase→receipt→movement corroboration, samePKDoc/scoped cardinality | Retain existing provenance for +37, not rescan purchases for this inventory-only test. Bill_detail line UKeyID matches movement in this case; receipt line UKeyID differs. No purchase amount as stock or Sale. |
| item_store.avail_qty/p_qty; item_detail.AvailableQty | Recorded0 while trusted scoped available quantity37 | Not an approved balance authority; existing Reader also has no item_store grant. No cache fallback, repair or new grant. |
| opn_stock / item_detail_Dtl / purchase footer | Empty opening table, branch cost placeholders and selection-dependent footer observations | None independently establishes a balance. No opening-balance synthesis or generalized footer authority. |

The archived function has other package, sign, date, expiry and batch branches and returns0 when its computed result is NULL. Thus even a successfully returned0 is not sufficient missing-data/zero proof. Validate required master/unit/location and movement evidence before invocation. Do not filter all movements by final ledger Posted=true: S2 inventory effect was established with Bill_post=false / receipt InvPost=true and unfinished GL posting. Draft5 has no persisted movement; lifecycle meaning comes from demonstrated effects, not guessed status names.

Quantities and function return are SQL float(53). Historical37/0/1 are finite safe whole integers exactly representable in this control case; fractional rounding or universal decimal fidelity is not qualified. Proposed test accepts this integer-only case and transports canonical quantity as decimal string `"37"` **only after actual source checks**. No rounding, epsilon equality, float-to-decimal cast presented as recovered precision, or default0. IDs such as bigint serial_no are selected/retained as text, not silently converted to unsafe JS numbers.

## 3. Smallest safe later source qualification

**Proposed, not run:** one bounded independent-reader acquisition from the existing frozen DB; no new transaction, backup, restore, S3 Save or current-source query. Expected result37 comes from historical evidence, not a hardcoded replacement for the next read.

1. Refresh service/PID/sole permitted listener and discover dynamic port; keep SQLBrowser Stopped/Disabled. Check exact approved CA/Leaf/public hash and merged build profile. Existing strict Node TLS/hostname/pinned-only CA/zero transient retries and hidden owner-password input remain. No host/security remedy or credential rotation on failure.
2. Verify SQL2014/frozen DB10/READ_ONLY/current original-effective Reader/user and required SELECT on item_detail, Item_Detail_Units, Measure, W_DETAIL, item_mov plus object EXECUTE on FindAvQty; no broad/admin/write rights. These grants already exist in October9 evidence, but FIRST LIVE DATA checked identity-only permissions, not a fresh positive inventory-permission proof. Do not execute denial/write probes or change grants.
3. Validate function identity/parameter types/current definition hash and local-only dependencies against the archived fingerprint **before invoking it**. Fresh Reader access to definition/dependency metadata is NOT proven by the retained projection or EXECUTE grant. Missing/NULL/invisible metadata is not a match: STOP. If Reader cannot establish the required definition identity, request a separately approved read-only administrative metadata attestation of this exact function/stage; no permission expansion or admin Connector fallback. Do not treat READ_ONLY as protection against privileged thaw/replacement. A new required grant is outside the proposed test.
4. Read only fixed target projections: one item, one primary unit/package, one UA definition, one Branch1/W1 row. Parameterize item nvarchar20 and integer scope; reject missing/duplicate/wrong binding. Read scoped COUNT_BIG as text and capped TOP(3) movement projection as an overflow guard; require exactly the two qualified rows, base unit/package and no unexpected free/sub/batch/conversion contributions. Compare raw event identities, quantities and saved historical projections. No unbounded SELECT* or wider business scan. Fixed scope cardinality2 limits the function's evidenced aggregation; TOP alone is not a universal bound on arbitrary function work.
5. Invoke the verified scalar once with exact parameters. Require one finite safe integer scalar; independently sum the actual signed quantity/free contributions in this base scope using exact integer arithmetic. Require function = movement reconciliation = historical scoped report37. Any unexplained number/change (including32), unsupported/missing row or mismatch is STOP/evidence gap, not repair, resubstitution or automatic broadening. Numeric function result0 alone never passes.
6. Recheck source identity/READ_ONLY and close resources before handing off the acquisition. Use existing10s connection/request budgets, one caller acquisition, no retries and no speculative query variants. Pool/health validation may establish additional physical connections; do not promise one socket. Preserve sanitized outcome and limited scoped evidence; no raw errors/credential dumps. No DBL inventory PASSED yet if the source qualification alone passes.

## 4. Existing Connector fit and smallest proposed extension

**Current Connector cannot be used unchanged to meet the inventory goal.** Source code declares inventory=false, only TOP(2) i_code/i_a_name SELECT, mapping exactly two columns, Product.id/name only and identity-only replay/profile validation. Feeding a new quantity column to the old mapper fails its closed-world projection guard. A runner that hand-adds37 to the existing acquisition would bypass provenance and is prohibited. FIRST LIVE DATA's retained identity snapshot must not be relabelled or overwritten.

Reuse qualified direct-port transport, TLS/secret handling, frozen Reader/profile guards, session lifecycle, bounded cached acquisition and existing ImportOrchestrator→SQLite→SnapshotReader. Proposed **specific Item A scoped-inventory increment**, not a generic SQL/movement framework:

- Add only the fixed inventory projections/scalar and exact scope/type/cardinality/reconciliation guards above; keep identity-only behavior supported and covered by regression tests. Assign a distinct versioned inventory profile/acquisition identity; never replay identity-only evidence as inventory proof.
- Existing Product.quantityOnHand is a DecimalString and existing SQLite/SnapshotReader can preserve it without a schema migration. But Product has no unit/warehouse/available-vs-physical semantics: numerical capacity is not semantic approval. **Before coding, owner must explicitly approve** using this scalar for the exact declared ERP-book/available/base-unit/one-warehouse profile, never generic physical/global quantity.
- Proposed minimal no-Canonical-change route: immutable approved scope/mapping definition identified by SourceRef.sourceVersion, plus a local acquisition manifest bound to connectorId/snapshotId, canonical content fingerprint and evidence hashes. It must retain exact function/query/parameter identity, branch/warehouse/unit/package, balance meaning, source backup as-of and observed/acquired times. Reader/application output must resolve that pinned profile/manifest and display its meaning and scope; quantity alone is not a passing DBL insight. This binding/display is required future implementation work, **not an existing storage feature proven by this review**. If scope cannot remain reliably bound and readable, STOP for a separate minimal contract decision; do not add unknown canonical keys or hide scope in a name.
- Keep core Canonical schema, SQLite migrations and insight engine unchanged initially if that explicit one-profile mapping is accepted. No purchases/sales/cost/prices/supplier or generic multiwarehouse domain. No low-stock/reorder/depletion/valuation rule: first insight is a sourced inventory fact with reconciliation, not a default threshold alert. Existing LowStockRule threshold5 is not the draft issue5 and supplies no business truth.
- Later offline tests must cover exact positive scoped37 and counterexamples (missing/duplicate/wrong scope/unit, cached0 substitution, extra/outgoing movement, nonfinite/fractional/unsafe numeric, metadata unavailable/changed function, orphan provenance, source thaw, cleanup/import failure). Fixture tests qualify implementation only; subsequent separately authorized real Reader acquisition/import proves the goal.

## 5. Verifiable success criteria for the later inventory experiment

Declare **FIRST INVENTORY INSIGHT #001 = PASSED** only when all are evidenced:

1. Actual approved frozen SQL source and limited Reader, current strict TLS/direct endpoint and READ_ONLY/profile/function/permission gates pass; no mock/replay/manual alternative used as live proof.
2. Exactly Item A/name and one qualified Branch1/W1/UA/package1 basis. Verified function scalar and independently reconciled actual scoped movements equal historical37, without rounding/defaults/deduplication or assumed37−5.
3. Provenance records actual source IDs, function hash and exact params/query version, mapping/build, backup UUID/hash/as-of, acquisition UTC, one snapshot ID/content fingerprint and comparison evidence. Recovered source as-of `2026-10-09 08:12:11+03:00` is distinct from October8 transaction/report date and new acquisition time; it is not today's ERP balance.
4. Same real acquisition passes Connector → ImportOrchestrator → new isolated SQLite → SnapshotReader; exact quantity decimal string and source/snapshot/profile agreement, products1/customers0/sales0, one committed import attempt, no retry, no partial commit. Existing FIRST LIVE DATA artifacts remain unchanged.
5. DBL read output presents number **with its verified available/book meaning, UA/package and branch/warehouse and frozen as-of**, with accessible bound evidence/manifest. Missing scope is failure even if number37 is visible. No low-stock/sales/physical-inventory claim inferred.
6. Post-guards and cleanup pass, no source/grants/host/TLS changes; actual stages and limitations are recorded separately. Unexpected differences STOP; no automatic repair or second attempt.

## 6. Required owner decisions and bounded rollout

Next smallest authorization: **one read-only inventory-source qualification** for the exact tables/function/metadata and scope listed in section3, using existing Reader/secure hidden input, no import or permissions/host changes. Metadata invisibility may require a separate read-only administrative function attestation; this is not already authorized or demonstrated.

After source gates pass, request separate approval of the precise available/book scalar semantics and immutable scope/provenance binding, then the limited Connector/profile/display extension and offline regression/CI review. No code implementation is authorized by this readiness request. After reviewed/merged implementation, request one bounded real inventory import into a fresh local SQLite/evidence directory; do not reuse FIRST LIVE DATA's output or authorization. Owner may combine these explicitly delimited approvals later, but a failed earlier gate forbids proceeding to the next.

Residual risks: historical report observation rather than a new preview; Controlled Zero PARTIAL and unresolved zero-row provenance; floating-source semantics limited to this integer case; no physical count/reservation/depletion/cross-version/all-state authority; constrained metadata visibility unproven; frozen stage mutable by an administrator; machine-wide Root/single-host CA custody and CRL/OCSP UNKNOWN remain accepted laboratory gaps, not production readiness. Dynamic port must be observed later. No new TLS/PKI/archive project is necessary. First insight does not require completing S3 or solving its accounting hierarchy.

## 7. Later phase, explicitly queued only

**FIRST SALES & INVENTORY INSIGHT #001 — DEFERRED until FIRST INVENTORY INSIGHT #001 passes and a new owner authorization is issued.** Goal then: qualified real sales linked to the proven item/inventory scope for a trustworthy business analysis. No sales table/field/eligibility study, SQL plan, Connector/Canonical design or implementation is started here. S2 purchase and S3 internal-consumption draft are not sales evidence. FIRST LIVE DATA customers0/sales0 reflect the authorized identity-only slice, not a global no-sales conclusion.

**STOP. Await owner approval of the bounded next test; readiness completion is not inventory-insight execution or PASSED.**
