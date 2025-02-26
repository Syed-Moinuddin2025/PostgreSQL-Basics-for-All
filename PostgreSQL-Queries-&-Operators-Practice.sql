-- Active: 1738588937501@@127.0.0.1@5432@company@public
DROP TABLE IF EXISTS employees;

CREATE TABLE employees(
	employee_id	INT	PRIMARY KEY,
	first_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(20) NOT NULL,
	email VARCHAR(50),	
	department VARCHAR(20),	
	salary NUMERIC(10,2),	
	joining_date DATE,	
	age INT	
);

SELECT * FROM employees;

COPY
employees(employee_id, first_name, last_name, email, department, salary, joining_date, age)
FROM 'D:\GiHubProjects\PostgreSQL-Basics-for-All\CSV files & Docx\employees_data_Queries-Operators.csv'
DELIMITER','
CSV HEADER;

SELECT * FROM employees ORDER BY employee_id ASC;
-- Refined and ordered queries for the table 'employees'

-- 1. Retrieve all employees’ first_name and their departments.
SELECT first_name, department
FROM employees;

-- 2. Update the salary of all employees in the 'IT' department by increasing it by 5%.
UPDATE employees 
SET salary = salary +(salary * 1.05)
WHERE department = 'IT';

-- 3. Retrieve the names of employees who joined after January 1, 2021.
SELECT first_name, joining_date FROM employees
WHERE joining_date > '2021-01-01';
 
-- 4. List all employees with their age and salary in descending order of salary.
SELECT first_name, age, salary 
FROM employees
ORDER BY salary DESC;

-- 5. Insert a new employee with the following details: (employee_id, 'Raj', 'Singh', 'Marketing', 60000, '2023-09-15', 30, email).
INSERT INTO employees (employee_id, first_name, last_name, department, salary, joining_date, age, email) 
VALUES (1001, 'Raj', 'Singh', 'Marketing', 60000, '2023-09-15', 30, NULL);

-- 6. Update age of employee +1 to every employee.
UPDATE employees 
SET age = age + 1;

-- 7. Find all employees who joined after 2022-01-01.
SELECT * FROM employees 
WHERE joining_date > '2022-01-01';

-- 8. Find the average salary of employees in each department.
SELECT department, ROUND(AVG(salary),2) AS average_salary 
FROM employees
GROUP BY department;

-- 9. Find employees who are older than 35 years.
SELECT * FROM employees
WHERE age > 35;

-- 10. Find the highest salary in the IT department.
SELECT MAX(salary) AS highest_salary
FROM employees
WHERE department = 'IT';

SELECT first_name , salary,department
FROM employees
WHERE department = 'IT'
AND salary = (SELECT MAX(salary) FROM employees WHERE department = 'IT')

-- 11. Update the email column for all employees with appropriate values.
UPDATE employees
SET email = CONCAT(first_name, '.', last_name, '@example.com');

-- 12. Find the total number of employees in each department.
SELECT department, COUNT(*) AS total_employees 
FROM employees 
GROUP BY department;

-- 13. Sort employees by their joining_date from the newest to the oldest.
SELECT * FROM employees
ORDER BY joining_date DESC;

-- 14. Retrieve employees whose salary is between 50,000 and 70,000.
SELECT * FROM employees
WHERE salary BETWEEN 50000 AND 70000;

-- 15. Find employees who have 'a' in their first name.
SELECT * FROM employees
WHERE first_name LIKE '%a%';

-- 16. Count the total number of employees in the table.
SELECT COUNT(*) AS total_employees 
FROM employees;

-- 17. Retrieve employees grouped by their department, sorted by department name.
SELECT department, COUNT(*) AS total_employees
FROM employees
GROUP BY department
ORDER BY department;

-- 18. Find employees who joined in the year 2024.
SELECT * FROM employees 
WHERE EXTRACT(YEAR FROM joining_date) = 2024;

-- 19. Retrieve the minimum salary in the company.
SELECT MIN(salary) AS minimum_salary 
FROM employees;

-- 20. Retrieve employees whose age is NULL.
SELECT * FROM employees WHERE age IS NULL;

