DEFINE str = 'abc,cde,ef,gh,mn,test,ss,df,fw,ewe,wwe';

WITH 
--преобразование строки в столбец
str_to_column AS ( 
    SELECT REGEXP_SUBSTR('&str', '[^,]+', 1, LEVEL) AS col --извлекаем из строки подстроки по запятым; 1-позиция, с которой надо искать, LEVEL-номер вхождения
    FROM dual
    CONNECT BY LEVEL <= REGEXP_COUNT('&str', ',') + 1), --уровней (строк в столбце) на один больше запятых в строке
--сортировка по алфавиту    
alphabet_sort AS ( 
    SELECT col, ROWNUM AS r
    FROM( SELECT col
          FROM str_to_column
          WHERE REGEXP_LIKE(col, '^[[:alpha:]]+$') --оставляем только элементы с буквами
          ORDER BY col))
--преобразование столбца в строку
SELECT '&str' AS "Исходная строка", LTRIM(SYS_CONNECT_BY_PATH(col, ','), ',') AS "Результат" --удаляем в начале строки запятую
    FROM (SELECT col, ROWNUM r FROM alphabet_sort)
    WHERE r = (SELECT COUNT(*) FROM alphabet_sort)
    START WITH r = 1
    CONNECT BY PRIOR r = r - 1; --подключаем к более низкому уровню значение на следующем уровне
    
UNDEFINE str;