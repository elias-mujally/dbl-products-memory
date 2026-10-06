# Host Windows 11 Motakamel development baseline — 2026-10-06

**Latest prerequisite discovery: blocked at the missing inventory account.** Official installed Group help explicitly requires that account and matching inventory/account currencies. At 2026-10-06T20:24:02+03:00, a fresh SELECT tied the current GL/inv sessions to EFA12026 and returned zero Account and Account_Cur_Detail rows. No provisioning or record creation was attempted. The bounded Computer Use and backup results below remain valid; they do not qualify Host S0a/S1 prerequisites.

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
| Isolated restore | NOT PERFORMED; no new database or database overwrite authorized. |

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

## Repository handling

The unrelated untracked `products/legacy-intelligence/research/.vscode/` directory was preserved and must remain unstaged. Explicit staging is limited to this evidence note and the README entry linking the current host decision. Backup binaries, database rows, credentials and unrelated files are not committed.
