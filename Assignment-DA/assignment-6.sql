CREATE TABLE EMPLOYEES (
    EMP_ID INT PRIMARY KEY,
    FIRST_NAME VARCHAR(30),
    LAST_NAME VARCHAR(30),
    EMAIL VARCHAR(60),
    PHONE_NUMBER VARCHAR(20),
    DEPARTMENT VARCHAR(30),
    CITY VARCHAR(30),
    SALARY DECIMAL(10,2)
);
use pfs8;
INSERT INTO EMPLOYEES VALUES
(101,'Rahul','Kumar','rahul.kumar@gmail.com','987-654-3210','IT','Hyderabad',45000),
(102,'Anita','Sharma','anita.sharma@yahoo.com','912-345-6789','HR','Bangalore',38000),
(103,'Suresh','Verma','suresh.verma@gmail.com','998-123-4567','Sales','Chennai',52000),
(104,'Priya','Singh','priya.singh@outlook.com','900-456-7890','Finance','Pune',47000),
(105,'Rahul','Joshi','rahul.joshi@gmail.com','955-888-1111','Testing','Delhi',41000),
(106,'Kiran','Reddy','kiran.reddy@gmail.com','901-222-3333','IT','Hyderabad',56000),
(107,'Deepika','Naidu','deepika.naidu@yahoo.com','944-111-2222','HR','Vizag',39000),
(108,'Mahesh','Patel','mahesh.patel@gmail.com','933-444-5555','Sales','Mumbai',62000),
(109,'Divya','Gupta','divya.gupta@gmail.com','955-777-8888','Finance','Delhi',49000),
(110,'Arjun','Rao','arjun.rao@gmail.com','988-999-7777','Developer','Hyderabad',68000);

SELECT*FROM EMPLOYEES;

-- Find employees whose first_name starts with 'R'.
SELECT *FROM employees WHERE first_name LIKE 'R%';

-- Find employees whose email contains 'yahoo'.
SELECT*FROM EMPLOYEES WHERE EMAIL LIKE '%YAHOO%'

-- Display full name along with department as a single string.
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME, ' - ', DEPARTMENT) AS EMPLOYEE_DETAILS FROM EMPLOYEES;

-- Find the length of every email address.
SELECT EMAIL, LENGTH(EMAIL) AS EMAIL_LENGTH FROM EMPLOYEES;

-- Find employees whose first_name has more than 5 characters.
SELECT*FROM EMPLOYEES WHERE LENGTH(FIRST_NAME)>5;

-- Replace 'gmail.com' with 'company.com' in email.
SELECT EMAIL,REPLACE(EMAIL,'GMAIL.COM','COMPANY.COM') AS UPDATED_EMAIL FROM EMPLOYEES;

-- Find the position of the '@' symbol in email.
SELECT POSITION('@' IN EMAIL)AS POSITION_OF_AT FROM EMPLOYEES;

-- Extract the username part of email (before '@') using SUBSTRING_INDEX().
SELECT EMAIL, SUBSTRING_INDEX(EMAIL, '@', 1) AS USERNAME FROM EMPLOYEES;

-- Extract the domain part of email (after '@') using SUBSTRING_INDEX().
SELECT EMAIL, SUBSTRING_INDEX(EMAIL, '@', -1) AS USERNAME FROM EMPLOYEES;


-- Find employees whose last_name ends with 'a'.
SELECT * FROM EMPLOYEES WHERE LAST_NAME LIKE '%a';

-- Display full name in uppercase for employees in the IT department.
SELECT UPPER(CONCAT(FIRST_NAME,' ',LAST_NAME))AS FULL_NAME FROM EMPLOYEES WHERE DEPARTMENT='IT';

-- Find first names that are duplicated among employees.
SELECT first_name, COUNT(*) AS TOTAL_COUNT FROM employees GROUP BY first_name HAVING COUNT(*) > 1;

-- Format phone numbers by removing all dashes.
SELECT PHONE_NUMBER, REPLACE(PHONE_NUMBER, '-', '') AS FORMATTED_NUMBER FROM EMPLOYEES;

-- Find employees whose first_name contains the letter 'i'.
SELECT * FROM employees WHERE first_name LIKE '%i%';

-- Sort employees by the length of their first_name.
SELECT FIRST_NAME, LENGTH(FIRST_NAME) AS NAME_LENGTH FROM EMPLOYEES ORDER BY NAME_LENGTH ASC;

-- Find employees whose city name has more than 6 characters.
SELECT*FROM EMPLOYEES WHERE LENGTH(CITY)>6;

-- Build a formatted string "Name - Department" for every employee.
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME, ' - ', DEPARTMENT) AS EMPLOYEE_DETAILS FROM EMPLOYEES;

