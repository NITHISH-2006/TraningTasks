# Normalisation - Bank Branch Accounts (Set 2)

## Original de-normalised sheet
`(customer, address, account number, account type, branch, relationship manager, balance)`

## Anomalies
- **Insert:** Cannot add branch/RM without an account; cannot add a new customer until an account is opened.
- **Update:** Customer address or RM/branch details repeated per account; changes require multi-row updates and risk inconsistency.
- **Delete:** Closing the only account may lose customer or RM/branch information.

## Keys and dependencies
- **Candidate keys:** `account_number` (business unique), `account_id` (surrogate). Customer may have multiple accounts; RM assigned per branch context.
- `account_number -> customer, branch, account_type, balance, opened_date`
- `customer_id -> full_name, address, phone, rm_id`
- `rm_id -> rm_name, branch_id`
- `branch_id -> branch_name, city`
- **Composite/relationship keys:** an account is identified by `account_number` (or `account_id`) and relates customer to branch (M:1 each). No single composite natural key required once surrogate/business keys defined.

## 3NF/BCNF decomposition
1. **1NF:** Atomic attributes, one row per account fact; identify determinants.
2. **2NF:** Separate entities so non-key attributes depend on whole keys.
3. **3NF/BCNF:** Remove transitive dependencies: `branches`, `relationship_managers` (depends on branch), `customers` (may reference RM), `accounts` (depends on account key, references customer and branch). Every determinant is a candidate key in its table (BCNF satisfied for this design).

## Final tables
- `branches(branch_id PK, branch_name UNIQUE, city)`
- `relationship_managers(rm_id PK, rm_name, branch_id FK)`
- `customers(customer_id PK, full_name, address, phone, rm_id FK NULL)`
- `accounts(account_id PK, account_number UNIQUE, customer_id FK, branch_id FK, account_type, balance, opened_date)`
