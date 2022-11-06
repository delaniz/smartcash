--------------------------------------------------------
--  DDL for Function GC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "YYORDERDB2"."GC" 
   RETURN VARCHAR2
IS
BEGIN
   RETURN SYS_CONTEXT ('oms_context', 'username');
END;
/
