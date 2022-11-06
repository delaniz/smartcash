--------------------------------------------------------
--  DDL for Function TO_CHAR_NUMBER2
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "YYORDERDB2"."TO_CHAR_NUMBER2" (myNumber IN NUMBER)
   RETURN VARCHAR2
IS
      formatstring   VARCHAR2 (100) := '99999990D99';
BEGIN
  RETURN TRIM (TO_CHAR (myNumber, formatstring, 'NLS_NUMERIC_CHARACTERS='',.'''));
END;
/
