SELECT 
    '&given_date' AS "Input date",
    CASE
            --if the year is not a multiple of 4
            WHEN mod(substr(TO_CHAR('&given_date'),7),4) != 0 THEN TO_CHAR( (next_day(TO_DATE('31.10.'
            || TO_CHAR(substr(TO_CHAR('&given_date'),7) + 4 - mod(substr(TO_CHAR('&given_date'),7),4) ) ),1) + 1),'DD.MM.YYYY')
            --if the year is a multiple of 4, the date before and on the election day of that year
            WHEN mod(substr(TO_CHAR('&given_date'),7),4) = 0
                 AND '&given_date' <= next_day(TO_DATE('31.10.'
            || TO_CHAR(substr(TO_CHAR('&given_date'),7) ) ),1) + 1 THEN TO_CHAR( (next_day(TO_DATE('31.10.'
            || TO_CHAR(substr(TO_CHAR('&given_date'),7) ) ),1) + 1),'DD.MM.YYYY')
            --if the year is a multiple of 4, the date after the election of this year
            WHEN mod(substr(TO_CHAR('&given_date'),7),4) = 0
                 AND '&given_date' > next_day(TO_DATE('31.10.'
            || TO_CHAR(substr(TO_CHAR('&given_date'),7) ) ),1) + 1 THEN TO_CHAR( (next_day(TO_DATE('31.10.'
            || TO_CHAR(substr(TO_CHAR('&given_date'),7) + 4) ),1) + 1),'DD.MM.YYYY')
        END
    AS "Election date"
FROM
    dual;    
