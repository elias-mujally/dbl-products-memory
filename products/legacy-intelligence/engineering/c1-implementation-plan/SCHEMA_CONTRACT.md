# C1 Catalog SQLite schema contract — candidate DDL

2026-10-25 · [Index](README.md) · **Documentation only. The SQL below has NOT been executed, parsed by SQLite or qualified. S1 must test and review it after implementation approval. No .sql migration file or database is created now.**

## Isolation and bootstrap

One new managed directory contains `CATALOG_STATE.json` (family hint) and `catalog.sqlite`; neither `STATE.json`, `inventory.sqlite`, `control.sqlite` nor V1 migrations are reused. The authoritative descriptor is inside the DB; the marker helps refuse wrong-family opens before writable initialization. Unknown/contradictory descriptors fail closed. A filename alone is not identity.

Reserve a wholly new directory exclusively; refuse existing nonempty or linked/reparse targets without repairing them. Publish the bootstrap marker before creating the DB. Initialize the schema, format/version/checksum and compatibility fence in one SQLite transaction initially in rollback journal mode; set application_id `0x44424C43` (DBLC) before commit. Close/reopen and validate, then use WAL/FULL for acceptance. This ensures the family header is in the main file before WAL operation. Interrupted bootstrap remains incomplete and blocked; never adopt it as an empty legacy DB. Marker/DB publication itself is not claimed cross-file atomic; acceptance cannot start until both agree. No old state participates.

All writer connections enable and verify foreign_keys and recursive_triggers before a transaction; the latter is needed for immutable DELETE guards to reject REPLACE as well. Use ordinary parameterized INSERT, never INSERT OR REPLACE. Catalog migration lineage starts at 1, independent of ordinary store migrations. The next format is never auto-upgraded by `open`; opening unsupported format/schema fails. The initializer is only available through explicit owner-side new-state creation. A separate migration command/design will be needed for any future nonempty upgrade.

The compatibility fence uses the ordinary engine's existing future-version refusal without pretending Catalog is ordinary schema v4. It is a deliberate reserved lineage signal, not an applied legacy migration. It blocks the reviewed generic store's migrations before staging cleanup. New DBL public writer entry points must additionally perform read-only family preflight. Arbitrary old audit tools or raw SQLite access by the file owner are not a security boundary; do not claim universal rejection of every historical executable.

## Candidate table definitions

All tables below are STRICT (SQLite 3.37+); S1 must verify the installed runtime supports this without installing/upgrading anything. STRICT prevents fractional values in INTEGER columns; the input verifier additionally rejects numeric strings/coercions and enforces exact safe-integer/time bounds. Time values are integer UTC milliseconds, sequences are exact safe integers; public grammar adds stricter bounds/closed fields. All identity columns are NOT NULL and compared BINARY, with no SKU uniqueness or implicit key normalization. `epoch` is immutable inside one source domain; re-enrollment is not a file-side reset.

