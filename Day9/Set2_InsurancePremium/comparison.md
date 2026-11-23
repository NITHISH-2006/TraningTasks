# Cursor vs Set-Based Comparison (Day 9 Set 2)

| Aspect | Cursor `sp_lapse_premiums` | Set-based `INSERT ... SELECT` + `UPDATE` |
|---|---|---|
| Read model | Snapshot queue table + one row per `FETCH` | Predicate evaluated once over all rows |
| Termination | `CONTINUE HANDLER FOR NOT FOUND` sets `v_done` | No loop/handler required |
| Audit | One `INSERT` per policy inside the loop | One multi-row `INSERT ... SELECT` |
| `INOUT` count | Incremented explicitly per row | Could be replaced by `ROW_COUNT()` after the update |
| Consistency risk | Longer transaction means more time for concurrent changes | Shorter statement window; predicate and update are evaluated together |
| Appropriate use | Per-policy branching, notifications or external calls | Bulk status change with identical logic for every row |

**Recommendation:** Use the set-based version for the monthly lapse job. Keep the cursor version as the documented `NOT FOUND` handler example and for future per-policy side effects.
