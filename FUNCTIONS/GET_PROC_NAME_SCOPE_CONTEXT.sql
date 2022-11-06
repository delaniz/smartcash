--------------------------------------------------------
--  DDL for Function GET_PROC_NAME_SCOPE_CONTEXT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION              GET_PROC_NAME_SCOPE_CONTEXT (in_package_name    VARCHAR2,
                                                                     in_line            PLS_INTEGER,
                                                                     in_version         PLS_INTEGER DEFAULT 1)
    RETURN VARCHAR2
AS
    l_dummy   NUMBER;
BEGIN
    RETURN get_proc_name (in_package_name, in_line, in_version);
EXCEPTION
    WHEN OTHERS
    THEN
        IF SQLCODE = -08002
        THEN
            l_dummy := logger_scope_context_seq.NEXTVAL;
            RETURN get_proc_name (in_package_name, in_line, in_version);
        END IF;

        RETURN NULL;
END GET_PROC_NAME_SCOPE_CONTEXT;
/
