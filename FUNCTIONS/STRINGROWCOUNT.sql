--------------------------------------------------------
--  DDL for Function STRINGROWCOUNT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "STRINGROWCOUNT" (in_string IN VARCHAR2, in_split_string IN VARCHAR2) RETURN NUMBER AS
   l_rows VARARGS := split_string_to_rows(in_string,in_split_string);
BEGIN
   RETURN l_rows.count;
END stringRowCount;

/
