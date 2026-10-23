# V1 publication receipt — review branches, not main

Date:2026-10-22. **Historical publication receipt; PR19/PR8 subsequently merged with owner approval.** See [the subsequent merge/recovery record](MERGE_AND_RECOVERY_GATE.md) for verified main commits and the unexecuted third test. The chronology below retains its original pre-merge evidence.

[Index](README.md) · [Review decisions](PUBLICATION_REVIEW.md) · [Evidence registry](EVIDENCE.json) · [Unexecuted third-capture proposal](THIRD_CAPTURE_PLAN.md)

| Repository | Review artifact | State |
|---|---|---|
| DBL Legacy Intelligence | [PR19](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/19) | Open for review; no merge |
| DBL Product Memory | [PR8](https://github.com/elias-mujally/dbl-products-memory/pull/8) | Open for review; sanitized public documentation; no merge |

Initial publication reviewed head was `a3a023627345c7cc26d761ef79dc11a10095d14c`; the latest advisory-review head is recorded below. Main base remains `415ad8acef5f5754487b83408bad6c9b9c58028e`. The initial four published commits preserve reviewed file trees and original local commit lineage:

| Original local checkpoint | Published equivalent | Identical Git tree |
|---|---|---|
| e82e5d003f7c546f170698ef2a107773d0837488 | 391692f8b0f882b213e8b13f6afa95a3c8b8a4b4 | 8da3aedbf221f32067253a2a8c94a0915547309b |
| 471d104f8e5965229bf420f259fb7d47a94d391c | 0f046aae6944bfa9bad9a0cd6b8f3a2cad655836 | d48eec3a79507a2e18bd68164f622a65d2fa8d23 |
| 2b3d25d2994a844d420f1e74286eb39b9015ff75 | ca77bd8bd8de0e850a8aebd3a2ba3be8d979424f | fdf3041c282f0ca75b3f4b9ba923e169c6eeb3fa |
| 1a9d2ddbad77cec881c79be3941efe10da40c8e9 | a3a023627345c7cc26d761ef79dc11a10095d14c | 4b43e7b612bdb6ce8447a203b1fe9f91b4cec980 |

The initial sanitized memory content commit is `1fb6f78efea1d11b5eeda424b6568179176bdcea`, parented directly to existing main `d02593c6faff785b1f500a5a887d8e331083abb1`, with reviewed tree `acfde45f8c00f54c080cd53db3576d84edccf088`. Subsequent publication-status documentation advances only that review branch. Earlier private local drafts and unreferenced preparation objects are not ancestors of the published branch. This preserves existing main history and avoids publishing sensitive intermediate versions. No force update is used. Local originals remain retained privately.

## Executed checks

- Fresh local Windows/Node22.23.2 build/typecheck and397passed/38skipped tests, with the two actual owner artifacts included. Second-source connector tests28passed. These are local actual-source/control checks, not new ERP captures.
- Product [CI run215](https://github.com/elias-mujally/dbl-legacy-intelligence/actions/runs/39824166424) succeeded on Windows and Ubuntu. Both completed locked dependency installation, build, typecheck, tests and10 Worker/native-WAL cycles. The critical-threshold audit passed on Ubuntu; lower-severity vulnerability absence is not implied. CI does not receive the private owner artifacts and skips their gated tests.
- Public memory's initial sanitized seal checked37evidence hashes and38relative V1 links. The publication receipt adds navigation links; validation is repeated before its branch update. Exact private evidence locators are retained in an owner-held nonpublished register keyed by evidence ID/hash. Endpoint/VM/database selectors, process IDs, raw exports and database/recovery files are excluded from new public memory.

## Advisory-review follow-up — latest product head

| Original local checkpoint | Published equivalent | Identical Git tree |
|---|---|---|
| 3b29431a39d3257279909b7cdf21405662b33c22 | db709081e15039507d50c4320a98f7b44b7cffd9 | 05ee9218edc1a7b53e69816aaf8b5ec9aabba010 |
| e81cbb3da19ee66ded798c2dabf18376d620f1df | f5471792a63c08039ebbbc4b96f40f94fd33325d | a1c5fe0d0011c95f944ffd80b5a18aa0a80099f8 |

The first follow-up reproduces and corrects interrupted bootstrap/publication and cold-start faults. The second corrects a competing test-worker lifetime exposed by failed CI216 and serializes app test files while preserving explicit process/thread concurrency. Both advance the existing branch without force or main changes. [Detailed advisory dispositions](ADVISORY_REVIEW.md) distinguish real faults, constrained platform privacy and metric-only warnings.

Final local verification: build/typecheck,413passed/41skipped with both retained actual source artifacts. [CI217](https://github.com/elias-mujally/dbl-legacy-intelligence/actions/runs/39843313410) passed Windows and Ubuntu, including10 Worker/native-WAL cycles each. Ubuntu also exercised the new POSIX controls and critical-threshold dependency audit. Private actual artifacts are absent from CI. CI216 and the failed local timeout iteration remain preserved. Public evidence metadata now pins51artifacts; exact source locators remain in the extended owner-private register. The old37entries/hashes and historical reports are unchanged. No raw exports, databases, recovery binaries, private paths or endpoint selectors are added to public memory.

## Boundaries and next approval

This publication does not qualify automatic source acquisition/transfer, live SQL, a constrained database identity, variable-cost production inventory, general document entities, final GL posting, or actual changed-business-row refresh. The two actual source captures have identical business rows. Successful CI also does not prove arbitrary existing-state migration compatibility across builds/platforms.

The next proposed ERP change is one consumption issue of DBL-T01 quantity1 at20SAR: expected quantity29 and total1450SAR. It has **not** run. Separate owner approval is required, with the recovery, Save, independent ERP evidence, third-file import/replay and historical-replay gates in [the plan](THIRD_CAPTURE_PLAN.md). No main merge or third ERP action is performed automatically.
