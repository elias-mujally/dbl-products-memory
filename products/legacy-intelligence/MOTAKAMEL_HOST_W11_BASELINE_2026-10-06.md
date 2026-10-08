# Host Windows 11 Motakamel development baseline — 2026-10-06

**Latest non-saving Cashbox discovery — 2026-10-07: ACCOUNT ROLE DOCUMENTED, CASHBOX SAVE / ACCOUNT-SELECTOR ELIGIBILITY UNRESOLVED.** Official Accounting → Inputs → Cashboxes → Add proposed draft number 1; account/name/foreign name/sequence stayed blank, all type/POS/stop flags unchecked, currency/balance grid empty. Installed version-5 Help binds a cashbox to its own subsidiary chart account and documents account-level currencies/balances. However the current active-account F9 lookup was empty despite the two existing subsidiary SAR accounts. No account was accepted or created; the exact exclusion rule was not identified, and GetCash's source definition is NOT proof of the Add selector's implementation. No nature/classification/linkage choice or complete Save requirements are qualified. Cancel was confirmed on the actual dialog and the final form had Add enabled / Save disabled. At 22:45:18–22:59:53+03:00 Cashboxes/Suppliers/Banks remained 0; all nine protected complete rows and the zero item's 73-field fingerprint were unchanged. Cashbox A + one dedicated cash-account is a conditional proposal, not a proven sufficient/shortest S2-P path; Supplier A cost remains UNRESOLVED without expanding its discovery. S0b PARTIAL, BOTH BLOCKED, S2-P preferred; Controlled Zero PARTIAL remains nonblocking for the authorized discovery only. No Save, stock report, S2/S3, SQL writes or account/master changes. Details and the next narrow question below.

**Latest S0b non-saving route comparison — 2026-10-07: BOTH BLOCKED at the payment-side reference / justified credit account, not at zero-row provenance.** The user retained Controlled Zero = PARTIAL, accepted the unexplained zero row as noncontradictory and explicitly allowed S0b discovery without further doc_type=11 investigation. Purchase Add offers cash/cheque/cheque+cash/credit; cashbox and credit-supplier lookups are empty. SELECT confirms cashboxes/banks/suppliers each 0. Supply Add offers saved Warehouse A after the old cached form is reopened, but its account lookup contains only the two existing neutral TEST children, not an approved payment-side account. Installed official version-5 Supply Help defines that account as the credit side, not the Group inventory account or Warehouse transfer intermediary. No account was accepted and no inbound Save attempted. Supply type is empty but HELP-DOCUMENTED optional, not a fabricated blocker. All drafts were officially cancelled. At 22:14:07+03:00 all nine protected full rows and the zero row's 73-field fingerprint matched the preceding baseline; 18 checked business tables remained empty. S0b remains PARTIAL; S2/S3 NOT STARTED. Prefer S2-P after bounded discovery of its payment master; neither route is executable now. Details and the next approval boundary are below. Earlier zero-provenance investigation proposals are superseded by this explicit user direction, not by a new provenance finding.

**Latest narrow zero-row review — 2026-10-07: B) CONTROLLED ZERO = PARTIAL.** SELECT-only review captured all 73 fields of the sole item_mov row, unchanged at 20:55:08–21:00:07+03:00. Its contribution to the inspected local available-quantity calculation is 0; no related document was found in 18 exactly counted business header/detail/request/journal tables. However doc_types=11 (invoice approval) and the separate PKTransDocType=0 (opening stock) dictionary labels do not establish this row's role. Producer, insertion time and report causality remain UNRESOLVED. No GUI/report regeneration occurred because safe side-effect-free reread was not established. Warehouse Save/reload PASSED and S1 accepted remain; S0b PARTIAL; S2/S3 NOT STARTED. Details below.

**Latest authorized Warehouse A Save and scoped-zero attempt — 2026-10-07: WAREHOUSE SAVE + INDEPENDENT UI RELOAD PASSED; EXPLICIT SCOPED REPORT ZERO PROVEN; OVERALL CONTROLLED ZERO PARTIAL PENDING SOURCE-SIDE-EFFECT REVIEW.** Exactly one official Save persisted approved `001 / DBL_WAREHOUSE_A`, officially selected branch 1 and transfer intermediary 97070102 with resolved name/SAR; Motakamel normalized the warehouse number to numeric 1. Independent reopening/search/reload and live SELECT confirmed it. The official stock preview, filtered to exact Item A, Warehouse A from/to, UA and unit level 1, displayed DBL_ITEM_A / UA / package 1 and explicit whole-unit quantity 0. However keyed item_mov changed from 0 before preview to 1 afterwards: the single row has zero quantities/costs, warehouse/branch 1, UA, p_size 1, doc_type 11 and doc_no 0. No transaction Add/Save or direct SQL write was issued. Its creator/mechanism and doc_type semantics remain UNRESOLVED; do not assert that the report is side-effect-free, that a business receipt exists, or that the zero is contradicted by nonzero movement. Overall Controlled Zero is conservatively PARTIAL until this source change is reviewed; no further GUI action followed its detection. S1 remains accepted, S0b PARTIAL and S2/S3 NOT STARTED. The former missing-warehouse blocker is superseded, not silently rewritten; details below.

**Latest authorized transfer-account experiment — 2026-10-07: ACCOUNT SAVE / INDEPENDENT UI RELOAD / SAR BINDING PASSED; Transfer Intermediary Account Candidate = QUALIFIED FOR WAREHOUSE SELECTOR.** Exactly one official Save created `97070102 / DBL_TEST_TRANSFER_INTERMEDIARY_20261007` under 970701, subsidiary type 2, officially derived rank 2 and inherited Balance Sheet, with active/default SAR. A reopened chart independently loaded the saved record. In unsaved Warehouse Add, F9 offered the new child; double-click returned its code. Tab alone did not resolve the name or leave the field; one ordinary click on the empty Arabic warehouse-name field resolved the full account name and SAR and moved focus, without validation. Add was cancelled and confirmed. Final SELECT at 17:59:38+03:00: W_DETAIL=0, Account=3, Account_Cur_Detail=2, Unit/Group/Item=1 each. Protected full rows stayed unchanged except root Acc_Sort 2→3 observed after chart reopening, without a manual root edit; cause unresolved. No Warehouse Save or stock transaction occurred. Earlier account-choice-not-qualified statements are historical where superseded. Warehouse Save remains untested with this account; Controlled Zero BLOCKED, S0b PARTIAL, S2/S3 NOT STARTED. See the dated transfer-account section below.

**Latest non-saving Warehouse account discovery — 2026-10-07: VALIDATION FIELD IDENTIFIED; TRANSFER-INTERMEDIARY ROLE HELP-DOCUMENTED; ACCOUNT CHOICE NOT QUALIFIED.** Dismissing the prior validation returned focus to warehouse edit ID 26, visibly the code field labelled `حساب وسيط التحويلات المخزنية`. F9 from that unchanged focus opened the official account lookup; it showed only existing child `97070101 / DBL_TEST_CHILD_20261007`, not root 970701. No row was accepted and the picker was cancelled with the code still blank. Installed version-5 Help explicitly distinguishes the transfer intermediary from the inventory account and describes opposite debit/credit effects on transfer/receipt. It does not state required nature/classification/currency or justify reusing the Group inventory account. Full filter rules and Save acceptance remain UNRESOLVED. Warehouse Add was cancelled and confirmed; protected complete bounded rows/counts at 17:29:37 and 17:34:42+03:00 were identical, `W_DETAIL=0`. The earlier open-draft statement is historical; the form is now in view mode. No Save, account/master change or stock transaction occurred. Controlled Zero stays BLOCKED, S0b PARTIAL, S2/S3 NOT STARTED. See the dated account-discovery section below for the separate-role recommendation and next approval boundary.

**Latest authorized Warehouse A single Save — 2026-10-07: BLOCKED AT ACCOUNT-NUMBER VALIDATION; NO WAREHOUSE PERSISTED OR RELOADED.** The approved unsaved candidate was `001 / DBL_WAREHOUSE_A`, with actual branch `1 -` selected from the official dropdown and all other fields/flags retained at blank/unchecked defaults. Exactly one Save produced **«فضلا أدخل رقم الحساب»**, verified in the modal's screenshot and native accessibility text. No account was supplied, no retry or further GUI input followed; the validation and draft remain open. Full bounded SELECT rows/counts at 17:05:32 and 17:15:20+03:00 were identical for accounts, SAR link and accepted S1 masters; `W_DETAIL=0`. Current Save therefore requires an account number, unlike what nullable metadata alone might suggest; the exact field/eligible account remains UNRESOLVED. Earlier non-saving-discovery mandatory-status statements are historical where superseded. Controlled Zero remains BLOCKED, S0b PARTIAL, S2/S3 NOT STARTED. See the dated single-Save section below; the narrow next proposal is non-saving discovery of this specific account requirement, not another Save or automatic assignment of the Group inventory account.

**Latest non-saving warehouse Add discovery — 2026-10-07: DISCOVERY COMPLETE; WAREHOUSE SAVE REQUIREMENTS NOT YET QUALIFIED.** Official Inventory → Inputs → Warehouse Data → Add was inspected without entering identity values or invoking Save. All identity/contact/account/address fields and branch selection were blank; the branch dropdown offered existing `1 -`, not an automatically assigned warehouse or selected branch. Installed official version-5 help explicitly makes location/keeper/phone/fax optional and documents transfer-account purposes, not their current Save mandatory status. Cancel and its confirmation ended Add. Full-row bounded SELECT comparisons at 16:43:44 and 16:49:53+03:00 were identical for the two accounts, SAR link, Unit A, Group A and Item A; `W_DETAIL=0` remained. Controlled Zero stays BLOCKED, S0b PARTIAL, S2/S3 NOT STARTED. A proposed single named test warehouse requires separate identity/Save authorization; no numerical warehouse ID or accounting dependency has been invented. See the dated warehouse section below.

**Latest Host Controlled Zero / S0b discovery — 2026-10-07: CONTROLLED ZERO BLOCKED AT MISSING WAREHOUSE SCOPE; S0b PARTIAL, NO TRANSACTION SAVE.** Accepted S1 masters were not recreated or edited. Item A's stock tab was empty, not an explicit zero. The official stock report exposes zero-item inclusion options, but its warehouse dropdown was empty; live SELECT confirmed `W_DETAIL=0`. At 16:20:04+03:00 the accepted item still had Group 001 / Unit UA / package 1, and keyed item_store/opn_stock/item_mov counts were each 0. This supports absence of matching source rows only, not an authoritative I/U/W zero or a general missing-row rule. Official inventory supply/transfer-receipt and purchase-invoice forms were inspected in view mode. No Add, Save, posting, supplier/warehouse creation or stock movement was attempted. Neither S2-P nor S2-R is qualified to execute; the first blocker is a real, officially defined warehouse. Details and the narrow next discovery are in the dated section below. Earlier S0b-not-started statements are historical; S1 remains accepted, S2/S3 remain NOT STARTED.

**Latest authorized Host bootstrap — 2026-10-07: UNIT A / GROUP A / ITEM A (S1 master creation) SAVE, INDEPENDENT UI RELOAD AND KEYED LIVE SELECT VERIFICATION PASSED.** One official UI Save per master created UA / DBL_UNIT_A, 001 / DBL_GROUP_A with inventory account 97070101, and DBL_P001_ITEM_A / DBL_ITEM_A with Group 001, Unit UA and primary package 1. Final joined read at 15:32:02+03:00 confirmed their persisted relationships in physical Host EFA12026 (database ID 7); counts Account=2, Account_Cur_Detail=1, Measure=1, i_group=1, item_detail=1. Earlier empty-Host-master / Group-Save-untested / authorization-pending statements below are historical. This closes the authorized Host bootstrap through S1 master persistence only, not frozen acquisition, stock semantics, Gate A, a connector, PARTNER-VALIDATED or PILOT-QUALIFIED. No S0b/S2/S3 or inventory transaction was executed. Full defaults, Reference distinctions and stop boundary are in the dated bootstrap section below.

**Latest unsaved Group discovery — 2026-10-07: INVENTORY GROUP ELIGIBILITY PASSED at the picker/name-resolution/normal-field-exit boundary only.** F9 and a double-click selected existing child 97070101. Clicking the empty Arabic Group-name field then populated DBL_TEST_CHILD_20261007 in the paired account-name display; a subsequent observation confirmed focus moved from inventory-account ID 41 to Group-name ID 60. No validation or account-property change was needed. Cancel was confirmed; final SELECT at 07:51:52+03:00 kept Account=2, Account_Cur_Detail=1 and i_group/Measure/item_detail=0, with the two account projections and active/default SAR link unchanged. This supersedes the preceding name/exit UNRESOLVED statement, not Group Save, full currency-validation internals, global minimum hierarchy or accounting correctness. Details are in the dated Group-discovery section below.

**Latest child-only result — 2026-10-07: DIRECT CHILD SAVE / INDEPENDENT UI RELOAD / SAR BINDING PASSED; GROUP PICKER VISIBILITY AND CODE SELECTION PROVEN, COMPLETE ELIGIBILITY UNRESOLVED.** One authorized Save persisted 97070101 / DBL_TEST_CHILD_20261007 directly under 970701, subsidiary type 2, derived rank 2 and inherited Balance Sheet. SAR has a persisted active/default currency row. The unsaved Group inventory-account picker offered this child and returned its code, but the account name remained blank and Tab did not visibly move focus; no validation message appeared. Per the first-unexplained-behavior stop rule, no repair/retry or Group Save followed. Cancel was confirmed. Final SELECT at 07:35:51+03:00: Account=2, Account_Cur_Detail=1, i_group/Measure/item_detail=0. Earlier child-not-attempted / zero-currency-link statements below are historical. This is not Group Save, accounting correctness, global minimum hierarchy, canonical mapping or pilot qualification. Details are in the dated child section below.

**Latest root-only result — 2026-10-07: ROOT SAVE / INDEPENDENT UI RELOAD / KEYED SQL VERIFICATION PASSED for 970701 / DBL_TEST_MAIN_20261007.** The user approved Balance Sheet and one new Save attempt only, with no child continuation. Report changed blank → الميزانية العمومية; no other immediate visible field-value change was observed. One Save persisted parent 0, main type 1, rank 1 and `A_Report=Balance Sheet`. Final SELECT at 07:11:36+03:00: Account=1, Account_Cur_Detail=0, Group/Unit/Item=0, child=0. Credit nature persisted as Dr=false without a nature click; this is not accounting-design approval. No activated SAR currency link, direct-child Save or Group eligibility is proved. Acc_Sort was NULL in the immediate post-Save read and 1 after UI reload; the internal cause is unresolved. The preceding blank-report blocker/proposal and clean-account counts are historical, superseded only within this bounded root test. Details are in the dated root-only section below. STOP before Child.

**Latest report-field discovery — 2026-10-07: balance-sheet choice is justified as a PROPOSAL for the bounded test, not selected or saved.** Current UI still offers profit/loss and balance sheet. Installed official version-5 help documents balance-sheet carry-forward versus profit/loss period-end closing. Preserved Reference rows independently show `A_Report=Balance Sheet` for inventory account 1141010001 and all five ancestors. Host report-related SQL definitions distinguish these stored report strings. Report inheritance, automatic classification/nature effects, subsequent Save requirements and Group eligibility remain UNRESOLVED. The existing root draft remains intact with report blank; no Save retry or child action occurred. Final SELECT at 06:40:40+03:00 kept Account/Account_Cur_Detail/Group/Unit/Item counts at zero. Details are in the dated report-field discovery section below.

**Latest prerequisite evidence — 2026-10-07: authorized root Save attempted once and BLOCKED by required report selection.** First validation: `ادخل التقرير الذي يجب ان يظهر فيه الحساب`. No report was guessed and no retry, child Add or Group inspection followed. SELECT at 06:21:30+03:00 confirmed Account=0, Account_Cur_Detail=0, i_group=0, Measure=0 and item_detail=0; both approved identities remain absent. Root Save is BLOCKED for this exact unset-report candidate; direct-child Save, persisted SAR binding and Group eligibility remain UNRESOLVED / NOT ATTEMPTED. The accepted baseline backup plus isolated RestoreProof establishes database restore proof, not full ERP rollback. Earlier no-Save / restore-not-performed / authorization-pending statements below are historical, superseded only by the later dated evidence sections. No Host Controlled Dataset or connector qualification follows.

**Latest result: `HOST W11 MOTAKAMEL COMPUTER USE QUALIFIED` for the bounded direct-input test.** After the authorized direct normal launch and manual authentication/module opening, GL and inv were both **Medium / Elevated=false** before input. Sky mouse input visibly maximized the inventory window; Alt+F4 visibly opened its exit-confirmation dialog, which was cancelled by Sky mouse input. The backup and bounded input gates are complete; this is not qualification of every ERP screen or business workflow. A Reports transient-surface capture failed with `window crop is outside captured monitor`; its cause remains unresolved although dashboard/dialog capture subsequently succeeded. No shortcut/security/configuration change, SQL operation, ERP business mutation or controlled dataset creation occurred.

## Execution decision and protected boundary

The user explicitly selected the already working physical-host Motakamel installation for controlled DBL development. The user states that it was installed specifically for experimentation and contains no important/private production, customer, hospital or personal business data. This is an environment declaration, not permission to inspect unrelated host data or modify Windows.

The host is NOT disposable. Personal files, unrelated applications, Windows/SQL/network/security configuration remain protected. No installation, repair, upgrade, DSN/FMMA/login/role changes, registry edits, service changes, ACL changes or SQL business writes are authorized by this task.

The prior Windows 11 Agent Lab installation failure is outside the current critical path. No Hyper-V VM was started, repaired, reverted or modified. The existing Reference Lab remains preserved and was not connected or altered. Its prior controlled Item A must not be confused with the empty host item tables. No new live Hyper-V integrity/network audit was needed or performed in this task.

## Host and executable baseline

| Evidence | Observed value |
|---|---|
| Physical host | DESKTOP-8QRQT7R |
| Windows | Windows 11 Pro / Professional, 23H2, build 22631.6199, X64 |
| Branding caveat | Registry ProductName says Windows 10 Pro; OS build/version identifies Windows 11. This host is not the 25H2 rebuilt guest. |
| Installation directory | C:\EFA |
| Active application | C:\EFA\GL.exe |
| GL FileVersion / ProductVersion | 8.03.0812 / 8.03.0812 |
| GL physical length | 3,358,720 bytes |
| GL SHA-256 | 8A66CB7C39736A108C9249C1395ADB7A712D1190FD630FFB2BCEC578D405583A |
| Historical comparison | Exact version/hash match with supplied reference; not evidence that database contents match any lab. |
| Visible UI branding | M+ Professional ERP; Trial Version; Gold Version; V6.0; Ver. 6 E-Invoice 18-01-2026 |
| Current UI context | Financial year 2026; activity 1; branch 1; authenticated Main Menu |
| Component file metadata | inv.exe 8.03.0304; Sale.exe 8.03.2063; GL_New.exe 5.03.0723. Initially not launched or qualified by the agent; the user later opened inv.exe manually, as distinguished below. |
| Initial host free space | C: 40,302,235,648 bytes; D: 17,562,300,416 bytes. Point-in-time measurements, not fixed reserves. |

Opening GL via Sky timed out without proving launch. The user then opened Motakamel normally and completed authentication manually. The main UI was captured directly afterwards. Normal operation in this environment is proven at this boundary, not autonomous launch/authentication.

## SQL baseline and active database attribution

The normal execution sandbox account was `CodexSandboxOffline`. Windows-authentication attempts there failed with security-package/SSPI errors before SQL queries could run. No credentials, permissions, security settings or authentication workaround were introduced.

A supported `require_escalated` execution context subsequently ran as the ordinary host user and successfully connected using existing Windows integrated authentication. This resolved the SQL execution-context limitation without changing SQL or host configuration. A user-supplied SQL result was corroborated by fresh direct queries.

- Server: DESKTOP-8QRQT7R\YSEDU.
- Engine: **Microsoft SQL Server 2014 SP3 (KB4022619), 12.0.6024.0, Express Edition, Intel X86**, operating under WOW64 on the x64 host.
- Engine-reported version is authoritative. Setup registry Version/PatchLevel was 12.3.6024.0 and sqlservr.exe file metadata was 2014.0120.6024.00; these are recorded separately and must not replace the engine result.
- MSSQL$YSEDU was Running; SQLAgent$YSEDU was Stopped. No service action was performed.
- GL process PID 64148 was matched to SQL sessions with `program_name=Motakamel` on this host: session 52 used Multi_Lang and session 54 used EFA12026. This ties the active application to the instance/database, rather than inferring from filenames.

| Database | Created (raw SQL metadata) | State | Compatibility | Recovery | Allocated bytes (data + log) |
|---|---|---|---:|---|---:|
| Multi_Lang | 2026-09-01 17:12:07.047 | ONLINE | 100 | SIMPLE | 85,860,352 |
| DbRepDes | 2026-09-01 17:12:12.507 | ONLINE | 100 | FULL | 26,214,400 |
| EFA12026 | 2026-09-01 17:12:13.250 | ONLINE | 120 | SIMPLE | 247,136,256 |
| EFAARC10 | 2026-09-02 06:53:51.163 | ONLINE | 120 | SIMPLE | 243,400,704 |

**Active business database: EFA12026.** Approximate allocated size: 235.688 MiB. EFAARC10 exists; EFAARC12026 was not returned by the relevant EFA-name discovery query. No archive-error investigation or SQL configuration audit beyond this baseline was undertaken.

## Current dataset state

Catalog counts in EFA12026: 516 user tables, 194 views, 188 procedures, 190 functions. Partition metadata estimates 54 populated user tables and 1,573 user rows. These are approximate, point-in-time counts, not a transaction reconciliation.

The populated-table metadata list is dominated by dictionaries, menu/report metadata, parameter/permission/branch/user settings and standards. Examples include country/currency standards, doc_types, FlagsName, System_Parametrs*, report signatures and Units_types. Such rows are not classified as customer business data merely because they exist.

Exact SELECT counts, corroborated again after the UI tests:

| Surface | Exact rows |
|---|---:|
| dbo.Measure | 0 |
| dbo.i_group | 0 |
| dbo.item_detail | 0 |
| dbo.item_mov | 0 |
| dbo.Account | 0 |
| dbo.Account_Cur_Detail | 0 |

`DBL_UNIT_A`, `DBL_GROUP_A`, `DBL_P001_ITEM_A` and `DBL_ITEM_A` each returned zero matches on their corresponding observed unit/group/item code/name surfaces. No global scan of every text column was performed. Units_types has 14 dictionary rows; it must not be equated with an existing reusable primary unit.

**Classification: effectively clean/uninitialized for the inspected business domains, with system seed/configuration already present.** This is not a proof of every seed row's origin or every table's semantics. It is not the Reference Lab's controlled dataset. No prerequisite account/unit/group/item exists in the checked host master tables; further prerequisite discovery/creation requires a separate task.

## New pre-mutation backup

Source: EFA12026 only. Support databases were observed but not backed up; this is NOT a complete application/server/environment recovery package.

Existing SQL backup directory was used without directory/ACL/configuration changes. Target name included a new GUID, was checked for nonexistence, and did not overwrite any existing backup. No INIT/FORMAT, database-object creation, restore, compression-setting change or backup-device registration was used.

```text
C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.YSEDU\MSSQL\Backup\DBL_HOST_W11_EFA12026_PreMutation_20261006_47a3d84be3294eba8c035cd0dfde8001.bak
```

| Metadata | Value |
|---|---|
| msdb backup_set_id | 1011 |
| Backup type | D — full database |
| Backup start / finish (raw msdb) | 2026-10-06 17:19:26.000 / 2026-10-06 17:19:26.000 |
| Correlated SQL clock | 2026-10-06T14:19:26.8755872Z; 17:19 local Asia/Aden |
| is_copy_only | 1 |
| has_backup_checksums | 1 |
| SQL backup_size / compressed_backup_size | 22,634,496 / 22,634,496 bytes |
| Database GUID | 9EE44BF3-A684-46B1-8502-20AFA0659CBF |
| first_lsn | 40000003895200170 |
| last_lsn | 40000003902400001 |
| checkpoint_lsn | 40000003895200170 |
| database_backup_lsn | 39000001251000162 |
| differential_base_lsn before / after | 39000001251000162 / 39000001251000162 — unchanged |
| RESTORE VERIFYONLY | Completed with CHECKSUM and STOP_ON_ERROR; SQL returned: The backup set on file 1 is valid. |
| Physical filesystem bytes | 22,663,168 bytes — user-supplied Get-Item output from the requested manual administrative read; distinct from SQL backup_size. |
| SHA-256 | 2821DDAA854FBC3EA0FFC015F933654D02BC03C952044C586A275B719A391722 — user-supplied Get-FileHash SHA256 output for the same exact path. |
| Isolated restore at this original backup stage | NOT PERFORMED then; later separately authorized RestoreProof succeeded, as recorded below. No source overwrite. |

