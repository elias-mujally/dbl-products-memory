# YSEDU activation readiness — bounded review, not maintenance

**Direct-port amendment (later on2026-10-11):** follow the
[revised transport/procedure gates](MOTAKAMEL_DIRECT_PORT_TRANSPORT_2026-10-11.md).
The owner approved adapter transport changes only in that task, not host maintenance.
Original key/certificate/rollback evidence below is retained; Browser startup/discovery
is no longer part of the selected direct-port forward procedure.

Date: 2026-10-11, Asia/Aden +03. Owner authorized read-only access qualification and correction/review of forward and rollback procedures only. No installation, SQL interruption or network activation is authorized by this report.

## Decision

**READY FOR ONE BOUNDED MAINTENANCE**, subject to a separate execution approval and fresh pre-stop gates. This means the existing signed leaf, key-access requirements and corrected rollback are ready for that limited procedure. It does **not** mean NETWORK READY, SQL2014 LOADING PASSED, strict Node TLS qualified, or FIRST LIVE DATA PASSED.

Actual administrative read-only preflight at **17:49:56.9172865+03** passed. The local result matches the operator JSON; SHA256 `82E590F881ECF7EBC34B48865F5580D0C552220BAFECE730725789C81C4AEEAE`. [Preserved actual result](research/DBL_YSEDU_ACTIVATION_READINESS_001_YSEDU_ACTIVATION_READINESS_001_RESULT.json). A separate service read at17:51:24+03 still found YSEDU Running and SQLBrowser Stopped. No installation/acceptance, key creation/export/signing, ACL/trust/Firewall/registry/service/network changes or SQL connection occurred.

The earlier [signed leaf evidence](DBL_YSEDU_EXISTING_CSR_LEAF_SIGNING_001_2026-10-11.md) and CAPI-only #003 proof remain qualified within their existing limits; neither was repeated. Archive work remains PAUSED; S3 remains ACCOUNTING-BLOCKED. No Connector, Canonical or ERP changes.

## Current access and network evidence

- Original captured settings are intact, including empty certificate binding, TCP disabled, ListenOnAllIPs=1, IP4 disabled/dynamic-port sentinel0/static-port empty, and SQLBrowser Disabled/Stopped. Original JSON SHA256 `BB3BF707DCEEDB99396BF2C598B3A0E9BF2E02E83F3FD7AE3A8DB27CF1931BD5`. RequireBaseline inspection of the new rollback passed with zero changes and zero LocalMachine/My certificates.
- Service identity remains MSSQL$YSEDU, LocalSystem, PID5072. Pending certificate public key matches the signed leaf. An existing provider context was opened only to read its storage locator and was released; no key handle, challenge or signing. The real key path and container name are intentionally not published.
- The located key file and ancestors contain no reparse points. Its DACL contains an explicit effective SYSTEM allow covering FILE_GENERIC_READ (0x120089), with no deny ACE. Owner/group/DACL rereads are equal; descriptor SHA256 `119EE2FB1E288527CD7128D069EC147F2C5E203DB8709B655A0B2A5FDDA2ED82`. Five certificate-store inventories remained unchanged. This is a conservative DACL requirement check, **not** impersonated SYSTEM cryptographic use or proof that SQL can load the certificate. SACL is not needed to establish this read-access requirement; the paused recovery-manifest qualification is not resumed or waived.
- The approved TCP candidate **192.168.56.1 / IP4** is Preferred on an Up VirtualBox Host-Only Ethernet Adapter, and host DNS includes it. This is a current address check, not a listener or Node routing proof; host-only is not synonymous with loopback or zero exposure to virtual guests.
- The pinned Browser policy helper passed again under the operator's administrator token: no candidate inbound UDP1434 allow rules, no missing filter joins, enabled blocking profiles, no experimental clients and no UDP1434 listener. The installed NetSecurity Action enum was independently read without Firewall access or writes: NotConfigured=0, Allow=2, Block=4. Thus the recorded numeric4 is Block, not NotConfigured. Static policy is **not packet reachability proof**, nor a promise of loopback-only Browser binding.