-- 21. Retrieve the first name, last name, and salary of employees earning more than the average salary.
SELECT first_name, last_name, salary FROM employees 
WHERE salary > (SELECT AVG(salary) FROM employees);

-- 22. Count the number of employees in each department where the department name starts with 'M'.
SELECT department, COUNT(*) AS total_employees FROM employees 
WHERE department LIKE 'M%' GROUP BY department;

-- 23. Retrieve employees who do not have an email address (email is NULL).
SELECT * FROM employees WHERE email IS NULL;

-- 24. Calculate the total salary paid to employees in each department.
SELECT department, SUM(salary) AS total_salary FROM employees GROUP BY department;

-- 25. Update the department of employees whose salary is less than 30,000 to 'Trainee'.
UPDATE employees 
SET department = 'Trainee' 
WHERE salary < 30000;

-- 26. Delete employees whose joining date is before January 1, 2020.
DELETE FROM employees 
WHERE joining_date < '2020-01-01';

-- 27. Retrieve the top 5 highest-paid employees.
SELECT * FROM employees ORDER BY salary DESC LIMIT 5;

-- 28. Find the names of employees who joined in the same month, regardless of the year.
SELECT first_name, last_name FROM employees 
WHERE EXTRACT(MONTH FROM joining_date) = EXTRACT(MONTH FROM CURRENT_DATE);

-- 29. Add a new column phone_number to the employees table with a data type of VARCHAR(15).
ALTER TABLE employees ADD COLUMN phone_number VARCHAR(15);

-- 30. Update the phone_number of all employees to '1234567890'.
UPDATE employees SET phone_number = '1234567890';

-- 31. Find employees whose first name ends with the letter 'n'.
SELECT * FROM employees WHERE first_name LIKE '%n';

-- 32. Retrieve employees whose age is between 25 and 35, and salary is greater than 50,000.
SELECT * FROM employees 
WHERE age BETWEEN 25 AND 35 AND salary > 50000;

-- 33. Add a constraint to ensure that the email column in employees is unique.
ALTER TABLE employees ADD CONSTRAINT unique_email UNIQUE (email);

-- 34. Find employees who are in the 'HR' or 'Finance' department.
SELECT * FROM employees
WHERE department IN ('HR', 'Finance');

-- 35. Retrieve the second highest salary in the employees table.
SELECT MAX(salary) AS second_highest_salary FROM employees 
WHERE salary < (SELECT MAX(salary) FROM employees);

-- 36. Create a view named high_salary_employees that retrieves employees with a salary above 70,000.
CREATE VIEW high_salary_employees AS 
SELECT * FROM employees WHERE salary > 70000;

-- 37. Insert a new record into employees with NULL for the age and email columns.
INSERT INTO employees (employee_id, first_name, last_name, department, salary, joining_date, age, email) 
VALUES (employee_id, 'First', 'Last', 'department', 50000, '2025-01-01', NULL, NULL);

-- 38. Retrieve employees who joined in the last 6 months from today’s date.
SELECT * FROM employees 
WHERE joining_date >= CURRENT_DATE - INTERVAL '6 months';

SELECT COUNT(*) AS employee_count
FROM employees
WHERE joining_date >= CURRENT_DATE - INTERVAL '6 months';

SELECT *, COUNT(*) OVER () AS total_employees
FROM employees
WHERE joining_date >= CURRENT_DATE - INTERVAL '6 months';

-- 39. Update the salary of employees earning the minimum salary to 40,000.
UPDATE employees
SET salary = 40000 WHERE salary = (SELECT MIN(salary) FROM employees);

-- 40. Find employees whose last names contain exactly 5 characters.
SELECT * FROM employees WHERE LENGTH(last_name) = 5;

-- 41. Retrieve employees sorted first by department name (ascending) and then by salary (descending).
SELECT * FROM employees ORDER BY department ASC, salary DESC;

-- 42. Find the department with the maximum number of employees.
SELECT department, COUNT(*) AS total_employees FROM employees 
GROUP BY department ORDER BY total_employees DESC LIMIT 1;

