--------------------------------------------------------
--  DDL for Function GET_GLOBAL_NAME
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "YYORDERDB2"."GET_GLOBAL_NAME_MARS" RETURN VARCHAR2
AS
    l_return VARCHAR2(50);
BEGIN
    select CASE WHEN global_name = 'ENDUR.WORLD' THEN 'MARS.WORLD' ELSE 'MARST.WORLD' END 
			INTO  l_return
			FROM global_name;
    RETURN l_return;
END get_global_name_mars;
/
