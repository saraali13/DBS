CREATE TABLE inventory (
    item_id    NUMBER PRIMARY KEY,
    item_name  VARCHAR2(50),
    quantity   NUMBER
);

INSERT INTO inventory VALUES (1, 'Keyboard', 50);
INSERT INTO inventory VALUES (2, 'Mouse', 80);
INSERT INTO inventory VALUES (3, 'Monitor', 30);
INSERT INTO inventory VALUES (4, 'USB', 100);

COMMIT;

-- Step 1: Reduce item 1 by 10
UPDATE inventory SET quantity = quantity - 10 WHERE item_id = 1;

-- Step 2: Savepoint
SAVEPOINT sp1;

-- Step 3: Reduce item 2 by 20
UPDATE inventory SET quantity = quantity - 20 WHERE item_id = 2;

-- Step 4: Savepoint
SAVEPOINT sp2;

-- Step 5: Reduce item 3 by 5
UPDATE inventory SET quantity = quantity - 5 WHERE item_id = 3;

ROLLBACK TO sp1;

COMMIT;

SELECT * FROM inventory;

