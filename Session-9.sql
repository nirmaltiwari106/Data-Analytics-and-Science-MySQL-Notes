-- create database
create database demojoins;
-- Use the newly created database for subsequent operations
USE demojoins;

/*
Subqueries:

Definition:
A subquery, also known as a nested query or inner query, is a query embedded within another SQL query. 
It is enclosed in parentheses and can be used in various clauses such as SELECT, INSERT, UPDATE, or DELETE. 
Subqueries can return a single value, a single row, or a set of rows.

Purpose:
Subqueries are used to perform operations that require multiple steps or to filter results based on the 
results of another query. They can simplify complex queries by breaking them down into smaller, 
more manageable parts. Subqueries can also be used to retrieve data that will be used in the main query, 
allowing for more dynamic and flexible SQL statements.

Types of Subqueries:
1. Single-row subquery: Returns a single row and can be used with comparison operators.
2. Multiple-row subquery: Returns multiple rows and can be used with operators like IN, ANY, or ALL.
3. Scalar subquery: Returns a single value (one column, one row) and can be used in expressions.

Examples:
*/

-- Table-1
-- Create the faculty table to store information about faculty members
CREATE TABLE faculty (
    faculty_id INT PRIMARY KEY AUTO_INCREMENT,
    faculty_code VARCHAR(10) UNIQUE NOT NULL,
    faculty_name VARCHAR(100) NOT NULL,
    faculty_description TEXT,
    dean_name VARCHAR(100) NOT NULL,
    established_year YEAR CHECK (established_year >= 1950),
    faculty_email VARCHAR(100) UNIQUE NOT NULL,
    faculty_phone VARCHAR(15) UNIQUE,
    faculty_location VARCHAR(100) NOT NULL,
    status ENUM('Active','Inactive') DEFAULT 'Active'
);

-- Insert sample data into the faculty table
INSERT INTO faculty VALUES
(1,'SCI','Faculty of Science','Science disciplines','Dr. Alice Smith',1995,'science@uni.com','9876543210','Building A','Active'),
(2,'ENG','Faculty of Engineering','Engineering & Technology','Dr. Bob Johnson',1992,'eng@uni.com','9876543211','Building B','Active'),
(3,'ART','Faculty of Arts','Humanities & Social Science','Dr. Carol Williams',1988,'arts@uni.com','9876543212','Building C','Active'),
(4,'BUS','Faculty of Business','Business & Management','Dr. David Brown',2000,'business@uni.com','9876543213','Building D','Active'),
(5,'EDU','Faculty of Education','Teacher Education','Dr. Eva Davis',1998,'edu@uni.com','9876543214','Building E','Active');

-- display data
select * from faculty;

-- Table-2
-- Create the department table to store information about departments within faculties
CREATE TABLE department (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_code VARCHAR(10) UNIQUE NOT NULL,
    department_name VARCHAR(100) NOT NULL,
    department_description TEXT,
    faculty_id INT NOT NULL,
    department_head VARCHAR(100) NOT NULL,
    contact_email VARCHAR(100) UNIQUE,
    contact_phone VARCHAR(15),
    department_location VARCHAR(100),
    status ENUM('Active','Inactive') DEFAULT 'Active',
    FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id)
);

-- Insert sample data into the department table
INSERT INTO department VALUES
(1,'PHY','Physics','Matter & Energy',1,'Dr. Emily White','phy@uni.com','9000011111','Room 101','Active'),
(2,'CSE','Computer Science','Computing & AI',1,'Dr. Frank Green','cse@uni.com','9000011112','Room 102','Active'),
(3,'CIV','Civil Engineering','Infrastructure',2,'Dr. Grace Black','civil@uni.com','9000011113','Room 201','Active'),
(4,'MECH','Mechanical Engg','Machines & Design',2,'Dr. Henry Blue','mech@uni.com','9000011114','Room 202','Active'),
(5,'HIS','History','World History',3,'Dr. Irene Red','his@uni.com','9000011115','Room 301','Active');

-- display data
select * from department;

