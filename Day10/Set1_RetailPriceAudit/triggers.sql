USE day10_retail_price_audit;

DELIMITER //

-- T1: AFTER UPDATE records OLD and NEW values. Triggers are row-level in MySQL.
DROP TRIGGER IF EXISTS trg_product_price_after_update //

CREATE TRIGGER trg_product_price_after_update
AFTER UPDATE ON product_price
FOR EACH ROW
BEGIN
    INSERT INTO price_audit
        (product_id, product_name, old_price, new_price, changed_by, changed_at)
    VALUES
        (NEW.id, NEW.product_name, OLD.selling_price, NEW.selling_price, USER(), NOW());
END //

-- T2: BEFORE UPDATE rejects a price below cost before the row is written.
DROP TRIGGER IF EXISTS trg_product_price_before_update //

CREATE TRIGGER trg_product_price_before_update
BEFORE UPDATE ON product_price
FOR EACH ROW
BEGIN
    IF NEW.selling_price < NEW.cost_price THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Selling price cannot be below cost price';
    END IF;
END //

DELIMITER ;
