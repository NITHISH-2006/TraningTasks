# ER Diagram - Retail Inventory (Set 1)

```mermaid
erDiagram
    SUPPLIERS ||--o{ PRODUCTS : supplies
    CATEGORIES ||--o{ PRODUCTS : categorizes
    PRODUCTS ||--o{ INVENTORY : stocked_as
    WAREHOUSES ||--o{ INVENTORY : stores

    SUPPLIERS {
        int supplier_id PK
        varchar supplier_name
        varchar supplier_phone
    }
    CATEGORIES {
        int category_id PK
        varchar category_name
    }
    WAREHOUSES {
        int warehouse_id PK
        varchar warehouse_name
        varchar location
    }
    PRODUCTS {
        varchar sku PK
        varchar product_name
        int category_id FK
        int supplier_id FK
        int reorder_level
    }
    INVENTORY {
        int inventory_id PK
        varchar sku FK
        int warehouse_id FK
        int quantity
    }
```

- **Cardinalities:** One supplier/category supplies/categorizes many products; one product can appear in many warehouse inventory rows; each inventory row belongs to one product and one warehouse.
- **Referential actions:** `ON DELETE RESTRICT` prevents removing referenced parents; `ON UPDATE CASCADE` propagates key changes.
