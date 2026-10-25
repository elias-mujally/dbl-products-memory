# S3 verification matrix and qualification limits

2026-10-25 · **Synthetic API/storage evidence only.** Final counts, source hashes and report digests are pinned in [S3_MANIFEST.json](S3_MANIFEST.json).

**PASS_S3_SYNTHETIC_ATOMIC_ADMISSION_REPLAY_AND_RECOVERY**

| Final local selection | Passed | Failed | Skipped |
| --- | ---: | ---: | ---: |
| New S3 API/fault tests | 49 | 0 | 0 |
| S2 proof/registry | 97 | 0 | 0 |
| S1 schema/family/bootstrap | 53 | 0 | 1 |
| Other bounded regressions | 134 | 0 | 4 |
| **Total** | **333** | **0** | **5** |

## Local method

Existing Windows developer environment: Node 22.23.2, better-sqlite3 12.8.0, SQLite 3.51.3. Core/storage builds and typechecks use existing tools; no dependency or configuration is installed/changed. Every new Catalog test starts from a separate disposable directory, invented fixture/company and fresh in-memory Ed25519 issuer key. No original ERP, historical archive, Preview1 state/package or owner evidence is read.

The regression selection is `packages/storage-sqlite/test`, `packages/audit-sqlite/test`; V1 `bootstrap`, `operator`, `refresh`, `state-publication`; Motakamel `v1-acquisition`; import-orchestrator `orchestrator` and `integration`. These are the bounded synthetic suites already used in S1/S2. Actual-V1/historical/customer/private-evidence tests are not selected locally.

## Actual behavior covered by the S3 suite

| C1 family / requirement | Exercised behavior | Limit |
| --- | --- | --- |
| C01 / atomic unit | Accept A/B with proof, products, immutable admission/sequence, linked head, consumed request and mandatory accepted event | Synthetic source only |
| C02/C17, storage portion | Revised stable A + B/C, old stored rows unchanged; reopen and replay old receipt without head regression | Private test-state inspection is not the S4 historical reader |
| C03–C09 | Signed wrong company and self-rehashed partial payload refuse, previous accepted unit stays exact | S2 still supplies wider malformed/key/profile fixtures; no real extractor qualification |
| C14/C15 | Replace input file after preflight; only private copied bytes publish. Inject stored-row substitution before sealing; rollback | No arbitrary OS adversary claim |
| C16–C19 | Exact accepted replay; same capture/different statement and equal-sequence fork; unseen stale sequence/finish refuse | No whole-state restored-backup anti-rollback |
| C21–C24 | Expiry/key window, consumed/cancelled/superseded request, parent binding, source suspension/active registration changed between verification and final transaction | Operational key rotation is unsupported and fails closed |
| C25/C26 | Inject before/after snapshot, each of three product writes, local event, admission/automatic head, consumption and commit; reopen before retry | Test-only synchronous statement faults, no real disk exhaustion |
| C28 | Commit exception after successful commit and actual isolated child exit immediately after commit; same-identity retry resolves durable replay | No broad C27/S5 process-kill sweep |
| C29/C30, local portion | Accepted event persisted once in the same transaction; skipped event/consumption/corrupt event fails. Simulated optional caller/output failure after commit cannot undo acceptance | No actual HTML generator failure or external audit adapter tested |
| C33, sequential portion | Two companies with identical keys/SKUs/capture IDs stay in separate local namespaces | Multi-process variant belongs to S5 |
| C35/C36 | Enumerate public exports; internal imports and preverified-token/trusted-flag attempts fail. Actual populated Catalog refused by legacy store/audit/V1. Ordinary legacy namespace label is not trusted Catalog authority | Same-owner arbitrary raw SQL/code is outside API isolation |
| C38, admission/replay portion | Deliberately corrupt new fixture product or local event, restore trigger definition, reopen; trusted replay refuses without repair | Not S4 trusted read-port qualification |
| C12/C39 hold portion | Honest missing-key/nonempty-to-empty proof holds; initial authenticated empty and 1,000-row full set work | Exact owner missing-set review API is deferred with S4 |

Write faults leave only the previous accepted unit, or the complete new unit if commit already succeeded. Retained authenticated observations are explicitly excluded from accepted counts and cannot satisfy admission/event linkage. A conflicting producer statement suspends new admissions but does not modify accepted history; a fault writing its control/event unit rolls back both.

## Recorded errors and corrections

The first S3-only run: 37 passed, 1 failed (request assertion omitted SQL ordering). Add explicit `ORDER BY`; no production change. The next Catalog-wide run: 195 passed, 1 failed, 1 Windows skip; the new guard test used sync `toThrow` on asynchronous V1 inspection and was corrected to awaited rejection. A test wrapper's TypeScript overload mismatch was fixed in test typing. Original reports remain private; failed assertions are not erased or reclassified as passes.

An intermediate regression run passed 333 with five Windows skips but included two exploratory pre-commit process-exit probes. Those were removed from the final S3 suite rather than claiming C27/S5 qualification. The final suite adds transport retry and ordinary-namespace false-attribution checks. Refer to the manifest for the exact final selection and results; earlier counts describe earlier selections.

The five Windows skips are inherited and explicit: S1 native file-link alias, V1 POSIX state-file privacy, broad POSIX directory mode, redirected backup ancestor and dangling symlink checks. No elevation, ACL change or link-policy workaround is used. CI Windows/Ubuntu observations, when completed, are recorded separately from local counts.

## Still open

S4 public historical product pages/differences and missing-set owner review; S5 multi-process contention, full acceptance crash matrix and final public-bypass matrix; physical power loss, real disk/media faults, whole-state restore anti-rollback with independent anchor; real ERP identity/stable-key/consistent-complete-extraction and production key custody. Windows ACL/Defender/customer operator qualification is not supplied by these unit tests.

A locally trusted signer can falsely attest an unseen partial source. This cryptographic trust limit remains, regardless of successful synthetic admission. There is no ERP qualification, scheduler, network connection, stock/value calculation or commercial readiness claim. No S4/S5 implementation or merge is authorized by this result.
