create database students;
use students;
drop database students;
CREATE DATABASE studentdb;
USE studentdb;
-- ---------- Strong Entity: STUDENTS ----------
CREATE TABLE Students (
student_id INT PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
enrollment_year INT
);

-- ---------- Strong Entity: SUBJECTS ----------
CREATE TABLE Subjects (
subject_id INT PRIMARY KEY,
subject_name VARCHAR(50)
);
-- ---------- Strong Entity: EXAMS ----------
CREATE TABLE Exams (
exam_id INT PRIMARY KEY,
exam_name VARCHAR(50),
exam_date DATE
);

-- ---------- Associative Entity: MARKS ----------
-- Resolves the natural many-to-many-to-many relationship between
-- STUDENTS, SUBJECTS and EXAMS. It has its own surrogate key (mark_id),
-- so it is a strong/associative entity, not a weak entity -- but every
-- row is meaningless without its three foreign keys.
CREATE TABLE Marks (
mark_id INT PRIMARY KEY,
student_id INT,
subject_id INT,
exam_id INT,
score INT,
FOREIGN KEY (student_id) REFERENCES Students(student_id),
FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id),
FOREIGN KEY (exam_id) REFERENCES Exams(exam_id)
);
-- SAMPLE DATA
-- Students
INSERT INTO Students VALUES
(1, 'Aarav', 'Sharma', 2023),
(2, 'Diya', 'Patel', 2023),
(3, 'Vihaan', 'Rao', 2024),
(4, 'Ananya', 'Singh', 2024);
-- Subjects
INSERT INTO Subjects VALUES
(101, 'Mathematics'),
(102, 'Science'),
(103, 'Hindi Literature');
-- Exams
INSERT INTO Exams VALUES
(1, 'Half-Yearly 2024', '2024-09-15'),
(2, 'Final Annual 2024', '2024-03-20');
-- Marks
INSERT INTO Marks VALUES
(1, 1, 101, 1, 85), -- Aarav, Math, Half-Yearly
(2, 1, 102, 1, 90), -- Aarav, Science, Half-Yearly
(3, 2, 101, 1, 75), -- Diya, Math, Half-Yearly
(4, 2, 102, 1, 60), -- Diya, Science, Half-Yearly
(5, 3, 101, 1, 95), -- Vihaan, Math, Half-Yearly
(6, 1, 101, 2, 88), -- Aarav, Math, Final
(7, 2, 101, 2, 79), -- Diya, Math, Final
(8, 3, 101, 2, 92); -- Vihaan, Math, Final
-- Note: Ananya Singh (student_id 4) has no marks recorded, and
-- Hindi Literature (subject_id 103) is never used -- both are useful
-- edge cases for the LEFT JOIN / "never took an exam" queries below.
-- NDEXES
-- Foreign-key and frequently-filtered columns get explicit indexes to
-- speed up the JOINs, WHERE and GROUP BY clauses used throughout.
CREATE INDEX idx_marks_student ON Marks(student_id);
CREATE INDEX idx_marks_subject ON Marks(subject_id);
CREATE INDEX idx_marks_exam ON Marks(exam_id);
CREATE INDEX idx_marks_score ON Marks(score);
CREATE INDEX idx_students_enrollment ON Students(enrollment_year);
CREATE INDEX idx_exams_date ON Exams(exam_date);
-- Verify indexes:
-- SHOW INDEX FROM Marks;
-- SHOW INDEX FROM Students;
-- VIEWS
-- 4.1 Flattened mark + student + subject + exam info (for reporting/UI)
CREATE OR REPLACE VIEW view_student_marks AS
SELECT
M.mark_id,
CONCAT(St.first_name, ' ', St.last_name) AS student_name,
Sb.subject_name,
E.exam_name,
E.exam_date,
M.score
FROM Marks M
JOIN Students St ON M.student_id = St.student_id
JOIN Subjects Sb ON M.subject_id = Sb.subject_id
JOIN Exams E ON M.exam_id = E.exam_id;
-- 4.2 Average score per subject
CREATE OR REPLACE VIEW view_subject_averages AS
SELECT
Sb.subject_id,
Sb.subject_name,
ROUND(AVG(M.score), 2) AS average_score,
COUNT(M.mark_id) AS marks_recorded
FROM Subjects Sb
LEFT JOIN Marks M ON Sb.subject_id = M.subject_id
GROUP BY Sb.subject_id, Sb.subject_name;
-- 4.3 Per-student totals (includes students with zero marks)
CREATE OR REPLACE VIEW view_student_totals AS
SELECT
St.student_id,
CONCAT(St.first_name, ' ', St.last_name) AS student_name,
St.enrollment_year,
COUNT(M.mark_id) AS marks_count,
COALESCE(SUM(M.score), 0) AS total_score,
ROUND(AVG(M.score), 2) AS average_score
FROM Students St
LEFT JOIN Marks M ON St.student_id = M.student_id
GROUP BY St.student_id, St.first_name, St.last_name, St.enrollment_year;
-- 4.4 Pass / Fail report (score >= 70 is a Pass)
CREATE OR REPLACE VIEW view_pass_fail AS
SELECT
CONCAT(St.first_name, ' ', St.last_name) AS student_name,
Sb.subject_name,
E.exam_name,
M.score,
CASE WHEN M.score >= 70 THEN 'Pass' ELSE 'Fail' END AS status
FROM Marks M
JOIN Students St ON M.student_id = St.student_id
JOIN Subjects Sb ON M.subject_id = Sb.subject_id
JOIN Exams E ON M.exam_id = E.exam_id;
-- 4.5 Exam-wise summary (total score, pass count, fail count)
CREATE OR REPLACE VIEW view_exam_summary AS
SELECT
E.exam_id,
E.exam_name,
SUM(M.score) AS total_score,
SUM(CASE WHEN M.score >= 70 THEN 1 ELSE 0 END) AS pass_count,
SUM(CASE WHEN M.score < 70 THEN 1 ELSE 0 END) AS fail_count
FROM Exams E
JOIN Marks M ON E.exam_id = M.exam_id
GROUP BY E.exam_id, E.exam_name;
-- STORED PROCEDURES
-- 5.1 All marks for one student (by student_id)
DROP PROCEDURE IF EXISTS sp_get_student_marks;
DELIMITER $$
CREATE PROCEDURE sp_get_student_marks(IN p_student_id INT)
BEGIN
SELECT Sb.subject_name, E.exam_name, M.score
FROM Marks M
JOIN Subjects Sb ON M.subject_id = Sb.subject_id
JOIN Exams E ON M.exam_id = E.exam_id
WHERE M.student_id = p_student_id
ORDER BY E.exam_date, Sb.subject_name;
END $$
DELIMITER ;
-- 5.2 Add a new mark (validates score range 0-100, auto-generates mark_id)
DROP PROCEDURE IF EXISTS sp_add_mark;
DELIMITER $$
CREATE PROCEDURE sp_add_mark(
IN p_student_id INT,
IN p_subject_id INT,
IN p_exam_id INT,
IN p_score INT
)
BEGIN
DECLARE v_new_id INT;
IF p_score < 0 OR p_score > 100 THEN
 SIGNAL SQLSTATE '45000'
 SET MESSAGE_TEXT = 'Score must be between 0 and 100';
