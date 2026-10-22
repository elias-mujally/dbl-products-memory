# V1 — approved merges and third-test recovery gate

Date:2026-10-22. **BOTH ORIGINAL PRS MERGED / THIRD ERP TEST AUTHORIZED BUT NOT EXECUTED.**

[Index](README.md) · [Measured status](RECURRING_STATUS.md) · [Advisory dispositions](ADVISORY_REVIEW.md) · [Third-test plan](THIRD_CAPTURE_PLAN.md) · [Evidence metadata](EVIDENCE.json)

## Verified merges

| Repository | Result | Merge commit |
|---|---|---|
| Product | [PR19 merged](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/19) | [f79b3549e04eb8e091ed253eac1f5eb090c8ae5b](https://github.com/elias-mujally/dbl-legacy-intelligence/commit/f79b3549e04eb8e091ed253eac1f5eb090c8ae5b) |
| Engineering memory | [PR8 merged](https://github.com/elias-mujally/dbl-products-memory/pull/8) | [475f78cb5e30ce3fd679ae6d5c6e0970917f6d46](https://github.com/elias-mujally/dbl-products-memory/commit/475f78cb5e30ce3fd679ae6d5c6e0970917f6d46) |

**FACT:** immediately before merge, product head was f5471792a63c08039ebbbc4b96f40f94fd33325d, with successful Windows/Ubuntu CI217 and10 fail-on-first-error WAL cycles each. The only submitted review was advisory COMMENTED, with no changes-requested review. The memory PR had no submitted review or workflow run; no memory CI success is invented. Both were mergeable. The owner's explicit instruction authorized the merges after review.

**DECISION:** use merge commits, retaining the reviewed branch history and unchanged source contents; no squash, rebase or force update. Both PRs report merged/closed. Reading main independently returned the merge commits above. Each comparison from reviewed head to merge showed one additional commit and zero changed files.

Before merge, both remaining coupling threads received final dispositions and were resolved as reviewed. Coordinator fan-out was retained after isolating filesystem/bootstrap ownership; cohesive cross-table qualification stayed intact. This does not claim coupling has no maintenance cost. Reproduced interruption/contention bugs, platform permissions and bounded-fetch false positives retain their evidence and explanations in ADVISORY_REVIEW. No review was dismissed to suppress a blocking objection.

## Recovery gate — actual observations

**FACT:** standalone VMConnect exposed the intended guest. The first app enumeration timed out; one same-call retry succeeded. Screenshot, guest Explorer clicks, navigation and one ASCII path entry were observed. An Alt+Enter attempt unexpectedly displayed Open With; it was dismissed without choosing an application or changing associations. The context-menu Properties route worked. This does not newly qualify every ERP text field or identify the cause of the shortcut behavior.

The previously recorded post-fixture ERP backup remains present inside the guest; General Properties showed **25,612,288bytes**, matching the historical size. Exact file/window identifiers remain private. File presence and size do not establish backup-content integrity, restore success or a verified independent copy. No fresh ERP quantities or accounting balances were measured during this gate.

**FACT:** a separate complete DBL-state preservation copy matched27file hashes before verification. All three copied SQLite databases passed integrity/FK checks; two historical snapshots, seven retained invocations, five current products and1470SAR were confirmed from the retained state/receipts. Original state files were unchanged and no importer was invoked. This is DBL recovery evidence, not an ERP database recovery test. Earlier evidence artifacts and source pins are retained unchanged.

## Stop decision and next action

**BLOCKED_RECOVERY_GATE:** the owner authorized one additional consumption issue, conditional on reliable recovery. Available evidence still has no verified ERP backup integrity/restore result. Therefore no issue draft was created, no Save or ERP SQL write occurred, no third source was acquired/imported, and no29-unit/1450SAR result is claimed. Approval remains valid; the missing prerequisite is evidence, not transaction permission.

The owner was asked whether a newer independently retained, recovery-qualified backup exists. If none exists, qualify the ERP recovery route first: a current native backup, independent verified retention and a controlled recovery verification against a separate agreed target. Do not restore over the active fixture, create additional databases/VMs, change transfer/security settings or accept a weaker recovery premise silently. Scope any additional setup before execution. JSON evidence and a local checkpoint alone cannot close this gate.

After recovery qualifies, recheck actual ERP baseline and document uniqueness, execute the authorized one-unit issue through ERP, verify inventory/journal effects, then acquire/import the third real file and exercise same-file/historical replay plus reopened storage/audit. Expected29units/1450SAR remains a prediction until that sequence completes. Original ERP and historical labs are outside scope.

This follow-up records actual merge results and the stop decision; it is proposed through a new documentation PR because PR8 is already merged. Its publication does not claim that the ERP gate has closed or authorize merging a further PR automatically.