-- 43. Calculate the difference in days between today’s date and each employee’s joining date.
SELECT first_name, last_name, (CURRENT_DATE - joining_date) AS days_with_company 
FROM employees;

SELECT 
    first_name, 
    last_name, 
    AGE(CURRENT_DATE, joining_date) AS time_with_company,
    DATE_PART('year', AGE(CURRENT_DATE, joining_date)) AS years_with_company
FROM employees;

SELECT 
    first_name, 
    last_name, 
    CONCAT( DATE_PART('year', AGE(CURRENT_DATE, joining_date)), ' Years ', 
       	 DATE_PART('month', AGE(CURRENT_DATE, joining_date)), ' Months'
    ) AS time_with_company
FROM employees;

-- 44. Retrieve employees whose first and last names are identical (e.g., first_name = last_name).
SELECT * FROM employees WHERE first_name = last_name;

-- 45. Create a backup table named employees_backup and copy all the data from employees.
CREATE TABLE employees_backup AS TABLE employees;

-- 46. Retrieve all employees who do not belong to the 'IT' department.
SELECT * FROM employees
WHERE department != 'IT';

-- 47. Find employees whose salary is a multiple of 5000.
SELECT * FROM employees 
WHERE salary % 5000 = 0;

-- 48. Delete duplicate rows in the employees table based on first name and last name.
DELETE FROM employees
WHERE employee_id NOT IN (SELECT MIN(employee_id) FROM employees GROUP BY first_name, last_name);

-- 49. Update the email column of all employees to include their department (e.g., john.doe@it.example.com).
UPDATE employees 
SET email = CONCAT(LOWER(first_name), '.', LOWER(last_name), '@', LOWER(department), '.example.com');

-- 50. Create an index on the salary column to improve query performance for salary-based searches.
CREATE INDEX idx_salary ON employees (salary);

SELECT * FROM pg_indexes WHERE tablename = 'employees';

--Arithmetic Operators Examples:

-- 51. Retrieve the first_name, salary, and calculate a 10% bonus on the salary.
SELECT first_name, salary, salary * 0.10 AS bonus
FROM employees;

-- 52. Retrieve the first_name, salary, and calculate the total salary after adding a 5000 bonus.
SELECT first_name, salary,
5000 AS bonus,
salary + 5000 AS total_salary
FROM employees;

-- 53. Retrieve the first_name, salary, and calculate the salary after subtracting a 2000 deduction.
SELECT first_name,
salary, salary - 2000 AS final_salary
FROM employees;

SELECT first_name,salary,
2000 AS deduction,
salary - 2000 AS final_salary
FROM employees;

-- 54. Retrieve the first_name, salary, and calculate the salary for a 20% increase in salary.
SELECT first_name, salary,
salary * 1.20 AS increased_salary
FROM employees;

SELECT 
  first_name,salary, 
  salary * 0.20 AS increase_amount, 
  salary + (salary * 0.20) AS increased_salary
FROM employees;

-- 55. Retrieve the first_name, salary, and calculate the result of dividing the salary by 2.
SELECT first_name, salary, salary / 2 AS half_salary
FROM employees;

-- 56. Retrieve the first_name, salary, and calculate the remainder when the salary is divided by 1000.
SELECT first_name, salary, salary % 1000 AS remainder
FROM employees;

-- 57. Retrieve the first_name, salary, and calculate the total salary after applying a 5% tax deduction.
SELECT first_name, salary, 
salary - (salary * 0.05) AS salary_after_tax
FROM employees;

SELECT first_name,  salary, 
salary * 0.05 AS tax_amount,
salary - (salary * 0.05) AS salary_after_tax 
FROM employees;

SELECT 
  first_name,  salary, 
  ROUND(salary - (salary * 0.05), 2) AS salary_after_tax, 
  ROUND(salary * 0.05, 2) AS tax_amount
FROM employees;

-- 58. Retrieve the first_name, salary, and calculate the difference between the salary and a fixed amount of 3000.
SELECT first_name, salary, salary - 3000 AS salary_difference
FROM employees;

-- 59. Retrieve the first_name, salary, and calculate the result of multiplying the salary by 1.1 for a 10% increase.
SELECT first_name, salary, salary * 1.1 AS new_salary
FROM employees;

