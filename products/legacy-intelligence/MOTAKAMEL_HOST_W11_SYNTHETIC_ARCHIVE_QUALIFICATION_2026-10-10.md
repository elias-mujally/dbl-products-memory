# Host W11 — Synthetic archive qualification

Date: **2026-10-10**, DESKTOP-8QRQT7R. Accepted design: Product Memory **3e44b95**, [minimal encrypted archive design](MOTAKAMEL_HOST_W11_MINIMAL_ENCRYPTED_RECOVERY_ARCHIVE_DESIGN_2026-10-09.md). Authorization: synthetic files, encryption/decryption, isolated NTFS extraction and bounded synthetic cleanup only.

**Later 2026-10-10 complementary gate:** [Final recovery capture safety qualification](MOTAKAMEL_HOST_W11_FINAL_RECOVERY_CAPTURE_SAFETY_QUALIFICATION_2026-10-10.md) passed actual native Pinentry, bounded owner/DACL/audit-SACL/NTFS manifest replay, twelve malicious TAR rejection cases and authenticated quarantine. The NOT TESTED statements below are historical for those bounded tests only. Custom integrity-label/other unsupported metadata and real SQL/E: capture/restore remain unqualified. The concrete next step is separately authorized bounded real capture, not automatic shutdown or certificate work.

**Original result: SYNTHETIC QUALIFIED — content/path round-trip, AES-256/OCB and test-only FD0 password transport.** This is **not RECOVERY READY**, a SQL restore proof, approval to stop SQL, or permission for certificate work. Real recovery Pinentry, security-metadata round-trip and real E: capture remained separate gates at this original checkpoint. S2 stays LAB-PROVEN; S3 accounting-blocked/frozen; live connector NOT TESTED. No product scope/architecture changed.

## 1. Installed tools and source qualification

No tool was installed, upgraded or replaced. Read-only inspection found:

| Tool | Observed evidence |
| --- | --- |
| GPG | `C:\Program Files\Git\usr\bin\gpg.exe`, **GnuPG 2.4.9**, libgcrypt **1.12.2-unknown** |
| Distribution | Git **2.54.0.windows.1**; installed package inventory lists gnupg2.4.9-1 / libgcrypt1.12.2-1 / pinentry1.3.2-1 |
| TAR | `C:\Windows\System32\tar.exe`, **bsdtar/libarchive 3.7.7** |
| Host runner | **PowerShell 7.6.5 Core**, native .NET `System.Formats.Tar.TarReader` |
| Filesystem | C: **NTFS / Healthy**, observed free space **38,022,467,584 bytes** before fixtures |
| Signatures | gpg.exe **NotSigned**; installed Git cmd executable Authenticode **Valid**, signer Johannes Schindelin. Git's signature alone is not GPG authenticity proof |

