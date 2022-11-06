--------------------------------------------------------
--  DDL for Function HANDLE_EXCEPTION
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "YYORDERDB2"."HANDLE_EXCEPTION" (p_error IN apex_error.t_error)
   RETURN apex_error.t_error_result
AS
   l_result   apex_error.t_error_result
                 := apex_error.init_error_result (p_error => p_error);
BEGIN
    BEGIN
        logger.log_apex_items('APEX Exception');
    END;
   logger.log_error (
      FORMATS('Received error message in APEX, user {3}, sql_code "{0}", sql_errm "{1}", error_backtrace "{2}, page_item = {4}"',
      VARARGS (p_error.ora_sqlcode,
               p_error.ora_sqlerrm,
               p_error.error_backtrace,
               SYS_CONTEXT('oms_context', 'username'),
               NVL (p_error.page_item_name, 'NULL'))));

   IF NVL (SYS_CONTEXT ('oms_context', 'fl_admin'), 'N') = 'N'
   THEN
      l_result.MESSAGE := properties.get('user_error_message');
      l_result.page_item_name := NULL;
      l_result.column_alias := NULL;
   END IF;

   RETURN l_result;
END HANDLE_EXCEPTION;



/
