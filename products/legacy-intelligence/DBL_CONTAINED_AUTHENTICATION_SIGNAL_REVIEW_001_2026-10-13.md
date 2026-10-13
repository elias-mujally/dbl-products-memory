# Contained authentication signal #001 — offline review completed

**CONTAINED AUTHENTICATION SIGNAL REVIEW = COMPLETED.** The saved diagnostic proves `authenticating_database_id > 0`, but does not preserve its numeric value or establish the actual authentication scope on SQL Server build12.0.6024.0. Its `NotContainedIdentity=FAIL` measurement is preserved; its reason code is a tool classification, not independently established contained-authentication attribution. Original acceptance remains **BLOCKED / UNCHANGED**. No SQL connection or helper execution occurred in this review. **STOP.**

## Authorization, evidence and scope

Owner authorized an offline interpretation review following Product Memory `57ec33b3cd1130038c56ff833f973e7be9107640`, not a gate correction or another diagnostic attempt. Read the [previous session diagnosis](DBL_SESSION_IDENTITY_DIAGNOSIS_001_2026-10-13.md), its [selective evidence](research/DBL_SESSION_IDENTITY_DIAGNOSIS_001_REVIEW_2026-10-13.json), and the actual fixed SELECT in the local helper. Re-read and matched the published SHA256 values:

- `Read-SessionIdentityDiagnosis001.ps1`: `95283B8494BEEFA0AC1A1D00F2D5C533F3F10CE8C8D31BA3744FB4ED30E42F03`.
- `RESULT.json`: `84F25B7CBC686E29134BFA1F0AFA4F29A94CEFD28D212A623B7C03F8701E47CE`.
- `OFFLINE_QUALIFICATION.json`: `66FA43B57E6A7CA3F660824F928491C5EFB8BAA2A34E4BBE88CDCB2D7712F85E`.
- `ATTEMPT.json`: `D713CDA1F20C9AE1D973C4BFCF2417F34A88FC3BC04A287A9B30B8BD7776AB62`.

These are public artifact digests, not identity-derived hashes. No previous helper, query, acceptance predicate or evidence file was edited or run. No SQL/host probe, function metadata, business read, Reader attempt, import, permission change or retry. Only Product Memory documentation is being published; existing `.vscode` remains excluded.

## What the actual query and retained result prove

The saved SELECT restricts both session and connection aliases to `@@SPID`. Its classifier is exactly:

```sql
CASE WHEN s.authenticating_database_id=0 THEN 1
     WHEN s.authenticating_database_id>0 THEN 0
     ELSE NULL END AS NotContainedIdentity
```

This excerpt is evidence, **not an executable proposal**. The result records FAIL with `CONTAINED_DATABASE_AUTHENTICATION_OBSERVED`. Given the inspected CASE and classification, it establishes a positive value; it cannot distinguish1,10 or another positive database ID. The raw field was not selected into retained evidence. Target DatabaseId10 is a separate current-database guard, not proof that the authenticating ID was10.

At2026-10-13T22:11:29.147688+03:00 the saved observation established the exact frozen DB, ONLINE/READ_ONLY, SQL12.0.6024.0, strict encrypted direct TCP, four SID comparisons PASS, integrated-authentication-set PASS, sysadmin PASS and original/effective exact-name equality FAIL. It did not retain NTLM versus KERBEROS, database containment settings, principal mappings or authenticating ID. These are historical point-in-time results, not refreshed current state.

## Microsoft documentation, SQL2014 applicability and discrepancy

The current [Microsoft DMV reference](https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-objects/sys-dm-exec-sessions-transact-sql?view=sql-server-ver16) describes the field as the authenticating database ID, with0 for logins and the authenticating database ID for contained users. The column description applies to SQL Server2012 and later, including2014. `database_id` instead identifies the session's current database. Thus the existing CASE follows this reference literally.

