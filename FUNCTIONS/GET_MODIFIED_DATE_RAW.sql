--------------------------------------------------------
--  DDL for Function GET_MODIFIED_DATE_RAW
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "YYORDERDB2"."GET_MODIFIED_DATE_RAW" (filename IN VARCHAR2)
   RETURN VARCHAR2
AS
   LANGUAGE JAVA
   NAME 'CheckFile.lastModified(java.lang.String) return java.lang.String' ;
/
