DEFINE str = 'abc,cde,ef,gh,mn,test,ss,df,fw,ewe,wwe';

WITH 
--transform a row to a column
str_to_column AS ( 
    --extract comma-separated substrings from the string; 1 - position from which to search, LEVEL - number of occurrence
    SELECT REGEXP_SUBSTR('&str', '[^,]+', 1, LEVEL) AS col
    FROM dual
    CONNECT BY LEVEL <= REGEXP_COUNT('&str', ',') + 1), --there are one more levels (rows in a column) than there are commas in a row
--sort alphabetically   
alphabet_sort AS ( 
    SELECT col, ROWNUM AS r
    FROM( SELECT col
          FROM str_to_column
          WHERE REGEXP_LIKE(col, '^[[:alpha:]]+$') --leave only elements with letters
          ORDER BY col))
--преобразование столбца в строку
SELECT '&str' AS "Original string", LTRIM(SYS_CONNECT_BY_PATH(col, ','), ',') AS "Result" --delete the comma at the beginning of the line
    FROM (SELECT col, ROWNUM r FROM alphabet_sort)
    WHERE r = (SELECT COUNT(*) FROM alphabet_sort)
    START WITH r = 1
    CONNECT BY PRIOR r = r - 1; --connect the value at the next level to a lower level
    
UNDEFINE str;
