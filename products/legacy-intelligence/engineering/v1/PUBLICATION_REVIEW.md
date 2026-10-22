# V1 publication review and subsequent approvals

Status: **OWNER AUTHORIZED BRANCH/PR PUBLICATION; PREPARATION COMPLETE; MERGE NOT AUTHORIZED**. Date:2026-10-22.

[Index](README.md) · [Measured status](RECURRING_STATUS.md) · [Evidence](EVIDENCE.json) · [Third-capture proposal](THIRD_CAPTURE_PLAN.md)

The owner explicitly authorized reviewing/fixing the local product and memory work, publishing one branch/PR per repository, and updating engineering memory. Earlier publication-pending notes describe the state before this approval. No main merge, release, live SQL, network/permissions change or ERP transaction is authorized by this publication approval.

## Engineering self-review and fixes

The reviewed V1 source path is file-only and bounded; original connector pins/storage migrations remain unchanged. Exact source bytes, receipt/return/journal relationships, constant-cost valuation, persistent latest/readback, audit and replay controls were inspected. Two actual owner artifacts remain the source proof. Historical original-source STOP gates remain scoped to those sources; they are not reopened by V1 success.

Review fixed a test timestamp tied to the first extraction, changed child-output tests to wait for closed stdio, and made the migration-fingerprint diagnostic measure differences without requiring the known defect to persist. A new optional external-artifact test reproduces the first/later import plus both replays through compiled processes. Narrow Git ignore rules protect raw acquisitions and database/recovery files. No runtime mapping/storage code or ERP data was changed during review.

Fresh local Windows/Node22.23.2 build/typecheck passed, **397 tests passed/38 skipped**, including18 application tests and the two actual files. The connector suite separately passed28tests against the second artifact. Absent historical evidence and live SQL remain explicit skips; CI without private owner files will skip additional actual-source tests. The first review run's new typed-test nullable lookup failed compilation, was corrected, and its failed log is retained separately from final success. This is an engineering self-review, not a claimed independent human or security review.

The migration diagnostic again measured version2 representation drift. Its protection was not weakened and compatibility across arbitrary builds/runtimes remains unqualified. Publication content inspection found no raw source JSON, SQLite/SQL backup, VM disk, binary or common secret pattern in the reviewed changes; this scoped check is not proof against every possible secret. Memory contains only sanitized lab facts, metadata, locators/hashes and decisions. See the product's `docs/V1_PUBLICATION_REVIEW.md` for the complete review scope.

Product [PR19](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/19) is open for review. [CI run215](https://github.com/elias-mujally/dbl-legacy-intelligence/actions/runs/39824166424) completed successfully on Windows and Ubuntu: locked installation, build, typecheck, tests and10 Worker/native-WAL cycles on each platform. The critical-threshold dependency audit also passed on Ubuntu; this is not a claim of zero lower-severity vulnerabilities. CI has no private owner artifacts, so its synthetic/control coverage does not replace local actual-source proof. No merge occurred.

## Publication method and history

Native Git transport lacked usable credentials; the existing connected GitHub tool has repository content/PR access. Product publication preserves the reviewed commit sequence with exact local/published tree-ID verification. Public memory uses one consolidated sanitized commit rooted at the unchanged main, so earlier private drafts are not ancestors of its published branch. Preserve remote main ancestry and private local originals/tags/bundles. Do not change credentials, use force updates, overwrite another branch or merge. Record final PR links and reviewed tree correspondence after creation.

## Third-capture decision

The preferred next functional slice is **one additional consumption issue of DBL-T01 quantity1**, existing branch/warehouse1 and expense counterpart301, at constant20SAR. Expected T01=29 and inventory1450SAR; all other items unchanged. This uses an already exercised route without new accounting setup or sales semantics. These remain predictions. [The approval-scoped plan](THIRD_CAPTURE_PLAN.md) defines recovery/evidence checks, a single Save, later same-state import, replay and historical-replay validation. No third ERP change or extraction has been executed.

## Public-memory redaction decision

Automatic approval review rejected an initial memory tree because it included internal endpoint identifiers, private filesystem locators and operational metadata. This was not treated as authorization to retry the rejected payload. Before creating a memory branch/PR, public documents were sanitized: private endpoint/VM/database selectors and process IDs were removed, and public evidence records retain only IDs, SHA-256, byte counts and safe descriptions. Exact evidence locators remain in a separate private owner register. Historical main documents are unchanged; only root indexes and the new sanitized collection are proposed. Initial draft objects are not referenced by the published branch. No raw ERP/SQLite files were ever included. This redaction and a consolidated memory commit replace the earlier multi-commit publication plan; source history is not rewritten.
