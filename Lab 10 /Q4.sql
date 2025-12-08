CREATE TABLE product (
    product_id    NUMBER PRIMARY KEY,
    product_name  VARCHAR2(50),
    stock         NUMBER
);

CREATE TABLE orderr (
    order_id    NUMBER PRIMARY KEY,
    product_id  NUMBER,
    quantity    NUMBER
);

INSERT INTO product VALUES (1, 'Laptop', 20);
INSERT INTO product VALUES (2, 'Mouse', 100);
INSERT INTO product VALUES (3, 'Keyboard', 50);

COMMIT;

-- Step 1: Reduce stock
UPDATE product SET stock = stock - 2 WHERE product_id = 1;

-- Step 2: Insert order
INSERT INTO orderr VALUES (101, 1, 2);

-- Step 3: Mistaken delete
DELETE FROM product WHERE product_id = 2;

ROLLBACK;

UPDATE product SET stock = stock - 2 WHERE product_id = 1;

INSERT INTO orderr VALUES (101, 1, 2);

COMMIT;

SELECT * FROM product;
SELECT * FROM orderr;