-- Display the initials of each employee (first letter of first and last name).
SELECT FIRST_NAME, LAST_NAME, CONCAT(LEFT(FIRST_NAME, 1), LEFT(LAST_NAME, 1)) AS INITIALS FROM EMPLOYEES;

-- Remove leading and trailing spaces from employee names.
SELECT TRIM(FIRST_NAME) AS FIRST_NAME, TRIM(LAST_NAME) AS LAST_NAME FROM EMPLOYEES;

-- Display the first three characters of every employee's first_name.
SELECT FIRST_NAME, LEFT(FIRST_NAME, 3) AS FIRST_THREE_CHARACTERS FROM EMPLOYEES;

SHOW TABLES;
DROP TABLE EMPLOYEE_ATTENDANCE;
CREATE TABLE EMPLOYEE_ATTENDANCE
(
	EMP_ID INT PRIMARY KEY AUTO_INCREMENT,
	EMP_NAME VARCHAR(100),
	DEPARTMENT VARCHAR(50),
	JOINING_DATE DATE,
	BIRTH_DATE DATE,
	LOGIN_TIME DATETIME,
	LOGOUT_TIME DATETIME,
	SALARY DECIMAL(10,2)
);

INSERT INTO EMPLOYEE_ATTENDANCE
(EMP_ID, EMP_NAME, DEPARTMENT, JOINING_DATE, BIRTH_DATE, LOGIN_TIME, LOGOUT_TIME, SALARY)
VALUES
(101,'Rahul','IT','2021-06-15','1998-05-10','2024-11-20 09:05:10','2024-11-20 18:15:30',55000),
(102,'Sneha','HR','2020-03-21','1996-11-18','2024-11-21 08:55:20','2024-11-21 17:45:50',48000),
(103,'Arjun','Finance','2019-08-10','1994-07-30','2024-11-22 09:15:45','2024-11-22 18:35:20',62000),
(104,'Priya','IT','2022-01-05','2000-01-25','2024-11-23 09:00:00','2024-11-23 17:55:40',51000),
(105,'Kiran','Admin','2018-12-11','1992-09-15','2024-11-24 08:40:30','2024-11-24 17:30:00',45000),
(106,'Anjali','Testing','2023-04-17','1999-12-20','2024-11-25 09:12:10','2024-11-25 18:05:00',47000),
(107,'Vijay','IT','2021-09-14','1997-04-08','2024-11-26 09:08:15','2024-11-26 18:20:40',59000),
(108,'Divya','HR','2019-10-19','1995-06-11','2024-11-27 08:50:30','2024-11-27 17:42:15',50000),
(109,'Ramesh','Finance','2017-07-01','1991-08-14','2024-11-28 09:03:00','2024-11-28 18:12:00',70000),
(110,'Pooja','Testing','2022-05-09','2001-03-19','2024-11-29 09:18:50','2024-11-29 18:25:10',53000);

SELECT*FROM EMPLOYEE_ATTENDANCE;

-- Display only the date part from every employee's login time.
SELECT EMP_NAME, DATE(LOGIN_TIME) AS LOGIN_DATE FROM EMPLOYEE_ATTENDANCE;

-- Display only the time part from every employee's login time.
SELECT EMP_NAME, TIME(LOGIN_TIME) AS LOGIN_TIME FROM EMPLOYEE_ATTENDANCE;

-- Display employee names along with their joining year.
SELECT EMP_NAME, YEAR(JOINING_DATE) AS JOINING_YEAR FROM EMPLOYEE_ATTENDANCE;

-- Display employee names along with their birth month number.
SELECT EMP_NAME, MONTH(BIRTH_DATE) AS BIRTH_MONTH FROM EMPLOYEE_ATTENDANCE;

-- Display employee names and day of birth.
SELECT EMP_NAME, DAY(BIRTH_DATE) AS BIRTH_DAY FROM EMPLOYEE_ATTENDANCE;

-- Display the week number of every employee's joining date.
SELECT EMP_NAME, WEEK(JOINING_DATE) AS WEEK_NUMBER FROM EMPLOYEE_ATTENDANCE;

-- Display the weekday number of each employee's joining date.
SELECT EMP_NAME, WEEK(JOINING_DATE) AS WEEKDAY_NUMBER FROM EMPLOYEE_ATTENDANCE;

-- Add 30 days to every employee's joining date.
SELECT EMP_NAME, JOINING_DATE, DATE_ADD(JOINING_DATE, INTERVAL 30 DAY) AS NEW_DATE FROM EMPLOYEE_ATTENDANCE;

-- Subtract 15 days from every employee's joining date.
SELECT EMP_NAME, JOINING_DATE, DATE_SUB(JOINING_DATE, INTERVAL 15 DAY) AS NEW_DATE FROM EMPLOYEE_ATTENDANCE;

