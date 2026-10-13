# Inventory Source Qualification #001 — preparation STOP before SQL

**INVENTORY SOURCE QUALIFICATION = BLOCKED BEFORE SQL / NOT PROVEN.**
**FIRST INVENTORY INSIGHT = NOT TESTED.** This is not a Reader metadata denial, TLS failure or newly observed balance. No password was requested, console launched, SQL connection made, inventory projection read, function invoked, import executed or SQLite file opened. No administrative fallback, grant, host/security/source change or automatic live retry.

## Authorization and exact boundary

Owner approved section3 of the [readiness review at2da930b](DBL_FIRST_INVENTORY_INSIGHT_001_READINESS_2026-10-13.md): one limited Reader-only qualification against DBL_HOST_W11_EFA12026_PostS2_Frozen_20261009, strict direct TCP/TLS, identity/READ_ONLY/permissions, exact function definition/dependencies before invocation, capped ItemA/Branch1/W1/UA/package1 projections, one FindAvQty call and reconciliation. Any failed gate means STOP without automatic remedy. No Connector/Canonical/SQLite implementation or FIRST LIVE DATA rerun is authorized.

A one-off qualification runner was prepared only in new local task directory `outputs/host-inventory-source-001-20261013`, outside both implementation and Product Memory repositories. It reuses unchanged qualified build/runtime/public-CA/environment pins and source identity inspection, not a new Connector or framework. Its proposed mssql connection retains encrypt=true, trustServerCertificate=false, pinned-only CA, normal DESKTOP-8QRQT7R hostname validation, minTLS1.2, observed direct port, no Browser discovery, zero transient-login retries and10s budgets. Its code orders Reader/profile/permissions and definition/dependency gates before capped business projections and exactly one typed-parameter scalar SELECT. No launcher/secret wrapper was activated.

## Actual failure, not an unexplained source blocker

Node syntax check passed. The single `check` execution stopped in public prerequisite handling with sanitized `BOUNDED_GATE_FAILED`, before its offline movement vectors, owner preflight or SQL. A bounded read-only investigation established the exact local cause:

- Preserved S2 reconciliation JSON contains `Metadata.Function` as an **array of one record**.
- The new helper incorrectly used `.Metadata.Function.definition`, which is undefined in JavaScript; hashing that value raises a TypeError. PowerShell's collection-property adaptation had previously exposed the one record's definition, which does not justify the JavaScript access pattern.
- Read-only inspection confirmed array=true, rows1, actual first-record definition string. Recomputing UTF8 SHA256 of that archived string gives `235E8D7379760735FA7E4F3613CD2F67E822EF974B7C990A3E281665659C2628`, matching existing qualified evidence. No archived evidence is corrupt or missing.
- Separate non-SQL checks loaded the existing mssql driver and pinned inspection module and successfully ran the unchanged read-only environment helper. No secret or raw exception/credential material was printed. These checks do not prove a Reader connection, metadata visibility or the source balance.

**This is an agent-prepared helper defect, not a SQL/Reader defect.** Its safe failure closed the preparation path; do not relabel historical37 as newly read or claim the metadata gate failed under Reader. No live ATTEMPT/RESULT marker exists. No actual live attempt has been consumed, but owner approval is required before correcting this failed preparation and proceeding under the STOP boundary.

## Preserved evidence and minimum next decision

Local runner `Run-InventorySource001.mjs`,18809 bytes, SHA256 `D7F100B42E2DA33859ABB1F695FE4D45FECE722DAF550CC9458FDE151DB5BAED` remains **NOT QUALIFIED / DO NOT EXECUTE**. Local manually recorded nonsecret `INVENTORY_SOURCE_001_PREPARATION_RESULT.json` captures reviewed state at `2026-10-13T19:56:38.2873403+03:00`; it is a preparation-review record, not a SQL-generated result. Prior FIRST LIVE DATA/S1/S2/S3 evidence remains unchanged; no helper source, database export or secret is committed here.

Proposed smallest correction, **not applied**: require `Array.isArray(archived.Metadata.Function)` and length exactly1; require its record ObjectName=FindAvQty and nonempty string definition; hash that record's definition and retain exact expected SHA256. Missing/multiple records still STOP. Add an explicit sanitized prerequisite code for this shape check. No SQL query, function requirement, pinned evidence, TLS/grant policy or business scope change is needed.

Request separate owner permission for that bounded local helper correction, offline checks and then the **first** approved live Reader attempt with hidden local password input. If live Reader cannot read required definition/dependency metadata, STOP and request the separate attestation authorization already specified by the readiness plan; never grant VIEW DEFINITION, substitute admin or invoke the function first.

The implementation repo remains clean at84eadfd / merged tree51f15b2a1113fc3742559f7d76dab350fb8bb83c. `.vscode` remains outside Product Memory commit. Source qualification, inventory implementation/import and the deferred sales stage have not advanced. **STOP.**