ELSE
 SELECT COALESCE(MAX(mark_id), 0) + 1 INTO v_new_id FROM Marks;
 INSERT INTO Marks (mark_id, student_id, subject_id, exam_id, score)
 VALUES (v_new_id, p_student_id, p_subject_id, p_exam_id, p_score);
END IF;
END $$
DELIMITER ;
-- 5.3 Average score for one subject (by subject_id)
DROP PROCEDURE IF EXISTS sp_subject_average;
DELIMITER $$
CREATE PROCEDURE sp_subject_average(IN p_subject_id INT)
BEGIN
SELECT Sb.subject_name, ROUND(AVG(M.score), 2) AS average_score
FROM Subjects Sb
LEFT JOIN Marks M ON Sb.subject_id = M.subject_id
WHERE Sb.subject_id = p_subject_id
GROUP BY Sb.subject_name;
END $$
DELIMITER ;
-- 5.4 Full exam report: every mark + pass/fail + exam-level pass count
DROP PROCEDURE IF EXISTS sp_exam_report;
DELIMITER $$
CREATE PROCEDURE sp_exam_report(IN p_exam_id INT)
BEGIN
SELECT CONCAT(St.first_name, ' ', St.last_name) AS student_name,
 Sb.subject_name,
 M.score,
 CASE WHEN M.score >= 70 THEN 'Pass' ELSE 'Fail' END AS status
