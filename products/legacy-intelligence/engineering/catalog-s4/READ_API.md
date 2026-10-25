# S4 read capability, durable references and pinned cursors

2026-10-25 · Synthetic profile/revision only, not a Desktop wire protocol or ERP connector.

## Public capability boundary

`openSyntheticCatalogReader(directory, {sourceId, epoch, companyId, scopeId})` is assembled in a trusted host. It checks the selected tuple against local enrollment, rather than trusting fields from a candidate/ref. Inject **this read port** into application-service, never the whole storage package or an owner/reviewer factory. Its methods are exactly `openCurrent`, `openHistorical`, `listAcceptedCaptures`, `openComparison`, `close`. The consumer-facing boundary is the projected application API/error envelope below; do not forward raw Node storage exceptions or the storage module to a renderer.

`openCurrent()` returns `{context,page}` for the accepted head at opening. `openHistorical(reference)` opens the selected admitted unit. Context carries the durable reference, synthetic profile/class, `erpQualified:false`, capture/acceptance times, count, `isCurrentAtOpen` and `authorityWarningAtOpen`. The names explicitly describe opening-time metadata, not a live promise that head or revocation status cannot later change. Current suspension/key expiry warns on authentic historical reads; unsupported registration/key rotation fails closed.

The durable `dbl.catalog.accepted-ref.1` contains exactly state ID, company/source/scope/epoch, admission/snapshot IDs, sequence, registration revision, mapping version and receipt hash. All fields are compared with the local admitted unit. Unknown fields, foreign state/company/scope/epoch, altered interpretation/digest/IDs and unadmitted candidates fail. A reference can be serialized and reopened by a fresh port. An exact reconstructed selector to a permitted admitted unit is legitimate; reference secrecy is not the authorization model. The host's source-bound capability is the domain boundary.

`listAcceptedCaptures({limit,cursor})` returns bounded contexts ordered by sequence, anchored at the initially selected head. Subsequent pages do not add a newer head that appeared during that listing. SQL loads metadata with LIMIT/OFFSET, not all signed receipts. Product `page({limit,cursor})` uses deterministic UTF-8/SQLite BINARY stable-key order, one immutable accepted snapshot and page sizes 1–100. Zero/oversized/coercive sizes and unknown request fields fail. Initial cursor is null; last `nextCursor` is null. Replaying a valid cursor in the same scope is repeatable.

## Cursor authentication/lifetime

Cursors authenticate canonical version/kind/view/limit/offset/references using HMAC-SHA256 with a fresh 32-byte key private to that reader instance. Body is base64url plus a 64-hex MAC, bounded to 8,192 characters; it contains allowed reference metadata, not paths/issuer material. This authenticates rather than encrypts the body. No cursor key is persisted or returned.

Altered/self-rebound cursors, another scope/port/kind/page size or a closed port fail. A product cursor cannot be used as a capture-list/difference cursor. Closing clears the in-memory key; new-process/new-port cursor reuse is deliberately unsupported. Reopen a saved historical reference and start with null cursor; never silently substitute current. SQLite opens and closes per short query-only transaction, with no write connection/handle exported. SQLite's ordinary internal sidecar behavior is not an OS privacy/permission qualification.

## Accepted comparisons

`openComparison(fromRef,toRef)` resolves both under the selected source/domain and requires chronological sequence order. It returns `{context:{from,to},page}` with both refs pinned. Incompatible interpretation/revision/domain and reverse order refuse; no cross-company comparison is recast as additions/removals. The synthetic policy currently permits one registration/mapping revision, so these tests establish refusal of incompatible references/domains, **not operational comparison across real mapping/key upgrades**.

Only stable key is identity. Relative to the selected pair: new key -> added; same key with changed SKU/name -> changed (changedFields lists only those fields); equal -> unchanged; key absent from later set -> notObserved. No quantity, price, money, delete/tombstone or lifecycle state exists. For an added key only, the port may attach the nearest accepted observation preceding the `from` snapshot, after verifying that stored unit. Reused SKU/name on a new key gets no such evidence. A before/after pair that both contains B is unchanged/changed, even if another intermediate capture once omitted it; no global lifecycle is invented.

The current C1 bound is 1,000 products/capture, so a union comparison is at most 2,000 keys. Stored row loading uses a 1,001-row sentinel and refuses overflow rather than truncating a source as complete. Long-history latency/reappearance workloads are not a production benchmark or S5 performance qualification.

## Application/consumer safety

`createCatalogReadApplication(readPort)` in application-service injects only the read interface; it adds no runtime storage dependency. Async results use `{ok:true,value}` or `{ok:false,error:{code,message}}`. Context/rows/diffs are projected field by field; extra owner/storage metadata is not forwarded. Native messages, path-bearing stack/cause and opaque thrown values do not escape the error envelope. Only a fixed set of read error codes is exposed.

Read-scope functions are host application capabilities, not an implemented Electron IPC transport. A future Desktop bridge must expose the selected DTO/read operations rather than import Node storage in a renderer. This does not establish multi-user OS authorization or defend against a malicious host deliberately injecting secrets into approved business fields. Actual product names/SKUs are intentionally data; real-source privacy qualification remains separate. Local audit-outbox export, UI and general key lifecycle are not supplied by S4.
