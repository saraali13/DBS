CREATE TABLE Department (
    Dep_ID INT PRIMARY KEY,
    Dep_Name VARCHAR(100) NOT NULL
);

CREATE TABLE Student (
    Std_ID INT PRIMARY KEY,
    Std_Name VARCHAR(100) NOT NULL,
    Dep_ID INT,
    GPA DECIMAL(3,2),
    Fee_Paid DECIMAL(12,2),
    FOREIGN KEY (Dep_ID) REFERENCES Department(Dep_ID)
);

CREATE TABLE Course (
    Course_ID INT PRIMARY KEY,
    Course_Name VARCHAR(100) NOT NULL,
    Dep_ID INT,
    FOREIGN KEY (Dep_ID) REFERENCES Department(Dep_ID)
);

CREATE TABLE Enrollment (
    Std_ID INT,
    Course_ID INT,
    PRIMARY KEY (Std_ID, Course_ID),
    FOREIGN KEY (Std_ID) REFERENCES Student(Std_ID),
    FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
);

CREATE TABLE Faculty (
    Faculty_ID INT PRIMARY KEY,
    Faculty_Name VARCHAR(100) NOT NULL,
    Dep_ID INT,
    Salary DECIMAL(12,2),
    Joining_Date DATE,
    FOREIGN KEY (Dep_ID) REFERENCES Department(Dep_ID)
);

CREATE TABLE FacultyCourse (
    Faculty_ID INT,
    Course_ID INT,
    PRIMARY KEY (Faculty_ID, Course_ID),
    FOREIGN KEY (Faculty_ID) REFERENCES Faculty(Faculty_ID),
    FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
);

CREATE TABLE HighFee_Students (
    Student_ID INT PRIMARY KEY,
    Student_Name VARCHAR(100),
    Dept_ID INT,
    GPA DECIMAL(3,2),
    Fee_Paid DECIMAL(12,2)
);

CREATE TABLE Retired_Faculty (
    Faculty_ID INT PRIMARY KEY,
    Faculty_Name VARCHAR(100),
    Dep_ID INT,
    Salary DECIMAL(12,2),
    Joining_Date DATE
);

CREATE TABLE Unassigned_Faculty (
    Faculty_ID INT PRIMARY KEY,
    Faculty_Name VARCHAR(100),
    Dep_ID INT,
    Salary DECIMAL(12,2),
    Joining_Date DATE
);

INSERT INTO Department (Dep_ID, Dep_Name) VALUES(5, 'SE');
INSERT INTO Student (Std_ID, Std_Name, Dep_ID, GPA, Fee_Paid) VALUES(5, 'Haider', 1, 3.8, 550000);
INSERT INTO Course (Course_ID, Course_Name, Dep_ID) VALUES(11, 'TBW', 4);
SELECT * FROM STUDENT;
INSERT INTO Enrollment (STD_ID, Course_ID) VALUES (1, 2);
INSERT INTO Enrollment (STD_ID, Course_ID) VALUES (1, 4);
INSERT INTO Enrollment (STD_ID, Course_ID) VALUES (2, 2);
INSERT INTO Enrollment (STD_ID, Course_ID) VALUES (2, 4);
INSERT INTO Enrollment (STD_ID, Course_ID) VALUES (3, 6);
INSERT INTO Enrollment (STD_ID, Course_ID) VALUES (3, 7);
INSERT INTO Enrollment (STD_ID, Course_ID) VALUES (5, 6);
INSERT INTO Enrollment (STD_ID, Course_ID) VALUES (5, 7);

INSERT INTO Faculty (Faculty_ID, Faculty_Name, Dep_ID, Salary, Joining_Date)VALUES (8, 'MISS NAZIA', 4, 85000, TO_DATE('2018-10-22','YYYY-MM-DD'));

INSERT INTO FacultyCourse (Faculty_ID, Course_ID) VALUES (1, 2);  -- Dr. RAFI teaches KRR
INSERT INTO FacultyCourse (Faculty_ID, Course_ID) VALUES (2, 5);  -- SIR BILAL teaches CV
INSERT INTO FacultyCourse (Faculty_ID, Course_ID) VALUES (3, 1);  -- MISS SANIA teaches ML

INSERT INTO FacultyCourse (Faculty_ID, Course_ID) VALUES (4, 6);  -- MISS KINZA teaches OOP
INSERT INTO FacultyCourse (Faculty_ID, Course_ID) VALUES (5, 7);  -- SIR RAHIM teaches FSE

INSERT INTO FacultyCourse (Faculty_ID, Course_ID) VALUES (6, 8);  -- SIR SHOAIB teaches DBS

INSERT INTO FacultyCourse (Faculty_ID, Course_ID) VALUES (7, 10);  -- Dr. KAMRAN teaches CAL
INSERT INTO FacultyCourse (Faculty_ID, Course_ID) VALUES (8, 11);  -- MISS NAZIA teaches TBW

-- IN LAB
SELECT d.Dep_Name, count(*) AS TOTAL_STUDENTS FROM DEPARTMENT d , Student s WHERE d.dep_id = s.dep_id group by d.DEP_NAME;
SELECT dep_name FROM department d WHERE (SELECT AVG(s.gpa) FROM student s WHERE s.dep_id = d.dep_id) >= 3.0;
SELECT co.Course_Name,AVG(s.Fee_Paid) AS avg_paidfees FROM Course co , enrollment e, student s WHERE co.course_id = e.course_id AND e.STD_ID = s.STD_ID group by co.COURSE_NAME;
SELECT d.dep_name,count(f.faculty_id) as faculty_members from faculty f , department d WHERE f.dep_id = d.dep_id group by d.dep_name;
SELECT faculty_name FROM faculty WHERE salary > (SELECT AVG(salary) FROM faculty);
SELECT STD_NAME,GPA FROM student WHERE GPA > ANY(SELECT GPA FROM student s , department d WHERE d.dep_id = s.dep_id AND d.dep_name = 'CS');
SELECT * FROM (SELECT * FROM student ORDER BY GPA DESC) where ROWNUM <= 3;
SELECT s.STD_ID, s.STD_NAME FROM Student s WHERE s.STD_NAME != 'Ali' AND NOT EXISTS ((SELECT e1.Course_ID FROM Enrollment e1 , Student s1 where e1.STD_ID = s1.STD_ID AND s1.STD_NAME = 'Ali') MINUS (SELECT e2.Course_ID FROM Enrollment e2 WHERE e2.STD_ID = s.STD_ID));
SELECT d.dep_name, SUM(s.fee_paid) AS total_fees FROM department d , student s WHERE d.Dep_ID = s.Dep_ID group by d.dep_name;
SELECT co.course_name FROM course co , student s WHERE co.dep_id = s.dep_id AND s.gpa>3.5;