Backup succeeded and verification succeeded; the combined command subsequently returned nonzero because filesystem Get-Item was denied. Do NOT misclassify this as backup failure or create another backup blindly.

Follow-up: a fresh read-only RESTORE VERIFYONLY WITH CHECKSUM, STOP_ON_ERROR again returned `The backup set on file 1 is valid.` with exit code 0. The user then reported that the original PowerShell token's Administrator-role test returned False. After the requested manual Run as administrator procedure, the user supplied Get-Item/Get-FileHash results above. These filesystem results are user-provided evidence, not an independently collected agent hash. No backup recreation, ACL/ownership change or execution-policy change was performed. The prior access denial is resolved for the manual administrative read; broader token/ACL behavior was not audited.

Microsoft documents COPY_ONLY as not affecting the differential base. VERIFYONLY checks backup readability/completeness/checksums but does not establish full restored database/application correctness:

- https://learn.microsoft.com/en-us/sql/relational-databases/backup-restore/copy-only-backups-sql-server
- https://learn.microsoft.com/en-us/sql/t-sql/statements/restore-statements-verifyonly-transact-sql

## Direct host Computer Use — bounded result

Current skill and guidance/API/confirmation documentation were read. Every UI operation used node_repl -> @oai/sky. No VMConnect/RdpViewer path was used; no SQL client or terminal UI was automated.

Fresh returned GL identity: `process:C:\EFA\GL.exe`, window 1377924, Main Menu. Enumeration, get_window, activation and visual capture succeeded. Original screenshots were displayed by the tool at 1920 x 1020; no screenshot payload was decoded or saved for inspection. No sensitive/authentication dialog was active. SetIsBorderRequired / 0x80004002 / E_NOINTERFACE did not reproduce.

1. Fresh BEFORE screenshot showed Main Menu.
2. Exactly one left click at (1790,270), derived from that screenshot, targeted the visible inventory top-level heading. Immediate and delayed captures showed no observable navigation change. No second click/double-click or guessed retry was performed. **Mouse effect: UNRESOLVED**, not proof of broken delivery.
3. Exactly one F1 key requested application help from the unchanged non-business main screen. No visible change appeared; a fresh enumeration returned only the GL Main Menu window and no GL-owned secondary window or hh.exe help window. **Keyboard effect: UNRESOLVED**, not proof that all guest/host keyboard delivery is broken.
4. No text, Enter, Save, Add/Edit/Delete, ERP form or transaction workflow was invoked. Follow-up SELECT confirmed the six business/master tables above remained empty.

**HOST W11 MOTAKAMEL COMPUTER USE PARTIALLY QUALIFIED.** Activation/capture do not qualify input. The input cause/semantics are not established by this bounded test; do not infer elevation/session mismatch or non-working application solely from lack of these two visible effects.

### Subsequent manual-known-good state and bounded follow-up

The user, not Computer Use, successfully opened Inventory Management. Fresh Sky enumeration returned two separate top-level targets:

- `process:C:\EFA\GL.exe`, window 1377924, `Main Menu`.
- `process:C:\EFA\inv.exe`, window 265464, inventory system / branch 1 / user 1 Adm / year 2026. The correctly captured dashboard visibly showed Inventory Management and Stocktaking. It was not simply changed content within the GL target. Internal child/MDI structure was not independently established.

An initial inventory capture had inventory metadata but displayed Codex; no input was based on that mismatch. Fresh selection, activation and a new capture produced the matching inventory dashboard. In that known-good state, one F10 action and then one screenshot-derived click on Reports at (1419,46), each followed by a two-second wait and fresh observation, produced no visible transition. Neither channel qualified. No data-entry form, business field, transaction or SQL was used. This manual opening is not automated-input evidence.

### Autonomous read-only diagnosis — 2026-10-06

Current bundled Computer Use skill, guidance, API and confirmation documentation were read before experimenting. All GUI operations used supported `node_repl -> @oai/sky`. PowerShell was used only for read-only process/token/launch-metadata inspection, not UI automation, input injection or application launch. No helper was manually spawned and no application was elevated.

**A/B control: both input channels PROVEN in the current interactive session.** A supported attempt to launch Notepad ended with `Computer Use app approval timed out`; no Notepad launch or input was inferred. Instead, the already-open Explorer window 592016 was activated and captured. One fresh-screenshot coordinate click at (931,112) opened its More menu. One Escape action closed that menu, confirmed again after a two-second animation-settling wait. No menu command or personal file was opened, no text/file was created, and the menu was left closed. This control rejects a global mouse/keyboard delivery failure in that session; it does not qualify Motakamel.

Read-only token inspection at 2026-10-06T19:15:55.0200470+03:00 returned:

| Process | PID | Owner | Session | Integrity / RID | Elevated | Elevation type | UIAccess |
|---|---:|---|---:|---|---|---|---|
| GL.exe | 64148 | DESKTOP-8QRQT7R\user | 23 | High / 12288 | true | 2 — Full | false |
| inv.exe | 66260 | DESKTOP-8QRQT7R\user | 23 | High / 12288 | true | 2 — Full | false |
| codex-computer-use.exe | 13260 | DESKTOP-8QRQT7R\user | 23 | Medium / 8192 | false | 3 — Limited | false |
| codex-computer-use.exe child | 10080 | DESKTOP-8QRQT7R\user | 23 | Medium / 8192 | false | 3 — Limited | false |
| explorer.exe control | 31804 | DESKTOP-8QRQT7R\user | 23 | Medium / 8192 | false | 3 — Limited | false |

The inspected accessible Codex/ChatGPT processes were also Medium / Limited / UIAccess=false in session 23. Some other process reads were denied; these denials were not generalized to the relevant successfully read targets. The diagnostic shell itself used CodexSandboxOffline at Medium; it was not confused with the ordinary-user Computer Use helper. Targeted outside-sandbox reads used the supported ordinary-user execution context, without Run as administrator or changing a target token.

Supported CIM process metadata additionally showed: GL parent PID 31804 (Explorer); inv parent PID 64148 (GL); Computer Use PID 13260 parent PID 49984 (ChatGPT), with child PID 10080. Thus a different user or different session is not the established boundary between the control, helper and Motakamel. Both GL and inv were WOW64. The helper/control reported per-monitor DPI awareness, while GL/inv reported DPI-unaware; this difference alone cannot explain keyboard failure, and no scaling correction was attempted.

Read-only Win32 window/foreground queries from the restricted diagnostic shell could not see the interactive handles (foreground zero / IsWindow=false). They do not establish missing Motakamel windows or a Sky session mismatch. No window-class, exact foreground/focus or child-hierarchy claim is derived from those unavailable queries. No custom input or cross-process injection was performed.

**Established technical boundary: lower-integrity Computer Use input -> elevated High-integrity Motakamel (UIPI).** The bundled skill documents use of SendInput and UI Automation. Microsoft documents that SendInput cannot inject input into a higher-integrity application, and that UIPI blocks lower-privilege automation of elevated applications without the appropriate trusted UIAccess context. Both helper tokens lack UIAccess. This is an evidence-backed explanation of the observed asymmetric control/application behavior, not an assertion that all old/VB6 applications are unsupported. No same-integrity counterfactual or successful Motakamel input has yet been performed, so removal of this blocker may expose another issue and does not establish READY.

Official sources:

- https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-sendinput
- https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-10/security/threat-protection/security-policy-settings/user-account-control-only-elevate-uiaccess-applications-that-are-installed-in-secure-locations

Targeted launch-policy inspection found no GL/inv values in the interactive user's or machine's inspected AppCompatFlags\Layers keys. PE resource inspection as data returned no embedded manifests, and adjacent GL.exe.manifest / inv.exe.manifest files were absent; no manifest was added and no binary was executed or modified by this inspection. This does not prove that the application functions correctly without administrative privileges.

Both existing shortcuts target C:\EFA\GL.exe with working directory C:\EFA\ and empty arguments:

- C:\Users\Public\Desktop\المتكامل.lnk
- C:\ProgramData\Microsoft\Windows\Start Menu\Programs\المتكامل\المتكامل.lnk

Both have LinkFlags 0x000060DB, including RunAsUser / SLDF_RUNAS_USER bit 0x00002000. This is a concrete launch-policy finding consistent with the observed elevated GL process, not proof of its functional need for elevation. The exact shortcut used in the current human launch was not independently traced. Shortcut flags were read only; neither shortcut was saved or changed.

- https://learn.microsoft.com/en-us/windows/win32/api/shlobj_core/ne-shlobj_core-shell_link_data_flags

**Resolution proposal, NOT executed:** after separate approval, gracefully close only Motakamel and attempt an ordinary-user, direct launch of C:\EFA\GL.exe without the elevation-marked shortcuts. Do not edit shortcuts, compatibility settings, registry, UAC, ACLs, binaries or services, and do not elevate Codex/Sky or add UIAccess. Authentication remains manual. Before any test, verify fresh GL/inv tokens are Medium, observe the normal main/module screen, then prove one harmless menu mouse effect and one keyboard effect. If normal launch still requires elevation, fails, or exposes permissions/configuration problems, stop; do not repair or bypass them. Rollback is normal closure of the test instance and return to the untouched original launch path. Startup/functionality at Medium remains unverified. This changes the application's runtime elevation context and therefore requires explicit approval under the diagnostic task boundary.

No Motakamel input was repeated during this autonomous diagnosis. No SQL, ERP record operation, Windows/security setting change, service action, VM action or controlled-dataset work occurred. **ROOT-CAUSE BOUNDARY IDENTIFIED — RESOLUTION UNVERIFIED.** Computer Use remains partially qualified and the development environment remains NOT READY.

### Authorized normal launch — historical login hand-off

This later evidence supersedes the preceding diagnostic-stage statement that the resolution proposal had not yet been executed, without claiming a completed fix or input qualification.

The user explicitly authorized normal closure and a direct ordinary launch, with no shortcut/UAC/ACL/compatibility/security changes. One supported Alt+F4 action in the old inventory window produced no visible closure; read-only inspection still showed GL/inv at High. No force termination or alternate input stack was used. The user then reported closing both windows manually; fresh process inspection and Sky enumeration found neither GL nor inv before the new launch.

One `sky.launch_app({app:'C:\\EFA\\GL.exe'})` request ended with `computer-use request timed out: launch_app`; subsequent inspection found no GL/inv process or target window. It was not repeated. The supported Explorer UI was then used to navigate to C:\EFA and open the existing C:\EFA\GL.exe path normally from the address bar. This was an existing application file launch, not a terminal command, shortcut launch or Run as administrator action. No application files or launch properties were edited.

Fresh read-only process/token inspection, before any Motakamel input, returned GL PID **30180**, owner DESKTOP-8QRQT7R\user, session **23**, integrity **Medium / RID 8192**, **Elevated=false**, UIAccess=false. Current Computer Use PIDs 47484 and 56820 were also Medium, non-elevated, UIAccess=false in session 23. inv was not running and its new-launch integrity is therefore NOT established.

Fresh Sky enumeration returned GL window **985220**, title `.`. Its original capture visibly showed the Motakamel login screen. No authentication controls, password, remembered-login setting or login submission were automated. The user was asked to authenticate manually. No mouse/keyboard qualification test was attempted inside Motakamel at this point.

**NORMAL GL LAUNCH AT MEDIUM: PROVEN to the login-screen boundary only.** This removes the original GL integrity mismatch at that point, without proving successful authentication, database access, module operation, inv integrity or general application functionality at Medium. Original shortcuts, UAC, ACLs, compatibility, registry, services, SQL and application configuration remain untouched. No SQL, ERP business operation, VM action or controlled-dataset step was performed. Readiness remains NOT READY pending the remaining observations and tests.

### Post-authentication Medium-integrity direct-input qualification

This is the latest evidence, superseding the pending hand-off/input statements above. The user reported completing the manual step. Fresh Sky enumeration showed GL `Main Menu`, window **10751170**, and the inventory dashboard, window **7668528**, owned by `process:C:\EFA\inv.exe`. Manual authentication and manual module opening are not counted as automated input evidence.

Before any Motakamel test, read-only token inspection returned GL PID **30180** and inv PID **66628**, both owner DESKTOP-8QRQT7R\user, session **23**, **Medium / RID 8192**, Elevated=false, UIAccess=false. Post-test inspection reconfirmed both tokens; current Computer Use PIDs **5480** and **9864** were also Medium, non-elevated, UIAccess=false in that session. Normal operation is observed through the authenticated inventory-dashboard boundary, not all application/database functions.

All GUI actions used the Computer Use skill's supported `node_repl -> @oai/sky`, with fresh returned window objects and observations. No VMConnect/RdpViewer, alternate input stack, automatic elevation or authentication automation was used.

1. **Mouse: PROVEN.** The initial inventory capture was **567 x 576**. A screenshot-derived left double-click at **(247,20)** in the title bar maximized that same inventory window; the immediate new capture showed its dashboard at **1920 x 1020**. This is an independent visible mouse effect, not merely activation or a successful API return.
2. A single Reports-header click at **(1419,46)** was followed by `encode latest capture frame failed: window crop is outside captured monitor`. One fresh window-selection/activation capture recovery returned the same error, without repeating the click. A text-only state was then available and exposed Reports ribbon controls. No report or business-data form was invoked. Hidden controls can appear in that tree, so it alone does not prove a visibly expanded menu. One Escape was sent; dashboard screenshot capture subsequently succeeded. This sequence does not independently qualify Escape or establish the capture error's cause.
3. One **Alt+Space** produced no observable transition and is explicitly **not** keyboard proof.
4. **Keyboard: PROVEN.** From a fresh dashboard capture with no data-entry form open, one **Alt+F4** produced a new inv-owned dialog, window **9047452**, title `نـظـام الــمـــخـــــازن`. Its fresh **282 x 183** capture visibly asked `هل تريد الخروج من البرنامج؟`, with OK and Cancel controls. This new dialog establishes delivery and application response, not actual program closure. A screenshot-derived left click at **(213,156)** on **إلغاء الأمر** cancelled the exit; a fresh **1920 x 1020** capture showed the inventory dashboard again. No exit confirmation, business text, Save or ERP action was submitted.

**Evidence-led conclusion:** removing the original runtime High/Medium mismatch through an ordinary direct launch enabled bounded input effects in inv without security/configuration changes. This supports the diagnosed UIPI boundary. It does not prove original shortcuts may be edited safely, that elevation is never needed, or that every Motakamel component/workflow works at Medium. GL is confirmed Medium and its main screen is available; these input effects were demonstrated in inv, not separately in GL.

**Remaining capture limitation:** the Reports transient-surface crop error is unresolved. Dashboard and exit-dialog capture work; a future workflow must observe its own current surface and stop on failed/mismatched capture rather than reuse coordinates. No monitor, scaling, compatibility or security setting was changed to address it. No complete dataset reread/SQL reconciliation was performed during this follow-up; the clean dataset/backup facts remain the previously documented baseline, not a new query result. No ERP record action was performed.

## Deployment support and readiness

This is **working in this environment**, not an officially supported SQL Server 2014 / Windows 11 combination. Microsoft's compatibility table explicitly marks SQL Server 2014 on Windows 11 not supported. Vendor support for this exact deployment remains unverified:
https://learn.microsoft.com/en-us/troubleshoot/sql/database-engine/install/windows/use-sql-server-in-windows

No Windows/SQL/Motakamel upgrade, repair, PowerShell 2.0 reinstatement or vendor compatibility workaround is implied or authorized by the host development decision.

**HOST W11 MOTAKAMEL DEVELOPMENT ENVIRONMENT READY at the bounded backup + direct-input gate.** The new database backup is SQL-verified and its filesystem length/SHA-256 are documented from the user's manual administrative read. Independent inventory-window mouse and keyboard effects are now proven at Medium. This readiness does not qualify all capture surfaces, business/accounting semantics, the SQL/Windows vendor-support combination, a connector, Controlled Dataset prerequisites or a customer pilot. The Reports crop limitation remains unresolved.

Safest next action: STOP this input-qualification task. Obtain separate authorization for bounded official-UI prerequisite/evidence discovery against the clean physical-host dataset before any controlled record creation. Re-observe each required form/menu; if a capture fails or operation requires elevation/configuration changes, stop rather than weaken security or extrapolate this input test. Do not recreate the backup merely to repeat the completed fingerprint gate.

Once those gates are proved, the intended direction is to resume Pilot #001 controlled evidence work through the official Motakamel UI under separate authorization. This task does NOT complete S0b, start S2/S3, migrate Reference data, create Unit/Group/Item A, or advance connector implementation/customer-pilot qualification.

## Host prerequisite discovery — official UI, no save

The user separately authorized prerequisite discovery only, with an explicit stop at the first unmet prerequisite. The current Product Memory context was reread before UI actions. The build checkout was inspected read-only (local HEAD 0fb18e982e90ae09b5e68f306c406ee97a7f29ff); no new remote-main/CI qualification is claimed. GL PID 30180 and inv PID 66628 were reconfirmed Medium, non-elevated, session 23 before UI work.

### Observed official paths and evidence strength

All paths begin at **إدارة المخزون والجرد**. Forms were opened in unchanged view mode; Add/Edit/Save/Delete were never used and no business values were entered.

| Form | Observed path | Documented minimum / dependency | What remains unproved |
|---|---|---|---|
| Unit | تهيئة النظام → الوحدات المخزنية (form: الوحدات) | Normal unit procedure describes الرمز and الاسم. Dimension/weight fields are conditional on using that system. No normal-unit account link is documented or visible. | Actual save-time code/name validation; Host acceptance of UA / DBL_UNIT_A. |
| Group | المدخلات → بيانات المجموعات | Number and Arabic name are described; foreign name is explicitly optional. Inventory account is explicitly mandatory in installed official help; its currency must match inventory currency. | Runtime Save validation of number/name and other account links; Host inventory currency was not investigated after the account blocker. |
| Item | المدخلات → بيانات الأصناف | Help explicitly says Groups must be coded before Items. Describes group, item number, Arabic name and unit/package. Numbering depends on Group's include-group-number / automatic-number options; manual numbering is documented when both are off. Blank item type is documented as commodity; foreign name is explicitly optional. | Host acceptance of the reference identifier; actual saved defaults/mandatory fields; current Group numbering policy (no Group was selected or created by this task). |

Installed official help was read through F1/HTML Help UI, not by extracting application archives: `C:\EFA\EFAHELP.chm`, Unit `/3106.htm`, Group `/3201.htm`, Item `/3202.htm`. It labels itself version 5 while the observed inventory dashboard labels version 6.1; this is installed official documentation corroborating visible fields, **not proof of current binary Save validation**.

Group `/3201.htm` explicitly states inventory-account use is mandatory and its currency must equal inventory currency. Reusing one account for multiple groups is documented. Visible additional links were sales, COGS, sales return, allowed discount, purchase return, supply/purchase-return difference, free-quantity purchases, earned discount, disassembly difference, prior-year sales return and prior-year COGS. Their minimum-save necessity remains **UNRESOLVED UNTIL SAVE-TIME VALIDATION**; no visibility-based mandatory claim or investigation beyond the first missing prerequisite was made.

Item `/3202.htm` documents a single unit with package 1 or more; for multiple units the primary unit is the smallest, and other package quantities are expressed relative to it. Reference package 1 is therefore a documented possible value, **not an observed Host automatic default**. GTIN/local code/analytical group/drug metadata/prices/costs were left untouched; their minimum-save necessity was not inferred from visibility.

### First unmet prerequisite, freshly checked

A narrow, authorized read-only query used Windows integrated authentication against `.\YSEDU`. The sandbox connection first failed with `Failed to generate SSPI context`; the approved outside-sandbox diagnostic query then succeeded without any permission or configuration change. This execution context was for discovery, not qualification of a future least-privilege connector identity.

Current SQL sessions matched host DESKTOP-8QRQT7R and both application PIDs: GL/Motakamel 30180 and inv/Inventory System 66628 each had an EFA12026 session. Other observed sessions used Multi_Lang / DbRepDes. Exact count at **2026-10-06T20:24:02.5629652+03:00**:

| Database / table | Rows |
|---|---:|
| EFA12026 / dbo.Account | 0 |
| EFA12026 / dbo.Account_Cur_Detail | 0 |

Thus **no existing inventory account is available in this active Host business database**. Combined with the official mandatory-account statement, this is the first unmet prerequisite for the proposed Unit → Group → Item sequence. No F9 account selector was tested in Add mode, no save-time validation was triggered, and no subsequent prerequisite/configuration was investigated. No account currency match is claimed on Host.

Reference Lab had reusable account 1141010001 / المخزون with SAR and saved Unit UA, Group 001 and Item DBL_P001_ITEM_A. Those values are **reference targets only** here: UA / DBL_UNIT_A; 001 / DBL_GROUP_A; DBL_P001_ITEM_A / DBL_ITEM_A; primary package 1. They were neither entered nor accepted on Host. A suitable inventory account is required by the documented Group workflow; **Account Numbering, an entire chart template, and the specific way of obtaining that account are NOT established requirements**. No provisioning was performed or authorized by discovery.

### Operational capture boundary and final state

An expanded temporary ribbon surface reproduced `window crop is outside captured monitor`. Fresh text-only observation succeeded, but UIA clicks on freshly returned Unit indexes failed as unavailable in cached app state; no blind action was inferred. Escape returned to a capturable dashboard. A screenshot-derived double-click pinned/expanded the application's own ribbon, after which Unit/Item/Group forms could be captured and opened by fresh screenshot-derived clicks. This was presentation-only, with no Windows/monitor/scaling/security change and no claimed general capture fix. Some help-close inputs had no immediately observed closure; fresh targeting and Escape ultimately closed HTML Help. All three forms were exited unchanged, leaving the inventory dashboard with the ribbon expanded and the window restored.

**Conclusion: Host prerequisite discovery is partially qualified, blocked at the missing inventory account.** Mandatory account dependency is documented and absence is freshly proven; other minimum-save rules remain untested. No ERP record was created, changed, saved, deleted, posted or approved. No VM, account, Account Numbering, chart template, provisioning, SQL write, service or security configuration was modified. S0b remains historically partial in Reference; Host S0a/S1 creation and S2/S3 were not started. No connector/Canonical Model expansion or customer/pilot qualification follows from this evidence.

**Narrowest next action:** obtain a separate decision/authorization for an official Motakamel operator/vendor-supported way to make one suitable inventory account available, with currency compatibility subsequently checked. Do not automatically provision a whole chart or reopen Account Numbering. Resolve that external prerequisite before authorizing Unit → Group → Item creation; no speculative setup is implied.

## Host inventory-account route discovery — no mutation

The user separately authorized discovery of official ways to supply the missing Group inventory account, not account creation or wider setup. The required Product Memory context was refreshed before UI work. No Add/Edit/Save, account-value entry, Account Numbering, chart initialization, Excel import, data initialization or FMMA provisioning was executed. All GUI work used `node_repl -> @oai/sky`.

### Current Host UI evidence

- **Inventory currency is SAR**, observed in **إدارة المخزون والجرد → تهيئة النظام → الخيارات → أساسية → عملة المخزون** in unchanged view mode. The current context is activity 1 / branch 1 / financial year 2026. The currency control displayed the code only; its visible full name was not established there. Options were exited without Edit or Save.
- **إدارة الحسابات → المدخلات → دليل الحسابات** opened the **الدليل المحاسبي** form in view mode. The account tree was empty. Add and Search were available; Edit/Save/Delete were disabled. This proves a separate individual-add entry point exists, not that an account was added or that its Save prerequisites have been qualified.
- Visible fields: parent/main account, account number, Arabic and foreign names, account type, group, rank, report, account-linked specialization, account classification, flow type, financial analysis, debit/credit nature, currency activation/limits/stop, account stop and TDS. Visibility alone is not proof of mandatory validation. The parent box displayed `1` on the empty view; this is not evidence of a saved or selectable parent account.
- The account currency grid displayed **SAR / Saudi Riyal**, with an unchecked activation cell on the empty view. This proves availability of that configured currency in the account form, **not** that any account has SAR enabled. Inventory currency and the available account-currency code match; there is still no existing Host account whose actual enabled currency can be compared.
- The same form exposes **إنشاء دليل الحسابات** and an Excel-icon control. Neither was invoked. The installed help identifies the Excel control as chart import.
- **إدارة الحسابات → تهيئة النظام → الخيارات → الخيارات العامة → الدليل المحاسبي** was inspected unchanged. The visible checkboxes for automatic subsidiary-number generation from the parent, fixed subsidiary rank, and excluding the parent number from the subsidiary were **unchecked**. No configured fixed rank 6 or requirement to open Account Numbering is established. No checkbox was changed.
- The Options form also exposes **تهيئة البيانات**. It was not invoked and its effect or role as an account prerequisite remains unqualified; a visible initialization button is not proof that this workflow requires it.
- The current accounting dashboard labels itself version 6.0; inventory labels itself version 6.1. The installed help identifies version 5. These are UI/help labels, not a new binary-version or licensing conclusion.

