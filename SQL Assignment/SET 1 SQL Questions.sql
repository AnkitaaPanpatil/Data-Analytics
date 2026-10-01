CREATE DATABASE company_data;
USE company_data;
CREATE TABLE departments (
    dept_no CHAR(4) PRIMARY KEY,
    dept_name VARCHAR(40) NOT NULL
);

CREATE TABLE employees (
    emp_no INT PRIMARY KEY,
    birth_date DATE,
    first_name VARCHAR(14),
    last_name VARCHAR(16),
    hire_date DATE
);
CREATE TABLE titles (
    emp_no INT,
    title VARCHAR(50),
    from_date DATE,
    to_date DATE,
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE salaries (
    emp_no INT,
    salary INT,
    from_date DATE,
    to_date DATE,
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE dept_emp (
    emp_no INT,
    dept_no CHAR(4),
    from_date DATE,
    to_date DATE,
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

-- Add a department
INSERT INTO departments (dept_no, dept_name) VALUES ('d001', 'Sales');

-- Add an employee
INSERT INTO employees (emp_no, birth_date, first_name, last_name, hire_date) 
VALUES (101, '1985-05-15', 'John', 'Doe', '2005-06-01');

-- Add department employee link
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date) 
VALUES (101, 'd001', '2005-06-01', '9999-01-01');

-- Add salary
INSERT INTO salaries (emp_no, salary, from_date, to_date) 
VALUES (101, 60000, '2005-06-01', '9999-01-01');

-- Add title
INSERT INTO titles (emp_no, title, from_date, to_date) 
VALUES (101, 'Senior Engineer', '2005-06-01', '9999-01-01');

SELECT first_name, last_name FROM employees;
SELECT * FROM departments WHERE dept_name = 'Sales';
SELECT DISTINCT title FROM titles;
SELECT de.emp_no, de.from_date, de.to_date FROM dept_emp de JOIN departments d ON de.dept_no = d.dept_no WHERE d.dept_name = 'Sales';
SELECT emp_no, dept_no FROM dept_emp;
SELECT birth_date FROM employees WHERE first_name = 'John';
CREATE TABLE dept_manager (
    dept_no CHAR(4),
    emp_no INT,
    from_date DATE,
    to_date DATE,
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

INSERT INTO dept_manager (dept_no, emp_no, from_date, to_date)
VALUES ('d001', 101, '2026-06-17', '9999-01-01');

SELECT * FROM dept_manager;
SELECT emp_no, title FROM titles WHERE title LIKE 'Senior%';
SELECT emp_no, salary FROM salaries WHERE salary > 50000;
SELECT * FROM employees WHERE hire_date > '2000-01-01';

INSERT INTO employees (emp_no, birth_date, first_name, last_name, hire_date) 
VALUES 
(102, '1990-01-20', 'Alice', 'Smith', '2020-03-15'),
(103, '1988-11-05', 'Bob', 'Johnson', '2019-07-22'),
(104, '1995-04-12', 'Charlie', 'Davis', '2022-01-10'),
(105, '1992-09-30', 'Diana', 'Wilson', '2021-11-05'),
(106, '1989-12-18', 'Evan', 'Brown', '2023-05-19');

SELECT * FROM employees;