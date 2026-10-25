# Reproduction and next slice

2026-10-25 · Synthetic development only; no private evidence required.

Use the product S2 review commit and its S1 ancestor, existing Node 22-compatible runtime, the repository's already provisioned locked dependencies and new disposable state directories. No install or machine reconfiguration was performed during this work. Source-controlled fixtures contain only invented products and companies. Test signing keys are generated per test process in memory, never committed/exported as private bytes.

Build core then storage with their existing TypeScript build configs. Typecheck both packages. Run the Catalog test directory using the existing Vitest runner with one worker. `bootstrap.test.ts` exercises the built **public** package export, so rebuild before this test. Then run the bounded regression selection listed in VERIFICATION.md. Test reports are retained privately; the public manifest lists only sanitized results and source/document hashes.

The product PR is stacked on S1 PR23, not main. Review S1 first; do not assume S1 or Stage B is merged. Only S2's listed files belong to its diff. Local unrelated notes/Stage B tests are not bundled. Existing C1 plan and S1 evidence are referenced by their PRs instead of copied. No Preview1 package is rebuilt.

## Decisions and observed issues

- S1 DDL supports enrollment/request/event storage without a migration; SQL syntax, transaction and actual SQLite behavior are exercised, not assumed from the plan.
- Source setup and file verification are separate public functions. Internal database handles, canonical decoders and bound authority loaders are not package-exported. Verification cannot call enrollment or publish a capture.
- Successful verification leaves the request pending and all publication tables empty. This consciously avoids implementing a premature S3 admission ledger or consuming a request before atomic acceptance exists.
- Owner operations include lifecycle events transactionally. Test-only injected event-write failures must roll back enrollment, supersession, cancellation and suspension. No production fault switch is added.
- Long-lived DB connection/cache is avoided. Each call validates the Catalog state/fingerprint and opens its own short transaction; no V1 state is adopted. S2 requires an unpublished state; later acceptance work must explicitly replace this S2 limitation under new authorization.
- The draft `state.ts` facade adds S2 reexports while retaining S1 lifecycle logic. The public-export assertion is updated accordingly. The state/registry modules have a function-only initialization cycle without DB side effects; package-import/build/reopen tests exercise it. A future S3 facade can remove that cycle within its authorized review scope.
- Direct UNC/URL inputs were rejected during pre-test review. No previous access denial, network setting or permission was bypassed. Publication uses an explicit file allowlist; unrelated local work is preserved.

## Rollback and deferred scope

Revert only S2 code in the development branch or stop using the new synthetic API; preserve diagnostic states. Owner suspension is available for newly enrolled synthetic sources. Do not modify old state roots, down-migrate, reset V1 or strip state markers. Failed synthetic fixture directories remain separate from ERP and Preview1.

Before S3, review this evidence and separately authorize atomic admission. S3 must revalidate authority/request in the write transaction, persist snapshot/products/admission/head/request consumption/local mandatory event as one unit, resolve durable replay after a lost response and reject conflicts/older captures. Missing-set review must bind exact proof/payload/parent; S2 implements none of that. S4 historical reads/diffs and S5 process crash/concurrency/public-bypass qualification remain open.

Real ERP qualification still requires independently authorized source identity, stable-key semantics, connector/build/mapping evidence, consistent full extraction and completion semantics, issuer/key custody and lifecycle. This synthetic success supplies neither operational enrollment nor permission to inspect ERP.