A narrow SELECT at **2026-10-06T22:11:16.9903932+03:00**, against physical Host DESKTOP-8QRQT7R / `.\YSEDU` / EFA12026, returned `Account=0`, `Account_Cur_Detail=0`, `account_types=0`, `AccountClasses=12`. A final read-only session query also matched both newly opened General Ledger processes **47216 / 62836**, GL **30180** and inv **66628** to EFA12026 sessions on that host (with additional Multi_Lang / DbRepDes sessions); the accounting evidence therefore concerns the same business database. No SQL writes or permission/configuration changes were performed. Empty `account_types` is not automatically classified as a required missing prerequisite; predefined AccountClasses rows are not proof that all UI choices or Save prerequisites are satisfied.

### Installed official help — documented, not current Save validation

F1 from the current accounting chart form opened **C:\EFA\EFAHELP.chm::/1801.htm**, **الدليل المحاسبي**, explicitly labelled version 5. It documents:

1. **Manual individual accounts:** first-level main account uses parent `0`; lower levels choose an already-defined parent. Account number can be entered manually, or generated if the accounting-options auto-generation setting is enabled. Rank is derived from the parent's rank. Main accounts occupy the principal levels; subsidiary accounts are the last level used directly by operations. A configurable fixed subsidiary-rank restriction is described, but the current Host checkbox is unchecked.
2. **Currencies:** a subsidiary account must have at least one currency activated, and can have several; principal accounts take the entity's local currency. Currency rows come from the currency setup. Activation uses the grid's activation checkbox. Limits are notification settings, not established minimum account-creation requirements.
3. **Other dependencies:** the introduction describes prior period/currency/account-group preparation, but the detailed group paragraph explicitly makes account-group membership optional. It describes report selection and conditional specialization (e.g. bank/customer), without proving every current field mandatory. Parent specialization can propagate to descendants. No inventory-specific specialization requirement was proved.
4. **Default chart:** `إنشاء الدليل المحاسبي` is presented as an optional way to create default principal levels, available at initial use before any accounts exist; the user then adds subsidiaries.
5. **Excel chart import:** import follows the supplied workbook structure and is documented for initial use before any accounts exist. No workbook/import wizard was opened and no supported single-row import or precise transaction scope was proved.
6. Accounts may be added later individually. The documentation does not make a full default-chart initializer the prerequisite for manual account entry.

The previously inspected Group help `/3201.htm` explicitly requires an inventory account and matching inventory currency. A future account must therefore have **SAR actually enabled**, then its suitability/selectability and currency must be verified through the Group selector/reloaded record. The blank chart grid's SAR row alone is insufficient.

### Historical Reference evidence and discrepancy

The earlier isolated Reference experiment is recorded in `MOTAKAMEL_CHART_OF_ACCOUNTS_TEMPLATE_PROVISIONING_QUALIFICATION.md` and its capture artifacts: the official chart initializer changed Account and Account_Cur_Detail from 0 to 225 each; the other 514 fingerprinted tables were unchanged. The later reference inventory account 1141010001 / المخزون was a level-6 subsidiary under Current Assets with SAR and was successfully reused for Group 001.

**Explicit discrepancy:** version-5 help describes the default initializer as principal-level creation followed by manual subsidiaries, whereas the newer observed Reference execution created a chart containing subsidiaries too. Prefer that actual execution for what happened in Reference; do not predict the Host initializer's exact account count or contents from either description. Nothing was initialized on Host. Neither the reference identifier nor rank 6 is a mandatory Host naming/structure decision.

### Route comparison and bounded conclusion

| Route | Prerequisites / evidence | Expected mutation surface if separately authorized | Decision |
|---|---|---|---|
| Chart → individual Add | Current entry point present; documented parent/type/rank/currency rules; actual Save validation untested | One account and its enabled currency links per save, plus separately approved necessary ancestor accounts if absent; exact storage effects unqualified | **Preferred narrow candidate**, not ready-to-execute qualification |
| Chart → Create default chart | Current button present; help restricts to empty initial chart; Host chart is empty | Whole default hierarchy/currency links; Reference produced 225+225, Host result unknown | Wider optional alternative, not an established requirement |
| Chart → Excel import | Current icon + old help; compatible workbook and empty chart documented | Accounts/hierarchy/currencies represented by import; exact importer effect and one-row support unqualified | No demonstrated advantage over individual Add; do not prepare/import data automatically |
| Options → Data initialization / broader provisioning | Data-initialization surface visible, not opened; no current causal prerequisite evidence | Unknown and potentially broader | Not recommended or qualified; FMMA provisioning was not explored/executed |

**One account versus bootstrap:** the individual-entry route is officially available and a full template/provisioning step is **not proven mandatory**. However, the Host has no existing parent accounts. The documented lower-level account procedure therefore cannot simply reuse a parent, and a single standalone inventory subsidiary without ancestors has not been qualified. The narrow solution may require a minimal approved ancestor chain plus one SAR-enabled inventory subsidiary; its exact count, codes, levels and classifications must not be invented from Reference. Current options do not establish a forced level-6 chain. Runtime type/filter/Save requirements remain unresolved without separately authorized bounded qualification.

**Safest next action:** obtain an explicit operator/vendor-approved minimal inventory-account hierarchy and a separate authorization for its bounded official individual-account workflow; if necessary, inspect its Add/lookup behavior without saving first. Do not execute a full chart initializer, change account options or open Account Numbering merely to unblock discovery. Account Numbering remains outside the critical path; no UI evidence in this task reinstates it. Stop before any account/Unit/Group/Item mutation. No S0b/S1/S2/S3 execution, connector/Canonical Model expansion or pilot qualification follows.

### Capture handling and final state

GL_New opened as a separate accounting module. Two accounting dashboard windows/processes were subsequently observed after the initial navigation click and a later double-click; delayed navigation is a possible explanation, not a proven cause. Both GL_New tokens were Medium / RID 8192, non-elevated, UIAccess=false, user/session 23. A module approval read first timed out, then later reads succeeded; no approval UI was automated. Initial screenshots were black despite an accessibility tree. A tree-derived tab click failed with `coordinate input geometry is unavailable`; the supported, freshly observed secondary action **Raise** on the accounting window then produced a correct dashboard capture. This is an operational observation, not a security change or general fix.

The temporary accounting ribbon also reproduced `window crop is outside captured monitor`. Fresh selection, Escape and a screenshot-derived header double-click expanded/pinned the application's ribbon; subsequent chart/options captures worked. No monitor/scaling/compatibility/security changes were made. UIA clicks in inventory also failed as unavailable in cached state; fresh screenshots, not stale indexes, were used afterward. Both inventory/account options and the chart were exited unchanged; HTML Help was closed. Accounting/inventory dashboards remain available, with windows maximized and ribbons expanded. The extra accounting instance was not force-terminated. No account or other ERP record was created, edited, saved, deleted, posted or approved; exact Account/currency counts remain zero in the concluding SELECT.

## Host minimum-account hierarchy discovery — no mutation

This follow-up continued from the preceding local route-discovery changes; it did not repeat template/provisioning investigation. The required project context was reread, and the build checkout remained clean at local HEAD 0fb18e982e90ae09b5e68f306c406ee97a7f29ff. That is a local repository observation, not new remote-main/CI evidence. No architecture, Canonical Model, connector scope, Pilot #001, dataset scenario or account naming scheme was changed.

### CURRENT-UI PROVEN

- Fresh Sky enumeration selected the existing accounting window 95554874 / GL_New.exe and inventory window 7668528 / inv.exe. The official paths remain **إدارة الحسابات → المدخلات → دليل الحسابات** and **إدارة المخزون والجرد → المدخلات → بيانات المجموعات**. Only view-mode forms were opened. No Add/Edit/Save, value entry or provisioning was performed.
- The empty chart exposes a separate **نوع الحساب** lookup and other account/rank/classification controls. The relevant combo boxes and currency group were disabled in view mode. One click on the visible account-type arrow produced no lookup or options; it does not prove that the dictionary is mandatory, empty in Add mode, or that main/subsidiary options are unavailable there. The blank parent display initially showed 1 and later was blank; neither display establishes a valid saved root or parent. Main/subsidiary status must not be conflated with the separate account-type lookup or classification field.
- The Group inventory-account field and the other group account fields were explicitly disabled in the fresh accessibility state. No usable account picker was exposed in this unchanged view. No F9 invocation, Add mode or Group save was attempted. Accordingly, no current selector filter was tested: neither its accepting principal accounts nor its restricting to subsidiaries, a rank, account type, classification or stop/currency status is proven.
- SAR availability and the unchecked fixed-subsidiary-rank/automatic-number settings are the immediately preceding current-UI observations, not new Save qualification. The form's unchecked SAR activation row is still a blank-form display, not an enabled account currency. Inventory currency SAR does not alone establish the entity-local currency inherited by a principal account.
- The chart and Group were closed unchanged to their dashboards. Maximizing the application windows was presentation-only; no Windows display/security/configuration setting was changed. This follow-up did not reproduce the crop error or establish a general capture fix.

### Bounded read-only metadata — not UI validation

A SELECT/catalog-only query against Host `.\YSEDU` / EFA12026 at **2026-10-06T22:28:33.2915896+03:00** returned **Account=0, Account_Cur_Detail=0, i_group=0**. No SQL business write or permission/configuration change occurred.

Within these three tables, the inspected catalog returned no CHECK constraints. Account.A_Parent, A_Level, a_s_m, ac_type and ClassType are nullable; no foreign key on Account.A_Parent was returned. Account_Cur_Detail has enabled foreign keys to Account and ex_rate. The Group account-reference foreign keys returned by the query reference Account.a_code, including g_a_code; these foreign keys alone do not impose rank/type/currency eligibility. No new semantic mapping from column names is promoted by this metadata.

**Limit:** nullable columns, absence of a CHECK/parent foreign key, and simple account-reference foreign keys are not permission to insert arbitrary values and do not prove what Motakamel accepts. Client-side Save logic, selector logic, triggers/procedures and additional application conditions were not qualified. No source-code/binary reverse engineering or broad schema investigation was undertaken. Existing records were not available to discriminate between competing structures.

### HELP-DOCUMENTED versus REFERENCE-LAB HISTORICAL

Installed version-5 chart help `/1801.htm`, already read in the route investigation, documents parent **0** for a first-level **main** account, a previously defined parent for lower accounts, and child rank derived from parent rank. It distinguishes principal hierarchy accounts from terminal subsidiary accounts used directly in operations. It documents at least one activated currency for a subsidiary and the entity-local currency for principal accounts. Report selection and specialization are described; a complete current minimum required-field list is not established. Account-group membership is explicitly optional in the detailed help. Group help `/3201.htm` requires an inventory account and matching currency, but does not establish the current selector's complete filter.

No fixed count of intermediate principal levels was established by that documentation. The narrow hypothesis is therefore **one root/main with parent 0 → one direct operational subsidiary with SAR activated**, without copied codes/names or manually forced ranks. This is a **two-account candidate to test**, not a proved minimum, accepted Host structure, or accounting-design approval. The terminal-subsidiary description does not itself prove that a subsidiary can be a direct child of a root, nor exclude a one-node operational root if a newer workflow permits it.

Reference's accepted level-6 subsidiary 1141010001 and its ancestor chain remain **REFERENCE-LAB HISTORICAL**. They do not prove that Host requires six levels, those identifiers, the same classification, or a default chart. The earlier help/template discrepancy remains as recorded above. No Reference hierarchy was copied or entered on Host.

### UNRESOLVED and smallest next experiment — NOT EXECUTED

The smallest **currently proved executable hierarchy is not known**. Still unresolved: runtime acceptance of root parent 0; eligible root main/subsidiary choices; direct-child subsidiary acceptance and derived ranks; entity-local currency/inheritance; mandatory account type/report/classification/nature and exact first Save validation; and Group picker eligibility beyond documented currency matching. A full chart, Account Numbering and fixed rank 6 remain **not proven prerequisites**. No one-account or two-account solution is declared ready.

The narrowest next evidence step is separately authorized **unsaved Add-form inspection**, first for the root's parent/main-subsidiary choices and generated rank, then cancellation; no speculative values or Save. This was not performed under the current view-mode investigation. If that does not resolve actual acceptance, propose the following separately authorized discriminating mutation, not an automatic next action:

1. Establish an actually reversible test boundary: an isolated disposable working copy matching the Host application/database/options, with a verified restoration/rollback procedure. The existing Host backup passed VERIFYONLY, but isolated restoration/application recovery was not performed; do not call an in-place Host experiment reversible merely because that backup exists. No clone, restore or rollback was performed here.
2. Obtain operator/vendor-approved exact identities and accounting classification; do not generate account numbers, parent names, type codes or arbitrary report/nature values. Confirm entity-local currency and the available SAR activation mechanism without changing currency setup.
3. If current unsaved form behavior supports only the documented root-main route, save **one root/main with parent 0**, once, using the form's derived rank. Reload it. On first rejection, capture the exact message and stop: do not add guessed fields, ranks or intermediate parents.
4. Save **one direct subsidiary under that root**, once, with SAR actually activated and the form-derived rank; reload and reconcile the two records/currency links. No balance or transaction. A first rejection is evidence against that exact candidate, not authority to build a deeper chain or initialize the chart. If the root form instead explicitly permits an operational root, test that one-node alternative first under a revised predeclared experiment; do not assert two nodes are globally minimal.
5. Inspect/select the saved candidate in the Group Inventory Account picker on an unsaved temporary form, then cancel without saving a Group. Visibility/selection would qualify that picker behavior only; it would not prove Group Save or later inventory/accounting correctness. Restore the independent test boundary under its separate authorization.

This experiment distinguishes a supported direct-child route from a forced deeper/restricted route without creating a full chart. Success would prove the tested small structure in that profile, not global minimality, production accounting correctness or every possible selector filter. No Unit/Group/Item, S0b/S1/S2/S3, template/import/initialization, account option, SQL write or ERP mutation was performed. **DISCOVERY COMPLETE — MINIMUM VALID HIERARCHY / SAVE AND PICKER ACCEPTANCE UNRESOLVED. STOP before mutation.**

## Host non-saving Add inspection — 2026-10-07

The user expressly authorized Add-form inspection, temporary cancellable values only where needed, and Cancel followed by read-only zero-count verification. All 12 required project-context documents were refreshed before native UI work. The build checkout was clean; no implementation change or new connector/Canonical Model decision was made.

### CURRENT-UI PROVEN — draft behavior, not Save qualification

Official path: **إدارة الحسابات → المدخلات → دليل الحسابات → إضافة**. Fresh Sky enumeration selected the existing GL_New.exe window 95554874; no new accounting process was launched. The application was maximized for presentation only, not by changing Windows display/security settings. Add was entered once.

| Field/control | Observed behavior in this unsaved Add |
|---|---|
| Parent/main reference | Initially blank in Add, unlike the historical empty-view display of 1. The only typed test text was `0` here. Tab generated rank 1 without a validation dialog. No existing parent can be tested while Account=0. |
| Account number; Arabic/foreign names | Blank; no number/name was typed or generated. A click on the visible right-hand ellipsis next to the number produced no observed lookup/value; its full semantics and number-entry/format rules remain unresolved. |
| Rank | Initially blank; after parent 0/Tab it was 1. Accessibility exposed the rank edit without a settable flag, unlike the parent/name fields. No rank was manually changed. |
| **نوع الحساب** | Current popup explicitly shows **1 رئيسي / 2 فرعي**. Each was temporarily highlighted then left with Tab; stable accessibility values 1 and later 2 corroborated selection. Parent remained 0/rank 1 even with subsidiary in the unsaved draft; this is NOT acceptance of a one-node operational root or direct saved child. |
| Principal currency | After principal selection a separate read-only **العملة: SAR** control appeared, and the grid child pane was reported disabled. This is current principal-draft currency evidence, not a persisted currency link. |
| Subsidiary currency | The separate principal-currency control disappeared; the SAR / Saudi Riyal activation checkbox could be checked. A fresh screenshot with the pointer moved off the cell showed its blue check. Limits remained blank; currency stop remained unchecked. No Account_Cur_Detail row was saved. |
| Report | A custom list offered **الربح والخسارة** and **الميزانية العمومية**. No report choice was deliberately assigned. Escape did not reliably dismiss this custom list; focusing another visible control did. |
| Group | Opened as a blank dropdown with no named choice visible. A transient numeric 1 appeared during browsing; no valid saved group or required membership is inferred. |
| Linked-account control labelled الحساب | Its list included other/assets/salaries/cash-flow/banks/customers/suppliers/inventory-groups/intermediate-accounts/payment-channels categories. No category was deliberately chosen as inventory-account semantics. |
| Separate نوع combo | Offered **1 تشغيلي / 2 استثماري / 3 تمويلي**. These are distinct from principal/subsidiary; no saved flow-type meaning is inferred. |
| تصنيف | Visible choices included fixed/current assets, shares, cash cover, fixed/current liabilities, sales and sales cost. Only the visible portion was inspected, not every scrolled entry; no classification was deliberately assigned. |
| التحليل | Visible enabled combo in Add; one arrow click did not expose a readable option list. Available values and any requirement remain unresolved. |
| Nature / stop / TDS | Initial Add displayed debit selected, TDS unchecked and account stop unchecked. After browsing, credit was visibly selected; no debit/credit radio was clicked, and the exact causal control event is unresolved. These later draft changes are not initial defaults or approved accounting semantics. Stop enablement varied with principal/subsidiary state; the parent group and child accessibility flags were not entirely consistent. No stop/TDS toggle was made. |
| Save / Cancel / other surfaces | Save and تراجع enabled in Add; Add/Search/Edit/Delete disabled. Template/Excel controls were visible but never invoked. No Save/Accept or save shortcut was used. |

**Material correction to the earlier evidence:** the view-mode inference that the separate account-type lookup must not be identified with principal/subsidiary was not established by that view. Current Add proves that this very lookup offers principal/subsidiary. The preceding `account_types=0` table observation therefore must not be used to infer absence of these UI choices or a missing mandatory type dictionary. Earlier sections are historical observations, superseded here where inconsistent.

Opening ordinary combos displayed numeric first entries and, during some immediate captures, temporarily blanked other fields; subsequent observations were used before conclusions. Those effects were not promoted into a stable default-value or causal mapping claim. No account names/numbers were needed, so none were entered. No field-marker or non-saving action established the complete mandatory Save-field list. The red currency heading alone is not a Save-validation result. No current validation dialog rejected parent 0/type selection; no Save validation was elicited.

### Cancellation and read-only reconciliation

Cancel **تراجع** opened **هل تريد التراجع**. The first attempted confirmation using the parent-window screenshot did not dismiss the separately owned modal; it brought/restored the disabled parent to the foreground. A fresh enumeration identified dialog 4263268. Its initial capture was occluded; activating that returned dialog produced a matching capture/tree, then its visible **نعم** button discarded the unsaved draft. This was not deletion of a saved record. The final fresh chart state had blank draft values and disabled Save/Cancel, with Add/Search enabled.

SELECT-only checks against Host `.\YSEDU` / EFA12026 returned:

| Observation, local +03:00 | Account | Account_Cur_Detail |
|---|---:|---:|
| 2026-10-07 05:34:32, before Add | 0 | 0 |
| 2026-10-07 05:40:31, after confirmed Cancel | 0 | 0 |

No account/currency record exists as a result of this inspection. No Group/Unit/Item form was opened in this follow-up, no Controlled Dataset work or S0b/S2/S3 began, and no options/template/import/initialization/Account Numbering or SQL write occurred. The crop error did not recur here; that is not a general fix claim. No VM/security/permission/configuration change was made.

### HELP-DOCUMENTED / REFERENCE-LAB HISTORICAL / UNRESOLVED

The previously read version-5 help documents root-main parent 0, existing parent for descendants, derived child rank, principal local currency and at least one enabled subsidiary currency. Today's unsaved root/rank/type/currency behavior supports parts of that description, not its Save rules. Reference's saved level-6 account and hierarchy remain historical only; no Reference number or structure was entered.

Still UNRESOLVED: actual root Save acceptance and mandatory fields; direct subsidiary Save under a saved rank-1 root; derived child rank (expected 2 from help, not observed); accepted account-number format/number-control behavior; report/classification/flow/nature requirements; root currency-link persistence; and the Group inventory-account selector's eligibility rules. A full chart, fixed rank 6 and Account Numbering are not proven prerequisites. Draft subsidiary at parent 0 does not prove a one-node alternative. **No smallest SAVED valid hierarchy has been proved.**

### Historical next discriminating mutation proposal — unexecuted at inspection time

The user's requested two-node candidate can be predeclared with **neutral TEST identities**, not operational inventory semantics:

| Planned record | Proposed code, not yet format-qualified | Arabic name | Parent / type / currency |
|---|---|---|---|
| Test root | 970701 | DBL_TEST_MAIN_20261007 | 0; 1 رئيسي; form-derived rank (1 observed in draft); SAR as displayed by principal form |
| Test direct child, only after root save/reload succeeds | 97070101 | DBL_TEST_CHILD_20261007 | saved 970701 directly; 2 فرعي; leave derived rank untouched; activate SAR only |

Foreign names, group, report, linked category, flow type, classification, analysis, limits and stop/TDS remain unset/unchanged where the new form allows it. Initial nature/defaults must be freshly recorded before any Save, not copied from the altered cancelled draft. No accounting classification is invented to force acceptance. If identity entry or a non-saving validation rejects the declared values, stop before Save; do not adjust numbers speculatively. If a mandatory semantic choice is exposed before saving, obtain a separate exact decision rather than guessing. These proposed codes/names are test labels, not a new chart/naming architecture or approved production inventory-account classification.

Before the first Save: obtain separate explicit approval for the exact two records and their recorded complete forms, and qualify recovery. The current physical Host is protected, and the existing COPY_ONLY/CHECKSUM backup's VERIFYONLY success is not a demonstrated restore/application rollback. Prefer a separately authorized independent working copy with the same profile and an actually tested restoration path. An in-place alternative needs a fresh verified backup plus separately authorized isolated restore/application verification and a pre-agreed restoration boundary; neither is performed now. Automatic UI deletion of child/root is not promised as complete rollback because deletion constraints/audit side effects have not been qualified. Any restoration remains separately authorized, never an automatic SQL business edit or security change.

If recovery/approval gates are met, attempt Save **once per declared record**, root first; reload and verify code/name/parent/type/rank/currency before proceeding. Capture the exact **first** validation and stop, with no guessed field, retry, third level, template or configuration change. Reconcile the two saved logical records and their actual currency links read-only; do not assume exactly two currency-detail rows before observing the principal's persistence behavior.

Only after both records exist, separately approve an **unsaved** Group Add/picker inspection: candidate code must be visible and selectable in Inventory Account and expose SAR compatibility; then Cancel, verify Group count unchanged. No Group Save, Unit/Item or S0b/S2/S3. Picker selection qualifies that behavior only, not Group Save, a globally minimal hierarchy, accounting correctness or purchase/inbound semantics. A first blocker ends the experiment rather than causing deeper hierarchy creation. **STOP before first Save and request approval for the recovery/experiment boundary.**

## Host database RestoreProof — 2026-10-07

Following separate authorization, the existing backup above was restored at **05:55:37+03:00** to **DBL_HOST_W11_EFA12026_RestoreProof_20261007**, database ID **9**, with independent MDF/LDF under the existing SQL DATA directory. Logical files EFA12026 / EFA12026_log were moved to `DBL_HOST_W11_EFA12026_RestoreProof_20261007.mdf` / `DBL_HOST_W11_EFA12026_RestoreProof_20261007_log.ldf`. FILE=1, CHECKSUM, STOP_ON_ERROR, RECOVERY and MOVE were used; no REPLACE, source overwrite, REPAIR, permission or security change. SQL reported successful restoration of 2757 pages (2752 data / 5 log). Source EFA12026, ID 7, stayed ONLINE on C:\EFA\EFA12026.mdf / .ldf; no shared physical path was found.

Full `DBCC CHECKDB` at **05:56:08+03:00**, without repair or PHYSICAL_ONLY, reported **0 allocation errors and 0 consistency errors** for the proof database. Bounded comparisons showed 516 user tables, 194 views and 188 procedures in each database, and zero Account, Account_Cur_Detail, Measure, i_group, item_detail and item_mov rows in both. This is not full row/byte equivalence proof. Final metadata at 05:56:44 showed the proof ONLINE with two independent files, no active user session on it, and msdb restore_history_id **4**, backup_set_id **1011**, replace=false, recovery=true. It was left in place; no cleanup/drop was authorized.

**DATABASE RESTORE PROOF PASSED — ERP ROLLBACK NOT YET QUALIFIED.** No application connection to the proof database, support-database restoration, whole-host recovery or UI rollback was tested. The physical backup SHA-256 remains the previously supplied manual administrative result, not a fresh agent filesystem hash. The user explicitly accepted this bounded database recovery evidence for the following experiment; the older fresh-backup/full-application-recovery proposal is not an additional automatic gate for this accepted scope. Actual source restoration would still require separate authorization.

## Host authorized two-account experiment — first validation stop — 2026-10-07

