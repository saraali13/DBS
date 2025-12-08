CREATE TABLE fees (
    student_id     NUMBER PRIMARY KEY,
    name           VARCHAR2(40),
    amount_paid    NUMBER,
    total_fee      NUMBER
);

INSERT INTO fees VALUES (1, 'Ali', 10000, 50000);
INSERT INTO fees VALUES (2, 'Sara', 12000, 50000);
INSERT INTO fees VALUES (3, 'Abbas', 15000, 50000);

COMMIT;

-- Step 1: Update student 1 payment
UPDATE fees
SET amount_paid = amount_paid + 5000
WHERE student_id = 1;

-- Step 2: Savepoint
SAVEPOINT halfway;

-- Step 3: Update student 2 payment
UPDATE fees
SET amount_paid = amount_paid + 8000
WHERE student_id = 2;

-- Step 4: ERROR → rollback
ROLLBACK TO halfway;

-- Step 5: commit correct work
COMMIT;

SELECT  * FROM fees;
