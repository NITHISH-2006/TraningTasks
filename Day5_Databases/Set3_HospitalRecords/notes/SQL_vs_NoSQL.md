# SQL vs NoSQL - Hospital Patient Records (Set 3)

| Aspect | SQL (RDBMS, e.g. MySQL) | NoSQL (e.g. document store) |
|---|---|---|
| Structure | Fixed schema, normalized tables (Patient/Doctor/Department/Visit/Billing) with rows/columns | Flexible schema; documents (e.g. a visit embedding patient/doctor/billing) or key-value/column/wide-column models |
| Consistency | Strong ACID transactions; FK constraints enforce referential integrity | Often BASE/eventual consistency; some engines offer transactions but integrity typically enforced in application |
| Scalability | Traditionally vertical scaling; horizontal via sharding/replication with added complexity | Designed for horizontal scaling and distribution across nodes |
| Querying | SQL joins/aggregations across relations | API/query per model; joins often avoided/denormalized, aggregations vary by engine |
| Typical use | Structured clinical/admin records, billing accuracy, reporting, regulatory audit needs | High-volume/variable data (logs, device streams), rapid iteration, large-scale distributed access |
| Fit for this case | Good for consistent patient-visit-billing integrity and relational reporting | Possible if denormalized views needed for speed, but care needed for consistency of billing/records |
