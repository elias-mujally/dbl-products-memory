# Controlled Outbound Experiment 001 — Plan Only

## Decision: PARTIAL / MISSING PREREQUISITES

**A gated test design is prepared, but the experiment is BLOCKED before any ERP Add/Save.** Current stock, a qualified writable-source evidence route, actual outbound-family observability/status semantics, an appropriate existing issue counterpart and a named authorized ERP operator are missing. This is not execution approval, outbound qualification, or an unsafe-design workaround. See the separate [approval gate](CONTROLLED_OUTBOUND_EXPERIMENT_001_APPROVAL_GATE.md).

**الخلاصة:** التجربة المقترحة صرف داخلي تجريبي واحد بكمية5 UA، لا بيع أو تحويل أو جرد. لا تُنشأ مسودة حتى تتأهل وسيلة أدلة قبل/بعد، ويتحقق الرصيد الحالي والحساب المقابل وسلوك Save. لا37 كرصد اليوم، ولا32 كقيمة قبول. المالك يوافق على الإعداد والتنفيذ لاحقًا وبصورة منفصلة؛ لا اتصال SQL/ERP أو عملية جديدة في مهمة التخطيط هذه.

## 1. Verified planning baseline and historical limits

Verified GitHub/fetched main on2026-10-15:

- Product `415ad8acef5f5754487b83408bad6c9b9c58028e` — PR17 merged.
- Product Memory `e41e063af054969d126ad58232ecf13b27a460b8` — PR6 merged, matching the owner's reference.

Reviewed current AI_HANDOFF/CURRENT_STATUS and [schema/linkage result](OUTBOUND_SCHEMA_LINKAGE_001_REPORT_2026-10-15.md) / [next decision](OUTBOUND_SCHEMA_LINKAGE_001_NEXT_DECISION_2026-10-15.md), retained S2/S3 artifacts and the actual PR17 main `inbound.ts` / `docs/HISTORICAL_INBOUND_MOVEMENT_001.md`. Old reports are evidence, not current instructions to rerun helpers.

- Historical inbound **+37 UA** and available balance **37 UA** belong to the Post-S2 image as-of `2026-10-09T08:12:11+03:00`, backup UUID `2b9d2bde-8d89-4ee7-98de-224fb97060c7` / recorded backup SHA256 `E63DF84D2DBB22C5ACD535DC5881D2DCF417F420665502927EBD9AD66731E572`.
- Old issue draft5 was cancelled, SaveCalls=0. Unknown outbound is not0; historical32 is unsupported. Financial−3700 is not an inventory outbound.
- The latest actual Reader probe was **frozen DB10 only**, not original writable DB7: strict TLS/identity/READ_ONLY/exact grants passed; nine objects visible, eight tentative names unresolved. It did not qualify ordinary-issue header/line/movement mappings. Do not repeat that probe or relabel tentative names as issue tables.
- No current writable-source stock, company/year state, account eligibility or Save behavior was verified during this plan. No new image, SQL/ERP, credentials, product import or SQLite was opened/run.

## 2. What inbound actually proved — reusable method, not a purchase template

The file-only planning check matched11 existing artifact pins, then recomputed selected retained document corroboration and movement delta without executing the product or a SQL client. [Planning review receipt](research/CONTROLLED_OUTBOUND_EXPERIMENT_001_REVIEW_2026-10-15.json) records sources and inspected product-blob hashes.

