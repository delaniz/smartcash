--------------------------------------------------------
--  DDL for Function TO_CHAR_NUMBER
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "YYORDERDB2"."TO_CHAR_NUMBER" (myNumber IN NUMBER)
   RETURN VARCHAR2 DETERMINISTIC
   --Deterministic verbessert die Performance, weil die Werte gecached werden können von der Datenbank
IS
   formatstring   VARCHAR2 (100) := '99999990D999999';
BEGIN
   --DBMS_OUTPUT.put_line (formatstring);
   RETURN TRIM (RTRIM (RTRIM (TO_CHAR (myNumber, formatstring, 'NLS_NUMERIC_CHARACTERS='',.'''), '0'), ','));
END;
/
