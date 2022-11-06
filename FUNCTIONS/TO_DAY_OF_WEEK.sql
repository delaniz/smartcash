--------------------------------------------------------
--  DDL for Function TO_DAY_OF_WEEK
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "YYORDERDB2"."TO_DAY_OF_WEEK" (in_date DATE) RETURN NUMBER DETERMINISTIC
AS
BEGIN
  RETURN 1 + in_date - TRUNC(in_date, 'IW');
END TO_DAY_OF_WEEK;
/