| Inbound evidence actually retained | Reuse for an outbound / limit |
| --- | --- |
| One official cash-immediate-purchase Save on2026-10-08 after Gate A and action-time owner confirmation; SaveCount1/NoSecondSave=true. Retained Save start17:26:23.116Z =20:26:23.116+03. | One approved action, actual entered values, before/after checkpoints and no retry. Do not reuse cash-purchase workflow or assume issue Save rules. |
| Official search attempt did not prove retrieval; official First navigation subsequently reloaded the saved invoice in view mode without Edit/Save. | Prove persisted retrieval independently, not merely disappearance of Save or a transient success dialog. |
| Header `PKDoc=1-44-1-0-1`, Bill_no1, one line record1; line ID `0c02c7b5-2210-46f0-a82c-cea2997e6d3a`. | Record actual generated document/composite/line identities. Do not preassign number1, type26/transaction44 or a PKDoc format to an issue. |
| Before one zero movement; after two movements. Only added movement serial2 has same PKDoc/record and invoice line ID, contribution+37; old zero row is unchanged. | Compare keyed row sets, preserve old rows, establish exact line linkage and signed contribution from the actual family. Do not assume issue line ID equals movement ID or use latest/max serial alone. |
| Auto receipt has same event key/line and quantity, but different receipt line ID `9aa94621-dbf5-4702-9a98-4c17a6df3876`. | Multiple source representations corroborate one event. Do not sum document+receipt+movement, equate their IDs, or execute an extra dispatch/receipt. |
| Bill_post=false, receipt InvPost=true/gr_post=false; saved source movement and qualified scoped quantity37 corroborated inventory effect. | Prove stock effect separately from final ledger posting. These particular fields/values are purchase-specific, not an issue status decoder. |
| Sequential immediately-before, after-Save, reload, before/after-report stages;21 count anchors, protected masters and old zero row preserved. | Capture bounded full selected records, identity/time and expected-delta allowlist. Counts alone are not a relationship map; sequential reads are not atomic snapshots. |
| Independent targeted source/UI reconciliation, exact ItemA/B1/W1/UA/package1; later repeated/reconnected restricted frozen Reader projection matched the source. Source function was inspected then; current definition is not attested by that history. | Separate persisted-record evidence, stock authority and independent workflow/report evidence for the same source/time/scope. Do not invoke today's FindAvQty from a historical definition or count repeat serialization as independent semantics. |

Inbound cache/footer quantities0 were retained as counter-observations rather than substituted for the trusted37. One earlier stock-preview workflow coincided with creation of a zero movement; a later S2 preview had bounded unchanged comparisons. Therefore **report previews are not assumed side-effect-free today**, and are not the default evidence route for this experiment.

PR17 independently verifies pinned originals, exact cardinality/subset corroboration, complete repeated projections, package/scope/date/state, BigInt arithmetic for the qualified integer case and one-event dedup. Its offline import/readback evidence is retained; no import/build/Worker-WAL run was repeated now. Its hard-scoped inbound connector, purchase joins and historical observation1.1.0 are **not outbound support**. No contract/migration/implementation change is included in this plan.

## 3. Proposed single trial and roles — not authorized values/actions

| Parameter | Proposed scope, subject to fresh qualification |
| --- | --- |
| Purpose/family | Internal Consumption / Test Expense Issue, candidate official **أمر صرف عادي**; confirm exact current family/discriminator and Save effect before selection. Not sale, transfer, adjustment or new opening balance. |
| Source | Existing dedicated test installation `DESKTOP-8QRQT7R\\YSEDU`, proposed writable `EFA12026 / historical DB7`, company/year2026 context to be verified. Never write frozen Post-S2 DB10; no production target or new clone/backup/restore by default. |
| Item/scope | `DBL_P001_ITEM_A` / `DBL_ITEM_A`, branch1, warehouse1, UA, primary package1, proposed quantity **5 UA**, exactly one line. Verify identities/conversion/eligibility anew. |
| Business date | **UNFILLED — actual ERP document date must be explicitly approved.** Do not inherit08/10/26, backdate silently, change system clock, infer UTC, or assume document date equals Save time. |
| Operator | **Owner-designated human ERP operator** performs the single Save. Name/authorization must be recorded before execution; an old UI label Adm is not a new operator appointment. Codex is evidence reviewer/observer, not a Save agent under this plan. |
| Accounting counterpart/currency | Existing, independently approved appropriate debit destination and currency only; current eligibility/hierarchy/nature and automatic valuation must be confirmed by the competent Motakamel operator/accountant. No code/account is preselected. |

S3 left account/currency/Save prerequisites unresolved. Inventory/cash/transfer accounts are not interchangeable expense destinations. Proposed97070104 was not created/qualified; old P&L/classification11 observations and a credit default do not establish correct saved hierarchy/nature. **No account/main/child/currency creation/edit, reclassification or speculative setup** is included. If an appropriate existing account is unavailable, STOP for a separate accounting decision; do not start a general chart-discovery chain or change the trial into another document type.

