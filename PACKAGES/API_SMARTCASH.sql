create or replace PACKAGE          "API_SMARTCASH" 
IS

    c_status_booked                  CONSTANT VARCHAR2 (20 CHAR) := 'BOOKED';

    FUNCTION Stat_Booked
        RETURN VARCHAR2
        DETERMINISTIC;

    c_status_expired                 CONSTANT VARCHAR2 (20 CHAR) := 'EXPIRED';

    FUNCTION Stat_Expired
        RETURN VARCHAR2
        DETERMINISTIC;


    c_status_update_request          CONSTANT VARCHAR2 (20 CHAR) := 'UPDATED';

    FUNCTION Stat_Update_Request
        RETURN VARCHAR2
        DETERMINISTIC;

    c_status_cancelation_request     CONSTANT VARCHAR2 (20 CHAR) := 'CANCELED';

    FUNCTION Stat_Cancellation_Request
        RETURN VARCHAR2
        DETERMINISTIC;


    FUNCTION Stat_All_Stats_CSV
        RETURN VARCHAR2
        DETERMINISTIC;

    c_ex_invalid_changes                      EXCEPTION;
    c_ex_invalid_changes_no          CONSTANT PLS_INTEGER := -20001;
    c_ex_invalid_changes_msg         CONSTANT VARCHAR2 (200 CHAR) := 'Invalid changes' ;

    c_send_notifications             CONSTANT BOOLEAN := TRUE;
    c_vision_enabled                 CONSTANT BOOLEAN := TRUE;
    c_vision_proxy_overrride         CONSTANT VARCHAR2 (1000) := NULL;             --'http://apex-test.power.inet:801/';

    c_ex_cant_lock_row                        EXCEPTION;
    c_ex_cant_lock_row_no            CONSTANT PLS_INTEGER := -20017;
    c_ex_cant_lock_row_msg           CONSTANT VARCHAR2 (200 CHAR) := 'Can not lock row {0}';

    c_ex_invalid_order                        EXCEPTION;
    c_ex_invalid_order_no            CONSTANT PLS_INTEGER := -20003;
    c_ex_invalid_order_msg           CONSTANT VARCHAR2 (200 CHAR)
                                                  := 'Invalid UPDATE order {0}, no data found for user {1}' ; --'Ungütlige UPDATE Order ID {0}, kein Datensatz vorhanden von User {1}';
                                                  
    c_ex_no_payment                           EXCEPTION;
    c_ex_no_payment_no              CONSTANT PLS_INTEGER := -20004;
    c_ex_no_payment_msg             CONSTANT VARCHAR2 (200 CHAR) := 'No payment is given' ; 

    FUNCTION to_sc_invoice_t (in_rowtype IN SC_INVOICE%ROWTYPE)
        RETURN sc_invoice_t;

    FUNCTION to_rowtype (in_sc_invoice_t IN sc_invoice_t)
        RETURN SC_INVOICE%ROWTYPE;

    FUNCTION get_invoice (in_invoice_id IN sc_invoice.id%TYPE
                        , in_raise_no_data_found VARCHAR2 DEFAULT 'N')
        RETURN SC_INVOICE%ROWTYPE;
    
    FUNCTION get_invoiceitem (in_invoiceitem_id IN sc_invoiceitem.id%TYPE
                            , in_raise_no_data_found VARCHAR2 DEFAULT 'N')
        RETURN SC_INVOICEITEM%ROWTYPE;
    
    FUNCTION get_article (in_article_id IN sc_article.id%TYPE
                        , in_raise_no_data_found VARCHAR2 DEFAULT 'N')
        RETURN SC_ARTICLE%ROWTYPE;


    PROCEDURE SAVE_INVOICE (inout_row                 IN OUT sc_invoice%ROWTYPE,
                        p_admin_mode              IN     VARCHAR2 DEFAULT NULL);
    
    PROCEDURE SAVE_INVOICEITEM (inout_row                 IN OUT sc_invoiceitem%ROWTYPE,
                        p_admin_mode              IN     VARCHAR2 DEFAULT NULL);


    PROCEDURE delete_row (in_sc_invoice_id IN sc_invoice.id%TYPE);

    PROCEDURE ORDER_DML (inout_row IN OUT SC_INVOICE%ROWTYPE, in_dml_type IN VARCHAR2);
    PROCEDURE ORDER_DML (inout_row IN OUT SC_INVOICEITEM%ROWTYPE, in_dml_type IN VARCHAR2);

    FUNCTION SAVE_IMAGE(filename    IN VARCHAR2
                      ,mimetype     IN VARCHAR2
                      ,image        IN BLOB
                      ,id           IN NUMBER DEFAULT NULL)
        RETURN SC_IMG.ID%TYPE;

     PROCEDURE SAVE_IMAGE(in_img_row IN OUT SC_IMG%ROWTYPE
                        ,action IN VARCHAR2);

    FUNCTION EXIST_IMAGE(in_sc_img_id IN SC_IMG.ID%TYPE)
        RETURN NUMBER;
    
    PROCEDURE INCREASE_FREQ(in_article_id IN NUMBER);   
    
    PROCEDURE CANCEL_INVOICE(in_invoice_id IN SC_INVOICE.ID%TYPE
                            ,in_cancel_reason IN SC_INVOICE.CANCEL_REASON%TYPE);
                            
    FUNCTION GET_PAYMENT_ID(in_payment_name IN SC_PAYMENT.NAME%TYPE)
        RETURN NUMBER;
    
    FUNCTION get_payment( in_payment_id IN SC_PAYMENT.ID%TYPE
                        , in_raise_no_data_found VARCHAR2 DEFAULT 'N')
        RETURN SC_PAYMENT%ROWTYPE;
        
    FUNCTION get_user (in_user_id IN SC_APEX_USERS.ID%TYPE
                             , in_raise_no_data_found VARCHAR2 DEFAULT 'N')
        RETURN SC_APEX_USERS%ROWTYPE;
        
    FUNCTION GET_USER (in_username IN SC_APEX_USERS.USERNAME%TYPE
                        , in_raise_no_data_found VARCHAR2 DEFAULT 'N')
        RETURN SC_APEX_USERS%ROWTYPE;
        
    PROCEDURE ADD_DEP
        ( IN_COMPANY_ID NUMBER 
        , IN_NAME VARCHAR2 
        , IN_DESCRIPTION VARCHAR2 
        , IN_SUBJECT VARCHAR2 
        , IN_AMOUNT_GROSS  NUMBER 
        , IN_AMOUNT_NET  NUMBER 
        , IN_AMOUNT_TAX NUMBER 
        , IN_ISSUE VARCHAR2
        );
        
    PROCEDURE ADD_DEP
        ( in_row                 IN OUT SC_DEP%ROWTYPE
        );
    
    FUNCTION GET_COMPANY_ID (in_username IN SC_APEX_USERS.USERNAME%TYPE
                             , in_raise_no_data_found VARCHAR2 DEFAULT 'N')
        RETURN NUMBER;
    
    PROCEDURE SAVE_CASHBOOK
        ( in_row                 IN OUT SC_CASHBOOK%ROWTYPE
        );
        
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
        );
    
    FUNCTION GET_CASHREGISTER( in_company_id IN NUMBER
                                , in_raise_no_data_found VARCHAR2 DEFAULT 'N')
        RETURN SC_CASHREGISTER%ROWTYPE;
    
    FUNCTION GET_MAX_BELEGNR
        RETURN NUMBER;
    
    FUNCTION GET_TAX( in_tax_id IN NUMBER
                    , in_raise_no_data_found VARCHAR2 DEFAULT 'N')
        RETURN VARCHAR2;
        
    FUNCTION GET_CATEGORY( in_category_id IN NUMBER
                         , in_raise_no_data_found VARCHAR2 DEFAULT 'N')
        RETURN VARCHAR2;
        
    FUNCTION GET_PRINTER( in_printer_id IN NUMBER
                         , in_raise_no_data_found VARCHAR2 DEFAULT 'N')
        RETURN VARCHAR2;
END API_SMARTCASH;