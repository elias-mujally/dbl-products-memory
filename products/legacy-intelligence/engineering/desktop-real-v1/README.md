# Desktop retained-file integration — architecture and open review gate

[Product Draft PR40](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/40) adds an isolated development application above the shared Electron integration branch. Its shell derives from the corrected V2 design, while source-specific fixture arrays and renderer financial aggregation are excluded. No existing engine, public contract, database schema, source guard or Preview1 package is changed.

## Architecture decision

An explicit private backend configuration selects an operator-provisioned retained backup and independently supplied pin. A Node worker uses the existing verifier and readonly in-memory SQLite inspection, then gives the unchanged Application Service an immutable selected capture. Both presentation tabs share that capture. The Renderer cannot select a file path, establish source trust, issue SQL, import or modify data.

The separate experimental read bridge supports sources, capture enumeration, capture opening, product pages/details and scope closing. It does not broaden the existing synthetic interfaces implicitly. Host enforces sender validation, checked DTOs, bounded operations and isolated preload; Electron keeps sandbox/CSP and denies network, permissions, navigation and extra windows. Expired scopes, worker failure and read errors invalidate displayed values, with manual reopen rather than fixture fallback.

The V2 layout, tabs, inspector, Arabic RTL and themes are retained. Fields absent from the approved product view remain unavailable. Source capture time is not current-stock freshness; neither this UI nor the private configuration qualifies a general ERP exporter, dynamic Catalog identity, final posting or production use.

## Evidence and publication boundary

Code/architecture and public synthetic CI may be published. Private captures, database/backup files, credentials, local configuration/locators and full receipts remain local. The detailed owner-artifact execution summary is held locally pending specific disclosure approval; it is not reproduced here.

The development implementation and native checks exist. The owner-session actual Electron acceptance and visual review are still PENDING at this checkpoint. Do not mark the task complete or infer human/Windows acceptance from Node/CI results. Preserve any failed rounds and update this record after verified execution.

A16, Narrator, supported clean Windows, clean-main build, data-directory security and production gates remain open. No ERP transaction, new extraction, network/security/permissions change, main merge or public release is introduced.

## Reproduction boundary

Use the source revision recorded in PR40 and an existing approved pinned development runtime. Supply private configuration outside Git, use a newly retained data copy, verify before and after footprints, and execute the owner launcher from the normal session. Do not retry security denials or change sandbox/ACL to bypass them. Private actual-data tests require explicit local opt-in; public CI must skip them when assets are absent.
