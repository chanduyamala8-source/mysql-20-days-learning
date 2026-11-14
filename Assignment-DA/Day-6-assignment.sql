CREATE TABLE Products (
 id INT,
 name VARCHAR(100),
 price DECIMAL(10,2),
 qty INT
 );
drop table products;
INSERT INTO Products VALUES
 (1, 'Pen', 10.00, 100),
 (2, 'Notebook', 25.00, 50),
 (3, 'Pencil', 5.00, 200),
 (4, 'Eraser', 3.00, 300),
 (5, 'Marker', 15.00, 80),
 (6, 'Scale', 20.00, 150),
 (7, 'Sharpener', 8.00, 120),
 (8, 'Geometry Box', 120.00, 40),
 (9, 'Sketch Pen', 60.00, 75),
 (10, 'Crayons', 90.00, 55);
 
 select*from products;
 
 select name,price,(price+20)as add_20 from products;
 select name,qty,(qty/2) as half_qty from products;
 select name,qty,(qty*2) as double_qty from products;
 select name,qty,(qty-10) as 10_units_sold from products;
select name,price,(price/5)as each_person_price from products;
select name,price from products where price%2=0;
select name,qty from products where qty%5=0;
select name,price,(price*0.9) as 10discount_price from products;
select name,price,(price+15)*1.18 from products;
select name,qty,(qty/2) as reamin_stock from products;

-- update queries
set sql_safe_updates=0;
select*from products;
update products set qty=qty+50 where name='pen';
update products set qty=qty-25 where name='pencil';
update products set price=price*1.1 where name='scale';
update products set qty=qty*2 where name='sharpener';
update products set price=price-15 where name='Crayons';

-- delete queries
delete from products where price<10;
delete from products where name='Marker';
delete from products where qty>300;
delete from products where price>100;

-- relational operators
CREATE TABLE StudentScores (
 id INT,
 name VARCHAR(100),
 subject VARCHAR(50),
 marks INT
 );

drop table studentscores;
INSERT INTO StudentScores VALUES
 (1, 'Alice', 'Math', 95),
 (2, 'Bob', 'Math', 76),
 (3, 'Charlie', 'Math', 59),
 (4, 'Diana', 'Math', 88),
 (5, 'Eve', 'Math', 40),
 (6, 'Frank', 'Math', 95),
 (7, 'Grace', 'Science', 67),
 (8, 'Henry', 'Science', 82),
 (9, 'Ivy', 'English', 91),
 (10, 'Jack', 'English', 55),
 (11, 'Kevin', 'Math', 73),
 (12, 'Lily', 'Science', 48),
 (13, 'Mia', 'English', 100),
 (14, 'Noah', 'Math', 64),
 (15, 'Olivia', 'Science', 79);
select*from studentscores;
-- select queries
select*from studentscores where marks<=60;
select*from studentscores where marks>70;
select*from studentscores where marks<=75;
select*from studentscores where marks=100;
select*from studentscores where marks!=40;
select*from studentscores where marks>=90;
select*from studentscores where marks<65;

-- update queries
select*from studentscores;
update studentscores set marks=100 where marks=95;
update studentscores set marks=marks+15 where marks<60;
update studentscores set marks=marks+5 where marks>75;
update studentscores set marks=marks-3 where marks>95;
update studentscores set marks=75 where marks<50;
update studentscores set marks=marks+8 where marks=64;
update studentscores set marks=marks-5 where marks=100;

-- update queries 
delete from studentscores where marks=76;
delete from studentscores where marks=100;
delete from studentscores where marks<65;
delete from studentscores where marks>=90;
delete from studentscores where marks=73;
delete from studentscores where marks=73;
delete from studentscores where marks between 70 and 80;
delete from studentscores where marks>=70 and marks<=80;

-- logical operators

CREATE TABLE Employees (
 id INT,
 name VARCHAR(100),
 department VARCHAR(100),
 salary INT,
 isactive BOOLEAN
 );
drop table employees;
INSERT INTO Employees VALUES
 (1, 'Rahul Sharma', 'IT', 50000, TRUE),
 (2, 'Priya Reddy', 'HR', 30000, TRUE),
 (3, 'Amit Kumar', 'Finance', 45000, FALSE),
 (4, 'Sneha Patel', 'IT', 35000, TRUE),
 (5, 'Vikram Singh', 'Finance', 28000, TRUE),
 (6, 'Anjali Mehta', 'HR', 32000, FALSE),
 (7, 'Kiran Rao', 'IT', 60000, TRUE),
 (8, 'Pooja Verma', 'Marketing', 27000, TRUE),
 (9, 'Ramesh Naidu', 'Sales', 38000, TRUE),
 (10, 'Deepika Joshi', 'Finance', 52000, TRUE),
 (11, 'Suresh Babu', 'Marketing', 29000, FALSE),
 (12, 'Neha Kapoor', 'HR', 41000, TRUE),
 (13, 'Arjun Reddy', 'IT', 55000, FALSE),
 (14, 'Lakshmi Devi', 'Sales', 33000, TRUE),
 (15, 'Nikhil Jain', 'IT', 47000, TRUE);
 select*from employees;
select*from employees where isactive=false or salary<30000;
select*from employees where department='marketing' and salary>25000;
select*from employees where not department='finance';
select*from employees where isactive=true and  salary>50000;
select*from employees where department='sales' or department='hr';
select*from employees where isactive=false or department='it';
select*from employees where salary<40000 and isactive=true;

-- update queries 
select*from employees;
update employees set isactive=true where department='marketing' and isactive=false;
update employees set salary=salary-2000 where isactive=false;
update employees set salary=salary*1.15 where isactive=true and salary>50000;
update employees set isactive=true where department='finance';
update employees set salary=salary+1000 where department='it' or department='sales';

-- delete queries 
delete from employees where department='sales' or isactive=false;
delete from employees where isactive=true and salary>55000;
delete from employees where department not in ('it','hr');
delete from employees where salary<30000 and isactive=false;
delete from employees where department='marketing' or salary>50000;