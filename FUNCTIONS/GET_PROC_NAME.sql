--------------------------------------------------------
--  DDL for Function GET_PROC_NAME
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION GET_PROC_NAME (in_package_name    VARCHAR2,
                                                       in_line            PLS_INTEGER,
                                                       in_version         PLS_INTEGER DEFAULT 1)
    RETURN VARCHAR2                                                                                      --DETERMINISTIC
--RESULT_CACHE RELIES_ON (USER_SOURCE)
AS
    lc_regex       VARCHAR2 (1000 CHAR) := '[0-9a-zA-Z_$<>'']+';
    l_token        VARCHAR2 (32767 CHAR);
    l_proc_name    VARCHAR2 (32767 CHAR);
    l_proc_begin   BOOLEAN := FALSE;
BEGIN
    CASE in_version
        WHEN 1
        THEN
            FOR c
                IN (SELECT     us.*
                        FROM   user_source us
                       WHERE       name = in_package_name
                               AND TYPE = 'PACKAGE BODY'
                               AND REGEXP_INSTR (text, '\S') > 0
                               AND line <= in_line
                    ORDER BY   line DESC)
            LOOP
                FOR i IN REVERSE 1 .. REGEXP_COUNT (c.text, lc_regex)
                LOOP
                    l_token :=
                        REGEXP_SUBSTR (c.text,
                                       lc_regex,
                                       1,
                                       GREATEST (i, 1));

                    IF UPPER (l_token) IN ('PROCEDURE', 'FUNCTION')
                    THEN
                        GOTO return_clause;
                    --RETURN l_proc_name;
                    END IF;

                    l_proc_name := l_token;
                END LOOP;
            END LOOP;
        WHEN 2
        THEN
            SELECT   ui1.name
              INTO   l_proc_name
              FROM   user_identifiers ui1
             WHERE       (ui1.line, ui1.object_name, ui1.object_type) =
                         (SELECT     MAX (line), ui2.object_name, ui2.object_type
                              FROM   user_identifiers ui2
                             WHERE       ui2.line < in_line
                                     AND ui2.object_name = UPPER (in_package_name)
                                     AND ui2.object_type = 'PACKAGE BODY'                              --ui1.object_type
                                     AND ui2.TYPE IN ('FUNCTION', 'PROCEDURE')
                                     AND ui2.usage = 'DEFINITION'
                                     AND ui2.name NOT LIKE 'L_%'
                          GROUP BY   ui2.object_name, ui2.object_type)
                     AND ui1.usage = 'DEFINITION';
    END CASE;

   <<return_clause>>
    BEGIN
        RETURN l_proc_name || ':' || logger_scope_context_seq.CURRVAL;
    EXCEPTION
        WHEN OTHERS
        THEN
            IF SQLCODE = -08002
            THEN
                --raise_application_error(-20001,'get proc name test');
                RETURN l_proc_name;
            END IF;

            RETURN NULL;
    END return_clause;
END get_proc_name;
/
