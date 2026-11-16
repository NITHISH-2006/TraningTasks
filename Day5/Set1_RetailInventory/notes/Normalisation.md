# Normalisation - Retail Inventory (Set 1)

## Original spreadsheet (un-normalised)
`(SKU, product name, category, supplier name, supplier phone, warehouse, quantity, reorder level)`

## Anomalies in original
- **Insert anomaly:** Cannot add a new supplier/category/warehouse without a product+stock row; cannot record a product until stocked.
- **Update anomaly:** Supplier phone or category name repeated across rows; changing a supplier phone requires updating every product row for that supplier, risking inconsistency.
- **Delete anomaly:** Removing the last stock row for a SKU can lose supplier/category/product master data if stored only in that row.

## Functional dependencies (inferred)
- `SKU -> product_name, category, supplier_name, supplier_phone, reorder_level`
- `supplier_name -> supplier_phone` (assumed single contact per supplier in source sheet)
- `(SKU, warehouse) -> quantity`
- `warehouse -> location` (if location implied) / treated as entity
- `category -> category_id/name`

## Decomposition to 3NF
1. **1NF:** Atomic columns, separate row per (SKU, warehouse) stock record; define keys.
2. **2NF:** Remove partial dependencies from composite stock key `(SKU, warehouse)` by separating `products` (keyed by SKU) and `inventory` (keyed by SKU, warehouse_id).
3. **3NF:** Remove transitive dependencies: move `category` to `categories`, `supplier_name/phone` to `suppliers`, `warehouse` to `warehouses`. Non-key attributes depend only on the key of their table.

## Final tables (3NF)
- `suppliers(supplier_id PK, supplier_name, supplier_phone, UNIQUE(name,phone))`
- `categories(category_id PK, category_name UNIQUE)`
- `warehouses(warehouse_id PK, warehouse_name UNIQUE, location)`
- `products(sku PK, product_name, category_id FK, supplier_id FK, reorder_level, CHECK reorder_level>=0)`
- `inventory(inventory_id PK, sku FK, warehouse_id FK, quantity, CHECK quantity>=0, UNIQUE(sku,warehouse_id))`
