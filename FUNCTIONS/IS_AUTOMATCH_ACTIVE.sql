CREATE OR REPLACE FUNCTION IS_AUTOMATCH_ACTIVE
    RETURN VARCHAR2
AS
    l_ret   VARCHAR2 (10);
BEGIN
    BEGIN
        SELECT   properties.get ('AUTOMATCH_ACTIVE', APP_UTIL.CONSTANTS.get_global_name, 'YYORDERDB2')
          INTO   l_ret
          FROM   DUAL;
    EXCEPTION
        WHEN OTHERS
        THEN
            l_ret := 'N';
    END;

    RETURN l_ret;
END IS_AUTOMATCH_ACTIVE;
/