Do not copy historical cost100 or draft valuation500. Show the future actual counterpart/currency/automatic valuation and ordinary stock/financial consequences to the owner for action-time consent. If these exceed the expressly accepted bounds or require independent posting/approval, STOP; one Save does not authorize additional financial actions or real physical stock consumption.

## 4. Access prerequisite — must be closed before any ERP Add

**Current state: NOT ESTABLISHED; experiment blocked.** The frozen Reader and its nine grants cannot be assumed to observe new transactions in original DB7. The previous metadata authorization did not allow admin fallback or permission changes. No live access is exercised in this plan.

Recommended future evidence producer: **authorized source custodian using an existing verified restricted read-only route to the original test source**, or a custodian-supplied bounded export/report route whose read behavior is already proven. The custodian and ERP operator may be separate people; evidence roles and identity/access must be explicit. This route is a proposal requiring the future preparation approval, not an assertion that it exists today.

Before transaction authority, complete and approve an `EVIDENCE_ACCESS_SPEC` containing:

1. Exact installation/build/company/year/database identity and source epoch; acquisition operator and existing restricted principal/approved export interface. Test-not-production and effective read-only access proven without grants/credential changes. Strict TLS/approved CA+hostname/direct observed port/no Browser/retries for any SQL path; no reuse of52952 without fresh ownership verification. Approved lab revocation UNKNOWN remains disclosed, not silently treated as success.
2. Actual family's header/line/inventory objects/types, columns/key/discriminator components, status meanings and source references. **Physical observability and provisional linkage must be known before Save; the trial then proves their actual event effect.** Do not demand a pre-existing qualified outbound event, or derive tables from eight guessed names.
3. Reviewed fixed, parameterized, SELECT-only bounded extraction texts/fields or exact documented export/report operations, proven not to invoke unverified UDF/SP/CLR/report writes. No free-form SQL, broad schema/business scan or default unrestricted database rights. If a view/function is part of the authority, its current behavior/dependencies must already be qualified under a separate exact scope; historical FindAvQty text is insufficient.
4. Same-source current available-stock authority, its meaning and full unit/package/branch/warehouse/date/batch/reservation scope; distinguish available/book from physical count/cache. Independent corroboration method and side-effect-free qualification. Prefer custodian extracts/already-produced authorized reports; do not regenerate the old stock preview merely to obtain a number.
5. Row/byte/time limits, expected automatic-effect surfaces, exclusion list and protected-row fingerprints; secure local output location, raw-byte hashing/close procedure and absence of secret logging. Retain the minimal source/access-check rowsets needed to audit the checks, not just PASS booleans; keep private identity material out of public receipts. Query/route hashes must be frozen before the trial, and both before/after capture must be possible **without changing access after Save**.

If that specification cannot be supplied and safely rehearsed read-only under a separate preparation approval, **do not create a draft or Save**. A report with no reliable full item/scope/date binding, clipped identity without corroboration, or unknown side effects is not an acceptable substitute. New rights, a different privileged account or new image are separate decisions, not defaults.

## 5. Gated procedure for a later owner-approved execution

Every step below is **proposed, NOT executed**. The present mission stops after documents/PR. Missing evidence at any gate is STOP, not permission to improvise.

