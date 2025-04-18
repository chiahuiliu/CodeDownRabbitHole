-- 1. WHERE vs HAVING
-- WHERE filters before grouping
SELECT department, COUNT(*) 
FROM employees 
WHERE salary > 50000 
GROUP BY department;

-- HAVING filters after grouping
SELECT department, COUNT(*) 
FROM employees 
GROUP BY department 
HAVING COUNT(*) > 5;

-- 2. Find duplicate records
SELECT name, COUNT(*) 
FROM customers 
GROUP BY name 
HAVING COUNT(*) > 1;

-- 3. JOIN Types
SELECT * FROM A 
INNER JOIN B ON A.id = B.id;

SELECT * FROM A 
LEFT JOIN B ON A.id = B.id;

SELECT * FROM A 
RIGHT JOIN B ON A.id = B.id;

SELECT * FROM A 
FULL OUTER JOIN B ON A.id = B.id;

-- 4. 2nd Highest Salary
SELECT MAX(salary) 
FROM employees 
WHERE salary < (
    SELECT MAX(salary) FROM employees
);

-- 5. Remove duplicates
DELETE FROM customers
WHERE id NOT IN (
  SELECT MIN(id)
  FROM customers
  GROUP BY email
);

-- 6. CTE
WITH department_counts AS (
  SELECT department, COUNT(*) AS total
  FROM employees
  GROUP BY department
)
SELECT * 
FROM department_counts
WHERE total > 10;

-- 7. Rank rows
SELECT name, department, salary,
  RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank
FROM employees;

-- 8. UNION vs UNION ALL
SELECT city FROM customers
UNION
SELECT city FROM vendors;

SELECT city FROM customers
UNION ALL
SELECT city FROM vendors;

-- 9. Update table from another
UPDATE A
SET A.salary = B.salary
FROM A
JOIN B ON A.id = B.id;

-- 10. Nth Highest Salary using DENSE_RANK()
WITH ranked_salaries AS (
  SELECT name, salary,
    DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
  FROM employees
)
SELECT name, salary
FROM ranked_salaries
WHERE rnk = 3;
