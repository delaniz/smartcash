--------------------------------------------------------
--  DDL for Function TD
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "YYORDERDB2"."TD" (p_tag     IN VARCHAR2 DEFAULT TO_CHAR (SYSDATE, 'DD.MM.YYYY'),
                               p_monat   IN VARCHAR2 DEFAULT TO_CHAR (SYSDATE, 'MM'),
                               p_jahr    IN VARCHAR2 DEFAULT TO_CHAR (SYSDATE, 'YYYY'))
    RETURN DATE
IS
BEGIN
    IF LENGTH (p_tag) = 10
    THEN
        RETURN TO_DATE (p_tag, 'DD.MM.YYYY');
    ELSE
        RETURN TO_DATE (p_tag || '.' || p_monat || '.' || p_jahr, 'DD.MM.YYYY');
    END IF;
END;
/