```sql
-- DESIGN TEXT ONLY: do not run before implementation approval.
CREATE TABLE catalog_format (
  singleton INTEGER PRIMARY KEY CHECK(singleton = 1),
  state_id TEXT NOT NULL UNIQUE CHECK(length(state_id) > 0),
  family TEXT NOT NULL CHECK(family = 'dbl.catalog-state'),
  format_version INTEGER NOT NULL CHECK(format_version = 1),
  state_class TEXT NOT NULL CHECK(state_class = 'synthetic')
) STRICT;
CREATE TABLE catalog_migrations (
  version INTEGER PRIMARY KEY CHECK(version > 0),
  name TEXT NOT NULL UNIQUE,
  checksum TEXT NOT NULL CHECK(length(checksum) = 64),
  applied_at_ms INTEGER NOT NULL CHECK(applied_at_ms >= 0)
) STRICT;
-- Reserved compatibility fence; not the catalog migration journal.
CREATE TABLE schema_migrations (
  version INTEGER PRIMARY KEY CHECK(version = 2147483647),
  name TEXT NOT NULL CHECK(name = 'catalog-lineage-fence-1'),
  checksum TEXT NOT NULL CHECK(length(checksum) = 64),
  applied_at TEXT NOT NULL
) STRICT;

CREATE TABLE catalog_sources (
  source_id TEXT NOT NULL,
  epoch TEXT NOT NULL,
  company_id TEXT NOT NULL,
  scope_id TEXT NOT NULL,
  namespace TEXT NOT NULL UNIQUE,
  created_at_ms INTEGER NOT NULL CHECK(created_at_ms >= 0),
  PRIMARY KEY(source_id, epoch),
  CHECK(length(source_id)>0 AND length(epoch)>0 AND length(company_id)>0
        AND length(scope_id)>0 AND length(namespace)>0)
) STRICT;
CREATE TABLE catalog_registrations (
  source_id TEXT NOT NULL,
  epoch TEXT NOT NULL,
  revision INTEGER NOT NULL CHECK(revision > 0),
  profile_id TEXT NOT NULL CHECK(profile_id = 'synthetic.catalog.capture.1'),
  trust_class TEXT NOT NULL CHECK(trust_class = 'synthetic'),
  expected_origin BLOB NOT NULL,
  connector_version TEXT NOT NULL,
  producer_build_sha256 TEXT NOT NULL CHECK(length(producer_build_sha256)=64),
  mapping_version TEXT NOT NULL,
  proof_policy_version TEXT NOT NULL,
  key_id TEXT NOT NULL,
  public_key_spki BLOB NOT NULL CHECK(length(public_key_spki) BETWEEN 32 AND 1024),
  key_sha256 TEXT NOT NULL CHECK(length(key_sha256)=64),
  valid_from_ms INTEGER NOT NULL CHECK(valid_from_ms >= 0),
  valid_until_ms INTEGER NOT NULL CHECK(valid_until_ms > valid_from_ms),
  PRIMARY KEY(source_id, epoch, revision),
  UNIQUE(source_id, epoch, revision, key_id),
  FOREIGN KEY(source_id, epoch) REFERENCES catalog_sources(source_id, epoch)
) STRICT;
CREATE TABLE catalog_source_control (
  source_id TEXT NOT NULL,
  epoch TEXT NOT NULL,
  active_registration INTEGER NOT NULL,
  status TEXT NOT NULL CHECK(status IN ('pending','enabled','suspended','revoked')),
  control_revision INTEGER NOT NULL CHECK(control_revision > 0),
  PRIMARY KEY(source_id, epoch),
  FOREIGN KEY(source_id, epoch, active_registration)
    REFERENCES catalog_registrations(source_id, epoch, revision)
) STRICT;

CREATE TABLE catalog_requests (
  source_id TEXT NOT NULL,
  epoch TEXT NOT NULL,
  request_id TEXT NOT NULL,
  registration_revision INTEGER NOT NULL,
  challenge BLOB NOT NULL UNIQUE CHECK(length(challenge)=32),
  expected_parent_id TEXT,
  issued_at_ms INTEGER NOT NULL CHECK(issued_at_ms >= 0),
  expires_at_ms INTEGER NOT NULL CHECK(expires_at_ms > issued_at_ms),
  status TEXT NOT NULL CHECK(status IN ('pending','consumed','cancelled')),
  consumed_admission_id TEXT,
  PRIMARY KEY(source_id, epoch, request_id),
  UNIQUE(source_id, epoch, request_id, registration_revision),
  UNIQUE(source_id, epoch, request_id, registration_revision, status, consumed_admission_id),
  CHECK((status='consumed' AND consumed_admission_id IS NOT NULL)
     OR (status<>'consumed' AND consumed_admission_id IS NULL)),
  FOREIGN KEY(source_id, epoch, registration_revision)
    REFERENCES catalog_registrations(source_id, epoch, revision),
  FOREIGN KEY(source_id, epoch, expected_parent_id)
    REFERENCES catalog_admissions(source_id, epoch, admission_id),
  FOREIGN KEY(source_id, epoch, request_id, consumed_admission_id)
    REFERENCES catalog_admissions(source_id, epoch, request_id, admission_id)
    DEFERRABLE INITIALLY DEFERRED
) STRICT;
CREATE UNIQUE INDEX catalog_one_pending_request
  ON catalog_requests(source_id, epoch) WHERE status='pending';

CREATE TABLE catalog_reviews (
  source_id TEXT NOT NULL,
  epoch TEXT NOT NULL,
  request_id TEXT NOT NULL,
  registration_revision INTEGER NOT NULL,
  receipt_sha256 TEXT NOT NULL CHECK(length(receipt_sha256)=64),
  payload_sha256 TEXT NOT NULL CHECK(length(payload_sha256)=64),
  expected_parent_id TEXT,
  missing_keys_sha256 TEXT NOT NULL CHECK(length(missing_keys_sha256)=64),
  event_id TEXT NOT NULL,
  event_kind TEXT NOT NULL DEFAULT 'missing.reviewed' CHECK(event_kind='missing.reviewed'),
  reviewed_at_ms INTEGER NOT NULL CHECK(reviewed_at_ms >= 0),
  PRIMARY KEY(source_id, epoch, request_id, receipt_sha256),
  FOREIGN KEY(source_id, epoch, request_id, registration_revision)
    REFERENCES catalog_requests(source_id, epoch, request_id, registration_revision),
  FOREIGN KEY(source_id, epoch, expected_parent_id)
    REFERENCES catalog_admissions(source_id, epoch, admission_id),
  FOREIGN KEY(source_id, epoch, event_id, event_kind)
    REFERENCES catalog_events(source_id, epoch, event_id, event_kind)
    DEFERRABLE INITIALLY DEFERRED
) STRICT;

CREATE TABLE catalog_snapshots (
  source_id TEXT NOT NULL,
  epoch TEXT NOT NULL,
  snapshot_id TEXT NOT NULL,
  admission_id TEXT NOT NULL,
  captured_at_ms INTEGER NOT NULL CHECK(captured_at_ms >= 0),
  product_count INTEGER NOT NULL CHECK(product_count BETWEEN 0 AND 1000),
  product_set_sha256 TEXT NOT NULL CHECK(length(product_set_sha256)=64),
  PRIMARY KEY(source_id, epoch, snapshot_id),
  UNIQUE(source_id, epoch, snapshot_id, admission_id),
  FOREIGN KEY(source_id, epoch) REFERENCES catalog_sources(source_id, epoch),
  FOREIGN KEY(source_id, epoch, admission_id, snapshot_id)
    REFERENCES catalog_admissions(source_id, epoch, admission_id, snapshot_id)
    DEFERRABLE INITIALLY DEFERRED
) STRICT;
CREATE TABLE catalog_products (
  source_id TEXT NOT NULL,
  epoch TEXT NOT NULL,
  snapshot_id TEXT NOT NULL,
  source_key TEXT NOT NULL COLLATE BINARY CHECK(length(source_key) BETWEEN 1 AND 256),
  sku TEXT NOT NULL CHECK(length(sku) BETWEEN 1 AND 256),
  name TEXT NOT NULL CHECK(length(name) BETWEEN 1 AND 1024),
  PRIMARY KEY(source_id, epoch, snapshot_id, source_key),
  FOREIGN KEY(source_id, epoch, snapshot_id)
    REFERENCES catalog_snapshots(source_id, epoch, snapshot_id)
) STRICT;

CREATE TABLE catalog_events (
  source_id TEXT NOT NULL,
  epoch TEXT NOT NULL,
  event_id TEXT NOT NULL,
  event_kind TEXT NOT NULL CHECK(event_kind IN
    ('source.enrolled','source.changed','request.created','request.cancelled',
     'missing.reviewed','capture.observed','capture.rejected','capture.accepted')),
  admission_id TEXT,
  claimed_capture_id TEXT,
  claimed_sequence INTEGER,
  statement_sha256 TEXT,
  data BLOB NOT NULL,
  data_sha256 TEXT NOT NULL CHECK(length(data_sha256)=64),
  occurred_at_ms INTEGER NOT NULL CHECK(occurred_at_ms >= 0),
  PRIMARY KEY(source_id, epoch, event_id),
  UNIQUE(source_id, epoch, event_id, event_kind),
  UNIQUE(source_id, epoch, admission_id, event_id, event_kind),
  CHECK((event_kind='capture.accepted' AND admission_id IS NOT NULL)
     OR (event_kind<>'capture.accepted' AND admission_id IS NULL)),
  CHECK((event_kind='capture.observed' AND claimed_capture_id IS NOT NULL
         AND claimed_sequence IS NOT NULL AND claimed_sequence BETWEEN 1 AND 9007199254740991
         AND statement_sha256 IS NOT NULL AND length(statement_sha256)=64)
     OR (event_kind<>'capture.observed' AND claimed_capture_id IS NULL
         AND claimed_sequence IS NULL AND statement_sha256 IS NULL)),
  FOREIGN KEY(source_id, epoch) REFERENCES catalog_sources(source_id, epoch),
  FOREIGN KEY(source_id, epoch, admission_id)
    REFERENCES catalog_admissions(source_id, epoch, admission_id)
    DEFERRABLE INITIALLY DEFERRED
) STRICT;
CREATE INDEX catalog_observed_capture
  ON catalog_events(source_id, epoch, claimed_capture_id, statement_sha256)
  WHERE event_kind='capture.observed';
CREATE INDEX catalog_observed_sequence
  ON catalog_events(source_id, epoch, claimed_sequence, statement_sha256)
  WHERE event_kind='capture.observed';
CREATE TABLE catalog_admissions (
  source_id TEXT NOT NULL,
  epoch TEXT NOT NULL,
  admission_id TEXT NOT NULL,
  capture_id TEXT NOT NULL,
  sequence INTEGER NOT NULL CHECK(sequence BETWEEN 1 AND 9007199254740991),
  request_id TEXT NOT NULL,
  request_state TEXT NOT NULL DEFAULT 'consumed' CHECK(request_state='consumed'),
  registration_revision INTEGER NOT NULL,
  key_id TEXT NOT NULL,
  snapshot_id TEXT NOT NULL,
  source_row_count INTEGER NOT NULL CHECK(source_row_count BETWEEN 0 AND 1000),
  source_set_sha256 TEXT NOT NULL CHECK(length(source_set_sha256)=64),
  payload_sha256 TEXT NOT NULL CHECK(length(payload_sha256)=64),
  receipt_sha256 TEXT NOT NULL CHECK(length(receipt_sha256)=64),
  receipt_bytes BLOB NOT NULL CHECK(length(receipt_bytes) BETWEEN 1 AND 65536),
  signature BLOB NOT NULL CHECK(length(signature)=64),
  started_at_ms INTEGER NOT NULL CHECK(started_at_ms >= 0),
  finished_at_ms INTEGER NOT NULL CHECK(finished_at_ms >= started_at_ms),
  accepted_at_ms INTEGER NOT NULL CHECK(accepted_at_ms >= 0),
  acceptance_event_id TEXT NOT NULL,
  acceptance_event_kind TEXT NOT NULL DEFAULT 'capture.accepted'
    CHECK(acceptance_event_kind='capture.accepted'),
  PRIMARY KEY(source_id, epoch, admission_id),
  UNIQUE(source_id, epoch, capture_id),
  UNIQUE(source_id, epoch, sequence),
  UNIQUE(source_id, epoch, snapshot_id),
  UNIQUE(source_id, epoch, admission_id, snapshot_id),
  UNIQUE(source_id, epoch, request_id),
  UNIQUE(source_id, epoch, request_id, admission_id),
  FOREIGN KEY(source_id, epoch, registration_revision, key_id)
    REFERENCES catalog_registrations(source_id, epoch, revision, key_id),
  FOREIGN KEY(source_id, epoch, snapshot_id, admission_id)
    REFERENCES catalog_snapshots(source_id, epoch, snapshot_id, admission_id)
    DEFERRABLE INITIALLY DEFERRED,
  FOREIGN KEY(source_id, epoch, request_id, registration_revision, request_state, admission_id)
    REFERENCES catalog_requests(source_id, epoch, request_id, registration_revision, status, consumed_admission_id)
    DEFERRABLE INITIALLY DEFERRED,
  FOREIGN KEY(source_id, epoch, admission_id, acceptance_event_id, acceptance_event_kind)
    REFERENCES catalog_events(source_id, epoch, admission_id, event_id, event_kind)
    DEFERRABLE INITIALLY DEFERRED
) STRICT;
CREATE TABLE catalog_heads (
  source_id TEXT NOT NULL,
  epoch TEXT NOT NULL,
  admission_id TEXT NOT NULL,
  PRIMARY KEY(source_id, epoch),
  FOREIGN KEY(source_id, epoch, admission_id)
    REFERENCES catalog_admissions(source_id, epoch, admission_id)
) STRICT;
```

