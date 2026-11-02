use da8;
show tables;

create table student1(
SID int primary key,
Name varchar(50),
Email varchar(50) primary key);

-- multiple primary key can't be used like this.

create table student1(
SID int,
Name varchar(50),
Email varchar(50),
primary key(SID,Email));

-- This doesn't allow null in both SID and Email
-- But this considers both SID and Email of a record to be same in order to consider it duplicate

insert into student1 values
(101,'Gowtham','kgowtham@gmail.com'),
(102,'Poojitha','Pooji17@gmail.com');
select * from student1;

insert into student1 values
(101,'Nani','nani@codegnan');
insert into student1 values
(103,'Nani','nani@codegnan');
-- it only considers duplicate if both SID and Email are same.

insert into student1 values
(102,'Nani','Pooji17@gmail.com');
select * from student1;

-- Default is used to fill the left over values with default value instead of null.

create table customers(
Cust_id int primary key,
Cust_name varchar(50),
City varchar(30) default 'HYDERABAD');
insert into customers(CUst_id,Cust_name,City) values
(1,'Ramu','BANGLORE');
insert into customers(CUst_id,Cust_name) values
(2,'Krishna');
select* from customers;

-- check is used as a condition to limit the values in column.

create table student2(
SID int primary key,
SName varchar(30),
Marks int check(Marks between 35 and 100));
insert into student2 values
(1,'Sita',20);
insert into student2 values
(1,'Sita',56);
insert into student2 values
(2,'Radha',120);
insert into student2 values
(2,'Radha',95);
select * from student2;

-- Foreign key is used to link 2 or more tables together to access data.alter
-- In two tables Foreign key is written in Child table to connect with Parent table.
-- The record in Child table must be in Parent table else it will report error.

create table employee(
EMP_ID INT PRIMARY KEY,
EMP_NAME VARCHAR(30)
);
insert into employee values
(1,'Ravi'),
(2,'Kiran'),
(3,'Arjun');
select * from employee;

create table department(
DEPT_ID INT PRIMARY KEY,
DEPT_NAME VARCHAR(30),
EMP_ID INT,
FOREIGN KEY(EMP_ID) REFERENCES EMPLOYEE(EMP_ID));
insert into department values
(101,'HR',1),
(102,'IT',3);
select * from department;

insert into department values
(103,'Sales',5); -- ERROR. Because Child table only allows Parent table's EMP_ID.

update employee set EMP_ID=11 where EMP_ID=1; -- ERROR. Can't update as this record is involved in Child table.

update employee set EMP_ID=11 where EMP_ID=2;

drop table employee; -- ERROR. First Child table needs to be dropped.