-- Table-3
-- Create the students table to store information about students
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    roll_no VARCHAR(15) UNIQUE NOT NULL,
    student_name VARCHAR(100) NOT NULL,
    gender ENUM('Male','Female','Other'),
    date_of_birth DATE NOT NULL,
    student_email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(15),
    enrollment_year YEAR NOT NULL,
    department_id INT NOT NULL,
    faculty_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES department(department_id),
    FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id)
);

-- Insert sample data into the students table
INSERT INTO students VALUES
(1,'SCI101','John Doe','Male','2002-05-10','john@uni.com','9111111111',2021,1,1),
(2,'SCI102','Jane Smith','Female','2001-08-15','jane@uni.com','9222222222',2020,2,1),
(3,'SCI103','Alice Johnson','Female','2003-03-20','alice@uni.com','9333333333',2022,1,1),
(4,'ENG201','Bob Brown','Male','2002-11-12','bob@uni.com','9444444444',2021,3,2),
(5,'ENG202','Charlie Davis','Male','2004-01-25','charlie@uni.com','9555555555',2023,4,2);

-- display data
select * from students;

-- Table-4
-- Create the salary table to store salary information for faculty members
CREATE TABLE salary (
    salary_id INT PRIMARY KEY AUTO_INCREMENT,
    faculty_id INT NOT NULL,
    basic_salary DECIMAL(10,2) CHECK (basic_salary > 0),
    hra DECIMAL(10,2),
    da DECIMAL(10,2),
    deductions DECIMAL(10,2) DEFAULT 0,
    net_salary DECIMAL(10,2),
    payment_month VARCHAR(15),
    payment_date DATE NOT NULL,
    payment_status ENUM('Paid','Pending') DEFAULT 'Paid',
    FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id)
);

-- Insert sample data into the salary table
INSERT INTO salary VALUES
(1,1,60000,8000,5000,2000,71000,'January','2023-01-15','Paid'),
(2,2,65000,9000,5500,2500,77000,'January','2023-01-15','Paid'),
(3,3,58000,7500,4800,1800,68500,'January','2023-01-15','Paid'),
(4,4,62000,8200,5100,2200,73100,'January','2023-01-15','Paid'),
(5,5,56000,7000,4500,1500,66000,'January','2023-01-15','Paid');

-- display data
select * from salary;

-- Table-5
-- Create the marks table to store marks obtained by students
CREATE TABLE marks (
    marks_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    subject_code VARCHAR(10) NOT NULL,
    subject_name VARCHAR(100) NOT NULL,
    semester INT CHECK (semester BETWEEN 1 AND 8),
    max_marks INT DEFAULT 100,
    marks_obtained INT CHECK (marks_obtained BETWEEN 0 AND 100),
    grade CHAR(2),
    exam_type ENUM('Internal','External'),
    result_status ENUM('Pass','Fail'),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);


-- Insert sample data into the marks table
INSERT INTO marks VALUES
(1,1,'PHY101','Physics',1,100,85,'A','External','Pass'),
(2,1,'MAT101','Mathematics',1,100,90,'A+','External','Pass'),
(3,2,'CSE201','Computer Science',2,100,88,'A','External','Pass'),
(4,3,'PHY101','Physics',1,100,92,'A+','External','Pass'),
(5,4,'CIV201','Civil Engineering',2,100,75,'B','External','Pass'),
(6,5,'BUS101','Business Management',1,100,80,'A','External','Pass');

-- display data
select * from marks;

/*
1. Single-row subquery:

   - Purpose: To find employees whose salary is greater than the average salary.
*/

-- create Employees table and insert 5 values

CREATE TABLE EMPLOYEES(
   EMPLOYEE_ID INT PRIMARY KEY,
   EMPLOYEE_NAME VARCHAR(100),
   DEPARTMENT VARCHAR(50),
   SALARY INT,
   JOIN_DATE DATE
   );
	   INSERT INTO Employees VALUES
	(1, 'Amit Sharma', 'HR', 35000, '2022-03-15'),
	(2, 'Priya Singh', 'IT', 55000, '2021-07-10'),
	(3, 'Rahul Verma', 'Finance', 45000, '2020-11-25'),
	(4, 'Neha Patel', 'Marketing', 40000, '2023-01-05'),
	(5, 'Karan Mehta', 'Operations', 38000, '2022-09-18');