All foreign keys use default NO ACTION, no cascading deletion. The cyclic deferred links deliberately prevent a committed admission without snapshot, consumed matching request and acceptance event, or a snapshot claiming acceptance without its admission. Null expected_parent means first capture only; it is compared with current using NULL-safe equality in the private transaction, not ignored by application convention. Index parent columns match their declared composite UNIQUE/PKs; S1 must exercise actual SQLite foreign-key mismatch errors, not just table creation.

No separate mutable last_sequence: derive it by joining head -> immutable admission, so it cannot diverge. Authenticated capture.observed events retain exact signed statement bytes/signature/registration references in their bounded data BLOB after signature/origin/request binding checks, before full-set admission. Their indexed claimed IDs allow detecting a producer fork even if an earlier authenticated statement was rejected later; they are not accepted captures and do not reserve/advance head. Unauthenticated files cannot create these events. The data BLOB's canonical hash and decoded bindings are checked by the service, not asserted from SQL length alone.

No product deleted/quantity/money/warehouse/customer/sale fields in this catalog-only format. Same SKU is allowed across keys and companies. Source/company/scope never move within one source domain. Future ERP-qualified profiles or larger bounds require reviewed format/policy changes; files cannot select a new trust_class.

## Required triggers and invariants in addition to the table DDL

