# One bounded YSEDU maintenance — pre-stop hold

**Later transport-only amendment:** the owner approved explicit-port adapter support.
[Direct-port implementation and revised procedure](MOTAKAMEL_DIRECT_PORT_TRANSPORT_2026-10-11.md)
supersede the Browser dependency/decision below for the direct path only. Browser must
remain Stopped/Disabled; unavailable discovery is not a rollback trigger there.
This report remains the historical pre-stop observation; no maintenance is claimed.

Date: 2026-10-11, Asia/Aden +03. Owner execution approval received against901afd0. **MAINTENANCE = NOT STARTED / BLOCKED BEFORE SHUTDOWN. FIRST LIVE DATA #001 = NOT TESTED.** No certificate/service/network/SQL-data changes were made.

## Fresh checks actually performed

[Structured agent observation record](research/DBL_YSEDU_MAINTENANCE_001_PRESTOP_HOLD_2026-10-11.json), explicitly not an administrative maintenance result. Source original and qualified artifacts were not edited or replaced.

At19:13:43.5988645+03, YSEDU remained Running and SQLBrowser Stopped. Five local file pins still matched the approved readiness/signing/original/rollback artifacts. The current agent token is not elevated. No GL/inv/pr/RepDes/SSMS/sqlcmd process was returned by the bounded name check; this is not proof of zero SQL sessions or transactions.

Fetched build origin/main: `8c22f7b2a1dc251928adc9c7590b551dffddbd5e`. Existing clean local checkout remains approved PR head `3fd128d2b49f439f24fe19fa7e3cc1c2e8d12e6e`; both the connector diff and entire tree diff against main are empty. No checkout/reset/code edit occurred. Product Memory remote main still901afd0 before this update. Read actual `packages/connectors-motakamel-plus/src/source.ts` and `profile.ts`: production session uses fixed host DESKTOP-8QRQT7R, `instanceName:YSEDU`, encrypt=true, trustServerCertificate=false. There is no approved explicit-port input in the current adapter. No alternate sessionFactory, fixture, admin connection or import was used.

Hostname DNS currently returns192.168.56.1,192.168.43.197,172.17.80.1 and three link-local IPv6 addresses. This is a multi-address observation, not proof of current interface category, active listeners or remote exposure. No fresh administrative registry/key-DACL/full-Firewall check was run; the prior administrative PASS is retained, not represented as a new execution result.

## Exact hold and proof boundary

The owner permits Browser **only if actual exposure can be qualified and accepted**; otherwise STOP/rollback.901afd0 explicitly left runtime Browser exposure/SSRP NOT TESTED. The pinned Browser helper proves static policy only and checks Browser while Stopped. Its prior PASS cannot meet that stricter runtime condition by itself. Restricting YSEDU TCP to192.168.56.1 does not prove Browser's own IPv4/IPv6 listener or packet exposure is similarly restricted.

Microsoft documents unauthenticated UDP1434 instance discovery and separate Browser behavior; named-instance clients need that discovery unless given a port. The documentation discusses IP_ANY listening but does **not** prove this host's actual binding. [Browser service](https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/sql-server-browser-service-database-engine-and-ssas?view=sql-server-ver15). We did not start Browser to infer that its transient unqualified exposure was implicitly accepted. This is an authorization/evidence boundary, **not** a failed Browser runtime test, a demonstrated Firewall bypass or proof of remote reachability.

Consequently, do not stop SQL or accept/bind the leaf merely to encounter this known unresolved gate afterward. Stop/start counts remain0/0 and the authorized maintenance cycle has not been consumed. Rollback #002 was not applied because there was no forward mutation to undo. Do not use rollback #001 or reset original settings unnecessarily. The readiness decision remains a conditional procedure qualification; it was never NETWORK READY or unconditional execution proof.

## Smallest recommended next decision

**Prefer direct TCP port configuration in the existing Motakamel adapter**, retaining exact server/DB/reader identity, strict TLS and the current Connector→ImportOrchestrator→SQLite→SnapshotReader path. Leave SQLBrowser Stopped/Disabled. Microsoft explicitly documents port-based connections without Browser and recommends keeping Browser stopped for the more restricted setup. [SQL Firewall/access guidance](https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/configure-a-windows-firewall-for-database-engine-access?view=sql-server-ver17).

This is a proposal, not an implementation or silent workaround: the current profile does not accept a port, and the [approved live plan](MOTAKAMEL_CONNECTOR_SLICE_001_PR11_MERGE_AND_LIVE_SQL_PLAN_2026-10-09.md) explicitly requires a separate direct-port proposal. It needs owner approval for a narrow transport-only adapter/configuration change plus amending the maintenance procedure to leave Browser stopped, rather than requiring rollback because discovery was not qualified. Do not choose1433 or any other port now. After the approved one-cycle activation, capture the actual YSEDU listener/process/address port, validate it, and use that port with exact hostname certificate validation and the pinned CA. No fixed-port SQL setting, Firewall rule, host override, TLS bypass, mapping/Canonical change, import parallel path or universal connector is proposed. Normal source inspection/least privilege/provenance still fail closed.

Alternative, if retaining instanceName is required: obtain precise acceptance of a bounded Browser qualification attempt and its potential transient listener scope, with reviewed stopping/restoration and fresh administrative policy checks before running it. No such probe or new diagnostic framework was built in this task. Do not infer general/all-interface exposure acceptance from the current conditional wording.

## Remaining gates and outcome

Separate the limits: no current reader password was requested, searched, guessed or tested; readiness remains UNCONFIRMED, not proof that the secret is unavailable. If unavailable later, stop for reader-only rotation approval. Fresh administrator preflight is still needed before actual installation/service actions; successful prior operator execution does not elevate this agent token. Certificate loading, actual TCP port, strict Node TLS, frozen-source/profile checks and live SQLite import are all NOT TESTED in this round.

The signed leaf/key qualifications, rollback #002 and all prior evidence remain untouched. Archive work remains PAUSED; S3 ACCOUNTING-BLOCKED. No SQL write/ERP save/secret rotation/CA reissue/Canonical expansion. **STOP pending the explicit transport or Browser-scope decision.** `.vscode` stays outside commit.
