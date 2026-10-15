# Outbound Schema & Linkage Qualification 001

## Final outcome: BLOCKED / METADATA INACCESSIBLE

**One actual restricted Reader connection succeeded; metadata visibility then blocked qualification.** Strict TLS, exact frozen database identity, READ_ONLY, non-administrative Reader identity and unchanged explicit grants passed the live helper's checks. The visibility batch resolved the nine previously allowed tables, but none of eight additional historical candidate names. Mandatory STOP was honored: **no further SQL attempt, business-row SELECT, column/key/FK batch, user function/procedure, administrative fallback or grant change**.

**الخلاصة:** نجح الوصول الآمن إلى النسخة المجمدة، لكن ربط مستند الصرف لم يتأهل. ظهرت الجداول التسعة المعروفة فقط؛ أسماء المرشحات الثمانية لم تُحل إلى object IDs. هذا لا يثبت عدم وجودها أو عدم وجود منصرف، ولا يثبت أنها عائلة الصرف الصحيحة أصلًا. اقتناء منصرف واحد **لا يمكن استئنافه بأمان بعد**.

## Verified repository and authorization scope

- Product main: `415ad8acef5f5754487b83408bad6c9b9c58028e` — PR17 merged; unchanged.
- Product Memory main/base: `716cd609e67e7bbaf48567422012bcaa55d39551` — PR5 merged, matching the owner's reference.
- Read current AI_HANDOFF/CURRENT_STATUS, [Acquisition001 report](ONE_EXISTING_OUTBOUND_ACQUISITION_001_REPORT_2026-10-14.md) and [its next decision](ONE_EXISTING_OUTBOUND_ACQUISITION_001_NEXT_DECISION_2026-10-14.md). The prior report bytes/content remain unchanged; earlier STOPs were not used to deny the new metadata-only authority or to authorize broader access.

The owner allowed only existing restricted access and catalog metadata. The single target selected was the **previously qualified frozen test DB10**, not original writable DB7. No assumption that Reader has access to `EFA12026`, no Windows Integrated administrator, and no source/customer production database were used.

## A. Exact source/access and acquisition boundary

| Item | Verified result / limit |
| --- | --- |
| Instance | `DESKTOP-8QRQT7R\\YSEDU`, SQL Server12.x identity guard passed |
| Database | `DBL_HOST_W11_EFA12026_PostS2_Frozen_20261009`, ID10, ONLINE, READ_ONLY=true; trustworthy/chaining disabled |
| Identity | `DBL_HOST_W11_S2_Reader_20261009`; original/effective/database-user equality passed; sysadmin/dbcreator/db_owner/control and checked write/alter permissions all0 |
| Grants | Exact recorded explicit-grant set matched pinned qualification evidence; no database-role membership. This is not a new grant or proof of access to DB7. |
| Transport | Direct TCP `192.168.56.1:52952`, hostname `DESKTOP-8QRQT7R`, encrypt=true, trustServerCertificate=false, minTLS1.2, only approved public CA, no Browser discovery, transient-login retries0 |
| Environment | PID101852 before/after, SQLBrowser Stopped/Disabled, leaf binding `A51BD253B6083D0114428FCFBAD57D008CD102F5`, ForceEncryption0 unchanged |
| Company/year context | Historical authenticated test profile `EFA12026`, year2026/activity1/branch1, bound through pinned Post-S2 qualification. **No current ERP company-master business row was read** and no new business-image timestamp asserted. |
| Timing | Attempt marker `2026-10-15T03:03:58.160Z` =06:03:58.160+03; visibility export `03:04:09.245Z`; final result `03:04:10.145Z` =06:04:10.145+03 |

Successful strict client connection proves the configured TLS/CA/name validation succeeded, not a separately captured cipher/peer-certificate transcript. CRL/OCSP remains **UNKNOWN_ACCEPTED_LAB_GAP**, not positive revocation assurance or production readiness. No Windows TLS/revocation/trust policy changed.

The historical image binding remains backup UUID `2b9d2bde-8d89-4ee7-98de-224fb97060c7`, recorded backup SHA256 `E63DF84D2DBB22C5ACD535DC5881D2DCF417F420665502927EBD9AD66731E572`, source-as-of `2026-10-09T08:12:11+03:00`. These are retained provenance, **not** a new backup/content-hash attestation. The current metadata acquisition time is distinct from that image time and from business dates. No BAK/restore/new image was used.

## What actually ran