The implementation must generate/review exact trigger bodies in S1 and test them. The trigger contract is explicit here; it is **not yet validated DDL**:

| Guard | Exact behavior |
| --- | --- |
| Immutable identity/evidence | Reject UPDATE and DELETE of sources, registrations, reviews, snapshots, products, admissions and events; no `INSERT OR REPLACE` bypass. Format/migration/fence rows also sealed after bootstrap |
| Product seal | BEFORE INSERT product: reject if an admission already exists for this source/epoch/snapshot. Thus insert products before admission; no extra product can be appended to an accepted capture |
| Admission prerequisites | BEFORE INSERT admission: require control enabled at the same registration; pending request at that revision; expected_parent NULL-safely equals current head; greater sequence and finish time than current if present; snapshot count equals actual product COUNT and source_row_count, snapshot set digest equals source_set_sha256 |
| Automatic head | AFTER INSERT admission: insert first head or update it to the just-inserted admission. Missing caller head update cannot leave an accepted capture invisible. Guard UPDATE to same domain and strictly greater sequence; reject head deletion |
| Request state | Immutable request identity/nonce/parent/revision/time fields. Only pending -> cancelled or pending -> consumed with one matching admission; reject deletion and terminal transitions. Partial UNIQUE index enforces one pending request |
| Control revision | Immutable source domain; control revision strictly increases on status/active-registration change. Active registration must exist. No capture file can call this owner-side operation |