The user approved root **970701 / DBL_TEST_MAIN_20261007**, then conditional direct child **97070101 / DBL_TEST_CHILD_20261007**, with no third level, guessed accounting choice or retry. All 12 mandatory Product Memory documents and current Computer Use guidance/API/confirmations were refreshed. The build checkout remained clean at local HEAD 0fb18e982e90ae09b5e68f306c406ee97a7f29ff; no new implementation/remote-CI claim is made.

### Pre-mutation verification and accepted recovery boundary

SELECT-only at **06:18:56+03:00** confirmed physical Host **DESKTOP-8QRQT7R\YSEDU / EFA12026 / database_id 7**, ONLINE, the same source paths, **Account=0, Account_Cur_Detail=0, i_group=0**, and zero matches for the two codes. Zero Account rows also excludes either approved name. Current GL PID **30180**, inv PID **66628**, and General Ledger PIDs **47216 / 62836**, all in session 23, each matched current EFA12026 application SQL sessions. Support sessions remained distinct. Backup set 1011 retained COPY_ONLY/CHECKSUM and UUID e6d6c875-12c6-4824-865b-687247ad8050; isolated RestoreProof ID 9 and restore history 4 remained present/ONLINE.

No material change was observed in the experiment-relevant baseline. This was a bounded pre-check, not a fingerprint of every setting/table or an atomic live snapshot. Per the user's instruction, the accepted baseline backup + RestoreProof was reused; no redundant backup, checkpoint or restore was performed.

### CURRENT-UI PROVEN — one root attempt, not a saved account

Official path: **إدارة الحسابات → المدخلات → دليل الحسابات → إضافة**. Fresh enumeration selected existing GL_New.exe window **95554874**. It was activated and maximized for presentation only; matching fresh captures preceded each input. Add was entered once. No app launch/elevation or Windows setting change occurred.

- Parent **0** followed by Tab generated read-only rank **1**.
- Manual number entry displayed **970701**. The first/top name field displayed **DBL_TEST_MAIN_20261007**; second/foreign name stayed blank. This proves draft input only, not accepted number format/persistence.
- Lookup **1 رئيسي** was selected and applied with Tab. Accessibility confirmed type 1 / parent 0 / rank 1. The principal form displayed read-only local currency **SAR**, with currency-grid child disabled.
- Report, group, linked category, flow type, classification, analysis and limits remained visually blank; no report choice was assigned. TDS/account stop were not toggled. Fresh Add initially showed credit selected; later captures after principal-type application showed debit selected without an explicit nature click. These are not a stable initial-default rule or accounting-design approval; exact internal cause was not investigated.
- The automatically exposed report popup showed profit/loss and balance-sheet choices. Focusing the name area dismissed it without assigning a report. The complete pre-Save capture showed the approved identity, parent/type/rank/SAR and blank report.
- **One** screenshot-derived Save click at **(1885,394)** opened GL_New dialog **5113684**, title **نـظـام الـمــحاسـبة الـمــالية**. Direct fresh capture/accessibility agreed on **`ادخل التقرير الذي يجب ان يظهر فيه الحساب`**.

Report selection is therefore required for this current root Save candidate. This does not establish the correct report, every later mandatory field, direct-child acceptance or number-format acceptance. The message was not dismissed; no additional input, semantic selection or Save retry followed. The unsaved root draft and first-validation dialog were left visible. No child or Group form was opened.

### Post-validation reconciliation and separate classifications

SELECT-only at **06:21:30+03:00** returned **Account=0, Account_Cur_Detail=0, i_group=0, Measure=0, item_detail=0**. Queries by both exact codes and both exact names in a_name/a_name_eng returned zero rows; currency-link queries for both codes also returned zero rows. No Account or Account_Cur_Detail row was persisted by this rejected Save. No successful record existed to reload.

| Claim | Result | Limit |
|---|---|---|
| Root Save | **BLOCKED — required report validation** | Exact blank-report candidate rejected on first attempt; not proof that root parent 0 is unsupported. |
| Direct Child Save | **UNRESOLVED / NOT ATTEMPTED** | Saved/reloaded/verified root prerequisite was not met. |
| SAR binding | **UNRESOLVED for persistence** | Principal draft displays SAR; earlier subsidiary draft activation was observed, but zero currency links exist. |
| Inventory Group eligibility | **UNRESOLVED / NOT ATTEMPTED** | No saved child to test. Group count remains 0; no Group Add/Save. |

No Unit/Group/Item or inventory movement was created. No S0b/S1/S2/S3, SQL business write, Account Numbering, chart template, import, initialization, third account, VM/configuration or security change occurred. SQL was SELECT/catalog evidence only in this experiment. The crop error did not recur; no general capture fix is claimed. These are current Host workflow observations, not LAB-PROVEN canonical mapping, PARTNER-VALIDATED or PILOT-QUALIFIED capability.

**Safest next action:** obtain an explicit justified report choice for the neutral root test and separate approval for another attempt, or separately authorize report-field-only discovery to establish that choice. Do not silently assume balance sheet, assets/current-assets classification or inventory specialization. Preserve the validation evidence; do not retry or expand the hierarchy to evade it. No database rollback was needed or executed because the inspected account/currency tables remained empty. **STOP.**

## Host report-field-only discovery — 2026-10-07

The user authorized narrow discovery only: no report assignment, Save/retry, child, Unit/Group/Item or S0b/S2/S3. All 12 mandatory context documents were reread. Historical sequencing in AI_HANDOFF/CURRENT_STATUS/ROADMAP does not replace the later controlled-dataset strategy or current Host gate. The build working tree remained clean; no implementation claim or architecture change was made. The current Computer Use skill and guidance/API/confirmation documents were read; all UI work used node_repl -> @oai/sky.

### CURRENT-UI PROVEN

Fresh enumeration found the existing validation modal 5113684 and chart window 95554874, both GL_New.exe. The modal still said `ادخل التقرير الذي يجب ان يظهر فيه الحساب`. Its **موافق** button was acknowledged once to dismiss that message, not to save/accept an account. The chart then automatically exposed the report list with exactly two observed choices: **الربح والخساره** and **الميزانية العمومية**. No row was selected. Focusing the existing name field closed the list without changing its text or assigning a report.

The preserved draft still displayed number 970701, name DBL_TEST_MAIN_20261007, parent 0, main type 1, derived rank 1 and local currency SAR. Report, classification, linked category, flow type and analysis remained blank. The nature radio visibly showed credit in these captures; earlier captures varied without a deliberate nature click. This is not a stable default, a report-induced effect or an approved accounting choice. No type/nature/classification was changed in this task. No report-selection dependency was experimentally triggered, because choosing a report was deliberately avoided.

F1 opened the installed chart help. It was read through its UI, scrolled, and closed normally. Final fresh chart capture showed the same unsaved identity and blank report; no Cancel/discard or additional Add occurred. No crop failure was reproduced here; that is not a general fix claim.

### HELP-DOCUMENTED — installed official version 5, not current Save validation

Source: `C:\EFA\EFAHELP.chm::/1801.htm`, الدليل المحاسبي, opened directly by F1 from the draft.

| Report | Meaning documented by Motakamel |
|---|---|
| ميزانية عمومية | For balance-sheet accounts, with assets/liabilities as examples; their balances carry to the new accounting period as opening balances. |
| أرباح وخسائر | For profit/loss accounts, with expenses/revenues as examples; these accounts close at financial-period end into profit/loss. |

Thus report is not merely an arbitrary screen label. The help connects it to annual reporting and carry-forward/closing treatment. Those operations were not executed or independently reconciled on Host.

The same help describes principal/subsidiary type separately from report, and does not state that either type uniquely determines one report. It documents inheritance for **الحساب مرتبط** specialization: linking a main account propagates that link to descendants. That sentence is NOT report-inheritance documentation. No explicit rule for report inheritance, automatic debit/credit selection or required classification/flow type was found in the relevant chart instructions. The help's financial nature wording must not be conflated with the separate debit/credit radio or ClassType field. No claim that omitted fields are optional at current Save is made.

### Current Host read-only metadata/logic

SELECT/catalog inspection at 06:38:58+03:00 used existing integrated Windows authentication against DESKTOP-8QRQT7R\YSEDU / EFA12026, without changing permissions, settings or data. Account.A_Report is nullable nvarchar(40), while a_s_m, Dr, ClassType and CashFlowType are separate columns. Nullable storage does not override the observed required-report client validation. No Account CHECK constraint was returned.

Definitions were read, NOT executed, for the report-specific function and three report views:

- `dbo.Get_Account_Rep_Type` reads this account's A_Report: literal `Balance Sheet` maps to return 1; its ELSE maps to 2, commented Expenses And Revenues. It does not read the parent, classification or Dr. The broad ELSE is not evidence that a blank/unknown report is a valid Save choice.
- `GetProfitAndLoss_Mob`, `GetProfitAndLossDetails_Mob` and `V_Acc_MonthBalanceChart` explicitly filter `A_Report='Profit And Loss'` and subsidiary discriminator `a_s_m=2`. This corroborates distinct persisted report classification and type filters in these specific outputs, not every report or Group selector.

The mapping between current Arabic UI selection and stored strings has not been demonstrated by a Host Save. No posting/closing procedure, financial operation or SQL business write was executed. No broad module/schema investigation followed.

### REFERENCE-LAB HISTORICAL — actual preserved rows, no live VM action

Read-only evidence: workspace `outputs/motakamel-chart-template-provisioning-01/POST-TEMPLATE-capture.json`, captured 2026-09-04T07:15:03.5178295+03:00 from DESKTOP-NTPS04J\YSEDU / EFA12026, database GUID DDC085C5-A048-4844-9668-759A63E630C5. Observer was DBLlab, not FMMA; artifact records read-only observer/no SQL writes. Fresh artifact SHA-256 matched the previously recorded hash: `12F07A6B98451E19712EFDE32FB1B9E66C73664C7A535A67CCB704CEA1BA1693`. Account projection was capped at 100 rows; all six needed records were present and the chain was followed by stored A_Parent, not number-prefix guessing.

| Account | Stored name | Parent | Level | a_s_m | A_Report |
|---|---|---|---:|---:|---|
| 1141010001 | المخزون | 114101 | 6 | 2 | Balance Sheet |
| 114101 | المخزون العام | 1141 | 5 | 1 | Balance Sheet |
| 1141 | المخزون السلعي | 114 | 4 | 1 | Balance Sheet |
| 114 | المخزون | 11 | 3 | 1 | Balance Sheet |
| 11 | الاصول المتداولة | 1 | 2 | 1 | Balance Sheet |
| 1 | الاصول | 0 | 1 | 1 | Balance Sheet |

All six rows have Dr=true and ClassType/CashFlowType/ac_type=null. This is evidence of the official historical template's stored inventory-route choices, not proof of manual Add requirements, automatic inheritance, Host optional fields or an obligatory six-level structure. The earlier template report also reconciled another balance-sheet subsidiary's UI label with stored `Balance Sheet`; the inventory row itself is the bounded historical SQL projection above. No VM was started, connected or modified; no historical account structure was copied into Host.

### ACCOUNTING INFERENCE, recommendation and UNRESOLVED

General accounting knowledge that inventory is an asset is not the sole basis for the decision. **Propose الميزانية العمومية for the neutral root test** because Motakamel's installed documentation explains its balance-carrying semantics, the official Reference inventory route stores Balance Sheet at the operational account AND every ancestor, and current Host definitions retain a distinct report classification. This is sufficient justification for a separately approved discriminating TEST choice, not production chart design, proof that Group requires this report, or a claim that profit/loss is rejected by its selector. The approved TEST identities remain unchanged; no assets name/code or additional level is introduced.

Still UNRESOLVED: current report inheritance to a direct child; report-selection effects on classification/type/nature; subsequent mandatory Save fields; root/direct-child save acceptance; SAR persistence; and Group eligibility. Historical null classification values and separate SQL fields do not prove that choosing report leaves every current UI field unchanged. A future separately authorized attempt should capture the actual before/after selection and stop at any newly exposed prerequisite or first validation, without guessing classification/nature/linkage or adding levels. No child follows unless root Save/reload/verification succeeds under its own approval.

Final SELECT at **06:40:40+03:00** returned **Account=0, Account_Cur_Detail=0, i_group=0, Measure=0, item_detail=0**; both approved codes were absent. Existing GL/inv/General Ledger PIDs again matched EFA12026 sessions. This is bounded no-persistence evidence, not a global atomic database fingerprint. The draft remains open with report blank. **REPORT CHOICE JUSTIFIED FOR PROPOSAL — SAVE / INHERITANCE / GROUP ACCEPTANCE UNRESOLVED. STOP before report selection or Save.**

## Host approved Balance Sheet root-only Save and reload — 2026-10-07

This later section supersedes the earlier report proposal / unset-report rejection only for the exact authorized root. The user approved choosing Balance Sheet in the preserved draft, documenting its immediate effects, and attempting Save once. Child was expressly withheld even on success. All 12 mandatory Product Memory documents and current Computer Use skill/guidance/API/confirmations were reread. The build checkout remained clean at local HEAD 0fb18e982e90ae09b5e68f306c406ee97a7f29ff; no new implementation, remote-main or CI claim follows.

### Pre-check and BEFORE → AFTER report selection

SELECT-only at **07:07:26+03:00** verified DESKTOP-8QRQT7R\YSEDU / EFA12026 / database ID 7, Account=0, Account_Cur_Detail=0 and i_group=0, with neither approved code/name present. Current Motakamel PID 30180, Inventory System PID 66628 and General Ledger PIDs 47216 / 62836 matched EFA12026 sessions; support-database sessions remained separate. The experiment-relevant baseline had not materially changed. The accepted baseline backup + RestoreProof boundary was reused without additional backup, restore or checkpoint.

Fresh Sky enumeration selected existing GL_New.exe chart window **95554874**. The intact draft was observed, then its window was maximized to expose all fields (presentation only). All native UI actions used node_repl → @oai/sky, fresh returned window objects and current screenshots; no VMConnect input, application launch, elevation or Windows configuration change occurred.

| Field | BEFORE | AFTER applying report selection |
|---|---|---|
| Account number / Arabic name | 970701 / DBL_TEST_MAIN_20261007 | Unchanged |
| Parent / principal-subsidiary type / derived rank | 0 / 1 رئيسي / 1 | Unchanged |
| Report | Blank | الميزانية العمومية |
| Foreign name / group / linked category / flow type / classification / analysis / limits | Visually blank | Remained visually blank |
| Nature | Credit selected | Credit remained selected; no nature action |
| Principal local currency / currency activation | SAR displayed; grid child disabled and activation unchecked | Unchanged |
| TDS / account stop | Unchecked; account stop disabled | Unchanged |

The report field was clicked at (459,432), then the freshly displayed **الميزانية العمومية** row at (463,470). The immediate observation showed that row highlighted while the custom list remained open. One **Tab**, not Enter/Save, applied the displayed report and moved focus. No other immediate visible value change or new blocking requirement appeared. This is one observed before/after case, not a general absence-of-side-effects, report-inheritance or nature-default rule. No classification, nature, flow or linked category was filled or corrected.

### One Save, independent reload and exact persistence

One fresh-screenshot **حفظ** click at **(1885,394)** returned the form to view mode: Save/Cancel disabled, Add/Search/Edit/Delete enabled, and the account tree populated. No validation or completion dialog appeared in the observed response; Save was not repeated. The immediate keyed SELECT at **07:10:00+03:00** returned one Account row, zero Account_Cur_Detail rows and no child, Group, Unit or Item.

For independent UI reload, the chart form alone was closed via its inner close control; the accounting dashboard remained open. **دليل الحسابات** was reopened from the official Inputs ribbon. After the tree populated, the saved **970701 / DBL_TEST_MAIN_20261007** entry was selected in view mode, without Add/Edit. The reloaded UI displayed parent 0, type 1, rank 1, الميزانية العمومية and credit nature; the foreign name, classification, flow and analysis remained blank. It displayed linked category **1-أخرى**, although SQL ac_type was NULL. This display is not evidence that an inventory specialization or a stored linkage was assigned. The SAR grid row was still unchecked; no activated currency was inferred from mere availability.

Final SELECT-only at **07:11:36.2751184+03:00**, after that reload, confirmed the same database and exact row:

| Stored field | Observed value |
|---|---|
| a_code / a_name | 970701 / DBL_TEST_MAIN_20261007 |
| A_Parent / a_s_m / A_Level | 0 / 1 / 1 |
| A_Report | Balance Sheet |
| Dr | false — consistent with the untouched credit radio |
| a_name_eng; A_Tcyf, A_Tcyl, A_tlyf, A_Tlyl, A_Tyblf, A_Tybll | NULL |
| ac_type / ClassType / CashFlowType / FC_Code | NULL |
| cr_limit / dr_limit / lwr_amnt / upr_amnt / AccNote | NULL |
| ac_close / AccountForCustomer / ap_in_tbal / FinishTransfer / FinishUpdate / UseTDS | false |
| TDSType / u_id / Flags_No / Doc_Serial / CrtdBy | 1 |
| CrtdOn / CrtdByComputer | 2026-10-07 07:09:25.577 (raw SQL time) / DESKTOP-8QRQT7R |
| MdfdBy / MdfdOn / MdfdByComputer / MdfdNo | NULL / NULL / NULL / 0 |
| Acc_Sort | NULL in immediate post-Save SELECT → 1 in final post-reload SELECT |

**Acc_Sort caveat:** this changed between two reads around official view-mode reload. No manual field edit, second Save or agent SQL write was sent; no causal trace identifies which internal application operation populated it. Do not claim Acc_Sort=1 was an original Save default or that view-mode navigation causes no storage effects. No corrective write or further investigation was performed. Other inspected Account values matched those reads; the UI audit display showed creation at 07:09:26, recorded separately from raw SQL time rather than silently normalized.

Final scoped counts: **Account=1, Account_Cur_Detail=0, i_group=0, Measure=0, item_detail=0**; the approved child code/name returned zero rows. There are no persisted account-currency rows in this database. The displayed principal SAR is therefore not proof of an activated Account_Cur_Detail binding, and subsidiary SAR behavior remains untested after Save. These are bounded live reads during paused UI intervals, not a frozen snapshot, full-database fingerprint or connector qualification.

### Separate qualification and stop boundary

- **Root Save / reload / keyed persistence: PASSED**, for the exact approved parent-0/main/rank-1/Balance-Sheet candidate. No additional classification/flow/linkage entry was required by this one successful Save; this does not prove global field optionality or production accounting correctness.
- **Direct Child Save: UNRESOLVED / NOT ATTEMPTED.** No child Add was opened, and no third level or copied Reference hierarchy was introduced.
- **SAR binding: principal local-currency display PROVEN; activated persisted currency-link / subsidiary SAR binding UNRESOLVED.** Account_Cur_Detail=0.
- **Inventory Group eligibility: UNRESOLVED / NOT ATTEMPTED.** No Group form/picker/save occurred.

No Unit/Group/Item, S0b/S1/S2/S3, direct/manual SQL business write, backup/restore, chart template, Account Numbering, import, initialization, VM/security/service/permission or Windows setting change occurred. Official application persistence of the authorized root is the intended mutation, not a claim of no database changes. The crop error did not recur; no general capture fix is claimed. No globally minimal hierarchy, LAB-PROVEN canonical mapping, PARTNER-VALIDATED or PILOT-QUALIFIED product capability is inferred. The root was left selected in view mode, not an unsaved draft. **Safest next action: review these root/default/currency limits and obtain separate authorization before any Child Add/Save. STOP.**

## Host approved direct-child Save, SAR binding and unsaved Group picker — 2026-10-07

The user accepted Root Save as PASSED and explicitly deferred investigating/correcting its Dr=false and Acc_Sort observations. Only child **97070101 / DBL_TEST_CHILD_20261007** was authorized, with parent 970701, subsidiary type 2, app-derived rank, justified/inherited Balance Sheet and official SAR activation. One Save only; no third level or guessed accounting fields. Group Add/picker was conditional on verified Child/SAR success and explicitly prohibited Group Save. All 12 mandatory context documents and the Computer Use skill/guidance/API/confirmations were reread. Build checkout remained clean at local HEAD 0fb18e982e90ae09b5e68f306c406ee97a7f29ff; no remote-main/CI or implementation qualification is implied.

### Pre-check and CURRENT-UI PROVEN draft behavior

SELECT-only at **07:24:54.5526915+03:00** confirmed DESKTOP-8QRQT7R\YSEDU / EFA12026 / database ID 7, Account=1, Account_Cur_Detail=0 and Group/Unit/Item=0. Root identity/parent/type/rank/report matched the accepted result; child code/name was absent. Current GL 30180, inv 66628 and General Ledger 47216/62836 again matched EFA12026 sessions. No Root Dr/Acc_Sort investigation or corrective action occurred. The accepted baseline backup + RestoreProof was reused; no additional backup/restore/checkpoint.

All native UI used **node_repl → @oai/sky**, fresh returned windows and matching observations, never VMConnect or a shell input stack. Official route: **إدارة الحسابات → المدخلات → دليل الحسابات → إضافة**, existing GL_New.exe window 95554874. Maximizing the app was presentation-only.

- Fresh Add cleared parent, number, names, type, rank and report; credit was visibly selected, SAR activation unchecked, limits blank. No nature action was sent.
- Setting **Parent=970701**, then **Tab**, automatically produced **Rank=2**, **الميزانية العمومية** and linked-category display **1-أخرى**. This is current observed report propagation in this exact parent case, not a universal inheritance rule or a deliberate linkage assignment. Rank/report were not manually filled.
- Entered the exact approved number/name. Selected the displayed **2 فرعي** row and applied it with Tab. Foreign name, group, classification, cash-flow type, analysis and limits remained blank; stop/TDS were not toggled.
- One click activated **SAR / Saudi Riyal** in the official grid. A subsequent matching capture with the pointer away showed its blue check. Complete pre-Save capture confirmed parent 970701, code/name, type 2, rank 2, Balance Sheet and SAR; no guessed semantic field was entered.

### One Save, independent reload and keyed persistence

One Save click at **(1885,393)** returned the chart to view mode (Save/Cancel disabled); no Save validation dialog appeared. The first post-Save SELECT at **07:30:18.7467904+03:00** returned the child and its SAR row, Account=2, Account_Cur_Detail=1, i_group=0. Raw SQL creation time: **2026-10-07 07:29:44.230**.

The chart alone was closed, reopened from the official Inputs ribbon, and the saved child selected from the newly loaded tree under Root. Independent view-mode reload showed the exact child, parent 970701, type 2, rank 2, Balance Sheet and checked SAR, with zero limits and no currency stop. No Edit or second Save occurred.

Final keyed SELECT at **07:35:51.6208038+03:00**, after Group cancellation, corroborated:

| Stored field | Observed value |
|---|---|
| a_code / a_name | 97070101 / DBL_TEST_CHILD_20261007 |
| A_Parent / a_s_m / A_Level / A_Report | 970701 / 2 / 2 / Balance Sheet |
| Account_Cur_Detail.A_Code / Cur_Code | 97070101 / SAR — exactly one row |
| Currency Suspend_Cur / Default_Cur / Max_Amt / Min_Amt | false / true / 0 / 0 |
| a_name_eng; A_Tcyf, A_Tcyl, A_tlyf, A_Tlyl, A_Tyblf, A_Tybll | NULL |
| ac_type / ClassType / CashFlowType / FC_Code | NULL |
| cr_limit / dr_limit / lwr_amnt / upr_amnt / AccNote | NULL |
| ac_close / AccountForCustomer / ap_in_tbal / FinishTransfer / FinishUpdate / UseTDS | false |
| Dr / TDSType / u_id / Flags_No / Doc_Serial / CrtdBy | false / 1 / 1 / 1 / 2 / 1 |
| CrtdOn / CrtdByComputer | 2026-10-07 07:29:44.230 (raw SQL) / DESKTOP-8QRQT7R |
| MdfdBy / MdfdOn / MdfdByComputer / MdfdNo | NULL / NULL / NULL / 0 |
| Acc_Sort | NULL immediately after Save; 1 in final read — causal explanation deferred |

These are observed automatic persistence values for this child, not accounting approval or globally stable defaults. No nature/Acc_Sort correction or causal investigation was performed. Displayed linked category Other is not a persisted inventory-specialization assignment: ac_type remains NULL. Reads were bounded live SELECTs during paused UI intervals, not an atomic/frozen snapshot or qualified connector acquisition.

### Group picker — selection proven, complete eligibility unresolved; Cancel verified

Official route: **إدارة المخزون والجرد → المدخلات → بيانات المجموعات → إضافة**, existing inv.exe window 7668528. No Group number/name or other account was entered. The **رقم حساب المخزون** field was focused, and F9 opened the official **شاشــــة البحــــث العامه** lookup, window 13635284. Its fresh direct capture displayed exactly the child code **97070101** and **DBL_TEST_CHILD_20261007**; Root was not displayed in this observed result. This is not a complete proof of the selector's filter predicate.

