# Cursor vs Set-Based Rewrite (Day 9 Set 1)

| Aspect | Cursor procedure `sp_pending_order_followups` | Set-based `INSERT ... SELECT` |
|---|---|---|
| Unit of work | One row at a time; one `FETCH` and one `INSERT` per pending order | One statement handles every pending order |
| Handler | `CONTINUE HANDLER FOR NOT FOUND` ends the loop cleanly | No handler needed |
| Duplicate control | `INSERT IGNORE` plus unique key | Same `INSERT IGNORE` plus unique key |
| Row count | Maintained manually with `ROW_COUNT()` per iteration | `ROW_COUNT()` reports total inserted rows |
| Cost | Repeated statement parsing/execution and context switches | Single parse, single execution, optimiser can choose an efficient plan |
| When useful | Need per-row branching, external calls or row-specific exception handling | Pure bulk insert/update, as here |

**Conclusion:** The set-based rewrite is preferred for this follow-up job. The cursor version is retained to demonstrate `NOT FOUND` handling and to show the pattern to use when each row requires distinct procedural logic.
