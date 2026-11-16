USE retail_inventory;

INSERT INTO suppliers (supplier_name, supplier_phone) VALUES
('Fresh Farms Co', '9000000001'),
('Daily Dairy Ltd', '9000000002'),
('Grain House', '9000000003'),
('SnackWorld', '9000000004'),
('HomeCare Supplies', '9000000005'),
('Beverage Bros', '9000000006'),
('Spice Route', '9000000007'),
('BakeWell', '9000000008'),
('GreenLeaf Produce', '9000000009'),
('ElectroBasics', '9000000010');

INSERT INTO categories (category_name) VALUES
('Fruits'),('Dairy'),('Grains'),('Snacks'),('Household'),
('Beverages'),('Spices'),('Bakery'),('Vegetables'),('Electronics');

INSERT INTO warehouses (warehouse_name, location) VALUES
('WH-North','Delhi'),
('WH-South','Chennai'),
('WH-East','Kolkata'),
('WH-West','Mumbai'),
('WH-Central','Bhopal'),
('WH-NorthEast','Guwahati'),
('WH-Hyd','Hyderabad'),
('WH-Pune','Pune'),
('WH-Jaipur','Jaipur'),
('WH-Ahmedabad','Ahmedabad');

INSERT INTO products (sku, product_name, category_id, supplier_id, reorder_level) VALUES
('SKU001','Apple',1,1,20),
('SKU002','Milk 1L',2,2,30),
('SKU003','Basmati Rice 5kg',3,3,15),
('SKU004','Potato Chips',4,4,25),
('SKU005','Dish Soap',5,5,10),
('SKU006','Orange Juice',6,6,18),
('SKU007','Turmeric Powder',7,7,12),
('SKU008','Bread Loaf',8,8,40),
('SKU009','Spinach',9,9,20),
('SKU010','AA Batteries',10,10,50),
('SKU011','Banana',1,1,25),
('SKU012','Butter 200g',2,2,20);

INSERT INTO inventory (sku, warehouse_id, quantity) VALUES
('SKU001',1,100),('SKU002',1,80),('SKU003',2,60),('SKU004',2,120),
('SKU005',3,45),('SKU006',4,70),('SKU007',5,90),('SKU008',6,55),
('SKU009',7,40),('SKU010',8,200),('SKU011',9,75),('SKU012',10,65);