Four central trigger bodies are specified below to make the acceptance/head constraint review concrete. They are also **unexecuted candidate SQL**. The other guards in the table above remain mandatory S1 work, not optional hardening.

```sql
CREATE TRIGGER catalog_product_seal BEFORE INSERT ON catalog_products
WHEN EXISTS(SELECT 1 FROM catalog_admissions a
  WHERE a.source_id=NEW.source_id AND a.epoch=NEW.epoch AND a.snapshot_id=NEW.snapshot_id)
BEGIN SELECT RAISE(ABORT,'catalog snapshot sealed'); END;

CREATE TRIGGER catalog_admission_prerequisites BEFORE INSERT ON catalog_admissions
WHEN NOT EXISTS(
  SELECT 1 FROM catalog_source_control c
  JOIN catalog_requests r ON r.source_id=c.source_id AND r.epoch=c.epoch
  JOIN catalog_snapshots s ON s.source_id=c.source_id AND s.epoch=c.epoch
  WHERE c.source_id=NEW.source_id AND c.epoch=NEW.epoch AND c.status='enabled'
    AND c.active_registration=NEW.registration_revision
    AND r.request_id=NEW.request_id AND r.registration_revision=NEW.registration_revision
    AND r.status='pending'
    AND r.expected_parent_id IS (SELECT h.admission_id FROM catalog_heads h
      WHERE h.source_id=NEW.source_id AND h.epoch=NEW.epoch)
    AND s.snapshot_id=NEW.snapshot_id AND s.admission_id=NEW.admission_id
    AND s.captured_at_ms=NEW.finished_at_ms
    AND s.product_count=NEW.source_row_count AND s.product_set_sha256=NEW.source_set_sha256
    AND s.product_count=(SELECT COUNT(*) FROM catalog_products p
      WHERE p.source_id=NEW.source_id AND p.epoch=NEW.epoch AND p.snapshot_id=NEW.snapshot_id)
) OR EXISTS(
  SELECT 1 FROM catalog_heads h JOIN catalog_admissions a
    ON a.source_id=h.source_id AND a.epoch=h.epoch AND a.admission_id=h.admission_id
  WHERE h.source_id=NEW.source_id AND h.epoch=NEW.epoch
    AND (NEW.sequence<=a.sequence OR NEW.finished_at_ms<=a.finished_at_ms)
)
BEGIN SELECT RAISE(ABORT,'catalog admission prerequisites'); END;

CREATE TRIGGER catalog_head_forward BEFORE UPDATE ON catalog_heads
WHEN NEW.source_id<>OLD.source_id OR NEW.epoch<>OLD.epoch
  OR COALESCE((SELECT a.sequence FROM catalog_admissions a
      WHERE a.source_id=NEW.source_id AND a.epoch=NEW.epoch AND a.admission_id=NEW.admission_id),-1)
    <= (SELECT a.sequence FROM catalog_admissions a
      WHERE a.source_id=OLD.source_id AND a.epoch=OLD.epoch AND a.admission_id=OLD.admission_id)
BEGIN SELECT RAISE(ABORT,'catalog head must advance'); END;

CREATE TRIGGER catalog_admission_head AFTER INSERT ON catalog_admissions
BEGIN
  INSERT INTO catalog_heads(source_id,epoch,admission_id)
    VALUES(NEW.source_id,NEW.epoch,NEW.admission_id)
    ON CONFLICT(source_id,epoch) DO UPDATE SET admission_id=excluded.admission_id;
END;
```

