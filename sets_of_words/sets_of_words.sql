DEFINE numeric_str = '11';
WITH
alphabet AS ( -- Converting a character string with an alphabet to a numbered column
    SELECT SUBSTR('абвгдеёжзийклмнопрстуфхцчшщъыьэюя', LEVEL, 1) AS letter, ROWNUM AS idx
    FROM dual
    CONNECT BY LEVEL <= 33),
split_str_variants AS (
    -- Determine all possible options for splitting the proposed line.
    -- The numbers in a string can be a maximum of two-digit - alphabet consists of 33 letters.
    SELECT SUBSTR('&&numeric_str', LEVEL, 1) AS num -- extracting one-digit number
    FROM dual
    CONNECT BY LEVEL <= LENGTH('&numeric_str')
    UNION ALL
    SELECT SUBSTR('&&numeric_str', LEVEL, 2) -- extracting two-digit numbers
    FROM dual
    CONNECT BY LEVEL <= LENGTH('&&numeric_str') - 1),
idx_to_letter AS( -- Match each number with its letter, if there is none, for example, for 0 - it does not get into the table
    SELECT num, letter, ROWNUM AS r_n
    FROM split_str_variants s  
    JOIN alphabet a
    ON TO_CHAR(s.num) = TO_CHAR(a.idx)),
words AS (
    SELECT DISTINCT REPLACE(SYS_CONNECT_BY_PATH(letter, ','), ',') AS word, -- letter string
        REPLACE(SYS_CONNECT_BY_PATH(num, ','), ',') num_str -- digital string
    FROM idx_to_letter
    CONNECT BY NOCYCLE PRIOR r_n != r_n AND LEVEL <= LENGTH('&numeric_str')),
words_varients_v2 AS ( -- leave only those strings whose numeric values match the original string
    SELECT *
    FROM words
    WHERE num_str = '&&numeric_str'),
-- output to a comma-separated string
words_in_str AS (
    SELECT LTRIM(SYS_CONNECT_BY_PATH(word, ','), ',') AS "Result"
    FROM (SELECT word, ROWNUM r FROM words_varients_v2)
    WHERE r = (SELECT COUNT(*) FROM words_varients_v2)
    START WITH r = 1
    CONNECT BY PRIOR r = (r - 1)),
count_words AS ( -- the number of words formed
    SELECT COUNT("Result") AS cnt 
    FROM words_in_str)
SELECT 
CASE 
    WHEN cnt = 0 THEN 'Incorrect template'
    ELSE (SELECT "Result" FROM words_in_str)
END AS "Result"
FROM count_words;
