# S2 canonical bytes and source authority

2026-10-25 · Implemented synthetic contract, not an ERP protocol qualification.

## Authority boundary

The owner factory accepts exactly `companyId, scopeId, originId, connectorVersion, producerBuildSha256, mappingVersion, publicKeySpki, validFromMs, validUntilMs`. IDs/namespace/epoch are generated locally. Registration revision is 1, profile is `synthetic.catalog.capture.1`, trust class is `synthetic`, proof policy is `catalog-synthetic-proof.1`. SPKI is canonical DER for Ed25519; `keyId` is lowercase SHA-256 of those DER bytes. No private key is accepted or persisted. Trusted owner setup is an application trust boundary, not OS isolation against a process already able to modify the same database.

The verifier requires a separately selected `{sourceId,epoch}` and exactly three local file paths: `payloadPath,receiptPath,signaturePath`. Payload cannot choose the selected source, registration, namespace or trust anchor. Remote URLs/UNC paths and symbolic redirects are refused; ordinary local filesystem/drive trust remains an operating-system prerequisite. No data drive is mounted or network contacted by this implementation.

Request IDs are random UUIDs and challenges are 32 random bytes represented as 64 lowercase hexadecimal characters. Validity is 1–3,600,000 ms and must fit the key-validity window. Times are integer UTC Unix milliseconds. Verification requires a currently enabled registration, currently pending/unexpired request, exact challenge, `issued <= start <= finish < expiry`, finish not in the future and capture inside key validity. Parent is null in S2. Source control revision is reported as metadata, not a future authorization capability.

## Canonical format

UTF-8, no BOM, no trailing newline, no whitespace beyond that produced inside JSON strings. Exact ordered fields, no unknown fields or duplicate JSON keys. Objects are reconstructed with the order below and must re-encode byte-for-byte identically using Node JSON string encoding. Numbers are safe integers without negative zero, scientific/alternate spellings, NaN, infinity or coercion. JSON depth is at most 8. Strings must contain valid Unicode scalar sequences, no C0/DEL controls; required identifiers are nonempty, trimmed and bounded. No Unicode normalization occurs.

Payload ordered fields: `format, declaredCount, products`; format `dbl.catalog.products.1`. Each row has exactly `sourceKey, sku, name` in that order. Key/SKU/name limits are 256/256/1024 Unicode scalar values. Stable source key is trimmed; SKU is mutable presentation data, not identity. Rows sort strictly by unsigned UTF-8 bytes of `sourceKey`, not locale order or JavaScript UTF-16 order; duplicate keys fail. Empty full catalog is valid under this synthetic contract. Maximum 1,000 rows and 1 MiB payload are explicit C1 synthetic bounds, unrelated to the preserved V1 five-item guard.

Receipt ordered fields:

```
format, sourceId, epoch, companyId, scopeId, originId,
registrationRevision, profileId, connectorVersion, producerBuildSha256,
mappingVersion, proofPolicyVersion, keyId, requestId, challenge,
expectedParentId, captureId, sequence, startedAtMs, finishedAtMs,
observation, payload
```

Receipt format is `dbl.catalog.capture-proof.1`, maximum 64 KiB. Sequence is a positive safe integer, with no accepted ordering ledger yet. `observation` order: `method, completed, pageCount, endMarker, rowCount, keySetSha256, productSetSha256`. Fixed values are `synthetic-consistent-fixture.1`, true, 1, `completed`. This is one coherent synthetic full-fixture read, not a pagination implementation. `payload` order: `bytes, sha256`; length and raw-byte hash must match the delivered payload.

Set hashes are SHA-256 over:

```
ASCII("dbl.catalog.key-set.1") || 0x00 || UTF8(JSON(sorted stable-key array))
ASCII("dbl.catalog.product-set.1") || 0x00 || UTF8(JSON(sorted full row array))
```

Receipt signature is exactly 64 raw Ed25519 bytes over the **entire canonical receipt bytes**, including its fixed profile, scope, request and payload identity. Only the locally pinned SPKI key is used. No key is trusted because it appears alongside a file. The producer derives row count/set hashes from its independently known full source, not from the delivered subset. Verification compares all three source observations with the delivered rows.

## Frozen vectors

For the one-row set `[{"sourceKey":"A","sku":"A4","name":"ورق"}]`:

- Arabic UTF-8 bytes: `d988d8b1d982`.
- Key-set digest: `dcd057ad4f93497378a2fd3b74856af3f91769cea0f997b6e051d9803be0bdff`.
- Product-set digest: `19fcac00baa4c5e2fc672269acf566092eb233d7315b92365bcd147971a97520`.

Tests also pin supplementary-Unicode ordering, escaped quotes/backslashes, exact receipt field order, invalid encodings/duplicates/numeric spellings and signed noncanonical bytes. Persistent accepted capture identity, anti-rollback and transaction-time authority revalidation must be implemented/tested in S3, not inferred from these vectors.
