CREATE OR REPLACE PACKAGE YYORDERDB2."API_OMS_ORDER" 
IS
    c_type_limitorder                CONSTANT VARCHAR2 (30 CHAR) := 'Limitorder';
    c_type_match_settle              CONSTANT VARCHAR2 (30 CHAR) := 'Match Settle';
    c_type_best_market               CONSTANT VARCHAR2 (30 CHAR) := 'Best Market';
    c_type_daily_average             CONSTANT VARCHAR2 (30 CHAR) := 'Daily Average';
	c_type_fixtrade					 CONSTANT VARCHAR2 (30 CHAR) := 'Fixtrade';
	c_type_spread_limitorder 		 CONSTANT VARCHAR2 (30 CHAR) := 'Spread Limitorder';
    c_type_spread_dailyaverage  	 CONSTANT VARCHAR2 (30 CHAR) := 'Spread Daily Average';	

    c_status_sleeping                CONSTANT VARCHAR2 (20 CHAR) := 'SLEEPING';

    FUNCTION Stat_Sleeping
        RETURN VARCHAR2
        DETERMINISTIC;

    c_status_new                     CONSTANT VARCHAR2 (20 CHAR) := 'NEW';

    FUNCTION Stat_New
        RETURN VARCHAR2
        DETERMINISTIC;

    c_status_deletion_request        CONSTANT VARCHAR2 (20 CHAR) := 'DELETION REQUEST';

    FUNCTION Stat_Deletion_Request
        RETURN VARCHAR2
        DETERMINISTIC;

    c_status_booked                  CONSTANT VARCHAR2 (20 CHAR) := 'BOOKED';

    FUNCTION Stat_Booked
        RETURN VARCHAR2
        DETERMINISTIC;

    c_status_expired                 CONSTANT VARCHAR2 (20 CHAR) := 'EXPIRED';

    FUNCTION Stat_Expired
        RETURN VARCHAR2
        DETERMINISTIC;

    c_status_deletion_confirmed      CONSTANT VARCHAR2 (30 CHAR) := 'DELETION CONFIRMED';

    FUNCTION Stat_Deletion_Confirmed
        RETURN VARCHAR2
        DETERMINISTIC;

    c_status_cancelation_confirmed   CONSTANT VARCHAR2 (30 CHAR) := 'CANCELATION CONFIRMED';

    FUNCTION Stat_Cancellation_Confirmed
        RETURN VARCHAR2
        DETERMINISTIC;

    c_status_executed                CONSTANT VARCHAR2 (30 CHAR) := 'EXECUTED';

    FUNCTION Stat_Executed
        RETURN VARCHAR2
        DETERMINISTIC;

    c_status_in_system               CONSTANT VARCHAR2 (20 CHAR) := 'IN SYSTEM';

    FUNCTION Stat_In_System
        RETURN VARCHAR2
        DETERMINISTIC;

    c_status_update_request          CONSTANT VARCHAR2 (20 CHAR) := 'UPDATED';

    FUNCTION Stat_Update_Request
        RETURN VARCHAR2
        DETERMINISTIC;

    c_status_await_settle            CONSTANT VARCHAR2 (20 CHAR) := 'AWAIT SETTLE';

    FUNCTION Stat_Await_Settle
        RETURN VARCHAR2
        DETERMINISTIC;

    c_status_cancelation_request     CONSTANT VARCHAR2 (20 CHAR) := 'CANCELED';

    FUNCTION Stat_Cancellation_Request
        RETURN VARCHAR2
        DETERMINISTIC;

    c_status_annuled                 CONSTANT VARCHAR2 (20 CHAR) := 'ANNULLED';

    FUNCTION Stat_Annulled
        RETURN VARCHAR2
        DETERMINISTIC;

    FUNCTION Stat_All_Stats_CSV
        RETURN VARCHAR2
        DETERMINISTIC;

    FUNCTION short_type (in_type VARCHAR2) RETURN VARCHAR2 DETERMINISTIC;

    c_product_base                   CONSTANT VARCHAR2 (10 CHAR) := 'Base';
    c_product_peak                   CONSTANT VARCHAR2 (10 CHAR) := 'Peak';

    c_direction_buy                  CONSTANT VARCHAR2 (1 CHAR) := 'B';
    c_direction_sell                 CONSTANT VARCHAR2 (1 CHAR) := 'S';

    c_websocket_channel              CONSTANT VARCHAR2 (100 CHAR)
                                                  :=    'OMS_'
                                                     || REGEXP_SUBSTR (app_util.constants.get_global_name,
                                                                       '[^\.]+',
                                                                       1,
                                                                       1) ;

    c_ex_invalid_changes                      EXCEPTION;
    c_ex_invalid_changes_no          CONSTANT PLS_INTEGER := -20001;
    c_ex_invalid_changes_msg         CONSTANT VARCHAR2 (200 CHAR)
                                                  := 'Partial Fulfillments can only be changed regarding the price' ;
    c_ex_invalid_changes_cnc                  EXCEPTION;
    c_ex_invalid_changes_cnc_no      CONSTANT PLS_INTEGER := -20002;
    c_ex_invalid_changes_cnc_msg     CONSTANT VARCHAR2 (200 CHAR)
        := 'Changes for order {0} are out of the bounds of contract with id {1}' ; --'Änderung für Order {0} ist nicht erlaubt für User {1}';
    c_ex_invalid_order                        EXCEPTION;
    c_ex_invalid_order_no            CONSTANT PLS_INTEGER := -20003;
    c_ex_invalid_order_msg           CONSTANT VARCHAR2 (200 CHAR)
                                                  := 'Invalid UPDATE order {0}, no data found for user {1}' ; --'Ungütlige UPDATE Order ID {0}, kein Datensatz vorhanden von User {1}';
    c_ex_status_invalid                       EXCEPTION;
    c_ex_status_invalid_no           CONSTANT PLS_INTEGER := -20004;
    c_ex_status_invalid_msg          CONSTANT VARCHAR2 (200 CHAR)
                                                  := 'Status "{0}" is not allowed after status "{1}" for user {2}' ; --'Fehler! Der Status >{0}< ist nicht erlaubt nach dem Status >{1}< fur den User {2}!';
    c_ex_order_expired                        EXCEPTION;
    c_ex_order_expired_no            CONSTANT PLS_INTEGER := -20005;
    c_ex_order_expired_msg           CONSTANT VARCHAR2 (200 CHAR) := 'Order {0} is expired'; --'Fehler! Das Gültigkeitsdatum {0} liegt zu weit in der Vergangenheit!';
    c_ex_delete_not_allowed                   EXCEPTION;
    c_ex_delete_not_allowed_no       CONSTANT PLS_INTEGER := -20006;
    c_ex_delete_not_allowed_msg      CONSTANT VARCHAR2 (200 CHAR)
                                                  := 'Delete order is only allowed for orders with status SLEEPING' ; --'Fehler! Eine Order darf nur gelöscht werden, wenn sie den Status SLEEPING hat!';
    c_ex_invalid_cnc_id                       EXCEPTION;
    c_ex_invalid_cnc_id_no           CONSTANT PLS_INTEGER := -20007;
    c_ex_invalid_cnc_id_msg          CONSTANT VARCHAR2 (200 CHAR)
                                                  := 'No matching contract found for provided parameters' ;
    c_ex_order_not_found                      EXCEPTION;
    c_ex_order_not_found_no          CONSTANT PLS_INTEGER := -20008;
    c_ex_order_not_found_msg         CONSTANT VARCHAR2 (200 CHAR) := 'No order with id {0} was found';
    c_ex_delete_req_invalid                   EXCEPTION;
    c_ex_delete_req_invalid_no       CONSTANT PLS_INTEGER := -20009;
    c_ex_delete_req_invalid_msg      CONSTANT VARCHAR2 (200 CHAR) := 'Deletion not allowed for order {0}';
    c_ex_update_not_allowed                   EXCEPTION;
    c_ex_update_not_allowed_no       CONSTANT PLS_INTEGER := -20010;
    c_ex_update_not_allowed_msg      CONSTANT VARCHAR2 (200 CHAR)
                                                  := 'Update not allowed, previous update still pending' ;
    c_ex_invalid_market                       EXCEPTION;
    c_ex_invalid_market_no           CONSTANT PLS_INTEGER := -20011;
    c_ex_invalid_market_msg          CONSTANT VARCHAR2 (200 CHAR)
                                                  := 'Market is not allowed to be Choice on Executed Orders' ;
    c_ex_invalid_update_id                    EXCEPTION;
    c_ex_invalid_update_id_no        CONSTANT PLS_INTEGER := -20012;
    c_ex_invalid_update_id_msg       CONSTANT VARCHAR2 (200 CHAR) := 'No previous data found for update on order {0}';
    c_ex_no_contract_region                   EXCEPTION;
    c_ex_no_contract_region_no       CONSTANT PLS_INTEGER := -20013;
    c_ex_no_contract_region_msg      CONSTANT VARCHAR2 (200 CHAR) := 'No contract region supplied for order {0}';
    c_ex_inv_organization                     EXCEPTION;
    c_ex_inv_organization_no         CONSTANT PLS_INTEGER := -20014;
    c_ex_inv_organization_msg        CONSTANT VARCHAR2 (200 CHAR) := 'User has no rights for organization id {0}';
    c_ex_ext_id_too_long                      EXCEPTION;
    c_ex_ext_id_too_long_no          CONSTANT PLS_INTEGER := -20015;
    c_ex_ext_id_too_long_msg         CONSTANT VARCHAR2 (200 CHAR) := 'Supplied external id exceeds the character limit';
    c_ex_invalid_ft_price                     EXCEPTION;
    c_ex_invalid_ft_price_no         CONSTANT PLS_INTEGER := -20016;
    c_ex_invalid_ft_price_msg        CONSTANT VARCHAR2 (200 CHAR) := 'Invalid fixtrade price supplied!';
    c_ex_cant_lock_row                        EXCEPTION;
    c_ex_cant_lock_row_no            CONSTANT PLS_INTEGER := -20017;
    c_ex_cant_lock_row_msg           CONSTANT VARCHAR2 (200 CHAR) := 'Can not lock row {0}';
    c_ex_invalid_qswitch                      EXCEPTION;
    c_ex_invalid_qswitch_no          CONSTANT PLS_INTEGER := -20020;
    c_ex_invalid_qswitch_msg         CONSTANT VARCHAR2 (200 CHAR) := 'Quantity switch over 1 MW not allowed';
    c_ex_update_not_allowed_ms                EXCEPTION; 
    c_ex_update_not_allowed_ms_no       CONSTANT PLS_INTEGER := -20021;
    c_ex_update_not_allowed_ms_msg      CONSTANT VARCHAR2 (200 CHAR) := 'Update not allowed, you can not update match settle order without admin rights.' ;
    c_ex_invalid_hedge_update                 EXCEPTION;
    c_ex_invalid_hedge_update_no     CONSTANT PLS_INTEGER := -20022;
    c_ex_invalid_hedge_update_msg    CONSTANT VARCHAR2(200 CHAR) := 'The Updates of Base-Order cant be applied on the Hedge-Order while hedge order is being changed.';
    c_ex_invalid_hedge_order                 EXCEPTION;
    c_ex_invalid_hedge_order_no     CONSTANT PLS_INTEGER := -20023;
    c_ex_invalid_hedge_order_msg    CONSTANT VARCHAR2(200 CHAR) := 'Invalid Base Order for creating a hedge Order. The Base-Order markt should be STP-PM ';
	c_ex_credit_limit_exceeded                 EXCEPTION;
    c_ex_credit_limit_exceeded_no     CONSTANT PLS_INTEGER := -20018;
    c_ex_credit_limit_exceeded_msg    CONSTANT VARCHAR2 (200 CHAR) := 'Credit limit exceeded for organization id {0}';
    c_ex_qty_limit_exceeded                  EXCEPTION;
    c_ex_qty_limit_exceeded_no     CONSTANT PLS_INTEGER := -20019;
    c_ex_qty_limit_exceeded_msg    CONSTANT VARCHAR2 (200 CHAR) := 'Quantity limit for this period {0} exceeded for organization id {1}, remaining quantity for this period: {2} ';
    c_ex_credit_limit_expired                 EXCEPTION;
    c_ex_credit_limit_expired_no     CONSTANT PLS_INTEGER := -20024;
    c_ex_credit_limit_expired_msg    CONSTANT VARCHAR2 (200 CHAR) := 'Delivery start {0} exceeds credit expiration date for organization id {1}';    
    c_ex_invalid_price                EXCEPTION;
    c_ex_invalid_price_no              CONSTANT PLS_INTEGER := -20025;
    c_ex_invalid_price_msg             CONSTANT VARCHAR2 (200 CHAR) := 'Order price cannot be empty for order type fixtrade or match-settle!';
    c_ex_invalid_ord_type_cng         EXCEPTION;
    c_ex_invalid_ord_type_cng_no      CONSTANT PLS_INTEGER := -20026;
    c_ex_invalid_ord_type_cng_msg     CONSTANT VARCHAR2 (200 CHAR) := 'Ord-Type change to Fixtrade is not allowed!';

    c_ex_vier_augen_prinzip          EXCEPTION;
    c_ex_vier_augen_prinzip_no       CONSTANT PLS_INTEGER := -20027;
    c_ex_vier_augen_prinzip_msg      CONSTANT VARCHAR2 (200 CHAR)
                                                  := 'The Trader who created the order is not allowed to set it to NEW. It must be handled by another Trader.' ; --'Fehler! Der Status >{0}< ist nicht erlaubt nach dem Status >{1}< fur den User {2}!';


    c_send_notifications             CONSTANT BOOLEAN := TRUE;
    c_vision_enabled                 CONSTANT BOOLEAN := TRUE;
    c_vision_proxy_overrride         CONSTANT VARCHAR2 (1000) := NULL;             --'http://apex-test.power.inet:801/';

    c_vision_action_type_create      CONSTANT VARCHAR2 (100) := 'placeOrder';
    c_vision_action_type_update      CONSTANT VARCHAR2 (100) := 'updateOrder';
    c_vision_action_type_delete      CONSTANT VARCHAR2 (100) := 'deleteOrder';
    c_vision_action_type_execute     CONSTANT VARCHAR2 (100) := 'executeOrder';
    c_instrumenttype_pwr             CONSTANT VARCHAR2 (1000) := 'PWR-PHYS';
    c_instrumenttype_gas             CONSTANT VARCHAR2 (1000) := 'GAS-PHYS';

    FUNCTION to_oms_ord_t (in_rowtype IN oms_order%ROWTYPE)
        RETURN oms_order_t;

    FUNCTION to_rowtype (in_oms_order_t IN oms_order_t)
        RETURN oms_order%ROWTYPE;

    --Wrapper für SELECT * INTO WHERE ord_id = [ID]
    --Gibt leere Row zurück falls die ID noch nicht exisitiert
    FUNCTION get_row (in_ord_id IN oms_order.ord_id%TYPE, in_raise_no_data_found VARCHAR2 DEFAULT 'N')
        RETURN oms_order%ROWTYPE;

    FUNCTION CHECK_FOR_COLUMN_VALUE_CHANGE(P_IN_ROW OMS_ORDER%ROWTYPE, P_OLD_ROW OMS_ORDER%ROWTYPE, P_TYPE VARCHAR2)
        RETURN BOOLEAN;

    --Validierung der Daten und entsprechender DML Prozess
    PROCEDURE save_row (inout_row                 IN OUT oms_order%ROWTYPE,
                        p_admin_mode              IN     VARCHAR2 DEFAULT NULL,
                        in_force_contract_check   IN     VARCHAR2 DEFAULT NULL);

    -- saves the row changes without triggering any logic and without any checks
    PROCEDURE save_row_as_silent_update (p_inout_row IN OUT oms_order%ROWTYPE, p_params IN LOGGER.TAB_PARAM);

    PROCEDURE delete_row (in_ord_id IN oms_order.ord_id%TYPE);

    --Eigene Prozedur zum setzen des Order Status
    PROCEDURE set_status (in_ord_id IN oms_order.ord_id%TYPE, in_ord_status IN oms_order.ord_status%TYPE);
    --Expired eine Order, falls gueltig_bis < SYSDATE
    PROCEDURE expire_outdated_order(in_ord_id NUMBER);
    PROCEDURE expire_outdated_orders;

    FUNCTION copy_order_hedge (in_row IN OUT oms_order%ROWTYPE) RETURN NUMBER;
    FUNCTION copy_order (in_ord_id IN oms_order.ord_id%TYPE, in_new_markt oms_order.ord_markt%TYPE DEFAULT NULL)
        RETURN NUMBER;

    PROCEDURE copy_order (in_ord_id IN oms_order.ord_id%TYPE, in_new_markt oms_order.ord_markt%TYPE DEFAULT NULL);

    PROCEDURE set_orders_booked;

    FUNCTION get_prod1 (p_periode IN oms_order.ord_periode%TYPE, 
                        p_lieferstart IN oms_order.ord_lieferstart%TYPE,
                        p_lieferende IN oms_contract_check.cnc_deliverydate_to%TYPE DEFAULT NULL)
        RETURN VARCHAR2
        DETERMINISTIC;

    FUNCTION status_change_valid (in_row       OMS_ORDER%ROWTYPE,
                                  in_row_old   OMS_ORDER%ROWTYPE,
                                  in_init      VARCHAR2,
                                  in_trade     VARCHAR2,
                                  in_admin     VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION fixtrade_price_is_valid (in_row OMS_ORDER%ROWTYPE)
        RETURN BOOLEAN;

    PROCEDURE fixtrade_reserve_order(in_row OMS_ORDER%ROWTYPE);

    FUNCTION get_prt_name (in_ord_periode VARCHAR2, in_ord_produkt VARCHAR2, in_ord_cnc_contract_region VARCHAR2) 
        RETURN VARCHAR2; 

    FUNCTION get_ts_id (in_ord_periode VARCHAR2, in_ord_produkt VARCHAR2, in_ord_cnc_contract_region VARCHAR2) 
        RETURN VARCHAR2;

    PROCEDURE update_settlement_order_prices;

    FUNCTION get_ancestor_id (in_ord_id NUMBER) 
        RETURN NUMBER;
		
    PROCEDURE save_pa_changes(in_pa_id IN NUMBER, in_ord_status IN VARCHAR2, in_triggered_market_price IN NUMBER);

    PROCEDURE set_autoinsert_to( in_ord_id IN oms_order.ord_id%TYPE , in_autoinsert IN oms_order.autoinsert%TYPE);
    
    PROCEDURE bulk_reinsert( in_ord_id IN oms_order.ord_id%TYPE);

    -----------------------------------------------
    --------- SAVE ROW SUB-PROCEDURES -------------
    -----------------------------------------------
    PROCEDURE check_organization
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        );

    PROCEDURE check_market
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM 
        );

    PROCEDURE set_lieferzone
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM 
        );

    PROCEDURE set_contract_region
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        );

    PROCEDURE set_index_preiszone
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_old_row   IN     OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        );

    PROCEDURE set_ord_instrumenttype
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        );

    PROCEDURE get_prod_hours_and_fin_price
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        );

    PROCEDURE check_ms_update_error
        ( p_inout_row                  IN OUT OMS_ORDER%ROWTYPE
        , p_params                     IN     LOGGER.TAB_PARAM
        , p_old_row                    IN     OMS_ORDER%ROWTYPE
        , p_just_note_or_extid_changed IN     BOOLEAN
        );

    PROCEDURE check_conditional_hedge_order
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        );

    PROCEDURE set_preis_vor_execute
        ( p_inout_row  IN OUT OMS_ORDER%ROWTYPE
        , p_params     IN     LOGGER.TAB_PARAM
        , p_admin_mode IN    VARCHAR2
        );

    PROCEDURE status_change_check
        ( p_inout_row     IN OUT OMS_ORDER%ROWTYPE
        , p_params        IN     LOGGER.TAB_PARAM
        , p_old_row       IN     OMS_ORDER%ROWTYPE
        , p_fl_init       IN     APEX_USERRIGHTS.FL_INIT%TYPE
        , p_fl_trade      IN     APEX_USERRIGHTS.FL_TRADE%TYPE
        , p_fl_admin      IN     APEX_USERS.FL_ADMIN%TYPE
        , p_user_is_admin IN     BOOLEAN
        );

    PROCEDURE set_autoinsert
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        , p_old_row   IN     OMS_ORDER%ROWTYPE
        , p_dml_type  IN     VARCHAR2
        );

    PROCEDURE get_market_price
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        , p_old_row   IN     OMS_ORDER%ROWTYPE
        );

    PROCEDURE check_expiry_date
        ( p_inout_row       IN OUT OMS_ORDER%ROWTYPE
        , p_params          IN     LOGGER.TAB_PARAM
        , p_user_is_admin   IN     BOOLEAN
        );

    PROCEDURE set_ord_market
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        , p_old_row   IN     OMS_ORDER%ROWTYPE
        );

    PROCEDURE get_ias_field
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        );

    PROCEDURE add_vision_fees_to_the_price
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        );

    PROCEDURE reserve_fixtrade_order
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        );

    PROCEDURE cnc_expiration_check
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        );

    PROCEDURE cnc_quantity_limit_management
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        );

    PROCEDURE taboo_generate_client_orderid
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        , p_old_row   IN     OMS_ORDER%ROWTYPE
        );

    PROCEDURE update_financial_price
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        , p_old_row   IN     OMS_ORDER%ROWTYPE
        );

    PROCEDURE get_trader
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        , p_old_row   IN     OMS_ORDER%ROWTYPE
        );

    PROCEDURE set_vor_execution
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        , p_old_row   IN     OMS_ORDER%ROWTYPE
        );

    PROCEDURE set_price_alerter
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        );

    PROCEDURE bcm_book
        ( p_inout_row      IN OUT OMS_ORDER%ROWTYPE
        , p_params         IN     LOGGER.TAB_PARAM
        , p_bcm_book_again IN     VARCHAR2
        );

    PROCEDURE set_bcm
        ( p_inout_row      IN OUT OMS_ORDER%ROWTYPE
        , p_params         IN     LOGGER.TAB_PARAM
        , p_bcm_book_again IN     VARCHAR2
        , p_found_bi          OUT VARCHAR2
        );

    PROCEDURE set_partial_fullfilment
        ( p_inout_row                  IN OUT OMS_ORDER%ROWTYPE
        , p_params                     IN     LOGGER.TAB_PARAM
        , p_old_row                    IN OUT OMS_ORDER%ROWTYPE
        , p_just_note_or_extid_changed IN     BOOLEAN
        );

    PROCEDURE set_oms_notification
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        );

    PROCEDURE set_vision_ws
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        , p_old_row   IN     OMS_ORDER%ROWTYPE
        , p_dml_type  IN     VARCHAR2
        );

	-------------------------------------------------------------
    PROCEDURE set_ord_menge (p_inout_row IN OUT OMS_ORDER%ROWTYPE);

    PROCEDURE set_ord_unit_and_amount( p_inout_row IN OUT OMS_ORDER%ROWTYPE
                                     , p_params    IN LOGGER.TAB_PARAM
                                     );
	
	PROCEDURE CORRECT_DELIVERY_START (P_INOUT_ROW IN OUT OMS_ORDER%ROWTYPE);
	
	PROCEDURE set_hedge_price_visual
		( p_inout_row IN OUT OMS_ORDER%ROWTYPE
		, p_params	  IN	 LOGGER.LOG_PARAM
		);
END API_OMS_ORDER;

/