SELECT * FROM EMPLOYEES;

   SELECT Employee_ID, EMPLOYEE_NAME
   FROM Employees
   WHERE Salary > (SELECT AVG(Salary) FROM Employees);

-- SOLVED REAL-LIFE SUBQUERY SITUATIONS
-- (Based on Faculty, Department, Students, Salary, Marks)

-- Solved-1(Single-Row Subquery): Find students who scored more than the average marks
-- Identify above-average performers in the university.

SELECT s.student_name, m.marks_obtained
FROM students s
JOIN marks m ON s.student_id = m.student_id
WHERE m.marks_obtained >
      (SELECT AVG(marks_obtained) FROM marks);
      
-- Solved-2(Single-Row Subquery): Find students from the same department as Jane Smith
-- Find classmates of a specific student.

SELECT student_name
FROM students
WHERE department_id =
      (SELECT department_id
       FROM students
       WHERE student_name = 'Jane Smith');
   
/*
2. Multiple-row subquery:
Purpose: To find employees who work in departments with a budget greater than $100,000.
*/

SELECT Employee_ID,EMPLOYEE_NAME
FROM Employees
WHERE Department_ID IN (SELECT Department_ID FROM Department WHERE Budget > 100000);

-- use alter and update staement to add budget column

-- Solved-3(Multi-Row Subquery): Find departments having more than one student
-- Identify active departments.

SELECT department_name
FROM department
WHERE department_id IN
      (SELECT department_id
       FROM students
       GROUP BY department_id
       HAVING COUNT(*) > 1);

#find departments having more than 2 students/fcaulty

/*
3. Scalar subquery:
Purpose: To find the name of the employee with the highest salary.
*/

SELECT EMPLOYEE_NAME
FROM Employees
WHERE Salary = (SELECT MAX(Salary) FROM Employees);

-- Solved-4(Scalar Subquery): Find faculty members earning more than average salary
-- Identify high-paid faculty members.

SELECT f.faculty_name, sa.net_salary
FROM faculty f
JOIN salary sa ON f.faculty_id = sa.faculty_id
WHERE sa.net_salary >
      (SELECT AVG(net_salary) FROM salary);

-- Task - create 3 situations to implement subquery concept on faculty table

-- Situation 1: Faculty earning more than the average salary

-- Situation 2: Faculty with maximum salary in each department

-- Situation 3: Faculty who joined earlier than the average joining date

/*
4. Correlated subquery:
A correlated subquery uses values from the outer query
--> Executes once per row

Purpose: To find employees whose salary is above the average salary of their respective departments.
*/

SELECT e.Employee_ID, e.EMPLOYEE_NAME
FROM Employees e
WHERE e.Salary > (SELECT AVG(Salary) FROM Employees WHERE Department_ID = e.DepartmentID);

select * from employees;
-- add department_ID as forign key in employee table

-- Solved-5(Scalar Subquery): Find students scoring highest marks in any subject
-- Identify top scorers.

SELECT s.student_name, m.subject_name, m.marks_obtained
FROM students s
JOIN marks m ON s.student_id = m.student_id
WHERE m.marks_obtained =
      (SELECT MAX(marks_obtained) FROM marks);

/*
subqueries are a powerful feature in SQL that allow for more complex and dynamic queries by enabling the use 
of the results of one query within another. They can help simplify SQL statements and make them more readable 
and maintainable. 
*/

-- UNSOLVED REAL-LIFE SUBQUERY PROBLEMS

-- LEVEL 1: SIMPLE SUBQUERIES (Foundation)

#Unsolved-1
-- Find faculty members who earn less than the average salary of all faculty.

#Unsolved-2
-- List students who are enrolled in the same department as 'Jane Smith'.

#Unsolved-3
-- Find departments that belong to the same faculty as 'Computer Science'.

#Unsolved-4
-- Find students who are enrolled in the latest enrollment year.

#Unsolved-5
-- Find faculty members who do not have any students.

-- LEVEL 2: AGGREGATE + FILTER SUBQUERIES

#Unsolved-6
-- Find students who scored more than the average marks of all students.

#Unsolved-7
-- Find the department(s) having the maximum number of students.

#Unsolved-8
-- Find faculty members who earn the highest salary.

