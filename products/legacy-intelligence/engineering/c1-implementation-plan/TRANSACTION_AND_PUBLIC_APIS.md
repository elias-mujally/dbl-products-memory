# C1 transaction, source proof and public API boundaries

2026-10-25 · [Index](README.md) · **Proposed algorithms and contracts only, not implemented interfaces.**

## 1. API surface and bypass refusal

The safe `@dbl/storage-sqlite/catalog` export exposes an explicit new-state factory, an owner-side registration/request/review port, admission by source handle + payload/receipt paths, and a separate read port. It never exposes Database, SQL, LocalStore, beginSnapshotWrite, appendBatch, saveSnapshot, raw verified-facts/token input or a caller-provided trusted flag. Generic ImportOrchestrator is not the Catalog coordinator. Its current behavior stays in the legacy path.

The enrollment port is assembled only for the trusted owner host/test harness, not exposed to a renderer/file import. Input files cannot call enrollment, enable a registration, set key/namespace or choose a different source handle. An arbitrary same-owner program editing DB files/code or invoking privileged owner provisioning is outside the untrusted-file/API assurance; type branding alone is not an authentication system. No Windows role/ACL change is implied.

Every new-service call resolves the selected local source handle to immutable company/scope/epoch/namespace, registration and current control. An admission payload may contain the matching expected fields as signed evidence, but they cannot override the selected binding. C1 schema accepts only the synthetic profile and trust class; passing `ERP-qualified` cannot enable a backdoor.

The ordinary SQLite store, audit sink and V1 target operations get **read-only family refusal before writable open/creation, PRAGMA mode changes, migrations, control initialization or cleanup**. The pure core discriminator consumes header/marker metadata; Node adapters read it without mutation. Recognize both the Catalog directory marker and the SQLite application_id, including a catalog DB copied without its sidecar. The DB contains no ordinary snapshots/items tables and has a documented future-lineage fence against the reviewed older generic store. Failed/contradictory bootstrap remains foreign/incomplete, not adopted as legacy. Tests cover each supported public writer/read entry point, direct low-level legacy store methods and wrong-root backup/restore calls.

No promise is made that every unmodified historical binary refuses even incidental extra audit tables; C1 must demonstrate refusal in the new supported API surface and fail-closed older generic-store compatibility. Arbitrary raw SQLite access by the file owner is not prevented by a facade or compatibility marker. If the owner requires stronger cross-process access isolation, that is a separately approved OS security/deployment requirement; do not disguise it as an API feature.

An ordinary importer may still save an ordinary snapshot with the same connectorId string in a separate legacy DB. That is existing unqualified behavior, not trusted Catalog acceptance. Catalog readers must reject that state kind and require actual admissions; never infer trust from the namespace string or redirect a failed Catalog open to the legacy reader. C35 must test this false-attribution route explicitly.

## 2. Source registration and signed evidence

Source/epoch/company/scope is immutable; registration revision records expected source-origin bytes, connector/build/mapping/proof policy, issuer key and validity. Owner control selects an active revision and status. Enrollment, activation, key rotation, cancellation and missing-set review are explicit owner operations with local events, not attributes imported from a candidate. Each control change increments a CAS revision.

Tests create ephemeral Ed25519 keypairs in a separate fixture issuer. Only SPKI public key and fingerprint are registered. Private keys remain test memory, never copied into payload, DB, package or GitHub. The producer oracle starts from an independent complete fixture, records source count/key-set/product-set digest, and signs a receipt for a durable 32-byte challenge/request. It must not produce the “independent” evidence by counting the already truncated receiver file. No signing/dependency/tool setup is performed in this planning task.

Proposed fixed receipt grammar `dbl.catalog.capture-proof.1` binds: source/company/scope/epoch/registration revision; expected source-origin digest; synthetic profile, producer build, connector/mapping/proof-policy version; key ID; request/challenge/parent; capture ID and exact positive sequence; start/finish times; consistent-observation method, full source row count/key-set/product-set digests, completion/page/end marker; payload byte length and SHA-256. Signature covers the exact canonical receipt bytes. Detached signature is exactly 64 bytes; a public key supplied beside it is never trusted automatically.

Before S2 code, freeze byte-level vectors for strict UTF-8, field order, numeric representation, string escaping and stable-key sorting. Decode fatally, reject unpaired surrogates/unknown fields, then canonical re-encode and require byte identity; this also rejects duplicate keys/coercive alternate spellings rather than silently accepting JSON.parse's last value. Product ordering is lexicographic UTF-8 bytes matching SQLite BINARY, **not localeCompare or default UTF-16 sort**. Header/receipt and product-set hashing have separately named domains. SHA-256 strings must be lowercase 64-hex, not just length 64.

