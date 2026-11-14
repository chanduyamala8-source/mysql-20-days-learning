create database assignments;
use assignments;
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    department VARCHAR(50),
    job_role VARCHAR(50),
    salary DECIMAL(10,2),
    joining_date DATE,
    city VARCHAR(50)
);
INSERT INTO employees
(emp_id, emp_name, department, job_role, salary, joining_date, city)
VALUES
(101, 'Ravi Kumar', 'IT', 'Developer', 45000, '2023-01-15', 'Vizag'),
(102, 'Priya Sharma', 'HR', 'HR Manager', 55000, '2022-06-20', 'Hyderabad'),
(103, 'Kiran Reddy', 'IT', 'Tester', 40000, '2023-03-10', 'Vizag'),
(104, 'Sneha Rao', 'Finance', 'Accountant', 48000, '2021-11-25', 'Chennai'),
(105, 'Arun Kumar', 'IT', 'Developer', 60000, '2020-08-18', 'Bangalore'),
(106, 'Divya Reddy', 'HR', 'Recruiter', 35000, '2024-01-05', 'Vizag'),
(107, 'Suresh Babu', 'Sales', 'Executive', 42000, '2022-09-12', 'Hyderabad'),
(108, 'Anjali Devi', 'IT', 'Developer', 70000, '2019-05-30', 'Chennai'),
(109, 'Mahesh Kumar', 'Sales', 'Manager', 65000, '2020-02-14', 'Bangalore'),
(110, 'Lakshmi Rao', 'Finance', 'Analyst', 52000, '2023-07-22', 'Hyderabad');

select*from employees;
update employees set salary=50000 where emp_name='Ravi Kumar';
set sql_safe_updates=0
update employees set salary=1.1* salary where department='it';
update employees set city='vizag' where emp_name='Priya Sharma';
update employees set job_role='senior tester' where emp_name='Kiran Reddy';
update employees set salary=5000+ salary where department='hr';
update employees set city='hyderabad' where city='vizag';
update employees set job_role='development' where emp_name='Arun Kumar';
update employees set salary=1.15* salary where salary<45000;
update employees set job_role='senior developer' where emp_name='Anjali Devi';
update employees set city='bangalore' where department='finance';

delete from employees where emp_id=106;
delete from employees where department='finance';
delete from employees where salary<40000;
delete from employees where city='vizag';
delete from employees where emp_name='Suresh Babu';
delete from employees where joining_date<'2020-01-01';
delete from employees where job_role='recruiters';
delete from employees where (department='Sales' and salary<50000);
delete from employees order by salary asc limit 1; 
delete from employees where city='chennai';


select*from employees;
select*from employees where department='it';
select*from employees where salary>50000;
select*from employees where (emp_name and salary);
select*from employees where city='vizag';
select*from employees where joining_date>'2022-01-01';
select*from employees where salary between 40000 and 60000;
select*from employees where emp_name like '%kumar';
select*from employees order by salary desc;
select*from employees order by salary desc limit 1;




