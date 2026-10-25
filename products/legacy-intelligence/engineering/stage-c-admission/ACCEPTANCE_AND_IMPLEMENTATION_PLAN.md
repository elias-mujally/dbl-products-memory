# Stage C acceptance and implementation plan

2026-10-25 · [Proposal index](README.md) · **Proposed tests only. No Stage C tests or implementation have run.**

## Success boundary

Under an intact approved registry/state and a truthful qualified producer, no incomplete, unauthenticated, wrong-company, out-of-scope, stale or conflicting candidate may become an accepted current snapshot. A receiver cannot prove that a malicious trusted producer told the truth about an unseen ERP; qualification of that root of trust is mandatory and remains external to these tests.

For every refused/held candidate compare logical accepted-state invariants before/after: source head, last sequence, accepted capture/snapshot count, accepted content/fingerprints and request successful-consumption state. Diagnostic attempts/held records may grow. Reopen before checking again. Refusal is not a pass if a generic reader or write path can expose the candidate as trusted current.

## Proposed acceptance families

These are test designs, not executed assertions or promised case counts. Parameterization may produce multiple tests per family. All first-slice inputs are synthetic, using independently known full fixtures and ephemeral test signing keys; no real producer private key or ERP connection.

| ID | Scenario | Required observable result |
| --- | --- | --- |
| C01 | Correctly registered source, requested full A/B | One accepted capture with correct company, source proof, immutable snapshot, head/sequence and local event |
| C02 | Fresh A/B/C with A name/SKU changed | A keeps stable key; current has three; old A/B remains available after reopen |
| C03 | Genuine signature but observed company/source differs from selected registration | Refuse; correct signature alone cannot route company or update registry |
| C04 | Change company/scope/profile fields in signed receipt | Signature/binding failure; current unchanged |
| C05 | Unknown source or file proposes registration/namespace/public key | No auto-enrollment or trust anchoring from file; refuse |
| C06 | Registered source with wrong epoch, connector/mapping/proof-policy/build | Refuse; no implicit fallback or remapping |
| C07 | Missing/unknown key, invalid signature, key revoked/not valid for this producer | Refuse new admission; previous accepted history retained with accurate trust status |
| C08 | File supplies self-consistent count/hash/complete but no source evidence | Refuse before trusted publication |
| C09 | Remove C and recompute payload's own count/hash; leave authenticated full-source evidence | Refuse source-set/count/digest mismatch even though payload is self-consistent |
| C10 | Interrupted export, failed completion, missing/duplicate/out-of-order page | Refuse; first page never passes as full catalog |
| C11 | Duplicate source key, omitted/replaced row with same count, or key normalization collision | Refuse ambiguity/source-set mismatch; never silently merge |
| C12 | Ambiguous empty/truncated capture versus attested explicit empty full set | First refuses; second may pass proof but nonempty-to-empty remains held until separate change-magnitude review |
| C13 | Duplicate JSON keys, unknown fields/version, malformed UTF-8/surrogates, integer overflow/fraction, oversized/deep payload | Strict bounded rejection, no partial parse/import or silent coercion |
| C14 | Replace file or reparse target after verification | Verifier imports exactly the verified stable bytes or rejects; no path-based TOCTOU substitution |
| C15 | Substitute staged canonical row/name/key after preflight | Final in-transaction digest/count checks reject publication |
| C16 | Exact accepted replay after close/reopen | Same admission/checkpoint; no duplicate snapshot/head or request consumption |
| C17 | Replay older known accepted capture after newer capture | Old receipt acknowledged; current, sequence and newer history unchanged |
| C18 | Same accepted capture identity with changed receipt/content | Conflict; no new snapshot under a content-derived alternate identity |
| C19 | Equal source sequence with different capture, or unseen older sequence | Refuse/quarantine; no rollback or timestamp workaround |
| C20 | Epoch reset, incompatible scope or source-key reuse requested in file | Refuse; needs explicit registration/reconciliation outside import |
| C21 | Clock regression/equal time, future time, expired request or inconsistent capture interval | First profile holds/refuses; source time never rewritten to pass |
| C22 | Stale/wrong challenge, parent changed, request cancelled/consumed | Refuse fresh admission; exact accepted replay remains a separate read-only classification |
| C23 | Source/key/policy revision changed after verification but before commit | Transactional recheck prevents promotion under stale authority |
| C24 | Two authenticated producer statements fork one capture/sequence/request | Quarantine and suspend new source admission; preserve prior accepted unit |
| C25 | Failure at receive, validate, stage or pre-transaction boundary | No accepted candidate; truthful bounded error/attempt, with logging failure disclosed if disk is unwritable |
| C26 | Inject failure after each snapshot/admission/head/request/event write inside transaction | Rollback of complete acceptance unit; no orphan trusted rows or consumed-success request |
| C27 | Kill process immediately before/during commit; reopen | Exactly old accepted unit or complete new unit; no mixed publication; abandoned work is not promoted from a flag |
| C28 | Kill immediately after commit before acknowledgement; retry | Discover committed admission, return replay, head correct; no duplicate stock/product rows |
| C29 | Post-commit HTML/full receipt/external audit delivery failure | Accepted result with explicit delivery status; outbox remains recoverable; no canonical re-import needed |
| C30 | Retry event export, duplicate event ID/digest, and conflicting event content | Identical acknowledgement is idempotent; conflicting event fails; never claim current audit INSERT already supports this |
| C31 | Two child processes import same capture concurrently | One accepted unit; other replay or bounded retry resolving to it; no duplicate head/event |
| C32 | Different captures race on same request/expected parent | At most one admission; loser stale/conflict; it cannot overwrite head automatically |
| C33 | Two sources with same SKUs, stable keys and capture IDs, concurrently | Independent companies/heads/history; writer contention does not mix them |
| C34 | Reader opens during writer/recovery/second initialization | Pinned accepted old/new snapshot only; no active staging deletion or visibility |
| C35 | Call generic save/begin/append/commit/default latest; session predates registration change | Catalog mode refuses bypass at final boundary; no trusted path created by caller flags or alternate namespace |
| C36 | Catalog-mode state opened through V1/legacy tools or incompatible binary | Refuse before migration/cleanup/mutation; V1 and Preview1 states are not targets or upgraded |
| C37 | Catalog migration interruption/error, drift/future version, unsupported state kind | No silent fallback/downgrade; preserve failed fresh state for diagnosis; existing unrelated states unchanged |
| C38 | Accepted snapshot linkage/head/count/fingerprint corruption | Trusted read and further admission fail closed; no generic latest fallback |
| C39 | B absent with valid full proof | Hold for missing-set review in first profile; after authorized magnitude approval and all checks, B is notObserved, remains historical, and receives no zero/tombstone |
| C40 | B reappears, same SKU on new key, key rename versus SKU rename | Correct scoped stable-key comparisons; no automatic merge/rekey/deletion semantics |
| C41 | Reopen and read old accepted snapshot; compare two admitted captures | Original rows/context and explicit added/changed/unchanged/notObserved output; same pinned result through paging while head changes |
| C42 | Cross-company/epoch/scope historical reference, forged cursor or non-admitted snapshot | Refuse or explicit notComparable as appropriate; no unscoped ID/SKU join or raw SQL exposure |
| C43 | Synthetic profile/fixture or insufficient evidence presented as ERP-qualified | Refuse trust-class escalation; Desktop/read receipt must continue to say synthetic/unqualified |
| C44 | Restore an older whole-state backup | Cannot claim anti-rollback from the restored ledger alone; real-source mode remains recovery-required until separately current source reconciliation. Broader recovery acceptance is deferred |

