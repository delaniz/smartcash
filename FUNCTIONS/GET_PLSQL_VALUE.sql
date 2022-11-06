--------------------------------------------------------
--  DDL for Function GET_PLSQL_VALUE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "YYORDERDB2"."GET_PLSQL_VALUE" (in_name VARCHAR2, in_package_name VARCHAR2 DEFAULT NULL) RETURN VARCHAR2
AS
  l_statement CONSTANT VARCHAR2(1000) := CASE WHEN in_package_name IS NULL THEN 'BEGIN :1 := '||in_name||'; END;' ELSE 'BEGIN :1 := '||in_package_name||'.'||in_name||'; END;' END;
  l_return VARCHAR2(100);
BEGIN
  EXECUTE IMMEDIATE l_statement USING OUT l_return;
  RETURN l_return;
  EXCEPTION WHEN OTHERS THEN RETURN NULL;
END;
/