Double-clicking that visible child row closed the lookup and placed **97070101** in the inventory-account field. **Picker visibility and code selection: PROVEN.** The corresponding account-name field remained blank. One Tab was sent for ordinary field-exit behavior; immediate and subsequent observation still showed focus on the inventory-account field and no populated name. No new modal/validation message appeared. The reason and completed acceptance/currency-validation behavior remain **UNRESOLVED**. No additional input or retry attempted to force acceptance; the stop condition was honored.

The child's persisted SAR matches the inventory currency **SAR previously proved in the current Host options UI**. That prior currency observation was not repeated or changed here, and the Group picker did not independently expose a currency column or confirm a completed compatibility validation. Do not equate matching codes plus transferred account number with full Group eligibility or Group Save acceptance.

Cancel **تراجع** opened **هل تريد التراجع عن العملية؟**, fresh inv dialog 97521486. Its observed **نعم** discarded only the unsaved Group draft. Final matching Group capture showed blank fields, Save/Cancel disabled and Add enabled. Final SELECT confirmed **Account=2, Account_Cur_Detail=1, i_group=0, Measure=0, item_detail=0**. No Group was saved; saved Root/Child/SAR remained present.

### Separate classifications and exact next boundary

- **Root Save: PASSED**, accepted prior evidence, not repeated.
- **Direct Child Save / independent reload / keyed persistence: PASSED** for the exact direct rank-2 subsidiary under the saved rank-1 root.
- **SAR binding: PASSED**, active/default persisted currency link plus checked reload.
- **Inventory Group picker visibility and code selection: PROVEN; complete eligibility: PARTIAL / UNRESOLVED** because name/field-exit behavior was not explained and no completed currency validation or Group Save was performed.

This proves the tested two-node Save route, not a globally minimal operational inventory chart. No level 3, chart template, initialization, Excel import, Account Numbering, SQL business writes, Unit/Group/Item Save, S0b/S1/S2/S3, backup/restore, VM, security/permission/service or Windows-setting changes occurred. No historical Reference hierarchy was copied. No LAB-PROVEN canonical mapping, PARTNER-VALIDATED or PILOT-QUALIFIED claim follows.

**Safest next action:** separately authorize narrow non-saving discovery of the selected Group inventory-account field's name/exit-validation behavior for this saved child, using current UI/help and targeted read-only evidence only. Do not adjust account nature/classification/report, create another level, fill unrelated Group prerequisites or attempt Group Save to resolve it. **STOP.**

## Host unsaved Inventory Account picker and field-exit discovery — 2026-10-07

The user authorized only narrow non-saving discovery of why the selected child code did not initially display its name or visibly leave the field with Tab. No account changes, Group Save, other master creation, SQL writes, backup/Restore or scenario execution were authorized. All 12 mandatory current-context documents and the Computer Use skill/guidance/API/confirmation documents were reread. Historical planning/zero-account statements remain historical; newer Host evidence controls this scoped test. The build checkout was clean at local HEAD 0fb18e982e90ae09b5e68f306c406ee97a7f29ff, without a new implementation/remote-CI qualification.

### Pre-check and CURRENT-UI PROVEN sequence

SELECT-only at **07:47:43.631087+03:00** reconfirmed physical Host DESKTOP-8QRQT7R\YSEDU / EFA12026 / database ID 7, Account=2, Account_Cur_Detail=1 and Group/Unit/Item=0. The approved root/child parent, type, rank and report matched the accepted results; MdfdNo=0 and MdfdOn=NULL for both. Child SAR remained Default_Cur=true, Suspend_Cur=false and zero limits. Current GL 30180, inv 66628 and GL_New 47216/62836 SQL sessions again used EFA12026. No permission/configuration or recovery operation was performed.

All native UI used **node_repl → @oai/sky**, with fresh returned targets and observations. Official route: **إدارة المخزون والجرد → المدخلات → بيانات المجموعات → إضافة**. Existing inv window **7668528** was selected from fresh enumeration. It was initially restored; its title bar was double-clicked to maximize it for presentation only. No monitor/scaling/Windows change or crop failure occurred in this test; this is not a general crop-error fix.

1. Entered Add once, without entering a Group number/name or any other account.
2. Focused **رقم حساب المخزون**, current edit ID **41**, and pressed **F9** once. Fresh inv lookup **23268660**, **شاشــــة البحــــث العامه**, displayed the existing child code/name; Root was absent from this observed result. No complete filter predicate is inferred.
3. Double-clicked the visible child-name row at **(293,177)** in the current **730 × 606** lookup capture. The lookup closed and transferred **97070101** to the account-code field. Its paired name was initially blank; focus remained ID 41. No Enter, plus-button action or Save was used.
4. Tested one explicit alternative to the preceding unresolved Tab behavior: a single click at **(320,274)** on the empty **الاسم العربي** Group field, from the matching **1920 × 1020** form capture. No text was entered there. The immediate screenshot showed **DBL_TEST_CHILD_20261007** in the paired inventory-account-name field, while its accessibility focus text still reported ID 41.
5. A subsequent observation, with **no intervening input**, showed the same resolved code/name, a caret in the empty Group Arabic-name field and current accessibility focus **ID 60**. Thus natural mouse-based field departure and completed name resolution are independently observed. No validation dialog appeared, and no account property was changed or supplied to achieve this result.

**Operational conclusion:** selection transfers the code, and the observed ordinary focus-departure interaction resolves the name and permits leaving the field. The previous blank-name/no-immediate-Tab-transition evidence does not establish account ineligibility. This sequence provides a narrow successful interaction path, not proof of the internal event implementation, the exact cause of the previous Tab observation, a general keyboard defect or a timing rule. It also demonstrates that immediate accessibility focus can lag a visible transition in this case. No repeated/random clicks, similar-field comparison, additional lookup/filter SQL investigation or Help browsing was necessary once this evidence closed the named question.

### Cancel, read-only reconciliation and qualification limits

Clicked **تراجع** once at **(1885,527)**. Fresh inv dialog **168234586** explicitly asked **هل تريد التراجع عن العملية؟**. Its current **نعم** button discarded only the unsaved draft. Final Group capture showed blank fields, Add enabled and Save/Cancel disabled. No saved record was deleted.

Final SELECT-only at **07:51:52.9040541+03:00** against the same source confirmed:

- **Account=2; Account_Cur_Detail=1; i_group=0; Measure=0; item_detail=0.**
- Root 970701 / DBL_TEST_MAIN_20261007: parent 0, main type 1, rank 1, Balance Sheet.
- Child 97070101 / DBL_TEST_CHILD_20261007: parent 970701, subsidiary type 2, rank 2, Balance Sheet.
- Both observed account projections retained ac_type=NULL, ac_close=false, MdfdNo=0 and MdfdOn=NULL. No Dr/Acc_Sort investigation or correction occurred.
- The child's one SAR link remained active/default with zero limits, matching the pre-check. Inventory currency SAR remains the previously proved Host-options observation, not a new options read or a trace of all Group currency-validation internals.

**Inventory Group eligibility = PASSED for this existing child's visibility, selection, resolved name and normal field exit in unsaved Group Add**, with the independently verified SAR binding and prior matching inventory currency. This does **not** prove Group Save, all mandatory Group fields, every account-selection predicate, financial/accounting correctness, globally minimal hierarchy or future inventory transaction behavior. No explicit separate currency-success dialog appeared; none is claimed.

No Group/Unit/Item was saved, no account/currency record was changed by an authorized edit, and no S0b/S1/S2/S3, third account/level, template, initialization, Account Numbering, SQL business write, backup/Restore, VM or security/configuration action occurred. No LAB-PROVEN canonical mapping, PARTNER-VALIDATED or PILOT-QUALIFIED product claim follows. The saved two-account experiment remains intact; Group is left blank in view mode.

**Narrowest next action:** review this closed picker gate and obtain separate bounded authorization before any official Unit/Group/Item creation. Group Save rules remain untested and require their own first-validation stop rule; do not infer permission to start them from this discovery. **STOP.**

## Host Controlled Dataset bootstrap through Item A / S1 — 2026-10-07

The user accepted Inventory Group eligibility PASSED and authorized only sequential official UI creation: Unit A, then Group A after Unit verification, then Item A after both prerequisites were verified. Each master had one Save; any new unknown validation required stopping without guesses. All 12 mandatory Product Memory documents and the Computer Use instructions were reread before UI work. Build checkout remained clean at **0fb18e982e90ae09b5e68f306c406ee97a7f29ff**, including the final local check; no implementation or remote CI claim follows.

### Pre-check, source and recovery boundary

SELECT-only at **08:38:06+03:00** matched physical Host **DESKTOP-8QRQT7R\YSEDU / EFA12026 / database ID 7**, current GL 30180 / inv 66628 / GL_New 47216 and 62836 sessions, and counts **Account=2, Account_Cur_Detail=1, Measure=0, i_group=0, item_detail=0, item_mov=0**. The approved accounts and active/default SAR link remained the prerequisite; no further accounts discovery or Dr/Acc_Sort investigation occurred. The previously accepted baseline backup plus DATABASE RESTORE PROOF PASSED remains the database recovery evidence, not a new post-S1 backup or full ERP rollback. No extra backup, restore or Hyper-V checkpoint was created.

All native inputs used **node_repl → @oai/sky**, selected returned inv.exe window **7668528**, and fresh matching observations. A later tool-session reset lost the JavaScript binding: one intended Group-tab action returned **sky is not defined** before any input. The supported import/list/get/activate workflow recovered the existing draft, without another Add or Save. Its initially restored window was maximized via title-bar double-click for presentation only. No Windows configuration or monitor setting changed; no general cure for the older capture-crop error is claimed.

### Unit A — one Save and independent verification

Official path: **إدارة المخزون والجرد → تهيئة النظام → الوحدات المخزنية → الوحدات → إضافة**.

Fresh Add exposed two blank fields only, **الرمز** and **الاسم**. Entered **UA** and **DBL_UNIT_A**; no additional setup value was supplied. The name edit's accessibility label said رمز الـISO although the visible form label was الاسم; this was treated as a UIA label mismatch, not an additional ISO-code requirement. Tab did not immediately show departure from the code field; a matching click/focus observation selected the name field before typing.

One Save returned the form to view mode without a validation dialog. Closed only this form and reopened Units from its official ribbon route; independently loaded UA / DBL_UNIT_A appeared in view mode. SELECT after reload at **08:41:24+03:00**, corroborated again at **15:23:19.8396086+03:00**, returned exactly:

| Stored column | Value |
|---|---|
| Measure_Code / Measure | UA / DBL_UNIT_A |
| Measure_type / Units_linked / Measure_Code_S | 0 / false / NULL |

The last three values were stored by Motakamel without agent assignment. These are this saved row's observed values, not universal unit defaults.

### Group A — one Save, SAR prerequisite and independent reload

Official path: **إدارة المخزون والجرد → المدخلات → بيانات المجموعات → إضافة**.

Entered **001 / DBL_GROUP_A** and selected existing inventory account **97070101 / DBL_TEST_CHILD_20261007** through F9 → official general lookup → double-click. Natural departure by clicking the Group-name field resolved the paired account name, without validation. Foreign name and all other account fields stayed blank. The setup tab was inspected without toggling options: group-code inclusion, automatic item numbering (disabled), group discount, VAT, restaurant linkage and VAT-inclusive sale/purchase options were visibly unchecked. No Reference settings were copied.

Literal type_text for numeric Group code 001 initially returned without error but left the field blank in subsequent observations; supported set_value on the freshly observed code edit populated 001. This is bounded interaction evidence, not an identified keyboard/root-cause defect. Group name was also set through its observed editable UI control.

One Save on **تهيئة المجموعة** returned to view mode without validation. Closed the form, reopened **بيانات المجموعات**, and used its official **الأخير** navigation to independently load the saved Group in view mode: 001, DBL_GROUP_A, 97070101 and DBL_TEST_CHILD_20261007 were visible. No Edit or second Save was used.

SELECT at **15:23:19.8396086+03:00** returned the complete saved i_group row. Exact entered and automatic values:

| Value | Stored columns |
|---|---|
| 001 / DBL_GROUP_A / 97070101 | g_code / g_a_name / g_a_code |
| empty string | g_e_name |
| 1 / 0 | cst_type / G_Disc |
| false | FinishTransfer, FinishUpdate, GenerateItemNo, ICodeWithGrp, PriceVAT, PriceVATPrch, Tax_item |
| NULL | CarryingAcc, free_qty_acc, g_cst_code, g_dif_rtn_purch, g_dsc_code, g_pr_code, g_py_code, g_py_cst_code, g_sadjs_code, g_sl_code, g_sr_code, Grp_disc, ItemLen, PromotionACC, SeparateType, Serial_Start, serial_Type, Vndr_dsc_code, Separate_Diff_acc, Method_No, Tax_No, Agency_Code, DiscRsnNo, VatExNo_Zero, VatExNo_Exempt, Tax_item_per |

There is **no currency column in the observed i_group schema**. Do not invent a persisted Group SAR field: compatibility evidence is the prior current inventory-options SAR observation, the freshly corroborated **Account_Cur_Detail A_Code=97070101 / Cur_Code=SAR / Suspend_Cur=false / Default_Cur=true / Max_Amt=0 / Min_Amt=0**, and accepted selection plus successful Group Save. No separate currency-success dialog or complete internal validation predicate is claimed. A read-only query initially used invalid column Acc_No and failed; actual catalog columns were read and the corrected SELECT used A_Code. No SQL write or permission change occurred.

### Item A / S1 — one Save and independent UI reload

Official path: **إدارة المخزون والجرد → المدخلات → بيانات الأصناف → إضافة**.

Fresh Add had blank group/code/names/type/unit/package inputs, an initial grid package **0**, the first grid row's **وحدة رئيسية** automatically checked, and added-date **07/10/26** supplied by Motakamel. No price, cost, balance, quantity, tax, barcode, supplier or secondary unit was supplied.

- Set Group **001**; leaving that field displayed **DBL_GROUP_A**.
- Entered **DBL_P001_ITEM_A** and Arabic-name-field **DBL_ITEM_A**. Foreign name remained blank.
- Opened the current unit dropdown and selected its actual **UA** entry, already verified as DBL_UNIT_A.
- Set the observed **العبوة** edit to approved **1**. The set_value call reported **wait for accessibility set value: timed out waiting on channel**; the next fresh observation proved both UIA Value=1 and visible 1. It was **not retried**. Leaving the field populated exactly the first grid row **UA / package 1 / primary checked**. No additional grid row was filled.
- Item type remained visually blank; no type was guessed from Reference help. All approved identity/link/package values and the primary row were visible before Save.

One Save returned the form to view mode without validation. Closed only Item form, reopened **بيانات الأصناف** from the official ribbon, observed the new blank view buffer, then invoked **الأخير** once. Independent reload displayed exact code/name, Group 001 / DBL_GROUP_A, Unit UA, package 1 and the checked primary-unit row. The grid's price displayed 0 after reload; the agent had not entered it. No second Save, Edit or correction occurred. The saved Item is left displayed in view mode.

Full keyed live SELECT at **15:30:03.1681908+03:00** returned the following exact item_detail values, grouped without assigning unsupported business meanings:

| Value | Stored columns |
|---|---|
| DBL_P001_ITEM_A / DBL_ITEM_A / 001 / UA | i_code / i_a_name / g_code / i_measure |
| 1 | i_size, i_c_type, p_size, ItmPrdctType |
| string 0 | p_code, reprs_code |
| 0 | CarryingFee, CBM, fre_prc, GrossMargin, imp_Item_value, item_fract, itm_disc, itm_disc2, itm_type, MaxPricePer, MinPricePer, Tax_item_Per, Tax_item_Value, CSTWithoutCFormVal, CSTWithCFormVal, comm_per, UseQrWise, ItmStndrdCost, AvailableQty, MedicalType |
| false | AssembledItems, blocked, disc, expr_date, FinishTransfer, FinishUpdate, fract, fre_qty, Imp_item, stopped_1, Tax_item, stopped, CSTWithoutCFormUse, CSTWithCFormUse, PriceVAT, UseStations, UseReprs, NotDisrbutBurdns, NotDistrbutDscnt, UsePrdcItm, UseRstrntItm, UseLabItm, UsedItm, PriceVatPrch, UseSN, UseFas, UseBatchNo, UseFood, ItmPrdctFlg, UseAttchdSpecifictions, UseBalance |
| empty string | i_desc, i_e_name, manfc_no, Itm_Mnfctr_Cntry, Itm_Brand, Itm_Quality, Itm_Scale, RegNo |
| single space | free_txt1, free_txt2, free_txt3, free_txt4 |
| 2026-10-07 00:00:00 | Itm_Add_Date |
| NULL | cost_rate, ExportBill, i_cur_cost, i_mqty, i_mxqty, i_name, i_rol, i_volum, Item_Get, itm_volm, Qty_Order, s_g_code, size_name, Taxno2, free_txt5, SciCode, Scin_Code, AltrntvScncGrpNo, ScncSubGrpNo, AltrntvGrpNo, AltrntvGrpPriority, I_codeCommrc, IG_ClassNo, i_desc2, Measure_Desc, GTIN, GPC_Code_S, Measure_Code_S, LocalCode, DiscRsnNo, VatExNo_Zero, VatExNo_Exempt, ExpireFormat |

**IPicturePath** contained a literal dot, a long run of spaces and the visible form placeholder **صـــــورة الـــصــــنــــف**. No image was uploaded or path assigned by the agent; this observed placeholder is not proof of a usable image file. The table records the saved values, not universal defaults or semantic approval of undocumented numeric codes. In particular AvailableQty=0, cost placeholders and the movement count below are **not reconciled zero-stock/valuation evidence**.

The keyed item_detail_Dtl row was **I_Code=DBL_P001_ITEM_A, Branch_No=1, i_cost_Brnch=0, i_cwtavg_Brnch=0**, created by Motakamel without manual branch-cost assignment. These are observed persistence effects, not financial/accounting correctness or a separate movement.

### Final reconciliation, Reference comparison and stop boundary

After independent Item UI reload, joined SELECT at **15:32:02.6960909+03:00** against the same Host source returned exactly one observed relation:

| Item | Arabic name | Group / name | Inventory account | Unit / name | Package |
|---|---|---|---|---|---|
| DBL_P001_ITEM_A | DBL_ITEM_A | 001 / DBL_GROUP_A | 97070101 | UA / DBL_UNIT_A | 1 |

Final counts: **Account=2, Account_Cur_Detail=1, Measure=1, i_group=1, item_detail=1, item_mov=0**. The count was recorded as a bounded table observation, not a stock-report reconciliation. Reads were SELECT-only during paused UI intervals, not an atomic/frozen snapshot, qualified least-privilege connector acquisition or complete mutation audit across every ERP table.

**Separate classifications:** Unit A Save/reload/persistence PASSED; Group A Save/reload/inventory-account persistence PASSED with active/default matching SAR prerequisite; Item A / S1 official master creation, independent reload and basic keyed relationships PASSED. This is the written Host evidence checkpoint, **not** a new backup or VM checkpoint.

Reference Lab historically saved the same authorized Unit/Group/Item identities and primary package 1. Host now has its **own newly created records**, not migrated Reference rows. The material distinction is Host inventory account **97070101 under 970701**, not Reference **1141010001** or its copied hierarchy/provisioned chart. Host automatic defaults above were observed here, not copied or asserted equivalent to unexamined Reference defaults. No financial semantics of the neutral TEST accounts, global minimum chart, canonical mapping or product qualification follows.

No direct SQL business writes, additional accounts, Account Numbering, chart template, initialization, connector implementation, purchase/inbound/stock movement, S0b/S2/S3, optional Windows update, activation, host security change or existing-lab action was performed. Pilot #001 remains Purchase Attention + Item Intelligence; S0b remains historically partial in Reference and was not begun on Host. Gate A frozen acquisition/reader/semantic reconciliation remains unqualified here; Gate B/C, PARTNER-VALIDATED and PILOT-QUALIFIED are not advanced by this master-only test.

**Narrowest next action:** review this persisted Host S1 evidence checkpoint and obtain a separate bounded authorization for the next plan gate. Do not start S0b, S2/S3, inventory transactions, connector coding or additional master creation automatically. **STOP after S1.**

## Host Controlled Zero and S0b inbound discovery — 2026-10-07

### Authorization, scope and current source

The user accepted the preceding S1 checkpoint and separately authorized Controlled Zero / inbound discovery only. No Account/Unit/Group/Item rediscovery or Save, no supplier/warehouse/document creation, no transaction Save/posting, no stock movement, no S2/S3, SQL writes, backup/restore, connector implementation or Canonical expansion was authorized or performed. Forms below were opened in **view mode**, not Add; no draft identifiers or quantity 37 were entered. S0b is now **started but PARTIAL on Host**, not completed. This supersedes older Host-S0b-not-started wording only; Reference's partial S0b is not promoted.

Current SELECT attribution at **2026-10-07 15:59:15.5655999+03:00** and **16:20:04.7454065+03:00**: `DESKTOP-8QRQT7R\YSEDU`, `EFA12026`, database ID **7**. GUI modules displayed branch 1, user 1 / Adm, year 2026. Branch 1 is **not** proof of warehouse 1. Item identity/unit/package remain the accepted S1 values; no new frozen acquisition or implementation verification follows from these live reads.

### A — Controlled Zero: BLOCKED, with partial supporting evidence

**CURRENT-UI PROVEN:** `إدارة المخزون → المدخلات → بيانات الأصناف → المخزون` displayed `DBL_P001_ITEM_A / DBL_ITEM_A`. The grid has `رقم المخزن`, `الكمية الافتتاحية`, `الكمية المتوفرة`, but was empty. There was no warehouse row, numeric stock zero or quantity-unit basis displayed. **Empty is not zero.** Accepted saved/reloaded Item A is retained from S1, not repeated as a new creation test.

The official candidate balance path is `إدارة المخزون → التقارير → المخزون` (form `تـقـريــر المخزون`). It exposes:

- Date displayed **07/10/26**, from/to branch **1 -**; item/group ranges, unit and warehouse-from/to filters.
- `عرض الكمية المتوفرة`, `المخزون مع اظهار الاصناف الصفرية`, `إظهار الاصناف الصفرية فقط`, and `مع الأصناف التي ليس لها تخزين و لا أي حركة مخزنية` (the latter was disabled under the default available-quantity mode).
- Quantity/package display and additional report filters. These were observed, not enabled, executed or assumed to resolve missing locations.

Opening the report's actual **from-warehouse dropdown** produced an empty list. No Warehouse ID/name/location was selected or invented. No report preview was generated, printed or exported; an explicit scoped zero has **not** been obtained. The source confirmation was targeted to the missing warehouse and accepted item rather than an ERP-wide dictionary investigation.

**BOUNDED LIVE SOURCE EVIDENCE:** at **16:00:27.3131097+03:00**, Item A had `i_measure=UA`, `i_size=1`, `AvailableQty=0`; exact `i_code`-filtered row counts in `item_store`, `opn_stock`, `item_mov` were each **0**. A subsequent SELECT confirmed **`W_DETAIL=0`** across that current database; metadata identifies `W_CODE`, `w_a_name`, `Branch_no`, `w_loc` in this warehouse master. Final SELECT at **16:20:04+03:00** again returned warehouse 0 and all three keyed item counts 0, with Item A / Group 001 / Unit UA / package 1 intact.

These are noncontradictory supporting observations only. `AvailableQty=0`, no movements, missing storage/opening rows or branch 1 do **not** establish authoritative scoped stock, warehouse allocation, a general missing-row=zero rule or a qualified inventory reader. No W exists to bind the proposed I/U/W experiment. Therefore **Controlled Zero = BLOCKED at W scope**, not PASSED and not a finding of nonzero stock. Unit UA / package 1 is known from S1; normalization in a stock report/inbound line is still untested. Physical shelf/bin/location semantics were not invented from `w_loc` metadata.

### B — Current official inbound routes and evidence limits

| Route | CURRENT-UI PROVEN | Scope / unresolved prerequisites |
|---|---|---|
| Inventory → Operations → `أوامر التوريد` | Opens `أمــــر توريد مخزني`. Fields: supply number/date, account/name, warehouse, supply type, supplier/customer, cost center, optional source-document controls; line code/name/unit/warehouse/quantity/cost/total. Bottom inventory currency **SAR**. | Candidate **S2-R inventory addition**, not automatically a purchase. Supplier controls exist but compulsory status was not established. Type choices, mandatory account/cost, dates/defaults in Add, Save validation and stock-effective completion remain UNRESOLVED. No Add/Save performed. |
| Inventory → Operations → `الاستلام المخزني` | Opens `استلام مخزني` with **transferred-from branch**, transfer number, **from warehouse / to warehouse**, receipt type, account, date, reference, cost center and item/qty/cost lines. | Current form is transfer-oriented; it is **not proven** to accept an independent supplier-free initial receipt. Do not use it to manufacture stock from an unproved transfer/source. No Add/Save performed. |
| Main Menu → `إدارة المشتريات` → Operations → `فواتير مشتروات فورية` | `C:\EFA\Prch.exe`, current form `فاتورة مشتروات فورية`: payment method/date, invoice number, supplier name, currency, exchange rates, cashbox, warehouse, cost center, source-document controls; item/unit/warehouse/qty/free qty/cost/tax columns. Bottom inventory currency **SAR**. | Candidate **S2-P**. Current required-field validation, actual payment choices/defaults, supplier versus cashbox requirement, active invoice currency/rate, price requirement and exact stock-effective state not verified at Save. No Add/Save performed. |
| Purchase Operations → `فواتير مشتروات خارجية`, `إذن التوريد`, local/foreign purchase cost | Menu controls visible; forms not opened. Purchase requests/orders also visible. | Not qualified alternatives. They may widen workflow or add cost/document dependencies; no implied stock movement or approval from menu presence. |

