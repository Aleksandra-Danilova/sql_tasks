--most of the employees: those who are assigned to the department and do not receive the maximum salary
WITH salary_ranc AS (
    SELECT
        e.employee_id,
        COUNT(c.salary) + 1 AS s_ranc -- calculate how many salaries of colleagues with a larger amount than that of this employee, and take into account the employee himself/herself
    FROM employees e
        JOIN employees c ON e.department_id = c.department_id
    WHERE
        e.salary < c.salary -- exclude employees with the maximum salary of the department and duplicates
    GROUP BY e.department_id, e.employee_id
)
     
SELECT
    nvl(TO_CHAR(e.department_id),' ') AS department_id,
    e.last_name,
    nvl(TO_CHAR(e.salary), ' ') AS salary,
    CASE
            -- is not assigned to the department or does not receive a salary
            WHEN sr.s_ranc IS NULL
                 AND (e.department_id IS NULL OR e.salary IS NULL) THEN nvl(TO_CHAR(sr.s_ranc),' ')
            -- maximum salary by department
            WHEN sr.s_ranc IS NULL
                 AND e.department_id IS NOT NULL THEN TO_CHAR(nvl(sr.s_ranc,1) )            
            ELSE TO_CHAR(sr.s_ranc)
        END
    AS salary_ranc
  FROM employees e
    LEFT JOIN salary_ranc sr ON e.employee_id = sr.employee_id
ORDER BY e.department_id, e.salary DESC;