One `pool.connect()` call, then **three fixed metadata batches**: (1) server/database/Reader identity and effective read-only guards, (2) own explicit grants plus own database-role membership, (3) visibility of17 predetermined `dbo` names through `sys.objects` and metadata-permission predicates. Batch2 contains two SELECT statements: **four caller metadata SELECT statements in three batches**, not three business queries. Built-in identity/catalog predicates were used; no application UDF or stored procedure was executed. Queries used the driver's SQL-batch API rather than an application stored-procedure call.

The 17 output rows are **17 requested lookup names from a VALUES list**, not17 actual source objects. A LEFT JOIN intentionally preserves unresolved names with NULL IDs. No business table appears as a FROM/JOIN source. Caps enforce one identity row, bounded grants/roles and17 unique lookup names. Statements for columns/keys/FKs existed only as guarded, unexecuted local code after the visibility gate; their export files are absent. The helper did not relax the gate or run another query after the failure.

## B. Objects and fields inspected

Fresh metadata fields returned: `objectName`, `objectId`, `objectType`, `canSelect`, `canViewDefinition`. No business quantity, status, date, key-column value or transaction was selected.

| Lookup group | Names / exact observed result |
| --- | --- |
| Known nine | `item_detail`, `Item_Detail_Units`, `Measure`, `W_DETAIL`, `Bills`, `Bill_detail`, `gr_note`, `gr_detail`, `item_mov`: positive objectId, typeU (table), SELECT=1, VIEW DEFINITION=0 |
| Unresolved eight | `Good_Trans_M`, `Good_Transfer`, `stk_adjustment`, `stk_adjustment_det`, `IncmRqustMstr`, `IncmRqustDtl`, `IncomRqustMstr`, `IncomRqustDtl`: objectId/type=NULL, SELECT=0, VIEW DEFINITION=0 |

These eight names came from earlier bounded schema/count anchors. They span possible transfer/adjustment/request surfaces and are **not an authenticated ordinary-issue dictionary or eight necessarily required outbound tables**. The check was a bounded candidate visibility probe, not a complete schema enumeration or an assertion that no other outbound family exists.

`objectId=NULL` under restricted metadata visibility cannot distinguish a hidden object from an absent/renamed object. VIEW DEFINITION=0 is an observed permission signal, **not** proof that all column/key metadata on the nine SELECT-visible tables is inaccessible. Those follow-up reads were not performed because no additional candidate became visible and the mission required STOP at inaccessible required metadata.

## C. Header → line → movement qualification map

| Component / relation | Structural evidence now | Semantic state / confidence |
| --- | --- | --- |
| Outbound family/type discriminators | No authenticated outbound decoder acquired | UNQUALIFIED; no inference from names/purchase type26/draft5 |
| Outbound header and key | No candidate header identity/columns acquired | UNKNOWN; not a claim of an absent header |
| Header → exact line | No selected source/target keys, composite components or FK inspected | UNQUALIFIED; cardinality unknown |
| Line → inventory movement | `dbo.item_mov` is visible, but no outbound line key/discriminator relationship was acquired | UNQUALIFIED; no purchase join reused |
| Item/quantity/unit/package/branch/warehouse fields | Existing inbound/control evidence retained; no current outbound field mapping inspected | NOT QUALIFIED for outbound |
| Saved/cancelled/void/reversal/inventory-effective fields | No authoritative current family definition/workflow acquired | UNQUALIFIED; financial posting not substituted |
| Business date and interpretation | No outbound date field/basis qualified | UNKNOWN; no guessed date/UTC offset |

Confidence is high in the **bounded visibility result and STOP**, not in a proposed outbound relationship. No fresh columns, primary/unique keys, FK, view definitions, lifecycle meanings or business cardinality were qualified. Mere catalog visibility or a future FK would not prove ERP inventory effect. Thus **PARTIAL / STRUCTURE KNOWN** would overstate this result; the requested map cannot be established.

## D. Evidence preservation and independent checks

Local directory (outside product repository/Git): `C:/Users/user/Documents/Codex/2026-08-25/files-pasted-by-the-user-dbl/outputs/host-outbound-schema-linkage-001-20261015/`.

