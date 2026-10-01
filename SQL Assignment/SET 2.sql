-- 1. Create the new database container
CREATE DATABASE school_management;

-- 2. Switch to the new database
USE school_management;

-- 3. Create tables specific to this new domain
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    enrollment_date DATE
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT
);

USE school_management;

-- Create the employees table for this database
CREATE TABLE employees (
    emp_no INT PRIMARY KEY,
    birth_date DATE,
    first_name VARCHAR(14),
    last_name VARCHAR(16),
    hire_date DATE
);

INSERT INTO employees (emp_no, birth_date, first_name, last_name, hire_date) 
VALUES 
(102, '1990-01-20', 'Alice', 'Smith', '2020-03-15'),
(103, '1988-11-05', 'Bob', 'Johnson', '2019-07-22'),
(104, '1995-04-12', 'Charlie', 'Davis', '2022-01-10'),
(105, '1992-09-30', 'Diana', 'Wilson', '2021-11-05'),
(106, '1989-12-18', 'Evan', 'Brown', '2023-05-19');

USE school_management;

-- Salaries table
CREATE TABLE salaries (
    emp_no INT,
    salary INT,
    from_date DATE,
    to_date DATE,
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

-- Titles/Roles table
CREATE TABLE titles (
    emp_no INT,
    title VARCHAR(50),
    from_date DATE,
    to_date DATE,
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

-- Department/Class Assignments
CREATE TABLE dept_emp (
    emp_no INT,
    dept_no VARCHAR(10),
    from_date DATE,
    to_date DATE,
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

SELECT emp_no, MAX(salary) FROM salaries GROUP BY emp_no;
SELECT dept_no, COUNT(emp_no) FROM dept_emp GROUP BY dept_no;
SELECT * FROM dept_emp WHERE to_date = '9999-01-01';
SELECT COUNT(emp_no) FROM titles WHERE title = 'Manager';
SELECT emp_no FROM dept_emp GROUP BY emp_no HAVING COUNT(DISTINCT dept_no) > 1;
SELECT DISTINCT emp_no FROM salaries WHERE salary < 40000;
SELECT emp_no, title FROM titles GROUP BY emp_no, title HAVING COUNT(*) > 1;
SHOW TABLES;
DESCRIBE employees;
DESCRIBE salaries;
SELECT * FROM employees;