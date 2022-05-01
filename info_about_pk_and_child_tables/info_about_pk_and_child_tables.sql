WITH
tables_without_pk AS ( -- among all the tables that have constraints, we leave those where there are any other than the primary key
    SELECT ut.table_name 
    FROM user_tables ut JOIN user_constraints uc ON ut.table_name = uc.table_name
        JOIN user_cons_columns ucc ON uc.constraint_name = ucc.constraint_name
    GROUP BY ut.table_name, uc.constraint_type
    MINUS
    SELECT ut.table_name
    FROM user_tables ut JOIN user_constraints uc ON ut.table_name = uc.table_name
        JOIN user_cons_columns ucc ON uc.constraint_name = ucc.constraint_name
    WHERE uc.constraint_type = 'P'
    GROUP BY ut.table_name, uc.constraint_type),
table_pk AS ( -- define the primary key columns for the user schema tables by alphabetically sorting the tables (for faster visual verification) and their primary keys
    SELECT DISTINCT(ut.table_name || ucc.column_name) AS doubles, ut.table_name AS tab_name, ucc.column_name AS pk
    FROM user_tables ut
    LEFT JOIN user_constraints uc
    ON ut.table_name = uc.table_name
    LEFT JOIN user_cons_columns ucc
    ON uc.constraint_name = ucc.constraint_name
    WHERE uc.constraint_type = 'P' OR uc.constraint_type IS NULL OR ut.table_name IN (SELECT * FROM tables_without_pk) -- also, it is needed to take into account that the table can be without any constraints or with some, but not with the primary key
    ORDER BY tab_name, pk),
group_pk_by_tab AS (-- implement the numbering of the primary keys within the corresponding tables, this will be needed for further transformations from column to row
    SELECT ROW_NUMBER() OVER (PARTITION BY tab_name ORDER BY tab_name, pk) AS r, tab_name, pk
    FROM table_pk),   
pk_to_str AS ( -- combine the primary keys of the tables into one row using the SYS_CONNECT_BY_PATH function
    SELECT tab_name, LTRIM(SYS_CONNECT_BY_PATH(pk, ','), ',') AS pk
    FROM group_pk_by_tab
    WHERE CONNECT_BY_ISLEAF = 1
    START WITH r = 1
    CONNECT BY tab_name = PRIOR tab_name AND r = PRIOR r + 1),
-- now perform similar operations for child tables
child_table AS ( -- define child tables for each table by alphabetically sorting the parent and child tables
    SELECT DISTINCT ucc.table_name AS tab_name, uc.table_name AS child_tab
    FROM user_constraints uc
    JOIN user_cons_columns ucc
    ON uc.r_constraint_name = ucc.constraint_name
    WHERE uc.constraint_type = 'R'
    ORDER BY tab_name, child_tab),
group_childs_by_parent AS ( -- implement the numbering of child tables within the corresponding parent ones, this will be needed for further transformations from column to row
    SELECT ROW_NUMBER() OVER (PARTITION BY tab_name ORDER BY tab_name, child_tab) AS r, tab_name, child_tab
    FROM child_table),
child_to_str AS ( -- combine the child tables into one row using the SYS_CONNECT_BY_PATH function
    SELECT tab_name, LTRIM(SYS_CONNECT_BY_PATH(child_tab, ','), ',') AS child_tab
    FROM group_childs_by_parent
    WHERE CONNECT_BY_ISLEAF = 1
    START WITH r = 1
    CONNECT BY tab_name = PRIOR tab_name AND r = PRIOR r + 1)
-- output all columns according to the condition of the problem
-- if there is no primary key or child tables, then display the corresponding message
SELECT p.tab_name AS "Table name", NVL(p.pk, 'No primary key') AS "List of PK columns", NVL(c.child_tab, 'No child tables') AS "List of child tables"
FROM pk_to_str p
LEFT JOIN child_to_str c
ON p.tab_name = c.tab_name;
