-- Deliverable 1 

-- Create a Retirement Titles table that holds all titles of current employees potentially eligible for retirement

-- Retrieve the emp_no, first_name, and last_name columns from the Employees table
SELECT emp_no, first_name, last_name
FROM employees AS _e;

-- Retrieve the title, from_date, and to_date columns from the Titles table
SELECT title, from_date, to_date
FROM titles AS _t;


-- Create a new table using the INTO clause, join both tables on the primary key
-- Filter data on the birth_date column to retrieve the employees who were born between 1952 and 1955
-- Then order by employee number
DROP TABLE IF EXISTS retirement_titles;

SELECT _e.emp_no, _e.first_name, _e.last_name, _t.title, _t.from_date, _t.to_date
INTO retirement_titles
FROM employees AS _e
INNER JOIN titles AS _t
ON _e.emp_no = _t.emp_no
WHERE (_e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

SELECT * FROM retirement_titles;


-- Use Dictinct with Orderby to remove duplicate rows
-- Retrieve employee number, first and last name, and title columns from retirement titles table
-- Use DISTINCT ON to retrieve first occurence of the employee number for each set of rows defined by the ON() clause
-- create a table using the INTO clause, named Unique Titles
-- sort the table in ascending order by employee number and descending order by last date of most recent title
DROP TABLE IF EXISTS unique_titles;

SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

SELECT * FROM unique_titles;


-- Retrieve the number of employees by their most recent job title who are about to retire
-- First, retrieve number of titles from unique titles table
-- Then create a table called Retiring Titles
-- Group the table by title, then sort the count column descending order
DROP TABLE IF EXISTS retiring_titles;

SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

SELECT * FROM retiring_titles;


-- Deliverable 2

-- Create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program

-- Retrieve the emp_no, first_name, last_name, and birth_date columns from the Employees table
-- Retrieve the from_date and to_date columns from the Department Employee table
-- Retrieve the title column from the Titles table
-- Use DISTINCT ON to retrieve the first occurence of the emp no
-- Create a new table using the INTO clause
-- Join the employees and the dept employee tables on the primary key
-- Join the employees and the titles table on the primary key
-- Filter the data on the to_date column to all the current employees
-- Then filter the data on the birth_date columns to get all the employees whose birth dates are between 1/1/65 and 12/31/65
-- Order the table by emp no 

DROP TABLE IF EXISTS mentorship_eligibility;

SELECT DISTINCT ON (_e.emp_no) _e.emp_no, _e.first_name, _e.last_name, _e.birth_date, _d.from_date, _d.to_date, _t.title
INTO mentorship_eligibility
FROM ((employees AS _e  
INNER JOIN dept_emp AS _d ON _e.emp_no = _d.emp_no)
INNER JOIN titles AS _t ON _e.emp_no = _t.emp_no)
WHERE _t.to_date = '9999-01-01' AND (_e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;

SELECT * FROM mentorship_eligibility;