#Unsolved-9
-- Find students who scored the minimum marks in any subject.

#Unsolved-10
-- Find departments whose student count is greater than the average student count of all departments.

-- LEVEL 3: CORRELATED SUBQUERIES (IMPORTANT)

#Unsolved-11
-- List students who scored below the average marks of their own department.
-- (Correlated Subquery)

#Unsolved-12
-- Find faculty members whose salary is greater than the average salary of their own faculty.
-- (Correlated Subquery)

#Unsolved-13
-- Find students who scored the highest marks within their own department.
-- (Correlated Subquery)

#Unsolved-14
-- Find faculty members who earn less than the maximum salary of their faculty.
-- (Correlated Subquery)

#Unsolved-15
-- Find students who enrolled earlier than the average enrollment year of their department.
-- (Correlated Subquery)

-- LEVEL 4: MULTI-TABLE + COMPLEX SUBQUERIES

#Unsolved-16
-- Find students who scored more than the average marks of their faculty.

#Unsolved-17
-- Find faculty members who have students scoring less than 40 marks.
-- (Use EXISTS)

#Unsolved-18
-- Find departments where at least one student has scored above 90 marks.
-- (Use EXISTS)

#Unsolved-19
-- Find students who scored more than ALL students of a specific department (e.g., Physics).
-- (Use ALL)

#Unsolved-20
-- Find faculty members whose salary is greater than ANY salary of faculty belonging to another faculty.
-- (Use ANY)

/*
What is a Co-related Subquery?
- A co-related subquery is a subquery that uses values from the outer query.
- Unlike a normal subquery (which runs once), a co-related subquery is executed repeatedly — 
once for each row processed by the outer query.
- So, it is row-by-row comparison.

Syntax -

SELECT column1, column2
FROM table1 t1
WHERE column1 operator
      (SELECT columnX 
       FROM table2 t2
       WHERE t1.columnY = t2.columnY);

- t1 is from outer query
- t2 is from inner query
- The subquery references columns of the outer query (t1.columnY).

Key Points

- Normal Subquery → Executes once and result is used by outer query.
- Co-related Subquery → Executes for each row of outer query.
- Commonly used with operators: =, >, <, >=, <=, IN, EXISTS, ANY, ALL.
- Performance can be slower for large data, but sometimes unavoidable.
*/
select * from employees;

-- Example 1: Find Employees earning more than the average salary of their own department
SELECT e.employee_id, e.employee_name, e.salary, e.department
FROM employees e
WHERE e.salary > (
      SELECT AVG(e2.salary)
      FROM employees e2
      WHERE e.department_id = e2.department_id
);

-- Example 2: Find Students who scored more than the average marks in their own class
SELECT s.student_id, s.student_name, #s.class, s.marks, 
s.roll_no
FROM students s
WHERE s.marks > (
      SELECT AVG(s2.marks)
      FROM students s2
      #WHERE s.class = s2.class
      WHERE s.roll_no = s2.roll_no
);

select * from students;
-- add join concept and marks table to solve this problem

-- Example 3: Find Employees whose salary is greater than at least one employee in the same department
SELECT e.emp_id, e.emp_name, e.salary, e.dept_id
FROM employees e
WHERE e.salary > ANY (
      SELECT e2.salary
      FROM employees e2
      WHERE e.dept_id = e2.dept_id
        AND e.emp_id <> e2.emp_id
);

-- Example 4: Find Employees who get the maximum salary in their department
SELECT e.emp_id, e.emp_name, e.salary, e.dept_id
FROM employees e
WHERE e.salary = (
      SELECT MAX(e2.salary)
      FROM employees e2
      WHERE e.dept_id = e2.dept_id
);

-- Sub-Queries with 2 Tables

-- 1. Find students who scored above the highest mark in a specific subject
SELECT s.student_name, m.marks_obtained
FROM students s
JOIN marks m ON s.student_id = m.student_id
WHERE m.marks_obtained > (SELECT MAX(marks_obtained) FROM marks WHERE subject_name = 'Mathematics');

-- 2. Find faculty members who earn less than the minimum salary in their department
SELECT f.faculty_name, s.amount
FROM faculty f
JOIN salary s ON f.faculty_id = s.faculty_id
WHERE s.amount < (SELECT MIN(amount) FROM salary WHERE department_id = f.department_id);

