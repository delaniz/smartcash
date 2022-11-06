--------------------------------------------------------
--  DDL for Function FROM_BASE64
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "YYORDERDB2"."FROM_BASE64" (t in varchar2) RETURN VARCHAR2
AS
BEGIN
  RETURN utl_raw.cast_to_varchar2(utl_encode.base64_decode(utl_raw.cast_to_raw(t)));
END from_base64;
/