| Gate | Exact future action / required evidence | Stop condition |
| --- | --- | --- |
| G0 — Preparation only | Owner appoints operator/custodian, qualifies `EVIDENCE_ACCESS_SPEC`, actual family/current workflow and existing account/currency; records completed source/scope/date/cost bounds. Read-only verification/dry capture only after separate preparation authority. | Any identity/access/observability/counterpart gap; source may be production; need for new permission/account/image. No ERP Add yet. |
| G1 — Source before | Establish a quiet controlled-use interval with no concurrent ERP Saves by others; no service stop/locks/isolation-option change. Capture current scoped stock `Q_before`, all relevant existing movement identities, matching document/line identities, selected masters/old S2 controls and acquisition times. | Missing stock authority, Q_before<5, uncertain precision/unit, unexplained drift or parallel activity. Do not replace Q_before with historical37. |
| G2 — One draft | Only after explicit execution approval, named human operator uses confirmed official family→Add, selects existing item/account/unit/package/branch/warehouse, enters5 in one line, records actual proposed date/identity and all required fields. No Save, setup, override, return/transfer/free lines or forced negative stock. | Mandatory field/counterpart unknown, unexpected auto action, date/cost outside approval, second line/alternate variant/extra posting required. |
| G3 — Immediate pre-Save | Re-read bounded source/stock using approved route; compare to G1, retain draft evidence and distinguish proposed from saved IDs. Owner reviews actual business date/account/currency/valuation and accepts one Save with ordinary documented automatic effects. | Source/evidence drift, unclear consequence, failed capture or absent action-time confirmation. No Save. |
| G4 — Single Save | Named human makes **one normal official Save invocation**, timestamped/logged. Capture result/message/view and actual saved header/line IDs if returned. No double-click, Ctrl+S retry, Edit/Resave or separate approve/post button. | Validation, timeout, ambiguous result, surprising side effect or failure. Save-call budget consumed even if validation fails; go to passive recovery, never retry. |
| G5 — Persisted state | Approved bounded after-capture, then documented non-edit official reload/view operation only if qualified side-effect-free. Record stable saved header/composite key, exact line, lifecycle flags and corresponding movement delta; compare protected before rows. | No persistence, missing/extra/ambiguous line/movement, cancellation/reversal/unknown state, changed old movement, unexpected protected change. No corrective write. |
| G6 — Reconciliation | Obtain current `Q_after` and independent same-event proof in the same quiet interval/source/scope. Reconcile exact quantity/direction and full relevant components; record discrepancies/caches as observations, not repairs. | Partial/hidden evidence, different time/image/UOM, unexplained difference/concurrent event, or report side effect. PARTIAL/STOP, not guessed success. |
| G7 — Preserve/decide | Close exports, hash original bytes, seal manifest/provenance and matrix; retain the real test transaction/evidence. Review offline. | Missing hash/source binding or qualification criterion. No product import, new FACT overwrite, merge or automatic reversal. |

Preparation approval and execution approval are distinct. Passing G0 does not authorize G2/G4. Passing this plan review does not establish G0 or authorize any SQL/UI step.

### Bounded read design to finalize at G0

- Proposed ceilings: each selected master lookup `TOP(2)` with exactly1 required; new header and selected line lookup `TOP(2)` with exactly1 each; selected-event effect rows `TOP(3)` to detect extras. One effective stock row is the small trial's target; if actual schema legitimately splits effects, STOP for an explicitly documented narrower mapping/budget decision **before Save**, not a silent first/distinct afterward.
- For current before/after history: selected ItemA/B1/W1 scope only, at most64 movements plus1 sentinel, at most16 matching document identities plus1 sentinel; exceeding a ceiling means STOP before draft, not truncation, auto-pagination or broadening. Use approved package/batch/date predicates and retain every relevant component, not just negative rows. Query texts/object names cannot be finalized until the physical schema/access gap is closed.
- Retain complete approved selected-record fields needed for lifecycle/joins/expected effects, not arbitrary all-company exports. Keep fixed query hashes/typed parameters, source times and capture ordering. No business reads occur now.
- Sequential live reads are not an atomic snapshot. Bracket the single known action with identity/stock/row-state checks, a short approved quiet interval, no unrelated Save and bounded readback. If drift cannot be excluded, report PARTIAL; do not change isolation/RCSI, lock production, stop services or silently take a backup.

## 6. Minimum evidence contract and independent reconciliation

