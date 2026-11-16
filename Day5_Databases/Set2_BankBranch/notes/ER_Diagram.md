# ER Diagram - Bank Branch Accounts (Set 2)

```mermaid
erDiagram
    BRANCHES ||--o{ RELATIONSHIP_MANAGERS : employs
    BRANCHES ||--o{ ACCOUNTS : hosts
    RELATIONSHIP_MANAGERS ||--o{ CUSTOMERS : manages
    CUSTOMERS ||--o{ ACCOUNTS : owns

    BRANCHES {
        int branch_id PK
        varchar branch_name UK
        varchar city
    }
    RELATIONSHIP_MANAGERS {
        int rm_id PK
        varchar rm_name
        int branch_id FK
    }
    CUSTOMERS {
        int customer_id PK
        varchar full_name
        varchar address
        varchar phone
        int rm_id FK
    }
    ACCOUNTS {
        int account_id PK
        varchar account_number UK
        int customer_id FK
        int branch_id FK
        varchar account_type
        decimal balance
        date opened_date
    }
```

## Data type justification
- **`DECIMAL(14,2)` for `balance`:** Exact fixed-point arithmetic required for money; avoids binary floating-point rounding errors of `FLOAT/DOUBLE`.
- **`INT AUTO_INCREMENT` for surrogate keys:** Compact, efficient joins and stable identifiers.
- **`VARCHAR` for names/addresses/phone/account_number:** Variable-length text; account numbers kept as strings to preserve leading zeros/format if needed.
- **`DATE` for `opened_date`:** Stores calendar date without time/zone ambiguity for account opening.
- **`CHECK` constraints:** Enforce `balance >= 0` and allowed `account_type` values at the database layer.
