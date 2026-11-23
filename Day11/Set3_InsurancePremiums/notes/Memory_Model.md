# Memory Model - Day 11 Set 3

## Stack vs heap

| Item | Stored in | Why |
|---|---|---|
| `main` frame, `applicants`, `results`, `bmi`, `bmiInfo`, `band`, `basePremium`, `totalLoading`, `finalPremium` | Stack | Local variables and primitive values live in the method frame; references also live there |
| `List.of(...)` list and each `InsuranceApplicant` record | Heap | Objects created with `new`/factories are heap allocated |
| Sealed band records (`Young`, `Adult`, `Senior`) | Heap | Returned by `AgeBand.fromAge` and referenced by `band` |
| `BmiInfo` and `PremiumResult` records in `results` | Heap | Immutable objects created per applicant |
| String literals such as `"APPROVED"` | String constant pool (heap, metaspace-backed history in older JDKs) | Interned literals are reused |

Each method call pushes a new stack frame. When `classifyBmi`, `basePremium` or `isEligible` returns, its frame is popped and its local primitives disappear; any objects they returned remain on the heap while referenced.

## Garbage collection

An object is eligible for garbage collection when it is no longer reachable from a GC root (for example, a static field or a live stack frame). In this program, a `PremiumResult` stays reachable through `results`. If `results` goes out of scope after `main` prints, all its records and their strings become unreachable and the JVM may reclaim them. Calling `System.gc()` would only request a collection; the JVM decides when to run it. Records are immutable, so no object is mutated into an inconsistent state after being shared.

## Operator precedence in the final premium

```java
var finalPremium = Math.round(basePremium * (1 + totalLoading / 100.0) * 100.0) / 100.0;
```

Evaluation order:

1. `totalLoading / 100.0` - `/` binds tighter than `+`.
2. `1 + ...` - parentheses force the loading factor first.
3. `basePremium * factor * 100.0` - `*` associates left-to-right.
4. `Math.round(...)` rounds to a whole number; `/ 100.0` restores two decimal places.

In `isEligible`, comparison operators (`>=`, `<=`) are evaluated before `&&` and `||`, so each age/BMI/term bound is tested first and then combined. The labelled `break batchValidation` exits the labelled enhanced `for` immediately when applicant I005 fails the age check; I006-I008 are added as `NOT_VALIDATED` only for reporting completeness.
