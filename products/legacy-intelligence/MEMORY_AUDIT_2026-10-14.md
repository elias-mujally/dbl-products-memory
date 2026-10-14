# Memory synchronization audit — 2026-10-14

Audited every existing file under `products/legacy-intelligence/` at memory base `f68772c46b090bac48183f11ccbc580d9ab52ee7`: 224 files. Text was read; existing JSON parsed; helpers inspected as reference, not run. This is a documentation inventory/consistency audit, not a security or raw ERP audit.

## Contradictions resolved

- Core README/status/handoff had divergent latest dates, main=PR12, local-only code0c325c8 and sequential STOP/pending statements. Current sections now point to verified PR17 main; original text remains explicitly historical.
- Roadmap old sole access/isolation gate and inventory NOT TESTED statements are historical. Bounded historical balance/inbound DONE does not close live/administrative/pilot gates.
- Architecture review predates Product v4 and inbound observation; current architecture links canonical merged docs. Vision intent and historical risk/acceptance checkpoints are preserved.
- Evidence binding/balance-only import do not themselves qualify event identity; PR17 supplies the distinct inbound slice. Different local receipts/SQLite hashes are not interchangeable.
- Draft language in source reports does not override live merged metadata; CI success does not verify absent raw owner artifacts.

## Exact file inventory and disposition

