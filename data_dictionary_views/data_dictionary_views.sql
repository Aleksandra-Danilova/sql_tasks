SELECT
    ucc.table_name || '.' || ucc.column_name AS "CUST.FK",
    ucc2.table_name || '.' || ucc2.column_name AS "SUPP.PK",
    COUNT(DISTINCT utpm.grantee) AS us_del_cnt, --amount of users who have privilege to delete rows from the main table
    nvl(uc.delete_rule, ' ') AS del_rule --rule for deleting rows
FROM
    user_constraints uc
    JOIN user_cons_columns ucc ON uc.constraint_name = ucc.constraint_name --define a FK (child table)
    JOIN user_cons_columns ucc2 ON uc.r_constraint_name = ucc2.constraint_name --define PK (main table)
                                   AND ucc.position = ucc2.position
    LEFT JOIN user_tab_privs_made utpm ON ucc2.table_name = utpm.table_name
WHERE
    uc.constraint_type = 'R'
GROUP BY 
    uc.constraint_type,
    ucc.table_name || '.' || ucc.column_name,
    ucc2.table_name || '.' || ucc2.column_name,
    uc.delete_rule;
