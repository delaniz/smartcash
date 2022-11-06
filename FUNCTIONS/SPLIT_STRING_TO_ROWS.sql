--------------------------------------------------------
--  DDL for Function SPLIT_STRING_TO_ROWS
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "YYORDERDB2"."SPLIT_STRING_TO_ROWS" (in_string VARCHAR2, in_char VARCHAR2) RETURN VARARGS DETERMINISTIC
AS
    l_result VARARGS := VARARGS();
BEGIN
    IF in_string IS NOT NULL THEN
       FOR i IN 1..REGEXP_COUNT(in_string, in_char) + 1
       LOOP
           l_result.extend;
           l_result(l_result.count) := REGEXP_SUBSTR(in_string, '[^'||in_char||']+',1, i);
       END LOOP;
    END IF;

    RETURN l_result;
END split_string_to_rows;
/
