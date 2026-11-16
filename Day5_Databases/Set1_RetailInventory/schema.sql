-- Retail Inventory Management - Schema (MySQL 8.4, InnoDB)
DROP DATABASE IF EXISTS retail_inventory;
CREATE DATABASE retail_inventory;
USE retail_inventory;

CREATE TABLE suppliers (
    supplier_id   INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    supplier_phone VARCHAR(20) NOT NULL,
    CONSTRAINT uq_supplier_name_phone UNIQUE (supplier_name, supplier_phone)
) ENGINE=InnoDB;

CREATE TABLE categories (
    category_id   INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(60) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE warehouses (
    warehouse_id   INT AUTO_INCREMENT PRIMARY KEY,
    warehouse_name VARCHAR(60) NOT NULL UNIQUE,
    location       VARCHAR(120) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE products (
    sku          VARCHAR(20) PRIMARY KEY,
    product_name VARCHAR(120) NOT NULL,
    category_id  INT NOT NULL,
    supplier_id  INT NOT NULL,
    reorder_level INT NOT NULL DEFAULT 10,
    CONSTRAINT chk_reorder_nonneg CHECK (reorder_level >= 0),
    CONSTRAINT fk_product_category FOREIGN KEY (category_id)
        REFERENCES categories(category_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_product_supplier FOREIGN KEY (supplier_id)
        REFERENCES suppliers(supplier_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    sku          VARCHAR(20) NOT NULL,
    warehouse_id INT NOT NULL,
    quantity     INT NOT NULL DEFAULT 0,
    CONSTRAINT chk_quantity_nonneg CHECK (quantity >= 0),
    CONSTRAINT uq_inventory_sku_wh UNIQUE (sku, warehouse_id),
    CONSTRAINT fk_inventory_product FOREIGN KEY (sku)
        REFERENCES products(sku)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_inventory_warehouse FOREIGN KEY (warehouse_id)
        REFERENCES warehouses(warehouse_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;