**HELP-DOCUMENTED, not current Save proof:** F1 from the immediate/local purchase invoice opened installed official HTML Help titled **فواتير المشتريات الفورية**, explicitly **version 5**. The observed current purchase dashboard labels version 6.0. The help was read through its UI; no archive extraction, unofficial tooling or external-site download was used. It documents:

- This invoice is for local purchases with known costs, including allocated added charges where applicable, and supplies items to the warehouse based on final cost. For known costs **without added charges**, it describes use of inventory **أمر التوريد المخزني**. That documents an alternative route; it does not prove the current inventory form's mandatory account/type rules or purchase/supplier semantics.
- Payment methods cash, cheque, cheque+cash and credit. Cash selects a cashbox; cheque selects a bank; credit selects a supplier. Thus **supplier is conditional on payment route in the help**, not proven universally mandatory on this Host.
- Invoice numbering and date automatic; actual IDs must be captured after a future authorized Save, not preassigned from this help. Available currency follows the selected cashbox/bank/supplier account. Warehouse can be selected at header or individual lines. No SAR document selection, FX configuration or payment master was created here.
- Item selection by code/F9; a single unit is automatic, otherwise a purchase-default unit or unit selection is used. Quantity and per-unit cost are entered; free quantities/discounts and other features are separate. These described controls do not prove a current accepted cost/value or stock status for Item A.

F1 from the inventory supply form produced no observed help window; fresh enumeration/capture confirmed no new Help target and the unchanged form. The inventory `التعليمات` ribbon was visibly empty. No repeated speculative Help/input recovery or interpretation of this as an ERP validation was performed. Mandatory current **S2-R** Save rules remain unresolved.

**REFERENCE-LAB HISTORICAL:** its existing warehouse/workflow choices remain hypotheses only. No Reference warehouse ID, supplier ID, document ID or transaction-type numeric code was imported, entered or assumed. Neither Receipt success nor Purchase success is established on Host by Reference history.

### Decision, first blocker and smallest next experiment

**First missing prerequisite: a real saved warehouse in the active Host database.** The report picker and `W_DETAIL=0` independently support that boundary. No warehouse/account/supplier creation or stock initialization was attempted to overcome it. Unit A / Group A / Item A and their accepted account prerequisite remain closed; this does not reopen chart/numbering discovery.

**S2 branch selection remains UNRESOLVED / not executable now.** The plan prefers S2-P when a narrow genuine purchase path can be qualified, but its payment-side prerequisites are not yet proved. Inventory `أمر توريد مخزني` is the **narrower candidate for S2-R** because it avoids the fuller purchase invoice's documented payment/charge surface; supplier-free Save, required account/type and stock-effective behavior still need proof. A control labelled `الاستلام المخزني` is not sufficient: its current transfer fields make it an unqualified initial-stock alternative. Do not label either candidate READY or silently choose receipt as proof of Purchase Attention.

**Narrowest next action proposed, not executed:** separately authorize non-saving discovery of **بيانات المخازن** to identify the minimum real warehouse prerequisites and whether it can be provided without broader company/account setup. Stop before warehouse Save; do not invent a warehouse identity. If a separately approved warehouse is later saved/reloaded and source-verified, obtain the explicit Item A / UA / actual W zero using the official zero-inclusive stock report, then finish non-saving discovery of one selected inbound route. Only after these gates and explicit mutation authorization could a **single stock-effective 37-UA line, package 1** produce the planned `0→37`. No opening balance, parallel purchase+receipt, hidden transfer, guessed supplier/account/type/cost or automatic third prerequisite is approved. If mandatory pricing is exposed later, apply the existing plan's conditional price/basis gate rather than guessing now.

Final live counts: **Account=2; Account_Cur_Detail=1; Measure=1; i_group=1; item_detail=1; W_DETAIL=0; keyed Item A item_store/opn_stock/item_mov=0**. These bounded SELECT projections are not an atomic snapshot, all-table mutation audit, frozen acquisition or qualified least-privilege connector read. No transaction Save/input, posting, stock adjustment or master mutation was issued by the agent. Existing VM labs and host security/settings were not operated; no fresh Hyper-V integrity audit is claimed.

### Operational / repository boundaries

Computer Use skill guided fresh target selection, one-action/observation loops and stopping on mismatched captures. Restored narrow windows were maximized through their current title bars only. The purchase temporary ribbon reproduced `window crop is outside captured monitor`; text-only fresh recovery succeeded, but its UIA expand index was unavailable in cached state. Escape followed by a fresh screenshot-derived double-click on the application's own Operations tab pinned the ribbon, after which purchase form capture succeeded. No Windows scaling/monitor/security change or general capture-fix claim. After Help closure, one inventory capture showed Help instead of the intended form; no coordinate action used that mismatched image. The remaining returned Help window was closed normally, then fresh selection/capture recovered inventory. All Help windows were absent from the final checked enumeration. Inventory and purchase forms were left in view mode, not unsaved transaction drafts.

Build checkout read-only verification: clean at **0fb18e982e90ae09b5e68f306c406ee97a7f29ff**; no implementation or Gate A/B/C claim was inferred from Product Memory. S1 stays accepted. **Controlled Zero BLOCKED; Host S0b PARTIAL; S2/S3 NOT STARTED; no PARTNER-VALIDATED/PILOT-QUALIFIED promotion. STOP before any transaction Save.**

## Host non-saving warehouse Add discovery — 2026-10-07

### Authorized scope and current-source verification

The user accepted the missing-Warehouse finding and authorized **Add inspection only**, including safe unsaved lookup interaction, Help, Cancel and read-only source reconciliation. Save was explicitly forbidden even as a validation probe. No identity was typed, flag toggled, branch selected, warehouse/account/supplier created, inbound entered, stock changed, SQL write, backup/restore or S2/S3 action performed. Existing accepted S1 masters were not reopened for discovery or modified.

Before and after SELECT attribution: `DESKTOP-8QRQT7R\YSEDU`, `EFA12026`, database ID **7**, at **2026-10-07 16:43:44.1172239+03:00** and **16:49:53.2166574+03:00**. Counts both times: **W_DETAIL=0; Account=2; Account_Cur_Detail=1; Measure=1; i_group=1; item_detail=1**. Bounded full-row reads returned exactly those two accounts and the single currency/unit/group/item records; comparison excluding observation timestamp was **identical**, not merely equal counts. This proves unchanged inspected records, not an atomic frozen snapshot or an all-table ERP mutation audit.

### CURRENT-UI PROVEN — path, Add and actual defaults

Official path: **Main Menu → إدارة المخزون والجرد → المدخلات → بيانات المخازن → إضافة**. Current window `process:C:\EFA\inv.exe`, ID **7668528**, title branch 1 / user 1 Adm / year 2026 / `بيانات المخازن`. Add enabled Save/Cancel, disabled Add/Search/Edit/Delete; Save was never invoked. The form's complete visible warehouse-data surface was inspected:

| Field / control | Actual fresh Add state | What this establishes |
|---|---|---|
| رقم المخزن | Blank, editable, initially focused; no numeric default observed | No generated ID or automatic Warehouse 1 established. |
| اسم المخزن العربي / الأجنبي | Both blank and editable | No name default; mandatory status not proved by appearance. |
| تابع للفرع | Blank, enabled selector | Opening once showed existing **`1 -`**. Escape closed it without selecting; no branch binding persisted or default selected. |
| مكان المخزن / أمين المخزن / تلفون المخزن / رقم الفاكس | Blank editable fields | No person/location/contact prerequisite populated automatically. |
| حساب وسيط التحويلات المخزنية, with adjacent account-display areas | Blank | No account selected; no current Save requirement or filter eligibility established. This is not the Group inventory-account field. |
| للتخزين فقط | Unchecked | No internal-consumption restriction selected. |
| غير قابل للبيع / غير قابل للصرف / مخزن إنتاج | All unchecked | Flags retained untouched. |
| Unlabelled production-related dropdown beside مخزن إنتاج | Blank, disabled in fresh Add accessibility | Enabling production and its dependent choices was out of scope; no type value assumed. |
| رقم الموقع العالمي / خط الطول / خط العرض / العنوان بالعربي / العنوان بالأجنبي | All blank | No geographic/address defaults or Save requirements proved. |

No currency selector, standalone keeper/responsible-person master picker, or additional visible transfer-difference-account input was identified on this current surface. That is a bounded UI observation, **not proof that currency or such masters can never be validated elsewhere**. No asterisks or explicit required-field explanation was observed; enabled/blank controls alone do not establish optionality. The separate `طباعة بيانات المخازن` tab is a report surface and was not used as a creation prerequisite.

### HELP-DOCUMENTED — official installed version 5, not current Save proof

F1 from Warehouse Add opened official installed HTML Help **بيانات المخازن**, `C:\EFA\EFAHELP.chm::/3204.htm`, explicitly **المتكامل بلاس الإصدار الخامس**. The page and its end were read through Computer Use, without extraction. It documents:

- Warehouse number is entered as its serial number; Arabic name names the warehouse; foreign name is for establishments needing it. This does not prove current automatic numbering or every Save validation.
- Branch links a warehouse to an establishment branch; one or more warehouses can belong to a branch, and other branches' warehouses are not shown there. This supports real branch scope, **not Branch 1 = Warehouse 1**.
- **Location, keeper, phone and fax are explicitly optional and may be skipped.** No mandatory keeper master creation is documented on this page.
- `للتخزين فقط` is for internally consumed/non-sale materials; it excludes the warehouse from sales invoices while retaining inventory/purchase visibility. Non-sale/non-issue/production flags have their documented restrictions; none was enabled.
- Transfer intermediary account is affected by **inter-branch stock transfer/receipt**; transfer-difference account relates to cost versus selling-price differences on transfers at selling price. These descriptions **do not make either account a proved mandatory prerequisite for saving one ordinary warehouse**. The help mentions a difference-account field not identified on this current visible Add surface; do not invent a value or conflate it with the existing Group inventory account.
- Global-location number, longitude/latitude and address describe location/regulatory/additional data. No mandatory currency field, chart template, Account Numbering, stock initialization or broader provisioning is documented here.

The Help predates the current application; described purposes/explicit optional fields are **HELP-DOCUMENTED**, not a successful current minimal warehouse Save. The page's generic Save description was not executed.

### Bounded source metadata — structure, not business requirements

`W_DETAIL` metadata has **W_CODE int NOT NULL** and **Branch_no int NOT NULL** (database default 0); Arabic/foreign names, location, keeper, phone/fax, `W_Acc`, `W_Acc_Diff`, global-location/address fields are nullable. FinishTransfer, locked, MrpWrhs, NoSaleIsAllowed and NoOutComAllowed have database false defaults. The inspected object list includes primary/unique constraints and `FK_W_DETAIL_Account_Acc_Diff`. No currency column appears in this table's inspected columns.

These facts do **not** authorize Branch 0, prove a blank account is accepted by Motakamel Save, establish optional Arabic name, identify all application validation, or assign business semantics to an integer/default. No missing master is inferred merely from a nullable FK or table design. The existing branch option comes from current UI evidence; no Reference warehouse was inspected/copied.

### Required versus optional versus unresolved; smallest next experiment

**Current Save-enforced REQUIRED set: UNRESOLVED.** Save was prohibited and not attempted. Warehouse number/name/branch are the documented identity/scope candidates for a bounded creation experiment, **not a proved minimum accepted set**. Storage requires a numeric W_CODE and a Branch_no, but this is database structure rather than current UI validation. Help explicitly documents location/keeper/phone/fax as optional and foreign name as conditional; account mandatory status and any additional current Save rules remain unresolved. No new missing master prerequisite beyond the real saved Warehouse has been proved; broader chart/initialization/extra-account provisioning is neither shown required nor authorized.

**Proposed identity only:** Arabic-name field **DBL_WAREHOUSE_A**, dedicated to Controlled Dataset #001. Numerical Warehouse ID remains **not assigned/proposed as a system fact**: fresh Add left it blank and Help describes manual serial entry; a new neutral numeric test code must be separately agreed before Save, without copying Reference Warehouse 1. Proposed branch is the actually offered **1 -** of the active Host module, subject to explicit authorization/selection and subsequent persisted binding verification. Leave foreign/contact/location/account/address fields blank and the observed restriction/production flags unchecked only as an approved **test candidate**, not guaranteed Save acceptance. No such name/code/branch was entered in this task.

After separate authorization, the narrowest experiment is **one Warehouse Save attempt** with agreed number, DBL_WAREHOUSE_A and the current existing branch; stop at the first new validation and do not guess an account/keeper or create another master. If saved, independently reload and SELECT-verify exact ID/name/branch/defaults. A single actual warehouse would remove the currently proved missing-W blocker and provide a scope for **retrying** Item A / UA / package 1 Controlled Zero through an official zero-inclusive report. It **does not guarantee** the report includes an unstocked item or yields trusted zero: those report/unit/missing-row semantics remain to be observed. No opening stock or inbound is authorized to force a zero row. S2-P versus S2-R remains undecided and no inbound Save follows automatically.

### Cancel, integrity and stop boundary

Closed only Help normally, observed Warehouse Add afresh, clicked official **تراجع**, read **هل تريد التراجع عن العملية؟**, and confirmed **نعم** for that unsaved draft. Subsequent fresh image showed Add/Search enabled and Save/Cancel disabled, confirming view mode. After-Cancel SELECT comparison above preserved the exact full returned rows for root **970701**, child **97070101**, active/default **SAR** link, **UA / DBL_UNIT_A**, **001 / DBL_GROUP_A**, and **DBL_P001_ITEM_A / DBL_ITEM_A**, including Group/account, Unit and package relationships. **W_DETAIL remains 0.**

Computer Use skill guided fresh observations, mismatch-safe Help selection and one-action loops. A capture requested on inventory during Help display showed Help; no input used that image to act on inventory. Help was selected from fresh enumeration and closed as its own returned window, then absence confirmed. Restored narrow inventory windows were maximized through observed native title bars only. No captured-monitor error occurred in this round and no Windows monitor/scaling/security setting was changed; no general fix is claimed.

**Discovery COMPLETE / no Warehouse created; Controlled Zero BLOCKED; S0b PARTIAL; S2/S3 NOT STARTED.** No SQL writes, business transaction, stock movement, backup/restore, existing-lab action, connector/Canonical implementation, accounting-scope expansion or Gate A/B/C promotion. No PARTNER-VALIDATED or PILOT-QUALIFIED claim. **STOP before any Warehouse Save.**

## Host authorized Warehouse A single Save — validation stop — 2026-10-07

### Approved candidate and pre-mutation evidence

The user authorized **one Save attempt only** through **إدارة المخزون والجرد → المدخلات → بيانات المخازن → إضافة**, with warehouse number **001**, Arabic name **DBL_WAREHOUSE_A** and branch **1 - selected from the current official dropdown**. The number was user-approved test identity, not an automatically generated warehouse ID or a Reference-Lab assumption. Foreign name, location, keeper, phone, fax, transfer-account/display fields, global-location/coordinates/addresses remained blank; storage-only/non-sale/non-issue/production flags remained unchecked and the production-dependent dropdown stayed disabled. No extra account, currency, person or location value was invented. Final fresh screenshot/accessibility inspection confirmed the approved identity and selected branch before Save.

Pre-check SELECT at **2026-10-07 17:05:32.6170073+03:00** attributed the source to **DESKTOP-8QRQT7R\YSEDU / EFA12026 / database ID 7**. Counts: **W_DETAIL=0; Account=2; Account_Cur_Detail=1; Measure=1; i_group=1; item_detail=1; keyed Item A item_mov=0**. Bounded full-row reads captured exactly the two account rows and single SAR/unit/group/item rows for before/after comparison. No additional backup/Restore was performed.

### Operational observations before Save — unsaved draft only

The initial `type_text` call for `001` returned without an exception, but subsequent observations still showed the number blank. A supported accessibility `set_value` then timed out with **`wait for accessibility set value: timed out waiting on channel`**; a fresh observation proved `001` present, so it was not repeated blindly. The next unnamed edit was incorrectly treated as the Arabic-name field; its set-value attempt also timed out and observation showed **DBL_WAREHOUSE_A in the fax field of the unsaved draft**, not the name field. This mapping error was disclosed immediately, before any Save. Fax was cleared and visually verified blank. One intervening inventory-targeted capture displayed Codex instead; **no input was grounded in that mismatched image**. Fresh enumeration, target selection, activation and capture recovered the intended warehouse form.

The actual Arabic-name field was then identified from the current image and focused; a subsequent observation resolved its accessibility ID to **19**, versus fax ID **23**. One text-input call populated the correct Arabic-name field. The branch dropdown was opened and its actual **1 -** row selected. Final fresh observation confirmed number ID **22** = `001`, Arabic-name ID **19** = `DBL_WAREHOUSE_A`, fax ID **23** empty, branch selector ID **25** = `1 -`, with the remaining defaults unchanged. The erroneous fax value was corrected **before the only Save attempt**, not persisted. These observations are not a general input/capture fix or a change to Windows security/monitor settings; the Computer Use skill's fresh-observation and pre-Save checks constrained the error to the unsaved draft.

### CURRENT-UI PROVEN — one Save, first validation, immediate stop

Exactly **one** official Save click was issued on inventory window **7668528 / process:C:\EFA\inv.exe** after the final pre-Save verification. It opened a newly enumerated modal **2954866**, titled **نـظـام الــمـــخـــــازن**. Both its original screenshot and native dialog accessibility text proved the literal message:

> فضلا أدخل رقم الحساب

No account number was entered and no second Save was attempted. **No GUI input followed this validation**: its OK button was not clicked, the draft was not cancelled, and no subsequent model was opened. The validation and unsaved draft are intentionally left open at the user-defined stop boundary.

**Warehouse A Save = BLOCKED; independent UI Reload = NOT ATTEMPTED.** Current UI now proves the approved number/name/branch-only candidate cannot pass this Save without an account number. The message itself is generic: the visible form contains `حساب وسيط التحويلات المخزنية`, but the validation's exact field association/focus and required account properties were **not established** in this round. Do not treat existing Group inventory account **97070101** as a qualified warehouse transfer account or automatically reuse it. Nullable W_Acc/W_Acc_Diff metadata and installed version-5 help's account-purpose descriptions did not prove current Save optionality; this runtime validation supersedes only that unresolved mandatory-status boundary. No broader chart/template/Account Numbering requirement, account creation, currency filter or accounting-role correctness has been proved.

### Post-validation source reconciliation and checkpoint

SELECT at **2026-10-07 17:15:20.3235013+03:00** verified the same source/server/database ID and counts: **W_DETAIL=0; Account=2; Account_Cur_Detail=1; Measure=1; i_group=1; item_detail=1; keyed Item A item_mov=0**. Before/after comparison of the complete returned bounded rows and counts, excluding only observation metadata, was **identical**. Protected records remained root **970701**, child **97070101**, its active/default **SAR** link, **UA / DBL_UNIT_A**, **001 / DBL_GROUP_A**, and **DBL_P001_ITEM_A / DBL_ITEM_A**, with the inspected values and relationships unchanged. This is not an atomic snapshot, all-table mutation audit or frozen connector acquisition. No warehouse row/defaults persisted, so there is no saved branch binding or reload to report.

**Controlled Zero remains BLOCKED at the missing saved warehouse scope.** Item-movement row absence is still not a trusted scoped quantity zero. **S1 remains accepted; Host S0b PARTIAL; S2/S3 NOT STARTED.** No inbound transaction, stock movement, direct SQL write, extra warehouse/account/master, backup/Restore, existing-lab operation, connector/Canonical implementation or Gate A/B/C advancement occurred. No PARTNER-VALIDATED/PILOT-QUALIFIED claim.

**Narrowest next action proposed, not executed:** separately authorize non-saving discovery of the specific account-number validation, including current-field association, official picker/filter and relevant help, to determine the required account role and whether an already saved account is eligible. Do not supply an account merely to clear the validation, create one, expand chart discovery, or retry Save without approval. **STOP at this Warehouse prerequisite checkpoint, before Controlled Zero or any further Save.**

## Host non-saving Warehouse transfer-account requirement discovery — 2026-10-07

### Scope and current-source reconciliation

The user accepted the previous **Warehouse Save BLOCKED** result and authorized only identification of the required account field/role, official lookup inspection without final selection, Help, read-only SQL and final Cancel. No Save or validation retry, account creation/edit, second warehouse, inbound, stock movement, S2/S3, SQL write, backup/Restore or connector work was authorized or performed. The accepted accounts and S1 masters were not reopened for new discovery or changed.

SELECT attribution before/after: **DESKTOP-8QRQT7R\YSEDU / EFA12026 / database ID 7**, at **2026-10-07 17:29:37.0187653+03:00** and **17:34:42.5532499+03:00**. Counts both times: **W_DETAIL=0; Account=2; Account_Cur_Detail=1; Measure=1; i_group=1; item_detail=1; keyed Item A item_mov=0**. Complete returned bounded rows and counts, excluding observation metadata, were identical: root 970701, child 97070101, the active/default SAR link, UA, Group 001 and Item A, including inspected defaults and relationships. This is not an atomic snapshot or an all-table mutation audit; item_mov absence is not a trusted warehouse-scoped zero.

### CURRENT-UI PROVEN — exact validation field and actual lookup candidates

The previous modal **2954866 / process:C:\EFA\inv.exe** still displayed **«فضلا أدخل رقم الحساب»**. Its OK button was clicked once to dismiss only that message, not to Save/accept an account. In the intact warehouse draft `001 / DBL_WAREHOUSE_A / branch 1 -`, a subsequent fresh observation showed focus on **edit ID 26**, with its caret visibly in the code field beside the label **حساب وسيط التحويلات المخزنية**. No input had intervened between dismissal and this focus observation. This identifies the field to which the existing validation returned the user; no new Save was needed to infer it. The adjacent code/display areas were blank.

**F9 once from that existing focus** opened official **شاشــــة البحــــث العامه**, returned window **2953076 / inv.exe**. Search fields were blank. The visible grid contained one row, **97070101 — DBL_TEST_CHILD_20261007**; existing main/root **970701** was not shown. The row's initial cell highlight is the lookup's own state, **not an agent acceptance or assignment**. No double-click, Return or accept action was sent. The picker was cancelled using its visible red-X cancel control. A fresh view confirmed the warehouse account code/display remained blank and the identity/branch draft intact.

Live account evidence classifies the offered child as **type 2 / subsidiary, rank 2, parent 970701, Balance Sheet**, with **active/default SAR**, whereas the non-offered root is type 1 / main, rank 1 and has no Account_Cur_Detail row. Child Dr=false and classification/linkage/cash-flow fields are unchanged from its accepted earlier experiment. **This proves that this particular subsidiary account is an offered candidate and this particular root is not offered in the current lookup.** It does not isolate whether the filter depends on type, rank, currency activation, report, another property or their combination. Do not promote two-row observations to universal eligibility rules or claim that appearance proves acceptance at Warehouse Save, accounting suitability or transfer correctness.

### HELP-DOCUMENTED — intermediary versus inventory role

F1 from the warehouse form opened installed official **C:\EFA\EFAHELP.chm::/3204.htm**, titled **بيانات المخازن**, explicitly **المتكامل بلاس الإصدار الخامس**. The entire page including its end was read through Computer Use. Under **حساب وسيط التحويلات المخزنية**, it documents a **transfer intermediary affected by inter-branch stock transfer and receipt**: on transfer, inventory is credited and the intermediary debited; on receipt, inventory is debited and the intermediary credited. This distinguishes the field's documented functional role from the Group inventory account. The separate documented **حساب فوارق التحويلات** relates to differences between item cost and selling price during transfers at selling price; it is not this validation's focused field.

The page does **not** specify mandatory account nature (Dr/Cr default), report/classification, rank, currency, a dedicated chart branch or a prohibition/permission on reusing the same account as Group inventory. No visible warehouse currency selector, nature/classification selector or lookup rule explanation was found on the inspected surfaces. The older Help supplies role descriptions, not current Save/filter internals. Current runtime validation proves this field cannot remain blank for the attempted candidate; it does not prove an actual transfer is needed to create/use one warehouse.

### Read-only metadata — bounded support, not semantic proof

