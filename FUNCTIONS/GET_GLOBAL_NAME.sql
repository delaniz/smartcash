--------------------------------------------------------
--  DDL for Function GET_GLOBAL_NAME
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "YYORDERDB2"."GET_GLOBAL_NAME" RETURN VARCHAR2
AS
    l_return global_name.global_name%TYPE;
BEGIN
    SELECT global_name INTO l_return
        FROM global_name;
    RETURN l_return;
END get_global_name;
/
