--  08bba8ab9e5b3d782a80fd59c65cd500117c2cfd
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
select trim(LEADING '0' FROM '000ABC123000') from dual;
select trim(TRAILING '0' FROM '000ABC123000') from dual;
select trim('0' FROM '000ABC123000') from dual;
select trim(LEADING '0' FROM (SELECT '000111' FROM DUAL)) from dual;

select trim(LEADING '00' FROM '000ABC123000') from dual;


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


-- FM lears up the extra spaces introduced by the formatting
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