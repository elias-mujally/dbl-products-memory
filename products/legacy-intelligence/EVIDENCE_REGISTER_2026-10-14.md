# Evidence register and merged milestones — 2026-10-14

الحالة الحالية: [Merged state](MERGED_STATE_2026-10-14.md). جميع PRs أدناه `merged=true` تحققت مباشرة من GitHub؛ ترتيب الدمج #13 → #14 → #16 → #15 → #17، لا ترتيب الأرقام. أوصاف Draft/STOP في أجسام PRs ووثائقها تعكس وقت إعدادها؛ metadata الدمج هي حقيقة الحالة الحالية.

| PR / milestone | Merge commit | Qualification / canonical report |
|---|---|---|
| [#13](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/13) historical balance / pinned metadata | [a61c3d7b488e536cbcf838732b00ad0cef4476b8](https://github.com/elias-mujally/dbl-legacy-intelligence/commit/a61c3d7b488e536cbcf838732b00ad0cef4476b8) | DONE bounded historical balance integration, Product v4/migration4 and EOF/TOCTOU remediation; no current inventory claim. |
| [#14](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/14) SQLite Safety | [f44b8eb664b994e103549d2f6f9681db5d583a7e](https://github.com/elias-mujally/dbl-legacy-intelligence/commit/f44b8eb664b994e103549d2f6f9681db5d583a7e) | [SQLITE_SAFETY_001](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/415ad8acef5f5754487b83408bad6c9b9c58028e/docs/SQLITE_SAFETY_001.md): better-sqlite3 12.8.0 / SQLite 3.51.3; bounded Worker lifecycle. |
| [#16](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/16) Stabilization | [1008ec04cc15515f088ab71c4c9975479d1df6bc](https://github.com/elias-mujally/dbl-legacy-intelligence/commit/1008ec04cc15515f088ab71c4c9975479d1df6bc) | [STABILIZATION_SPRINT_001](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/415ad8acef5f5754487b83408bad6c9b9c58028e/docs/STABILIZATION_SPRINT_001.md): fresh attempt acknowledgement / healthy timing / ten fail-fast cycles; not product runtime redesign. |
| [#15](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/15) Product Movement | [32b6086830c76b8749e29c7b33cbc444a37bda20](https://github.com/elias-mujally/dbl-legacy-intelligence/commit/32b6086830c76b8749e29c7b33cbc444a37bda20) | [PRODUCT_MOVEMENT_INTELLIGENCE_001](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/415ad8acef5f5754487b83408bad6c9b9c58028e/docs/PRODUCT_MOVEMENT_INTELLIGENCE_001.md): DONE balance-only Arabic application preview. Its inbound gap describes that slice, superseded for one event by #17 only. |
| [#17](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/17) Historical Inbound | [415ad8acef5f5754487b83408bad6c9b9c58028e](https://github.com/elias-mujally/dbl-legacy-intelligence/commit/415ad8acef5f5754487b83408bad6c9b9c58028e) | [HISTORICAL_INBOUND_MOVEMENT_001](https://github.com/elias-mujally/dbl-legacy-intelligence/blob/415ad8acef5f5754487b83408bad6c9b9c58028e/docs/HISTORICAL_INBOUND_MOVEMENT_001.md): DONE one qualified inbound, not generalized ledger. |

## Evidence availability and authority

| Evidence | Availability / what this synchronization checked |
|---|---|
| main + PR13–17 merge metadata | Direct live GitHub inspection; main=PR17 merge SHA. |
| CI212 exact head `504ff3372abb74b88cfe441c5faf3264fec7581f` | [Run 38608071766](https://github.com/elias-mujally/dbl-legacy-intelligence/actions/runs/38608071766), Windows job116003991221 / Linux job116003991739 success; logs verify portable suites and ten WAL cycles per OS. |
| local 365 tests + actual retained-source offline inbound import | Reported in canonical PR17/report; not independently rerun in memory synchronization. |
| Original FACT.json / QUALIFICATION_EVIDENCE.json / S2 SAVE_EVIDENCE.json / targeted READ_ONLY_EVIDENCE.json | Owner-retained outside Git; pins/pointers are recorded in canonical inbound report. No newly invented evidence file or hash; no raw rehash/verification here. |
| Original backup/source database / local acceptance SQLite and Arabic preview | Not opened/rehashed; recorded identity/as-of and acceptance claims only. PR17 post-close audit-hash correction belongs to that acceptance, not earlier balance-only artifacts. |
| Existing memory research JSON | Historical status copies, sometimes normalized formatting; their bytes do not replace authoritative local artifact hashes. Unchanged in this synchronization. |

Historical lineage: [S2 reconciliation](MOTAKAMEL_HOST_W11_S2_TARGETED_RECONCILIATION_2026-10-09.md) → [Frozen Reader](MOTAKAMEL_HOST_W11_POST_S2_FROZEN_READER_QUALIFICATION_2026-10-09.md) → [Binding](DBL_HISTORICAL_INVENTORY_EVIDENCE_BINDING_001_2026-10-13.md) → [balance-only offline integration](DBL_FIRST_HISTORICAL_INVENTORY_OFFLINE_IMPORT_001_2026-10-14.md) → PR13/14/16/15/17. Source as-of, acquisition interval, document business date, memory-sync date and merge dates are distinct; no invented timestamp replaces them.

NOT QUALIFIED / PARTIAL boundaries and next evidence acceptance live in [current state](MERGED_STATE_2026-10-14.md) and [next plan](OUTBOUND_EVIDENCE_DISCOVERY_001_PLAN.md). No external raw-evidence qualification follows from green CI or a merged PR.