Stronger source check: the [official Git for Windows v2.54.0.windows.1 release](https://github.com/git-for-windows/git/releases/tag/v2.54.0.windows.1) publishes the SHA256 for `Git-2.54.0-64-bit.tar.bz2`. Downloaded that official asset over normal validated HTTPS into **memory only**, bounded to 160 MiB; compared its full digest, then streamed the archive member `usr/bin/gpg.exe` to a digest without writing/installing/executing the downloaded member. Its bytes exactly matched the installed GPG executable:

```text
Official asset:
https://github.com/git-for-windows/git/releases/download/v2.54.0.windows.1/Git-2.54.0-64-bit.tar.bz2
Package bytes: 116824890
Published AND observed package SHA256:
E1819CEE60D09793DDE322CDB1170E03663C41CD9265CF45246219FC5E6AEECD
Official GPG member AND installed gpg.exe SHA256:
A5140C85353E8399DA8D6BD7E3741524CD76A4E69BE88AF12042B1C9EF022984
Installed tar.exe SHA256:
92FAFED485AF0FE4C291457DC3C00D0241F6A136731BAB63EF18A3F0C949D37A
```

**Qualified installed-GPG byte provenance within this HTTPS/release-hash comparison**, not an independent offline signature validation, whole-distribution/DLL audit or vulnerability-free attestation. The library suffix is recorded, not interpreted. Recovery on another workstation and an independently retained matching decoder distribution/dependencies remain NOT TESTED. The public asset was not installed or retained on disk.

## 2. Bounded fixture and crypto procedure

Only test root: `C:\Users\user\Documents\Codex\SAQ-20261010-b6f1a72c`, outside the repositories. Ownership marker: `DBL_SYNTHETIC_ONLY b6f1a72c 2026-10-10`. No E: read/write, SQL/ERP content read/copy, SQL connection, service stop/start, ACL/Windows/network/TLS/certificate change. All working files, private GPG homedir, decoded quarantine and extraction were inside that root.

Fixtures: **7 payload files +1 JSON manifest**; empty file, ASCII/CRLF, spaces, Arabic filename/content, Chinese filename/binary bytes, nested relative path and deterministic **257 MiB /269,484,032-byte** binary. Longest full source path: **211 characters**. The large fixture exceeds the previously inventoried largest database-file candidate (224,526,336 bytes); it is generated data, **not an MDF/LDF or a database-format test**. Exact fixture identities/sizes/hashes are retained in the [non-sensitive result](research/SYNTHETIC_ARCHIVE_QUALIFICATION_RESULT_2026-10-10.json).

Native TAR packaged `payload/` and `metadata/` only, preserving relative path separation. An independent .NET TAR reader verified the exact regular-file/directory name sets. Validator guards allow only those entry types and forbid traversal, absolute/drive paths and duplicates before extraction; malicious TAR fixtures were not separately exercised. Restore target was newly created and empty; extraction never overwrote existing data. Every restored file path/size/SHA256 matched its source, and source fingerprints stayed unchanged.

Test secret: **32 CSPRNG bytes encoded as Base64**, independent of any real recovery password. A different random secret was used for the negative password test. Secret bytes were passed to each GPG child through an anonymous redirected standard-input pipe (`--passphrase-fd 0`); no secret in argv, environment, fixture, password file, Git or tool output. Child output was captured privately, checked for secret disclosure and reduced to safe status lines. No shell interpolation of secrets. Managed strings exist in process memory; no zeroization/pagefile/crash-dump guarantee is claimed.

Profile actually executed:

```text
--no-options --homedir <private-test-MSYS-path>
--batch --pinentry-mode loopback --passphrase-fd 0
--no-symkey-cache --status-fd 2
--cipher-algo AES256 --force-ocb
--s2k-mode 3 --s2k-digest-algo SHA256 --s2k-count 65011712
--compress-algo none --symmetric
```

The private agent was stopped after encryption, then decryption ran in a new GPG process, demonstrating password re-entry without relying on that agent's cache. Final cleanup stopped only the root-scoped agent. Child processes had 60-second bounds; no global GPG termination or insecure encryption fallback. **Loopback/FD0 is qualified for this synthetic automation only**; it does not substitute for testing private native Pinentry with an owner-held real recovery secret under the accepted design.

Actual statuses: `BEGIN_ENCRYPTION 0 9 2`, `DECRYPTION_INFO 0 9 2`, `DECRYPTION_OKAY`, `GOODMDC`, with exit **0** for positive operations. [GnuPG 2.4.9 status definitions](https://raw.githubusercontent.com/gpg/gnupg/gnupg-2.4.9/doc/DETAILS) identify the cipher/AEAD positions; [its algorithm enums](https://raw.githubusercontent.com/gpg/gnupg/gnupg-2.4.9/common/openpgpdefs.h) identify **9=AES256, 2=OCB**. Thus actual AEAD use is observed, not inferred from option availability. `GOODMDC` is the tool's status label here, not evidence of fallback to MDC-only encryption. Profile controls follow the [GnuPG 2.4 manual](https://gnupg.org/documentation/manuals/gnupg24/gpg.1.html); S2K is iterated/salted, not memory-hard.

## 3. Actual results and integrity failures

Successful qualification run: **05:44:34.8147919–05:45:04.6896688 +03:00**, 2026-10-10.

| Test | Result / exact observation |
| --- | --- |
| TAR + AES256/OCB encrypt/full decrypt | **PASSED**, exit0, actual status algorithm IDs 9/2 |
| Full TAR identity | **PASSED**, original and decoded SHA256 identical |
| Members / directories / Unicode | **PASSED**, exact names including Arabic/Chinese; restored paths and bytes equal |
| NTFS isolated restore | **PASSED**, all8 regular files, sizes and SHA256 equal; no existing files overwritten |
| Large file | **PASSED**, 257 MiB; TAR269,500,416 bytes; ciphertext269,530,378 bytes (29,962 bytes over TAR) |
| Wrong password | **REJECTED**, exit2, `11_BAD_PASSPHRASE`, 0 plaintext bytes; no extraction |
| Single-bit middle-body tamper | **REJECTED**, exit2, `aead_checktag` / `BADMDC` / `DECRYPTION_FAILED`; 138,412,010 partial plaintext bytes; no extraction |
| Final17-byte truncation | **REJECTED**, exit2, same authentication-failure statuses; 269,500,343 partial plaintext bytes; no extraction |
| Original ciphertext/source preservation | **PASSED**, hashes unchanged after negative tests |
| Password/agent handling | **PASSED within synthetic FD0 transport**, scoped agent restarted before decode and stopped afterwards |

```text
TAR SHA256 (original = fully authenticated decoded TAR):
5B5C81288DF79ECE9241A64082C3222E63F041F6648ADE1C364C0E8EB9D1B862
Original ciphertext SHA256:
FA4DB11739BCB62D318C6ED4FA534E2412708E175AACCD16DEE5BCFB33A058D9
```

**Mandatory operational consequence:** GPG can write substantial partial plaintext before detecting corruption/truncation. File existence, a successful early AEAD chunk, or even a nearly complete TAR is insufficient. Decrypt to quarantine, consume the full message, require successful process exit/authentication, then validate TAR hash/members before extraction. Never stream GPG directly into TAR extraction or consume outputs from failed decryptions. This test observed that hazard and correctly refused extraction.

Setup history, not hidden retries of a cryptographic failure:

- Initial runner setup hit PowerShell's read-only `HOME` variable collision **before fixture/secret generation**; changed the test-specific variable to `gpgHome`.
- First fixture/TAR run at05:42 stopped before password generation/encryption: native `tar -t` text decoding lost Arabic/Chinese names in this locale. Independent `.NET TarReader` found the actual TAR headers correct. Resumed only those fingerprint-verified fixtures after the diagnosed pre-encryption failure; no changed Windows codepage/DPI/settings and no encryption-profile weakening.
- The corrected run checked raw TAR header names independently; native Windows TAR extraction then restored the actual Unicode paths with matching hashes. **Do not use this host's locale-dependent `tar -t` text as the authoritative Unicode member validator.** No Unicode encoding success is claimed for that textual display.

## 4. Reproducibility and bounded cleanup

Retained [exact tested synthetic harness](research/SYNTHETIC_ARCHIVE_QUALIFICATION_2026-10-10.ps1), SHA256 **BC5F88C6349B941C2E3AD043A51FAE1F68A64C7C257ED40720859C1B8450AF0A**, plus the non-sensitive JSON receipt (line endings normalized in Git; parsed receipt content independently compared). This is a bounded test artifact, **not a new backup utility or real-capture executor**. It has no SQL/service/E:/certificate operations. Direct invocation from the repository fails its root guard.

For a separately authorized repeat on this same toolchain: verify tool hashes and >=4 GiB free on C: NTFS; require the exact test root absent; create it anew with only `Run-SyntheticQualification.ps1` copied from the retained harness and `OWNERSHIP.txt` containing the marker above. Run the script under PowerShell7 **without `-ResumeFixtures`** and without transcripts/debug/secret capture. It creates fresh fixtures/passwords and performs the same positive and three negative tests. A repeat's randomized ciphertext and TAR timestamp digest need not equal this run; within-run original/decrypted hashes and restored fixture hashes must agree. The resume switch is only a historical narrow recovery path for the diagnosed pre-encryption name-listing failure, not a retry mechanism for crypto failure. JSON `Decision`, not shell exit0 alone, is the test verdict. Stop on any BLOCKED result; do not disable AEAD/checks to force success.

Cleanup **PASSED at05:50:10.4983694 +03:00**: exact absolute root, marker, no reparse points, all28 file paths/sizes/SHA256 rechecked against the pre-cleanup inventory, result and retained harness identities matched. Removed **only that synthetic root**, containing **2,294,495,385 bytes**, including source/restore fixtures, TARs, ciphertext copies, rejected partial plaintext and private GPG homedir. Verified the root no longer exists. Non-sensitive evidence/harness remain in Product Memory; no outside-root deletion. This was ordinary deletion, **not secure erasure** or a promise that synthetic files can be recovered. No real recovery secret or business file was there.

## 5. Limits and next decision

**Not tested / not authorized here:** real native Pinentry entry/confirmation; owner/group/DACL/SACL/inheritance/NTFS-stream metadata capture/replay; >4 GiB files or Windows paths beyond211 characters/legacy limits; sparse-file allocation/ADS/EFS/hardlinks; malformed/link/traversal TAR negative fixtures; real SQL file completeness/recovery/login grants; frozen DB state; E: writes/exFAT interruptions; independent-machine decoder recovery. TAR content equality does not preserve security descriptors automatically. No SQL-format or database-restorability inference from the fake large file.

The immediate synthetic technology gate passed, but **full laboratory capture/maintenance remains NO-GO** under the accepted design until remaining metadata/Pinentry qualification, custody/private staging and exact scope/outage-risk acceptance plus separate graceful stop/capture/abort-start authorization. Do not expand this test's noninteractive password transport into an approved real-password method silently. No new backup, restore, archive of business content, certificate, CA, service/network/Windows/ERP change or live Connector test occurred.

Only this report, README/design status pointers and test evidence changed in Product Memory. `.vscode` remains outside the commit. **STOP.**
