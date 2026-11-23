# Timing Comparison (Day 9 Set 3)

Both implementations insert one notification per prepaid subscriber below **50 units** and suppress duplicates for the current day.

```sql
SET @cursor_start = NOW(6);
CALL sp_low_balance_notifications(@cursor_notified);
SELECT TIMESTAMPDIFF(MICROSECOND, @cursor_start, NOW(6)) AS cursor_elapsed_microseconds;

SET @set_start = NOW(6);
-- INSERT ... SELECT from cursor.sql
SELECT TIMESTAMPDIFF(MICROSECOND, @set_start, NOW(6)) AS set_based_elapsed_microseconds;
```

## Interpretation

| Measure | Cursor | Set-based |
|---|---|---|
| Statements executed | `FETCH` + `INSERT` per qualifying subscriber, plus handler checks | One `INSERT ... SELECT` |
| Row count | Accumulated from per-row `ROW_COUNT()` | `ROW_COUNT()` after one statement |
| Handler | `CONTINUE HANDLER FOR NOT FOUND` ends the loop | Not needed |
| Typical elapsed time on the small seed set | Small but generally larger | Usually equal to or smaller than cursor |

On a tiny dataset the difference may be only a few hundred microseconds and cache/plan effects dominate. As subscriber counts grow, the cursor's per-row overhead grows linearly while the set-based statement still benefits from a single optimised plan. Use the set-based version for the daily notification job; keep the cursor version for cases needing per-subscriber branching or external side effects.
