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

alter table employee rename column emp_name to full_name;
alter table employee drop constraint check_salary;
insert into departments(dep_id,dep_name) values (3,'Management');
insert into employee(emp_id,full_name,salary,dep_id) values (1,'Ali Haider',5000,2);
alter table departments add constraint unique_dep_name unique(dep_name);
alter table employee drop column dep_id;
alter table employee add (dep_id int ,CONSTRAINT fk_emp_dept foreign key(dep_id) references departments(dep_id));
alter table employee add bonus number(6,2) default 1000;
alter table employee add (city varchar(10) default 'Karachi',age int constraint check_age check(age>18));
insert into employee(emp_id,full_name,salary,dep_id,bonus,city,age) values (4,'Ali Akber',70000,1,2359.12,'Lahore',22);
delete from employee where emp_id in (1,3);
alter table employee modify (full_name varchar(20),city varchar(20));
alter table employee add (email varchar(20), constraint unique_mail unique(email));
