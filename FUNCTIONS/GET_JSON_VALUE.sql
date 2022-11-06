--------------------------------------------------------
--  DDL for Function GET_JSON_VALUE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "YYORDERDB2"."GET_JSON_VALUE" (in_json CLOB, in_path VARCHAR2, in_type VARCHAR2 DEFAULT 'VC2') RETURN VARCHAR2
AS
BEGIN
  apex_json.parse(in_json);
  CASE WHEN in_type IN ('N', 'NUMBER')
  THEN
    RETURN apex_json.get_number(in_path);
  WHEN in_type IN ('D', 'DATE')
  THEN
    RETURN apex_json.get_date(in_path);
  WHEN in_type IN ('B', 'BOOLEAN')
  THEN
    RETURN CASE WHEN apex_json.get_boolean(in_path) THEN 'TRUE' ELSE 'FALSE' END;
  WHEN in_type IN ('C', 'COUNT')
  THEN
    RETURN apex_json.get_count(in_path);
  WHEN in_type IN ('VC2', 'VARCHAR2')
  THEN
    RETURN apex_json.get_varchar2(in_path);
  ELSE
    RAISE_APPLICATION_ERROR(-20001, 'Invalid type supplied valid values are N,NUMBER,D,DATE,B,BOOLEAN,C,COUNT,VC2,VARCHAR2');
  END CASE;
END GET_JSON_VALUE;
/
