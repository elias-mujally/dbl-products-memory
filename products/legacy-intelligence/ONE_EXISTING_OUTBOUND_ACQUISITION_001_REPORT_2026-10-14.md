# One Existing Outbound — Bounded Read-Only Acquisition 001

## Final status: BLOCKED / NO QUALIFYING EVENT

**Phase A mandatory STOP — existing verified outbound linkage is unavailable. No live candidate search was performed.** This status means no outbound was qualified by this mission, **not** that SQL was searched and contained none. The owner's new read-only acquisition authorization was accepted; it was not treated as permission to guess document tables/relationships or substitute an administrative identity.

**الخلاصة:** توقف التنفيذ عند شرط سابق للقراءة الحية: الأدلة المعتمدة لا تحدد عائلة مستند الصرف ولا تربط رأسه وسطره بحركة المخزون. مسار Reader المثبت سابقًا يخص نسخة Post‑S2 المجمدة وجداول محددة، لا تفويضًا عامًا لكل جداول الصرف أو للقاعدة الأصلية. **SQLConnectionAttempts=0، BusinessQueries=0، OriginalExportsAcquired=0.** لم يُختبر الاتصال الحالي؛ لذلك لا ادعاء بفشل الوصول أو بعدم وجود منصرف في البيئة.

## Authorization and current repository references

The owner explicitly approved read-only test-environment inspection and acquisition of **one existing saved inventory-effective outbound**, but required exact source/access identity, effective read-only permissions and document-family/linkage establishment before business queries. Mandatory STOP includes: **document linkage cannot be established safely**, additional permissions, unverified source/read-only access, or need for a new transaction/image. These restrictions were not weakened.

GitHub `commits/main` and fetched `origin/main` agree:

- Product: `415ad8acef5f5754487b83408bad6c9b9c58028e` — PR #17 merge, unchanged.
- Product Memory: `64a9b1a8126a00a00d89150238e8885026b17674` — PR #4 merge, matching the new owner reference.

Read current AI_HANDOFF/CURRENT_STATUS and [offline handoff](OFFLINE_OUTBOUND_EVIDENCE_HANDOFF_001_REPORT_2026-10-14.md) / [next decision](OFFLINE_OUTBOUND_EVIDENCE_HANDOFF_001_NEXT_DECISION_2026-10-14.md). The two handoff documents and prior full context equal the previously read PR4 head; fresh current top sections were checked. Previous approval proposals/STOPs are historical, not new execution authority. Product checkout remained unchanged; no old helpers were executed.

## Phase A — exact preflight findings

| Required preflight condition | Finding and limit |
| --- | --- |
| Exact test instance/database/company/year/access identity | Retained profile identifies `DESKTOP-8QRQT7R\\YSEDU / EFA12026 / DB7`; former UI records year2026/activity1/branch1. These are historical, not fresh current identity/company-year proof. No name-based production/test inference was accepted. |
| Previous restricted read mechanism | Owner-hidden Reader input → private child stdin → Node mssql/Tedious, strict direct TCP with approved CA/hostname, no Browser/transient retries. Reviewed, **not activated**. |
| Previously qualified restricted target | `DBL_HOST_W11_S2_Reader_20261009` against `DBL_HOST_W11_EFA12026_PostS2_Frozen_20261009 / DB10 / READ_ONLY=true`, not the original writable `EFA12026 / DB7 / READ_ONLY=false`. Archived source metadata is independently confirmed. |
| Effective current read-only permissions | **NOT TESTED**. Historical object-level SELECT grants/database DENYs are preserved; they do not prove current effective permissions or a grant on another source. No denied query was attempted, grant requested/applied or alternate account used. |
| Outbound document family and header → line → movement linkage from existing verified schema | **UNQUALIFIED — mandatory STOP.** S3 contains protected table-count anchors and purchase/receipt projections, not an authenticated outbound document mapping/status decoder. |
| Current source/as-of, PID/port/TLS and acquisition timestamps | **NOT TESTED** after STOP. Existing non-SQL environment helper was source/pin reviewed only. Receipt time is the review time, never a new SQL source-as-of or outbound business date. |

