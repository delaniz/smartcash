CREATE OR REPLACE PACKAGE MACDENIZ."API_SMARTCASH" 
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
    c_ex_invalid_changes_msg         CONSTANT VARCHAR2 (200 CHAR)
                                                  := 'Partial Fulfillments can only be changed regarding the price' ;

    c_send_notifications             CONSTANT BOOLEAN := TRUE;
    c_vision_enabled                 CONSTANT BOOLEAN := TRUE;
    c_vision_proxy_overrride         CONSTANT VARCHAR2 (1000) := NULL;             --'http://apex-test.power.inet:801/';
    
    c_ex_cant_lock_row                        EXCEPTION;
    c_ex_cant_lock_row_no            CONSTANT PLS_INTEGER := -20017;
    c_ex_cant_lock_row_msg           CONSTANT VARCHAR2 (200 CHAR) := 'Can not lock row {0}';
    
    c_ex_invalid_order                        EXCEPTION;
    c_ex_invalid_order_no            CONSTANT PLS_INTEGER := -20003;
    c_ex_invalid_order_msg           CONSTANT VARCHAR2 (200 CHAR)
                                                  := 'Invalid UPDATE order {0}, no data found for user {1}' ; --'Ung�tlige UPDATE Order ID {0}, kein Datensatz vorhanden von User {1}';
                                                  
    FUNCTION to_sc_invoice_t (in_rowtype IN SC_INVOICE%ROWTYPE)
        RETURN sc_invoice_t;

    FUNCTION to_rowtype (in_sc_invoice_t IN sc_invoice_t)
        RETURN SC_INVOICE%ROWTYPE;

    --Wrapper für SELECT * INTO WHERE ord_id = [ID]
    --Gibt leere Row zurück falls die ID noch nicht exisitiert
    FUNCTION get_row (in_invoice_id IN sc_invoice.id%TYPE, in_raise_no_data_found VARCHAR2 DEFAULT 'N')
        RETURN SC_INVOICE%ROWTYPE;

  

    --Validierung der Daten und entsprechender DML Prozess
    PROCEDURE save_row (inout_row                 IN OUT sc_invoice%ROWTYPE,
                        p_admin_mode              IN     VARCHAR2 DEFAULT NULL);

  
    PROCEDURE delete_row (in_sc_invoice_id IN sc_invoice.id%TYPE);
    
    PROCEDURE ORDER_DML (inout_row IN OUT SC_INVOICE%ROWTYPE, in_dml_type IN VARCHAR2);
    
    FUNCTION SAVE_IMAGE(filename    IN VARCHAR2
                      ,mimetype     IN VARCHAR2
                      ,image        IN BLOB
                      ,id           IN NUMBER DEFAULT NULL)
        RETURN SC_IMG.ID%TYPE;
        
     PROCEDURE SAVE_IMAGE(in_img_row IN OUT SC_IMG%ROWTYPE
                        ,action IN VARCHAR2);
    
    FUNCTION EXIST_IMAGE(in_sc_img_id IN SC_IMG.ID%TYPE)
        RETURN NUMBER;
END API_SMARTCASH;

/

