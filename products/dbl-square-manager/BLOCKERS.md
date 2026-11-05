# Blockers and Limitations

- Redistribution permission for the pinned third-party upstream files has not been confirmed; they are excluded from the private repository and must be obtained separately under applicable terms.
- Offline tests use synthetic data and mocked network calls; they do not prove the new publishing path has completed a real publication.
- Account identity is not independently verified by the API workflow. Ambiguous outcomes need manual review; there is no automatic retry.
- A new checkout requires explicit local initialization and upstream-file integrity verification before the guarded workflow is usable. Preserving prior evidence remains necessary.
