use da8;
show tables;
desc employees;

insert into employees(empid,first_name,lname,age,doj,address,dept)
value
('emp01','malli','arjun',27,'2021-03-10','hyd','it'),
('emp02','mahesh','babu',28,'2026-03-10','vsp''it'),
('emp03','umesh','kumar',30,'2026-03-10','vsp','it');

select*from employees;

insert into employees(empid,first_name,lname,age,doj,address,dept)
value
('emp02','mahesh','babu',28,'2024-03-20','mumbai','sales'),
('emp03','umesh','kumar',23,'2026-03-10','vsp','it');

insert into employees values
('emp04','sunny','varma',54,'2000-12-12','noida','marketing'),
('emp05','charani','cherry',22,'2026-06-10','vsp','it'),
('emp06','chandu','yamala',22,'2026-05-11','vsp','it');

insert into employees (empid,first_name,age,address,dept)
value
('emp07','bunny',17,'bng','hr');
insert into employees(empid,lname,age,doj,address,dept)
value
('emp08','abhi',20,'2026-02-03','vsp','it');

insert into employees(empid,lname,age,doj,address)
value
('emp09','jessy',22,'2026-02-03','vsp');

insert into employees set
empid='emp10',first_name='sai',lname='vardan',age=25,doj='2024-03-18',address='hyd',dept='qa';

set sql_safe_updates=0;
select*from employees;

update employees set age=22 where empid='emp01';

select*from employees;
select*from employees where empid='emp01';

update employees set lname='varma' where dept='hr';

update employees set doj='2026-10-25' where first_name='bunny';

update employees set dept='sales' where lname='jessy';
update employees set age=20 where first_name='bala';

update employees set first_name='bala' where age=20;

delete from employees where first_name='sunny';

delete from employees where dept='sales';
select*from employees;
create database assignment;
