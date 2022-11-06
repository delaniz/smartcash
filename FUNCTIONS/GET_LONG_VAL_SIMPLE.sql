--------------------------------------------------------
--  DDL for Function GET_LONG_VAL_SIMPLE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "GET_LONG_VAL_SIMPLE" (in_column VARCHAR2, in_table VARCHAR2, in_filter_column VARCHAR2, in_filter_vals VARCHAR2) RETURN VARCHAR2
AS
BEGIN
    RETURN get_long_val(in_column, in_table, AR(in_filter_column), AR(in_filter_vals));
END;

/