A SELECT of current SQL-module names containing W_Acc returned only view **Acc_diff**. W_DETAIL foreign-key inspection returned **FK_W_DETAIL_Account_Acc_Diff**, from **W_Acc_Diff** to **Account.a_code**. This does not identify a SQL-defined rule for the intermediary lookup, connect native edit ID 26 to a specific persisted column, establish every client-side dependency, or imply the intermediary is optional. No warehouse row exists to verify that mapping. No filter was invented from column/object names; no Reference-Lab warehouse/account configuration was accessed or copied in this round.

### Decision — existing candidate versus separate test role

**Existing-account technical candidacy: PROVEN only for lookup visibility of 97070101. Safe reuse/Save acceptance: UNRESOLVED.** It is already assigned as Group A's inventory account. **ACCOUNTING/TEST-DESIGN INFERENCE, not a Motakamel-enforced rule:** sharing it with the intermediary would conflate the two roles that official Help distinguishes and weaken later evidence about their separate effects. Therefore do not use it automatically merely to clear validation. Conversely, **a separate new account is NOT proved system-mandatory**; this discovery must not invent chart/template/numbering/provisioning requirements or claim accounting correctness.

**Narrowest recommended next proposal:** obtain explicit approval for a single dedicated subsidiary test account for the transfer-intermediary role under the already accepted main account, using a separately approved neutral DBL identity and the supported SAR activation path, without changing existing inventory account 97070101 or adding hierarchy levels. That is a proposed isolation choice, not execution authorization or proof that all account defaults/Save requirements will pass. Required nature/classification/report decisions must remain evidence-based; do not change Dr or guess extra fields. After an approved account experiment succeeds, first verify its reload, SAR binding and actual warehouse-lookup presence/selection; only a separately approved Warehouse Save may test acceptance. No existing account was finally selected in this discovery, and no new identity/number was assigned as a system fact.

### Cancel and final stop

Help was closed normally and its absence confirmed in fresh window enumeration. Fresh warehouse observation still showed edit ID 26/code blank. Official **تراجع** was clicked once; confirmation **هل تريد التراجع عن العملية؟** was read and **نعم** clicked to cancel that unsaved Add. Subsequent fresh accessibility showed warehouse identity/branch/account edits disabled and blank, Add/Search enabled, Save disabled: the draft was discarded and the form returned to view mode. The post-Cancel SQL comparison above kept W_DETAIL at zero and protected records identical.

Computer Use skill guided returned-window targeting, one-action/fresh-observation loops and reading screenshots/accessibility without accepting the lookup row. Some immediate post-action accessibility results were null or stale; observation-only refresh resolved them, with no blind repeated inputs. On final Cancel, the returned inventory capture changed from maximized to restored dimensions; no explicit resize/scaling/monitor setting action was issued and its cause was not investigated. No `window crop is outside captured monitor` error occurred in this round; no general capture fix is claimed.

**Discovery complete at field/role/candidate boundary; account choice and Warehouse Save remain UNQUALIFIED. Controlled Zero BLOCKED; S0b PARTIAL; S2/S3 NOT STARTED.** No PARTNER-VALIDATED/PILOT-QUALIFIED, Gate A/B/C or implementation claim. **STOP before account creation, another Warehouse Save or Controlled Zero retry.**

## Host dedicated transfer-intermediary account and unsaved Warehouse selector — 2026-10-07

### Authorization and pre-check

The user approved exactly one new child identity, **97070102 / DBL_TEST_TRANSFER_INTERMEDIARY_20261007**, under existing main **970701 / DBL_TEST_MAIN_20261007**. The separate account isolates the Help-documented transfer-intermediary role from Group A inventory account **97070101**; it is not proof that Motakamel universally requires different accounts. One account Save only was authorized, followed by independent reload, bounded SELECT and a **non-saving** Warehouse picker test. No Warehouse Save, extra account, master edit, stock movement, S2/S3, direct SQL write, backup or Restore was authorized or performed.

Pre-check SELECT at **2026-10-07 17:43:16.5024256+03:00** attributed the source to **DESKTOP-8QRQT7R\YSEDU / EFA12026 / database ID 7**. Counts: W_DETAIL=0, Account=2, Account_Cur_Detail=1, Measure=1, i_group=1, item_detail=1, keyed Item A item_mov=0. Complete bounded account rows showed only the accepted root and inventory child; the new code and name were absent. Existing Unit A, Group A, Item A and SAR link were recorded for comparison. Absence of item movements is not controlled warehouse-scoped zero evidence.

### CURRENT-UI PROVEN — single Save and independent reload

The already open official **إدارة الحسابات → المدخلات → دليل الحسابات** was used, returned GL_New window **95554874**. Add began with blank identity/parent/report fields, unchecked SAR activation and the form's own credit-nature default. Parent **970701**, followed by Tab, derived **rank 2**, displayed **الميزانية العمومية** and `1-أخرى` in the linked-category display without a manual linkage choice. The approved code/name were entered, **type 2 فرعي** chosen from the actual type list, and SAR activated once in the currency grid. Final pre-Save observation verified these values; foreign name, classification, cash flow and financial-analysis fields stayed blank, TDS/stop flags unchecked. No Nature/Classification/Cash Flow/Linked Account value was invented.

Exactly **one Save** was clicked. No validation dialog or tool exception appeared; the form returned to view mode. Immediate SELECT at **17:49:19.3476774+03:00** proved the new Account row and currency row, not merely Save-button success. The chart MDI tab alone was then closed and reopened through its official Inputs ribbon. The newly loaded tree showed all three accounts, and selecting **97070102** independently loaded its correct code/name, parent 970701, type 2, rank 2, Balance Sheet and checked SAR. No Edit or second Save was invoked.

### Read-only persisted values and defaults

Post-reload SELECT at **17:54:15.7855922+03:00**, reconfirmed after Warehouse Cancel at **17:59:38.4264928+03:00**, returned:

| Persisted surface | Observed values |
|---|---|
| Account identity | a_code=97070102; a_name=DBL_TEST_TRANSFER_INTERMEDIARY_20261007 |
| Hierarchy/report | A_Parent=970701; a_s_m=2; A_Level=2; A_Report=Balance Sheet |
| SAR binding | A_Code=97070102; Cur_Code=SAR; Suspend_Cur=false; Default_Cur=true; Min_Amt=Max_Amt=0 |
| Blank/NULL fields | a_name_eng; classification ac_type/ClassType; CashFlowType; FC_Code; limits; note; inspected A_T* linkage fields |
| Boolean defaults | Dr=false; ac_close/AccountForCustomer/ap_in_tbal/FinishTransfer/FinishUpdate/UseTDS=false |
| Creation/default metadata | u_id=1; Flags_No=1; Doc_Serial=3; CrtdBy=1; CrtdOn=2026-10-07 17:48:43.140; CrtdByComputer=DESKTOP-8QRQT7R; TDSType=1; MdfdNo=0; modification user/time/computer NULL |
| Sort observations | New Acc_Sort=NULL immediately after Save, 2 after independent chart reload; root Acc_Sort=2 before and immediately after Save, 3 after chart reopening; existing child remains 1 |

No manual root/old-child modification or SQL write occurred. The complete bounded pre/post comparison found **only root Acc_Sort 2→3 among previously existing inspected rows**. Therefore do not claim all original account fields were byte-identical. Its internal cause and accounting significance remain unresolved; no correction or expanded discovery was attempted. New Dr=false reflects the unchanged displayed/persisted default, not approved accounting nature. UI `1-أخرى` does not prove a stored operational linkage: inspected linkage/classification fields remain NULL. These findings prove this local test record, not universal hierarchy/filter rules or accounting correctness.

### CURRENT-UI PROVEN — Warehouse selector only, then Cancel

Fresh enumeration selected official Warehouse window **7668528 / process:C:\EFA\inv.exe**. It was maximized through its native title bar and Add opened without entering warehouse identity, branch or other draft values. Focus was verified on **edit ID 26**, beside **حساب وسيط التحويلات المخزنية**. F9 opened returned lookup **13569558**, whose grid offered existing inventory child 97070101 and the new transfer child **97070102**. Only the new child's row was double-clicked, returning code 97070102 to the field; its long name was clipped in the lookup column but independently established by chart/SQL.

One Tab left focus at ID 26 and the paired name/currency blank, confirmed by an observation-only refresh. One ordinary click on the empty Arabic warehouse-name field then resolved **DBL_TEST_TRANSFER_INTERMEDIARY_20261007** and **SAR** in the paired displays; current accessibility showed focus on warehouse-name **ID 19**, not ID 26. No validation appeared. This proves actual official selection, full name/currency resolution and normal mouse field exit. It does not explain Tab internals or prove Warehouse Save/posting/transfer semantics.

**Transfer Intermediary Account Candidate = QUALIFIED FOR WAREHOUSE SELECTOR.** Warehouse itself is **not PASSED**. Official تراجع opened **هل تريد التراجع عن العملية؟**; نعم confirmed cancellation of this unsaved draft. The subsequent screenshot showed blank disabled fields, Add enabled and Save disabled. No Warehouse Save was sent.

### Final reconciliation and next boundary

Final counts at **17:59:38+03:00**: **W_DETAIL=0; Account=3; Account_Cur_Detail=2; Measure=1; i_group=1; item_detail=1; keyed Item A item_mov=0**. The new account/SAR row remained persisted. Existing inventory child/SAR row and complete returned Unit A/Group A/Item A rows stayed identical; Group 001 still points to inventory account **97070101**, not the intermediary. Root's sole observed change is the sort value disclosed above. This is a bounded point-in-time reconciliation, not an atomic snapshot or an all-table mutation audit.

Computer Use skill constrained returned-window targeting, one-action/fresh-observation loops, focus checks and exactly one account Save. Some immediate observations were stale/null; observation-only refreshes resolved these without blind repeated inputs. No crop error occurred in this round, and no Windows scaling/security/ACL/UAC change or general capture fix is claimed. No build implementation, connector/Canonical expansion, Account Numbering, Chart Template, initialization, existing-lab operation or Gate A/B/C advancement occurred.

**S1 stays accepted; Controlled Zero stays BLOCKED at missing saved warehouse; S0b PARTIAL; S2/S3 NOT STARTED.** No PARTNER-VALIDATED/PILOT-QUALIFIED promotion. Narrow next proposal, **not executed**: separately authorize one Warehouse A Save using already approved 001 / DBL_WAREHOUSE_A, officially selected branch 1 and this now-qualified transfer selector candidate, keeping other defaults and stopping at first new validation. Successful Warehouse Save/reload would still precede a separate Controlled Zero qualification; do not create a transaction or infer 0→37 readiness. **STOP.**

## Host Warehouse A single Save, independent reload and scoped-zero attempt — 2026-10-07

### Authorization, pre-check and exactly one Warehouse Save

The user accepted 97070102 as qualified for the transfer-intermediary selector and authorized one Warehouse Save, followed only by reload/SELECT and a scoped Controlled Zero attempt. At **20:18:35+03:00**, live read-only evidence attributed the source to **DESKTOP-8QRQT7R\YSEDU / EFA12026 / database ID 7**, with W_DETAIL=0, Account=3, Account_Cur_Detail=2 and Measure/i_group/item_detail=1 each; keyed Item A item_mov=0. Protected identities/defaults were consistent with the preceding accepted checkpoint. No new backup/Restore was performed.

Computer Use continued the approved official **Inventory → Inputs → Warehouse Data → Add** form. Input of number 001 required careful outcome reconciliation: literal type_text did not visibly populate the number; supported accessibility set_value reported `Error: wait for accessibility set value: timed out waiting on channel`. The subsequent observation-only refresh showed **001**, so the operation was not blindly repeated. This timeout was an input-tool observation issue, not a Save validation. Arabic name **DBL_WAREHOUSE_A** was visibly entered; the actual **1 -** branch row was selected from the dropdown. F9 offered the approved transfer child; double-click selected **97070102**. One normal mouse exit to the warehouse-name field resolved the full **DBL_TEST_TRANSFER_INTERMEDIARY_20261007** and **SAR** displays. All other visible fields stayed blank and all special flags unchecked. No Windows/security/configuration adjustment was used.

Exactly **one** click on official **حفظ** was issued in this experiment. No new validation appeared; the form returned to disabled/view fields with Add/Edit enabled and Save disabled. Its warehouse number became **1**, not literal 001. This is observed ERP normalization, not an agent-assigned replacement identity. Save acceptance alone was not treated as persistence proof.

### Independent UI reload and persisted Warehouse defaults

The saved form was exited using its official خروج toolbar, reopened through Inputs → Warehouse Data and searched using بحث. The independent search returned **1 / DBL_WAREHOUSE_A**. Double-click reloaded that persisted row in view mode, showing branch **1 -**, intermediary **97070102**, full account name and **SAR**, with the same blank/default fields. No Edit, copy/add or second Save occurred.

Live SELECT at **20:28:23+03:00** confirmed:

| Persisted field | Actual value |
|---|---|
| W_CODE / w_a_name | 1 / DBL_WAREHOUSE_A |
| Branch_no / W_Acc | 1 / 97070102 |
| W_e_name, w_loc, wh_keepr, w_phone, w_fax | empty strings |
| GLN, Longitude, Latitude, AddressL, AddressF | empty strings |
| FinishTransfer, locked, MrpWrhs, NoSaleIsAllowed, NoOutComAllowed | false |
| PrinterForStore, W_Acc_Diff, WrhsPrdctType | NULL |

The source row has no separate warehouse currency column in this returned projection; **SAR was resolved in UI and separately proven as the intermediary account's active/default Account_Cur_Detail binding**, not invented as a W_DETAIL value. Group 001 remains linked to inventory account **97070101**, distinct from warehouse intermediary 97070102. Counts were W_DETAIL=1, Account=3, currencies=2 and Unit/Group/Item=1 each. **Warehouse A Save + Reload = PASSED** for this exact approved candidate; this does not qualify transfer posting/accounting correctness or all possible warehouse configurations.

### Official scoped report: explicit zero, not absence-of-rows inference

Path: **Inventory → Reports → Stock / المخزون**, form **تـقـريــر المخزون**. The already-open report's warehouse dropdown initially remained empty after the master Save. It was closed normally and reopened from the official Reports ribbon; the new dropdown then offered **1 -DBL_WAREHOUSE_A**. No synthetic warehouse number was typed into a blank selector.

Parameters visibly established before preview:

- Date **07/10/26**; branch from/to **1 -** (current disabled defaults).
- Item from/to **DBL_P001_ITEM_A**, entered into the two actual report filters; other unrelated ranges left blank.
- Warehouse from/to **1 -DBL_WAREHOUSE_A**, each selected from the actual dropdown.
- Unit **UA**, chosen from the actual list.
- Initially **المخزون مع اظهار الاصناف الصفرية** enabled the checkbox **مع الأصناف التي ليس لها تخزين و لا أي حركة مخزنية**; that checkbox was selected.
- Selecting **مع إظهار الكميات بعبواتها** automatically changed the report mode back to **عرض الكمية المتوفرة**, disabled other zero modes and displayed package-report controls. The agent did not silently treat the earlier mode as still selected.
- Package report totals defaulted to **حسب الوحدة**; the official **مستوى الوحدة رقم =** option was selected and its number entered as **1**. This records the actual report parameter, not a universal semantic mapping of level and package.

The official طباعة action opened **Crystal Preview**, not a physical-print submission. No printer/export/save action followed. Preview title was **المخزون حتى تاريخ 2026/10/07**, one page at 100%, headed **حسب الوحدة**. Its single visible row showed branch **1**, name **DBL_ITEM_A**, unit **UA**, package column **1**, and **الكمية كاملة بكل وحدة = 0**. Remaining-unit quantity was blank, **not asserted to be a separate explicit zero**. The narrow item-code column clipped the long identifier; exact identity attribution relies on the recorded exact from/to filter plus the single matching persisted master, not a claim that its full code was visible in the preview. Warehouse restriction is proven in the before-preview filters, not printed as a warehouse column. **Explicit scoped report zero = PROVEN** within these recorded limits.

### Unexpected source change and conservative stop

Post-preview SELECT at **20:40:37+03:00** returned keyed **item_store=0, opn_stock=0, item_mov=1**, whereas the pre-check and post-Warehouse/pre-report read had item_mov=0. A bounded SELECT of the one new row at **20:41:17+03:00** established:

| Row evidence | Actual value |
|---|---|
| i_code / ii_code | DBL_P001_ITEM_A / DBL_P001_ITEM_A |
| w_code / Branch_no / m_measure / Measure_Code / p_size | 1 / 1 / UA / UA / 1 |
| i_qty, inout_qty, p_qty, si_qty, inout_sqty | 0 each |
| free_qty, free_sqty, inout_fqty, inout_sfqty, Pf_qty | 0 each |
| open_stock, open_Fstock, sopen_stock, sub_op_Fstk | 0 each |
| i_cost / stk_cost / i_rate | 0 each |
| doc_type / doc_no / record_no / serial_no | 11 / 0 / 0 / 1 |
| i_date / gr_flag / PKDoc / PKTransDocType | 2026-10-07 / true / 0-0-0-0-1 / 0 |
| Vendor_No / Customer_No | NULL / NULL |

The timing brackets the source change between the pre-report read and post-preview read; **it does not independently prove who created it or that the preview alone caused it**. The row has no nonzero quantity contradicting the displayed zero. It must not be labelled a purchase/receipt or discarded as harmless from doc_type/column names alone. No transaction Add/Save, stock-posting command or direct SQL business write was issued by the agent. Equally, **the observed database state was not entirely unchanged**, so no claim of a side-effect-free report or item_mov=0 baseline is permitted. No row was deleted, altered or restored, and no additional GUI input followed detection.

The eight complete bounded protected records (three accounts, two account-currency links, Unit, Group and Item) compared exactly equal between 20:18:35 and 20:40:37, including previously noted Acc_Sort values. Warehouse alone was intentionally created; the additional zero-quantity item_mov row is separately disclosed. This is point-in-time bounded evidence, not an atomic snapshot or all-table audit.

**Controlled Zero = PARTIAL overall**, despite the explicit scoped UI zero being PROVEN, pending review of the unexplained source-row side effect. The missing saved-warehouse prerequisite is now resolved. **S1 remains accepted; S0b remains PARTIAL; S2/S3 NOT STARTED; no 0→37 transaction occurred or was qualified.** No connector, canonical-field expansion, Gate A/B/C advancement, PARTNER-VALIDATED or PILOT-QUALIFIED claim follows.

Narrowest next proposal, **not executed**: separately authorize read-only interpretation of this single zero-quantity row and the official report's no-storage-item behavior to decide whether it is a synthetic/report-support row and whether the controlled-zero gate can be accepted with this disclosed state. Preserve the row/evidence; do not retry reports randomly, create movement, repair SQL or start inbound to resolve uncertainty. The preview remains visible. **STOP.**

## Host narrow read-only review of the zero item_mov row — 2026-10-07

### Full current row and stability

The user accepted Warehouse A Save + Reload = PASSED, retained Controlled Zero = PARTIAL, and authorized only this bounded read-only source/definition review. One report reread was optional only if safe and without Save. **No GUI action or report regeneration occurred.** The preceding scoped official preview is retained as earlier UI evidence, not relabelled as a fresh live observation. No SQL writes, stored-procedure execution, inbound, S2/S3, master changes, deletion, backup or Restore.

At **20:55:08.6853094+03:00**, SELECT attributed the source to **DESKTOP-8QRQT7R\YSEDU / EFA12026 / database ID 7** and captured **every one of the current item_mov row's 73 columns**, preserving NULL/zero/empty distinctions. The full second row at **21:00:07.5166681+03:00** compared exactly equal, including GUID and every field. Local complete evidence artifact, outside Product Memory: `outputs/host-motakamel-zero-row-review-20261007/READ_ONLY_EVIDENCE.json` under the task workspace. It contains both full observations, attribution/times, counts, projections, dictionary rows, inspected definitions and limitations; no database/backup binary or credential is committed.

Canonical row SHA-256: **DC1991445F7FB86D40C47D28BDA492C30F550D999D94014C0A427443F1BB2165**. Method: all object keys sorted using JavaScript default sort, JSON.stringify, UTF-8 without BOM. This is a client evidence fingerprint, not a raw SQL physical-row hash or atomic snapshot.

| Identifiers / scope | Current values |
|---|---|
| UKeyID | 83158763-eb4b-4f49-b244-84e419d373e7 |
| i_code / ii_code / p_code | DBL_P001_ITEM_A each |
| w_code / Branch_no / m_measure / Measure_Code / p_size | 1 / 1 / UA / UA / 1 |
| doc_type / doc_no / record_no / serial_no | 11 / 0 / 0 / 1 |
| PKDoc / PKTransDocType / PKSubDocType | 0-0-0-0-1 / 0 / 0 |
| i_date / expr_date / Mnfctr_Date | 2026-10-07 00:00:00 / 1900-01-01 00:00:00 / NULL |
| Vendor_No / Customer_No / CmndID | NULL each |
| gr_flag / FinishTransfer / G_Code_Tmp / I_Size_Tmp | true / false / 001 / 1 |

All returned ordinary/sub/free/pack/opening quantity fields and i_cost/stk_cost/i_rate remain **0**. Field names alone were not promoted into universal inbound/outbound/balance meanings.

### Locally defined quantity effect, not event classification

The inspected **dbo.FindAvQty** definition's branch/warehouse path sums inout_qty + inout_fqty and inout_sqty + inout_sfqty, with item/package/expiry/batch handling. Current Item A has i_size=1, p_code=0, p_size=1 and expiry/batch use false. Its **Item_Detail_Units** row binds I_Code/P_Code to Item A, Measure_Code=UA, I_Size=1, Unit_Level=1. Only after verifying the function definition contains read-only SELECT logic, SELECT invoked `dbo.FindAvQty(1,N'DBL_P001_ITEM_A',1,N'',NULL,NULL)`; result **0** at 21:00:07.

At **20:58:50.7393024+03:00**, a direct exact-scope projection found one row for branch 1 / warehouse 1 / UA / package 1 and each sum of **inout_qty, inout_sqty, inout_fqty, inout_sfqty = 0**. The row has no nonzero contribution to this inspected local available-quantity computation; its business class and the preview's exact query path are still unproven. No general missing-row/connector extraction rule follows.

**CheckQtyNoMinus**, the observed AFTER Insert/Update trigger, calls FindAvQty and raises a negative-quantity error under its condition; its inspected definition does not insert the row. **AvQty_Item_Mov** aggregates into **AV_QURY**, using item_mov for one report type and item_store for another. It contains INSERT into AV_QURY, not item_mov, and was **read, never executed**. Presence alone does not establish use by this preview. Targeted read-only installed inv.exe string search for literal item_mov inserts/doc_type=11 predicates returned no matches; this cannot exclude dynamically assembled code. No decompilation/patching or application execution was used for that search.

### Distinct dictionaries and missing binding

Current local rows:

- **doc_types.doc_type=11:** Arabic **إعتماد فاتورة**, English NULL.
- **TransDocType.PKTransDocType=0:** Arabic **مخزون الافتتاح**, English **Open Qty  s**, language rows 0–3. No selected PKTransDocType=11 row was returned.

Neither description is assigned to the movement's business role. No item_mov FK to either dictionary or document header was found; its observed FKs bind item_detail, Item_Detail_Units, Measure and branch masters. The targeted SQL-module search did not establish the binding of doc_types to item_mov.doc_type=11 or this zero-row insertion path. **Get_Group_Amt_Bills** has an unrelated **@Type_Group=11** context; that value is not this row's doc_type definition. The earlier Bills.Bill_Type versus journal.doc_type namespace distinction remains intact.

### Related documents, chronology and preserved masters

Exact **COUNT_BIG**, not merely partition metadata, returned **0** in each of these 18 checked business tables:

`Bills, Bill_detail, RT_BILLS, rt_Bill_detail, gr_note, gr_detail, rtnincm_note, rtnincm_det, Good_Trans_M, Good_Transfer, stk_adjustment, stk_adjustment_det, journal, Journal_Master, IncmRqustMstr, IncmRqustDtl, IncomRqustMstr, IncomRqustDtl`.

The request spelling variants were checked separately, not treated as aliases. **opn_stock=0; item_store=0; total item_mov=1**. None of the empty checked tables can contain a header/detail matching this row's identifiers or a new related transaction. This is **no related business document found in the checked scope**, not a whole-ERP audit or proof against undocumented relationships.

Users_Logs queries returned no selected-table row in the relevant post-20:18 interval and no match for this UKeyID; audit completeness was not established. No producer/timestamp inference is made from missing logs.

Earlier post-Warehouse/pre-report **20:28:23** count was 0, post-preview **20:40:37** count was 1, and this review **20:55:08–21:00:07** stayed 1 with a fully equal row. The observed schema has i_date/expr_date/Mnfctr_Date but no insertion timestamp. **Midnight i_date and a NEWID-default GUID are not insertion clocks.** The time bracket does not establish preview-only causality.

Nine complete protected records (Warehouse, three accounts, two SAR links, Unit, Group and Item) exactly matched their prior **20:40:37** full rows after key-sorted JSON comparison. Counts remain W_DETAIL=1, Account=3, Account_Cur_Detail=2 and Measure/i_group/item_detail=1 each. Paused-UI live SELECTs are not atomic/frozen acquisition or qualified least-privilege connector reads.