-- 3. Find students who scored above the average marks in a specific subject
SELECT s.student_name, m.marks_obtained
FROM students s
JOIN marks m ON s.student_id = m.student_id
WHERE m.marks_obtained > (SELECT AVG(marks_obtained) FROM marks WHERE subject_name = 'Science');

-- 4. Find faculty members who earn more than the average salary in their department
SELECT f.faculty_name, s.amount
FROM faculty f
JOIN salary s ON f.faculty_id = s.faculty_id
WHERE s.amount > (SELECT AVG(amount) FROM salary WHERE department_id = f.department_id);

-- 5. Find students who scored above the highest mark in a specific subject and have a faculty member with a 
-- specific title
SELECT s.student_name, m.marks_obtained
FROM students s
JOIN marks m ON s.student_id = m.student_id
WHERE m.marks_obtained > (SELECT MAX(marks_obtained) FROM marks WHERE subject_name = 'Mathematics')
AND s.faculty_id IN (SELECT faculty_id FROM faculty WHERE title = 'Professor');

-- 6. Find faculty members who earn less than the minimum salary in their department and have students with 
-- low marks
SELECT f.faculty_name, s.amount
FROM faculty f
JOIN salary s ON f.faculty_id = s.faculty_id
WHERE s.amount < (SELECT MIN(amount) FROM salary WHERE department_id = f.department_id)
AND EXISTS (SELECT 1 FROM students s2 JOIN marks m ON s2.student_id = m.student_id 
WHERE s2.faculty_id = f.faculty_id AND m.marks_obtained < 40);


-- Sub-Queries with 3 Tables

-- 1. Find students who scored above the highest mark in a specific subject and are from a specific department
SELECT s.student_name, m.marks_obtained
FROM students s
JOIN marks m ON s.student_id = m.student_id
JOIN department d ON s.department_id = d.department_id
WHERE m.marks_obtained > (SELECT MAX(marks_obtained) FROM marks WHERE subject_name = 'Mathematics')
AND d.department_name = 'Computer Science';

-- 2. Find faculty members who earn less than the minimum salary in their department and have students with low 
-- marks
SELECT f.faculty_name, s.amount
FROM faculty f
JOIN salary s ON f.faculty_id = s.faculty_id
JOIN department d ON f.department_id = d.department_id
WHERE s.amount < (SELECT MIN(amount) FROM salary WHERE department_id = f.department_id)
AND EXISTS (SELECT 1 FROM students s2 JOIN marks m ON s2.student_id = m.student_id 
WHERE s2.faculty_id = f.faculty_id AND m.marks_obtained < 40);

-- 3. Find students who scored above the average marks in a specific subject and have a faculty member with 
-- a specific title
SELECT s.student_name, m.marks_obtained
FROM students s
JOIN marks m ON s.student_id = m.student_id
JOIN faculty f ON s.faculty_id = f.faculty_id
WHERE m.marks_obtained > (SELECT AVG(marks_obtained) FROM marks WHERE subject_name = 'Science')
AND f.title = 'Professor';

-- 4. Find faculty members who earn more than the average salary in their department and have students 
-- with high marks
SELECT f.faculty_name, s.amount
FROM faculty f
JOIN salary s ON f.faculty_id = s.faculty_id
JOIN department d ON f.department_id = d.department_id
WHERE s.amount > (SELECT AVG(amount) FROM salary WHERE department_id = f.department_id)
AND EXISTS (SELECT 1 FROM students s2 JOIN marks m ON s2.student_id = m.student_id 
WHERE s2.faculty_id = f.faculty_id AND m.marks_obtained > 80);

-- 5. Find students who scored above the highest mark in a specific subject, are from a specific department, 
-- and have a faculty member with a specific title
SELECT s.student_name, m.marks_obtained
FROM students s
JOIN marks m ON s.student_id = m.student_id
JOIN faculty f ON s.faculty_id = f.faculty_id
JOIN department d ON s.department_id = d.department_id
WHERE m.marks_obtained > (SELECT MAX(marks_obtained) FROM marks WHERE subject_name = 'Mathematics')
AND d.department_name = 'Computer Science'
AND f.title = 'Professor';

