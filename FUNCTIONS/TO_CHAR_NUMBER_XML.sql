--------------------------------------------------------
--  DDL for Function TO_CHAR_NUMBER_XML
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "YYORDERDB2"."TO_CHAR_NUMBER_XML" (myNumber NUMBER)
   RETURN VARCHAR2
IS
BEGIN
   RETURN TRIM (RTRIM (RTRIM (TO_CHAR (myNumber, '99999990D999999', 'NLS_NUMERIC_CHARACTERS=''.,'''), '0'), '.'));
END;
/