Initial bounds: 1 MiB payload, 64 KiB receipt, 1,000 products, depth 8, 256 Unicode scalars for key/SKU and 1,024 for name. Exceeding any bound rejects the whole source; no pagination/filter/truncation fallback. Products carry only stable sourceKey, SKU and name. Unknown quantity, cost, currency or warehouse is not synthesized as zero/default. Existing V1 envelope is not accepted or adapted here.

Wrong source/company/scope/key/method/completion/digest/count fails even if the payload is internally consistent. An attested source with >1,000 rows is unsupported by this bounded profile, not “full” after trimming. Conversely, a genuinely qualified empty set is distinguishable from an ambiguous empty file; nonempty-to-empty and any missing key require an exact owner review in C1. That review binds request, registration, receipt hash, payload hash, missing-key digest and expected parent; it never waives source proof.

A lying/compromised registered issuer that signs false but internally consistent source evidence is not detectable from those bytes alone. Test this as a trust limit, not a miraculous verifier capability. Real-source completeness still requires separately qualified extraction semantics and actual origin verification.

## 3. One acceptance transaction, in concrete order

No permanent staging table is used for the bounded C1 payload. The verifier reads from a stable bounded handle into private memory, validates and copies rows; it does not return a public reusable verified token. During the final transaction no external filesystem, network, owner prompt or await is allowed. This keeps writer time bounded and avoids the legacy staging cleanup/recovery path entirely.

1. Resolve source; obtain authoritative control/request and immutable registration. Parse/verify exact statement bytes, signature, origin/profile/request binding first. After those authentication checks only, retain an immutable capture.observed event in a short transaction which rechecks that authority/request and compares previously authenticated capture/sequence statements. Exact observed replay is idempotent; a fork suspends admission and records conflict. This event holds the signed statement but is **not acceptance** and cannot move head. Unknown/forged file labels cannot poison this ledger. Then verify full-source evidence, count/key/digest and canonical products; classify hold/reject before taking the acceptance write lock. A crash with only an observed event leaves the old accepted unit intact.
2. Enter one synchronous `BEGIN IMMEDIATE` using the Catalog connection only. Reread control status/revision/registration/key, source proof policy and request. Do not use a second connection or call legacy commit.
3. Look up accepted `(source, epoch, capture ID)` **before** demanding a fresh pending request. The preflight must also perform this accepted lookup before attempting a new observed-event write, so a consumed/expired request does not block an exact accepted replay. If exact signed statement/payload identity already accepted, return its stored admission without writes to head; include current revocation/trust warning if appropriate. Different content for that identity is conflict. A report path or import-attempt ID is not capture identity.
4. For new capture, require pending request/challenge/registration, NULL-safe expected parent equal to current head, sequence > committed head sequence, valid time/window, completed full proof and valid exact missing-set review if needed. Suspended/revoked/forked/stale identities cannot advance. Proof facts from preflight are only reused if authority and exact bytes are unchanged.
5. Derive deterministic admission/snapshot/acceptance-event IDs from a domain-separated, unambiguous encoding of the source/epoch/capture identity. Do not derive snapshot ID from content hash, which would hide a same-ID/different-content conflict.
6. Insert catalog_snapshots and all catalog_products by prepared statements. Their deferred snapshot->admission linkage keeps them uncommitted until the complete unit exists. Re-read inserted products in BINARY key order, recompute count/key-set/product-set digest and compare to authenticated source evidence. No direct SQL fabrication is used for normal import; fault tests may deliberately corrupt their disposable fixture to challenge refusal.
7. Insert the mandatory capture.accepted catalog_event with canonical event digest and deterministic ID. Insert catalog_admission with signed receipt/signature, proof/registration, count/digests and snapshot/event links. Admission's trigger checks stored prerequisites and automatically advances head; its deferred constraints still require the same request to be consumed by this admission.
8. Change only that pending request to consumed with the new admission ID, requiring exactly one affected row. Check event/head/request/admission linkage, counts and applicable foreign keys. COMMIT must succeed, including deferred constraints, before returning accepted. Any failed statement/constraint/count affects rollback of the entire unit.
9. Outside the transaction, generate optional operator output from the accepted receipt. Report failure is `accepted-output-pending`, not “import failed, retry a new capture ID”. There is no separate acceptance commit in audit.sqlite/control.sqlite or a filesystem current pointer.

Head sequence comes from its immutable admission, not a mutable duplicate field or captured_at ordering. Known older accepted replay is acknowledged without promotion; unseen stale/equal-sequence candidates refuse. Two different captures for one request/parent cannot both commit. A conflicting authenticated producer statement records a bounded conflict event and suspends new admissions in a separate owner-control transaction after rolling back the attempted acceptance; it cannot edit the prior accepted unit. Unauthenticated files cannot reserve a sequence or suspend a source merely by inventing an ID.

