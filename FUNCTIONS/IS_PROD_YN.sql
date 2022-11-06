--------------------------------------------------------
--  DDL for Function GET_GLOBAL_NAME
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "YYORDERDB2"."IS_PROD_YN" RETURN VARCHAR2
AS
BEGIN
    RETURN CASE WHEN get_global_name() = 'ENDUR.WORLD' 
				THEN 'Y' 
				ELSE 'N' 
			END;
END IS_PROD_YN;
/