| Existing path | Audit disposition |
|---|---|
| `AI_HANDOFF.md` | UPDATED current entry + preserved historical body |
| `ALMUHASEB1_LAB_PROGRESS_2026-09-01.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `ARCHITECTURE_REVIEW_2026-08-25.md` | UPDATED scoped supersession note; historical body preserved |
| `CONTROLLED_DATASET_TO_DESIGN_PARTNER_STRATEGY_2026-09-10.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `CONTROLLED_MOTAKAMEL_DATASET_001_PLAN_2026-09-10.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `CURRENT_STATUS.md` | UPDATED current entry + preserved historical body |
| `DBL_ADMINISTRATIVE_IDENTITY_DIAGNOSIS_001_2026-10-13.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `DBL_ADMINISTRATIVE_IDENTITY_SECURITY_REVIEW_001_2026-10-13.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `DBL_CONNECT_FUTURE_PRODUCT_CONCEPT_2026-10-13.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `DBL_CONTAINED_AUTHENTICATION_SIGNAL_REVIEW_001_2026-10-13.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `DBL_FINDAVQTY_ADMIN_METADATA_ATTESTATION_001_2026-10-13.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `DBL_FIRST_HISTORICAL_INVENTORY_OFFLINE_IMPORT_001_2026-10-14.md` | UPDATED scoped supersession note; historical body preserved |
| `DBL_FIRST_HISTORICAL_INVENTORY_OFFLINE_INTEGRATION_001_2026-10-13.md` | UPDATED scoped supersession note; historical body preserved |
| `DBL_FIRST_INVENTORY_INSIGHT_001_READINESS_2026-10-13.md` | UPDATED scoped supersession note; historical body preserved |
| `DBL_FIRST_INVENTORY_INSIGHT_001_SIMPLIFICATION_REVIEW_2026-10-13.md` | UPDATED scoped supersession note; historical body preserved |
| `DBL_FIRST_LIVE_DATA_001_2026-10-10.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `DBL_FIRST_LIVE_DATA_001_BOUNDED_MAINTENANCE_2026-10-10.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `DBL_FIRST_LIVE_DATA_001_BOUNDED_READ_2026-10-11.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `DBL_FIRST_LIVE_DATA_001_CA_CUSTODY_EXECUTION_GATE_2026-10-10.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `DBL_FIRST_LIVE_DATA_001_REAL_SQL_IMPORT_2026-10-13.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `DBL_HISTORICAL_INVENTORY_EVIDENCE_BINDING_001_2026-10-13.md` | UPDATED scoped supersession note; historical body preserved |
| `DBL_HISTORICAL_INVENTORY_LEGACY_READER_COMPATIBILITY_001_2026-10-14.md` | UPDATED scoped supersession note; historical body preserved |
| `DBL_HISTORICAL_INVENTORY_STORAGE_GATE_AND_INTEGRATION_STOP_001_2026-10-14.md` | UPDATED scoped supersession note; historical body preserved |
| `DBL_HISTORICAL_INVENTORY_STORAGE_GATE_AND_INTEGRATION_STOP_001_RESULT.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `DBL_INVENTORY_SOURCE_001_QUALIFICATION_2026-10-13.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `DBL_LAB_LEAF_ACCEPTANCE_001_2026-10-11.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `DBL_MACHINE_ROOT_REMEDY_001_2026-10-11.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `DBL_READER_CLIPBOARD_FREE_HANDOFF_DESIGN_001_2026-10-12.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `DBL_READER_CLIPBOARD_FREE_SYNTHETIC_001_2026-10-12.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `DBL_READER_CREDENTIAL_ROTATION_001_2026-10-12.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `DBL_READER_MANUAL_ROTATION_001_2026-10-12.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `DBL_SESSION_IDENTITY_DIAGNOSIS_001_2026-10-13.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `DBL_WINDOWS_CHAIN_DIAGNOSIS_001_2026-10-11.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `DBL_YSEDU_ACTIVATION_READINESS_2026-10-11.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `DBL_YSEDU_EXISTING_CSR_LEAF_SIGNING_001_2026-10-11.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `DBL_YSEDU_EXISTING_KEY_CAPI_ONLY_003_QUALIFICATION_2026-10-11.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `DBL_YSEDU_ONE_BOUNDED_MAINTENANCE_2026-10-11.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `DBL_YSEDU_RESUMED_MAINTENANCE_ADMIN_GATE_2026-10-11.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `DBL_YSEDU_REVOCATION_POLICY_DECISION_REVIEW_2026-10-11.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `DBL_YSEDU_SQL_ACTIVATION_001_2026-10-11.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `DECISIONS.md` | UPDATED current entry + preserved historical body |
| `FIRST_CONNECTOR_TARGET_2026-08-25.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `INDEPENDENT_FULL_PRODUCT_REVIEW_2026-09-06.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `LEGACY_INTELLIGENCE_PROGRESS_CHECKPOINT_2026-09-25.md` | UPDATED scoped supersession note; historical body preserved |
| `MARKET_STUDY_2026-08-21.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `MOTAKAMEL_CONNECTOR_SLICE_001_ITEM_IDENTITY_IMPLEMENTATION_2026-10-09.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `MOTAKAMEL_CONNECTOR_SLICE_001_PR11_FINAL_VERIFICATION_2026-10-09.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `MOTAKAMEL_CONNECTOR_SLICE_001_PR11_INDEPENDENT_REVIEW_2026-10-09.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `MOTAKAMEL_CONNECTOR_SLICE_001_PR11_MERGE_AND_LIVE_SQL_PLAN_2026-10-09.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `MOTAKAMEL_CONNECTOR_SLICE_001_PR11_REMEDIATION_2026-10-09.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `MOTAKAMEL_DIRECT_PORT_TRANSPORT_2026-10-11.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `MOTAKAMEL_HOST_W11_BASELINE_2026-10-06.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `MOTAKAMEL_HOST_W11_ELEVATED_RECOVERY_INVENTORY_2026-10-09.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `MOTAKAMEL_HOST_W11_EXPLICIT_SECURITY_DESCRIPTOR_QUALIFICATION_001_2026-10-10.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `MOTAKAMEL_HOST_W11_EXTERNAL_RECOVERY_DRIVE_E_QUALIFICATION_2026-10-09.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `MOTAKAMEL_HOST_W11_FINAL_RECOVERY_CAPTURE_SAFETY_QUALIFICATION_2026-10-10.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `MOTAKAMEL_HOST_W11_LIVE_SQL_GATE_A_PREFLIGHT_2026-10-09.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `MOTAKAMEL_HOST_W11_MINIMAL_ENCRYPTED_RECOVERY_ARCHIVE_DESIGN_2026-10-09.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `MOTAKAMEL_HOST_W11_POST_S2_FROZEN_READER_QUALIFICATION_2026-10-09.md` | UPDATED scoped supersession note; historical body preserved |
| `MOTAKAMEL_HOST_W11_REAL_RECOVERY_CAPTURE_001_2026-10-10.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `MOTAKAMEL_HOST_W11_S2_TARGETED_RECONCILIATION_2026-10-09.md` | UPDATED scoped supersession note; historical body preserved |
| `MOTAKAMEL_HOST_W11_SECURITY_METADATA_ACCESS_DIAGNOSIS_001_2026-10-10.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `MOTAKAMEL_HOST_W11_SYNTHETIC_ARCHIVE_QUALIFICATION_2026-10-10.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `MOTAKAMEL_HOST_W11_TRUSTED_LOCAL_SQL_MAINTENANCE_PREFLIGHT_2026-10-09.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `MOTAKAMEL_HOST_W11_YSEDU_CERTIFICATE_IMPLEMENTATION_READINESS_RECOVERY_GATE_2026-10-09.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `MOTAKAMEL_HOST_W11_YSEDU_CERTIFICATE_REMEDIATION_DESIGN_2026-10-09.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `MOTAKAMEL_HOST_W11_YSEDU_NETWORK_ENABLEMENT_2026-10-09.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `MOTAKAMEL_PILOT_001_EVIDENCE_PLAN_2026-09-07.md` | UPDATED scoped supersession note; historical body preserved |
| `MOTAKAMEL_PLUS_EVIDENCE_MILESTONE_2026-09-02.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `MOTAKAMEL_PLUS_PROGRESS_CHECKPOINT_2026-09-03.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `MOTAKAMEL_PLUS_V1_SEMANTIC_SCOPE_2026-09-03.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `MOTAKAMEL_PR12_MERGE_VERIFICATION_2026-10-11.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `MOTAKAMEL_PR12_P2_TRANSIENT_RETRY_FIX_2026-10-11.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `MOTAKAMEL_W10_AGENT_LAB_RETIREMENT_EVIDENCE_2026-09-25.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `MOTAKAMEL_W11_STAGE_B_INSTALLATION_BLOCKER_2026-09-30.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `MULTI_INDUSTRY_VISION_2026-08-21.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `MULTI_LENS_PRODUCT_DIRECTION_2026-09-06.md` | RETAINED dated strategy/lab/research context; no independent current qualification |
| `PILOT_LEARNING_CONTRACT_001_PURCHASE_ATTENTION_ITEM_INTELLIGENCE_2026-09-06.md` | UPDATED scoped supersession note; historical body preserved |
| `README.md` | UPDATED current entry + preserved historical body |
| `ROADMAP.md` | UPDATED current entry + preserved historical body |
| `VISION.md` | UPDATED current entry + preserved historical body |
| `research/DBL_ADMINISTRATIVE_IDENTITY_DIAGNOSIS_001_REVIEW_2026-10-13.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_ADMINISTRATIVE_IDENTITY_SECURITY_REVIEW_001_2026-10-13.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_CONTAINED_AUTHENTICATION_SIGNAL_REVIEW_001_2026-10-13.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_FINDAVQTY_ADMIN_METADATA_ATTESTATION_001_REVIEW_2026-10-13.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_FIRST_LIVE_DATA_001_BROWSER_POLICY_READONLY_2026-10-10.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_FIRST_LIVE_DATA_001_BROWSER_POLICY_RESULT_2026-10-10.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_FIRST_LIVE_DATA_001_PREFLIGHT_2026-10-10.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_FIRST_LIVE_EXECUTION_001_FIRST_LIVE_DATA_001_BUILD_PINS.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_FIRST_LIVE_EXECUTION_001_FIRST_LIVE_DATA_001_PREFLIGHT.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_FIRST_LIVE_EXECUTION_001_Invoke-FirstLiveDataInteractive001.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_FIRST_LIVE_EXECUTION_001_Read-FirstLiveEnvironment001.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_FIRST_LIVE_EXECUTION_001_Run-FirstLiveData001.mjs` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_FIRST_LIVE_EXECUTION_001_Start-FirstLiveData001.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_HISTORICAL_INVENTORY_BINDING_001_RESULT_2026-10-13.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_HISTORICAL_INVENTORY_COMPATIBILITY_001_RESULT_2026-10-14.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_HISTORICAL_INVENTORY_OFFLINE_INTEGRATION_001_PREFLIGHT_2026-10-13.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_HISTORICAL_OFFLINE_IMPORT_001_POST_IMPORT_READONLY_VERIFICATION.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_HISTORICAL_OFFLINE_IMPORT_001_PREFLIGHT_RESULT.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_HISTORICAL_OFFLINE_IMPORT_001_RESULT.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_INVENTORY_SOURCE_001_LIVE_REVIEW_2026-10-13.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_LAB_CA_CUSTODY_001_AGENT_VERIFIED_2026-10-10.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_LAB_CA_CUSTODY_001_CORRECTED_HELPER_2026-10-10.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_LAB_CA_CUSTODY_001_CORRECTED_LAUNCHER_2026-10-10.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_LAB_CA_CUSTODY_001_CORRECTED_PREFLIGHT_2026-10-10.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_LAB_CA_CUSTODY_001_HELPER_2026-10-10.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_LAB_CA_CUSTODY_001_ISSUANCE_STOP_2026-10-10.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_LAB_CA_CUSTODY_001_LAUNCHER_2026-10-10.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_LAB_CA_CUSTODY_001_NULL_BINDING_PROBE_2026-10-10.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_LAB_CA_CUSTODY_001_NULL_BINDING_RESULT_2026-10-10.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_LAB_CA_CUSTODY_001_OPERATOR_STOP_2026-10-10.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_LAB_CA_CUSTODY_001_PASSED_RESULT_2026-10-10.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_LAB_CA_CUSTODY_001_PREFLIGHT_2026-10-10.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_LAB_LEAF_ACCEPTANCE_001_Invoke-LabLeafAcceptance001.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_LAB_LEAF_ACCEPTANCE_001_LAB_LEAF_ACCEPTANCE_001_ATTEMPT.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_LAB_LEAF_ACCEPTANCE_001_LAB_LEAF_ACCEPTANCE_001_BEFORE.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_LAB_LEAF_ACCEPTANCE_001_LAB_LEAF_ACCEPTANCE_001_CERTREQ_ATTEMPT.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_LAB_LEAF_ACCEPTANCE_001_LAB_LEAF_ACCEPTANCE_001_RESULT.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_LAB_LEAF_ACCEPTANCE_001_POST_READONLY_VERIFICATION.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_LAB_LEAF_ACCEPTANCE_001_PREPARATION.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_LAB_LEAF_ACCEPTANCE_001_Start-LabLeafAcceptance001.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_LAB_LEAF_ACCEPTANCE_001_Test-LabLeafAcceptance001.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_MACHINE_ROOT_REMEDY_001_Invoke-MachineRootRemedy001.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_MACHINE_ROOT_REMEDY_001_MACHINE_ROOT_REMEDY_001_ATTEMPT.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_MACHINE_ROOT_REMEDY_001_MACHINE_ROOT_REMEDY_001_BEFORE.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_MACHINE_ROOT_REMEDY_001_MACHINE_ROOT_REMEDY_001_RESULT.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_MACHINE_ROOT_REMEDY_001_OwnedMachineRoot001.cs` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_MACHINE_ROOT_REMEDY_001_Start-MachineRootRemedy001.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_SESSION_IDENTITY_DIAGNOSIS_001_REVIEW_2026-10-13.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_WINDOWS_CHAIN_DIAGNOSIS_001_Read-WindowsChain001.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_WINDOWS_CHAIN_DIAGNOSIS_001_WINDOWS_CHAIN_DIAGNOSIS_001_RESULT.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_WINDOWS_CHAIN_DIAGNOSIS_001_WindowsChainReadOnly001.cs` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_ACTIVATION_READINESS_001_Read-YseduActivationReadiness001.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_ACTIVATION_READINESS_001_Restore-YseduLeafNetwork002.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_ACTIVATION_READINESS_001_Start-YseduActivationReadiness001.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_ACTIVATION_READINESS_001_Test-YseduActivationRollback002.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_ACTIVATION_READINESS_001_Test-YseduSystemDaclReadiness001.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_ACTIVATION_READINESS_001_YSEDU_ACTIVATION_READINESS_001_RESULT.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_YSEDU_ACTIVATION_READINESS_001_YseduKeyStorageReadiness001.cs` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_CAPI_ONLY_003_HELPER_2026-10-11.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_CAPI_ONLY_003_LAUNCHER_2026-10-11.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_CAPI_ONLY_003_NATIVE_SOURCE_2026-10-11.cs` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_CAPI_ONLY_003_OPERATOR_QUALIFIED_2026-10-11.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_YSEDU_CAPI_ONLY_003_PREFLIGHT_2026-10-11.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_YSEDU_CAPI_ONLY_003_TESTS_2026-10-11.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_CORRECTED_LEAF_SIGNED_2026-10-11.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_YSEDU_CORRECTED_SIGNING_002_HANDOFF_2026-10-11.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_YSEDU_CORRECTED_SIGNING_CUSTODY_STOP_2026-10-11.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_YSEDU_CSP_HASH_CAPABILITY_2026-10-10.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_YSEDU_CSP_HASH_CAPABILITY_SOURCE_2026-10-10.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_CSR_ACTUAL_STOP_SEQUENCE_2026-10-10.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_YSEDU_CSR_PUBLIC_VALIDATOR_2026-10-10.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_CSR_ROLLBACK_QUALIFICATION_2026-10-10.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_YSEDU_CSR_ROLLBACK_TEST_SOURCE_2026-10-10.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_DIRECT_MAINTENANCE_001_Invoke-YseduDirectMaintenance001.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_DIRECT_MAINTENANCE_001_RESULT_2026-10-11.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_YSEDU_DIRECT_MAINTENANCE_001_Start-YseduDirectMaintenance001.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_DIRECT_MAINTENANCE_001_Test-YseduDirectMaintenance001.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_EXISTING_CSR_PUBLIC_QUALIFICATION_2026-10-10.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_YSEDU_EXISTING_CSR_RESUME_HELPER_2026-10-10.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_EXISTING_CSR_RESUME_LAUNCHER_2026-10-10.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_EXISTING_CSR_TEST_SOURCE_2026-10-10.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_EXISTING_CSR_VALIDATOR_2026-10-10.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_EXISTING_KEY_002_DIAGNOSTIC_QUALIFICATION_2026-10-11.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_YSEDU_EXISTING_KEY_002_LAUNCHER_2026-10-11.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_EXISTING_KEY_002_OPERATOR_STOP_2026-10-11.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_YSEDU_EXISTING_KEY_002_QUALIFICATION_2026-10-11.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_EXISTING_KEY_ASSOCIATION_READER_2026-10-11.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_EXISTING_KEY_RESUME_STOP_DIAGNOSIS_2026-10-11.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_YSEDU_INTERACTIVE_GATE_002_HELPER_2026-10-11.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_INTERACTIVE_GATE_002_LAUNCHER_2026-10-11.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_INTERACTIVE_GATE_002_PASSED_2026-10-11.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_YSEDU_INTERACTIVE_GATE_002_SHARED_SAFETY_2026-10-11.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_INTERACTIVE_GATE_002_TESTS_2026-10-11.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_KEY_DIAGNOSTIC_LIBRARY_2026-10-11.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_KEY_DIAGNOSTIC_TESTS_2026-10-11.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_LEAF_CSP24_CSR_HELPER_2026-10-10.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_LEAF_CSP24_REQUEST_2026-10-10.inf` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_LEAF_CSR_LAUNCHER_2026-10-10.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_LEAF_MAINTENANCE_IDENTITY_STOP_2026-10-10.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_YSEDU_LEAF_MAINTENANCE_PREFLIGHT_001_2026-10-10.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_LEAF_NETWORK_ROLLBACK_2026-10-10.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_LEAF_SIGNING_001_HELPER_2026-10-11.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_LEAF_SIGNING_001_LAUNCHER_2026-10-11.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_LEAF_SIGNING_001_OPERATOR_STOP_2026-10-11.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_YSEDU_LEAF_SIGNING_001_PREFLIGHT_2026-10-11.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_YSEDU_LEAF_SIGNING_001_SOURCE_2026-10-11.cs` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_LEAF_SIGNING_001_TESTS_2026-10-11.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_LEAF_SIGNING_002_CORRECTED_HELPER_2026-10-11.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_MAINTENANCE_001_PRESTOP_HOLD_2026-10-11.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_YSEDU_ORIGINAL_SETTINGS_CAPTURE_SUMMARY_2026-10-10.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_YSEDU_PREFLIGHT_OPERATOR_IDENTITY_2026-10-10.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_YSEDU_SQL_ACTIVATION_001_Invoke-YseduSqlActivation001.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_SQL_ACTIVATION_001_POST_READONLY_VERIFICATION.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_YSEDU_SQL_ACTIVATION_001_PREPARATION.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_YSEDU_SQL_ACTIVATION_001_Restore-YseduLeafNetwork002-RetainedCertificates.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_SQL_ACTIVATION_001_Start-YseduSqlActivation001.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_SQL_ACTIVATION_001_Test-YseduSqlActivation001.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/DBL_YSEDU_SQL_ACTIVATION_001_YSEDU_SQL_ACTIVATION_001_ATTEMPT.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_YSEDU_SQL_ACTIVATION_001_YSEDU_SQL_ACTIVATION_001_BEFORE.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_YSEDU_SQL_ACTIVATION_001_YSEDU_SQL_ACTIVATION_001_RESULT.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_YSEDU_SQL_ACTIVATION_001_YSEDU_SQL_ACTIVATION_001_START_ATTEMPT.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_YSEDU_SQL_ACTIVATION_001_YSEDU_SQL_ACTIVATION_001_WRITE_0.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_YSEDU_SQL_ACTIVATION_001_YSEDU_SQL_ACTIVATION_001_WRITE_1.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_YSEDU_SQL_ACTIVATION_001_YSEDU_SQL_ACTIVATION_001_WRITE_2.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/DBL_YSEDU_SQL_ACTIVATION_001_YSEDU_SQL_ACTIVATION_001_WRITE_3.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/EXPLICIT_SECURITY_DESCRIPTOR_QUALIFICATION_001_2026-10-10.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/EXPLICIT_SECURITY_DESCRIPTOR_QUALIFICATION_001_NATIVE_2026-10-10.cs` | RETAINED research helper/source; read as reference, never executed |
| `research/EXPLICIT_SECURITY_DESCRIPTOR_QUALIFICATION_001_RESULT_2026-10-10.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/FINAL_RECOVERY_SAFETY_ELEVATED_METADATA_2026-10-10.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/FINAL_RECOVERY_SAFETY_ELEVATED_REPLAY_2026-10-10.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/FINAL_RECOVERY_SAFETY_EXTRACTED_MANIFEST_2026-10-10.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/FINAL_RECOVERY_SAFETY_RESULT_2026-10-10.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/FINAL_RECOVERY_SAFETY_SYNTHETIC_2026-10-10.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/MOTAKAMEL_DIRECT_PORT_TRANSPORT_2026-10-11.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/MOTAKAMEL_PR12_P2_TRANSIENT_RETRY_FIX_2026-10-11.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/REAL_CAPTURE_001_READONLY_PREFLIGHT_2026-10-10.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/REAL_CAPTURE_001_SECURITY_METADATA_PREFLIGHT_2026-10-10.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/RECOVERY_DECODER_RETENTION_001_RESULT_2026-10-10.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/SECURITY_METADATA_ACCESS_DIAGNOSIS_001_2026-10-10.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/SECURITY_METADATA_ACCESS_DIAGNOSIS_001_RESULT_2026-10-10.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/SYNTHETIC_ARCHIVE_QUALIFICATION_2026-10-10.ps1` | RETAINED research helper/source; read as reference, never executed |
| `research/SYNTHETIC_ARCHIVE_QUALIFICATION_RESULT_2026-10-10.json` | RETAINED parsed historical status copy; not authoritative raw re-verification |
| `research/procurement-operations-wedge-study-2026-09.md` | RETAINED dated strategy/lab/research context; no independent current qualification |

## Link and evidence gaps

No missing local Markdown file targets found in the audited product directory.

External repository document paths used by this sync were checked against the inspected main checkout; PR/commit/run links use live inspected GitHub identifiers. Existing external historical artifact links are references, not newly downloaded proof. Raw original owner artifacts remain absent; local365 qualification is reported, not independently rerun. Full historical notes and research artifacts remain preserved; no correction of old result JSON or fabricated source hashes.

## Fragment checks

All local Markdown file targets resolve. New links use file targets without fragments. Existing heading-fragment scan found 0 unresolved candidates under GitHub-style slug checking; these predate the synchronization and do not replace artifact evidence.