-- 6. Find faculty members who earn less than the minimum salary in their department, have students 
-- with low marks, and are from a specific department
SELECT f.faculty_name, s.amount
FROM faculty f
JOIN salary s ON f.faculty_id = s.faculty_id
JOIN department d ON f.department_id = d.department_id
WHERE s.amount < (SELECT MIN(amount) FROM salary WHERE department_id = f.department_id)
AND EXISTS (SELECT 1 FROM students s2 JOIN marks m ON s2.student_id = m.student_id 
WHERE s2.faculty_id = f.faculty_id AND m.marks_obtained < 40)
AND d.department_name = 'Electrical Engineering';

-- Sub-Queries with 4 Tables

-- 1. Find students who scored above the average marks in their department and have a faculty member 
-- with a specific title
SELECT s.student_name, m.marks_obtained, d.department_name, f.faculty_name
FROM students s
JOIN marks m ON s.student_id = m.student_id
JOIN department d ON s.department_id = d.department_id
JOIN faculty f ON d.faculty_id = f.faculty_id
WHERE m.marks_obtained > (SELECT AVG(marks_obtained) FROM marks m2 
                           JOIN students s2 ON m2.student_id = s2.student_id 
                           WHERE s2.department_id = d.department_id)
AND f.title = 'Professor';

-- 2. Find faculty members who earn more than the average salary of their department and have students 
-- with high marks
SELECT f.faculty_name, s.amount, d.department_name
FROM faculty f
JOIN salary s ON f.faculty_id = s.faculty_id
JOIN department d ON f.department_id = d.department_id
WHERE s.amount > (SELECT AVG(amount) FROM salary s2 
                   JOIN faculty f2 ON s2.faculty_id = f2.faculty_id 
                   WHERE f2.department_id = d.department_id)
AND EXISTS (SELECT 1 FROM students s3 
            JOIN marks m ON s3.student_id = m.student_id 
            WHERE s3.department_id = d.department_id AND m.marks_obtained > 80);
            
-- 3. Find students who scored above the average marks in their department and are taught by faculty members 
-- with a specific salary range
SELECT s.student_name, m.marks_obtained, d.department_name, f.faculty_name, sa.amount
FROM students s
JOIN marks m ON s.student_id = m.student_id
JOIN department d ON s.department_id = d.department_id
JOIN faculty f ON d.faculty_id = f.faculty_id
JOIN salary sa ON f.faculty_id = sa.faculty_id
WHERE m.marks_obtained > (SELECT AVG(marks_obtained) FROM marks m2 
                           JOIN students s2 ON m2.student_id = s2.student_id 
                           WHERE s2.department_id = d.department_id)
AND sa.amount BETWEEN 50000 AND 100000;

-- 4. Find faculty members who earn less than the minimum salary in their department and have students 
-- with low marks
SELECT f.faculty_name, s.amount, d.department_name
FROM faculty f
JOIN salary s ON f.faculty_id = s.faculty_id
JOIN department d ON f.department_id = d.department_id
WHERE s.amount < (SELECT MIN(amount) FROM salary s2 
                   JOIN faculty f2 ON s2.faculty_id = f2.faculty_id 
                   WHERE f2.department_id = d.department_id)
AND EXISTS (SELECT 1 FROM students s3 
            JOIN marks m ON s3.student_id = m.student_id 
            WHERE s3.faculty_id = f.faculty_id AND m.marks_obtained < 40);
            
-- 5. Find students who scored above the average marks in their department and are supervised by faculty 
-- members with a specific title and salary range
SELECT s.student_name, m.marks_obtained, d.department_name, f.faculty_name, sa.amount
FROM students s
JOIN marks m ON s.student_id = m.student_id
JOIN department d ON s.department_id = d.department_id
JOIN faculty f ON d.faculty_id = f.faculty_id
JOIN salary sa ON f.faculty_id = sa.faculty_id
WHERE m.marks_obtained > (SELECT AVG(marks_obtained) FROM marks m2 
                           JOIN students s2 ON m2.student_id = s2.student_id 
                           WHERE s2.department_id = d.department_id)
AND f.title = 'Associate Professor'
AND sa.amount > 60000;

