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