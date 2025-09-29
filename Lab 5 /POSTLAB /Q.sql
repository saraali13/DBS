create user lab5 IDENTIFIED BY lab5;

CREATE TABLE department (
    dept_id     INT PRIMARY KEY,
    dept_name   VARCHAR(15)
);

CREATE TABLE employee (
    emp_id      INT PRIMARY KEY,
    emp_name    VARCHAR(15),
    salary      INT,
    hire_date   DATE,
    manager_id  INT,
    dept_id     INT,
    CONSTRAINT fk_manager FOREIGN KEY (manager_id) REFERENCES employee(emp_id),
    CONSTRAINT fk_emp_dept FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

CREATE TABLE project (
    project_id   INT PRIMARY KEY,
    project_name VARCHAR(15)
);

CREATE TABLE project_assignment (
    emp_id     INT,
    project_id INT,
    CONSTRAINT fk_proj_emp FOREIGN KEY (emp_id) REFERENCES employee(emp_id),
    CONSTRAINT fk_proj FOREIGN KEY (project_id) REFERENCES project(project_id)
);

CREATE TABLE student (
    student_id    INT PRIMARY KEY,
    student_name  VARCHAR(15),
    city          VARCHAR(10),
    gpa           NUMBER(3,2)
);

CREATE TABLE course (
    course_id    INT PRIMARY KEY,
    course_name  VARCHAR(10),
    dept_id      INT,
    teacher_id   INT
);

CREATE TABLE enrollment (
    student_id   INT,
    course_id    INT,
    CONSTRAINT fk_enroll_student FOREIGN KEY (student_id) REFERENCES student(student_id),
    CONSTRAINT fk_enroll_course FOREIGN KEY (course_id) REFERENCES course(course_id)
);

CREATE TABLE teacher (
    teacher_id   INT PRIMARY KEY,
    teacher_name VARCHAR(15),
    city         VARCHAR(10)
);

CREATE TABLE subject (
    subject_id   INT PRIMARY KEY,
    subject_name VARCHAR(10)
);

CREATE TABLE customer (
    customer_id   NUMBER PRIMARY KEY,
    customer_name VARCHAR2(50)
);

CREATE TABLE orders (
    order_id     INT PRIMARY KEY,
    customer_id  INT,
    order_date   DATE,
    CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);



-- Departments
INSERT INTO department VALUES (10, 'HR');
INSERT INTO department VALUES (20, 'IT');
INSERT INTO department VALUES (30, 'Finance');

-- Employees
INSERT INTO employee VALUES (1, 'Ali', 60000, DATE '2021-05-01', NULL, 20);
INSERT INTO employee VALUES (2, 'Sara', 40000, DATE '2022-01-15', 1, 20);
INSERT INTO employee VALUES (3, 'Abbas', 55000, DATE '2019-11-20', 1, 30);
INSERT INTO employee VALUES (4, 'Sakina', 70000, DATE '2020-07-10', NULL, 10);

-- Students
INSERT INTO student VALUES (1, 'Fatima', 'Lahore', 3.5);
INSERT INTO student VALUES (2, 'Haider', 'Karachi', 3.2);
INSERT INTO student VALUES (3, 'Ali Akber', 'Lahore', 3.8);

-- Teachers
INSERT INTO teacher VALUES (1, 'Sir Ali', 'Karachi');
INSERT INTO teacher VALUES (2, 'Miss Sania', 'Karachi');
INSERT INTO teacher VALUES (3, 'Miss Kinza', 'Lahore');


-- Courses
INSERT INTO course VALUES (1, 'DBS', 20, 1);
INSERT INTO course VALUES (2, 'AI ', 20, 2);

-- Enrollment
INSERT INTO enrollment VALUES (1, 2);
INSERT INTO enrollment VALUES (2, 2);
INSERT INTO enrollment VALUES (3, 1);

-- Projects
INSERT INTO project VALUES (1, 'ERP System');
INSERT INTO project_assignment VALUES (1, 1);
INSERT INTO project_assignment VALUES (2, 1);

-- Customers + Orders
INSERT INTO customer VALUES (1, 'Adeel');
INSERT INTO customer VALUES (2, 'Nida');
INSERT INTO orders VALUES (1, 2, SYSDATE);

INSERT INTO subject VALUES(1,'cal');
INSERT INTO subject VALUES(2,'krr');

--POST LAB--
SELECT s.STUDENT_NAME,t.TEACHER_NAME,s.CITY FROM STUDENT s JOIN TEACHER t ON s.CITY=t.CITY;
SELECT e.EMP_NAME AS employee,m.EMP_NAME AS manager FROM EMPLOYEE e LEFT JOIN employee m ON e.MANAGER_ID=m.EMP_ID;
SELECT e.EMP_NAME FROM EMPLOYEE e LEFT JOIN DEPARTMENT d ON e.DEPT_ID=d.DEPT_ID WHERE d.DEPT_ID IS NULL;
SELECT d.DEPT_NAME, AVG(e.SALARY) AS avg_salary FROM DEPARTMENT d JOIN EMPLOYEE e ON d.DEPT_ID=e.DEPT_ID GROUP BY d.DEPT_NAME HAVING AVG(e.SALARY)>50000;
SELECT e.EMP_NAME, e.SALARY, e.DEPT_ID FROM EMPLOYEE e WHERE e.SALARY>(SELECT AVG(em.SALARY) FROM EMPLOYEE em WHERE em.DEPT_ID=e.DEPT_ID);
SELECT d.DEPT_NAME FROM DEPARTMENT d JOIN EMPLOYEE e ON d.DEPT_ID=e.DEPT_ID GROUP BY d.DEPT_NAME HAVING MIN(e.SALARY)>=30000;
SELECT s.STUDENT_NAME,c.COURSE_NAME FROM STUDENT s JOIN ENROLLMENT e ON s.STUDENT_ID=e.STUDENT_ID JOIN COURSE c ON e.COURSE_ID=c.COURSE_ID WHERE s.CITY='Lahore';
SELECT e.EMP_NAME,m.EMP_NAME AS manager, d.DEPT_NAME, e.HIRE_DATE FROM EMPLOYEE e LEFT JOIN EMPLOYEE m ON e.MANAGER_ID= m.EMP_ID JOIN DEPARTMENT d ON e.DEPT_ID=d.DEPT_ID WHERE e.HIRE_DATE BETWEEN DATE'2020-01-01' AND DATE'2023-01-01';
SELECT s.STUDENT_NAME, c.COURSE_NAME FROM STUDENT s JOIN ENROLLMENT e ON s.STUDENT_ID=e.STUDENT_ID JOIN COURSE c ON e.COURSE_ID=c.COURSE_ID JOIN TEACHER t ON c.TEACHER_ID= T.TEACHER_ID WHERE t.TEACHER_NAME='Sir Ali';
SELECT e.EMP_NAME, m.EMP_NAME AS manager, e.DEPT_ID FROM EMPLOYEE e JOIN EMPLOYEE m ON e.MANAGER_ID=m.EMP_ID WHERE e.DEPT_ID=m.DEPT_ID;
