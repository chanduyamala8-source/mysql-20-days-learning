use da8;
drop table students;
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    course VARCHAR(50)
);

INSERT INTO Students VALUES
(101,'Rahul','Java Full Stack'),
(102,'Priya','Python Full Stack'),
(103,'Kiran','Data Science'),
(104,'Sneha','Java Full Stack'),
(105,'Ajay','Testing');
select*from students

select*from students;

CREATE TABLE Placed_Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    company_name VARCHAR(50)
);
INSERT INTO Placed_Students VALUES
(103,'Kiran','TCS'),
(104,'Sneha','Infosys'),
(105,'Ajay','Wipro'),
(106,'Pooja','Accenture'),
(107,'Ramesh','Capgemini');

select*from placed_students;

select student_name from students
union
select student_name from placed_students;

select student_name from students
union all
select student_name from placed_students;

select student_name from students
intersect
select student_name from placed_students;

select student_name from students
except
select student_name from placed_students

drop database da8;
create database pfs8;
use pfs8;

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    salary DECIMAL(10,2)
);
 
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);
 
 drop table departments;
 drop table project;
CREATE TABLE Projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100),
    emp_id INT
);
 
INSERT INTO Departments (department_id, department_name) VALUES
(1, 'Human Resources'), (2, 'Engineering'), (3, 'Marketing'), (4, 'Finance'), (5, 'Operations'),(6,'HR');
 
INSERT INTO Employees (emp_id, name, department_id, salary) VALUES
(101, 'Arjun', 1, 50000), (102, 'Bhavana', 2, 65000), (103, 'Charan', 2, 72000),
(104, 'Divya', 3, 45000), (105, 'Eswar', NULL, 40000), (106, 'Farhan', 4, 55000),
(107, 'Gowri', 2, 62000), (108, 'Harish', 5, 48000), (109, 'Ishita', NULL, 53000),
(110, 'Jagan', 3, 60000);
 
INSERT INTO Projects (project_id, project_name, emp_id) VALUES
(201, 'Website Redesign', 102), (202, 'Mobile Banking App', 103), (203, 'Marketing Campaign', 104),
(204, 'Payroll System', 106), (205, 'Backend Optimization', 107), (206, 'Cloud Migration', 102),
(207, 'Customer Analytics', 110), (208, 'Inventory System', NULL);

select*from Departments;
select*from Projects;
select*from employees;

-- inner joint
select e.emp_id,e.name,d.department_name
from employees e
inner join departments d
on e.department_id=d.department_id;

select e.emp_id,e.name,p.emp_id
from employees e
inner join projects p
on e.emp_id=p.emp_id;

select e.emp_id,e.name,p.project_name
from employees e
inner join projects p
on e.emp_id=p.emp_id;