-- Find how many days each employee has worked from joining date until today.
SELECT EMP_NAME, JOINING_DATE, DATEDIFF(CURDATE(), JOINING_DATE) AS WORKED_DAYS FROM EMPLOYEE_ATTENDANCE;

-- Find the number of days between login time and logout time.
SELECT EMP_NAME, LOGIN_TIME, LOGOUT_TIME, DATEDIFF(LOGOUT_TIME, LOGIN_TIME) AS DAYS_DIFFERENCE FROM EMPLOYEE_ATTENDANCE;

-- Display the Unix timestamp of login_time.
SELECT EMP_NAME, UNIX_TIMESTAMP(LOGIN_TIME) AS UNIX_TIME FROM EMPLOYEE_ATTENDANCE;

-- Convert Unix timestamp 1700000000 into DateTime.
SELECT FROM_UNIXTIME(1700000000) AS CONVERTED_DATETIME;

-- Display the last day of each employee's joining month.
SELECT EMP_NAME, JOINING_DATE, LAST_DAY(JOINING_DATE) AS LAST_DATE_OF_MONTH FROM EMPLOYEE_ATTENDANCE;

-- Display the month name and day name of every employee's birth date.
SELECT EMP_NAME, BIRTH_DATE, MONTHNAME(BIRTH_DATE) AS BIRTH_MONTH, DAYNAME(BIRTH_DATE) AS BIRTH_DAY FROM EMPLOYEE_ATTENDANCE;


-- Display employees who joined in the current year.
SELECT *FROM employee_attendance WHERE YEAR(joining_date) = YEAR(CURDATE());

-- Display employees born in November.
SELECT * FROM employee_attendance WHERE MONTH(birth_date) = 11;

-- Display employees whose joining month is June.
SELECT * FROM employee_attendance WHERE MONTH(joining_date) = 6;

-- Display employees whose birthday falls on the 10th day.
SELECT * FROM employee_attendance WHERE DAY(birth_date) = 10;

-- Display employees who joined in Quarter 2.
SELECT * FROM employee_attendance WHERE QUARTER(joining_date) = 2;

-- Display employee names and their age in years using TIMESTAMPDIFF().
SELECT emp_name, birth_date, TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) AS AGE FROM employee_attendance;

-- Display employees who have completed more than 3 years in the company.
SELECT * FROM employee_attendance WHERE TIMESTAMPDIFF(YEAR, joining_date, CURDATE()) > 3;

-- Display employee names and their total working hours.
SELECT emp_name, login_time, logout_time, ROUND(TIMESTAMPDIFF(SECOND, login_time, logout_time) / 3600, 2) AS WORKING_HOURS FROM employee_attendance;

-- Display employee names and working minutes.
SELECT emp_name, login_time, logout_time, TIMESTAMPDIFF(MINUTE, login_time, logout_time) AS WORKING_MINUTES FROM employee_attendance;

-- Display employees whose login time is before 9 AM.
SELECT * FROM employee_attendance WHERE TIME(login_time) < '09:00:00';

-- Display employees who logged in after 9:10 AM.
SELECT * FROM employee_attendance WHERE TIME(login_time) > '09:10:00';

-- Display employees whose joining date falls on Monday.
SELECT * FROM employee_attendance WHERE DAYNAME(joining_date) = 'Monday';

-- Display employees whose birth month name starts with 'J'.
SELECT emp_name, birth_date, MONTHNAME(birth_date) AS BIRTH_MONTH FROM employee_attendance WHERE MONTHNAME(birth_date) LIKE 'J%';

-- Display employees who joined in Week Number 25.
SELECT * FROM employee_attendance WHERE WEEK(joining_date) = 25;

-- Display employee names and the last day of their birth month.
SELECT emp_name, birth_date, LAST_DAY(birth_date) AS LAST_DAY_OF_BIRTH_MONTH FROM employee_attendance;

-- Display employee names with joining date after adding one year.
SELECT emp_name, joining_date, DATE_ADD(joining_date, INTERVAL 1 YEAR) AS NEW_JOINING_DATE FROM employee_attendance;

-- Display employee names with joining date before subtracting two months.
SELECT emp_name, joining_date, DATE_SUB(joining_date, INTERVAL 2 MONTH) AS PREVIOUS_JOINING_DATE FROM employee_attendance;

-- Display employees who were born in the current year.
SELECT * FROM employee_attendance WHERE YEAR(birth_date) = YEAR(CURDATE());

-- Display employee names along with their joining date in the format DD-MM-YYYY.
SELECT emp_name, DATE_FORMAT(joining_date, '%d-%m-%Y') AS FORMATTED_JOINING_DATE FROM employee_attendance;

-- Display employee names along with their login date in the format DD-MONTH-YYYY.
SELECT emp_name,DATE_FORMAT(login_time, '%d-%M-%Y') AS FORMATTED_LOGIN_DATE FROM employee_attendance;