[SQL certificate requirements](https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/certificate-requirements?view=sql-server-ver17) require service access to the private key; this report does not substitute the DACL check for actual SQL loading. [CryptGetProvParam](https://learn.microsoft.com/en-us/windows/win32/api/wincrypt/nf-wincrypt-cryptgetprovparam) documents the unique-container locator used for the read-only storage lookup.

## Corrected unified rollback #002

[Reviewed source](research/DBL_YSEDU_ACTIVATION_READINESS_001_Restore-YseduLeafNetwork002.ps1). Original #001 remains byte-for-byte preserved for historical pins; **do not use it for the actual signed leaf**. No fabricated old-shaped signing result was created.

The new rollback pins the actual result `YSEDU_LEAF_SIGNING_001_RESULT.json` (SHA256 `756917FF89B109902D5E88CBDDC487B121C1B830B9EECAEF302DE441E6C505C4`), actual Decision `YSEDU_EXISTING_CSR_LEAF_SIGNED_AND_PROFILE_QUALIFIED`, and actual field `CAThumbprint`. It requires leaf thumbprint **A51BD253B6083D0114428FCFBAD57D008CD102F5** and DER SHA256 **522C79FD31F0422D3988FB00CC4EF0A51B4042DEED72A435A6519237AC548DFE**, plus the approved CA/CSR identity and successful evidence flags. Unknown or missing ownership fails closed.

| Target | Only owned forward difference accepted by rollback | Restored state |
| --- | --- | --- |
| YSEDU Certificate | Exact owned leaf thumbprint, including registry lowercase form | Original captured empty string |
| YSEDU TCP Enabled / ListenOnAllIPs | 1 / 0 | Original 0 / 1 |
| YSEDU TCP IP4 Enabled | 1 | Original 0 |
| IP4 TcpDynamicPorts | Actual assigned numeric port1..65535 after startup | Original sentinel0 |
| SQLBrowser Start / runtime | Manual3, conditionally started | Original Disabled4 / Stopped |
| LocalMachine/My | At most the one exact owned leaf | Remove that public store entry only |

Static port, other IPs, ForceEncryption, startup flags, other instances, trust roots, unknown certificates and unowned settings are rejected, not reset opportunistically. The original types, presence and values are retained. No private-key deletion API is used. Removal uses X509Store.Remove, not certificate-provider DeleteKey. The pending request/store lifecycle after a future certreq acceptance is not asserted to be restored: rollback restores operational binding/network/Browser and the owned My entry, preserves the persisted key, and is **not** a byte-for-byte undo of enrollment history.

Default execution is inspection only. Apply requires explicit MaintenanceAuthorized, actual administrator, YSEDU already Stopped, stopped dependents and no concurrent drift. It never stops/starts SQL. It can stop only SQLBrowser normally, restore the owned registry differences, remove the owned public entry while unbound and SQL stopped, then independently reread restored state. Unknown drift or partial failure stops; no force/retry. **Actual Apply has NOT BEEN TESTED**, because readiness authority prohibits applying changes. The new administrative RequireBaseline inspection was tested successfully, not simulated as a rollback success.

## Source/guard qualification

- [Rollback tests](research/DBL_YSEDU_ACTIVATION_READINESS_001_Test-YseduActivationRollback002.ps1): 14 identity/ownership cases and19 scope cases passed at17:48:01+03. Actual source functions were extracted via AST; expected identities and negative changes are independent literals. Wrong leaf/CA/DER/CSR, missing evidence, other IP/instance, static port, out-of-range dynamic port and security-flag/service-start changes are rejected. Source guards check maintenance authority, stopped-service gate, no SQL stop/start and no key deletion. These are pure guard tests, not registry/service mutation tests.
- [DACL tests](research/DBL_YSEDU_ACTIVATION_READINESS_001_Test-YseduSystemDaclReadiness001.ps1): nine memory-only vectors passed at17:48:01+03. SYSTEM full/generic read and effective inherited allow pass; BA-only, inherit-only SYSTEM, read-data-only, any deny, empty/null DACL fail. No fixture ACL was written and no effective SYSTEM token was exercised.
- Native metadata source compiled; helper and launcher CheckOnly/pins/parse passed. Actual administrative helper then passed once. Initial agent CIM/address access was denied under its non-administrator token; no bypass or implicit elevation followed. The owner manually opened the administrator console.
- [Readiness helper](research/DBL_YSEDU_ACTIVATION_READINESS_001_Read-YseduActivationReadiness001.ps1), [native locator](research/DBL_YSEDU_ACTIVATION_READINESS_001_YseduKeyStorageReadiness001.cs), [launcher](research/DBL_YSEDU_ACTIVATION_READINESS_001_Start-YseduActivationReadiness001.ps1). Retained sources are review copies, not alternate execution paths.

Local executable SHA256 pins:

| File | SHA256 |
| --- | --- |
| Restore-YseduLeafNetwork002.ps1 | 3F1E4FEF5BB3FF0845014E4893155FE9A13059D7F593C6F1DA9066FCD1059D87 |
| YseduKeyStorageReadiness001.cs | 957DC651000AB683D2F679CF8ED844864BB4A075C0DDC2FF469598524D2E3784 |
| Read-YseduActivationReadiness001.ps1 | 1D5F4407B3EDF64D1A44427F14F91CAD3661216D9593CD49A3E9AC83072C68A5 |
| Start-YseduActivationReadiness001.ps1 | E1E726C474C473A92E329A0684AD126A9BF7C45722906203D56663FE5EB992B4 |
| Test-YseduActivationRollback002.ps1 | 0122BE10D31336F4947F3749AC9DC2FBF457B3A2A76EB43A6F95E1E67D299161 |
| Test-YseduSystemDaclReadiness001.ps1 | B890A27C22F657E224E7EAF3DB113665A5AFA3AC68045D16B1A39570E95DB779 |

## One future bounded procedure — reviewed, NOT executed

1. Obtain separate execution approval. Retain the owner's accepted historical S2 recovery/unfinished transaction limitations; do not reopen archive work. Refresh original pins, service/dependent/client state, key DACL, address and Browser policy immediately before any interruption. Close experimental ERP clients normally. Any unknown drift, inaccessible key or changed exposure is STOP.
2. One normal YSEDU stop, bounded120 seconds; no Force/Kill/Reboot. Verify Stopped before certificate acceptance or network mutation. Do not stop another service/instance.
3. While stopped, accept only the exact signed DER against the existing machine pending request/key. [certreq -accept](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/certreq_1) is the enrollment-response acceptance path; it is not new-key issuance. Verify the exact installed thumb/DER/private-key association and unchanged key DACL before binding YSEDU. If acceptance requires trust-store/ACL changes or new-key creation, STOP, not a bypass. Review YSEDU Configuration Manager12 selection against the exact thumb; [SQL encryption configuration](https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/configure-sql-server-encryption?view=sql-server-ver17) documents selection and restart. Do not change ForceEncryption or trust stores.
4. Enable YSEDU TCP only: Enabled1, ListenOnAllIPs0, IP4 Enabled1 on the freshly verified192.168.56.1, retaining dynamic sentinel0 and empty static port until SQL assigns its port. Leave all other address/protocol/security settings unchanged. No Firewall changes or silent connector/configuration redesign.
5. **Superseded by the direct-port amendment:** leave SQLBrowser Stopped/Disabled; do not start it or perform SSRP discovery. After separately authorized YSEDU startup, discover the actual dynamic TCP listener and verify its owning YSEDU PID and approved192.168.56.1 address before supplying that port to the adapter. No assumed/default port and no SQL fixed-port setting. Missing Browser discovery is not a rollback trigger in this mode. The older conditional Browser startup allowance is historical, not this forward procedure.
6. Before the single normal YSEDU start, either finish the qualified forward changes or apply the reviewed rollback while stopped. This is one bounded stop/start cycle, not a restart loop. Verify actual SQL startup/log evidence for this leaf rather than fallback, key-access failures, actual scoped TCP port and service state. If that start fails or a later correction needs another cycle, STOP for a separate decision; no automatic second start/restart.
7. Rollback is limited to #002 with separately authorized Apply while SQL already Stopped: restore original binding/TCP/Browser values, remove only the owned public My entry without deleting the key, reread state, then the one authorized normal start if not already consumed. Unexpected concurrent drift or inability to restore is STOP; no security changes to force success.
8. Only after successful loading/network qualification, test strict Node22/Tedious TLS with the pinned public CA, exact DESKTOP-8QRQT7R name and certificate validation enabled. No trustServerCertificate, encryption disable, fallback certificate or administrator/FMMA connector. The independent reader credential remains a separate gate; unavailable password requires explicit reader-only rotation authorization, not an archive/CA password substitution.
9. Then run only the existing Item Identity slice against `DBL_HOST_W11_EFA12026_PostS2_Frozen_20261009` as `DBL_HOST_W11_S2_Reader_20261009`, via Connector → ImportOrchestrator → SQLite → SnapshotReader. FIRST LIVE DATA #001 passes only for actual SQL source Item code `DBL_P001_ITEM_A` and name `DBL_ITEM_A`; no Inventory/Purchase/S3 or Canonical expansion.

## Unresolved / acceptance gates

SYSTEM effective cryptographic use and SQL2014 certificate loading, actual TCP listener/Node routing, strict live TLS, reader password readiness and FIRST LIVE DATA are **NOT TESTED**. Browser packet exposure/SSRP remains historically NOT TESTED but is no longer a prerequisite when it stays Stopped/Disabled and direct-port mode is used. Offline CA revocation remains NOT TESTED with no CRL/OCSP; no production PKI claim. Rollback Apply and SQL database restoration are NOT TESTED. This review neither removes the remaining gates nor requests a new diagnostic project. **STOP now; next action is the separately authorized one bounded maintenance.** `.vscode` stays outside commit.
