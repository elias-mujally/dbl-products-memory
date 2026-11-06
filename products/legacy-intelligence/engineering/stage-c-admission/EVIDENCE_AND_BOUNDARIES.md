# Evidence baseline and limits of the claim

2026-10-25 · [Proposal index](README.md).

## Refreshed repository identities

At this review, product main is `bccc89ecb077b11ec5476b82a222ed9c4a3487b9` (tree `f1988518b45b94ef303ae79eb0eabb761fd12aa6`); memory main is `86beaf03cceac4e39acc1d194a1577f41b749d70`. Product PR22 is open/draft at `ecba3c2129488fa98bf88355df560bd2f5becf8f`; memory PR15 is open/draft at `4091f0d231a30e47bea49d6cbb1905dba8831b11`. Neither is merged. The local tracked product source remains unchanged. Existing uncommitted work in both checkouts is preserved and excluded from this documentation-only submission.

## Source-code evidence

Links below pin product source at the reviewed main commit; they are evidence of implementation, not production qualification.

| Source | Existing behavior and implication |
| --- | --- |
| [Core model](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/core/src/model.ts) and [closed validator](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/core/src/validation.ts) | SourceRef has connectorId/sourceSystem/sourceVersion. Ordinary Product IDs and cardinality are general. No company/full-completion/epoch/source-sequence envelope exists. Unknown metadata cannot simply be appended |
| [Storage interface](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/core/src/storage.ts) | Latest/pinned reader, checkpoint listing, staged write and close exist. No public historical snapshot-by-ID reader or catalog-difference contract |
| [SQLite store](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/storage-sqlite/src/sqlite-store.ts) | Latest is selected by captured_at then imported_at and IDs. Initialization uses WAL/FULL and normally removes staging sessions. That general cleanup is not safe to assume compatible with a live admission writer |
| [Write session](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/storage-sqlite/src/sqlite-write-session.ts) | Final commit computes fingerprint under an immediate transaction, inserts snapshot rows, resolves identical replay and rejects conflicting content. It does not atomically store the proposed registration/evidence/sequence/head |
| [Importer](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/import-orchestrator/src/orchestrator.ts) and [audit sink](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/audit-sqlite/src/sqlite-audit-sink.ts) | Snapshot is saved before completion audit. Audit uses a separate database and ordinary INSERT; exactly-once outbox delivery is not currently implemented |
| [Migrations](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/storage-sqlite/src/migrations.ts) | Checks migration drift and future unknown versions. Existing v4 compatibility triggers are explicitly not authentication against the file owner; catalog admission must not be claimed from that mechanism |
| [Application read contract](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/bccc89ecb077b11ec5476b82a222ed9c4a3487b9/packages/application-service/src/types.ts) | Opens a pinned latest scope for connectorId. Desktop can reuse pinned semantics, but trusted source handles, admission context and historical/diff APIs are new design work |

## Stage B evidence, not a new execution claim

The [35-case suite](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/ecba3c2129488fa98bf88355df560bd2f5becf8f/packages/import-orchestrator/test/catalog-stage-b/full-catalog-capture.test.ts) and [reference model](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/ecba3c2129488fa98bf88355df560bd2f5becf8f/packages/import-orchestrator/test/catalog-stage-b/reference-contract.ts) establish A/B -> revised A/B/C, immutable history, replay/conflict and namespace behavior on synthetic data. They also deliberately establish partial/empty acceptance and company-misbinding gaps. Their reference witness is an independent fixture oracle, not a qualified ERP exporter attestation.

[Original Stage B result summary and hashes](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/ecba3c2129488fa98bf88355df560bd2f5becf8f/docs/contracts/CATALOG_STAGE_B_RESULTS.md): 35 new passes, zero failures; 153 focused passes including those 35; 38 skipped owner-evidence cases. Historical rows after reopen were inspected by read-only SQL on synthetic SQLite, not a newly implemented public history API. No tests are rerun or added in this design task.

## Threat model and falsifiable boundary

Protected: current and accepted history against malformed/tampered/replayed/wrong-company/unqualified/partial candidate files, ordinary importer bypass, accidental mapping mistakes, crashes, bounded write errors and concurrent legitimate callers.

Trusted roots: the authorized owner/service enrolling the correct company and source; intact local code/state; a pinned producer public key; an independently qualified producer method that reads the registered source consistently and signs truthful observation evidence. Files and renderer inputs are untrusted. The producer signing key is not embedded in the input bundle or held by the importer.

Not promised: defense against a malicious authorized administrator editing SQLite/registry/code, a stolen signer key, a trusted exporter that deliberately signs the wrong company's rows while falsely claiming the right identity, or storage hardware that violates durability guarantees. Those require independent controls/investigation. Local ACL/Defender/backup gates remain open; no policy changes are part of this proposal.

**Critical impossibility:** DBL cannot infer actual source completeness or company origin from an arbitrary payload plus internally consistent counts/digests, even if a signature authenticates that assertion. If two different real sources can produce the same claimed envelope, the importer has no independent fact that distinguishes them. The remedy is a qualified, authenticated observation rooted outside that file; otherwise refuse the trusted path. Tests can prove verifier behavior under these assumptions, not universal truth about unseen ERP databases.

## Official platform references consulted

- [SQLite atomic commit](https://www.sqlite.org/atomiccommit.html): transaction atomicity has storage/OS assumptions; process-kill tests are not physical power-loss certification.
- [SQLite WAL](https://www.sqlite.org/wal.html): atomicity is not guaranteed across multiple attached databases as a group; keep the acceptance transaction in one local database, not a network filesystem. Retaining a lone live DB file without its WAL is not a recovery procedure.
- [SQLite isolation](https://www.sqlite.org/isolation.html): one writer at a time and isolated readers support a short serialized admission transaction; application checks still have to run inside the transaction.
- [Node 22 crypto verification](https://nodejs.org/docs/latest-v22.x/api/crypto.html#cryptoverifyalgorithm-data-key-signature-callback): built-in detached signature verification is a candidate implementation route. This task did not test an algorithm or change Node. Consulted documentation may track a newer patch than the locally used runtime; compatibility must be tested on the approved target binary.
