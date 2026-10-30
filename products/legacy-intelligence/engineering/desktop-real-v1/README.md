# Desktop retained-file integration — architecture and open review gate

[Product Draft PR40](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/40) adds an isolated development application above the shared Electron integration branch. Its shell derives from the corrected V2 design, while source-specific fixture arrays and renderer financial aggregation are excluded. No existing engine, public contract, database schema, source guard or Preview1 package is changed.

## Architecture decision

An explicit private backend configuration selects an operator-provisioned retained backup and independently supplied pin. A Node worker uses the existing verifier and readonly in-memory SQLite inspection, then gives the unchanged Application Service an immutable selected capture. Both presentation tabs share that capture. The Renderer cannot select a file path, establish source trust, issue SQL, import or modify data.

The separate experimental read bridge supports sources, capture enumeration, capture opening, product pages/details and scope closing. It does not broaden the existing synthetic interfaces implicitly. Host enforces sender validation, checked DTOs, bounded operations and isolated preload; Electron keeps sandbox/CSP and denies network, permissions, navigation and extra windows. Expired scopes, worker failure and read errors invalidate displayed values, with manual reopen rather than fixture fallback.

The V2 layout, tabs, inspector, Arabic RTL and themes are retained. Fields absent from the approved product view remain unavailable. Source capture time is not current-stock freshness; neither this UI nor the private configuration qualifies a general ERP exporter, dynamic Catalog identity, final posting or production use.

## Evidence and publication boundary

Code/architecture and public synthetic CI may be published. Private captures, database/backup files, credentials, local configuration/locators and full receipts remain local. The detailed owner-artifact execution summary is held locally pending specific disclosure approval; it is not reproduced here.

The owner-session actual Electron R2 acceptance passed17/17, and a separate normal visible review window was opened and inspected via Computer Use. R1 remains retained as a failure: its host compared internal worker IDs with renderer IDs. The fix validates the worker response, re-envelopes the UI correlation ID, and validates again without weakening source or schema checks. Failure invalidation also clears capture navigation. Public synthetic tests18/18 passed; the private suite remains local and overlaps them, so the groups are not added as unique cases. Screenshots and actual-data evidence remain local. These results are bounded developer acceptance, not the owner's final product acceptance, A16, Narrator or production qualification.

A16, Narrator, supported clean Windows, clean-main build, data-directory security and production gates remain open. No ERP transaction, new extraction, network/security/permissions change, main merge or public release is introduced.

## Reproduction boundary

Use the source revision recorded in PR40 and an existing approved pinned development runtime. Supply private configuration outside Git, use a newly retained data copy, verify before and after footprints, and execute the owner launcher from the normal session. Do not retry security denials or change sandbox/ACL to bypass them. Private actual-data tests require explicit local opt-in; public CI must skip them when assets are absent.


## Delivery and publication — 30 October 2026

Product R2 source is on PR40 at28d4e65e862f78d4dfc2ca99f131a6642caa1b1d, stacked without main merge. The owner explicitly reauthorized the sanitized source/test upload and this architecture update after automatic review had referred to an older planning-only scope. No rejected private evidence payload was republished. Existing exact-head CI is tracked in the product PR rather than inferred from its parent.

The visible application uses the approved existing Node/Electron runtime and frozen local data copy. A repeatable local launcher verifies pins, requires a normal session and creates a fresh application profile; it does not import data at startup. A nonblocking Windows GPU-cache path-length warning occurred in the long evidence directory. Future-launch config now uses a new shorter application-owned output directory without changing Windows long-path policy or security; that alternate profile launch is prepared, not independently exercised yet. The inspected current window remains open. Source-copy footprints matched after the actual qualification run; no claim about kernel-level write-proofing or final after-owner-close audit follows while the owner session remains open.
