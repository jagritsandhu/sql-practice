-- Create a table
CREATE TABLE employees (
  id INTEGER PRIMARY KEY,
  name TEXT,
  department TEXT,
  salary INTEGER
);

-- Insert data
INSERT INTO employees VALUES (1, 'Alice', 'Engineering', 90000);
INSERT INTO employees VALUES (2, 'Bob', 'HR', 60000);
INSERT INTO employees VALUES (3, 'Charlie', 'Engineering', 85000);
INSERT INTO employees VALUES (4, 'Dana', 'Marketing', 70000);

-- Query: Get all employees
SELECT * FROM employees;

-- Query: Engineering employees
SELECT name, salary FROM employees WHERE department = 'Engineering';

-- Query: Sorted by salary
SELECT * FROM employees ORDER BY salary DESC;