-- Sub-Queries with 5 Tables

-- 1. Find students with marks greater than the average marks in a department, faculty, and salary range

SELECT s.student_name, m.marks_obtained, d.department_name, f.faculty_name, s.amount
FROM students s
JOIN marks m ON s.student_id = m.student_id
JOIN department d ON s.department_id = d.department_id
JOIN faculty f ON d.faculty_id = f.faculty_id
JOIN salary s ON f.faculty_id = s.faculty_id
WHERE m.marks_obtained > (SELECT AVG(marks_obtained) FROM marks 
WHERE department_id = d.department_id AND faculty_id = f.faculty_id AND amount BETWEEN 50000 AND 100000);

-- 2. Find faculty with salary greater than the average salary in a department, faculty, and student count
SELECT f.faculty_name, s.amount, d.department_name, f.faculty_name, COUNT(s.student_id) AS student_count
FROM faculty f
JOIN salary s ON f.faculty_id = s.faculty_id
JOIN department d ON f.department_id = d.department_id
JOIN students s ON d.department_id = s.department_id
WHERE s.amount > (SELECT AVG(amount) FROM salary 
WHERE department_id = d.department_id AND faculty_id = f.faculty_id AND student_count > 10);

-- 3. Find students who scored above the average marks in their department, are taught by faculty members 
-- with a specific title, and belong to a specific salary range
SELECT s.student_name, m.marks_obtained, d.department_name, f.faculty_name, sa.amount
FROM students s
JOIN marks m ON s.student_id = m.student_id
JOIN department d ON s.department_id = d.department_id
JOIN faculty f ON d.faculty_id = f.faculty_id
JOIN salary sa ON f.faculty_id = sa.faculty_id
WHERE m.marks_obtained > (SELECT AVG(marks_obtained) FROM marks m2 
                           JOIN students s2 ON m2.student_id = s2.student_id 
                           WHERE s2.department_id = d.department_id)
AND f.title = 'Professor'
AND sa.amount BETWEEN 70000 AND 120000;

-- 4. Find faculty members who earn less than the minimum salary in their department, have students 
-- with low marks, and are from a specific department
SELECT f.faculty_name, s.amount, d.department_name
FROM faculty f
JOIN salary s ON f.faculty_id = s.faculty_id
JOIN department d ON f.department_id = d.department_id
WHERE s.amount < (SELECT MIN(amount) FROM salary s2 
                   JOIN faculty f2 ON s2.faculty_id = f2.faculty_id 
                   WHERE f2.department_id = d.department_id)
AND EXISTS (SELECT 1 FROM students s3 
            JOIN marks m ON s3.student_id = m.student_id 
            WHERE s3.faculty_id = f.faculty_id AND m.marks_obtained < 40)
AND d.department_name = 'Mathematics';

-- 5. Find students who scored above the average marks in their department, are supervised by faculty 
-- members with a specific title, and have faculty members earning above a certain salary
SELECT s.student_name, m.marks_obtained, d.department_name, f.faculty_name, sa.amount
FROM students s
JOIN marks m ON s.student_id = m.student_id
JOIN department d ON s.department_id = d.department_id
JOIN faculty f ON d.faculty_id = f.faculty_id
JOIN salary sa ON f.faculty_id = sa.faculty_id
WHERE m.marks_obtained > (SELECT AVG(marks_obtained) FROM marks m2 
                           JOIN students s2 ON m2.student_id = s2.student_id 
                           WHERE s2.department_id = d.department_id)
AND f.title = 'Associate Professor'
AND sa.amount > 80000;

-- 6. Find faculty members who earn more than the average salary in their department and have students 
-- with high marks, while also being from a specific department
SELECT f.faculty_name, s.amount, d.department_name
FROM faculty f
JOIN salary s ON f.faculty_id = s.faculty_id
JOIN department d ON f.department_id = d.department_id
WHERE s.amount > (SELECT AVG(amount) FROM salary s2 
                   JOIN faculty f2 ON s2.faculty_id = f2.faculty_id 
                   WHERE f2.department_id = d.department_id)
AND EXISTS (SELECT 1 FROM students s3 
            JOIN marks m ON s3.student_id = m.student_id 
            WHERE s3.department_id = d.department_id AND m.marks_obtained > 85)
