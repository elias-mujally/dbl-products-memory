# PR #12 — owner-authorized merge verification

Date: 2026-10-11, Asia/Aden +03. Scope: **MERGE PR #12 ONLY** and Product Memory
publication. No host maintenance or live SQL qualification authorized in this task.

## Final decision and pre-merge evidence

[PR #12](https://github.com/elias-mujally/dbl-legacy-intelligence/pull/12) was OPEN,
CLEAN and MERGEABLE immediately before merge. Local HEAD, remote feature branch and
GitHub PR head all matched the exact approved SHA:
`84eadfddfd064ada961e36675ceffe24e33f2f3a`.

The PR contained only the two reviewed commits: direct-port transport
`3f7fb6d4c07da3185d1eddda0273b3a55569d83b` and P2 fix `84eadfdd...`.
GitHub reviews, issue comments and inline review comments were empty; no newer
blocking review or unreviewed commit was observed. Base main was still
`8c22f7b2a1dc251928adc9c7590b551dffddbd5e`.

[Exact-head CI](https://github.com/elias-mujally/dbl-legacy-intelligence/actions/runs/38158174952):

- `verify (ubuntu-latest)`: SUCCESS, completed 2026-10-11T17:06:16Z.
- `verify (windows-latest)`: SUCCESS, completed 2026-10-11T17:07:27Z.

These are the two visible CI checks, not a claimed independent inventory of branch
protection requirements. The protection API returned403 with GitHub's plan-upgrade
message; required-check configuration could not be independently retrieved. The
normal merge command used no admin/force bypass and succeeded under server enforcement.
Ubuntu's original `npm audit --audit-level=critical` passed; Windows audit remains
skipped by the unchanged workflow. No new local test run was needed for this
merge-only step: approved-head CI and existing qualification evidence were checked.

Actual code/diff inspection confirmed the P2 production correction is precisely
`options.maxRetriesOnTransientErrors:0` in the direct TCP branch; legacy named-instance
options remain unchanged. Real mssql/Tedious and Login7-handler tests cover effective
direct0/legacy3. TLS encrypt=true/trustServerCertificate=false, pinned CA/hostname,
explicit-port/no-instanceName and existing Canonical/import contracts remain unchanged.
This does not guarantee one socket/handshake; retry limits and remaining physical
connection behaviors in the [P2 report](MOTAKAMEL_PR12_P2_TRANSIENT_RETRY_FIX_2026-10-11.md)
remain applicable. Two inherited moderate audit entries remain, not newly qualified safe.

## Merge and remote verification

The established PR #11 method was verified directly as a two-parent merge commit.
PR #12 used the same method with an exact-head guard:

```text
gh pr merge 12 --repo elias-mujally/dbl-legacy-intelligence --merge --match-head-commit 84eadfddfd064ada961e36675ceffe24e33f2f3a
```

No `--admin`, force, auto-merge or branch deletion. GitHub returned:

- State: MERGED; closed=true.
- Merged at: **2026-10-11T17:18:46Z** (20:18:46 Asia/Aden).
- Final merge SHA: **`aa234dfbeb38ce738718957d739af348406c293a`**.
- Parents: `8c22f7b2a1dc251928adc9c7590b551dffddbd5e` and approved head
  `84eadfddfd064ada961e36675ceffe24e33f2f3a`.
- Tree: `51f15b2a1113fc3742559f7d76dab350fb8bb83c`.

Fresh `git fetch origin` and `git ls-remote origin refs/heads/main` both verified
that `origin/main` is the final merge SHA. The approved head is an ancestor of main,
and `git diff approved-head origin/main` is empty: no merge-only content changes.
The local feature checkout was not reset or switched; its working tree stayed clean.

## Boundaries and next step

**PR #12 = MERGED / REMOTE MAIN VERIFIED. FIRST LIVE DATA #001 = NOT TESTED.**

No YSEDU/SQLBrowser service inspection or mutation, certificate installation/binding,
network/Firewall/TLS/trust/ACL change, credential rotation or SQL connection occurred.
The next scoped task is the bounded maintenance procedure with fresh preflight,
Browser remaining stopped/disabled and discovery of the actual direct TCP listener;
then strict TLS and independent-reader qualification before the existing full import
path. Merge success is not SQL2014 certificate-loading or live-data evidence.
No Canonical/Inventory/Purchase implementation or S3; archive remains paused and
S3 remains ACCOUNTING-BLOCKED. Previous reports/evidence retained, `.vscode` excluded.
**STOP after Product Memory publication.**