Adversarial family C09 must use an independent expected full set from the producer-side fixture, not manufacture the “independent” witness by recounting the already truncated candidate. A test signing a lying manifest with an authorized key can illustrate the **limit**, not prove that the receiver discovered the real source truth. Do not turn an impossible detection claim into a green assertion.

## Smallest future implementation: C1 synthetic admission vertical slice

One new managed catalog state in the existing approved developer environment, one synthetic producer profile with two registered synthetic companies, no VM/network/ERP, no new dependency or scheduler. Every output retains `synthetic` trust class. Manual invocation processes qualified fixture payload/receipt pairs, not a supported vendor export. Initial limits bound safety; no performance/5,000-product claim.

1. **C1a — freeze contract and migration design.** Approve exact receipt/canonical encoding vectors, registration/key policy, requests/sequence/holds, metadata constraints/state-kind compatibility and error taxonomy. Implement strict verifier and source-registration module only after the later approval. Keep test keys ephemeral/private and separate from input data; no shipped private keys.
2. **C1b — durable gate.** Add opt-in catalog migration in a fresh state, trusted write/read mode dispatch, transaction-bound canonical finalize plus admission/head/request/event, retry and safe recovery. Test public/generic bypasses explicitly. No universal auto-upgrade of legacy state.
3. **C1c — read proof.** Add pinned accepted snapshot-by-ID/current reads and bounded same-source field-diff output. Run A/B -> revised A/B/C, absent/reappearing B, exact/old replay/conflict and two companies sharing codes through these public APIs rather than private SQL as the acceptance oracle.
4. **C1d — failure qualification.** Run invalid/incomplete/wrong-company vectors, write-failure injection, child-process crash/reopen, competing writers/readers, registry races, compatibility and authoritative audit/outbox recovery. Preserve original failure reports and distinguish reruns. Run relevant existing tests, V1 guard regressions and typechecks without owner evidence or Preview1 inputs.

