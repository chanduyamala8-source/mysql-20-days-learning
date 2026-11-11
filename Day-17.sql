use pfs8;

creATE DATABASE companydb;

USE companydb;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    experience INT,
    city VARCHAR(50),
    age INT
);

INSERT INTO employees
VALUES
(101, 'Ravi', 'IT', 45000, 2, 'Hyderabad', 24),
(102, 'Kiran', 'HR', 40000, 3, 'Vijayawada', 27),
(103, 'Suresh', 'IT', 55000, 5, 'Hyderabad', 30),
(104, 'Anil', 'Sales', 35000, 1, 'Chennai', 23),
(105, 'Priya', 'Finance', 60000, 6, 'Bangalore', 32),
(106, 'Sneha', 'IT', 50000, 4, 'Vizag', 28),
(107, 'Rahul', 'HR', 42000, 2, 'Hyderabad', 25),
(108, 'Arjun', 'Sales', 38000, 3, 'Chennai', 26),
(109, 'Divya', 'Finance', 65000, 7, 'Bangalore', 34),
(110, 'Manoj', 'IT', 70000, 8, 'Hyderabad', 35);

SELECT*FROM EMPLOYEES;

delimiter //
create procedure getitemployees()
begin
     select*from employees where department='it';
     end //
delimiter ;
call getitemployees;

delimiter //
create procedure experience()
begin
     select*from employees where experience>5;
     end //
delimiter //
call experience;

delimiter //
create procedure getemployeesbydepartment(in dept varchar(20))
begin
select*from employees where department=dept;
end //
delimiter ;
call  getemployeesbydepartment('it');

delimiter //
create procedure getemployeesbysalary(in emp_salary decimal (10,2))
begin
select*from employees where salary>emp_salary;
end //
delimiter ;getemployeessalary
call getemployeesbysalary(50000);

set sql_safe_updates=0;
delimiter //
create procedure incrementbyexperience (in exp int,in sal decimal(10,2))
begin
update employees set salary=sal where experience>exp;
end //
delimiter ;
call incrementbyexperience(6,20000);

select*from employees;

delimiter //
create procedure getemployeesbsalary (in sal decimal(10,2),in sal_2 decimal(10,2))
begin
select*from employees where salary>sal and salary<sal_2;
end //
delimiter ;
call getemployeesbsalary(50000,80000);

delimiter //
create procedure totalemployees(out total int)
begin
select count(*) into total from employees;
end //
delimiter ;
call totalemployees(@T);
select @t;

delimiter //
create procedure totalitemployees(out itemp int)
begin
select count(*) into itemp from employees where department='it';
end //
delimiter ;
call totalitemployees(@it);
select@it;\

delimiter //
create procedure adbonus(in empid int,inout bonus decimal(10,2))
begin 
update employees set salary=salary-bonus where emp_id=empid;
select salary into bonus from employees where emp_id=empid;
end //
delimiter ;
set @b=5000;
call adbonus(101,@b);
select @b;

delimiter //
