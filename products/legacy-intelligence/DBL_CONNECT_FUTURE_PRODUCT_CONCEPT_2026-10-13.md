# DBL Connect — Future bundled setup companion (idea record)

**Recorded:** 2026-10-13  
**Status:** Product concept accepted for roadmap consideration; implementation NOT authorized.  
**Owner intent:** Bundle a Windows database-connection assistant with DBL Legacy Intelligence and a practical Arabic PDF usage guide.

## Product concept
**DBL Connect** is a locally installed companion application shipped with DBL Legacy Intelligence. It helps an authorized customer discover supported SQL Server instances within an explicitly approved scope, select the appropriate ERP/database, configure a secure read-only connection, validate server identity and permissions, identify a supported system-specific Connector/profile, and initiate an owner-approved bounded sample import into DBL's offline-first local store.

Target user journey: install DBL bundle → open DBL Connect → choose/discover an authorized SQL instance → provide approved read-only credentials securely → validate TLS, privileges and supported ERP profile → preview bounded import → approve import → use DBL Intelligence.

The assistant is intended to reduce specialist setup work, not to bypass customer DBA authority or promise universal one-click access.

## Proposed delivery
- DBL Legacy Intelligence application.
- DBL Connect Windows setup/connection companion.
- Illustrated **Arabic PDF user guide**, plus a separate technical appendix for the database administrator covering requirements, least-privilege reader setup, TLS trust, troubleshooting, and privacy.
- First supported target: **SQL Server + Motakamel Plus** using the existing system-specific Connector. Other ERP/database families are future candidates, not current commitments.

## Safety and product constraints
- Offline-first; **read-only source access**. No ERP/source business writes.
- Discover only explicitly authorized local or specified hosts/instances. No indiscriminate network scanning.
- Never guess credentials, auto-grant permissions, change SQL services/network/firewall/certificates, or bypass TLS verification.
- Secure secret handling and owner-controlled credential custody. No credentials in logs, repositories, support exports or PDF.
- Inspect only permitted metadata; do not infer business meaning from table names alone. Require a verified Connector/profile and explicit owner consent before business-data reads/imports.
- Maintain bounded queries, provenance, deterministic mapping, clear error/status reporting and customer visibility into what will be imported.
- An unsupported database or insufficient permissions results in actionable guidance for the customer/DBA, not automatic remediation.

## Relationship to current implementation
Existing Motakamel Plus Connector, ImportOrchestrator, SQLite and SnapshotReader remain the data pipeline. DBL Connect would be an installation/onboarding/orchestration layer **on top of** the proven pipeline, not a replacement or generic SQL-to-canonical guessing engine.

**Sequencing gate:** Complete and evidence-qualify **FIRST LIVE DATA #001** before authorizing DBL Connect implementation. Current concept recording does not change the live-data test scope, SQL reader, TLS, Connector or canonical contracts.

## Open design questions for a later proposal
- Local process/packaging architecture and installer/update lifecycle.
- Authorized discovery UX and SQL named-instance/direct-TCP behavior.
- Credential provisioning responsibility and secure handoff for customers.
- Database/profile compatibility fingerprinting and version support matrix.
- Installer documentation and DBA-facing troubleshooting flows.
- Consent, telemetry defaults (prefer none/offline), auditability and support diagnostics.
- Acceptance criteria and a bounded first Windows MVP.

**Decision:** Preserve this idea in Product Memory as future roadmap input. **No code changes, no deployment, no new SQL access and no automatic execution authorized.**
