# Trigger Pitfalls (Day 10 Set 1)

## Two risks

1. **Hidden logic.** An `UPDATE product_price SET selling_price = 90` that looks harmless in application code can fail in the database. Developers who only read Java code may not discover the rule until runtime. Document triggers in the schema and expose the same validation in API documentation.
2. **Cascading effects.** A trigger can write to other tables, fire other triggers and multiply work inside a statement. In a multi-row update the trigger runs once per row, so a 10,000-row update can create 10,000 audit rows and take noticeably longer. Unexpected cascades also make deadlocks harder to diagnose.

## When application code is better

Prefer application-layer validation when the rule depends on UI context, external services, feature flags or a workflow that changes often. Example: "only a pricing manager may apply a discount above 20% during a promotion" needs the actor's role in the current request and possibly an approval service call; putting that in a trigger would tie the database to an application workflow and make promotion changes require a DDL deployment.

## What stays in the database here

The below-cost guard is an invariant of the data itself, so a `BEFORE UPDATE` trigger is appropriate. The audit is mandatory for every client (JDBC, scripts, other services), so the `AFTER UPDATE` trigger is also appropriate. The multi-row test shows that InnoDB's statement atomicity preserves consistency: a rejected row aborts the whole statement rather than leaving half the batch changed.

`information_schema.TRIGGERS` lists every trigger in the schema and is the first place to look during debugging.