Every acceptance event is already durable in the DB. C1 exposes read-only event enumeration as the future outbox source. Do **not** add external audit delivery now: current SqliteAuditSink INSERT is not idempotent. An eventual delivery adapter must add identical-ID/digest acknowledgement versus conflict handling and its own delivery ledger; that is a separately reviewable follow-on, never authority for current.

## 4. Reopen and recovery

| Interruption | Reopen behavior | Retry behavior |
| --- | --- | --- |
| Bootstrap marker created, DB schema not committed | Incomplete new state blocked, preserved; no legacy adoption | Fix implementation; explicitly create a different fresh synthetic state, no automatic cleanup |
| Before BEGIN IMMEDIATE | Accepted DB unchanged; no staging lease to recover | Re-read and re-verify candidate |
| During row/event/admission/head/request writes | SQLite yields old state or complete new state after recovery; application validates the linked unit | Stable capture lookup classifies it; never promote from an in-memory flag |
| COMMIT returned error or response was lost | Close/reopen and inspect exact accepted identity/digests/linkage; report uncertain if DB cannot be inspected | Exact accepted => replay; absent => fresh validation under same capture ID; conflicting/integrity error => stop |
| After commit but before HTML/output | Accepted state/current/event remain correct | Re-generate output from stored admission, not a second import |
| Concurrent open/writer | Readers never run migrations or cleanup; writers use SQLite transaction serialization/bounded busy retry | Reread source/head/request after obtaining lock; no stale lock-file deletion |

No external PID lease, multi-commit staging cleanup or stale-session takeover is required for this bounded design. A process does not own acceptance merely because it parsed a file. Preserve live WAL/SHM on error and use the existing approved SQLite backup/closed-state procedure when a backup is later authorized; copying a live main DB alone is not recovery. Disk full/I/O simulation uses isolated test doubles or new test state only, not exhausting the user's disk. Process-kill qualification is not physical power-loss qualification.

## 5. Historical read and product-difference port

Proposed explicit operations (names can be frozen in S2; none exist yet):

| Operation | Contract |
| --- | --- |
| `listCatalogSources` | Owner-visible locally registered descriptors, actual trust class/status; never data from a file label |
| `listAcceptedCaptures(sourceHandle, cursor)` | Source/epoch-specific admitted IDs, sequences, times and current flag, bounded pages |
| `openAcceptedScope(sourceHandle, current-or-snapshotRef)` | Resolve head or specific admitted ref under one consistent read transaction; pin source/epoch/snapshot for all pages; unknown/non-admitted ref refuses |
| `readProducts(scope, cursor)` | DTOs stableKey/SKU/name in deterministic key order, with admission context; no stock/value claims |
| `compareAccepted(scopeA, scopeB, cursor)` | Same source/epoch/scope and compatible mapping only; added/changed/unchanged/notObserved plus old/new values and changed fields |
| `listAcceptanceEvents(sourceHandle, cursor)` | Read-only authoritative local events; no promise of completed external audit delivery |

The scope carries company/source/epoch/registration/profile, admission/snapshot ID, sequence and times, synthetic trust class, decision-at-acceptance, current source revocation status and output/delivery limitations. Read path checks count/digest and snapshot/admission/event/request linkage on the bounded data before emitting a trusted scope. Corrupt state is `recovery-required`; no generic latest fallback.

Public snapshot-by-ID is required, so S4 verification no longer relies on private SQL for history. Scope/cursor binds source, both snapshot IDs for a diff, filters/order/page position and schema version; cross-company, wrong epoch or mismatched mapping is rejected/notComparable, not presented as additions/removals. Current changes cannot switch an existing scope's snapshot. Closing the process loses a cursor if its session binding cannot be revalidated; a new explicit historical open remains available from persisted admitted refs.

SKU rename/name edit with stable key is changed, not a new identity. Missing B is notObserved relative to the specified snapshots; no tombstone, carry-forward or zero quantity. Reappearance can be shown as added relative to the previous set plus explicit earlier-history presence; C1 does not invent a persistent deleted/active lifecycle. Same SKU on a new stable key stays distinct. Source key reuse/rekey is not inferred from names.

The read implementation can adapt pinned rows to the existing core SnapshotReader internally (customers/sales empty, inventory capability false) without returning a write-capable LocalStore. The catalog application facade takes a read port; the renderer never receives Database, file paths, source connection details, signing material or owner enrollment/write capabilities. This is source attribution isolation, not a new multi-user Windows authorization system. Desktop integration and inventory/value analytics are outside C1.