The nine prior SELECT objects are: `dbo.item_detail`, `dbo.Item_Detail_Units`, `dbo.Measure`, `dbo.W_DETAIL`, `dbo.Bills`, `dbo.Bill_detail`, `dbo.gr_note`, `dbo.gr_detail`, `dbo.item_mov`. The saved purchase's qualified mapping does **not** classify all possible Bills document types as outbound, or identify ordinary issue tables. FindAvQty's existing object-level EXECUTE permission is not exercised; no function/procedure was invoked.

Prior S3 `documentBefore`/`documentAfter` retained `Bills/Bill_detail/gr_note/gr_detail`, journal/cache/quantity controls and function metadata. Their table-count anchors for `Good_Trans_M/Good_Transfer`, request and adjustment tables prove counts at their historical checkpoint, **not** an ordinary issue header/line key, source type dictionary, cancellation/reversal semantics or safe join. S3 `SaveCalls=0` remains confirmed. No table name or signed quantity was promoted into a document mapping.

The earlier Windows Integrated administrative route was not substituted for the restricted Reader. Its existence for earlier purpose-specific tasks does not supply an approved restricted outbound business reader or solve the unresolved identity/linkage gates. Nor was an ERP stock report regenerated: prior report-preview side effects were already disclosed, so report output cannot be assumed read-only without qualification.

**Why no live preflight connection?** The required existing-schema linkage prerequisite already failed during retained-context review. A new login cannot supply the missing independently verified semantics automatically. The mission says STOP when linkage cannot be established safely; it does not authorize starting a new schema-discovery/account/identity chain to bypass that stop. This is neither a secret-availability failure nor evidence that the prior Reader method no longer works.

## Phase B/C and qualification matrix

Phase B locate and Phase C event extraction/reconciliation: **NOT RUN**. No live item filter or business date window was queried. Exact checked scope was retained metadata/authorization/source bindings and local helper source text only; **no live business scope was checked**.

| Qualifying requirement | Result |
| --- | --- |
| Saved outbound header and stable key | NOT TESTED / no acquired candidate |
| Exact linked line | NOT TESTED |
| Matching inventory movement | NOT TESTED |
| Item identity and signed quantity | NOT TESTED for an outbound |
| Unit/package/branch/warehouse | Historical control scope known; no outbound acquired |
| Reliable outbound business date | NOT TESTED |
| Saved/cancelled/void/reversal/inventory-effective state | UNQUALIFIED decoder; no candidate tested |
| Source identity/acquisition time | Historical sources only; no live export or new source-as-of |
| Independent same-event reconciliation | NOT RUN |
| Original outbound SHA256 and event cardinality | UNAVAILABLE / NOT TESTED |

No document → line → inventory relationship was invented and no event was counted. Historical **37 UA** balance, **+37 UA** inbound, cancelled draft5 with SaveCalls0 and the financial−3700 distinction remain unchanged. No new event from another time/image was subtracted from the historical balance; unknown outbound remains unknown, never zero or32.

## Original files and SHA256 verification

Five existing source/control files matched their earlier pins in raw-byte Node hashing and independent PowerShell Get-FileHash. Original bytes were unchanged before/after local receipt preparation. These are **retained evidence hashes**, not newly acquired SQL exports:

