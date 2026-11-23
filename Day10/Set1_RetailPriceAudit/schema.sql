DROP DATABASE IF EXISTS day10_retail_price_audit;
CREATE DATABASE day10_retail_price_audit;
USE day10_retail_price_audit;

CREATE TABLE product_price (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(120) NOT NULL,
    cost_price DECIMAL(10,2) NOT NULL,
    selling_price DECIMAL(10,2) NOT NULL,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT chk_cost_positive CHECK (cost_price > 0.00),
    CONSTRAINT chk_selling_positive CHECK (selling_price > 0.00)
) ENGINE=InnoDB;

CREATE TABLE price_audit (
    audit_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    product_id BIGINT NOT NULL,
    product_name VARCHAR(120) NOT NULL,
    old_price DECIMAL(10,2) NOT NULL,
    new_price DECIMAL(10,2) NOT NULL,
    changed_by VARCHAR(100) NOT NULL,
    changed_at DATETIME NOT NULL,
    CONSTRAINT fk_price_audit_product FOREIGN KEY (product_id) REFERENCES product_price(id)
) ENGINE=InnoDB;