-- 60. Retrieve the first_name, salary, and calculate the total salary after subtracting a 1000 penalty.
SELECT first_name, salary, salary - 1000 AS salary_after_penalty
FROM employees;

-- 61. Retrieve the first_name, salary, and calculate the result of dividing the salary by 3.
SELECT first_name, salary, salary / 3 AS third_salary
FROM employees;

-- 62. Retrieve the first_name, salary, and calculate the total salary after adding a 2000 bonus.
SELECT first_name, salary, salary + 2000 AS total_salary_with_bonus
FROM employees;

-- 63. Retrieve the first_name, salary, and calculate the remainder when the salary is divided by 1500.
SELECT first_name, salary, salary % 1500 AS remainder
FROM employees;

-- 64. Retrieve the first_name, salary, and calculate the total salary after applying a 15% bonus.
SELECT first_name, salary, salary + (salary * 0.15) AS salary_with_bonus
FROM employees;

-- 65. Retrieve the first_name, salary, and calculate the total salary after applying a 10% penalty.
SELECT first_name, salary, salary - (salary * 0.10) AS salary_after_penalty
FROM employees;

-- 66. Retrieve the first_name, salary, and calculate the result of multiplying the salary by 1.25 for a 25% increase.
SELECT first_name, salary, salary * 1.25 AS salary_increased_25_percent
FROM employees;

-- 67. Retrieve the first_name, salary, and calculate the total salary after applying a 3% deduction.
SELECT first_name, salary, salary - (salary * 0.03) AS salary_after_deduction
FROM employees;

-- 68. Retrieve the first_name, salary, and calculate the total salary after adding a 1000 bonus.
SELECT first_name, salary, salary + 1000 AS total_salary_after_bonus
FROM employees;

-- 69. Retrieve the first_name, salary, and calculate the remainder when the salary is divided by 500.
SELECT first_name, salary, salary % 500 AS remainder_division_500
FROM employees;

-- 70. Retrieve the first_name, salary, and calculate the salary for a 12% bonus.
SELECT first_name, salary, salary * 1.12 AS salary_with_12_percent_bonus
FROM employees;
-- 71. Retrieve the first_name, salary, and calculate the salary for a 12% bonus.
SELECT first_name, salary, (salary * 0.12) AS bonus, (salary + (salary * 0.12)) AS total_salary
FROM employees;

-- Comparison Operators Examples:

-- 72. Retrieve employees with salary greater than 50,000.
SELECT * FROM employees
WHERE salary > 50000;

-- 73. Retrieve employees whose age is either 25 or 30.
SELECT * FROM employees
WHERE age IN (25, 30);

-- 74. Retrieve employees whose department is either 'HR' or 'IT', and salary is greater than 45,000.
SELECT * FROM employees
WHERE department IN ('HR', 'IT') AND salary > 45000;

-- 75. Retrieve employees whose experience is between 3 and 8 years.
SELECT * FROM employees
WHERE experience BETWEEN 3 AND 8;

-- 76. Retrieve employees whose salary is not equal to 40,000.
SELECT * FROM employees
WHERE salary != 40000;

-- 77. Retrieve employees with age less than or equal to 28.
SELECT * FROM employees
WHERE age <= 28;

-- Logical Operators Examples:

-- 78. Retrieve employees who are in 'Finance' department and have more than 3 years of experience.
SELECT * FROM employees
WHERE department = 'Finance' AND experience > 3;

-- 79. Retrieve employees who are either from 'HR' department or have a salary greater than 60,000.
SELECT * FROM employees
WHERE department = 'HR' OR salary > 60000;

-- 80. Retrieve employees who are neither from 'Sales' nor 'HR' department.
SELECT * FROM employees
WHERE NOT department IN ('Sales', 'HR');

-- 81. Retrieve employees who don't have a NULL value in the address field.
SELECT * FROM employees
WHERE address IS NOT NULL;

-- 82. Retrieve employees whose salary is greater than 50,000 and age is less than 35.
SELECT * FROM employees
WHERE salary > 50000 AND age < 35;