| Checkpoint | Evidence that must be preserved in a new future evidence directory |
| --- | --- |
| Before/G1+G3 | Source/test/company/year identity, current access guards, acquisition start/end, exact item/name/branch/warehouse/UOM/package conversion/batch settings, Q_before definition/value, existing document/line/movement key sets and protected baselines. Actual current source values only. |
| During/G2+G4 | Official document family/version, operator, one entered5-UA line, actual date/account/currency/valuation, proposed-vs-saved identity distinction, action-time approval, one Save action/result/message and timestamps. No credential screenshots or unnecessary business data. |
| After/G5 | Original saved header and exact linked line, document/line keys/discriminators, saved/cancelled/void/reversal/review/stock-effective state, new linked movement IDs/fields, signed component contributions and date basis. Absent/NULL flags are UNKNOWN, not false; documented N/A needs evidence. |
| Independent/G6 | Qualified official saved-document reload plus a separately produced custodian stock/movement output or other prequalified independent channel. Match event/item/unit/package/B1/W1/source/time exactly. A second parse/hash/repeat SQL read is reliability checking, not independent ERP semantics. |
| Seal/G7 | Original byte exports, query/route versions/hashes and typed scope, UI/report filters/metadata, chronological stage ledger, full SHA256 manifest, selected non-sensitive findings and qualification matrix; keep raw business records/secrets out of GitHub. |

The hypothesis is **net inventory contribution = −5 UA** and, only if the qualified available-stock definition is compatible and all other scoped contributions are unchanged, **Q_after = Q_before − 5 UA**. Both sides must come from the same newly measured source interval. This is a future test expectation, not a current observation or a way to manufacture historical32. Do not infer direction from a negative journal amount, use `−abs(quantity)` as a decoder, or ignore free/subquantity/package components. Use exact source precision/decimal representations; no hidden float rounding/tolerance. If fractional precision is unqualified, STOP rather than claiming the historical integer proof covers it.

Define the logical event within this unchanged test-source epoch by the actual installation/company/year + family/document composite key + exact line identity. Before/after/reload/independent exports are observations of **that same event**, not new events because timestamps/file hashes differ. Keep export/image identities in provenance; do not use a new export hash to inflate event count. No cross-restore/global dedup guarantee is assumed.

Count the qualified net inventory contribution **once**. Header, line, automatically generated dispatch/receipt and finance entries corroborate it; never sum their represented quantities. Do not create a second dispatch to mirror the issue. Any auxiliary/multiple movement representation must be understood and reconciled under the approved mapping; duplicates/orphans/extra nonzero effects mean STOP, not DISTINCT/first-row selection. Preserve the old zero and inbound rows; do not relabel either as this outbound.

## 7. Qualification matrix — future evidence, not current PASS claims

| Claim | Required passing proof | Present planning state / failure response |
| --- | --- | --- |
| Correct test source and authorized access | Fresh exact test identity/company/year, existing restricted route and read-only extraction; no production ambiguity | Missing for proposed writable-source trial → block before Add |
| Valid single workflow and counterpart | Version-specific ordinary issue Save behavior; existing approved account/currency and explicit operator/date/valuation consent | Unresolved S3 prerequisites → no substitute account/creation |
| Current capacity | Qualified same-scope Q_before≥5, exact unit/package/precision and known meaning | NOT TESTED; historical37 not substituted |
| Genuine saved document | One approved Save, stable generated key and independent non-edit reload | Future only; validation/unknown persistence → STOP/no retry |
| Exact one line | Correct item/name,5 UA, B1/W1/package1 and actual stable line key/header relationship | Future only; extra/missing/ambiguous line → STOP |
| Inventory movement link | Actual family key/discriminator linkage and verified new stock effect; old rows protected | Schema/evidence access missing; sign or date proximity alone insufficient |
| Lifecycle/date | Saved/not cancelled/void/reversed state and proved stock effectiveness; raw business date and its basis recorded separately from acquisition | Meanings unqualified; financial posted=false/true not stock decoder |
| Exact net outbound and stock change | −5 decoded contribution once, all relevant components reconciled with Q_before/Q_after and no competing changes | Future hypothesis only; discrepancy → PARTIAL/STOP |
| Independent corroboration | Same-event source-custodian/report/workflow evidence from a prequalified independent channel | Method not established; no report regeneration by assumption |
| Cardinality/provenance | One logical business event, complete selected identity graph, original hashes, source/time scope and no truncated/duplicate/orphan data | Required future evidence; no qualified outbound now |

Only all required gates/evidence passing can support a **new controlled outbound qualification**. A saved document without stock proof remains PARTIAL; contradictory linkage/state is NOT QUALIFIED; inaccessible evidence remains BLOCKED. Historical live/function/admin failures are unchanged. No result in this matrix is an executed experiment.

