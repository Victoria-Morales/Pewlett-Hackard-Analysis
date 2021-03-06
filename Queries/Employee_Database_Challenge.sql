-- Create retirement titles table
SELECT e.emp_no, 
	e.first_name,
	e.last_name,
	tl.title,
	tl.from_date,
	tl.to_date
INTO retirement_titles
FROM employees As e
INNER JOIN titles as tl
ON e.emp_no = tl.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;



-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,	
	rt.title
INTO unique_titles
FROM retirement_titles as rt
ORDER BY rt.emp_no, rt.to_date DESC;

-- Obtain count of retirement titles
SELECT
   COUNT(ut.title)
FROM
   unique_titles as ut;
   
-- Create table with retirement count by title
SELECT COUNT (ut.title), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT DESC;

-- Create Mentorship eligibility table
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	tl.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as tl
ON (e.emp_no = tl.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;



-- Additional queries/tables for summary questions part 3 deliverable
-- Obtain count of mentorship eligible employees
SELECT
   COUNT(me.title)
FROM
	unique_titles as me;

SELECT * FROM unique_titles;

-- Create table with mentorship eligibility by title
SELECT COUNT (me.title), me.title
INTO mentorship_count
FROM mentorship_eligibility as me
GROUP BY me.title
ORDER BY COUNT DESC;