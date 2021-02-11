SELECT
        CASE
            WHEN GROUPING(e.last_name) = 0 THEN TO_CHAR(e.row_num) --т.к. ROLLUP применялся для составных столбцов, то достаточно использовать один GROUPING
            ELSE ' '
        END 
    AS "Номер п/п",
        CASE
            WHEN GROUPING(e.last_name) = 0 THEN TO_CHAR(d.department_id) 
            WHEN GROUPING(d.department_id) = 1 THEN 'Общее количество сотрудников в отделах'
            ELSE 'Кол-во сотрудников в отделе'
        END
    AS "Идентификатор отдела",
        nvl(department_name, ' ') AS "Название отдела", --NVL - при выводе общего количества сотрудников в отделах
        CASE
            WHEN GROUPING(e.last_name) = 0 THEN LTRIM(nvl(e.first_name, '') || ' ' || e.last_name) --удаляем пробел, если у сотрудника нет имени
            ELSE TO_CHAR(COUNT(e.last_name)) 
        END
    AS "Сотрудник"
FROM
    departments d 
    JOIN (
        SELECT --выбираем отсортированные данные вместе с псевдостолцом ROWNUM для колонки "Номер п/п"
            e.first_name, e.last_name, e.department_id, ROWNUM AS row_num
        FROM
            (
            --сортируем данные из обеих таблиц по названию отдела, имени и фамилии сотрудника
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
    ) --применяем ROLLUP для составных столбцов
ORDER BY
    d.department_name,
    e.first_name,
    e.last_name; --сортировка по названию отдела, имени и фамилии сотрудника
