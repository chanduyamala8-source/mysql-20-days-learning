use da8;
show tables;
drop table products;
select*from products;

CREATE TABLE Products (
 id INT,
 name VARCHAR(100),
 price DECIMAL(10,2),
 qty INT
 );
 
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
 
 select*from products
 
 select name,price,price+(price*0.12)as price_with_tax from products;
 
 select name,price,(price-5)as discount_price from products;
 
 select name,price,qty,(price*qty)as total_inventory from products;

 select name,price,(price*10)as price_per_10 from products;
 
 select name,qty,qty%50!=0 as price_not_50 from products;
 
 set sql_safe_updates=0;
 update products set qty=qty+2;
 
 update products set price=price-5;
 update products set qty=qty*2 where name='eraser';
 update products set qty=qty/2 where name='marker';
 delete from products where qty<100;
 
  select*from products
  
  
  delete from products where price<10;
  
  update products set qty=qty/2;
  
  CREATE TABLE StudentScores (
 id INT,
 name VARCHAR(100),
 subject VARCHAR(50),
 marks INT
 );


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

select*from studentscores where marks>80;

select*from studentscores where marks>=60;

select*from studentscores where marks<50;

select*from studentscores where marks=95;

select*from studentscores where marks!=95;

select*from studentscores where marks<=60;

update studentscores set marks=marks+10 where marks<50;
select*from studentscores;
update studentscores set marks=marks+5 where marks<=60;
update studentscores set marks=marks+2 where marks>90;
update studentscores set marks=marks+3 where marks>=80;
update studentscores set marks=marks-1 where marks!=95;
update studentscores set marks=100 where marks=95;
select*from studentscores;
delete from studentscores where marks<50;
delete from studentscores where marks<=60;
delete from studentscores where marks>90;
delete from studentscores where marks>=80;
delete from studentscores where marks!=95;
delete from studentscores where marks=76;

select*from studentscores;

drop table employees;
CREATE TABLE Employees (
   id INT,
   name VARCHAR(100),
   department VARCHAR(100),
   salary INT,
   isactive BOOLEAN
);

insert into employees values
(1, 'Rahul Sharma', 'IT', 50000, TRUE),
(2, 'Priya Reddy', 'HR', 30000, TRUE),
(3, 'Amit Kumar', 'Finance', 45000, FALSE),
(4, 'Sneha Patel', 'IT', 35000, TRUE),
(5, 'Vikram Singh', 'Finance', 28000, TRUE),
(6, 'Anjali Mehta', 'HR', 32000, FALSE),
(7, 'Kiran Rao', 'IT', 60000, TRUE),
(8, 'Pooja Verma', 'Marketing', 27000, TRUE);

select*from employees;
select*from employees where department='it' and salary>40000;
select*from employees where department='hr' or salary<35000;
select*from employees where not department='hr'; 
select*from employees where not department='finance'or
(salary>30000 and isactive=1);

update employees set salary=salary+2000 where department='it'and isactive=true and salary<60000;
update employees set salary=salary-(salary*0.10) where department='finance' or isactive=false;



