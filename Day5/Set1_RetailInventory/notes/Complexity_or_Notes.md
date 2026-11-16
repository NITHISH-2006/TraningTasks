# Notes - Set 1 Retail Inventory

## Referential actions
- `ON DELETE RESTRICT`: prevents deleting a supplier/category/warehouse/product while child rows exist (protects stock integrity).
- `ON UPDATE CASCADE`: propagates changes to referenced keys (e.g. SKU/category/supplier/warehouse id changes) to child rows.

## Constraints used
- `PRIMARY KEY` on all entities; surrogate keys for suppliers/categories/warehouses/inventory, natural key `sku` for products.
- `FOREIGN KEY` links products->suppliers/categories and inventory->products/warehouses.
- `UNIQUE` on category/warehouse names, supplier(name,phone), and (sku,warehouse_id) to avoid duplicate stock rows.
- `CHECK (quantity >= 0)` and `CHECK (reorder_level >= 0)` to prevent negative values.
- `DEFAULT` on quantity (0) and reorder_level (10); `NOT NULL` on mandatory attributes.

## Operations demonstrated
- Correct supplier phone via `UPDATE ... WHERE` and remove discontinued SKUs via `DELETE ... WHERE` with `SELECT` before/after (see `output/console_output.txt`).
- System DB exploration: queried `information_schema.tables` for schema tables, engine and row counts; referenced `mysql`, `performance_schema`, `sys`.
