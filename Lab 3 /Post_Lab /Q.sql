create table departments(
dep_id int primary key,
dep_name varchar(15) not null
);

create table employee ( 
emp_id int primary key,
emp_name varchar(15) ,
salary int,
constraint check_salary check(salary > 20000),
dep_id int REFERENCES departments(dep_id)                  
);

select * from DEPARTMENTS;
select * from EMPLOYEE;


alter table employee add constraint unique_bonus unique(bonus) ;
insert into employee(emp_id,full_name,salary,dep_id,bonus,city,age,email) values (1,'Ali Haider',5000,2,234.3,'Karachi',20,'alihaider@gmail.com');
insert into employee(emp_id,full_name,salary,dep_id,bonus,city,age,email) values (5,'Sakina Hussain',7000,3,234.35,'Karachi',22,'sakinaa@gmail.com');
alter table employee add dob date;
alter table employee add constraint check_staffage check(dob <= TO_DATE('2006-09-06', 'YYYY-MM-DD'));
insert into employee(emp_id,full_name,salary,dep_id,bonus,city,age,email,dob) values (5,'Sakina Hussain',7000,3,234.35,'Karachi',22,'sakinaa@gmail.com',DATE'2006-09-07');
alter table employee drop constraint fk_emp_dept;
insert into employee(emp_id,full_name,salary,dep_id,bonus,city,age,email,dob) values (6,'Ali Abbas',34000,4,234.31,'Karachi',22,'abbas@gmail.com',DATE'2006-09-03');
alter table employee drop column age;
alter table employee drop column city;
select dep_id,full_name from employee where dep_id IN(select dep_id from departments);
alter table employee rename column salary to monthly_salary;
select dep_id,dep_name from DEPARTMENTS where dep_id not in (select dep_id from employee);
TRUNCATE TABLE students;
select dep_id,count(*) as emp_count from employee group by dep_id having count(*)=(select max( count(*)) from employee group by dep_id);
