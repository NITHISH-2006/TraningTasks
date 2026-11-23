# Boundary Tests - Day 11 Set 2

Rates: 0-100 @ 3, 101-200 @ 5, 201-400 @ 7, above 400 @ 9. Fixed charge: Domestic 50, Commercial 150, Industrial 300.

| Units | Energy charge calculation | Energy | Fixed | Total (no surcharge/rebate) |
|---:|---|---:|---:|---:|
| 100 | 100 x 3 | 300.00 | 50.00 | 350.00 |
| 101 | 100 x 3 + 1 x 5 | 305.00 | 50.00 | 355.00 |
| 200 | 100 x 3 + 100 x 5 | 800.00 | 50.00 | 850.00 |
| 201 | 100 x 3 + 100 x 5 + 1 x 7 | 807.00 | 50.00 | 857.00 |
| 400 | 100 x 3 + 100 x 5 + 200 x 7 | 2200.00 | 50.00 | 2250.00 |
| 401 | 100 x 3 + 100 x 5 + 200 x 7 + 1 x 9 | 2209.00 | 50.00 | 2259.00 |

## Sample meter-reading run

Input (previous/current pairs, then sentinel `0`):

```text
1200 1350 1350 1500 1500 1605 0
```

| Pair | Units | Late surcharge | Online rebate | Payable |
|---|---:|---:|---:|---:|
| 1200 -> 1350 | 150 | 60.00 | 13.20 | 646.80 |
| 1350 -> 1500 | 150 | 60.00 | 13.20 | 646.80 |
| 1500 -> 1605 | 105 | 37.50 | 8.25 | 404.25 |

The `do-while` loop reads until the previous reading is `0`. The `for` loop prints the 12-month Commercial statement.

## Operator precedence

`totalPayable = (subtotal + surcharge) - rebate` is evaluated as follows:

1. `*` in `subtotal * 0.10` and `(subtotal + surcharge) * 0.02` happens before `+`/`-`.
2. Parentheses around `subtotal + surcharge` force the surcharge to be included in the rebate base.
3. The final `- rebate` happens after both additions because `+` and `-` share precedence and associate left-to-right.

## Casting findings

- `7 / 2` is integer division and yields `3`; cast one operand to `double` for `3.50`.
- `Integer.MAX_VALUE + 1` wraps to `-2147483648`; widen to `long` before adding.
- `(int) 99.99` truncates to `99`; use `Math.round` before casting when rounding is intended.
