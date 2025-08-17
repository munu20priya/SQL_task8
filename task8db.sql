USE TechCompany;
DROP PROCEDURE IF EXISTS GetEmployeesByDept;
                    -- 1. Stored Procedure
-- Stored procedure to get the employees by Department name
DELIMITER //
CREATE PROCEDURE GetEmployeesByDept(IN deptName VARCHAR(50))
BEGIN
    SELECT e.emp_name, e.salary, d.dept_name, e.hire_date
    FROM Employee e
    JOIN Department d ON e.department_id = d.dept_id
    WHERE d.dept_name = deptName;
END //
DELIMITER ;

-- Calling the stored procedure = GetEmployeesByDept('')
CALL GetEmployeesByDept('IT');
CALL GetEmployeesByDept('HR');

                  -- 2. Stored Procedure
-- Stored procedure to get the Employees with Salary Above a Given Amount
DELIMITER //
CREATE PROCEDURE GetHighSalaryEmployees(IN minSalary DECIMAL(10,2))
BEGIN
    SELECT e.emp_name, e.salary, d.dept_name
    FROM Employee e
    JOIN Department d ON e.department_id = d.dept_id
    WHERE e.salary > minSalary
    ORDER BY e.salary DESC;
END //
DELIMITER ;

-- Calling the stored procedure = GetHighSalaryEmployees(  )
CALL GetHighSalaryEmployees(55000);
CALL GetHighSalaryEmployees(65000);


                     -- 1. Stored Function
-- Stored function to calculate the Experience of Employees in Years
DROP FUNCTION IF EXISTS GetExperience;
DELIMITER //
CREATE FUNCTION GetExperience(hire_date DATE)
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    RETURN ROUND(DATEDIFF(CURDATE(), hire_date) / 365, 2);
END //
DELIMITER ;

-- Using the stored function = ' GetExperience(hire_date)'
SELECT emp_name, hire_date, GetExperience(hire_date) AS years_experience
FROM Employee;

                     -- 2. Stored Function
-- Stored function to calculate the Annual salary of Employees 
DELIMITER //
CREATE FUNCTION GetAnnualSalary(monthly_salary DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN monthly_salary * 12;
END //
DELIMITER ;

-- Using the stored function = ' GetAnnualSalary(salary / 12)'
SELECT emp_name, salary, GetAnnualSalary(salary / 12) AS annual_salary
FROM Employee;