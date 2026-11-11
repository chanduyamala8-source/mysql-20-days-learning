use pfs8;
show tables;
drop table students;

create table students(
sid int primary key,
sname varchar(30),
email varchar(30));

start transaction;
insert into students values
(111,'malli','malli@codegnan'),
(222,'arjun','arjun@codegnan'),
(333,'mahi','mahi@codegnan');
commit;
select*from students;

start transaction;
delete from students where sid=222;

rollback;


start transaction;
insert into students values (222,'arjun','arjun@codegnan'),
(444,'mani','mani@codegnan');

select*from students;
set sql_safe_updates=0;
update students set sname='mahesh' where sid=333;
select*from students;
savepoint sp1;
delete from students where sid=111;
rollback to sp1;
select*from students;

show tables;
drop table employees;
drop table departments;

CREATE TABLE departments (
	dept_id INT PRIMARY KEY AUTO_INCREMENT,
	dept_name VARCHAR(50),
	location VARCHAR(50)
);
 
CREATE TABLE employees (
	emp_id INT PRIMARY KEY AUTO_INCREMENT,
	emp_name VARCHAR(100),
	dept_id INT,
	designation VARCHAR(50),
	salary DECIMAL(10,2),
	join_date DATE,
	FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

INSERT INTO departments (dept_name, location) VALUES
('IT','Hyderabad'), ('HR','Bangalore'), ('Finance','Chennai'), ('Sales','Mumbai');
 
INSERT INTO employees (emp_name, dept_id, designation, salary, join_date) VALUES
('Rahul',1,'Software Engineer',55000,'2021-06-15'),
('Anita',2,'HR Executive',38000,'2020-03-21'),
('Suresh',4,'Sales Manager',52000,'2019-08-10'),
('Priya',1,'Team Lead',65000,'2022-01-05'),
('Kiran',3,'Finance Analyst',48000,'2018-12-11'),
('Deepika',2,'HR Manager',60000,'2019-10-19');
select*from departments;
select*from employees;

create view vw_employee_department as
select e.emp_id,e.emp_name,e.designation,d.dept_name,d.location
from employees e
join departments d
on e.dept_id=d.dept_id;

select*from vw_employee_department;

create view vw_department_salary as
select d.dept_name,
count(e.emp_id) as total_employees,
sum(e.salary) as total_salary,
avg(e.salary) as Average_salary
from employee e join department d
on e.dept_id=d.dept_id
group by dept_name;

select*from vw_department_salary_summary;

create view vm_employees_anual_salary as
select emp_name,salary as monthly_salary,salary*12 as anual_salary from employees;
select*from vm_employees_anual_salary;

