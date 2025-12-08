CREATE TABLE STUDENTS (
    student_id NUMBER PRIMARY KEY,
    student_name VARCHAR2(50),
    age NUMBER
);

CREATE TABLE EMPLOYEES (
    emp_id NUMBER PRIMARY KEY,
    name VARCHAR2(30),
    salary NUMBER
);

INSERT INTO EMPLOYEES VALUES (1, 'Sara', 50000);
INSERT INTO EMPLOYEES VALUES (2, 'Ali', 60000);

CREATE TABLE LOG_SALARY_AUDIT (
    log_id NUMBER PRIMARY KEY,
    emp_id NUMBER,
    old_salary NUMBER,
    new_salary NUMBER,
    updated_on DATE
);

CREATE TABLE PRODUCTS (
    product_id NUMBER PRIMARY KEY,
    name VARCHAR2(20),
    price NUMBER
);

CREATE TABLE COURSES (
    course_id NUMBER PRIMARY KEY,
    course_name VARCHAR2(30),
    created_by VARCHAR2(30),
    created_on DATE
);

CREATE TABLE EMP (
    emp_id NUMBER PRIMARY KEY,
    emp_name VARCHAR2(30),
    department_id NUMBER
);

CREATE TABLE SALES (
    sale_id NUMBER,
    amount NUMBER
);

CREATE TABLE SCHEMA_DDL_LOG (
    username VARCHAR2(30),
    ddl_operation VARCHAR2(20),
    object_name VARCHAR2(30),
    event_date DATE
);

CREATE TABLE ORDERS (
    order_id NUMBER PRIMARY KEY,
    order_status VARCHAR2(20),
    amount NUMBER
);

CREATE TABLE LOGIN_AUDIT (
    username VARCHAR2(30),
    login_time DATE
);


--Triggers

--1
CREATE OR REPLACE TRIGGER trg_uppercase_name
BEFORE INSERT ON STUDENTS
FOR EACH ROW
BEGIN
    :NEW.student_name := UPPER(:NEW.student_name);
END;
/
INSERT INTO STUDENTS VALUES (1, 'ali khan', 20);

--2
CREATE OR REPLACE TRIGGER trg_no_delete_weekend
BEFORE DELETE ON EMPLOYEES
BEGIN
    IF TO_CHAR(SYSDATE, 'DY') IN ('SAT','SUN') THEN
        RAISE_APPLICATION_ERROR(-20010, 
          'Cannot delete employees on weekends!');
    END IF;
END;
/

--3
CREATE OR REPLACE TRIGGER trg_salary_update_log
AFTER UPDATE OF salary ON EMPLOYEES
FOR EACH ROW
BEGIN
    INSERT INTO LOG_SALARY_AUDIT (emp_id, old_salary, new_salary, updated_on)
    VALUES (:OLD.emp_id, :OLD.salary, :NEW.salary, SYSDATE);
END;
/

--4
CREATE OR REPLACE TRIGGER trg_no_negative_price
BEFORE UPDATE OF price ON PRODUCTS
FOR EACH ROW
BEGIN
    IF :NEW.price < 0 THEN
        RAISE_APPLICATION_ERROR(-20020, 'Price cannot be negative!');
    END IF;
END;
/

--5
CREATE OR REPLACE TRIGGER trg_course_insert_info
BEFORE INSERT ON COURSES
FOR EACH ROW
BEGIN
    :NEW.created_by := USER;
    :NEW.created_on := SYSDATE;
END;
/

--6
CREATE OR REPLACE TRIGGER trg_default_dept
BEFORE INSERT ON EMP
FOR EACH ROW
BEGIN
    IF :NEW.department_id IS NULL THEN
        :NEW.department_id := 10;
    END IF;
END;
/

--7
CREATE OR REPLACE TRIGGER trg_sales_total
FOR INSERT ON SALES
COMPOUND TRIGGER

    before_total NUMBER := 0;
    after_total NUMBER := 0;

BEFORE STATEMENT IS
BEGIN
    SELECT NVL(SUM(amount),0) INTO before_total FROM SALES;
END BEFORE STATEMENT;

AFTER EACH ROW IS
BEGIN
    after_total := after_total + :NEW.amount;
END AFTER EACH ROW;

AFTER STATEMENT IS
BEGIN
    DBMS_OUTPUT.PUT_LINE(
        'Total before insert = ' || before_total ||
        ' | Inserted amount = ' || after_total ||
        ' | New total = ' || (before_total + after_total)
    );
END AFTER STATEMENT;

END trg_sales_total;
/

--8
CREATE OR REPLACE TRIGGER trg_schema_ddl
AFTER CREATE OR DROP ON SCHEMA
BEGIN
    INSERT INTO SCHEMA_DDL_LOG (username, ddl_operation, object_name, event_date)
    VALUES (SYS_CONTEXT('USERENV','SESSION_USER'),
            ORA_SYSEVENT,
            ORA_DICT_OBJ_NAME,
            SYSDATE);
END;
/

--9
CREATE OR REPLACE TRIGGER trg_no_update_shipped
BEFORE UPDATE ON ORDERS
FOR EACH ROW
BEGIN
    IF :OLD.order_status = 'SHIPPED' THEN
        RAISE_APPLICATION_ERROR(-20030, 
            'Cannot update shipped orders!');
    END IF;
END;
/

--10
CREATE OR REPLACE TRIGGER trg_logon_audit
AFTER LOGON ON DATABASE
BEGIN
    INSERT INTO LOGIN_AUDIT (username, login_time)
    VALUES (SYS_CONTEXT('USERENV','SESSION_USER'), SYSDATE);
END;
/
