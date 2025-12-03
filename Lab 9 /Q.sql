set SERVEROUTPUT on;

--3 phases of pl language: decalartion(var dec, optional),execution(mandatory),exception(optional)
DECLARE         -- (optional) variables
BEGIN           -- required, executable code
EXCEPTION       -- (optional) error handling
END;

declare--declaration of vars
sec_name varchar(20) := 'BS-AI';--:= is the assignment op
course_name varchar(20) := 'DB';

BEGIN--execution
DBMS_OUTPUT.PUT_LINE('Welcome' || sec_name || 'to the' || course_name);
End;
/ --to stop the execution

declare
a int := 10;
b int := 20;
c int;
f real;
begin
c:=a+b;
DBMS_OUTPUT.PUT_LINE('Value of c ' || c);
f:= 70.0/3.0;
DBMS_OUTPUT.PUT_LINE('Value of f ' || f);
end;
/
--nested begin and end
declare
--global vars
n1 number := 21;
n2 number := 22;
begin
DBMS_OUTPUT.PUT_LINE('outer var of n1 ' || n1);
DBMS_OUTPUT.PUT_LINE('outer var of n2 ' || n2);

declare
--local var
n3 int := 45;
n4 int := 12;
begin
DBMS_OUTPUT.PUT_LINE('inner var of n3 ' || n3);
DBMS_OUTPUT.PUT_LINE('inner var of n4 ' || n4);
end; --inner one
end; --puter one
/
  
declare
e_name varchar(20);
begin
select first_name into e_name from employees where employee_id=101;
DBMS_OUTPUT.PUT_LINE('Employee name is ' || e_name);
exception 
when 
no_data_found then
DBMS_OUTPUT.PUT_LINE('No Employee Found ');
end;
/
  
declare
e_name varchar(20);
begin
update employees set salary=salary*1.10 where DEPARTMENT_ID=(select department_id FROM departments where department_name='Administration');
DBMS_OUTPUT.PUT_LINE('salary updated...');
end;
/
  
declare 
e_id employees.employee_id%type;
e_name employees.first_name%type;-- assigns the type of var from the table(col mentioned)
d_name departments.department_name%type;
begin
select employee_id,first_name,department_name into e_id,e_name,d_name from employees inner join DEPARTMENTS on employees.DEPARTMENT_ID=DEPARTMENTS.DEPARTMENT_ID where employee_id=100;
DBMS_OUTPUT.PUT_LINE('emp id: '|| e_id);
DBMS_OUTPUT.PUT_LINE('emp name: '|| e_name);
DBMS_OUTPUT.PUT_LINE('dep name: '|| d_name);
end;
/



