CREATE TABLE employee (
    emp_id     NUMBER PRIMARY KEY,
    emp_name   VARCHAR2(50),
    salary     NUMBER
);

INSERT INTO employee VALUES (1, 'Ali', 50000);
INSERT INTO employee VALUES (2, 'Sara', 60000);
INSERT INTO employee VALUES (3, 'Abbas', 70000);
INSERT INTO employee VALUES (4, 'Sakina', 75000);
INSERT INTO employee VALUES (5, 'Hussain', 65000);

COMMIT;

-- Step 1: Increase salary of emp 1
UPDATE employee SET salary = salary + 5000 WHERE emp_id = 1;

-- Step 2: Savepoint A
SAVEPOINT A;

-- Step 3: Increase salary of emp 2
UPDATE employee SET salary = salary + 7000 WHERE emp_id = 2;

-- Step 4: Savepoint B
SAVEPOINT B;

-- Step 5: Increase salary of emp 3
UPDATE employee SET salary = salary + 6000 WHERE emp_id = 3;

ROLLBACK TO A;

COMMIT;

SELECT * FROM employee;
