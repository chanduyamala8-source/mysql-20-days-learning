use da8;
show tables;
drop table employees;

use da8;

create table employees(
empid char(5),
fname varchar(50),
lname varchar(30),
age int,
doj date,
address tinytext,
dept varchar(20)
);

desc employees;

alter table employees modify fname varchar(30);

desc employees;
alter table employees modify lname varchar(50);

alter table employees add location tinytext;

alter table employees add pfid int after address;

alter table employees add company_name text first;
alter table employees change fname first_name varchar(40);

alter table employees drop column company_name;
alter table employees drop column pfid;
alter table employees drop column location;
alter table employees rename to codegnan_emp;

desc codegnan_emp;

alter table codegnan_emp rename to employees;

desc employees;
show tables;

create table company_staff(
emp_id int primary key,
age tinytext,
experience smallint,
gender char(1),
emp_name varchar(50),
address tinytext,
salary decimal(10,2),
department enum('hr','it','sales','finance','support'),
skills set('java','python','sql','excel','communication'),
joining_date date);

desc company_staff;

alter table company_staff add email varchar(100);

alter table company_staff add phone_number bigint;

alter table company_staff add bonus decimal(8,2) after salary;

alter table company_staff add status varchar(20) after department;

alter table company_staff add company_name varchar(50) first;

alter table company_staff add qualification varchar(50) after emp_name;

alter table company_staff modify emp_name varchar(100);

alter table company_staff modify salary decimal(12,2);

alter table company_staff rename column emp_name to employee_name;

alter table company_staff rename column joining_date to date_of_joining;

alter table company_staff drop column bonus;

alter table company_staff drop column phone_number;

alter table company_staff rename to staff_records;

desc staff_records;

alter table staff_records rename to company_staff;

desc company_staff;

alter table company_staff add last_updated date after skills;





