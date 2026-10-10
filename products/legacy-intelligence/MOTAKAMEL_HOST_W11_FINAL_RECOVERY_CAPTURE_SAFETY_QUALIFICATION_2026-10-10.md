# Host W11 — Final recovery capture safety qualification

Date: **2026-10-10**, DESKTOP-8QRQT7R. Baseline: accepted Product Memory **4fc8167** [synthetic archive qualification](MOTAKAMEL_HOST_W11_SYNTHETIC_ARCHIVE_QUALIFICATION_2026-10-10.md) and **3e44b95** [minimal encrypted recovery design](MOTAKAMEL_HOST_W11_MINIMAL_ENCRYPTED_RECOVERY_ARCHIVE_DESIGN_2026-10-09.md).

**FINAL RECOVERY CAPTURE SAFETY = SYNTHETIC QUALIFIED within the tested boundaries. Next decision: READY FOR A SEPARATELY AUTHORIZED BOUNDED REAL CAPTURE, not another design investigation.** No actual laboratory recovery archive, SQL restore proof, safe-current-transaction attestation or certificate execution approval follows from this result. Actual capture remains unauthorized until the owner accepts the exact scope/custody/outage conditions in section 5.

S2 remains LAB-PROVEN; S3 frozen/accounting-blocked; live Connector NOT TESTED. No product/Canonical/Connector change.

## 1. Actual results and evidence

Only fixture root: `C:\Users\user\Documents\Codex\FRCSQ-20261010-7e3821a9`, marker `DBL_SYNTHETIC_ONLY FRCSQ 7e3821a9 2026-10-10`. All files are generated test content. The agent's ordinary Windows token was not elevated; administrative synthetic execution was performed by the operator in an actual administrative PowerShell. Sandbox approval is not Windows elevation.

Retained [nonsecret combined receipt](research/FINAL_RECOVERY_SAFETY_RESULT_2026-10-10.json) contains the actual outputs, negative-fixture hashes, metadata proof, tool identities and capacity observations. No password, actual SQL/ERP contents or private signing material is included.

| Requirement | Result and limits |
| --- | --- |
| Interactive secret entry | **PASSED**, native Pinentry launched during encryption, fresh-agent positive decode and truncated-ciphertext rejection; operator confirmed private entry. The harness never receives the passphrase |
| Owner/group/DACL/inheritance | **PASSED within same-host fixtures**: protected and inherited descriptors, current-user owner, then operator-created SYSTEM owner / Administrators group / audit SACL; exact full SDDL comparison |
| NTFS content/attributes/times | **PASSED bounded**: SHA256, ReadOnly/Hidden/Archive, directory attributes, creation/write UTC; authenticated TAR manifest replay verified four records |
| TAR pre-extraction rejection | **PASSED**, 12 actual malicious fixtures; zero extraction calls, empty negative target |
| Full authenticated quarantine | **PASSED**, full exit/status/hash/member checks before rename/extraction; failed decode produced 139703 plaintext bytes that were never promoted or extracted |
| Capacity | **PASSED provisionally for historical known-path size**, not complete recovery coverage or E: write integrity |
| Real SQL restoration / custom MIC labels / portable recovery | **NOT TESTED**; do not promote these to passed |

### Interactive profile and quarantine

Installed GPG2.4.9 SHA256 still equals the byte-qualified distribution member at4fc8167:
`A5140C85353E8399DA8D6BD7E3741524CD76A4E69BE88AF12042B1C9EF022984`.
Native TAR3.7.7 SHA256:
`92FAFED485AF0FE4C291457DC3C00D0241F6A136731BAB63EF18A3F0C949D37A`.
Installed Pinentry-w32 1.3.2-unknown SHA256:
`95A49C7B02CFA93DFDEC7F7E122D703E6A6003B2AE064B0EB61C22AB7C79410D`.
No reinstall or repeated package download; no independent Pinentry-signature/whole-DLL/vulnerability attestation.

