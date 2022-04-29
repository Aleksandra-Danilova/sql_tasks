SELECT
        CASE
            WHEN GROUPING(e.last_name) = 0 THEN TO_CHAR(e.row_num) --since ROLLUP was used for composite columns, it is enough to use one GROUPING
            ELSE ' '
        END 
    AS "Serial number",
        CASE
            WHEN GROUPING(e.last_name) = 0 THEN TO_CHAR(d.department_id) 
            WHEN GROUPING(d.department_id) = 1 THEN 'Total number of employees in departments'
            ELSE 'Number of employees in the department'
        END
    AS "Department ID",
        nvl(department_name, ' ') AS "Department name", --NVL - when displaying the total number of employees in departments
        CASE
            WHEN GROUPING(e.last_name) = 0 THEN LTRIM(nvl(e.first_name, '') || ' ' || e.last_name) --remove the space if the employee does not have a name
            ELSE TO_CHAR(COUNT(e.last_name)) 
        END
    AS "Employee"
FROM
    departments d 
    JOIN (
        SELECT --select the sorted data together with the ROWNUM pseudo column for the "Serial number" column
            e.first_name, e.last_name, e.department_id, ROWNUM AS row_num
        FROM
            (
            --sort the data from both tables by department name, first and last name of the employee
                (SELECT e.first_name, e.last_name, e.department_id   
                FROM
                    employees e
                    JOIN departments d ON e.department_id = d.department_id
                ORDER BY
                    d.department_name,
                    e.first_name,
                    e.last_name) e
            ) 
    ) e ON d.department_id = e.department_id 
GROUP BY
    ROLLUP(
        (d.department_id, d.department_name),
        (e.first_name, e.last_name, e.row_num)
    ) --using ROLLUP for composite columns
ORDER BY
    d.department_name,
    e.first_name,
    e.last_name; --sorting by department name, employee's first and last name