AND d.department_name = 'Computer Science';

-- 7. Find students who scored above the highest mark in a specific subject, belong to a specific department, 
-- and are taught by faculty members with a specific title and salary range
SELECT s.student_name, m.marks_obtained, d.department_name, f.faculty_name, sa.amount
FROM students s
JOIN marks m ON s.student_id = m.student_id
JOIN department d ON s.department_id = d.department_id
JOIN faculty f ON d.faculty_id = f.faculty_id
JOIN salary sa ON f.faculty_id = sa.faculty_id
WHERE m.marks_obtained > (SELECT MAX(marks_obtained) FROM marks WHERE subject_name = 'Mathematics')
AND d.department_name = 'Engineering'
AND f.title = 'Professor'
AND sa.amount BETWEEN 60000 AND 100000;


-- Multiple types of Subqueries

-- 1. Single Row Subqueries
-- A single-row subquery returns only one row and can be used with comparison operators.
-- Example: Find students who scored more than the highest mark in a specific subject.
SELECT s.student_name, m.marks_obtained
FROM students s
JOIN marks m ON s.student_id = m.student_id
WHERE m.marks_obtained > (SELECT MAX(marks_obtained) FROM marks WHERE subject_name = 'Mathematics');


-- 2. Multi-row Subqueries
-- A multi-row subquery returns multiple rows and is typically used with operators 
-- like IN, ANY, or ALL.
-- Example: Find students who scored above the average marks of all students.
SELECT s.student_name, m.marks_obtained
FROM students s
JOIN marks m ON s.student_id = m.student_id
WHERE m.marks_obtained > (SELECT AVG(marks_obtained) FROM marks);


-- 3. Correlated Subqueries
-- A correlated subquery references columns from the outer query and is executed 
-- for each row processed by the outer query.
-- Example: Find students who scored above the average marks in their department.
SELECT s.student_name, m.marks_obtained, d.department_name
FROM students s
JOIN marks m ON s.student_id = m.student_id
JOIN department d ON s.department_id = d.department_id
WHERE m.marks_obtained > (SELECT AVG(marks_obtained) 
                           FROM marks m2 
                           JOIN students s2 ON m2.student_id = s2.student_id 
                           WHERE s2.department_id = d.department_id);
                           

-- 4. Using IN Operator
-- The IN operator allows you to specify multiple values in a WHERE clause.
-- Example: Find students who scored in the top 10 marks in any subject.
SELECT s.student_name, m.marks_obtained
FROM students s
JOIN marks m ON s.student_id = m.student_id
WHERE m.marks_obtained IN (SELECT marks_obtained 
                            FROM marks 
                            ORDER BY marks_obtained DESC 
                            LIMIT 10);


-- 5. Using EXISTS Operator
-- The EXISTS operator checks for the existence of rows returned by a subquery.
-- Example: Find faculty members who have students with low marks.
SELECT f.faculty_name
FROM faculty f
WHERE EXISTS (SELECT 1 
              FROM students s 
              JOIN marks m ON s.student_id = m.student_id 
              WHERE s.faculty_id = f.faculty_id AND m.marks_obtained < 40);


-- 6. Using ANY Operator
-- The ANY operator compares a value to each value returned by the subquery and 
-- returns true if any comparison is true.
-- Example: Find students who scored more than any student in a specific department.
SELECT s.student_name, m.marks_obtained
FROM students s
JOIN marks m ON s.student_id = m.student_id
WHERE m.marks_obtained > ANY (SELECT m2.marks_obtained 
                               FROM marks m2 
                               JOIN students s2 ON m2.student_id = s2.student_id 
                               WHERE s2.department_id = 'Computer Science');


-- 7. Using ALL Operator
-- The ALL operator compares a value to all values returned by the subquery and 
-- returns true if the comparison is true for all values.
-- Example: Find students who scored more than all students in a specific subject.
SELECT s.student_name, m.marks_obtained
FROM students s
JOIN marks m ON s.student_id = m.student_id
WHERE m.marks_obtained > ALL (SELECT m2.marks_obtained 
                               FROM marks m2 
                               WHERE m2.subject_name = 'Mathematics');
                               
                               
