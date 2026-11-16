USE retail_inventory;

-- 1) Duplicate key (SKU already exists)
INSERT INTO products (sku, product_name, category_id, supplier_id, reorder_level)
VALUES ('SKU001','Duplicate Apple',1,1,10);

-- 2) Missing parent (supplier_id 999 does not exist)
INSERT INTO products (sku, product_name, category_id, supplier_id, reorder_level)
VALUES ('SKU999','Ghost Product',1,999,10);

-- 3) Negative quantity violates CHECK (quantity >= 0)
INSERT INTO inventory (sku, warehouse_id, quantity)
VALUES ('SKU001',2,-5);

-- 4) NULL in a mandatory column (product_name NOT NULL)
INSERT INTO products (sku, product_name, category_id, supplier_id, reorder_level)
VALUES ('SKU998', NULL, 1, 1, 10);
