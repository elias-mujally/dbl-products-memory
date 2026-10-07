# Host Windows 11 Motakamel development baseline — 2026-10-06

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

## Repository handling

The unrelated untracked `products/legacy-intelligence/research/.vscode/` directory was preserved and must remain unstaged. Explicit staging is limited to this evidence note and the README entry linking the current host decision. Backup binaries, database rows, credentials and unrelated files are not committed.
