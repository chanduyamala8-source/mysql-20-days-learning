
create database pfs8;

drop database pfs8;

create database da8;


show databases;

use da8;
create table employees(
empid char (5),
fname varchar(50),
lname varchar(30),
age int,
doj date,
address tinytext,
dept varchar(20)
);

desc employees;