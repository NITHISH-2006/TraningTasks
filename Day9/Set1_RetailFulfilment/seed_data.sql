USE day9_retail_fulfilment;

INSERT INTO suppliers (id, name, contact_email) VALUES
    (1, 'Northwind Supplies', 'sales@northwind.example'),
    (2, 'Delta Wholesale', 'orders@delta.example');

INSERT INTO products (id, name, sku, cost_price, unit_price, qty_in_stock, reorder_level, supplier_id) VALUES
    (1, 'Wireless Mouse',    'MOUSE-01',  450.00,  799.00, 50, 10, 1),
    (2, 'Mechanical Keyboard','KEYB-02', 1800.00, 2999.00,  8, 10, 1),
    (3, 'USB-C Hub',         'HUB-03',    700.00, 1299.00, 25, 10, 2),
    (4, 'Laptop Stand',      'STAND-04',  900.00, 1899.00,  6, 10, 2);

INSERT INTO customers (id, name, email) VALUES
    (1, 'Riya Kapoor', 'riya@example.com'),
    (2, 'Arjun Reddy', 'arjun@example.com');

INSERT INTO orders (id, order_no, customer_id, order_date, status, total_amount) VALUES
    (1, 'ORD-OLD-001', 1, '2026-11-10 09:00:00', 'PENDING',   1599.00),
    (2, 'ORD-OLD-002', 2, '2026-11-12 10:30:00', 'PENDING',   2999.00),
    (3, 'ORD-REC-003', 1, DATE_SUB(NOW(), INTERVAL 1 DAY), 'PROCESSING', 799.00);

INSERT INTO order_items (id, order_id, product_id, qty, unit_price) VALUES
    (1, 1, 3, 1, 1299.00),
    (2, 1, 1, 1,  300.00),
    (3, 2, 2, 1, 2999.00),
    (4, 3, 1, 1,  799.00);
