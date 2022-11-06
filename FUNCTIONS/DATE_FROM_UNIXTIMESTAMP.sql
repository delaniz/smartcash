--------------------------------------------------------
--  DDL for Function DATE_FROM_UNIXTIMESTAMP
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "YYORDERDB2"."DATE_FROM_UNIXTIMESTAMP" 
(
  IN_UNIXTIMESTAMP IN NUMBER 
) RETURN DATE AS 
BEGIN
  RETURN to_date('1970-01-01','YYYY-MM-DD') + numtodsinterval(IN_UNIXTIMESTAMP,'SECOND') + 2/24;
END DATE_FROM_UNIXTIMESTAMP;
/