FROM Marks M
JOIN Students St ON M.student_id = St.student_id
JOIN Subjects Sb ON M.subject_id = Sb.subject_id
WHERE M.exam_id = p_exam_id
ORDER BY M.score DESC;
END $$
DELIMITER ;
-- 5.5 Student report card (all marks + overall average)
DROP PROCEDURE IF EXISTS sp_student_report_card;
DELIMITER $$
CREATE PROCEDURE sp_student_report_card(IN p_student_id INT)
BEGIN
SELECT Sb.subject_name, E.exam_name, M.score,
 CASE WHEN M.score >= 70 THEN 'Pass' ELSE 'Fail' END AS status
FROM Marks M
JOIN Subjects Sb ON M.subject_id = Sb.subject_id
JOIN Exams E ON M.exam_id = E.exam_id
WHERE M.student_id = p_student_id;
SELECT ROUND(AVG(score), 2) AS overall_average
FROM Marks
WHERE student_id = p_student_id;
END $$
DELIMITER ;
-- TRIGGERS
-- 6.0 Supporting audit table for mark changes
CREATE TABLE marks_log (
log_id INT AUTO_INCREMENT PRIMARY KEY,
mark_id INT,
student_id INT,
action_type VARCHAR(10),
old_score INT,
new_score INT,
change_date DATETIME DEFAULT CURRENT_TIMESTAMP
);
-- 6.1 Reject an out-of-range score before it is ever inserted
DROP TRIGGER IF EXISTS trg_validate_score_insert;
DELIMITER $$
CREATE TRIGGER trg_validate_score_insert
BEFORE INSERT ON Marks
FOR EACH ROW
BEGIN
IF NEW.score < 0 OR NEW.score > 100 THEN
 SIGNAL SQLSTATE '45000'
 SET MESSAGE_TEXT = 'Score must be between 0 and 100';
END IF;
END $$
DELIMITER ;
-- 6.2 Reject an out-of-range score on UPDATE too
DROP TRIGGER IF EXISTS trg_validate_score_update;
DELIMITER $$
CREATE TRIGGER trg_validate_score_update
BEFORE UPDATE ON Marks
FOR EACH ROW
BEGIN
IF NEW.score < 0 OR NEW.score > 100 THEN
 SIGNAL SQLSTATE '45000'
 SET MESSAGE_TEXT = 'Score must be between 0 and 100';
END IF;
END $$
DELIMITER ;
-- 6.3 Block duplicate marks (same student + subject + exam already exists)
DROP TRIGGER IF EXISTS trg_prevent_duplicate_mark;
DELIMITER $$
CREATE TRIGGER trg_prevent_duplicate_mark
BEFORE INSERT ON Marks
FOR EACH ROW
BEGIN
DECLARE v_count INT;
SELECT COUNT(*) INTO v_count
FROM Marks
WHERE student_id = NEW.student_id
 AND subject_id = NEW.subject_id
 AND exam_id = NEW.exam_id;
IF v_count > 0 THEN
 SIGNAL SQLSTATE '45000'
 SET MESSAGE_TEXT = 'This student already has a mark for this subject in this exam';
END IF;
END $$
DELIMITER ;
-- 6.4 Log every new mark inserted
DROP TRIGGER IF EXISTS trg_log_mark_insert;
DELIMITER $$
CREATE TRIGGER trg_log_mark_insert
AFTER INSERT ON Marks
FOR EACH ROW
BEGIN
INSERT INTO marks_log (mark_id, student_id, action_type, old_score, new_score)
VALUES (NEW.mark_id, NEW.student_id, 'INSERT', NULL, NEW.score);
END $$
DELIMITER ;
-- 6.5 Log every score change (old vs new)
DROP TRIGGER IF EXISTS trg_log_mark_update;
DELIMITER $$
CREATE TRIGGER trg_log_mark_update
AFTER UPDATE ON Marks
FOR EACH ROW
BEGIN
IF OLD.score <> NEW.score THEN
 INSERT INTO marks_log (mark_id, student_id, action_type, old_score, new_score)
 VALUES (NEW.mark_id, NEW.student_id, 'UPDATE', OLD.score, NEW.score);
