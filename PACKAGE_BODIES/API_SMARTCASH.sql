CREATE OR REPLACE PACKAGE BODY MACDENIZ."API_SMARTCASH"
IS
    gc_scope_prefix      CONSTANT VARCHAR2 (31) := LOWER ($$plsql_unit) || '.';
    g_row_before                  sc_invoice%ROWTYPE;
    g_log_diff_enabled            BOOLEAN := TRUE;
    gc_dml_insert        CONSTANT VARCHAR2 (10 CHAR) := 'INSERT';
    gc_dml_update        CONSTANT VARCHAR2 (10 CHAR) := 'UPDATE';
    gc_dml_delete        CONSTANT VARCHAR2 (10 CHAR) := 'DELETE';

    

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

    FUNCTION get_row (in_invoice_id IN SC_INVOICE.ID%TYPE, in_raise_no_data_found VARCHAR2 DEFAULT 'N')
        RETURN SC_INVOICE%ROWTYPE
    --Wrapper für SELECT * INTO WHERE ord_id = [ID]
    --Gibt leere Row zurück falls die ID noch nicht exisitiert
    AS
        l_scope       logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params      logger.tab_param;
        l_row_count   PLS_INTEGER;
        l_row         SC_INVOICE%ROWTYPE;
    BEGIN
        logger.append_param (p_params => l_params, p_name => 'in_invoice_id', p_val => in_invoice_id);
        logger.append_param (p_params => l_params, p_name => 'in_raise_no_data_found', p_val => in_raise_no_data_found);
        logger.log_information ('get_row',
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
    END get_row;

    
    PROCEDURE INSERT_INVOICE_HISTORY(i_sc_invoice_row IN SC_INVOICE%ROWTYPE)
    AS
       l_hist_row SC_INVOICE_JN%ROWTYPE;
      BEGIN
        l_hist_row.id            := i_sc_invoice_row.id;
        l_hist_row.total         := i_sc_invoice_row.total;
        l_hist_row.discount      := i_sc_invoice_row.discount;
        l_hist_row.payment_id    := i_sc_invoice_row.payment_id;
        l_hist_row.created    	 := SYSTIMESTAMP;
       -- l_hist_row.action       := i_ord_row.updated;
        l_hist_row.customer_id   := i_sc_invoice_row.customer_id;
        l_hist_row.canceled      := i_sc_invoice_row.canceled;
        l_hist_row.cancel_reason := i_sc_invoice_row.cancel_reason;
        
        INSERT INTO SC_INVOICE_JN VALUES l_hist_row;
    END INSERT_INVOICE_HISTORY;

    FUNCTION append_oms_row_params(i_sc_invoice_row IN SC_INVOICE%ROWTYPE) RETURN logger.tab_param
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
    END append_oms_row_params;

    PROCEDURE SAVE_ROW
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
        l_scope := gc_scope_prefix || 'save_row';

        IF l_lockname IS NOT NULL THEN
            DBMS_LOCK.ALLOCATE_UNIQUE (lockname => l_lockname, lockhandle => l_lockhandle);
            l_result := DBMS_LOCK.request (l_lockhandle, DBMS_LOCK.x_mode);

            IF l_result <> 0 THEN
                RAISE c_ex_cant_lock_row;
            END IF;
        END IF;

        l_params := append_oms_row_params(INOUT_ROW);
        logger.append_param (p_params => l_params, p_name => 'p_admin_mode',            p_val => p_admin_mode);
    
        logger.log_information ('SaveRow ENTRY', l_scope, NULL, l_params);

    
		logger.log('call insert_order_history', l_scope, null, l_params);
		insert_invoice_history(inout_row);
        
        -- call order_dml
        order_dml
            ( inout_row => inout_row
            , in_dml_type => l_dml_type
            );
		
		
		

        l_result := DBMS_LOCK.release (l_lockhandle);

        logger.log_information('end of the save_row story, na endlich!',l_scope, null, l_params);
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

    END save_row;

   
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
        l_row := get_row (in_sc_invoice_id, c.yes);

        ORDER_DML (inout_row => l_row, in_dml_type => gc_dml_delete);

      
    EXCEPTION
        WHEN c_ex_invalid_order
        THEN
            logger.log_error ('Ungültige Order ID ' || in_sc_invoice_id || ' für delete_row angegeben',
                              l_scope,
                              NULL,
                              l_params);
            RAISE_APPLICATION_ERROR (c_ex_invalid_order_no,
                                     'Ungültige Order ID ' || in_sc_invoice_id || ' für delete_row angegeben');
        WHEN OTHERS
        THEN
            logger.log_error ('Unhandled Exception',
                              l_scope,
                              NULL,
                              l_params);
            RAISE;
    END delete_row;

   

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

     PROCEDURE ORDER_DML (inout_row IN OUT SC_INVOICE%ROWTYPE, in_dml_type IN VARCHAR2)
    AS
        l_scope               logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params              logger.tab_param;
        l_dml_type   CONSTANT VARCHAR2 (10 CHAR) := in_dml_type;
    BEGIN
        logger.append_param (p_params => l_params, p_name => 'inout_row.id', p_val => inout_row.id);
        logger.append_param (p_params   => l_params,
                             p_name     => 'inout_row.total',
                             p_val      => inout_row.total);
        logger.append_param (p_params => l_params, p_name => 'inout_row.discount', p_val => inout_row.discount);
        logger.append_param (p_params => l_params, p_name => 'inout_row.created', p_val => inout_row.created);
        logger.append_param (p_params => l_params, p_name => 'inout_row.updated', p_val => inout_row.updated);
        logger.append_param (p_params => l_params, p_name => 'inout_row.customer_id', p_val => inout_row.customer_id);
        logger.append_param (p_params => l_params, p_name => 'inout_row.canceled', p_val => inout_row.canceled);
        logger.append_param (p_params   => l_params,
                             p_name     => 'inout_row.cancel_reason',
                             p_val      => inout_row.cancel_reason);
        

        CASE l_dml_type
            WHEN gc_dml_insert
            THEN
                logger.LOG ('Inserting new row', l_scope);

                INSERT INTO   sc_invoice
                     VALUES   inout_row;
            WHEN gc_dml_update
            THEN
                logger.LOG ('Updating row', l_scope);

                UPDATE sc_invoice oo
                   SET ROW = inout_row
                 WHERE oo.id = inout_row.id;
            WHEN gc_dml_delete
            THEN
                logger.LOG ('Deleting row', l_scope);

                DELETE FROM sc_invoice o
                      WHERE   o.id = inout_row.id;
        END CASE;

      --  update_current_quantity (in_row => inout_row);
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
END API_SMARTCASH;
/

