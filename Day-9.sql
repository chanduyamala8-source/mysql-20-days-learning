CREATE TABLE Projects (
 id INT,
 name VARCHAR(100),
 assignedto VARCHAR(100),
 start DATE,
 end DATE
 );
use da8;
INSERT INTO Projects VALUES
 (1, 'Website Revamp', 'Alice', '2024-01-15', '2024-03-01'),
 (2, 'Mobile App', 'Bob', '2024-02-01', NULL),
 (3, 'Data Migration', NULL, NULL, NULL),
 (4, 'SEO Optimization', 'Eve', '2024-03-10', '2024-04-20'),
 (5, 'Cloud Migration', NULL, '2024-03-15', NULL),
 (6, 'ERP Development', 'John', '2024-04-01', NULL),
 (7, 'CRM Upgrade', NULL, NULL, NULL),
 (8, 'Inventory System', 'David', '2024-05-10', '2024-06-25'),
 (9, 'Online Portal', 'Sophia', '2024-06-15', NULL),
 (10, 'Security Audit', NULL, '2024-07-01', NULL),
 (11, 'AI Chatbot', 'James', NULL, NULL),
 (12, 'Payroll System', 'Emma', '2024-08-01', '2024-09-10'),
 (13, 'Hospital Management', NULL, NULL, NULL),
 (14, 'Student Portal', 'Michael', '2024-09-05', NULL),
 (15, 'Banking Application', NULL, '2024-10-01', NULL);
 
select*from projects;
select*from projects where assignedto is null;
select*from projects  where start is null;
select*from projects where end is not null;
select*from projects where assignedto is not null;

-- update queries
set sql_safe_updates=0;
update projects set assignedto='frank' where assignedto is null;
update projects set start='2026-10-30' where start is null;
update projects set name='completed' where end is not null;

-- delete queries
delete from projects where assignedto is null;
delete from projects where start is null;
delete from projects where end is not null;

use da8;

CREATE TABLE Orders (
 id INT,
 customer_name VARCHAR(100),
 order_date DATE,
 total_amount DECIMAL(10,2)
 );

INSERT INTO Orders VALUES
 (1, 'Alice', '2024-03-01', 1500.00),
 (2, 'Bob', '2024-03-05', 450.00),
 (3, 'Charlie', '2024-03-10', 2500.00),
 (4, 'Diana', '2024-03-15', 800.00),
 (5, 'Eve', '2024-03-20', 1200.00),
 (6, 'Frank', '2024-03-25', 3000.00),
 (7, 'Grace', '2024-04-02', 1800.00),
 (8, 'Henry', '2024-04-08', 950.00),
 (9, 'Ivy', '2024-04-12', 2750.00),
 (10, 'Jack', '2024-04-18', 650.00),
 (11, 'Kevin', '2024-04-22', 4200.00),
 (12, 'Lily', '2024-05-01', 1350.00),
 (13, 'Michael', '2024-05-08', 5000.00),
 (14, 'Nancy', '2024-05-15', 2250.00),
 (15, 'Oliver', '2024-05-25', 900.00);

SELECT*FROM ORDERS;
select*from orders where Order_date between '2024-03-03' and '2024-03-10';
select*from orders where Order_date between '2024-04-01' and '2024-04-30';
select*from orders where total_amount between 500 and 1500;
update orders set total_amount=total_amount+1000 where order_date between '2024-03-04' and '2024-03-20';
update orders set total_amount=total_amount-200 where total_amount between 1000 and 2000;
update orders set total_amount=total_amount+(total_amount*0.10) where total_amount between 2500 and 5000;
delete from orders where order_date between '2024-03-10' and '2024-03-20';
delete from orders where total_amount between 2500 and 5000;

CREATE TABLE Emp (
 id INT,
 name VARCHAR(100),
 dept VARCHAR(20),
 salary INT
 );


INSERT INTO Emp VALUES
 (1, 'Rahul', 'IT', 50000),
 (2, 'Ramesh', 'HR', 35000),
 (3, 'Karan', 'Finance', 45000),
 (4, 'Mahesh', 'Marketing', 40000),
 (5, 'Suresh', 'IT', 55000),
 (6, 'Arjun', 'Sales', 38000),
 (7, 'Manish', 'Admin', 42000),
 (8, 'Ganesh', 'Finance', 47000),
 (9, 'Naresh', 'HR', 39000),
 (10, 'Rohan', 'IT', 52000),
 (11, 'Mohan', 'Sales', 41000),
 (12, 'Kishan', 'Marketing', 43000),
 (13, 'Dinesh', 'Admin', 46000),
 (14, 'Rajesh', 'Finance', 51000),
 (15, 'Kiran', 'IT', 48000);

select*from emp;

select*from emp where dept in ('it','finance');
select*from emp where dept in ('hr','sales');
select*from emp where salary in (35000,42000,60000);
update emp set salary=salary+2000 where dept in ('hr','marketing');
update emp set salary=salary+5000 where salary in (35000,39000,43000);
update emp set salary=salary+1500 where dept in ('sales', 'admin');
delete from emp where dept in ('finance','marketing');
delete from emp where salary in (35000,39000,43000);
delete from emp where dept in ('hr');

-- case operator
drop table employees;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    salary DECIMAL(10,2),
    experience INT,
    age INT
);

INSERT INTO employees VALUES
(101,'Ravi','IT',65000,5,28),
(102,'Priya','HR',45000,2,24),
(103,'Amit','Finance',75000,8,35),
(104,'Sneha','IT',55000,3,27),
(105,'Rahul','Sales',40000,1,22),
(106,'Kiran','Finance',90000,12,40),
(107,'Anjali','HR',52000,4,29),
(108,'Suresh','Sales',68000,7,33);

SELECT*FROM EMPLOYEES;

select emp_name,salary,
case
when salary>=80000 then 'high salary'
when salary>=60000 then 'medium slary'
else 'low salary'
end as salary_category
from employees;

select emp_name,experience,
case
when experience>=10 then 'expert'
when experience>=5 then 'senior'
when experience>=2 then 'junior'
else 'fresher'
end as experience_candiate
from employees;
 -- like operators
select*from employees where emp_name like 'r%';
select*from employees where emp_name like 'a%i';
select*from employees where emp_name like '%a%';
select*from employees where emp_name like '____';
select*from employees where emp_name like '__h__';
