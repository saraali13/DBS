CREATE TABLE bank_accounts (
    account_no   NUMBER PRIMARY KEY,
    holder_name  VARCHAR2(50),
    balance      NUMBER
);

INSERT INTO bank_accounts VALUES (101, 'Ali', 50000);
INSERT INTO bank_accounts VALUES (102, 'Sara', 30000);
INSERT INTO bank_accounts VALUES (103, 'Abbas', 20000);

COMMIT;

SELECT * FROM bank_accounts;

-- Deduct 5000 from account A (101)
UPDATE bank_accounts
SET balance = balance - 5000
WHERE account_no = 101;

-- Credit 5000 to account B (102)
UPDATE bank_accounts
SET balance = balance + 5000
WHERE account_no = 102;

-- Mistaken Update (C)
UPDATE bank_accounts
SET balance = balance + 999999  -- mistake
WHERE account_no = 103;

ROLLBACK;

SELECT * FROM bank_accounts;
