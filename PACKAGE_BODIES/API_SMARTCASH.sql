create or replace PACKAGE BODY          "API_SMARTCASH"
IS
    gc_scope_prefix      CONSTANT VARCHAR2 (31) := LOWER ($$plsql_unit) || '.';
    g_row_before                  sc_invoice%ROWTYPE;
    g_log_diff_enabled            BOOLEAN := TRUE;
    gc_dml_insert        CONSTANT VARCHAR2 (10 CHAR) := 'INSERT';
    gc_dml_update        CONSTANT VARCHAR2 (10 CHAR) := 'UPDATE';
    gc_dml_delete        CONSTANT VARCHAR2 (10 CHAR) := 'DELETE';


    FUNCTION Stat_Booked RETURN VARCHAR2 DETERMINISTIC AS BEGIN RETURN c_status_booked; END Stat_Booked;
   -- FUNCTION Stat_Deletion_Confirmed RETURN VARCHAR2 DETERMINISTIC AS BEGIN RETURN c_status_deletion_confirmed; END Stat_Deletion_Confirmed;
    FUNCTION Stat_Expired RETURN VARCHAR2 DETERMINISTIC AS BEGIN RETURN c_status_expired; END Stat_Expired;
    FUNCTION Stat_Update_Request RETURN VARCHAR2 DETERMINISTIC AS BEGIN RETURN c_status_update_request; END Stat_Update_Request;
    FUNCTION Stat_Cancellation_Request RETURN VARCHAR2 DETERMINISTIC AS BEGIN RETURN c_status_cancelation_request; END Stat_Cancellation_Request;
    FUNCTION Stat_All_Stats_CSV RETURN VARCHAR2 DETERMINISTIC AS BEGIN
        RETURN    ''
               || c_status_cancelation_request
               || ', '
               || c_status_update_request
             --  || ', '
            --   || c_status_deletion_confirmed
               || ', '
               || c_status_expired
               || ', '
               || c_status_booked
          --     || ', '
             --  || c_status_deletion_request
               ;END;

    FUNCTION to_sc_invoice_t (in_rowtype IN sc_invoice%ROWTYPE)
        RETURN sc_invoice_t
    AS
        l_scope    logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params   logger.tab_param;
    BEGIN
        RETURN sc_invoice_t (id             => in_rowtype.id,
                            total           => in_rowtype.total,
                            discount        => in_rowtype.discount,
                            payment_id		=> in_rowtype.payment_id,
                            created			=> in_rowtype.created,
                            updated         => in_rowtype.updated,
                            customer_id     => in_rowtype.customer_id,
                            canceled        => in_rowtype.canceled,
                            cancel_reason   => in_rowtype.cancel_reason
                           );
    END to_sc_invoice_t;

    FUNCTION to_rowtype (in_sc_invoice_t IN sc_invoice_t)
        RETURN SC_INVOICE%ROWTYPE
    AS
        l_scope    logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params   logger.tab_param;
        l_row      SC_INVOICE%ROWTYPE;
    BEGIN
        l_row.id := in_sc_invoice_t.id;
        l_row.total := in_sc_invoice_t.total;
        l_row.discount := in_sc_invoice_t.discount;
        l_row.payment_id := in_sc_invoice_t.payment_id;
        l_row.created := in_sc_invoice_t.created;
        l_row.updated := in_sc_invoice_t.updated;
        l_row.customer_id := in_sc_invoice_t.customer_id;
        l_row.canceled := in_sc_invoice_t.canceled;
        l_row.cancel_reason := in_sc_invoice_t.cancel_reason;
		RETURN l_row;
    END to_rowtype;

    FUNCTION get_invoice (in_invoice_id IN SC_INVOICE.ID%TYPE
                         , in_raise_no_data_found VARCHAR2 DEFAULT 'N')
        RETURN SC_INVOICE%ROWTYPE
   
    --returns null row on not found id
    AS
        l_scope       logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params      logger.tab_param;
        l_row_count   PLS_INTEGER;
        l_row         SC_INVOICE%ROWTYPE;
    BEGIN
        logger.append_param (p_params => l_params, p_name => 'in_invoice_id', p_val => in_invoice_id);
        logger.append_param (p_params => l_params, p_name => 'in_raise_no_data_found', p_val => in_raise_no_data_found);
        logger.log_information ('get_invoice',
                                l_scope,
                                NULL,
                                l_params);

        SELECT   COUNT (*)
          INTO   l_row_count
          FROM   SC_INVOICE inv
         WHERE   inv.id = in_invoice_id;

        IF l_row_count = 1
        THEN
            SELECT   *
              INTO   l_row
              FROM   SC_INVOICE inv
             WHERE   inv.id = in_invoice_id;
        ELSE
            IF in_raise_no_data_found = c.yes
            THEN
                RAISE NO_DATA_FOUND;
            END IF;
        END IF;

        RETURN l_row;
    EXCEPTION
        WHEN OTHERS
        THEN
            logger.log_error ('Unhandled Exception',
                              l_scope,
                              NULL,
                              l_params);
            RAISE;
    END get_invoice;
    
    FUNCTION get_invoiceitem (in_invoiceitem_id IN SC_INVOICEITEM.ID%TYPE
                             , in_raise_no_data_found VARCHAR2 DEFAULT 'N')
        RETURN SC_INVOICEITEM%ROWTYPE
   
    --returns null row on not found id
    AS
        l_scope       logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params      logger.tab_param;
        l_row_count   PLS_INTEGER;
        l_row         SC_INVOICEITEM%ROWTYPE;
    BEGIN
        logger.append_param (p_params => l_params, p_name => 'in_invoiceitem_id', p_val => in_invoiceitem_id);
        logger.append_param (p_params => l_params, p_name => 'in_raise_no_data_found', p_val => in_raise_no_data_found);
        logger.log_information ('get_invoiceitem',
                                l_scope,
                                NULL,
                                l_params);

        SELECT   COUNT (*)
          INTO   l_row_count
          FROM   SC_INVOICEITEM inv
         WHERE   inv.id = in_invoiceitem_id;

        IF l_row_count = 1
        THEN
            SELECT   *
              INTO   l_row
              FROM   SC_INVOICEITEM inv
             WHERE   inv.id = in_invoiceitem_id;
        ELSE
            IF in_raise_no_data_found = c.yes
            THEN
                RAISE NO_DATA_FOUND;
            END IF;
        END IF;

        RETURN l_row;
    EXCEPTION
        WHEN OTHERS
        THEN
            logger.log_error ('Unhandled Exception',
                              l_scope,
                              NULL,
                              l_params);
            RAISE;
    END get_invoiceitem;

    FUNCTION get_article (in_article_id IN SC_ARTICLE.ID%TYPE
                             , in_raise_no_data_found VARCHAR2 DEFAULT 'N')
        RETURN SC_ARTICLE%ROWTYPE
   
    --returns null row on not found id
    AS
        l_scope       logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params      logger.tab_param;
        l_row_count   PLS_INTEGER;
        l_row         SC_ARTICLE%ROWTYPE;
    BEGIN
        logger.append_param (p_params => l_params, p_name => 'in_article_id', p_val => in_article_id);
        logger.append_param (p_params => l_params, p_name => 'in_raise_no_data_found', p_val => in_raise_no_data_found);
        logger.log_information ('get_article',
                                l_scope,
                                NULL,
                                l_params);

        SELECT   COUNT (*)
          INTO   l_row_count
          FROM   SC_ARTICLE a
         WHERE   a.id = in_article_id;

        IF l_row_count = 1
        THEN
            SELECT   *
              INTO   l_row
              FROM   SC_ARTICLE a
             WHERE   a.id = in_article_id;
        ELSE
            IF in_raise_no_data_found = c.yes
            THEN
                RAISE NO_DATA_FOUND;
            END IF;
        END IF;

        RETURN l_row;
    EXCEPTION
        WHEN OTHERS
        THEN
            logger.log_error ('Unhandled Exception',
                              l_scope,
                              NULL,
                              l_params);
            RAISE;
    END get_article;

    PROCEDURE INSERT_INVOICE_HISTORY(i_sc_invoice_row IN SC_INVOICE%ROWTYPE)
    AS
       l_hist_row SC_INVOICE_JN%ROWTYPE;
      BEGIN
        l_hist_row.id           := SEQ_ID.NEXTVAL;
        l_hist_row.INVOICE_ID   := i_sc_invoice_row.id;
        l_hist_row.total         := i_sc_invoice_row.total;
        l_hist_row.discount      := i_sc_invoice_row.discount;
        l_hist_row.payment_id    := i_sc_invoice_row.payment_id;
        l_hist_row.created    	 := SYSTIMESTAMP;
        l_hist_row.updated       := i_sc_invoice_row.updated;
        l_hist_row.customer_id   := i_sc_invoice_row.customer_id;
        l_hist_row.canceled      := i_sc_invoice_row.canceled;
        l_hist_row.cancel_reason := i_sc_invoice_row.cancel_reason;

        INSERT INTO SC_INVOICE_JN 
             VALUES l_hist_row;
    END INSERT_INVOICE_HISTORY;
    
     PROCEDURE INSERT_INVOICEITEM_HISTORY(i_sc_invoiceitem_row IN SC_INVOICEITEM%ROWTYPE)
    AS
       l_hist_row SC_INVOICEITEM_JN%ROWTYPE;
      BEGIN
        l_hist_row.id           := SEQ_ID.NEXTVAL;
        l_hist_row.INVOICEITEM_ID := i_sc_invoiceitem_row.id;
        l_hist_row.total         := i_sc_invoiceitem_row.total;
        l_hist_row.discount      := i_sc_invoiceitem_row.discount;
        l_hist_row.article_id    := i_sc_invoiceitem_row.article_id;
        l_hist_row.created    	 := SYSTIMESTAMP;
        l_hist_row.updated       := i_sc_invoiceitem_row.updated;
        l_hist_row.invoice_id   := i_sc_invoiceitem_row.invoice_id;
        l_hist_row.quantity  := i_sc_invoiceitem_row.quantity;
      
        INSERT INTO SC_INVOICEITEM_JN 
              VALUES l_hist_row;
    END INSERT_INVOICEITEM_HISTORY;

    FUNCTION append_invoice_row_params(i_sc_invoice_row IN SC_INVOICE%ROWTYPE) RETURN logger.tab_param
    AS
      l_params   logger.tab_param;
      BEGIN
        logger.append_param (p_params 	=> l_params, 
							 p_name   	=> 'i_sc_invoice_row.id', 
							 p_val 	  	=> i_sc_invoice_row.id);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_sc_invoice_row.total',
                             p_val  	=>  i_sc_invoice_row.total);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_sc_invoice_row.payment_id',
                             p_val  	=>  i_sc_invoice_row.payment_id);
        logger.append_param (p_params 	=> l_params, 
                             p_name 	=> 'i_sc_invoice_row.created',
							 p_val 		=> i_sc_invoice_row.created);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_sc_invoice_row.customer_id', 
							 p_val 		=> i_sc_invoice_row.customer_id);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_sc_invoice_row.canceled', 
							 p_val 		=> i_sc_invoice_row.canceled);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_sc_invoice_row.cancel_reason', 
							 p_val 		=> i_sc_invoice_row.cancel_reason);

        RETURN l_params;
    END append_invoice_row_params;
    
    FUNCTION append_invoiceitem_row_params(i_sc_invoiceitem_row IN SC_INVOICEITEM%ROWTYPE) RETURN logger.tab_param
    AS
      l_params   logger.tab_param;
      l_article SC_ARTICLE%ROWTYPE := get_article(i_sc_invoiceitem_row.article_id);
      BEGIN
        logger.append_param (p_params 	=> l_params, 
							 p_name   	=> 'i_sc_invoiceitem_row.id', 
							 p_val 	  	=> i_sc_invoiceitem_row.id);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_sc_invoiceitem_row.total',
                             p_val  	=>  i_sc_invoiceitem_row.total);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_sc_invoiceitem_row.quantity',
                             p_val  	=>  i_sc_invoiceitem_row.quantity);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_sc_invoiceitem_row.discount',
                             p_val  	=>  i_sc_invoiceitem_row.discount);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_sc_invoiceitem_row.article_id',
                             p_val  	=>  i_sc_invoiceitem_row.article_id);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'l_article.name',
                             p_val  	=>  l_article.name);
        logger.append_param (p_params 	=> l_params, 
                             p_name 	=> 'i_sc_invoiceitem_row.created',
							 p_val 		=> i_sc_invoiceitem_row.created);
        logger.append_param (p_params 	=> l_params, 
                             p_name 	=> 'i_sc_invoiceitem_row.updated',
							 p_val 		=> i_sc_invoiceitem_row.updated);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_sc_invoiceitem_row.invoice_id', 
							 p_val 		=> i_sc_invoiceitem_row.invoice_id);

        RETURN l_params;
    END append_invoiceitem_row_params;

    PROCEDURE SAVE_INVOICE
        ( inout_row                 IN OUT SC_INVOICE%ROWTYPE
        , p_admin_mode              IN     VARCHAR2 DEFAULT NULL
        )
    AS
        l_scope                        logger_logs.scope%TYPE;
        l_params                       logger.tab_param;
        l_dml_type            CONSTANT VARCHAR2 (10 CHAR)
                                           := CASE WHEN inout_row.id IS NULL THEN gc_dml_insert ELSE gc_dml_update END ;
        l_result                       NUMBER;
        l_lockname                     VARCHAR2 (128)   := inout_row.id;
        l_lockhandle                   VARCHAR2 (128);
        l_payment                      SC_PAYMENT%ROWTYPE;
        l_park_id                      NUMBER := GET_PAYMENT_ID('PARK');
        l_dep                          SC_DEP%ROWTYPE;
        --l_fl_admin                     APEX_USERS.FL_ADMIN%TYPE := SYS_CONTEXT ('oms_context', 'fl_admin');
        --  l_fl_init                      APEX_USERRIGHTS.FL_INIT%TYPE;
        -- l_fl_trade                     APEX_USERRIGHTS.FL_TRADE%TYPE;
        --l_user_is_admin       CONSTANT BOOLEAN := CASE WHEN l_fl_admin = c.yes OR p_admin_mode = c.yes THEN TRUE ELSE FALSE END; 
                                                --combined both of admin flags in order to make it possible to force saving price-alerter-id 
                                                --over admin-mode with p_admin_mode so that status changes can be made in_system to in_system 
                                                --old version: CASE l_fl_admin WHEN c.yes THEN TRUE ELSE FALSE END;

        PROCEDURE l_handle_error (l_error_code PLS_INTEGER, l_message VARCHAR2, ll_params VARARGS DEFAULT NULL)
        AS
            l_formatted_message   VARCHAR2 (1000 CHAR) := FORMATS (l_message, ll_params);
        BEGIN
            logger.log_error (l_formatted_message,
                              l_scope,
                              NULL,
                              l_params);
            l_result := DBMS_LOCK.release (l_lockhandle);
            RAISE_APPLICATION_ERROR (l_error_code, l_formatted_message);
        END l_handle_error;
    BEGIN
        l_scope := gc_scope_prefix || 'SAVE_INVOICE';

        IF l_lockname IS NOT NULL THEN
            DBMS_LOCK.ALLOCATE_UNIQUE (lockname => l_lockname, lockhandle => l_lockhandle);
            l_result := DBMS_LOCK.request (l_lockhandle, DBMS_LOCK.x_mode);

            IF l_result <> 0 THEN
                RAISE c_ex_cant_lock_row;
            END IF;
        END IF;
        
        IF inout_row.payment_id IS NULL
        THEN
            RAISE c_ex_no_payment;
        ELSE
            l_payment := get_payment(inout_row.payment_id);
        END IF;
        
        --FIND COMPANY_ID
        inout_row.company_id := GET_COMPANY_ID(V('APP_USER'));
        
        l_params := append_invoice_row_params(INOUT_ROW);
        logger.append_param ( p_params  => l_params
                            , p_name    => 'p_admin_mode'
                            , p_val     => p_admin_mode);

        logger.log_information ('SaveRow ENTRY', l_scope, NULL, l_params);

        -- call order_dml
        order_dml
            ( inout_row => inout_row
            , in_dml_type => l_dml_type
            );
            
        l_dep.company_id := inout_row.company_id;
        l_dep.subject := APEX_STRING.FORMAT('Invoice ID: %0',inout_row.ID) ;
        l_dep.issue := 'BON';
        l_dep.amount_gross := inout_row.total;
        
        IF inout_row.canceled IS NOT NULL
        THEN
            l_dep.name := 'Invoice canceled';
            l_dep.description := APEX_STRING.FORMAT('Canceled, Reason: %s',inout_row.cancel_reason);
            l_dep.amount_gross := -1*inout_row.total;
        ELSIF inout_row.status = 'Open'
        THEN
            l_dep.name := 'Invoice parked';
            l_dep.description := 'parked Invoice';
        ELSE
            l_dep.name := 'New Invoice created';
            l_dep.description := l_payment.name;
        END IF;
        
        ADD_DEP(l_dep);
                
        IF inout_row.status != 'Open'
           AND (l_dml_type = C.gc_dml_insert 
                OR inout_row.canceled IS NOT NULL)
        THEN 
        
            SAVE_CASHBOOK(IN_COMPANY_ID     => inout_row.company_id 
                    , IN_TYPE           => CASE WHEN inout_row.canceled IS NOT NULL
                                                THEN C.gc_out
                                                ELSE C.gc_in
                                           END
                    , IN_CATEGORY       => C.gc_business
                    , IN_AMOUNT_GROSS   => CASE WHEN inout_row.canceled IS NOT NULL
                                                THEN -1
                                                ELSE +1 END*inout_row.total 
                    , IN_INVOICE_ID     => inout_row.id
                    );
                    
        END IF;

        l_result := DBMS_LOCK.release (l_lockhandle);

        logger.log_information('end of the SAVE_INVOICE story, na endlich!',l_scope, null, l_params);
    EXCEPTION
        WHEN c_ex_invalid_changes THEN
			l_handle_error (c_ex_invalid_changes_no, c_ex_invalid_changes_msg);
        WHEN c_ex_no_payment THEN
			l_handle_error (c_ex_no_payment_no, c_ex_no_payment_msg);
        WHEN OTHERS THEN
            l_result := DBMS_LOCK.release(l_lockhandle);

            IF SQLCODE BETWEEN -20031 AND -20042
            THEN
                RAISE_APPLICATION_ERROR(SQLCODE, SQLERRM);
            ELSE
                logger.log_error
                    ('Unhandled Exception'
                    , l_scope
                    , NULL
                    , l_params
                    );
                RAISE;
            END IF;

    END SAVE_INVOICE;
    
    PROCEDURE SAVE_INVOICEITEM
        ( inout_row                 IN OUT SC_INVOICEITEM%ROWTYPE
        , p_admin_mode              IN     VARCHAR2 DEFAULT NULL
        )
    AS
        l_scope                        logger_logs.scope%TYPE;
        l_params                       logger.tab_param;
        l_dml_type            CONSTANT VARCHAR2 (10 CHAR) := CASE WHEN inout_row.id IS NULL THEN gc_dml_insert ELSE gc_dml_update END ;
        l_result                       NUMBER;
        l_lockname                     VARCHAR2 (128)   := inout_row.id;
        l_lockhandle                   VARCHAR2 (128);
        l_article                      SC_ARTICLE%ROWTYPE := get_article(inout_row.article_id);
        --l_fl_admin                     APEX_USERS.FL_ADMIN%TYPE := SYS_CONTEXT ('oms_context', 'fl_admin');
        --  l_fl_init                      APEX_USERRIGHTS.FL_INIT%TYPE;
       -- l_fl_trade                     APEX_USERRIGHTS.FL_TRADE%TYPE;
        --l_user_is_admin       CONSTANT BOOLEAN := CASE WHEN l_fl_admin = c.yes OR p_admin_mode = c.yes THEN TRUE ELSE FALSE END; 
                                                --combined both of admin flags in order to make it possible to force saving price-alerter-id 
                                                --over admin-mode with p_admin_mode so that status changes can be made in_system to in_system 
                                                --old version: CASE l_fl_admin WHEN c.yes THEN TRUE ELSE FALSE END;

        PROCEDURE l_handle_error (l_error_code PLS_INTEGER, l_message VARCHAR2, ll_params VARARGS DEFAULT NULL)
        AS
            l_formatted_message   VARCHAR2 (1000 CHAR) := FORMATS (l_message, ll_params);
        BEGIN
            logger.log_error (l_formatted_message,
                              l_scope,
                              NULL,
                              l_params);
            l_result := DBMS_LOCK.release (l_lockhandle);
            RAISE_APPLICATION_ERROR (l_error_code, l_formatted_message);
        END l_handle_error;
    BEGIN
        l_scope := gc_scope_prefix || 'save_invoiceitem';

        IF l_lockname IS NOT NULL THEN
            DBMS_LOCK.ALLOCATE_UNIQUE (lockname => l_lockname, lockhandle => l_lockhandle);
            l_result := DBMS_LOCK.request (l_lockhandle, DBMS_LOCK.x_mode);

            IF l_result <> 0 THEN
                RAISE c_ex_cant_lock_row;
            END IF;
        END IF;

        l_params := append_invoiceitem_row_params(INOUT_ROW);
        logger.append_param (p_params => l_params, p_name => 'p_admin_mode',            p_val => p_admin_mode);

        logger.log_information ('SaveRow INVOICEITEM ', l_scope, NULL, l_params);
        
        -- set total
        inout_row.total := ROUND((inout_row.quantity*l_article.price)-COALESCE(inout_row.discount,0),2);
        -- call order_dml
        order_dml
            ( inout_row => inout_row
            , in_dml_type => l_dml_type
            );




        l_result := DBMS_LOCK.release (l_lockhandle);

        logger.log_information('end of the SAVE_INVOICE story, na endlich!',l_scope, null, l_params);
    EXCEPTION
        WHEN c_ex_invalid_changes THEN
			l_handle_error (c_ex_invalid_changes_no, c_ex_invalid_changes_msg);

        WHEN OTHERS THEN
            l_result := DBMS_LOCK.release(l_lockhandle);

            IF SQLCODE BETWEEN -20031 AND -20042
            THEN
                RAISE_APPLICATION_ERROR(SQLCODE, SQLERRM);
            ELSE
                logger.log_error
                    ('Unhandled Exception'
                    , l_scope
                    , NULL
                    , l_params
                    );
                RAISE;
            END IF;

    END SAVE_INVOICEITEM;
    


    PROCEDURE delete_row (in_sc_invoice_id IN sc_invoice.id%TYPE)
    AS
        l_scope      logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params     logger.tab_param;
        l_row        sc_invoice%ROWTYPE;


        PROCEDURE l_handle_error (l_error_code PLS_INTEGER, l_message VARCHAR2, l_params VARARGS DEFAULT NULL)
        AS
            l_formatted_message   VARCHAR2 (1000 CHAR) := FORMATS (l_message, l_params);
        BEGIN
            logger.log_error (l_formatted_message, l_scope);
            RAISE_APPLICATION_ERROR (l_error_code, l_formatted_message);
        END l_handle_error;
    BEGIN
        logger.append_param (p_params => l_params, p_name => 'in_sc_invoice_id', p_val => in_sc_invoice_id);
        logger.log_information (l_scope,
                                l_scope,
                                NULL,
                                l_params);
        logger.log_information ('{', l_scope);
        l_row := get_invoice (in_sc_invoice_id, c.yes);

        ORDER_DML (inout_row => l_row, in_dml_type => gc_dml_delete);


    EXCEPTION
        WHEN c_ex_invalid_order
        THEN
            logger.log_error ('UngÃ¼ltige Order ID ' || in_sc_invoice_id || ' fÃ¼r delete_row angegeben',
                              l_scope,
                              NULL,
                              l_params);
            RAISE_APPLICATION_ERROR (c_ex_invalid_order_no,
                                     'UngÃ¼ltige Order ID ' || in_sc_invoice_id || ' fÃ¼r delete_row angegeben');
        WHEN OTHERS
        THEN
            logger.log_error ('Unhandled Exception',
                              l_scope,
                              NULL,
                              l_params);
            RAISE;
    END delete_row;

    PROCEDURE ORDER_DML ( inout_row IN OUT SC_INVOICE%ROWTYPE
                        , in_dml_type IN VARCHAR2)
    AS
        l_scope               logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params              logger.tab_param;
    BEGIN
        l_params := append_invoice_row_params(INOUT_ROW);
        
        logger.append_param (p_params   => l_params,
                             p_name     => 'in_dml_type',
                             p_val      => in_dml_type);

        
        logger.log(in_dml_type||' Action ', l_scope, null, l_params);
        
        inout_row.moduser := V('APP_USER');
        
        CASE in_dml_type
            WHEN gc_dml_insert
            THEN
                inout_row.id := COALESCE(inout_row.id,SEQ_ID.NEXTVAL);
                inout_row.created := SYSTIMESTAMP;
                
                INSERT INTO   sc_invoice
                     VALUES   inout_row;
            WHEN gc_dml_update
            THEN
               inout_row.updated := SYSTIMESTAMP;

                UPDATE sc_invoice oo
                   SET ROW = inout_row
                 WHERE oo.id = inout_row.id;
            WHEN gc_dml_delete
            THEN
                DELETE FROM sc_invoice o
                      WHERE   o.id = inout_row.id;
        END CASE;
        
        insert_invoice_history(inout_row);
    END ORDER_DML;	
    
    PROCEDURE ORDER_DML (inout_row IN OUT SC_INVOICEITEM%ROWTYPE, in_dml_type IN VARCHAR2)
    AS
        l_scope               logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params              logger.tab_param;
    BEGIN
        l_params := append_invoiceitem_row_params(INOUT_ROW);
        logger.append_param (p_params   => l_params,
                             p_name     => 'in_dml_type',
                             p_val      => in_dml_type);

       
        logger.log(in_dml_type||' Action ', l_scope, null, l_params);
             
        CASE in_dml_type
            WHEN gc_dml_insert
            THEN
                inout_row.id := COALESCE(inout_row.id,SEQ_ID.NEXTVAL);
                inout_row.created := SYSTIMESTAMP;
                
                INSERT INTO   sc_invoiceitem
                     VALUES   inout_row;
                
                 API_SMARTCASH.INCREASE_FREQ(inout_row.article_id);
            WHEN gc_dml_update
            THEN
               inout_row.updated := SYSTIMESTAMP;

                UPDATE sc_invoiceitem oo
                   SET ROW = inout_row
                 WHERE oo.id = inout_row.id;
            WHEN gc_dml_delete
            THEN
                DELETE FROM sc_invoiceitem o
                      WHERE   o.id = inout_row.id;
        END CASE;
        
        insert_invoiceitem_history(inout_row);
        
    END ORDER_DML;	

    FUNCTION SAVE_IMAGE(filename    IN VARCHAR2
                      ,mimetype     IN VARCHAR2
                      ,image        IN BLOB
                      ,id           IN NUMBER DEFAULT NULL)
        RETURN SC_IMG.ID%TYPE
    IS
        l_row SC_IMG%ROWTYPE;
        l_scope               logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params              logger.tab_param;
        l_dml_type   CONSTANT VARCHAR2 (10 CHAR) := CASE WHEN id IS NULL OR EXIST_IMAGE(id) = 0 
                                                         THEN c.gc_dml_insert 
                                                         ELSE c.gc_dml_update END;
    BEGIN
        logger.append_param (p_params   => l_params,
                             p_name     => 'filename',
                             p_val      => filename);
        logger.append_param (p_params   => l_params,
                             p_name     => 'mimetype',
                             p_val      => mimetype);
        logger.append_param (p_params   => l_params,
                             p_name     => 'image.length',
                             p_val      => LENGTH(image));
        logger.append_param (p_params   => l_params,
                             p_name     => 'id',
                             p_val      => id);
        logger.append_param (p_params   => l_params,
                             p_name     => 'l_dml_type',
                             p_val      => l_dml_type);


        l_row.id := COALESCE(id,SEQ_ID.NEXTVAL);
        l_row.mimetype := mimetype;
        l_row.img := image;
        l_row.filename := filename;
        l_row.updated := systimestamp;

        logger.append_param (p_params   => l_params,
                             p_name     => 'l_row.id',
                             p_val      =>  l_row.id);
        logger.log('inserting image with following params'
                    ,l_scope
                    ,null
                    ,l_params);

        SAVE_IMAGE(l_row,l_dml_type);
        return l_row.id;
    END SAVE_IMAGE;

    PROCEDURE SAVE_IMAGE(in_img_row IN OUT SC_IMG%ROWTYPE
                        ,action IN VARCHAR2)
    AS
        l_scope               logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params              logger.tab_param;
    BEGIN
        in_img_row.id := COALESCE(in_img_row.id,SEQ_ID.NEXTVAL);

        IF action = c.gc_dml_insert
        THEN
            INSERT INTO   SC_IMG
                 VALUES   in_img_row;
        ELSE
            UPDATE SC_IMG
               SET ROW = in_img_row
             WHERE ID = in_img_row.id;
        END IF;
        
        
        logger.log('inserting image with following params'
                    ,l_scope
                    ,null
                    ,l_params);
        COMMIT;
        
      /*  ADD_DEP(  IN_COMPANY_ID         => in_row.company_id 
                , IN_NAME               => CASE WHEN in_row.canceled IS NOT NULL
                                                THEN 'Cashbook Entry canceled'
                                                ELSE 'Cashbook Entry'
                                           END      
                , IN_DESCRIPTION        => CASE WHEN in_row.canceled IS NOT NULL
                                                THEN APEX_STRING.FORMAT('Canceled, Reason: %s',in_row.cancel_reason)
                                                ELSE APEX_STRING.FORMAT('%0 - %1  %2'
                                                                        ,l_in_out_text
                                                                        ,in_row.CATEGORY
                                                                        ,CASE WHEN in_row.invoice_id IS NOT NULL THEN ' - InvoiceID: '||in_row.invoice_id END)
                                           END 
                , IN_SUBJECT            => APEX_STRING.FORMAT('Entry ID: %0',in_row.ID) 
                , IN_AMOUNT_GROSS       => in_row.AMOUNT_GROSS 
                , IN_AMOUNT_NET         => in_row.AMOUNT_NET  
                , IN_AMOUNT_TAX         => in_row.AMOUNT_TAX
                , IN_ISSUE              => 'BON' --(PDF/EMAIL/etc.)
                );*/
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            logger.log_error('no_data_found for given img_id '||in_img_row.id
                            ,l_scope
                            ,null
                            ,l_params);
        WHEN OTHERS
        THEN
            logger.log_error('unhandled exception'
                            ,l_scope
                            ,null
                            ,l_params);
    END SAVE_IMAGE;

    FUNCTION EXIST_IMAGE(in_sc_img_id IN SC_IMG.ID%TYPE)
        RETURN NUMBER
    IS
        l_exist NUMBER := 0;
    BEGIN
        SELECT count(*)
          INTO l_exist
          FROM SC_IMG
         WHERE ID = in_sc_img_id;

        RETURN l_exist;
    END EXIST_IMAGE;
    
    
    PROCEDURE INCREASE_FREQ(in_article_id IN NUMBER)
    AS
        l_scope               logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params              logger.tab_param;
    BEGIN
         UPDATE sc_article 
            SET freq = freq+1 
          WHERE id = in_article_id;
        
    EXCEPTION
        WHEN OTHERS
        THEN
            logger.log_error ('Unhandled Exception',
                              l_scope,
                              NULL,
                              l_params);
            RAISE;
    END INCREASE_FREQ;
    
    PROCEDURE CANCEL_INVOICE(in_invoice_id IN SC_INVOICE.ID%TYPE
                            ,in_cancel_reason IN SC_INVOICE.CANCEL_REASON%TYPE)
    AS
        l_invoice SC_INVOICE%ROWTYPE := get_invoice(in_invoice_id);
        l_scope               logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params              logger.tab_param;
    BEGIN
        logger.append_param (p_params   => l_params,
                             p_name     => 'in_invoice_id',
                             p_val      =>  in_invoice_id);
        logger.append_param (p_params   => l_params,
                             p_name     => 'in_cancel_reason',
                             p_val      =>  in_cancel_reason);
        logger.log('invoice CANCELATION',l_scope,null,l_params);
        
        l_invoice.cancel_reason := in_cancel_reason;
        l_invoice.canceled := SYSTIMESTAMP;
        l_invoice.status := 'Canceled';
    
        SAVE_INVOICE(l_invoice);
    
    EXCEPTION
        WHEN OTHERS
        THEN
            logger.log_error ('Unhandled Exception',
                              l_scope,
                              NULL,
                              l_params);
            RAISE;
    END CANCEL_INVOICE;
    
    FUNCTION GET_PAYMENT_ID(in_payment_name IN SC_PAYMENT.NAME%TYPE)
        RETURN NUMBER
    IS
        l_scope               logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params              logger.tab_param;
        l_payment_id NUMBER;
    BEGIN
        SELECT ID 
          INTO l_payment_id
          FROM SC_PAYMENT
         WHERE UPPER(NAME) = UPPER(in_payment_name);
        
        RETURN l_payment_id;
    EXCEPTION
        WHEN OTHERS
        THEN
            logger.log_error('no payment found '||in_payment_name,l_scope,null,l_params);
            RETURN 0;
            --RAISE;
            
    END GET_PAYMENT_ID;
    
    FUNCTION get_payment( in_payment_id IN SC_PAYMENT.ID%TYPE
                        , in_raise_no_data_found VARCHAR2 DEFAULT 'N')
        RETURN SC_PAYMENT%ROWTYPE
   
    --returns null row on not found id
    AS
        l_scope       logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params      logger.tab_param;
        l_row_count   PLS_INTEGER;
        l_row         SC_PAYMENT%ROWTYPE;
    BEGIN
        logger.append_param ( p_params => l_params
                            , p_name   => 'in_payment_id'
                            , p_val     => in_payment_id);
        logger.append_param ( p_params  => l_params
                            , p_name    => 'in_raise_no_data_found'
                            , p_val     => in_raise_no_data_found);
        logger.log_information ('get_payment',
                                l_scope,
                                NULL,
                                l_params);

        SELECT   COUNT (*)
          INTO   l_row_count
          FROM   SC_PAYMENT p
         WHERE   p.id = in_payment_id;

        IF l_row_count = 1
        THEN
            SELECT   *
              INTO   l_row
              FROM   SC_PAYMENT p
             WHERE   p.id = in_payment_id;
        ELSE
            IF in_raise_no_data_found = c.yes
            THEN
                RAISE NO_DATA_FOUND;
            END IF;
        END IF;

        RETURN l_row;
    EXCEPTION
        WHEN OTHERS
        THEN
            logger.log_error ('Unhandled Exception',
                              l_scope,
                              NULL,
                              l_params);
            RAISE;
    END get_payment;
    
    FUNCTION get_user (in_user_id IN SC_APEX_USERS.ID%TYPE
                             , in_raise_no_data_found VARCHAR2 DEFAULT 'N')
        RETURN SC_APEX_USERS%ROWTYPE
   
    --returns null row on not found id
    AS
        l_scope       logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params      logger.tab_param;
        l_row_count   PLS_INTEGER;
        l_row         SC_APEX_USERS%ROWTYPE;
    BEGIN
        logger.append_param (p_params => l_params, p_name => 'in_user_id', p_val => in_user_id);
        logger.append_param (p_params => l_params, p_name => 'in_raise_no_data_found', p_val => in_raise_no_data_found);
        logger.log_information ('get_user',
                                l_scope,
                                NULL,
                                l_params);

        SELECT   COUNT (*)
          INTO   l_row_count
          FROM   SC_APEX_USERS a
         WHERE   a.id = in_user_id;

        IF l_row_count = 1
        THEN
            SELECT   *
              INTO   l_row
              FROM   SC_APEX_USERS a
             WHERE   a.id = in_user_id;
        ELSE
            IF in_raise_no_data_found = c.yes
            THEN
                RAISE NO_DATA_FOUND;
            END IF;
        END IF;

        RETURN l_row;
    EXCEPTION
        WHEN OTHERS
        THEN
            logger.log_error ('Unhandled Exception',
                              l_scope,
                              NULL,
                              l_params);
            RAISE;
    END get_user;
    
    FUNCTION GET_USER (in_username IN SC_APEX_USERS.USERNAME%TYPE
                        , in_raise_no_data_found VARCHAR2 DEFAULT 'N')
        RETURN SC_APEX_USERS%ROWTYPE
   
    --returns null row on not found id
    AS
        l_scope       logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params      logger.tab_param;
        l_row_count   PLS_INTEGER;
        l_row         SC_APEX_USERS%ROWTYPE;
    BEGIN
        logger.append_param (p_params => l_params, p_name => 'in_username', p_val => in_username);
        logger.append_param (p_params => l_params, p_name => 'in_raise_no_data_found', p_val => in_raise_no_data_found);
        logger.log_information ('GET_USER by username',
                                l_scope,
                                NULL,
                                l_params);

        SELECT   COUNT (*)
          INTO   l_row_count
          FROM   SC_APEX_USERS a
         WHERE   UPPER(a.username) = UPPER(in_username);

        IF l_row_count = 1
        THEN
            SELECT   *
              INTO   l_row
              FROM   SC_APEX_USERS a
             WHERE    UPPER(a.username) = UPPER(in_username);
        ELSE
            IF in_raise_no_data_found = c.yes
            THEN
                RAISE NO_DATA_FOUND;
            END IF;
        END IF;

        RETURN l_row;
    EXCEPTION
        WHEN OTHERS
        THEN
            logger.log_error ('Unhandled Exception',
                              l_scope,
                              NULL,
                              l_params);
            RAISE;
    END GET_USER;
    
    PROCEDURE ADD_DEP
        ( IN_COMPANY_ID NUMBER 
        , IN_NAME VARCHAR2 
        , IN_DESCRIPTION VARCHAR2 
        , IN_SUBJECT VARCHAR2 
       /* , IN_OLDVALUE VARCHAR2 
        , IN_NEWVALUE VARCHAR2 
        , IN_PROGRAMMVERSION  VARCHAR2 
        , IN_CASHREGISTER_ID  NUMBER 
        , IN_FL_DEMO  VARCHAR2 
        , IN_AMOUNT NUMBER */
        , IN_AMOUNT_GROSS  NUMBER 
        , IN_AMOUNT_NET  NUMBER 
        , IN_AMOUNT_TAX NUMBER 
        , IN_ISSUE VARCHAR2
        )
    AS
        l_scope                        logger_logs.scope%TYPE :=  gc_scope_prefix || 'ADD_DEP';
        l_params                       logger.tab_param;
        l_row                          SC_DEP%ROWTYPE;
    BEGIN
        l_row.company_id := IN_COMPANY_ID;
        l_row.name := IN_NAME;
        l_row.DESCRIPTION := IN_DESCRIPTION;
        l_row.subject := IN_SUBJECT;
        --todo calculate these fields
       /* l_row.oldvalue := IN_OLDVALUE;
        l_row.newvalue := IN_NEWVALUE;
        l_row.programmversion := IN_PROGRAMMVERSION;
        l_row.cashregister_id := IN_CASHREGISTER_ID;
        l_row.fl_demo := IN_FL_DEMO;
        l_row.amount := IN_AMOUNT;*/
        l_row.amount_gross := IN_AMOUNT_GROSS;
        l_row.amount_net := IN_AMOUNT_NET;
        l_row.amount_tax := IN_AMOUNT_TAX;
        l_row.issue := IN_ISSUE;
        
        ADD_DEP(l_row);
        
    END ADD_DEP;
    
    FUNCTION CALC_CASHBOOK
        RETURN NUMBER
    IS
        l_cashbook_result NUMBER := 0;
    BEGIN
        SELECT COALESCE(SUM(COALESCE(amount_gross,0)),0)
          INTO l_cashbook_result
          FROM SC_CASHBOOK;
          
        RETURN l_cashbook_result;
    END CALC_CASHBOOK;
    
    PROCEDURE ADD_DEP
        ( in_row                 IN OUT SC_DEP%ROWTYPE
        )
    AS
        l_scope         logger_logs.scope%TYPE :=  gc_scope_prefix || 'ADD_DEP';
        l_params        logger.tab_param;
        l_cashreg       SC_CASHREGISTER%ROWTYPE := GET_CASHREGISTER(in_row.COMPANY_ID); 
    BEGIN
        IF UPPER(in_row.name) = 'CASHBOOK ENTRY'
        THEN
            in_row.newvalue := calc_cashbook;
            in_row.oldvalue := ROUND(in_row.newvalue-in_row.amount_gross,2);
        END IF;
        
        in_row.CREATED := sysdate;
        in_row.UPDATED := sysdate;
        in_row.MODUSER := V('APP_USER');
        in_row.PROGRAMMVERSION := l_cashreg.VERSION;
        in_row.CASHREGISTER_ID := l_cashreg.ID;
        in_row.FL_DEMO := CASE WHEN l_cashreg."MODE" = 'NORMAL' THEN 'N' ELSE 'Y' END;
        
        logger.append_param ( p_params => l_params 
                            , p_name => 'in_row.company_id'           
                            , p_val => in_row.company_id);
        logger.append_param ( p_params => l_params 
                            , p_name => 'in_row.name'           
                            , p_val => in_row.name);                  
        logger.append_param ( p_params => l_params 
                            , p_name => 'in_row.description'           
                            , p_val => in_row.description);
        logger.append_param ( p_params => l_params 
                            , p_name => 'in_row.subject'           
                            , p_val => in_row.subject);
        logger.append_param ( p_params => l_params 
                            , p_name => 'in_row.oldvalue'           
                            , p_val => in_row.oldvalue);                   
        logger.append_param ( p_params => l_params 
                            , p_name => 'in_row.newvalue'           
                            , p_val => in_row.newvalue);
        logger.append_param ( p_params => l_params 
                            , p_name => 'in_row.programmversion'           
                            , p_val => in_row.programmversion);
        logger.append_param ( p_params => l_params 
                            , p_name => 'in_row.cashregister_id'           
                            , p_val => in_row.cashregister_id);
        logger.append_param ( p_params => l_params 
                            , p_name => 'in_row.fl_demo'           
                            , p_val => in_row.fl_demo);
        logger.append_param ( p_params => l_params 
                            , p_name => 'in_row.amount'           
                            , p_val => in_row.amount);
        logger.append_param ( p_params => l_params 
                            , p_name => 'in_row.amount_gross'           
                            , p_val => in_row.amount_gross);                  
        logger.append_param ( p_params => l_params 
                            , p_name => 'in_row.amount_net'           
                            , p_val => in_row.amount_net);
        logger.append_param ( p_params => l_params 
                            , p_name => 'in_row.amount_tax'           
                            , p_val => in_row.amount_tax);              
        logger.append_param ( p_params => l_params 
                            , p_name => 'in_row.issue'           
                            , p_val => in_row.issue);
         logger.append_param ( p_params => l_params 
                            , p_name => 'in_row.CREATED'           
                            , p_val => in_row.CREATED);
        logger.append_param ( p_params => l_params 
                            , p_name => 'in_row.UPDATED'           
                            , p_val => in_row.UPDATED);              
        logger.append_param ( p_params => l_params 
                            , p_name => 'in_row.MODUSER'           
                            , p_val => in_row.MODUSER);
                            
                            
        logger.log_information ('ADD DEP ', l_scope, NULL, l_params);
        
        INSERT INTO SC_DEP VALUES in_row;
        --COMMIT;
       
    EXCEPTION
        WHEN OTHERS THEN
            logger.log_error
                    ('Unhandled Exception'
                    , l_scope
                    , NULL
                    , l_params
                    );
            RAISE;

    END ADD_DEP;
    
    FUNCTION GET_COMPANY_ID (in_username IN SC_APEX_USERS.USERNAME%TYPE
                             , in_raise_no_data_found VARCHAR2 DEFAULT 'N')
        RETURN NUMBER
   
    --returns null row on not found id
    AS
        l_scope       logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params      logger.tab_param;
        l_user_row    SC_APEX_USERS%ROWTYPE := GET_USER(in_username);
    BEGIN
        logger.append_param (p_params => l_params, p_name => 'in_username', p_val => in_username);
        logger.append_param (p_params => l_params, p_name => 'company_id', p_val => l_user_row.company_id);
        logger.append_param (p_params => l_params, p_name => 'in_raise_no_data_found', p_val => in_raise_no_data_found);
        logger.log_information ('GET_COMPANY_ID',
                                l_scope,
                                NULL,
                                l_params);
        RETURN l_user_row.company_id;
    EXCEPTION
        WHEN OTHERS
        THEN
            logger.log_error ('Unhandled Exception',
                              l_scope,
                              NULL,
                              l_params);
            RAISE;
    END GET_COMPANY_ID;
    
    FUNCTION GET_MAX_BELEGNR
        RETURN NUMBER
    IS
        l_max_belegnr NUMBER;
    BEGIN
        SELECT COALESCE(MAX(BELEGNR),0)
          INTO l_max_belegnr
          FROM SC_CASHBOOK;
        RETURN l_max_belegnr;
    END GET_MAX_BELEGNR;
    
    PROCEDURE SAVE_CASHBOOK
        ( in_row                 IN OUT SC_CASHBOOK%ROWTYPE
        )
    AS
        l_scope                 logger_logs.scope%TYPE :=  gc_scope_prefix || 'SAVE_CASHBOOK';
        l_params                logger.tab_param;
        l_last_belegnr          NUMBER := GET_MAX_BELEGNR;
        l_in_out_text           VARCHAR2(20) := CASE in_row.type WHEN 'OUT' THEN 'Outgoing' ELSE 'Incoming' END;
    BEGIN
        
          
        in_row.CREATED := sysdate;
        in_row.UPDATED := sysdate;
        in_row.MODUSER := V('APP_USER');
        in_row.BELEGNR := l_last_belegnr + 1;
        in_row.company_id := COALESCE(in_row.company_id,GET_COMPANY_ID(V('APP_USER')));
        
        logger.append_param ( p_params => l_params 
                            , p_name => 'in_row.company_id'           
                            , p_val => in_row.company_id);
        logger.append_param ( p_params => l_params 
                            , p_name => 'in_row.BELEGNR'           
                            , p_val => in_row.BELEGNR); 
        logger.append_param ( p_params => l_params 
                            , p_name => 'in_row.TYPE'           
                            , p_val => in_row.TYPE);                  
        logger.append_param ( p_params => l_params 
                            , p_name => 'in_row.CATEGORY'           
                            , p_val => in_row.CATEGORY);
        logger.append_param ( p_params => l_params 
                            , p_name => 'in_row.INVOICE_ID'           
                            , p_val => in_row.INVOICE_ID);
        logger.append_param ( p_params => l_params 
                            , p_name => 'in_row.DESCRIPTION'           
                            , p_val => in_row.DESCRIPTION);
        logger.append_param ( p_params => l_params 
                            , p_name => 'in_row.AMOUNT_GROSS'           
                            , p_val => in_row.AMOUNT_GROSS);                   
        logger.append_param ( p_params => l_params 
                            , p_name => 'in_row.AMOUNT_NET'           
                            , p_val => in_row.AMOUNT_NET);
        logger.append_param ( p_params => l_params 
                            , p_name => 'in_row.AMOUNT_TAX'           
                            , p_val => in_row.AMOUNT_TAX);
        logger.append_param ( p_params => l_params 
                            , p_name => 'in_row.UST'           
                            , p_val => in_row.UST);
        logger.append_param ( p_params => l_params 
                            , p_name => 'in_row.DELIVERY_ID'           
                            , p_val => in_row.DELIVERY_ID);
        logger.append_param ( p_params => l_params 
                            , p_name => 'in_row.CANCELED'           
                            , p_val => in_row.CANCELED);
        logger.append_param ( p_params => l_params 
                            , p_name => 'in_row.CANCEL_REASON'           
                            , p_val => in_row.CANCEL_REASON);                  
         logger.append_param ( p_params => l_params 
                            , p_name => 'in_row.CREATED'           
                            , p_val => in_row.CREATED);
        logger.append_param ( p_params => l_params 
                            , p_name => 'in_row.UPDATED'           
                            , p_val => in_row.UPDATED);              
        logger.append_param ( p_params => l_params 
                            , p_name => 'in_row.MODUSER'           
                            , p_val => in_row.MODUSER);
                            
                            
        logger.log_information ('SAVE_CASHBOOK ', l_scope, NULL, l_params);
        
        INSERT INTO SC_CASHBOOK 
             VALUES in_row
             RETURNING ID INTO in_row.id;
             
       COMMIT;
       
        ADD_DEP(  IN_COMPANY_ID         => in_row.company_id 
                , IN_NAME               => CASE WHEN in_row.canceled IS NOT NULL
                                                THEN 'Cashbook Entry canceled'
                                                ELSE 'Cashbook Entry'
                                           END      
                , IN_DESCRIPTION        => CASE WHEN in_row.canceled IS NOT NULL
                                                THEN APEX_STRING.FORMAT('Canceled, Reason: %s',in_row.cancel_reason)
                                                ELSE APEX_STRING.FORMAT('%0 - %1  %2'
                                                                        ,l_in_out_text
                                                                        ,in_row.CATEGORY
                                                                        ,CASE WHEN in_row.invoice_id IS NOT NULL THEN ' - InvoiceID: '||in_row.invoice_id END)
                                           END 
                , IN_SUBJECT            => APEX_STRING.FORMAT('Entry ID: %0',in_row.ID) 
                , IN_AMOUNT_GROSS       => in_row.AMOUNT_GROSS 
                , IN_AMOUNT_NET         => in_row.AMOUNT_NET  
                , IN_AMOUNT_TAX         => in_row.AMOUNT_TAX
                , IN_ISSUE              => 'BON' --(PDF/EMAIL/etc.)
                );
        
         
    EXCEPTION
        WHEN OTHERS THEN
            logger.log_error
                    ('Unhandled Exception'
                    , l_scope
                    , NULL
                    , l_params
                    );
            RAISE;

    END SAVE_CASHBOOK;
    
    PROCEDURE SAVE_CASHBOOK
        ( IN_COMPANY_ID NUMBER 
        , IN_TYPE VARCHAR2 
        , IN_CATEGORY VARCHAR2
        , IN_AMOUNT_GROSS  NUMBER
        , IN_INVOICE_ID NUMBER DEFAULT NULL
        , IN_DESCRIPTION VARCHAR2 DEFAULT NULL
        , IN_AMOUNT_NET  NUMBER DEFAULT NULL
        , IN_AMOUNT_TAX NUMBER DEFAULT NULL
        , IN_UST NUMBER DEFAULT NULL
        , IN_DELIVERY_ID NUMBER DEFAULT NULL
        , IN_CANCELED TIMESTAMP DEFAULT NULL
        , IN_CANCEL_REASON VARCHAR2 DEFAULT NULL
        )
    AS
        l_scope                        logger_logs.scope%TYPE :=  gc_scope_prefix || 'SAVE_CASHBOOK';
        l_params                       logger.tab_param;
        l_row                          SC_CASHBOOK%ROWTYPE;
    BEGIN
        l_row.company_id := IN_COMPANY_ID;
        l_row.type := IN_TYPE;
        l_row.category := IN_CATEGORY;
        l_row.invoice_id := IN_INVOICE_ID;
        l_row.DESCRIPTION := IN_DESCRIPTION;
        l_row.amount_gross := IN_AMOUNT_GROSS;
        l_row.amount_net := IN_AMOUNT_NET;
        l_row.amount_tax := IN_AMOUNT_TAX;
        l_row.ust := IN_UST;
        l_row.delivery_id := IN_DELIVERY_ID;
        l_row.canceled := IN_CANCELED;
        l_row.cancel_reason := IN_CANCEL_REASON;
        
        SAVE_CASHBOOK(l_row);
        
    END SAVE_CASHBOOK;
    
    FUNCTION GET_CASHREGISTER( in_company_id IN NUMBER
                                , in_raise_no_data_found VARCHAR2 DEFAULT 'N')
        RETURN SC_CASHREGISTER%ROWTYPE
   
    --returns null row on not found id
    AS
        l_scope       logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params      logger.tab_param;
        l_row_count   PLS_INTEGER;
        l_row         SC_CASHREGISTER%ROWTYPE;
    BEGIN
        logger.append_param (p_params => l_params, p_name => 'in_company_id', p_val => in_company_id);
        logger.append_param (p_params => l_params, p_name => 'in_raise_no_data_found', p_val => in_raise_no_data_found);
        logger.log_information ('GET_CASHREGISTER by company_id',
                                l_scope,
                                NULL,
                                l_params);

        SELECT   COUNT (*)
          INTO   l_row_count
          FROM   SC_CASHREGISTER 
         WHERE   company_id = in_company_id;

        IF l_row_count = 1
        THEN
            SELECT   *
              INTO   l_row
              FROM   SC_CASHREGISTER 
             WHERE   company_id = in_company_id;
        ELSE
            IF in_raise_no_data_found = c.yes
            THEN
                RAISE NO_DATA_FOUND;
            END IF;
        END IF;

        RETURN l_row;
    EXCEPTION
        WHEN OTHERS
        THEN
            logger.log_error ('Unhandled Exception',
                              l_scope,
                              NULL,
                              l_params);
            RAISE;
    END GET_CASHREGISTER;
    
    FUNCTION GET_TAX( in_tax_id IN NUMBER
                    , in_raise_no_data_found VARCHAR2 DEFAULT 'N')
        RETURN VARCHAR2
   
    --returns null row on not found id
    AS
        l_scope       logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params      logger.tab_param;
        l_tax_name    VARCHAR2(50); 
    BEGIN
        logger.append_param (p_params => l_params, p_name => 'in_tax_id', p_val => in_tax_id);
        logger.append_param (p_params => l_params, p_name => 'in_raise_no_data_found', p_val => in_raise_no_data_found);
        logger.log_information ('GET_TAX',
                                l_scope,
                                NULL,
                                l_params);
        SELECT name
          INTO l_tax_name
          FROM SC_TAX
          WHERE id = in_tax_id;
        
        RETURN l_tax_name;
    EXCEPTION
        WHEN OTHERS
        THEN
            logger.log_error ('Unhandled Exception',
                              l_scope,
                              NULL,
                              l_params);
            IF in_raise_no_data_found = 'Y'
            THEN
                RAISE;
            END IF;
    END GET_TAX;
    
    FUNCTION GET_CATEGORY( in_category_id IN NUMBER
                         , in_raise_no_data_found VARCHAR2 DEFAULT 'N')
        RETURN VARCHAR2
   
    --returns null row on not found id
    AS
        l_scope       logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params      logger.tab_param;
        l_category_name    VARCHAR2(50); 
    BEGIN
        logger.append_param (p_params => l_params, p_name => 'in_category_id', p_val => in_category_id);
        logger.append_param (p_params => l_params, p_name => 'in_raise_no_data_found', p_val => in_raise_no_data_found);
        logger.log_information ('GET_TAX',
                                l_scope,
                                NULL,
                                l_params);
        SELECT name
          INTO l_category_name
          FROM SC_CATEGORY
          WHERE id = in_category_id;
        
        RETURN l_category_name;
    EXCEPTION
        WHEN OTHERS
        THEN
            logger.log_error ('Unhandled Exception',
                              l_scope,
                              NULL,
                              l_params);
            IF in_raise_no_data_found = 'Y'
            THEN
                RAISE;
            END IF;
    END GET_CATEGORY;
    
    FUNCTION GET_PRINTER( in_printer_id IN NUMBER
                         , in_raise_no_data_found VARCHAR2 DEFAULT 'N')
        RETURN VARCHAR2
   
    --returns null row on not found id
    AS
        l_scope       logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params      logger.tab_param;
        l_printer_name    VARCHAR2(50); 
    BEGIN
        logger.append_param (p_params => l_params, p_name => 'in_printer_id', p_val => in_printer_id);
        logger.append_param (p_params => l_params, p_name => 'in_raise_no_data_found', p_val => in_raise_no_data_found);
        logger.log_information ('GET_TAX',
                                l_scope,
                                NULL,
                                l_params);
        SELECT name
          INTO l_printer_name
          FROM SC_PRINTER
          WHERE id = l_printer_name;
        
        RETURN l_printer_name;
    EXCEPTION
        WHEN OTHERS
        THEN
            logger.log_error ('Unhandled Exception',
                              l_scope,
                              NULL,
                              l_params);
            IF in_raise_no_data_found = 'Y'
            THEN
                RAISE;
            END IF;
    END GET_PRINTER;
     
END API_SMARTCASH;