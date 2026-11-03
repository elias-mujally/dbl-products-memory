# Oracle Legacy Environment Discovery Log

> DBL Legacy Intelligence | Oracle exploratory track | Started: 2026-11-03
>
> **Scope:** observations from an authorized, read-only exploration of a hospital workstation. This is a separate Oracle discovery track, **not** evidence of readiness or connector support for the Motakamel Plus / SQL Server V1 track.

## Purpose
Maintain an append-only, evidence-oriented record of Oracle client discoveries, tests, assumptions, limitations, and next steps. Never confuse an installed Oracle *client* version with the database *server* version. This log is not an authorization to copy production data into DBL, export patient information, change Oracle configuration, or execute writes.

## Authorization and guardrails
- Operator reports IT permission to inspect the workstation and **read** Oracle data, with **no modifications or harm** to the operational system.
- The precise database account, allowed schemas/tables, and permission to **persist/export** data to a local SQLite snapshot have **not yet been established** in this investigation.
- Use an IT-approved, least-privilege **read-only database account** for any future live connection. Do not reuse privileged application credentials or bypass restrictions.
- No INSERT, UPDATE, DELETE, MERGE, DDL, PL/SQL execution, procedures, administrative grants, or production configuration changes. Even SELECT should be bounded and approved for the specific dataset.
- Do not commit credentials, host strings, service aliases, internal network addresses, patient data, screenshots containing sensitive content, or identifiable institution data to this repository. Keep evidence redacted and metadata-only.
- Avoid running broad queries or costly scans on the production database; coordinate scope with IT.

## Verified observations (operator screenshots and command outputs)

| ID | Observation | Evidence / method | Confidence |
|---|---|---|---|
| ORA-001 | Workstation runs Windows 11; Windows PowerShell 5.1, build 22621, revision 2428 | `$PSVersionTable.PSVersion` | Observed |
| ORA-002 | Basic PowerShell command execution works | `Write-Output "DBL Oracle Lab - PowerShell OK"` | Observed |
| ORA-003 | `Microsoft ODBC for Oracle` is registered as a **32-bit** driver | `Get-OdbcDriver` filtered for Oracle | Observed; functional connectivity not tested |
| ORA-004 | `C:\orant\BIN\OCI.DLL` exists; file version **8.0.6.0.0** | Windows file search + `VersionInfo` | Observed |
| ORA-005 | `C:\orant\BIN\PLUS80.EXE` exists; FileVersion and ProductVersion **8.0.6.0.0**, description `Oracle SQL*PLUS` | PowerShell `Get-Item ... .VersionInfo` and screenshot | Observed |
| ORA-006 | `PLUS80W` exists and opens a graphical Oracle login dialog requesting username, password and host string | Operator screenshot | Observed; no login demonstrated |
| ORA-007 | `PLUS80.EXE /NOLOG` starts SQL*Plus and displays `SQL>`; startup banner reports **Release 8.0.6.0.0**, copyright 1999 | Operator screenshot | Observed; **disconnected** |
| ORA-008 | `SELECT 1 FROM DUAL;` was attempted while **not connected**; no result row demonstrated. Console showed garbled Arabic text and a connection-related prompt | Operator screenshots | Observed; SQL execution against server **not proven** |
| ORA-009 | `SHOW RELEASE` returned `release 0` | Operator screenshot | Observed; **not** the Oracle version |
| ORA-010 | `C:\orant\BIN\DE60` launches **Oracle Procedure Builder**, with Object Navigator and PL/SQL Interpreter | Operator screenshot | Observed; no database connection demonstrated |
| ORA-011 | An Oracle Reports Builder welcome/report wizard screen opens, with options to create or open reports | Operator screenshot | Observed; no report executed and exact executable/version not independently verified |
| ORA-012 | `C:\orant\BIN` also visibly contains `PLUS80W`, `PJD60`, and other legacy Oracle binaries | Explorer screenshots | Observed filenames only |

## Interpretation (not independently proven)
- The workstation contains a **legacy Oracle 8.0.6 client / SQL*Plus installation** and Oracle development/reporting tools. These are **client-side** observations.
- The **server version, server address, service name, schema, accessible tables, privileges, compatibility of a new DBL connector, and data freshness remain unknown**.
- Garbled Arabic text is *consistent with* a legacy console encoding mismatch; the precise Oracle error code was not captured.
- The presence of a 32-bit ODBC driver or `OCI.DLL` **does not prove** a successful or safe connection.

## Status / next bounded milestone
**ORACLE CLIENT DISCOVERY = PARTIAL PASS. DATABASE CONNECTION = NOT TESTED / NOT PROVEN. DBL ORACLE CONNECTOR = NOT BUILT.**

Next, with IT:
1. Obtain an approved dedicated Oracle read-only identity and a service alias through secure channels; do **not** record credentials here.
2. Confirm authorized non-sensitive inventory tables/views and query limits; first connection test can use `SELECT 1 FROM DUAL;`.
3. Establish server version and read permissions through an approved, bounded read-only check.
4. Separately obtain explicit approval for any local caching/export/snapshot, even on the same workstation.
5. Design a distinct Oracle connector spike using synthetic or approved non-sensitive data; do not claim compatibility with production until demonstrated.

## Future discovery entry template

### ORA-XXX — YYYY-MM-DD — Short title
- **Goal:**
- **Environment / tool:**
- **Authorized scope:**
- **Read-only action:**
- **Observed result:**
- **Evidence (redacted reference; no secrets):**
- **Confidence:** Observed / Inferred / Not proven
- **Risk / limitation:**
- **Next decision:**

## Relation to DBL
- Product memory: `products/legacy-intelligence/`
- Build repository: `elias-mujally/dbl-legacy-intelligence`
- This file is a **discovery notebook**, not a declaration of Oracle production support or a replacement for the main product's acceptance gates.
