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