However, an official [SQL Server team article](https://techcommunity.microsoft.com/blog/sqlserver/contained-database-authentication-how-to-control-which-databases-are-allowed-to-/383704), originally published December6,2010, describes server-scoped SQL/Windows authentication as1, the ID of `master`, and contained authentication as the authenticating database ID. It explicitly discusses **Denali CTP1**, not a qualification of SQL2014 RTM/SP3. This is a genuine historical documentation discrepancy, not proof that build12.0.6024.0 returns1 or that our saved value was1.

No successfully retrieved build-specific SQL2014 reference or live observation resolves0-versus-master here. The current reference is applicable guidance; the older primary source supplies a plausible alternative interpretation requiring evidence. Neither permits silently changing the classifier or asserting that every positive value is harmless. This review supersedes the previous narrative's conclusive contained-authentication interpretation, **not its measured FAIL, original policy or immutable evidence**.

## Compatibility with Windows authentication and SID results

Microsoft's [contained-user model](https://learn.microsoft.com/en-us/sql/relational-databases/security/contained-database-users-making-your-database-portable?view=sql-server-2017) supports both Windows and SQL authentication. Therefore integrated authentication does not by itself rule out contained Windows authentication. No Azure/Entra or newer-version behavior is assumed for this SQL2014 instance.

| Saved observation | Supported inference | Not established |
| --- | --- | --- |
| Four original/current/session/SQL SID matches PASS | The compared binary identities agree at the observation | Where authentication was authorized, complete token equivalence, or all earlier context history |
| NTLM/KERBEROS-set PASS | The connection used an allowed Windows integrated mechanism | Server-login versus contained Windows-user scope |
| sysadmin predicate PASS | Current context passed that role test | A catalog-qualified login mapping or an explanation for the positive ID |
| Positive authenticating ID | The inspected CASE takes its positive branch | Exact ID, target-database containment, or a confirmed contained principal |
| Exact name comparison FAIL | The old textual predicate failed independently | Naming cause, malicious impersonation, or authorization to replace the predicate |

A master-scoped historical representation would be consistent with Windows/SID/sysadmin observations if verified; contained Windows authentication is also compatible with Windows/SID equality alone. The sysadmin result makes server-scoped authentication an important hypothesis, but it is not used to override the unexplained field or to prove a contained token could have these server privileges. The complete cause remains **UNRESOLVED**, rather than either hypothesis declared true.

## Smallest proposed additional diagnosis — not implemented or executed

If separately authorized, prepare an independent, locally qualified tool for **one connection and one fixed own-session SELECT** using the same approved owner integrated method, direct TCP and strict TLS. No new credentials, grants, impersonation or Windows elevation. Revalidate source identity/ONLINE/READ_ONLY and the observed endpoint; do not assume that the historical port remains current.

Minimum additional descriptive fields, beyond existing source/transport guards:

| Field or safe derived observation | Purpose and bound |
| --- | --- |
| `s.authenticating_database_id`, preserving NULL distinctly | Resolve the lossy positive-only observation; numeric metadata is not a SID |
| `DB_ID(N'master')` and equality with the authenticating ID | Detect MASTER without assuming a hard-coded1 |
| `DB_ID()`, `s.database_id`, equality with target/authenticating ID | Distinguish current frozen database from authentication authority; classify ZERO/MASTER/TARGET/OTHER/UNKNOWN |
| Current target row's `sys.databases.containment` | Read only the pinned current database's containment; no database enumeration |
| Own connection `c.auth_scheme` | Retain the concrete integrated scheme rather than only the allowed-set flag |
| The same four SID equality flags and current sysadmin predicate | Co-observe identity/role in the new session; never publish raw SIDs, account names or hashes of them |

Microsoft documents [containment](https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-databases-transact-sql?view=sql-server-ver17) as NONE/0 or PARTIAL/1 for SQL2012 and later. This setting identifies database capability, not whether a particular session used contained authentication.

Keep both DMV aliases limited to `@@SPID`, require exactly one row and known typed fields; NULL/unavailable metadata remains UNKNOWN/STOP. If the authenticating ID is OTHER, stop without resolving another database's name, reading its catalog or broadening scope. Do not include server login inventories, login/user names, SID lookups, tokens, other sessions, global configuration, function definitions or business objects. No current-principal catalog expansion is necessary for this first discriminator. A future ambiguity must be reported, not trigger a diagnostic chain automatically.

Interpretation boundaries: MASTER would support the historical server-scoped hypothesis, not automatically repair acceptance. TARGET plus PARTIAL would support a contained-authentication hypothesis but would not alone prove a particular principal mapping. ZERO would match the current reference but would not retrospectively explain the old positive value. Unexpected values, inconsistent SID/authentication/source observations or inaccessible metadata require STOP. Neither this review nor that proposed diagnosis changes the existing name-equality or noncontained acceptance predicates.

The proposed metadata reveals limited authentication/topology information. Limit publication to already approved target identity, numeric IDs/categories, scheme, containment and comparison flags; suppress names of other databases and all principal names/SIDs. A new session cannot reconstruct the old one or guarantee future stability. READ_ONLY protects business-write scope but does not independently prove that administrators could never alter source metadata.

## Recommendation and approval boundary

Current compressed evidence is **insufficient to explain the signal**. Recommend the above single descriptive diagnosis, only after separate owner authorization and offline qualification of a new independent tool. Do not rerun the previous test. Gate-policy changes, administrative function attestation, connecting an attestation to Reader qualification and inventory acquisition each remain outside this review and require their own approval. No change to accounts, source, TLS, host or acceptance is recommended now.

Review completed; exact authentication scope and name mismatch remain unresolved. **FUNCTION METADATA ATTESTATION and INVENTORY SOURCE QUALIFICATION remain NOT PROVEN. STOP.**
