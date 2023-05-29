-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

CREATE TABLE "salaries" (
    "emp_no" varchar (30)  NOT NULL,
    "salary" int   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"));

--check the data from salaries got imported correctly
select * from salaries;

CREATE TABLE "titles" (
    "title_id" varchar (30)  NOT NULL,
    "title" varchar (30)  NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"));
		
--check the data from titles got imported correctly
select * from titles;

CREATE TABLE "department" (
    "dept_no" varchar (30)  NOT NULL,
    "dept_name" varchar (30)  NOT NULL,
    CONSTRAINT "pk_department" PRIMARY KEY (
        "dept_no"));

--check the data from department got imported correctly
select * from department;

CREATE TABLE "dept_emp" (
    "emp_no" varchar (30)  NOT NULL,
    "dept_no" varchar (30)  NOT NULL);
		
--check the data from dept_emp got imported correctly
select * from dept_emp;

CREATE TABLE "employees" (
    "emp_no" varchar (30)  NOT NULL,
    "emp_title_id" varchar  (30) NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar (30)  NOT NULL,
    "last_name" varchar (30)  NOT NULL,
    "sex" varchar (30)  NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"));

--check the data from employees got imported correctly
select * from employees;		

CREATE TABLE "dept_manager" (
    "dept_no" varchar (30)  NOT NULL,
    "emp_no" varchar (30)  NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "emp_no"));

--check the data from dept_manager got imported correctly 
select * from dept_manager

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "salaries" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "department" ("dept_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_no" FOREIGN KEY("emp_no")
REFERENCES "dept_emp" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "department" ("dept_no");

--List the employee number, last name, first name, sex, and salary of each employee
Select e.emp_no, e.last_name, e.first_name, e.sex, s.salary
From employees as e
Join salaries as s
on e.emp_no = s.emp_no;

--List the first name, last name, and hire date for the employees who were hired in 1986.
Select first_name, last_name, hire_date
From employees
Where hire_date >='01/01/1986'

--List the manager of each department along with their department number, department name, employee number,
--last name, and first name.
Select d.dept_no,
	d.dept_name, 
	dm.emp_no, 
	e.last_name,
	e.first_name
From department as d
Join dept_manager as dm
on d.dept_no = dm.dept_no
Join employees as e
on dm.emp_no = e.emp_no;

--List the department number for each employee along with that employee’s employee number, last name,
--first name, and department name.
Select e.emp_no, 
	e.last_name, 
	e.first_name, 
	de.dept_no, 
	d.dept_name
From employees as e
Join dept_emp as de
on e.emp_no = de.emp_no
Join department as d
on de.dept_no = d.dept_no;

--List first name, last name, and sex of each employee whose first name is Hercules 
--and whose last name begins with the letter B.
select first_name,
	last_name,
	sex 
From employees
Where first_name = 'Hercules'
AND last_name LIKE 'B%';

--List each employee in the Sales department, including their employee number, last name, and first name.
Select e.emp_no,
	e.last_name, 
	e.first_name
From employees as e
Join dept_emp as de
on e.emp_no = de.emp_no
Join department as d
on de.dept_no = d.dept_no
Where d.dept_name = 'Sales';

--List each employee in the Sales and Development departments, including their employee number, 
--last name, first name, and department name.
Select e.emp_no,
	e.last_name, 
	e.first_name,
	d.dept_name
From employees as e
Join dept_emp as de
on e.emp_no = de.emp_no
Join department as d
on de.dept_no = d.dept_no
Where d.dept_name = 'Sales' OR d.dept_name = 'Development';

--List the frequency counts, in descending order, of all the employee last names
--(that is, how many employees share each last name).
Select last_name,
	count (last_name) AS "Sum of Last Name"
From employees
Group by last_name
Order by "Sum of Last Name" desc;