C1 should cover C01–C43 using synthetic parameterized tests, except any external audit delivery adapter not yet implemented must remain explicitly blocked rather than counted as passed; the durable local event/outbox is mandatory. C44 is a declared later whole-state-recovery gate, not a C1 pass. If C1 cannot implement safe startup/generic-path refusal or atomic metadata with the existing APIs, that is a necessary engine/storage change to review, not permission to weaken the acceptance test. The later implementation authorization must cover that change.

**C1 acceptance deliverable:** a reviewable product PR with code/migration/API changes and reproducible synthetic tests, a machine-readable acceptance report separating cases run/skipped/blocked, exact build/source hashes, old/new current/history receipts and fault outcomes, and updated engineering memory. No real-source or production readiness claim. Do not publish synthetic SQLite/ephemeral keys or private local receipts by default.

## Later stages, deliberately separate

- **C2 — real source qualification:** owner-authorized vendor/version discovery; actual source/company identification, full-export consistency, key stability/reuse, read-only permission proof, qualified producer build/key custody, clock and operational limits. No source registration can be labelled ERP-qualified before this passes.
- **C3 — assisted manual product integration:** real qualified exports under separately approved handling/privacy/retention; reconcile with source references. Connect Windows Desktop to accepted-source/pinned history/diff capabilities, not fixture namespaces. Human/operator, supported Windows, ACL/Defender and encrypted off-host recovery gates remain independent.
- **C4 — automation:** only after accepted manual path and operational recovery are qualified, assess a timer/feed. No assumption of CDC/API, network access or source DB technology. Triggers must reuse the same admission gate.

## Decisions needing later approval

1. Explicit implementation authorization for source registration/receipt protocol, key-verifier integration, catalog-state migration/version routing, storage admission/write restrictions, durable head/event/outbox, public historical/diff APIs and the synthetic test suite.
2. Any dependency beyond the installed runtime, real signing-key provisioning, producer deployment, existing-state upgrade, permission/network change, real data access or release remains separately authorized; none is implied by this design approval.
3. This documentation PR, PR22 and PR15 may be reviewed independently. No automatic merge and no implementation starts when the proposal is published.

No runtime test or migration was executed in this task. Editorial verification is limited to source-reference review, relative links, document hashes, publication allowlist and unchanged product source; it does not close any Stage C gate.