## 8. Risks and recovery — no fictitious rollback

- **Before any Save:** if the authorized preparation/draft step is unambiguously unsaved, the human may use a separately approved normal Cancel and verify no persistence via the established read route. Never cancel/close blindly if the application might autosave or state is ambiguous.
- **Save validation/timeout/uncertain commit:** stop all input; capture non-sensitive message/current state; use only the already-approved passive evidence route to establish persisted/not-persisted/unknown. Do not repeat Save, try another account, kill/restart ERP/SQL or infer failure from timeout. Unknown stays unknown and goes to owner review.
- **Saved but incorrect/unsupported/stock not effective:** preserve the real document and all deltas; do not Edit/Delete, direct-SQL rollback, manually post/approve, reverse, restore a backup or create a compensating event. Correction/reversal/extra posting needs a new exact owner decision covering its own stock/financial effects. Do not force an effect merely to pass the experiment.
- **Successful trial:** the lab transaction and its ordinary approved automatic consequences remain recorded. There is no automatic cleanup/reversal or physical-consumption claim. Owner must accept that retained test-state change before execution; frozen DB10/original historical FACT/snapshots remain untouched.
- **Unexpected read/report/UI side effect, concurrent change or lost evidence:** stop before further actions; disclose the observed change, preserve originals, do not repair/delete a zero/cache row. Sampling is bounded, not a whole-database no-change guarantee.
- **Privacy/operational limits:** no password in commands/logs/Git/screenshots; no broad account/financial/customer exports; capacity/disk budgets and local output access checked before trial; no new service/network/TLS configuration. No comprehensive memory-erasure guarantee is implied.

## 9. Exact next owner decision and present deliverables

First approve a **bounded preparation/observability qualification**, with a named custodian/operator and concrete source/access/account/workflow inputs, or provide their already-qualified package. It must stop before ERP Add/Save and before any new grant/master/image. Only after that produces a complete G0 pack can the owner approve the one-draft/one-Save experiment with actual date/stock/valuation values. See [the approval checklist](CONTROLLED_OUTBOUND_EXPERIMENT_001_APPROVAL_GATE.md); do not ask for broad transaction authority while the evidence capture path is missing.

Present outputs: this plan, approval-gate document, embedded qualification matrix and file-only review receipt in a documentation-only Draft PR. The original local review receipt SHA256 is `A370E0B3CF084E07CF46F15EE350624249ABE6A22EB463B660727AEE140EEFE2`; the public copy preserves its exact bytes. Its11 source pins and two inspected product-blob hashes are individually recorded there; these are planning inputs, not11 new SQL exports.

Independent PowerShell file-only cross-check matched all11 pins, recomputed the one-before/two-after/one-new inbound movement relationship and historical BigInteger sum37, verified the distinct receipt line identity and preserved metadata blocker; no SQL/client/helper or SQLite ran. Local `outputs/host-controlled-outbound-experiment-001-plan-20261015/INDEPENDENT_CHECK.json` SHA256 `FAB26052EB9EA117DF796DA7D4D28BDB838330A7A54C4385D94063A50AC9AFBE` records that check. It is a second implementation over retained evidence, not a new acquisition, human review, current quantity or whole-database audit.

Another retained PR17 lesson applies to future evidence sealing: close/flush the export producer before final hashing; do not hash a main SQLite file while its authoritative changes remain in WAL and then label it a closed artifact. Original provisional receipts must be preserved with narrowly identified superseding close-time receipts, not rewritten. No SQLite evidence store, new migration or WAL exercise is proposed or run by this plan.

No SQL/ERP/native UI, credentials, backup/restore, source write, product/Canonical/SQLite/import implementation, release/deployment or merge was performed. Original files remain unchanged; prior tests/results are historical, not rerun product acceptance. Evidence-quality/validation stance: ready to review this **conditional plan with explicit prerequisites**, not ready to execute a transaction. The requested delivery is repository plan/approval documents and Draft PR, not an external analytical site. Status remains **PARTIAL / MISSING PREREQUISITES**. **STOP.**
