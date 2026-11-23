DROP DATABASE IF EXISTS day8_retail_reservation;
CREATE DATABASE day8_retail_reservation;
USE day8_retail_reservation;

CREATE TABLE categories (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(80) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE products (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    category_id BIGINT NOT NULL,
    qty_in_stock INT NOT NULL DEFAULT 0,
    unit_price DECIMAL(10,2) NOT NULL,
    CONSTRAINT chk_product_stock_nonnegative CHECK (qty_in_stock >= 0),
    CONSTRAINT chk_product_price_positive CHECK (unit_price > 0.00),
    CONSTRAINT fk_product_category FOREIGN KEY (category_id) REFERENCES categories(id)
) ENGINE=InnoDB;

CREATE TABLE orders (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_no VARCHAR(30) NOT NULL UNIQUE,
    order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status ENUM('PENDING', 'CONFIRMED', 'CANCELLED') NOT NULL DEFAULT 'PENDING',
    total_amount DECIMAL(12,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB;

CREATE TABLE order_lines (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    qty INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    CONSTRAINT chk_line_qty_positive CHECK (qty > 0),
    CONSTRAINT fk_line_order FOREIGN KEY (order_id) REFERENCES orders(id),
    CONSTRAINT fk_line_product FOREIGN KEY (product_id) REFERENCES products(id)
) ENGINE=InnoDB;

CREATE TABLE monthly_sales (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    product_id BIGINT NOT NULL,
    sales_month DATE NOT NULL,
    units_sold INT NOT NULL,
    revenue DECIMAL(12,2) NOT NULL,
    CONSTRAINT uq_product_month UNIQUE (product_id, sales_month),
    CONSTRAINT fk_sales_product FOREIGN KEY (product_id) REFERENCES products(id)
) ENGINE=InnoDB;