END IF;
END $$
DELIMITER ;
-- 6.6 Log every deleted mark
DROP TRIGGER IF EXISTS trg_log_mark_delete;
DELIMITER $$
CREATE TRIGGER trg_log_mark_delete
AFTER DELETE ON Marks
FOR EACH ROW
BEGIN
INSERT INTO marks_log (mark_id, student_id, action_type, old_score, new_score)
VALUES (OLD.mark_id, OLD.student_id, 'DELETE', OLD.score, NULL);
END $$
DELIMITER ;

--  Display the first name and last name of all students.
select first_name,last_name from students;

-- Retrieve all records from the Marks table where the score is greater than 80.
select*from marks where score>80;
-- Display all exams ordered by exam date, starting with the most recent exam
select*from exams order by exam_date desc;
-- Display the student's first name, subject name, and score for every recorded mark.
select s.first_name,ss.subject_name,m.score from marks m
join students s on m.student_id=s.student_id join subjects ss on m.subject_id=ss.subject_id;
-- Calculate the average score for each subject.
select s.subject_name,avg(m.score) as average_score from subjects s
join marks m on s.subject_id=m.subject_id group by s.subject_name;
-- Find the total number of exams taken by the student Aarav Sharma.
select s.first_name,count(m.student_id) as total_exam from students s
join marks m on s.student_id=m.student_id where s.first_name='aarav';

-- Retrieve the name of the student who obtained the highest individual score in any exam.
select s.first_name,m.score from students s
join marks m on s.student_id=m.student_id order by m.score desc limit 1;
-- Display each exam name and its total score. Show only exams where the total score is greater than 250.
select e.exam_name,sum(m.score) as total_score from exams e
join marks m on e.exam_id=m.exam_id group by e.exam_name having total_score>250;
-- Display the student name, subject name, score, and pass/fail status. Consider a score of 70 or above as Pass; otherwise, Fail.
select s.first_name,ss.subject_name,m.score,
case
when m.score>=70 then'pass'
else 'fail'
end as status from marks m join subjects ss on m.subject_id=ss.subject_id
join students s on m.student_id=s.student_id;
-- Retrieve the first and last names of students who enrolled in 2023.
select first_name,last_name from students where enrollment_year=2023;
-- Find the highest score recorded in each subject
select s.subject_name,max(m.score) as high_score from subjects s 
join marks m on s.subject_id=m.subject_id group by s.subject_name;

--  Retrieve the names of students who appeared for the 'Final Annual 2024' examination
select s.first_name,e.exam_name from students s
join marks m on s.student_id=m.student_id join exams e on m.exam_id=e.exam_id
where e.exam_name='final annual 2024';

-- Display students whose average score across all recorded marks is greater than 80.
select s.first_name,avg(m.score) as average_score from students s
join marks m on s.student_id=m.student_id group by s.first_name having average_score>80;

-- Find the number of students enrolled in each year
select enrollment_year,count(*) as total_students from students group by enrollment_year;
--  Identify the subject with the highest average score.
select s.subject_name,avg(m.score) as average_score from subjects s
join marks m on s.subject_id=m.subject_id group by s.subject_name
order by average_score desc limit 1;

-- Retrieve students who scored above the average score of their respective subjects.
select s.first_name,ss.subject_name,m.score from students s join marks m
on s.student_id=m.student_id join subjects ss on ss.subject_id=m.subject_id;
where m.score (select avg (m2.score) from marks m2 where m2.subject_id=m.subject_id);

-- Calculate the number of students who passed and failed each exam. Consider 70 as the minimum passing score.
select e.exam_name,sum(case when m.score>=70 then 1 else 0 end) as passed,
sum(case when m.score>=70 then 0 else 1 end) as fail
from exams e join marks m on e.exam_id=m.exam_id group by e.exam_name;
-- Display student name, subject name, exam name,and score for every recorded mark
select s.first_name,ss.subject_name,e.exam_name,m.score from marks m join students s
on m.student_id=s.student_id join subjects ss on m.subject_id=ss.subject_id 
join exams e on m.exam_id=e.exam_id;
--  Retrieve the names of students who do not have any marks recorded.
select s.first_name,m.score from students s
left join marks m on m.student_id=s.student_id where m.score is null;

-- Calculate the total score obtained by each student and display students in descending order of their total scores. Include students who have notreceived any marks.
