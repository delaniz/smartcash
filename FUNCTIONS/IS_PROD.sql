--------------------------------------------------------
--  DDL for Function GET_GLOBAL_NAME
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "YYORDERDB2"."IS_PROD" RETURN BOOLEAN
AS
BEGIN
    RETURN CASE WHEN get_global_name() = 'ENDUR.WORLD' 
				THEN TRUE 
				ELSE FALSE 
			END;
END IS_PROD;
/