| Workspace-relative file | SHA256 |
| --- | --- |
| `outputs/host-motakamel-posts2-frozen-20261009/QUALIFICATION_EVIDENCE.json` | `7D742175B6652860C7974115F8A1CBB789F49D86ACAD4FC5DD40CFCE310E7BAC` |
| `outputs/host-motakamel-s3-issue-discovery-20261008/READ_ONLY_EVIDENCE.json` | `83C73240BFAE62755D429D0DA6FA00B54C9A74E8AD5ED45FEDF7F8565869000C` |
| `outputs/host-motakamel-s2p-save-20261008/GATE_A_EVIDENCE.json` | `8D15D6B0BB5B22A62FAD15A04E6EF4F4F6DA1CC4269132AAD6CA504B235EDF87` |
| `outputs/host-historical-inventory-binding-001-20261013/FACT.json` | `0DE22CE4304839AC2D9807A45F448900C598F55177596A374D5A8E230A6FD670` |
| `outputs/host-first-live-data-001-20261010/Read-FirstLiveEnvironment001.ps1` | `A11CBCAB8EF1B189343D8ADCA62AC572F945C9D3EA463B5D4BDC94BCCCF7B78A` |

The frozen binding remains backup UUID `2b9d2bde-8d89-4ee7-98de-224fb97060c7`, recorded backup SHA256 `E63DF84D2DBB22C5ACD535DC5881D2DCF417F420665502927EBD9AD66731E572`, source-as-of `2026-10-09T08:12:11+03:00`. No backup/current database was opened or rehashed. A new acquisition cannot inherit that source time/UUID by default.

New local directory: `C:/Users/user/Documents/Codex/2026-08-25/files-pasted-by-the-user-dbl/outputs/host-existing-outbound-acquisition-001-20261014/`.

- `RESULT.json` — `47A31F5D0E2AA0DAFF202FB13EBC9435B7ADB1D80F059202A102E0481C924EEB`.
- `INDEPENDENT_RETAINED_BOUNDARY_CHECK.json` — `57925C3D87E5F8C8F21113ADA9BAA2B765E0357194261A2641CDF960BE242523`.
- Inspectable offline receipt code: `review-preflight.mjs`, corrected `review-preflight-002.mjs`, `verify-retained-boundaries.ps1`. All originals and the first helper remain unchanged. Initial helper stopped before receipt/SQL because archived Stage/SourceOptions **one-row arrays** were mistakenly read as objects; the new helper validates exact array cardinality before selecting the record. Independent PowerShell verifies that shape and identities. This was a local receipt preparation defect, **not a current-source identity mismatch or a live retry**.

Metadata-only public [receipt](research/ONE_EXISTING_OUTBOUND_ACQUISITION_001_RESULT_2026-10-14.json) preserves the precise distinction between historical grants and untested current permissions. No raw business exports or secret/SID/name hashes are published. Node/PowerShell independence is implementation cross-checking, not a separate human or live source reconciliation.

## Exact next decision — close the missing precondition, not repeat broad approval

See [bounded decision](ONE_EXISTING_OUTBOUND_ACQUISITION_001_NEXT_DECISION_2026-10-14.md). The current live read-only approval is acknowledged; the missing input is a **pinned source/access route plus authenticated outbound family/header/line/movement/status mapping**. Supply already-verified mapping/export metadata from the authorized ERP custodian, or decide a separately bounded **metadata-only outbound linkage qualification** before any business acquisition. Do not request the same generic acquisition permission again, change Reader grants, invent a new account/admin route, or recreate the draft.

If the necessary metadata is inaccessible through an existing verified restricted route, custodian-supplied evidence is the smallest safe path. If no existing saved event can ultimately be identified, a controlled new lab transaction still requires its own decision; none is proposed for execution here.

## Boundary and validation statement

The data-quality/validation review distinguished metadata completeness from file integrity and halted before unsupported live inference. **Ready to share this bounded preflight BLOCKED result**, not a verdict on current ERP contents. Missing current identity/permissions/semantics and unperformed extraction are explicit blockers; no synthetic result is described as source qualification.

No SQL/ERP connection or operation, credentials, source write, procedure/function call, account/permission/configuration change, backup/restore/snapshot, product/Canonical/SQLite/import change, deployment or release. No product build/test/WAL run was needed or claimed for this preflight-stop documentation. Prior reports and original FACT are unchanged; `.vscode` stays outside the commit. Focused documentation-only **Draft PR**, no merge. **STOP.**
