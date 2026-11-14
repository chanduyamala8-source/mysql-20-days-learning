use da8;
drop table orders;
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
 
 select*from orders;

-- Select Queries
select customer_name,total_amount from orders where total_amount between 2000 and 5000;
select * from orders where order_date between '2024-03-15' and '2024-04-15';
select * from orders where total_amount between 800 and 1800;
select * from orders where order_date between '2024-04-10' and '2024-05-10';
select * from orders where total_amount between 2500 and 5000;

-- Update Queries
set sql_safe_updates=0;
update orders set total_amount=total_amount-100 where order_date between '2024-03-15' and '2024-03-31';
update orders set total_amount=total_amount+750 where total_amount between 800 and 1500;
update orders set total_amount=total_amount-500 where total_amount between 3000 and 5000;
update orders set total_amount=total_amount+250 where order_date between '2024-04-20' and '2024-05-10';
update orders set total_amount=total_amount+100 where order_date between '2024-03-01' and '2024-05-31';

-- Delete Queries
delete from orders where total_amount between 1000 and 2000;
delete from orders where order_date between '2024-03-01' and '2024-03-05';
delete from orders where order_date between '2024-04-18' and '2024-05-08';
delete from orders where total_amount between 1800 and 3000;
delete from orders where order_date between '2024-03-25' and '2024-04-08';

select*from orders;

show tables;
drop table emp;

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
 
 -- Select Queries
select * from emp where name like '_a%';
select * from emp where name like '%es%';
select * from emp where name like '%n';
select * from emp where name like 'm%e%';
select * from emp where name like '___h';
select * from emp where name like 'a%';
select * from emp where name like '%an';
select * from emp where name like '%oh%';
select * from emp where name like '___';
select * from emp where name like 's%';

-- Update Queries
update emp set salary=salary+1500 where name like '_a%';
update emp set salary=salary+4000 where name like '%es%';
update emp set salary=salary+1000 where name like '%n';
update emp set salary=salary+5000 where name like 'm%e%';
update emp set salary=salary+2000 where name like '__';

-- Delete Queries
delete from emp where name like '_a%';
delete from emp where name like '%es%';
delete from emp where name like '%n';
delete from emp where name like 'm%e%';
delete from emp where name like '__';

drop table employees;

--Case Operator
=============
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
select*from employees;

-- Case Operator Queries
-- Example 3: Department Bonus
select emp_name,department,salary, 
case
when department='IT' then salary*0.2
when department='Finance' then salary*0.15
when department='HR' then salary*0.1
else salary*0.05
end as bonus_amount from employees;
-- Example 4: Voting Eligibility
select emp_name,age, 
case
when age>=18 then 'Eligible'
else 'Not Eligible'
end as Voitng_Eligibility from employees;

-- Example 5: Grade Employees
select emp_name,salary,
case
when salary>=80000 then 'Grade A'
when salary>=60000 then 'Grade B'
when salary>=50000 then 'Grade C'
else 'Grade D'
end as grade from employees;

-- Example 6: CASE in ORDER BY
select * from employees order by
case
when department='IT' then 0
else 1 end;
-- Example 7: CASE in UPDATE
select *,
case
when experience>=10 then salary+10000
when experience>=5 then salary+5000
else salary+2000
end as Improved_sal from employees;
 
 -- Example 8: CASE with Aggregate Function
select sum(case 
when department='IT' then salary
else 0 end) as total_it_salary
from employees;
