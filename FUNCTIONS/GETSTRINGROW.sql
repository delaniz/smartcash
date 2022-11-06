--------------------------------------------------------
--  DDL for Function GETSTRINGROW
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "GETSTRINGROW" (in_string IN VARCHAR2, in_split_string IN VARCHAR2, in_row IN NUMBER) RETURN VARCHAR2 AS
   l_rows VARARGS := split_string_to_rows(in_string,in_split_string);
BEGIN
   RETURN l_rows(in_row);
END getStringRow;

/