### Decision and deliberate non-rerun

**B) Controlled Zero = PARTIAL.** The earlier explicit scoped UI zero is noncontradicted by the current row quantities and local quantity function. No nonzero stock/business state was found in the checked scope; BLOCKED on that ground is not justified. However the precise doc_type=11 role and potential report insertion behavior remain **UNRESOLVED**, so PASSED is not claimed.

The optional single reread was not performed because the preceding possible persistent report effect is still unexplained; safe side-effect-free regeneration is not established. No fresh preview, before/after-rerun comparison or repeatability proof is fabricated. This does not claim every report writes data.

**Warehouse Save/reload PASSED; S1 accepted; S0b PARTIAL; S2/S3 NOT STARTED.** No Gate A/B/C, connector/canonical, PARTNER-VALIDATED or PILOT-QUALIFIED promotion. Narrow remaining evidence concerns the exact local report/initialization insertion path or authoritative binding for item_mov.doc_type=11. Further runtime/report experiment requires separately bounded authorization acknowledging the unresolved possible source effect. Preserve the row; cleanup or inbound is not a diagnostic substitute. **STOP.**

## Host S0b non-saving inbound route comparison — 2026-10-07

### Authority, retained zero boundary and acquisition

The user explicitly accepted **Controlled Zero = PARTIAL** without promotion, retained the prior zero row as noncontradictory, and removed its unresolved provenance as a blocker to **S0b discovery only**. This supersedes the preceding proposal to investigate doc_type=11 further now. The existing `outputs/host-motakamel-zero-row-review-20261007/READ_ONLY_EVIDENCE.json` was preserved; no dictionary/producer/provenance investigation or stock-report regeneration occurred. Its **DC1991445F7FB86D40C47D28BDA492C30F550D999D94014C0A427443F1BB2165** 73-field fingerprint remains the comparison baseline. This direction does not authorize S2 execution or classify Controlled Zero PASSED.

Current Product Memory/plan context was refreshed. Computer Use was used for official application UI, fresh target-window observations and verified Cancel dialogs. No terminal-driven GUI, security setting change or alternative ERP mutation path was used. SQL access used SELECT-only bounded source/catalog queries; database attribution remained **DESKTOP-8QRQT7R\YSEDU / EFA12026 / database ID 7**. The build checkout was inspected separately, not treated as implemented from Product Memory; it was unchanged, HEAD `0fb18e9`. No connector implementation claim or change follows.

Local evidence packet: `outputs/host-motakamel-s0b-route-comparison-20261007/READ_ONLY_EVIDENCE.json` in the task workspace. It records final raw bounded SELECT rows/counts, comparisons, observed UI facts, official help limits and operational deviations. It is not a stored GUI image, atomic acquisition, backup or implementation test. Original GUI observations were displayed through Computer Use; no screenshot payload was decoded or saved.

### S2-P — current official Purchase Add

Official path: **إدارة المشتريات → العمليات → فواتير مشتروات فورية**, `Prch.exe` window 136168. One unsaved Add was inspected and then cancelled. **No item, quantity 37, price/cost or saved invoice identifier was entered.**

| Field / behavior | CURRENT-UI PROVEN | Limits / dependency |
|---|---|---|
| Payment | Default `1 - نقد`; list offers cash, cheque, cheque+cash and `4 - أجل` | Credit was selected only in the cancelled draft to inspect its conditional fields. No payment mode was committed. |
| Cash route | Cashbox code/name and account currency blank; F9 cashbox picker had no rows | First missing current cash-route reference is a cashbox. SELECT later confirmed `cash_in_hand=0`. Not a Save-validation result. |
| Credit route | Switching to credit changes cashbox label to supplier; due date appears blank and tax-before-discount control becomes disabled; F9 supplier picker had no rows | First missing credit-route reference is supplier. SELECT confirmed `V_detail=0`. No supplier/account was created or chosen. Supplier is not asserted universally compulsory for cash. |
| Cheque variants | Actual choices visible | Bank routes not exercised; SELECT `cash_at_bank=0`. No bank/payment-channel setup inferred as compulsory for cash/credit. |
| Currency / rates | Invoice currency, exchange rate and inventory conversion rate blank before a payment master is selected | Earlier installed official Purchase Help documents currency following selected cashbox/bank/supplier account. Current SAR/rate derivation and acceptance remain UNRESOLVED; no guessed rate 1 or implicit FX. |
| Number / date / state | Add displays number `1`, date `07/10/26`, posted control disabled/unchecked; source-document and service-invoice controls unchecked | `1` is an unsaved UI display, not the future saved identity. No posting, approval or stock-effective completion proved. Capture the real identifier only after a future authorized Save. |
| Warehouse / cost center | Both blank in this Add; line grid contains unit code/name/unit/warehouse/quantity/free quantity/cost/tax/charges | Warehouse A is saved in the source, but this Purchase picker/line binding was not separately qualified before the payment gap. No new warehouse inferred. Current compulsory cost-center/tax/charge rules remain UNRESOLVED. |
| Item / unit / package / cost | Grid surface visible, no detail row populated | Existing Item A / UA / package 1 are accepted master facts, not yet a Purchase-line acceptance result. Help documents quantity and per-unit cost; actual cost basis, local/payment currency and any required tax/defaults must be proved before using the plan's conditional price. No price/cost 10 was guessed or typed. |

The prior locally inspected official **version-5 Purchase Help** remains HELP-DOCUMENTED, not a fresh Save result: this is the local known-cost purchase route, including added-cost handling; it distinguishes cashbox/bank/credit-supplier choices. It also documents inventory Supply Order as an alternative for known cost without added charges. This is neither proof of current Host accounting correctness nor a universal requirement for Supplier in every purchase mode. No validation was solicited by Save.

### S2-R — current official Supply Add and Help

Official path: **إدارة المخزون والجرد → العمليات → أوامر التوريد**, form `أمــــر توريد مخزني`, `inv.exe` window 7668528. The previously open form first had an empty warehouse dropdown. Its Add was cancelled, the form closed normally and reopened through the official Operations control; fresh Add then offered **`1 -DBL_WAREHOUSE_A`**. This is a stale-form observation corrected by reopening, not a missing Warehouse or permission/configuration change.

| Field / behavior | CURRENT-UI PROVEN | HELP-DOCUMENTED / unresolved boundary |
|---|---|---|
| Number / date | Unsaved number `1`, date `07/10/26` | Automatic sequence/date documented; future persisted identifiers not preassigned. |
| Account | Blank; F9 offers `97070101 — DBL_TEST_CHILD_20261007` and `97070102 — DBL_TEST_TRANSFER_INTERMEDIARY_20261007`, not root 970701 | Official Supply Help explicitly defines **credit side**, cashbox/bank/supplier account depending on purchase method. Neither candidate has been approved for that role. No row was accepted. Lookup visibility is not financial/business eligibility. |
| Currency / FX | Account currency initially blank; inventory-summary SAR appeared during later observation | Help says choose a currency linked to the selected account; foreign-account currency exposes exchange rate. No account choice or current conversion behavior was qualified. SAR inventory does not prove document currency automatically. |
| Warehouse | Reopened current picker offers saved Warehouse A | No final warehouse/detail-line binding or Save verified. Dropdown collapse briefly displayed `1` during transition; no acceptance claim is made from that transient value. |
| Supply type | Dropdown empty | Help explicitly calls this optional, referring to coded types in inventory setup. **Do not invent a mandatory type/template prerequisite**; current Save enforcement remains untested. |
| Supplier / customer | Blank controls | Help makes these conditional on account linkage to supplier/customer; it does not establish unconditional supplier requirement. No accepted account to test this behavior. |
| Cost center | Blank | Help makes use conditional on inventory configuration, including compulsory/optional and single/multiple centers. Current mandatory status not proved. No options modified. |
| Source / return controls | From-document and return-of-stock-issue unchecked; document type/number blank | No source document, transfer or opening balance invented. Review/status/stock-effective state not exercised. |
| Details | Item code/name/unit/warehouse/quantity/cost/total columns visible; no line entered | Help documents unit selection from item master, quantity and selected-unit cost. Current Item A / UA / package 1 line behavior remains untested behind the account gap. No quantity/cost or stock effect was attempted. |

**Installed official Help actually opened by F1 from Supply:** `C:\EFA\EFAHELP.chm::/3301.htm`, labelled **المتكامل بلاس الإصدار الخامس**. It documents known/finalized cost without added charges, account as credit side, account-linked currency, optional supply type, configuration-dependent cost centers and per-unit cost. It says warehouses are affected on Save while accounts/financial statements are affected after posting, and describes the accounting direction inventory debit → cashbox/bank/supplier credit. These are **HELP-DOCUMENTED** mechanics; the current application has not saved/posted a Supply Order here, so current timing, generated journal rows, document-state eligibility and deterministic source reconciliation remain UNRESOLVED. Even a future qualified S2-R would be inventory movement evidence only, not purchase/Pilot evidence.

The Group inventory account 97070101 and Warehouse transfer intermediary 97070102 remain preserved in their separately approved roles. Neither is reassigned to fund/offset this new receipt merely because its code appears in F9. This is a semantic qualification gap, not proof that Motakamel's lookup rejects the accounts. No independent account/template/numbering investigation, account Add or master Save was performed.

### Classification, minimum next discovery and no guessed provisioning

**BOTH BLOCKED** — neither candidate is currently qualified for execution. This means the **readiness gate** is blocked by missing justified payment-side references, not that a forbidden Save proved both forms invalid or that their remaining requirements are exhaustively known. **S0b PARTIAL; S2/S3 NOT STARTED.** No inventory movement, Purchase evidence, connector capability, Gate A/B/C, PARTNER-VALIDATED or PILOT-QUALIFIED advancement.

- **S2-P cash first missing reference:** actual saved cashbox with suitable payment-side account/currency; cashbox picker and `cash_in_hand=0` agree. **S2-P credit alternative:** actual saved supplier/account/currency; supplier picker and `V_detail=0` agree. Banks are also absent, but no cheque route is recommended to add requirements.
- **S2-R first unresolved/missing qualified prerequisite:** an independently justified credit-side account/currency for the intended controlled receipt, rather than either existing inventory-role TEST account. Empty supply type is not the blocker. Help suggests cashbox/bank/supplier based on the operation; no proven supplier-free, financially neutral bypass exists on Host.
- **Preferred next action, proposal only:** keep S2-P preferred for Pilot #001 and authorize **non-saving Add discovery of one cashbox** via the currently visible official **إدارة الحسابات → المدخلات → الصناديق**. This was observed as a menu path only; its Add model was not opened. Determine whether one narrow cashbox plus a separately justified SAR payment account suffices for the default cash-purchase route, versus a larger required setup. No cashbox identity, account number/parent/nature, opening cash balance, currency rate or Save is approved. If a supplier-credit route is preferred instead, its official master editor/prerequisites still need bounded discovery; the Purchase Reports control `بيانات الموردين` opened `avend.rpt`, **not** a Supplier master creation form, and must not be misreported as that editor.
- After separately approved/proved payment-master provision, recheck the **chosen single** inbound draft's Warehouse A / Item A / UA / package 1, document/account SAR and cost basis before seeking one transaction Save authorization. This round cannot promise that provision alone will suffice. No master chains, extra chart, parallel P+R transaction, guessed document type/cost or automatic prerequisites are authorized.

### Cancellation, operational deviations and bounded preservation

All transaction Adds were officially cancelled via **تراجع** and the actual modal **«هل تريد التراجع عن العملية؟» → نعم**; final forms showed Add enabled and Save disabled. No transaction Save/Accept/posting was sent. Picker cancellation was targeted to its own current window; no lookup plus/new-master action was used.

Operational disclosure: an unlabelled Purchase ellipsis opened an empty purchase-by-supplier preview (`apb_vnd2.rpt`) instead of a lookup; it was closed without print/export. Checking the `بيانات الموردين` Reports menu opened the empty supplier-data preview (`avend.rpt`); it too was closed without print/export. **Neither was the stock report**, and the pre-existing stock preview was merely visible, never regenerated. A Supply Add accessibility target timed out; a fresh observation showed Add still enabled and Save disabled before a screenshot-coordinate Add. Supply Help appeared asynchronously and blocked a subsequent parent click due to overlapping hh.exe; no click was delivered to the wrong target. Closing Help restored the parent to smaller dimensions, so an out-of-bounds Cancel click was rejected and the observed official Ctrl+U shortcut used instead. A Main Menu capture initially showed the Purchase surface; activating the actual target and observing again corrected it before any action. No Windows settings/UAC/ACL/elevation/compatibility or host security modifications followed these capture/targeting issues.

Final SELECT at **2026-10-07 22:14:07.7419073+03:00** confirmed Warehouse=1, Account=3, Account_Cur_Detail=2, Measure=1, i_group=1, item_detail=1; **V_detail=0, cash_in_hand=0, cash_at_bank=0**. The nine complete bounded protected rows compared exactly equal to the preceding 21:00:07 observations using key-sorted JSON. The sole Item A movement row still has **all 73 fields exactly equal** to the retained canonical baseline, hence the same fingerprint; this is a comparison only, not further interpretation of doc_type/provenance. **All 18 previously checked business header/detail/request/journal tables stayed at exact count 0; opn_stock/item_store=0; total item_mov=1.** This is bounded, paused-UI, point-in-time evidence, not an atomic/whole-ERP audit or proof that every possible table is unchanged.

No master creation/change, SQL write, stock report rerun, zero-row edit/delete, backup/Restore, S2/S3 or connector work occurred. Product Memory changes record this material S0b evidence and explicit user decision only. **STOP before any transaction Save or automatic prerequisite provision.**

## Host non-saving Cashbox Add discovery — 2026-10-07

### Authority, context and evidence package

The user accepted BOTH BLOCKED at payment/account prerequisites, retained S2-P as preferred and Controlled Zero = PARTIAL as nonblocking for S0b discovery. This task inspected **only** the Cashbox Add form and related official Help/source metadata. No Save was permitted even to provoke validation; no Supplier Add, Purchase Save, account creation or stock-report regeneration was permitted.

Current official path: **إدارة الحسابات → المدخلات → الصناديق → إضافة**, in `C:\EFA\GL_New.exe`, window 95554874, financial year 2026 / branch 1 / user Adm. The Inputs cashbox ribbon opened the form; its window was maximized operationally to expose the complete balance grid, without changing Windows settings. Product decisions/plans were refreshed; this is not implementation work, and no capability is promoted from Product Memory intent to verified build behavior.

Local bounded evidence: `outputs/host-motakamel-cashbox-discovery-20261007/READ_ONLY_EVIDENCE.json`, SHA-256 **33C3E9CD64E41FAE66C1A94A3F1B2705FB15280FC44001CBCE137FAB016865F0**. Raw bounded before/after rows and Help text are retained outside Product Memory, not committed database exports or image payloads. The prior zero-row evidence packet and canonical baseline were not changed.

### CURRENT-UI PROVEN: Add fields and defaults

| Field / surface | Observed Add state | Qualification limit |
|---|---|---|
| رقم الصندوق | **1**, assigned to the unsaved draft after Add; blank again after Cancel | Not a persisted/generated final identifier or approval to create Cashbox 1 |
| رقم حساب الصندوق + adjacent name display | Blank | F9 inspected; no code/name selected or final binding tested |
| اسم الصندوق / الاسم الأجنبي | Blank; enabled on later stable Add observation | No name validation or automatic name inheritance tested |
| رقم التسلسل | Blank | Help explains receipt/payment sequence groups; current Save mandatory/default behavior unresolved |
| صندوق نقطة بيع | Unchecked | No POS use requested |
| النوع: قبض / صرف / بيع وشراء | All unchecked | No flag toggled; do not equate بيع وشراء with mandatory ordinary purchasing permission |
| إيقاف / تاريخ الإيقاف / سبب الإيقاف | Unchecked / blank date mask / blank reason; date disabled while not stopped | No stop configuration changed |
| البيانات المالية grid | Five empty display rows; headers include account, currency code, repeated limit/balance labels and suspended checkbox; no SAR populated | Empty grid is not an account balance or proven currency activation; unlabeled repeated columns not assigned guessed meanings |
| Branch / separate currency / responsible person / location / supplier / bank / cost-center selector | No such control observed on the complete Add surface | UI absence does not prove no hidden Save rule; context branch 1 is not a saved cashbox Branch_no |

Save became enabled and Add disabled. The first immediate accessibility response retained stale disabled field states; a later stable observation showed editable fields and draft number 1. No temporary test name/code, sequence, flag or balance was entered. The account-box screenshot's narrow caret is not an entered account value: its accessibility value remained empty.

### HELP-DOCUMENTED: the cash account and currency role

F1 opened installed official **version-5** Help at `C:\EFA\EFAHELP.chm::/1803.htm` (**تعريف الصناديق**). Its documentation is not a current Save acceptance test:

- Cashboxes are prepared after the chart and used for depositing/disbursing cash in receipts/payments and other operations; each box links to its **own chart account**.
- Account code is selected using F9; the documented list contains **subsidiary accounts**, not main accounts.
- The account name becomes the default cashbox name and can be renamed. This propagation was not exercised because no candidate was offered/selected.
- Sequence groups govern receipt/payment voucher numbering across boxes; the examples are explanations, not approved test values or evidence that blank sequence saves on this build.
- POS flag makes a box available to POS. Receipt/payment/buy-and-sell flags are documented for **remittance/currency exchange**, not proof that the buy-and-sell flag is required for an inventory purchase invoice.
- The bottom grid shows **cash-account balances per currency**; minimum currency limits come from the chart account. This supports account-level SAR binding, not a separate cashbox FX setup.

The already recorded Purchase Help says available invoice currencies follow the selected cashbox/bank/supplier account. Taken together these document the proposed SAR account → cashbox → invoice-currency path. It has not been tested with a saved cashbox, so current purchase SAR/rate/default behavior remains unresolved. No Help statement inspected established a mandatory debit/credit nature, classification, report, rank number beyond subsidiary, special linked-account category, new branch/currency master or opening cash balance for this form.

### CURRENT-UI PROVEN: account selector is empty; exact eligibility unresolved

From the blank **رقم حساب الصندوق** field, F9 opened actual lookup window **918952 / شاشــــة البحــــث العامه**. It showed disabled status **1- الفعال**, empty search fields and columns **رقم الحساب / الاسم / نوع الحساب**, with **no rows**. Neither 97070101 nor 97070102 was offered; no row was accepted. The lookup was cancelled and the account code/name remained blank.

Both existing children are known subsidiary/type 2/rank 2, with active/default SAR and not stopped, but are dedicated to Group inventory and Warehouse transfer respectively. Their absence here is a material difference from the earlier Group/Warehouse/Supply lookups. It does **not** prove which extra condition excludes them: linkage/specialization, existing role usage, permissions, another filter or a UI issue remain alternatives, not identified causes. Do not automatically reuse either account, change ac_type/nature/classification, or assume a new identical child will be offered.

No current Cashbox Save validation was solicited. Therefore **the complete minimum saveable cashbox configuration is NOT proven**, and no literal Save-error requirement is invented. Cashbox number + its subsidiary account/name and account-supported SAR are documented candidate prerequisites; sequence and any hidden validation remain unresolved.

### Bounded SQL STRUCTURAL EVIDENCE, not business semantics by names

Observer used the existing supported ordinary-user integrated-authentication context for SELECT/catalog reads of Host `DESKTOP-8QRQT7R\YSEDU / EFA12026 / DB_ID 7`; FMMA was not the observer. Read evidence is paused-UI/live point-in-time, not an atomic snapshot or connector acquisition qualification.

- `cash_in_hand.cash_ac` is NOT NULL and has `FK_cash_in_hand_Account` to Account.a_code; cash_no is NOT NULL. This corroborates the Help's account reference structurally, not UI Save rules or a valid financial role by itself.
- `Branch_no` is NOT NULL with catalog default 0. No branch chooser appeared in Add; **actual future saved branch cannot be inferred as 1 or 0** from context/default alone.
- sr_no and cashbox names are nullable; type/POS/stop flags have catalog false defaults. Nullable columns do not prove optional UI Save fields, and no table currency column appeared in the inspected definition.
- Read-only definition **GetCash** joins cash_in_hand to Account and Account_Cur_Detail, projects Cur_Code and filters **A_S_M=2 / ac_close=0**. This establishes that this local view relates cashboxes to subsidiary account/currency rows. It is **NOT proven to be the Add F9 lookup**, and cannot explain that lookup's empty result or establish purchase Save eligibility.
- Definition **GetPrivAccountCash** relates an already saved cashbox/bank account to branch/group account permissions; its group-1 early return is source logic only, not a finding that the current UI user's permissions are the blocker. No permissions changed.
- Two bounded attempts to observe recently cached application Account SQL returned no matching text. Only the two directly relevant definitions above were read; unrelated posting procedures were not executed/read to broaden this task. Exact selector filter remains UNRESOLVED.

### Cost comparison and narrow next proposal — no mutation authority

**Cash route:** a dedicated justified subsidiary cash account with officially active SAR plus one named cashbox is the smallest *candidate* master-data path evidenced so far. Proposed neutral identity only: **97070103 — DBL_TEST_CASH_ACCOUNT_20261007** (absent among the unchanged three accounts), and label **DBL_CASHBOX_A**. Neither is created/approved by this discovery; no cashbox final number or sequence is preassigned. Parent/report/nature/classification/linkage/eligibility for this new role must not be copied blindly from the two prior test children.

Before proposing its Save, the narrow unresolved question is **why this Cashbox account selector offers no existing subsidiary SAR account, and what exact official property makes a dedicated cash account selectable**. Resolve that specific rule without changing current accounts; if it cannot be resolved non-saving, propose one separately authorized discriminating experiment with exact values and stop before its Save, rather than guessing a cash specialization or configuring broad ERP setup.

**Supplier/credit route:** existing evidence only proves the credit Supplier lookup empty and V_detail=0, with payment/currency linked to its reference. Supplier Add/save/account requirements were NOT investigated here. Consequently Supplier A is **not proven shorter**, nor is the cash route proven globally shortest. Comparison **UNRESOLVED**; S2-P remains preferred for purchase semantics, not qualified for execution.

Even a future saved cashbox/account pair would only address the named payment reference if the Purchase picker accepts it and resolves SAR. Invoice warehouse/currency/rate, Item A purchase-unit/package/quantity eligibility, cost/tax/mandatory fields, document status and stock-effective completion still require their bounded proof. No claim that Cashbox A alone closes all S0b or produces 0→37; S2-P versus S2-R semantics remain distinct.

### Cancellation, source preservation and operational limits

Cashbox Add was cancelled via **تراجع → هل تريد التراجع → نعم**, ultimately targeting actual modal **4065022**. Final observation showed **Add enabled / Save disabled / Cancel disabled**, draft number/account/name blank. No Save/Accept, account/cashbox/supplier creation, purchase action, report generation, stock movement, SQL write, backup/Restore or S2/S3 occurred.

Operational disclosure: the key intended to close Help was followed by the parent's **هل تريد الخروج من البرنامج ..** dialog; it was declined, not approved. No business field changed and no application exit was accepted. Some interim captures showed Help or the parent instead of the named target; these were not treated as semantic proof. One indexed cancel action was rejected as unavailable in the cached state. The first parent-coordinate Cashbox Cancel confirmation did not end Add; it was not claimed successful. Selecting/activating the actual Cancel dialog and clicking its observed Yes button then ended Add, confirmed by enabled/disabled controls. These are capture/targeting observations, not a diagnosed Windows or ERP cause; no Windows/security/compatibility settings changed.

Full-row SELECT at **22:45:18.3767594 → 22:59:53.4964358+03:00**: `cash_in_hand=0 / V_detail=0 / cash_at_bank=0`; Warehouse=1, Account=3, Account_Cur_Detail=2, Unit=1, Group=1, Item=1, keyed item_mov=1. All **nine protected full rows** matched before/after and the previous 22:14:07 evidence. The sole movement row retained all **73 fields** and fingerprint **DC1991445F7FB86D40C47D28BDA492C30F550D999D94014C0A427443F1BB2165**, identical to the preserved canonical baseline. No further doc_type/provenance investigation or zero promotion was attempted. No new all-table/18-business-table audit is claimed from this narrower query.

**Final: Cashbox discovery PARTIAL; account role HELP-DOCUMENTED, complete Save requirements and selector rule UNRESOLVED. S0b PARTIAL / BOTH BLOCKED; S2-P preferred; Controlled Zero PARTIAL, not a blocker for this discovery by explicit user decision. S2/S3 NOT STARTED. STOP before any new account/cashbox/transaction Save.** No Gate A/B/C, connector, PARTNER-VALIDATED or PILOT-QUALIFIED promotion.

## Repository handling

The unrelated untracked `products/legacy-intelligence/research/.vscode/` directory was preserved and must remain unstaged. Explicit staging is limited to this evidence note and the README entry linking the current host decision. The authorized test identities and bounded observed values are documented here; backup binaries, database export files, credentials and unrelated files are not committed.
