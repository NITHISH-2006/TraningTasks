# Notes - Day 9 Set 2

- `vw_policy_due` removes `phone` and `pan_number` and exposes only the due-date window (`CURDATE()` to `CURDATE() + 30 days`).
- `sp_renew_policy` uses `IN` for the policy id and `INOUT` for the running processed count; validation, recalculation, policy update and audit insert share one transaction.
- The `EXIT HANDLER` rolls back the whole renewal if validation or any SQL statement fails; the caller receives the `SIGNAL` message.
- `fn_premium_with_no_claim_discount` is deterministic and side-effect free, so it is safe inside `SELECT`.
- The cursor processes a snapshot queue table, avoiding undefined behaviour from updating the same table that the cursor reads.
- The set-based rewrite performs the same lapse work in two statements and is preferred for batch jobs.
