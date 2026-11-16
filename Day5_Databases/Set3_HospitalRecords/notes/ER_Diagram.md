# ER Diagram - Hospital Patient Records (Set 3)

```mermaid
erDiagram
    DEPARTMENTS ||--o{ DOCTORS : has
    PATIENTS ||--o{ VISITS : attends
    DOCTORS ||--o{ VISITS : conducts
    VISITS ||--|| BILLING : generates

    DEPARTMENTS {
        int department_id PK
        varchar dept_name UK
    }
    DOCTORS {
        int doctor_id PK
        varchar doctor_name
        int department_id FK
        varchar phone
    }
    PATIENTS {
        int patient_id PK
        varchar full_name
        varchar address
        varchar phone
        date dob
    }
    VISITS {
        int visit_id PK
        int patient_id FK
        int doctor_id FK
        date visit_date
        varchar diagnosis
        varchar prescription
    }
    BILLING {
        int bill_id PK
        int visit_id FK UK
        decimal bill_amount
        varchar bill_status
    }
```

- `visit_date` constrained to a valid range; `bill_amount >= 0`; `bill_status` defaults to `OPEN`.
- Each visit produces at most one billing record (1:1 via unique `visit_id`).