Actual interactive phase **06:13:46–06:15:02 +03:00** used a session-only GPG homedir, `pinentry-mode ask`, `no-symkey-cache`, configured native Pinentry and `no-allow-external-cache`. AES256/OCB, S2K3/SHA256/count65011712 and no compression remained unchanged. Encryption status9/2 and successful decode `DECRYPTION_INFO 0 9 2`, exit0, `DECRYPTION_OKAY` prove the executed profile. The owner was asked to generate a fresh random test secret, unrelated to real recovery credentials; its contents/entropy were intentionally unobserved. No argv/environment/pipe/password-file transport, transcript or screen capture of that secret. Only the scoped agent was stopped between stages and at completion. Managed/agent memory, pagefile and compromised-host exposure are not excluded. These session controls are documented in the [GnuPG agent manual](https://gnupg.org/documentation/manuals/gnupg24/gpg-agent.1.html).

139776-byte TAR SHA256:
`554B683DAA0F83A138A2B32AD0FD2D708FCD237533D01F0C97B06DEFD3535586`.
Positive decode wrote a new pending TAR, consumed the entire message, required authentication/exit0, equal TAR SHA and exact allowed members, then promoted and extracted into a new NTFS directory. Two payload hashes and manifest hash matched.

The new interactive negative test removed the final17 cipher bytes: exit2, `aead_checktag/BADMDC/DECRYPTION_FAILED`, **139703 partial plaintext bytes**. No use/promotion/extraction. It specifically qualified interactive/quarantine dispatch; the prior257MiB/wrong-password/bit-tamper/Unicode successes were not rerun. Never stream decryption directly into TAR.

### Security metadata proof and diagnosed setup failures

At06:13 the ordinary-token test passed four source/restore records with owner/group, exact DACL SDDL, inherited/protected behavior, attributes and UTC times. Its SACL read failed with missing privilege; this was recorded, not treated as absence of SACL.

At **06:26:40 +03:00**, operator output and local RESULT.json match:
`ARBITRARY_OWNER_DACL_AUDIT_SACL_SYNTHETIC_PASSED`.
A 34-byte dummy source had SYSTEM owner, Administrators group, protected DACL and one success/failure audit ACE. Manifest was serialized and re-read; target owner changed **Administrators → SYSTEM**, exact full SDDL and SHA256 matched:
`9C1EB50D9AD2F4B590A3AD510F56272236B475193BF6C169C199171991A41EA2`.
This is an operator-executed privileged proof, not an agent claim to have acquired an administrator token. Helper enables SeRestore/SeSecurity only in its own process and restores prior state in finally; no assignment of Windows account rights. [Microsoft privilege definitions](https://learn.microsoft.com/en-us/windows/win32/secauthz/privilege-constants) explain arbitrary-owner restoration and security/audit access.

An additional replay used the manifest extracted from the authenticated TAR rather than only an unarchived in-memory manifest. Initial failures were preserved:
1. ISO dates became DateTime objects after JSON parsing; string comparisons were corrected to UTC ticks, without inventing timestamps.
2. Reapplying descriptors under the ordinary token failed for SeSecurityPrivilege; removing ReadOnly did not fix that privilege error. Administrative operator replay applied the descriptors.
3. That administrative replay then failed setting creation time after ReadOnly had already been restored. The correction clears ReadOnly on owned dummy targets, sets times while writable, reapplies final attributes and checks them strictly. Already-identical SDDL is verified rather than unnecessarily reapplied; a mismatch still requires real successful ACL application.

Final **06:38:23 +03:00**:
`AUTHENTICATED_TAR_MANIFEST_NTFS_REPLAY_PASSED`, four records; full owner/group/DACL SDDL, owner SID, inheritance protection, final attributes, creation/write ticks and payload hashes matched. LastAccess also matched at this check, but earlier subsequent reads changed it: **record/apply LastAccess, do not promise it remains immutable after access**. No NTFS policy change. [Windows file-time documentation](https://learn.microsoft.com/en-us/windows/win32/sysinfo/file-times) describes delayed NTFS access-time updates.

Audit SACL round-trip is now bounded-proven. It is not itself required to decode SQL file contents, but this preservation plan retains it for security/audit equivalence rather than silently dropping it. **Custom mandatory integrity label replay remains NOT TESTED**. Integrity labels are SACL data and can affect access before DACL checks ([Microsoft MIC documentation](https://learn.microsoft.com/en-us/windows/win32/secauthz/mandatory-integrity-control)); do not equate “audit ACE worked” with all SACL types working. During authorized real metadata inventory, an unsupported label/ACE, unreadable full descriptor or unresolved SID is a STOP condition, not a reason to strip it.

This test does not qualify ADS/EFS/sparse allocation/hardlinks, all possible ACEs, >4GiB files, every Windows alias or arbitrary path length. None was read from real SQL files in this task.

### Malicious TAR admission

An independent .NET TarReader walks the entire candidate before extraction, checks exact case-sensitive member allowlist, case-insensitive path uniqueness, allowed regular-file/directory types, completeness and synthetic count/size bounds. It rejects drive/UNC/absolute/backslash/colon namespaces, dot/parent segments and unsupported aliases. Twelve encoded fixtures rejected with the expected reason:
traversal, valid-prefix then late traversal, POSIX absolute, Windows absolute, drive-relative, UNC, backslash traversal, symbolic link, hard link, exact duplicate, case alias and ADS-like name. **All12 had zero extraction calls and zero destination entries.**

The positive five-member set was `payload/`, two payload files, `metadata/`, manifest. The synthetic1MiB bound is deliberately not a real capture limit: future admission must derive byte/count/relative-path bounds from the owner-approved refreshed allowlist. This retained validator is a bounded test artifact, not a complete hostile-archive framework.

## 2. Capacity and staging

Read-only refresh **06:40:45 +03:00**:

| Volume | Filesystem / physical disk | Free bytes |
| --- | --- | ---: |
| C: | NTFS, Disk0 / partition3 | 39870500864 |
| D: | NTFS, Disk0 / partition4 | 17562300416 |
| E: | exFAT, Disk1 / partition1 | 139640832000 |

Accepted inventory known scope `B=1278906368 bytes` (20 persistent candidates +3 retained backups, excluding tempdb), not refreshed SQL content or a proven complete catalog.

Conservative provisional budgets, no compression:
- NTFS: `ceil(4 × B × 1.20) + 256MiB = 6407186023 bytes (~5.97GiB)` for stage, TAR, decoded TAR, verification extraction and headroom.
- E:: `ceil(B × 1.20) + 256MiB = 1803123098 bytes (~1.68GiB)` for one ciphertext plus headroom.

Current capacity exceeds those historical-size budgets. Recalculate using every freshly approved payload/settings/artifact and actual growth before stopping SQL; count metadata overhead too. No E: write/repair/format test occurred. Free space does not prove safe USB writes, archive integrity, database completeness or restore success.

The synthetic parent root inherited additional ACEs; **do not advertise the entire test root/private-gpg label as an attested private real-data staging root**. The fixture source itself had the protected test DACL. Real capture needs a new approved private NTFS root outside Git/OneDrive/project spaces with verified restricted inheritance/ACL; the actual path/ACL must be checked before SQL stop. C:/D: plaintext staging exposure and ordinary deletion remnants require explicit owner acceptance; no secure-erasure claim.

## 3. Retained artifacts and reproducibility

Nonsecret source evidence:
- [main two-phase synthetic harness](research/FINAL_RECOVERY_SAFETY_SYNTHETIC_2026-10-10.ps1)
- [operator owner/audit helper](research/FINAL_RECOVERY_SAFETY_ELEVATED_METADATA_2026-10-10.ps1)
- [corrected extracted-manifest verifier](research/FINAL_RECOVERY_SAFETY_EXTRACTED_MANIFEST_2026-10-10.ps1)
- [same-session privilege wrapper](research/FINAL_RECOVERY_SAFETY_ELEVATED_REPLAY_2026-10-10.ps1).

Executed local source hashes are in the receipt; all four retained local copies were independently hashed and match their final local artifacts byte-for-byte. Git checkout newline conversion can subsequently change those digests. The wrapper's final helper-hash update is reviewed preparation for reproduction, not a second successful operator invocation. The successful final replay reused the operator-applied exact descriptors and completed/verified timestamps and attributes under the ordinary token. Do not mislabel the failed earlier operator invocation as a fully successful final replay.

For any separately authorized repeat: require the exact owned root absent/new and NTFS; stage only marker+main harness initially (Metadata phase enforces two initial files), run Metadata once then Interactive under PS7 with private owner Pinentry. Copy administrative companion helpers only afterwards; obtain the published LF bytes and verify recorded hashes before execution because Git newline conversion can alter byte digests. Do not disable hash checks or change expected digests merely to accommodate an unexplained mismatch. Run owner/audit helper in actual administrative PowerShell, then its same-session wrapper; no security bypass or policy change. Corrected verifier applies times before ReadOnly. Every JSON verdict is checked; exit0/file presence alone is insufficient. Never run these fixture scripts against real SQL files or turn them into a backup framework. Current synthetic files are retained under their marked root for inspection; only scoped GPG agents were stopped. No cleanup outside that root or secure erasure is claimed.

## 4. One real-capture procedure — NOT EXECUTED

This is the executable operational sequence after explicit stop/capture/start approval, not permission granted by this synthetic task.

1. **Fresh preflight, before outage.** Confirm actual authorized administrative channel; exact YSEDU service/startup/build/network-original evidence and approved known-path allowlist from the prior inventory, no other instance. Include required parent-directory SDDL, full owner/group/DACL/SACL, attributes/UTC, exact original→collision-free relative paths, retained backups and required nonsecret DBL recovery artifacts. Resolve every unreadable/unknown path, stream, reparse/EFS/custom-label anomaly by STOP rather than skipping. No secret extraction or broad registry/home copy. Catalog/external-file and transaction gaps remain explicit if the strict trusted maintenance connection is still unavailable.
2. **Custody/private stage/capacity.** Owner generates ≥128-bit-entropy new recovery secret in a password manager with an independently held recovery record, not in chat/Git/E:. Verify trusted matching decoder availability and actual private NTFS stage/quarantine root outside repositories/OneDrive; source ACLs stay untouched. Recheck E: Disk1 identity/free space; unique nonexistent ciphertext path. Recompute4× budget plus headroom using refreshed total. Insufficient space, broad inherited access, missing custody or decoder → STOP before outage.
3. **Authorized outage.** Close ERP/SQL clients normally. Obtain fresh trusted activity/catalog/state evidence if possible, never TLS bypass. Otherwise proceed only with the owner's explicit acceptance of unknown active-transaction/catalog/rollback limits. Gracefully stop **MSSQL$YSEDU only**, observing a120-second bound; confirm Stopped and no corresponding engine process/file ownership. Timeout/StopPending/unclear file ownership → STOP; no force/kill/reboot, no live database copy.
4. **Stopped-file capture.** Refresh the approved persistent-file allowlist while stopped; omit regenerated tempdb, do not silently omit anything else. Capture full manifest/settings to private stage, record metadata before reads change access times, hash source, copy exact approved files without overwrite or /MIR/PURGE/MOV, compare staged bytes/hash and rehash stopped sources. Unknown growth/file/descriptor, changed hash or copy error → fail capture. Do not edit source files, source ACLs, SQL credentials or settings.
5. **Package/encrypt.** TAR only the exact relative payload+metadata set; independently validate complete members/types/names/count/byte bounds. Native owner Pinentry, dedicated scoped homedir/no cache, unchanged AES256/OCB/S2K profile, unique E: ciphertext.partial. Require encryption success; reread complete ciphertext SHA. No plaintext/manifest/secret on E:.
6. **Full verification from E:.** Restart only the scoped GPG agent; re-enter the secret privately. Decode to new NTFS pending TAR, require full authenticated exit0/profile and original TAR SHA before promotion. Validate every TAR member before native extraction to a new empty target. Compare complete manifest/file count, sizes/SHA and restore full security metadata/required attributes/creation/write UTC, with ReadOnly last; access time is retained/applied but not immutable. Audit SACL requires qualified administrative privileges; unsupported security metadata → fail, not strip. No SQL attachment/overwrite during archive verification.
7. **Commit capture receipt / normal start.** Only after all checks pass finalize the unique encrypted filename, create a small nonsecret receipt and independently anchor its digest/scope in Product Memory. Authorized normal start of original unmodified YSEDU once; compare service/process/log evidence. A Running service alone is not DB/login/grants/READ_ONLY proof: check those through a strictly trusted channel when available or label them UNVERIFIED. Capture failure prevents certificate work; retain exact failed private artifacts and use only the preauthorized normal start once. Start failure → STOP for recovery authority, not a retry loop.
8. **Custody/cleanup/recovery boundary.** Retain qualified ciphertext on E: and independently held secret/receipt/decoder. Only approved exact-owned plaintext roots may be removed after inventory/marker/no-link checks; normal deletion is not secure erase. Actual disaster restoration is separately authorized: authenticate/validate into new NTFS quarantine first; same-host/same-build target review, preserve originals, appropriate stopped-instance/system-database procedures, then trusted SQL checks (integrity, S2 item/warehouse/37/SAR3700, reader SID/grants and frozen READ_ONLY). Never attach Resource or blindly overlay a running master. **Archive file/metadata verification is not SQL restore qualification.**

## 5. Decision / exact remaining owner authorization

**Technical complementary synthetic gate passed. Do not reopen another general design round.** Request one bounded execution approval covering:
- identified private stage/quarantine path and its ACL/temporary privilege use;
- new owner-held secret, independent secret record/decoder custody;
- exact refreshed known-file/settings/DBL-evidence scope and acceptance of unresolved catalog/transactions and plaintext-staging/single-USB/same-host portability risks;
- graceful YSEDU-only stop, stopped capture/encrypt/full verification, normal original-service start once on success or abort, exact owned staging cleanup;
- STOP at any new scope, metadata, disk, service or authentication failure.

**Not included:** certificate/CA/root/binding/TLS/network changes, new SQL backups/Restore, business writes, Live Connector, S3 or other instances. The owner can now authorize this concrete capture; until then no real capture or shutdown.

Only dummy fixture metadata/content and Product Memory documentation/evidence were changed; E: volume/partition reads only. No actual SQL/ERP content read/copy, SQL connection/service change or Windows policy/global privilege/ACL modification. Administrative ACL/owner/audit changes were confined to fake fixtures. `.vscode` excluded. **STOP.**
