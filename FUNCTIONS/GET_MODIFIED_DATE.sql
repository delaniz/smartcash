--------------------------------------------------------
--  DDL for Function GET_MODIFIED_DATE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "YYORDERDB2"."GET_MODIFIED_DATE" (filename IN VARCHAR2)
   RETURN DATE
IS
   vlastModifiedDate   DATE;
BEGIN
   vlastModifiedDate := TO_DATE (get_modified_date_raw (filename), 'YYYY-MM-DD HH24:MI:SS');

   IF TO_CHAR (vlastModifiedDate, 'YYYY') = '1970'
   THEN
      RETURN NULL;
   ELSE
      RETURN vlastModifiedDate;
   END IF;
END;
/
