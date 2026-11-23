# Justification Note (Day 10 Set 3)

## Trigger vs `CHECK` constraint

A `CHECK` constraint is the better choice when the rule is a simple, row-local invariant: for example, `CHECK (occupied >= 0 AND occupied <= capacity)` on `wards`. The database rejects any invalid row immediately, the rule is visible in `SHOW CREATE TABLE`, and no procedural code is needed.

A trigger is necessary here because "do not admit when the ward is full" compares a new `admissions` row with current state in another table. MySQL `CHECK` constraints cannot query other tables, so a `BEFORE INSERT`/`BEFORE UPDATE` trigger with `SIGNAL SQLSTATE '45000'` is appropriate. The `AFTER` triggers also maintain `wards.occupied` and write the audit row for every client automatically.

## Trigger vs stored procedure

A stored procedure is better when the caller should choose a different workflow rather than simply being blocked. For example, `sp_admit_or_waitlist(patient_id, ward_id)` could check capacity, insert into `admissions` when a bed is free, or insert into a `waitlist` table otherwise. That is an application-level policy with more than one valid outcome, so it belongs in a procedure that callers invoke explicitly.

Keep the trigger for the invariant: no raw `INSERT` may overfill a ward. Add a procedure if the business later wants an automatic waitlist.

## Multi-row InnoDB behaviour

Triggers are row-level. In the two-row test, the first row passes the guard and its `AFTER` trigger increments `occupied`. The second row then sees `occupied = capacity` and raises `SIGNAL`. Because the whole `INSERT` is one InnoDB statement, the failed row aborts the statement and the first row's insert, audit row and bed increment are all rolled back. There is no partially applied admission.

## JDBC application-layer test

```java
String sql = "INSERT INTO admissions (patient_name, ward_id, status) VALUES (?, ?, 'ADMITTED')";
try (PreparedStatement ps = connection.prepareStatement(sql)) {
    ps.setString(1, "Patient JDBC");
    ps.setLong(2, 1L);
    ps.executeUpdate();
    System.out.println("Admission inserted");
} catch (SQLException e) {
    if ("45000".equals(e.getSQLState())) {
        System.out.println("Business rule enforced: " + e.getMessage());
    } else {
        throw e;
    }
}
```

The test asserts both outcomes: a valid admission increases `wards.occupied` and writes an `INSERT` audit row, while a full-ward admission throws `SQLException` with SQL state `45000` and leaves `occupied` unchanged.
