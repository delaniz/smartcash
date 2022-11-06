--------------------------------------------------------
--  DDL for Function FIELD_IS_FIXED_BY_TEMPLATE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "YYORDERDB2"."FIELD_IS_FIXED_BY_TEMPLATE" (pODT_NAME IN VARCHAR2, pFIELDNAME IN VARCHAR2)
   RETURN varchar2
IS
   vReturn          VARCHAR2 (1);
   vFeldExistiert   NUMBER;
   vQuery           VARCHAR2 (4000);
BEGIN
   SELECT   COUNT (*)
     INTO   vFeldExistiert
     FROM   user_tab_cols c
    WHERE   table_name = 'OMS_ORDERTEMPLATE' AND column_name = pFIELDNAME;

   IF (vFeldExistiert = 1)                                                                        -- SQL-Injection safe!
   THEN
      vQuery := '
        SELECT   DECODE (COUNT (*),  0, ''N'',  1, ''J'')        
        FROM   oms_ordertemplate
        WHERE   odt_name = :pODT_NAME and ' || pFIELDNAME || ' is not null';

      EXECUTE IMMEDIATE vQuery INTO vReturn USING pODT_NAME;
   END IF;

   RETURN vReturn;
END;
/
