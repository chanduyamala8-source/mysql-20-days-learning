use pfs8;

select e.emp_id,e.name,d.department_name
from employees e
left join departments d
on e.department_id=d.department_id;


select e.emp_id,e.name,p.project_name
from employees e
left join projects p
on e.emp_id=p.emp_id
where project_name is null;

select d.department_name,e.name
from departments d
left join employees e
on d.department_id=e.department_id;

select d.department_name,e.name
from departments d
left join employees e
on d.department_id=e.department_id
where department_name is null;

-- count employees per department.
select d.department_name,count(emp_id)as total_employees
from departments d
left join employees e
on d.department_id=e.department_id
group by d.department_name;

-- count 
select e.name,count(p.project_id)as total_projects
from employees e
left join projects p
on e.emp_id=p.emp_id
group by e.name;

select d.department_name,sum(e.salary)as toatl_salary
from departments d
left join employees e
on d.department_id=e.department_id
group by d.department_name;

select d.department_name,avg(e.salary)as toatl_salary
from departments d
left join employees e
on d.department_id=e.department_id
group by d.department_name;

select d.department_name,count(emp_id)as total_employees
from departments d
left join employees e
on d.department_id=e.department_id
group by d.department_name;

select d.department_name,count(emp_id)as total_employees
from departments d
left join employees e
on d.department_id=e.department_id
group by d.department_name
order by total_employees desc;

SELECT D.DEPARTMENT_NAME,AVG(E.SALARY)AS AVERAGE_SALARY
 FROM DEPARTMENTS D
 LEFT JOIN EMPLOYEES E
 ON D.DEPARTMENT_ID=E.DEPARTMENT_ID
 GROUP BY D.DEPARTMENT_NAME
 HAVING AVERAGE_SALARY>40000
 ORDER BY AVERAGE_SALARY DESC
 LIMIT 1;
