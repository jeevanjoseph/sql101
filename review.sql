-- schema objects are owned by a user account.
-- a synonymn is a schema object, however a public schema is a non-schema object.

-- db object naming
--      -- start with a letter,[A-Za-z0-9_#$]. 1<= length<=30
        -- name is not case sensitive, but stored in UPPER in data dictionary tables.
        -- if name is quoted, then all references should be quoted as well.
        -- reserved words can be used in quoted names, they can start with any char or include spaces.
-- Name Spaces
    -- names have to be unique in their name spaces
    -- Users & Roles
    -- Public Synonymns
    -- Schema Objects
        -- NS
            -- Indexes
        -- NS
            -- Constraints
        -- NS
            -- Tables 
            -- views
            -- synonymns
            -- sequences
            -- user defined types
-- CREATE TABLE
    -- need to ensure the brackets for column definitions, the commas and a final semicolon
    -- Constraints can be added in-line or at the end. EXCEPT for NOT NULL. thats possible only with INLINE
    -- Inline constraints can be named using the CONSTRAINT keyword. 

-- DATA TYPES
    -- CHAR(n). Fixed, shorter entries are RPADed with spaces. n is optional and assumed to be one. n<=2000
    -- VARCHAR2(n). 1<= n <= 4000. n is mandatory
    -- NUMBER(p,s). p,s optional defaults to the largerst values. 
        -- p is the total number of digits, s is the number of digits to the right of the decimal
        -- NUMBER(4,1) -> 101.55 => 101.6 == total 4 digits, 1 to the right of the decimal and values are rounded.
    -- DATE - stores time up to seconds as well
        -- RR - 00-49 21at century, 50-99 20th century

    -- TIMEASTAMP(n=6) - 0<=n<=9 . Stores franctional seconds as well
    -- TIMESTAMP WITH TIMEZONE (n=6) - 0<=n<=9. Stores a timezone offset or timezone region name 
    -- TIMESTAMP WITH LOCAL TIMEZONE (n=6) - 0<=n<=9. Timezone offset or region code is not actually stored,
    --                   rather the DB converts to the session tine and retutrns to the user.

    -- BLOB - Binary upto 4GB. No unique indexes possible
    -- CLOB - Char LOB upto 4GB. No unique indexes possible.
    -- NCLOB - CLOB in unicode.



-- LPAD and RPAD
-- Syntax: LPAD(s1, n, s2)
--               RPAD(s1, n, s2).
-- Parameters: s1 (character string—required); n (number—required); s2 (character string—optional; s2 defaults to a single blank space if omitted).
-- Process: Pad the left of character string s1 (LPAD) or right of character string s1 (RPAD) with character string s2 so that s1 is n characters long.
-- Output: Character string.
-- Example: Take a string literal 'Chapter One—I Am Born' and pad it to the right so that the resulting string is 40 characters in length.

select rpad('0123456789',12,'.') from dual;
select rpad('0123456789',12,'LONG_STRING') from dual;
select rpad('0123456789',10,'.') from dual;
select rpad('0123456789',5,'.') from dual;
select rpad('0123456789',0,'.') from dual;
select rpad('0123456789',-1,'.') from dual;
select rpad('0123456789',15) from dual;

select lpad('0123456789',5,'.') from dual;
select lpad('0123456789',10,'.') from dual;
select lpad('0123456789',12,'.') from dual;

-- CONCAT & || 
-- Syntax: CONCAT(s1, s2)
--              s1 || s2
-- Parameters: s1, s2. Both are character strings; both are required.
-- Process: Concatenates s1 and s2 into one string. a single ' char is the escape char. 
-- Output: Character string.

select concat('Hello',' there') || concat('! How''s it going','?') from dual;


-- !!!  TRICKY ONE !!!!
-- LTRIM and RTRIM 
-- Syntax: LTRIM(s1, s2)
--              RTRIM(s1, s2)
-- Parameters: s1, s2—both are character strings. s1 is required, and s2 is optional—if omitted, it defaults to a single blank space.
-- Process: Removes occurrences of the s2 characters from the s1 string, from either the left side of s1 (LTRIM) or the right side of s1 (RTRIM) exclusively.
-- Output: Character string.
-- Notes: Ideal for stripping out unnecessary blanks, periods, ellipses, and so on.
-- basically ensures that the input string does not begin with or end with any of the characters in the S2.
-- S2 is treated as "any char in this string" and not "match this literal string as-is"

select LTRIM('AAABBAAABBBCC','A') from dual;
select LTRIM('AAABBAAABBBCC','C') from dual;
select LTRIM('AAABBAAABBBCC','ABC') from dual;
select LTRIM('AAABBAAABBBCC','ACB') from dual;
select LTRIM('AAABBAAABBBDCC','ACB') from dual;

select RTRIM('AAABBAAABBBCC','A') from dual;
select RTRIM('AAABBAAABBBCC','C') from dual;
select RTRIM('AAABBAAABBBCC','BC') from dual;
select RTRIM('AAABBAAABBBCC','ABC') from dual;
select RTRIM('AAABBAAABBBCC','ACB') from dual;
select RTRIM('AAABBAAABDBBCC','ACB') from dual;


-- TRIM
-- Syntax: TRIM(trim_info trim_char FROM trim_source)
-- Parameters:

--     trim_info is one of these keywords: LEADING, TRAILING, BOTH—if omitted, defaults to BOTH.
--     trim_char is a single character to be trimmed—if omitted, assumed to be a blank.
--     trim_source is the source string—if omitted, the TRIM function will return a NULL.

-- Process: Same as LTRIM and RTRIM, with a slightly different syntax.
-- Output: Character string.
-- If multiple chars are specified in the trim_char, then an error is thrown
select TRIM(LEADING '0' FROM '000ABC123000') from dual;
select TRIM(TRAILING '0' FROM '000ABC123000') from dual;
select TRIM('0' FROM '000ABC123000') from dual;
select TRIM(LEADING '0' FROM (SELECT '000111' FROM DUAL)) from dual;

select TRIM(LEADING '00' FROM '000ABC123000') from dual;


-- INSTR
-- Syntax: INSTR(s1, s2, pos, n)
-- Parameters: s1 is the source string (required); s2 is the substring (required); pos is the starting position in s1 to start looking for occurrences of s2 (optional, default is 1); n is the occurrence of s2 to locate (optional, default is 1). If pos is negative, the search in s1 for occurrences of s2 starts at the end of the string and moves backward.
-- Process: Locates a string within another string (thus the name of the function: IN STRing).
-- Output: Numeric.
-- Indexes (position) are 1 based. looking for a string from the 0th position will yield nothing.
-- Occurence - looking for the 0th or negative occurence will throw an error.
-- The entire search string is located. 
-- Looking fo 

-- first occurence of A = 5
select INSTR('1234AA7A9','A',1,1) FROM DUAL; 
-- third occurence of A = 8
select INSTR('1234AA7A9','A',1,3) FROM DUAL; 
-- first occurence of A on or after the 7th char= 8
select INSTR('1234AA7A9','A',6,1) FROM DUAL; 
-- first occurence of AA = 5
select INSTR('1234AA7A9','AA',1,1) FROM DUAL; 
-- second occurence of AA = 0 i.e. does not exist in the input string
select INSTR('1234AA7A9','AA',1,2) FROM DUAL; 

-- first occurence of A on or after the 0th position = 0
select INSTR('1234AA7A9','A',0,1) FROM DUAL; 

-- 0th occurence of A on or after the 1st position = ERROR
select INSTR('1234AA7A9','A',1,0) FROM DUAL; 

-- first occurence of AA on or after the 1st char = 5 
select INSTR('1234AA7A9','AA',1,1) FROM DUAL; 
-- 2nd occurence of AA on or after the 1st char = 0 NOT FOUND (there is only one occurence)
select INSTR('1234AA7A9','AA',1,2) FROM DUAL; 
-- 1st occurence of AA on or after the last char (reverse search) = 10. although the search is in reverse, the indexes are from left to right
select INSTR('1234AA7A9AA','AA',-1,1) FROM DUAL;
-- 2nd occurence of AA on or after the last char (reverse search) = 5. although the search is reverse, the index/positions are from left to right.
select INSTR('1234AA7A9AA','AA',-1,2) FROM DUAL; 


-- SUBSTR
-- Syntax: SUBSTR(s, pos, len)
-- Parameters: s = a character string, required; pos = a number, required; len = a number, optional.
-- Process: Extracts a substring from s, starting at the pos character of s and continuing for len number of characters. If len is omitted, then the substring starts as pos and runs through the end of s. If pos is negative, then the function starts at the end of the string and moves backward.
-- Output: Character string.

-- take from 5th char to the end. No length
select substr('1234567890',5) from dual;
-- take from the 5th char, two chars (5th included)
select substr('1234567890',5,2) from dual;
--  zero based indexes work here, returns the first char
select substr('1234567890',0),substr('1234567890',1,1),substr('1234567890',0,1) from dual;    

-- negaive or zero lengths will give a NULL. No errors
select substr('1234567890',5,0), substr('1234567890',5,-1) from dual;
select 'Hello' from Dual where substr('1234567890',5,0) IS null and substr('1234567890',5,-1) is null;

-- CEIL
-- Syntax: CEIL(n)
-- Parameters: n is required and is any numeric data type.
-- Process: CEIL returns the smallest integer that is greater than or equal to n.

-- FLOOR
-- Syntax: FLOOR(n)
-- Parameters: n is required and is any numeric data type.
-- Process: FLOOR returns the largest integer that is less than or equal to n.

-- ROUND—Number
-- Syntax: ROUND (n, i)
-- Parameters: n is required, is any number, and can include decimal points. i is an integer and is optional—if omitted, it will default to 0.
-- Process: n is rounded depending on the value of i. If i is zero, n is rounded off to the nearest whole number, in other words, zero decimal points. If i is a positive number, n is rounded to i places to the right of the decimal point. If i is a negative number, n is rounded to i places to the left of the decimal point. The number 5 is rounded away from zero.
-- Output: If i is omitted, ROUND returns a value in the same numeric data type as n. If i is specified, ROUND returns a data type of NUMBER.

-- Rounding works with the number of decimals desired. if desired decimals are more than available, nothing is done. Negative decimal points will round on the other side of the decimal.
select CEIL(5.5), FLOOR(5.5), ROUND(5.5),ROUND(5.49), ROUND(5.49,1),ROUND(5.49,3), ROUND(5.49e3,3),ROUND(555.49,-1), ROUND(555.49,-2)from Dual;
-- Automatic type conversion works when numbers are quoted, including scientific 'e to the power' notation 
select CEIL('5.5'), FLOOR('5.5'), ROUND('5.5'),ROUND('5.49'), ROUND('5.49',1),ROUND('5.49',3), ROUND('5.49e2',2) from Dual;
-- Auto type conversion cannot work with nin number strings ?
select CEIL('21-NOV-18'),CEIL('A') from Dual;



-- TRUNC—Number
-- Syntax: TRUNC(n, i)
-- Parameters: n is required, is any number, and can include decimal points. i is an integer and is optional—if omitted, it will default to 0.
-- Process: TRUNC "rounds" toward zero; in other words, it truncates the numbers.
-- Output: If i is omitted, TRUNC returns a value in the same numeric data type as n. If i is specified, TRUNC returns a data type of NUMBER.
-- One way to think about this is that its like a FLOOR with a way to spceficy how many decimals to keep. 

-- without the decimal, it pretty much works like a FLOOR, with the decimal, ir takes away the number of significant digits, and rounds then to 0.
select TRUNC(5.5),TRUNC(5.49), TRUNC(5.49,1),TRUNC(5.49,3), TRUNC(5.49e3,3),TRUNC(555.49,-1), TRUNC(555.49,-2)from Dual;


-- ROUND—Date
-- Syntax: ROUND(d, i)
-- Parameters: d is a date (required); i is a format model (optional).
-- Process: d is rounded off to the nearest date value, at a level of detail specified by i. 
-- d is required and specifies a value of the DATE data type. 
-- i is a format model and specifies the level of detail to which the DATE value will be rounded,
-- in other words, to the nearest day, nearest hour, nearest year, and so on. i is optional; 
-- if i is omitted, ROUND will default to a format model that returns a value of d rounded to the nearest whole day. 
-- Values are biased toward rounding up. For example, when rounding off time, 12 noon rounds up to the next day.
SELECT SYSDATE TODAY, ROUND(SYSDATE,'MM') ROUNDED_MONTH, ROUND(SYSDATE,'RR') ROUNDED_YEAR FROM   DUAL; 

-- rounding without a format, rounds to the nearest day, 12:00 noon rounds to the next day and 11:59:59 rounds to the 00:00 of the current day  
select to_char(round(to_date('16-DEC-2018 11:30:00','DD-MON-YYYY HH24:MI:SS')), 'DD-MON-YYYY HH24:MI:SS') "11:30:00", to_char(round(to_date('16-DEC-2018 12:00:00','DD-MON-YYYY HH24:MI:SS')), 'DD-MON-YYYY HH24:MI:SS') "12:00:00" from Dual ;
-- HH, rounds to the nearest hour, 30th minute rounds up to the next hour
select to_char(round(to_date('16-DEC-2018 11:30:00','DD-MON-YYYY HH24:MI:SS'),'HH'), 'DD-MON-YYYY HH24:MI:SS') "11:30:00", to_char(round(to_date('16-DEC-2018 11:29:59','DD-MON-YYYY HH24:MI:SS'),'HH'), 'DD-MON-YYYY HH24:MI:SS') " 11:29:59" from Dual ;
-- DD rounds a date to the nearest Day. 12 noon rounds up to the next day.
select to_char(round(to_date('16-DEC-2018 11:59:59','DD-MON-YYYY HH24:MI:SS'),'DD'), 'DD-MON-YYYY HH24:MI:SS') "11:59:59", to_char(round(to_date('16-DEC-2018 12:00:00','DD-MON-YYYY HH24:MI:SS'),'DD'), 'DD-MON-YYYY HH24:MI:SS') "12:00:00" from Dual ;
-- MM Round a date to the 'nearest' month. 15th is rounded down, and 16th is rounded up
select to_char(round(to_date('16-DEC-2018 11:29:00','DD-MON-YYYY HH24:MI:SS'),'MM'), 'DD-MON-YYYY HH24:MI:SS') "16th", to_char(round(to_date('15-DEC-2018 11:29:00','DD-MON-YYYY HH24:MI:SS'),'MM'), 'DD-MON-YYYY HH24:MI:SS') "15th" from Dual ;


-- TRUNC—Date
-- Syntax: TRUNC(d, i)
-- Parameters: d is a date (required); i is a format model (optional).
-- Process: Performs the same task as ROUND for dates, except TRUNC always rounds down.

-- trunc without a format,  rounds to the 00:00 of the current day  
select to_char(trunc(to_date('16-DEC-2018 11:30:00','DD-MON-YYYY HH24:MI:SS')), 'DD-MON-YYYY HH24:MI:SS') "11:30:00", to_char(trunc(to_date('16-DEC-2018 12:00:00','DD-MON-YYYY HH24:MI:SS')), 'DD-MON-YYYY HH24:MI:SS') " 12:00:00" from Dual ;
-- HH, truncates to the start of the current hour
select to_char(trunc(to_date('16-DEC-2018 11:30:00','DD-MON-YYYY HH24:MI:SS'),'HH'), 'DD-MON-YYYY HH24:MI:SS') "11:30:00", to_char(trunc(to_date('16-DEC-2018 11:29:59','DD-MON-YYYY HH24:MI:SS'),'HH'), 'DD-MON-YYYY HH24:MI:SS') " 11:29:59" from Dual ;
-- DD truncates a date to the nearest Day. 12 noon rounds up to the next day.
select to_char(trunc(to_date('16-DEC-2018 11:59:59','DD-MON-YYYY HH24:MI:SS'),'DD'), 'DD-MON-YYYY HH24:MI:SS') "11:59:59", to_char(trunc(to_date('16-DEC-2018 12:00:00','DD-MON-YYYY HH24:MI:SS'),'DD'), 'DD-MON-YYYY HH24:MI:SS') "12:00:00" from Dual ;
-- MM Round a date to the 'nearest' month. 15th is rounded down, and 16th is rounded up
select to_char(trunc(to_date('16-DEC-2018 11:29:00','DD-MON-YYYY HH24:MI:SS'),'MM'), 'DD-MON-YYYY HH24:MI:SS') "16th", to_char(trunc(to_date('15-DEC-2018 11:29:00','DD-MON-YYYY HH24:MI:SS'),'MM'), 'DD-MON-YYYY HH24:MI:SS') "15th" from Dual ;

-- LAST_DAY
-- Syntax: LAST_DAY(d)
-- Parameters: d is a date, required.
-- Process: Returns the last day of the month in which d falls.
-- Output: Date.
-- Example: Show the last days of February in 2020 and 2021.
-- auto conversion works
SELECT LAST_DAY(to_date('14-FEB-20','DD-MON-YY')), LAST_DAY ('20-FEB-21') FROM   DUAL; 

-- ADD_MONTHS
-- Syntax: ADD_MONTHS(d, n)
-- Parameters: d is a date, required; n is a whole number, required.
-- Process: Adds n months to d and returns a valid date value for the result.
-- Output: Date.

-- ading month to the last dat in a month, gives the last day of the next month. leap years included. 
select ADD_MONTHS('27-Feb-2018',1), ADD_MONTHS('28-Feb-2018',1),ADD_MONTHS('28-Feb-2020',1),ADD_MONTHS('29-Feb-2020',1) from dual ;
-- subtracting months works the same way
select ADD_MONTHS('27-Feb-2018',-1), ADD_MONTHS('28-Feb-2018',-1),ADD_MONTHS('28-Feb-2020',-1),ADD_MONTHS('29-Feb-2020',-1) from dual ;

-- TO_NUMBER
-- Syntax: TO_NUMBER(e1, format_model, nls_parms)
            -- NLS_NUMERIC_CHARACTERS = 'dg'	d = decimal character (see D in Table 6-1)
            -- g = group separator (see G in Table 6-1)
            -- NLS_CURRENCY = 'text'	text = local currency symbol (see L in Table 6-1)
            -- NLS_ISO_CURRENCY = 'currency'	currency = international currency symbol
-- G and D used in the format model. the nls chars param set the "redefined" vaues for G and D. 
SELECT TO_NUMBER('17.000,23',  '999G999D99', 'nls_numeric_characters='',.'' ')  REFORMATTED_NUMBER FROM   DUAL; 


-- Date types
--      DATE - Stores the century, year, month, date, hour, minute, and second. 
--              When a string is coerced, RR or YY Format model interpret the century. Once stored, the output format does not affect the stored century info. 
--              When a date is queried, it inlcudes the time stored. To compare dates without times, TRUNC can be used.
-- TIMESTAMP - tracks franstional seconds in addition to date. default is to use 6 digits (percision) for storing the  franctional seconds.
-- TIMESTAMP WITH TIME ZONE - includes the TZ offset or th TZ region name.
--           - Two TZ with timezones are equal if they represent the same instant in UTC . 
select 'they are the same', TO_TIMESTAMP_TZ ('1999-01-15 8:00:00 -8:00','YYYY-MM-DD HH24:MI:SS TZH:TZM'), TO_TIMESTAMP_TZ ('1999-01-15 11:00:00 -5:00','YYYY-MM-DD HH24:MI:SS TZH:TZM') 
from dual 
where TO_TIMESTAMP_TZ ('1999-01-15 8:00:00 -8:00','YYYY-MM-DD HH24:MI:SS TZH:TZM') = TO_TIMESTAMP_TZ ('1999-01-15 11:00:00 -5:00','YYYY-MM-DD HH24:MI:SS TZH:TZM') ;

-- TIMESTAMP WITH LOCAL TIMEZONE - variarion on TS with TZ, but the date stored is in the DB tz, and the TZ offset is NOT stored. 
--                               - when queried, the DB converts the date in to the user's local TZ as setup in the user session

-- *** Date formatting ***
-- FM clears up the extra spaces introduced by the formatting
-- Day prints the day of the week in mixed case. DAY/day would have printed in upper/lower case. dAY = day, DaY=Day (only the first&second char matters).
--   if the first char is lower, print all lower
--   else // first char is upper
--        if (second char is lower) => mixed case
--        else => all upper case // second char is also upper.
-- quoted string "the" passed through as is
-- Ddth => DD TH. DD is day of month. TH adds the 1'ST', 'nd'. 'rd', 'th' appropriately. DD will cause TH, or RD, but Dd/dd will cause th,rd, etc.
-- Month prints the complete month name in mixed case. MONTH = all upper case, month= all lower case. only the first two chars matter. 
-- RRRR - prints Year
--          YYYY -> print current Year
--          RRRR -> if the last two digits are 00-49, assume current century. 50-99 assumes previous century.
-- The 24-hour format (HH24) shows midnight as 00, and the 12-hour format(HH12/HH) shows midnight as 12. 
select TO_CHAR(SYSDATE,'FMDaY, "the" Ddth "of" Month, RRRR')  from dual;
-- Shows how RR interprests date. once the DFATE object is created, its always put put the same way. RR and YY differ in interpretting a string represantatin as a DATE type.
select TO_CHAR(TO_DATE('99','YY'), 'YYYY'), TO_CHAR(TO_DATE('99','RR'), 'YYYY'),TO_CHAR(TO_DATE('99','YY'), 'RRRR') from dual;
-- Sample converting a number to a date.
SELECT TO_DATE(11221999,'MMDDYYYY') "Time" FROM   DUAL; 


-- CASE 
-- Kind of like an if then else.
-- There are two kinds - simple and searched. when no options match , a null is returned.
-- The evaluation stop at the first match.
-- There can be a total of 255 exprs, inlcuding the expr for the CASE, the optional ELSE, and each WHEN and TEN exprs.
-- Simple - CASE <EXPR> WHEN <CONDITION> THEN <VALUE> ELSE <DEFAULT> END
--   EXPR is sommething like a name or a condition like AGE>10. 
--   CONDITIONS check the result of the expression. 
--     Select name, age, case name when 'angelina' then 'maleficent' from Table
-- searched -  CASE WHEN <EXPR> = <CONDITION> THEN <RESULT> 
--     Here we can have multiple expressions which is the big differnce.
--     SELECT name, age , CASE WHEN age >= 18 THEN 'adult' WHEN age < 18 THEN 'child' from table.
-- HANDLING NULLS
-- Simple CASE, the NULL is compared to the WHEN clause, and results in NULL!=NULL as expected. 
Select CASE NULL when NULL THEN 'CASE : NULL == NULL' ELSE 'CASE : NULL !=NULL' END from Dual;

-- Searched CASE, where a proper IS NULL check is employed, this returs NULL IS NULL as expected
Select CASE WHEN NULL IS NULL THEN 'CASE : NULL IS NULL' ELSE 'CASE : NULL IS NOT NULL' END from Dual;
-- DECODE, where NULL values are compared -- IS NULL not used -- return true. This is out of the ordinary. 
Select DECODE(NULL,NULL,'DECODE: NULL==NULL','DECODE: NULL!=NULL') from Dual;

-- Samples. Takes the EMP table, look at the job_id and deduce the job based on the first two letters of the code.
SELECT EMP.*, 
CASE SUBSTR(EMP.JOB_ID,1,2)
WHEN 'AD' THEN 'Admin'
WHEN 'IT' THEN 'Tech'
WHEN 'FI' THEN 'Finance'
ELSE 'Other'
END JOB
from HR.EMPLOYEES EMP;
-- Same thing in DECODE form.
-- Both CASE and DECODE does not need to have a final "default". if there is no default and none of the exprs match, then a NULL is returned.

SELECT EMP.*, 
DECODE( SUBSTR(EMP.JOB_ID,1,2), 
        'AD', 'Admin',
        'IT', 'Tech',
        'FI', 'Finance',
        'Other') JOB
from HR.EMPLOYEES EMP;


--  COUNT
 
-- Syntax: COUNT(e1)
-- Parameters: e1 is an expression. e1 can be any data type.

-- The aggregate function COUNT determines the number of  occurrences of non-NULL values. 
-- It considers the value of an expression and determines whether that value is NOT NULL for each row it encounters.
-- COUNT will never return NULL. If it encounters no values at all, it will at least return a value of 0 (zero). 
-- COUNT counts occurrences of data, ignoring NULL values. But when combined with the asterisk, as in SELECT COUNT(*) FROM VENDORS,
-- it counts occurrences of rows—and will include rows with all NULL values in the results. 
-- 
-- The DISTINCT and ALL operators can be used with aggregate functions. DISTINCT returns only unique values. 
-- ALL is the opposite of DISTINCT and is the default value. If you omit DISTINCT, the ALL is assumed. 
-- DISTINCT and ALL cannot be used with the asterisk
-- 
select COUNT(*), COUNT(COMMISSION_PCT), COUNT(DISTINCT COMMISSION_PCT) from HR.EMPLOYEES;


--  SUM
 
-- Syntax: SUM(e1)
-- Parameters: e1 is an expression whose data type is numeric.

-- The SUM function adds numeric values in a given column. It takes only numeric data as input. SUM adds all the values in all the rows and returns a single answer.
Select to_char(SUM(salary),'L999,999,999.99') from hr.employees;


--  MIN, MAX
 
-- Syntax: MIN(e1); MAX(e1)
-- Parameters: e1 is an expression with a data type of character, date, or number.
-- they use the same basic logic that ORDER BY uses for the different data types, specifically:

--     Numeric: Low numbers are MIN; high numbers are MAX.
--     Date: Earlier dates are MIN; later dates are MAX. Earlier dates are less than later dates.
--     Character: A is less than Z; Z is less than a. The string value 2 is greater than the string value 100. The character 1 is less than the characters 10.

-- NULL values are ignored, unless all values are NULL, in which case MIN or MAX will return NULL.

Select MIN(salary), MIN(email), MIN(hire_date),  MAX(salary), MAX(email), MAX(hire_date) from hr.employees;

--  AVG
 
-- Syntax: AVG(e1)
-- Parameters: e1 is an expression with a numeric data type.

-- The AVG function computes the average value for a set of rows. AVG works only with numeric data. It ignores NULL values. 
-- a single aggregate function can be used within as many nested scalar functions as you want. The aggregate function need not be the innermost function

--  MEDIAN
 
-- Syntax: MEDIAN(e1)
-- Parameters: e1 is an expression with a numeric or date data type.

-- MEDIAN can operate on numeric or date data types. It ignores NULL values. 
Select median(hire_date),  to_char(AVG(ROUND(nvl(salary,0),2)),'L999,999.99'), MAX(email), MAX(hire_date) from hr.employees;


-- RANK: Analytic
-- Syntax: RANK() OVER (PARTITION BY p1 ORDER BY ob1)
-- Parameters: p1 is a partition. ob1 is an expression.

-- The use of PARTITION BY is optional. All other elements are required.

-- The RANK function calculates the rank of a value within a group of values. 
-- Ranks may not be consecutive numbers since SQL counts tied rows individually, 
-- so if three rows are tied for first, they will each be ranked 1, 1, and 1, and the next row will be ranked 4.


-- SELECT SHIP_CABIN_ID, ROOM_STYLE, SQ_FT 
--      , RANK() OVER (PARTITION BY ROOM_STYLE ORDER BY SQ_FT) SQ_FT_RK 
-- FROM     SHIP_CABINS 
-- WHERE    SHIP_CABIN_ID <= 7 
-- ORDER BY SQ_FT; 
 
-- SHIP_ 
-- CABIN_ 
--     ID ROOM_STYLE  SQ_FT   SQ_FT_RK 
-- ------ ---------- ------ ---------- 
--      2 Stateroom     160          1 
--      4 Stateroom     205          2 
--      7 Stateroom     211          3 
--      3 Suite         533          1 
--      1 Suite         533          1 
--      5 Suite         586          3 
--      6 Suite        1524          4 


Select first_name, last_name, hire_date, salary,job_id, RANK() over (partition by job_id order by salary,hire_date ) rnk from hr.employees order by job_id, salary, hire_date  ;


-- GROUP BY identifies subsets of rows within the larger set of rows being considered by the SELECT statement.
--     The GROUP BY can specify any number of valid expressions, including columns of the table.
--     Generally the GROUP BY is used to specify columns in the table that will contain common data in order to group rows together for performing some sort of aggregate function on the set of rows.
--     The following are the only items allowed in the select list of a SELECT that includes a GROUP BY clause:
--         Expressions that are specified in the GROUP BY.
--         Aggregate functions applied to those expressions.
--     Expressions that are specified in the GROUP BY do not have to be included in the SELECT statement’s select list.

-- The HAVING clause can exclude specific groups of rows defined in the GROUP BY clause. 
-- You could think of it as the WHERE clause for groups of rows specified by the GROUP BY clause.
-- The HAVING clause is unique to the SELECT statement; it does not exist in other SQL statements.
-- The HAVING clause does not define the groups of rows themselves; those groups must already be defined by the GROUP BY clause. 
-- HAVING defines the criteria upon which each of the GROUP BY groups will be either included or excluded.
-- The HAVING clause can be invoked only in a SELECT statement where the GROUP BY clause is present.
-- GROUP BY and HAVING may occur in any order.
-- It can only compare expressions that reference groups as defined in the GROUP BY clause and aggregate functions.



-- this query gets employees, their department names and manager names 
-- it ranks the employees by salary within thier department.
-- displays the result in the order or salary earned.
-- the left outer join for getting manager names is needed to capture the CEO(no manager)

select emp.first_name||' '||emp.last_name as Employee, 
        emp.salary, 
        dept.department_name,
        mgr.first_name||' '||mgr.last_name as Manager, 
        rank() over (partition by emp.department_id order by emp.salary desc) 
    from hr.employees emp  
        join hr.departments dept 
            on emp.department_id = dept.department_id 
        left outer join hr.employees mgr 
            on emp.manager_id = mgr.employee_id 
    order by emp.salary desc
    
-- this query finds the total salary budget for each department with their managers.
-- to get the salary budget, we need the employee table grouped at the department_id level
-- emp.dept_id:dept.dept_name is 1:1, so group by department name to select that in the query
-- its joined again with the emp table to find managers for each dept. this is also a 1:1 
-- since each dept has only one manager and that manager has only one name, we can group by the name.
select  dept.department_name, sum(emp.salary) total, dept.manager_id ,mgr.first_name
from hr.employees emp 
    join hr.departments dept
        on dept.department_id = emp.department_id 
    join hr.employees mgr
        on mgr.employee_id = dept.manager_id
-- this where clause would consider only employees with less than 10k in salary.
-- all departments are considered, and the results with the filtered data is found
--where emp.salary < 10000
group by dept.department_name, dept.manager_id, mgr.first_name
-- the having clause filters the groups that are already identified.
-- it does not work at the individual row level but rather at the group level
-- only aggregates or columns inthe group by can be used here.
--having sum(emp.salary)>10000

--when both the where clause and the having is used, the where caulse filters the 
-- rows and the group by processes the filtered rows. The having clause sees the 
-- filtered data from the where clause/
order by total desc


-- Examples for testing queries as well as data dictionary. 


-- drop everything to make this idempotent
drop table emp cascade constraints;
drop table dept cascade constraints;
drop table emp_managers ;
drop table emp_department;
drop table emp_department_mgr;
drop sequence emp_seq;
drop sequence dept_seq;
drop view emp_details;
drop view emp_detail2;

-- table creation. 
-- named primary key using the constraint keyword.
-- row movement enabled, so that this table can be used in a flashback table
create table emp(id number(10),
                name varchar2(30),
                age number(3),
                dept_id number(10),
                CONSTRAINT emp_pk primary key (id)
                ) enable row movement;

-- un-named primary key, using inline syntax.
-- named foreign key that references the manager_id column of the employee table.
create table dept (id number(10) primary key,
                    name varchar2(30),
                    manager_id number(10),
                    constraint dept_mgr_fk foreign key(manager_id) references emp(id) 
                    );

-- adding an FK constraint on the emp table to reference the department id.
-- this could not be done before becuase the dept table did not exist at that time
alter table emp add constraint dept_fk foreign key (dept_id) references dept(id);

-- sequence creations
create sequence emp_seq start with 1000 increment by 5;
create sequence dept_seq start with 10 increment by 10;


-- some data being inserted, the sequence is used for key generation
-- The FK cannot be populated initally since the dept row does not yet exist.
insert into emp(id, name, age) values (emp_seq.nextval, 'Joe', 30);
insert into dept values (dept_seq.nextval, 'keyboards', 1000);
insert into dept values (dept_seq.nextval, 'mice', 1000);

-- adding the reationship
update emp set dept_id = (select max(id) from dept) where id = (select max(id) from emp);

-- simple join
select * from emp join dept on emp.dept_id = dept.id;

-- Simple view - Insertable
create view leadership_team as (select * from emp where dept_id = 10);
select * from leadership_team;
-- inserts a row into the underlying table, but the view sql will prevent this 
-- row from being selected in the view.
-- the where condition on the view sql does not affect the insertability.
insert into leadership_team values (emp_seq.nextval, 'alex', 25, 20);


-- create a view . uses a subquery to get the department manager.
-- can be done with a 3 way join as well
create view emp_details as (select emp.id, emp.name, age, dept_id, dept.name as dept_name, (select emp.name from emp join dept on dept.manager_id = emp.id ) department_manager from emp join dept on emp.dept_id = dept.id);

-- using a 3 way join to get the employee details as well as the departmental manager.
create view emp_detail2 as (select emp.id, emp.name, emp.age, emp.dept_id, dept.name as dept_name, mgr.name as department_manager 
from emp 
    join dept
        on emp.dept_id = dept.id 
    join emp  mgr on dept.manager_id = mgr.id);


select * from emp_details;


-- METADATA Tables and Views.

-- all DDL (not DML) statements affect the data dictionary
-- USER_ tables contain info on the objects that are owned by the current user.
-- ALL_  tables conatain info on everything that the current user has access to (but not necesarily own)
-- DBA_  tables have info on all objects in the DB, but requires the user to have permisssions to query the tables.

-- query the data dictionary 
select * from dictionary where table_name like '%EMP%';
select * from user_catalog;
select * from user_objects;
select * from user_tables;

-- checking status of views and recompiling them.
-- You cannot select all invalid views and recompile them in one command as
-- the alter is a DDL and the select is a DML. PL/SQL can do this 
select * from user_objects where object_type='VIEW'
alter view EMP_DETAILS compile

-- check privileges
select * from user_sys_privs;
select * from DBA_SYS_PRIVS;

-- See constraint details, filtered by the table name.
-- note that only tables can have constraints.
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, R_CONSTRAINT_NAME, STATUS
FROM   USER_CONSTRAINTS
WHERE  TABLE_NAME = 'EMP'


-- see table comments.
-- users can add comments although the dictionary tables are owned by the SYS user
select * from user_tab_comments;
comment on table emp is 'simple table for testing';
select * from user_tab_comments;

-- Note that the dictonary stores everything in upper case. except for quoted table names.
-- note that create table uses double qoutes to specify the table name, but the 
-- select from the user_tab_comments uses as single quoted string.
create table "Really Bad Name" (key number(5) primary key,value varchar2(2000));
select * from user_tab_comments where table_name = 'Really Bad Name'


select * from user_col_comments where table_name = 'EMP'
comment on column emp.id is 'The Employee ID. the primary key for the emp table'
select * from user_col_comments where table_name = 'EMP'

-- Multi Table Inserts


-- setting up some dummy tables
create table emp_managers  (emp_name varchar2(30), manager_name varchar2(30));
create table emp_department (emp_name varchar2(30), department_name varchar2(30));
create table emp_department_mgr (emp_name varchar2(30), department_name varchar2(30),manager varchar2(30));

-- the first table omits the column names, so all columns are assumed in the table order. 
-- will fail if the values clause does not have data for all columns
--  the second insert specifies the column list as well as the values list
-- the final isert omits both the column list as well as the values list, 
-- but the select statement result can directly be  inserted in to this table
INSERT ALL
    into  emp_managers values (ename, manager)
    into  emp_department (emp_name, department_name) values (ename, dname)
    into emp_department_mgr
    Select emp.name ename, dept.name dname, (select emp2.name from emp emp2 join dept dept2 on emp2.id= dept2.manager_id where dept.id = dept2.id) manager
    from emp 
        join dept
        on emp.dept_id = dept.id
        
select * from emp_managers;
select * from emp_department;
select * from emp_department_mgr;