| Preserved original artifact | SHA256 |
| --- | --- |
| `METADATA_VISIBILITY.json` — actual catalog export | `B145D8C4B8E85A02738A465D200B042BF55A1B4529069643B04238E2BBFDC6DC` |
| `RESULT.json` — actual completed attempt | `FCD26900279B3E26D6ADCEABA47E66D91F417D04131D873A9DE80B8D30D21B98` |
| `SELF_TEST.json` —48 named offline cases | `9100E7F492FC67C60A49E7655F49F747E73105D777A98C89BF1801EF65A10480` |
| `metadata.mjs` — executed helper pinned before input | `68FCD6618F5C2F19162211AD008448E63F9273EEB7DC4EFA5F3A1EC59E8D0E00` |
| `INDEPENDENT_OFFLINE_CHECK.json` — new file-only verification | `909FCF9F357C9F30BD23D0EC7FCF3BD4DFED89B06F77BCA454AB4C2A386921D2` |

Executed visibility SQL text SHA256: **`EBA7C4EC312ECE7EAE07B913DD10C43FD4E3C8B5E37EFBB97C503F79DA465539`**. The original export hash matches the producer's RESULT and independent native PowerShell hashing. PowerShell independently parsed exact1×17 rowset shape, unique names, 9/8 split, positive/NULL IDs, table types and permission flags; extracted the literal visibility SQL from the sealed helper and recomputed the query hash; matched the known nine to the original allowed-table list in pinned `QUALIFICATION_EVIDENCE.json` SHA256 `7D742175B6652860C7974115F8A1CBB789F49D86ACAD4FC5DD40CFCE310E7BAC`. This verifies source binding/receipt consistency, **not** unchanged schemas, existence of hidden objects or business semantics.

The independent checker **does not connect to SQL**. It is an independent implementation over the same acquired metadata, not a separate source acquisition, human review or independent ERP semantic corroboration. Actual identity/grant raw rowsets were checked in memory by the original live helper, **not separately retained**; the RESULT stores their passed checks. They cannot be recomputed independently from raw rows now without a new connection, which was not attempted. This limitation does not turn the blocked visibility result into a success or justify a retry.

48 offline tests passed before the connection (synthetic identity/permission/cardinality failures, fixed catalog-only SELECT text, TLS/no-retry and no product/SQLite imports). They qualify helper safeguards only. Product build/CI/Worker-WAL suites were not rerun or represented as fresh product tests for this metadata investigation. Wrapper result records child exit1, no credential in files/arguments/environment and no comprehensive memory-erasure guarantee. No raw SQL exception or credential was published. CleanupFailures=[]; sampled PID/port/Browser/binding/ForceEncryption were equal before/after; this is not an exhaustive atomic host-change audit.

Public receipts contain only this investigation's result and catalog metadata, no business exports or secrets: [result](research/OUTBOUND_SCHEMA_LINKAGE_001_RESULT_2026-10-15.json), [original visibility export](research/OUTBOUND_SCHEMA_LINKAGE_001_VISIBILITY_2026-10-15.json), [independent offline verification](research/OUTBOUND_SCHEMA_LINKAGE_001_OFFLINE_CHECK_2026-10-15.json). Result and visibility copies preserve their exact original byte hashes above. The public offline-verification copy normalizes CRLF to LF only and has SHA256 `B27037F8AF825A8BD52A285212B33A6B53CC0A57FEB8365CA8495DFECBC274F6`; its content equals the preserved local original after that explicit line-ending normalization. The original CRLF receipt/hash remains unchanged, not silently replaced. All prior evidence and failed/blocked reports remain unchanged.

## E. Exact next decision and invariant boundaries

**Do not resume one-outbound transaction acquisition.** Obtain authoritative, source/version/image-bound **metadata-only handoff from the authorized source custodian/ERP provider** for the actual selected outbound family: object names/types and key/column definitions, header-line-movement composite linkage/discriminators/cardinality, lifecycle/inventory-effect meaning, units/conversions/scope/date basis and its documentation/workflow provenance. See [the bounded next decision](OUTBOUND_SCHEMA_LINKAGE_001_NEXT_DECISION_2026-10-15.md). Do not guess that all eight names need grants, automatically request broad VIEW DEFINITION, rerun the same Reader probe, or use an administrator under this authorization.

Historical inbound+37 UA and historical balance37 UA stay within their original image/scope; cancelled draft5 SaveCalls0 and financial−3700 are not inventory outbound; unknown outbound is not zero and32 is unsupported. No business acquisition, new source image, account/credential/grant change, host/TLS change, source write, product/Canonical/SQLite/import change, release/deployment or merge occurred. The successful TLS/Reader gates **do not** reclassify earlier inventory/function/administrative identity failures as passed.

Evidence-quality/validation assessment: **Ready to share the bounded BLOCKED finding**, with explicit hidden-or-absent and independent-check limits. Owner-requested delivery is this documentation-only Draft PR, not an external analytical site. **STOP.**
