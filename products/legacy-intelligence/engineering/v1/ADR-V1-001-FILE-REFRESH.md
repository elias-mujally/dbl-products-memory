# ADR-V1-001 — operator export, pinned files and persistent local import

Status: **IMPLEMENTED LOCALLY / PUBLICATION PENDING**. Date: 2026-10-22.

[Index](README.md) · [Semantics](DATA_SEMANTICS.md) · [Runbook](RUNBOOK.md) · [Measured results](RECURRING_STATUS.md)

## Context

An actual offline V1 import is proved. The old experiment runner required a fresh SQLite directory and fixed reference balances, so it was a verification harness rather than an operational refresh entry point. V1 is disconnected; Hyper-V/HNS queries previously hit access denial, guest command automation is unavailable under Computer Use's terminal rules, and an independent DB-enforced read-only live account is not qualified.

## Decision

Use the owner-run bounded SELECT-only acquisition and independently supplied SHA-256 as the source boundary. Preserve exact accepted bytes once in a private content-addressed archive. Run an explicitly invoked `@dbl/v1-file-import` application against a dedicated persistent DBL state directory.

Use ImportOrchestrator, existing atomic SQLite snapshot storage, persistent audit and Application Service without adding ERP write capability or changing the old host connector's pins. A separate local SQLite admission lock serializes processes and is released by the OS on exit. Reject unseen older/equal-time captures, retain known-replay idempotence, validate readback against retained source bytes, retain receipts and stop at retention limits. No reference balance is used as mapping or operational fallback.

This is an **operator-assisted repeated integration**, not a background daemon, automated file transfer or live SQL synchronization. A replay does not demonstrate a fresh extraction.

## Alternatives

| Route | Benefits | Current decision and prerequisite |
|---|---|---|
| Default Switch / direct guest SQL TCP | Potential automated reads | Deferred: changes guest connectivity and demands actual isolation, TLS/identity/read-only grants, credentials and network tests. NAT alone is not security isolation. No network/SQL setup is changed. |
| PowerShell Direct / host-driven guest export | Potential no-network automation | Deferred: Hyper-V authorization and guest authentication/permissions are not qualified for Codex. Do not retry denied access or extract credentials. |
| VMConnect GUI-only report export | Existing working desktop route | Useful human/ERP reference; not a proven repeatable structured-row export. Computer Use is not permitted to type terminal commands. |
| Reusing the old pinned host connector | Less apparent code | Rejected: source/version/profile/identity semantics differ; changing pins would weaken established source boundaries. |
| New empty DB per run with fixed balances | Preserves simple experiments | Kept as baseline verification only. Does not prove durable repeated imports or changing supported data. |
| Operator bounded files + durable DBL state | Proven data path, no network/admin changes, reproducible provenance | Selected now. Transfer remains manual; retained private artifacts and bounded state growth need operator ownership. |

## Consequences and separate approval gates

- Current-state import is a new snapshot per later acquisition, not event-by-event incremental sync. Known same-file replay creates no extra checkpoint; later identical business data remains a distinct timed observation, with five current products.
- Units/warehouses/documents/journal are qualification evidence; no broad Canonical migration is introduced. Semantics remain the narrow V1 stock-cycle profile.
- Keep Node22/locked build consistent. A migration fingerprint based on function.toString() differs under transformed test runtime versus compiled runtime; mixing them was observed to reject migration2. Do not disable drift checks or rewrite old metadata. A future stable fingerprint/compatibility migration needs a separate design and approval before touching existing data.
- Source clocks are operator evidence; unseen capture order/future-skew guards can block imports after clock drift. Do not silently adjust timestamps to pass.
- The collector uses existing owner SQL privileges and short SERIALIZABLE reads. It is SELECT-only by reviewed code, not DB-enforced least privilege. Before deployment beyond this lab, qualify a constrained identity and representative workload/locking behavior.
- Any network, privilege, scheduler/service installation, broad schema/storage migration, external publication or remote repository change requires the owner's separate approval. Local code, fixtures, tests, documentation and new private DBL state are within the current authorized scope.


## Subsequent operator-package decision — 23 October

The owner explicitly authorized ordinary code/test/documentation engineering, a new product PR and continued PR9 preparation, without merging either or making further ERP/infrastructure changes. [The operator package](OPERATOR_PACKAGE.md) implements the selected file route; guest/network/SQL alternatives remain deferred. A command surface plus offline HTML and Arabic guide was preferred to a new desktop application, service or installer. Independently pinned manifest verification and new-directory state restoration were selected to make recovery reproducible without overwriting a known success. Runtime/migration/source scope remains unchanged. Public source publication is authorized for this task; production deployment and additional ERP/security/network changes are not.

Recovery manifests use locale-independent ASCII path ordering for new output. Verification treats the independently pinned file list as an order-independent set after strict identity/path/uniqueness/hash validation, preserving valid prior manifest bytes. This was selected after two failing synthetic regressions and actual prior-revision restore acceptance, without changing source/Canonical/storage schema.