SQL prerequisites compare stored facts; they **do not verify Ed25519 or prove source truth**. The private writer must recompute the staged-in-transaction product digest, recheck signature authority and full proof and compare them before admission insertion. A copied digest or a magic SQL capability function is not authentication. Ordinary APIs have no raw connection, generic trusted flag or public insert-admission method. File-owner/raw SQL mutation is explicitly outside this API threat model.

Every trusted write in S3 uses the same connection, foreign_keys ON and one BEGIN IMMEDIATE/COMMIT. Requests and acceptance-event cycles are deferred until commit; duplicate products/capture/sequence and head monotonicity fail earlier. Empty attested set passes row COUNT=0 but still requires source proof and missing-set review where applicable. Rejection events may be appended independently; they never satisfy acceptance-event linkage.

## What S1 must prove before this design is called implementable

Actual DDL/trigger syntax and runtime compatibility; missing/mismatched composite parents; duplicate and NULL identities; request consumed by the wrong capture; orphan snapshot/event/admission; cross-company head; accepted-row mutation and REPLACE; append-after-seal; head regression; partial-index contention; failed COMMIT from deferred constraints; unknown schema and bootstrap failure. Also test SHA-256 field grammar in the parser (lowercase hexadecimal, not length alone); DB length checks are not that parser.

S1 must execute the reviewed schema only on new synthetic DBs after approval. If a proposed constraint needs redesign, stop that slice and show the smallest schema diff; do not weaken a test to make the plan appear proven. A migration checksum is recorded from fixed schema SQL bytes, not transformed function.toString(), avoiding coupling evidence to a build representation. No checksum or SQL artifact is fabricated as executed in this planning task.

References: [SQLite STRICT tables](https://www.sqlite.org/stricttables.html), [SQLite composite/deferred foreign keys](https://www.sqlite.org/foreignkeys.html), [unique partial indexes](https://www.sqlite.org/partialindex.html), [trigger behavior](https://www.sqlite.org/lang_createtrigger.html). These support the design primitives, not validation of this unexecuted schema.
