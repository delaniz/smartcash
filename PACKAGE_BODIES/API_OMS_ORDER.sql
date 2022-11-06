CREATE OR REPLACE PACKAGE BODY YYORDERDB2."API_OMS_ORDER"
IS
    gc_scope_prefix      CONSTANT VARCHAR2 (31) := LOWER ($$plsql_unit) || '.';
    g_row_before                  OMS_ORDER%ROWTYPE;
    g_log_diff_enabled            BOOLEAN := TRUE;
    gc_dml_insert        CONSTANT VARCHAR2 (10 CHAR) := 'INSERT';
    gc_dml_update        CONSTANT VARCHAR2 (10 CHAR) := 'UPDATE';
    gc_dml_delete        CONSTANT VARCHAR2 (10 CHAR) := 'DELETE';

    SUBTYPE bcm_api_requests IS pmst.bcm_api_requests%ROWTYPE;

    PROCEDURE run_async_webservice_call
        ( p_body  IN CLOB
        , p_proxy IN VARCHAR2 DEFAULT NULL
        )
    AS
        l_vision_websocket_url  VARARGS;
    BEGIN
        SELECT value
          BULK COLLECT INTO l_vision_websocket_url
          FROM user_properties
         WHERE NAME LIKE 'VISION notification URL%'
           AND database = (SELECT global_name FROM global_name);

        FOR i IN 1 .. l_vision_websocket_url.COUNT
        LOOP
            app_util.notifications.async_webservice_call
                ( in_url      => l_vision_websocket_url(i)
                , in_method   => 'POST'
                , in_body     => p_body
                , in_proxy    => p_proxy
                );
        END LOOP;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            logger.log_error ('Vision URL not found.');    
        WHEN OTHERS THEN
            logger.log_error('Error in the run async_webservice_call');

    END run_async_webservice_call;

    PROCEDURE call_taboo_oms_fill_companies
        ( p_ord_id  in number
        )
    AS
        l_scope    logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params   logger.tab_param;
    BEGIN
        logger.append_param (p_params => l_params, p_name => 'Order ID', p_val => p_ord_id);

        trap.taboo_oms.fill_companies
            ( p_ord_id => p_ord_id
            );

    EXCEPTION
        WHEN others
        THEN
            logger.log_error ('Unexpected error in call_taboo_oms_fill_companies ',
                                l_scope,
                                NULL,
                                l_params);
    END call_taboo_oms_fill_companies;

    PROCEDURE log_difference (in_stage VARCHAR2, in_row OMS_ORDER%ROWTYPE)
    AS
        l_scope           logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_date_format     nls_session_parameters.VALUE%TYPE;
        l_params          logger .tab_param;
        l_ret             VARCHAR2 (32000);
        l_init_return_str varchar2(1000)         := l_ret || in_row.ord_id || ': Values changed after ' || in_stage || CHR (10);
    BEGIN
        IF NOT g_log_diff_enabled
        THEN
            RETURN;
        END IF;

        logger.append_param(p_params => l_params, p_name => 'ord_id', p_val => in_row.ord_id);

        SELECT   VALUE
          INTO   l_date_format
          FROM   nls_session_parameters
         WHERE   parameter = 'NLS_DATE_FORMAT';

        l_ret := l_ret || in_row.ord_id || ': Values changed after ' || in_stage || CHR (10);

        IF g_row_before.ord_id != in_row.ord_id
        THEN
            l_ret := l_ret || 'ord_id :' || g_row_before.ord_id || '->' || in_row.ord_id || CHR (10);
        END IF;

        IF g_row_before.organization_id != in_row.organization_id
        THEN
            l_ret :=
                   l_ret
                || 'organization_id :'
                || g_row_before.organization_id
                || '->'
                || in_row.organization_id
                || CHR (10);
        END IF;

        IF g_row_before.ord_extid != in_row.ord_extid
        THEN
            l_ret := l_ret || 'ord_extid :' || g_row_before.ord_extid || '->' || in_row.ord_extid || CHR (10);
        END IF;

        IF g_row_before.ord_buysell != in_row.ord_buysell
        THEN
            l_ret := l_ret || 'ord_buysell :' || g_row_before.ord_buysell || '->' || in_row.ord_buysell || CHR (10);
        END IF;

        IF g_row_before.ord_produkt != in_row.ord_produkt
        THEN
            l_ret := l_ret || 'ord_produkt :' || g_row_before.ord_produkt || '->' || in_row.ord_produkt || CHR (10);
        END IF;

        IF g_row_before.ord_periode != in_row.ord_periode
        THEN
            l_ret := l_ret || 'ord_periode :' || g_row_before.ord_periode || '->' || in_row.ord_periode || CHR (10);
        END IF;

        IF g_row_before.ord_lieferstart != in_row.ord_lieferstart
        THEN
            l_ret :=
                   l_ret
                || 'ord_lieferstart :'
                || g_row_before.ord_lieferstart
                || '->'
                || in_row.ord_lieferstart
                || CHR (10);
        END IF;

         IF g_row_before.ord_lieferende != in_row.ord_lieferende
        THEN
            l_ret :=
                   l_ret
                || 'ord_lieferende :'
                || g_row_before.ord_lieferende
                || '->'
                || in_row.ord_lieferende
                || CHR (10);
        END IF;

        IF g_row_before.ord_menge != in_row.ord_menge
        THEN
            l_ret := l_ret || 'ord_menge :' || g_row_before.ord_menge || '->' || in_row.ord_menge || CHR (10);
        END IF;

        IF g_row_before.ord_preis != in_row.ord_preis
        THEN
            l_ret := l_ret || 'ord_preis :' || g_row_before.ord_preis || '->' || in_row.ord_preis || CHR (10);
        END IF;

        IF g_row_before.ord_markt != in_row.ord_markt
        THEN
            l_ret := l_ret || 'ord_markt :' || g_row_before.ord_markt || '->' || in_row.ord_markt || CHR (10);
        END IF;

        IF g_row_before.ord_gueltig_bis != in_row.ord_gueltig_bis
        THEN
            l_ret :=
                   l_ret
                || 'ord_gueltig_bis :'
                || g_row_before.ord_gueltig_bis
                || '->'
                || in_row.ord_gueltig_bis
                || CHR (10);
        END IF;

        IF g_row_before.ord_type != in_row.ord_type
        THEN
            l_ret := l_ret || 'ord_type :' || g_row_before.ord_type || '->' || in_row.ord_type || CHR (10);
        END IF;

        IF g_row_before.ord_status != in_row.ord_status
        THEN
            l_ret := l_ret || 'ord_status :' || g_row_before.ord_status || '->' || in_row.ord_status || CHR (10);
        END IF;

        IF g_row_before.ord_comment != in_row.ord_comment
        THEN
            l_ret := l_ret || 'ord_comment :' || g_row_before.ord_comment || '->' || in_row.ord_comment || CHR (10);
        END IF;

        IF g_row_before.ord_insdate != in_row.ord_insdate
        THEN
            l_ret := l_ret || 'ord_insdate :' || g_row_before.ord_insdate || '->' || in_row.ord_insdate || CHR (10);
        END IF;

        IF g_row_before.ord_moddate != in_row.ord_moddate
        THEN
            l_ret := l_ret || 'ord_moddate :' || g_row_before.ord_moddate || '->' || in_row.ord_moddate || CHR (10);
        END IF;

        IF g_row_before.ord_moduser != in_row.ord_moduser
        THEN
            l_ret := l_ret || 'ord_moduser :' || g_row_before.ord_moduser || '->' || in_row.ord_moduser || CHR (10);
        END IF;

        IF g_row_before.ord_trader != in_row.ord_trader
        THEN
            l_ret := l_ret || 'ord_trader :' || g_row_before.ord_trader || '->' || in_row.ord_trader || CHR (10);
        END IF;

        IF g_row_before.obc_id != in_row.obc_id
        THEN
            l_ret := l_ret || 'obc_id :' || g_row_before.obc_id || '->' || in_row.obc_id || CHR (10);
        END IF;

        IF g_row_before.ord_ias39 != in_row.ord_ias39
        THEN
            l_ret := l_ret || 'ord_ias39 :' || g_row_before.ord_ias39 || '->' || in_row.ord_ias39 || CHR (10);
        END IF;

        IF g_row_before.obc_matching_status != in_row.obc_matching_status
        THEN
            l_ret :=
                   l_ret
                || 'obc_matching_status :'
                || g_row_before.obc_matching_status
                || '->'
                || in_row.obc_matching_status
                || CHR (10);
        END IF;

        IF g_row_before.ord_lieferzone != in_row.ord_lieferzone
        THEN
            l_ret :=
                l_ret || 'ord_lieferzone :' || g_row_before.ord_lieferzone || '->' || in_row.ord_lieferzone || CHR (10);
        END IF;

        IF g_row_before.ord_id_parent != in_row.ord_id_parent
        THEN
            l_ret :=
                l_ret || 'ord_id_parent :' || g_row_before.ord_id_parent || '->' || in_row.ord_id_parent || CHR (10);
        END IF;

        IF g_row_before.bc_request_group_id != in_row.bc_request_group_id
        THEN
            l_ret :=
                   l_ret
                || 'bc_request_group_id :'
                || g_row_before.bc_request_group_id
                || '->'
                || in_row.bc_request_group_id
                || CHR (10);
        END IF;

        IF g_row_before.bc_request_id != in_row.bc_request_id
        THEN
            l_ret :=
                l_ret || 'bc_request_id :' || g_row_before.bc_request_id || '->' || in_row.bc_request_id || CHR (10);
        END IF;

        IF g_row_before.ord_tradedate != in_row.ord_tradedate
        THEN
            l_ret :=
                l_ret || 'ord_tradedate :' || g_row_before.ord_tradedate || '->' || in_row.ord_tradedate || CHR (10);
        END IF;

        IF g_row_before.cnc_id != in_row.cnc_id
        THEN
            l_ret := l_ret || 'cnc_id :' || g_row_before.cnc_id || '->' || in_row.cnc_id || CHR (10);
        END IF;

        IF g_row_before.menge_vor_update != in_row.menge_vor_update
        THEN
            l_ret :=
                   l_ret
                || 'menge_vor_update :'
                || g_row_before.menge_vor_update
                || '->'
                || in_row.menge_vor_update
                || CHR (10);
        END IF;

        IF g_row_before.preis_vor_update != in_row.preis_vor_update
        THEN
            l_ret :=
                   l_ret
                || 'preis_vor_update :'
                || g_row_before.preis_vor_update
                || '->'
                || in_row.preis_vor_update
                || CHR (10);
        END IF;

        IF g_row_before.all_or_none_vor_update != in_row.all_or_none_vor_update
        THEN
            l_ret :=
                   l_ret
                || 'all_or_none_vor_update :'
                || g_row_before.all_or_none_vor_update
                || '->'
                || in_row.all_or_none_vor_update
                || CHR (10);
        END IF;

        IF g_row_before.preis_vor_execute != in_row.preis_vor_execute
        THEN
            l_ret :=
                   l_ret
                || 'preis_vor_execute :'
                || g_row_before.preis_vor_execute
                || '->'
                || in_row.preis_vor_execute
                || CHR (10);
        END IF;

        IF g_row_before.menge_status_new != in_row.menge_status_new
        THEN
            l_ret :=
                   l_ret
                || 'menge_status_new :'
                || g_row_before.menge_status_new
                || '->'
                || in_row.menge_status_new
                || CHR (10);
        END IF;

        IF g_row_before.ord_instrumenttype != in_row.ord_instrumenttype
        THEN
            l_ret :=
                   l_ret
                || 'ord_instrumenttype :'
                || g_row_before.ord_instrumenttype
                || '->'
                || in_row.ord_instrumenttype
                || CHR (10);
        END IF;

        IF g_row_before.tp_client_orderid != in_row.tp_client_orderid
        THEN
            l_ret :=
                   l_ret
                || 'tp_client_orderid :'
                || g_row_before.tp_client_orderid
                || '->'
                || in_row.tp_client_orderid
                || CHR (10);
        END IF;

        IF g_row_before.cnc_contract_region != in_row.cnc_contract_region
        THEN
            l_ret :=
                   l_ret
                || 'cnc_contract_region :'
                || g_row_before.cnc_contract_region
                || '->'
                || in_row.cnc_contract_region
                || CHR (10);
        END IF;

        IF g_row_before.price_visual != in_row.price_visual
        THEN
            l_ret := l_ret || 'price_visual :' || g_row_before.price_visual || '->' || in_row.price_visual || CHR (10);
        END IF;

        IF g_row_before.price_visual_before_update != in_row.price_visual_before_update
        THEN
            l_ret :=
                   l_ret
                || 'price_visual_before_update :'
                || g_row_before.price_visual_before_update
                || '->'
                || in_row.price_visual_before_update
                || CHR (10);
        END IF;

        IF g_row_before.product_hours != in_row.product_hours
        THEN
            l_ret := l_ret || 'product_hours :' || g_row_before.product_hours || '->' || in_row.product_hours || CHR (10);
        END IF;

        IF g_row_before.financial_price != in_row.financial_price
        THEN
            l_ret := l_ret || 'financial_price :' || g_row_before.financial_price || '->' || in_row.financial_price || CHR (10);
        END IF;

        IF g_row_before.autoinsert != in_row.autoinsert
        THEN
            l_ret := l_ret || 'autoinsert :' || g_row_before.autoinsert || '->' || in_row.autoinsert || CHR (10);
        END IF;

        IF g_row_before.market_price != in_row.market_price
        THEN
            l_ret := l_ret || 'market_price :' || g_row_before.market_price || '->' || in_row.market_price || CHR (10);
        END IF;

        IF g_row_before.cnc_contract_region_vor_execute != in_row.cnc_contract_region_vor_execute
        THEN
            l_ret :=
                   l_ret
                || 'cnc_contract_region_vor_execute :'
                || g_row_before.cnc_contract_region_vor_execute
                || '->'
                || in_row.cnc_contract_region_vor_execute
                || CHR (10);
        END IF;

        IF l_ret = l_init_return_str 
        THEN
            l_ret := 'No values have been changed after: ' || in_stage || CHR (10);
        END IF;

        logger.LOG (l_ret, l_scope, null, l_params);
        g_row_before := in_row;

    END log_difference;

    -- generate a Trayport GUID for the tp_client_orderid
    FUNCTION NEW_TP_GUID
        RETURN VARCHAR2;

    FUNCTION short_type (in_type VARCHAR2) RETURN VARCHAR2 AS
    BEGIN
      RETURN CASE in_type
        WHEN 'Limitorder' THEN 'LO'
        WHEN 'Match Settle' THEN 'MS'
        WHEN 'Best Market' THEN 'BM'
        WHEN 'Daily Average' THEN 'DA'
        WHEN 'Fixtrade' THEN 'FT'
		WHEN 'Spread Limitorder' THEN 'SLO'
		WHEN 'Spread Daily Average' THEN 'SDA'
        ELSE in_type END
      ;
    END short_type;

    FUNCTION to_oms_ord_t (in_rowtype IN oms_order%ROWTYPE)
        RETURN oms_order_t
    AS
        l_scope    logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params   logger.tab_param;
    BEGIN
        RETURN oms_order_t (ord_id                       => in_rowtype.ord_id,
                            organization_id              => in_rowtype.organization_id,
                            ord_extid                    => in_rowtype.ord_extid,
                            ord_buysell                  => in_rowtype.ord_buysell,
                            ord_produkt                  => in_rowtype.ord_produkt,
                            ord_periode                  => in_rowtype.ord_periode,
                            ord_lieferstart              => in_rowtype.ord_lieferstart,
                            ord_menge                    => in_rowtype.ord_menge,
                            ord_preis                    => in_rowtype.ord_preis,
                            ord_markt                    => in_rowtype.ord_markt,
                            ord_gueltig_bis              => in_rowtype.ord_gueltig_bis,
                            ord_type                     => in_rowtype.ord_type,
                            ord_status                   => in_rowtype.ord_status,
                            ord_comment                  => in_rowtype.ord_comment,
                            ord_insdate                  => in_rowtype.ord_insdate,
                            ord_moddate                  => in_rowtype.ord_moddate,
                            ord_moduser                  => in_rowtype.ord_moduser,
                            ord_trader                   => in_rowtype.ord_trader,
                            obc_id                       => in_rowtype.obc_id,
                            ord_ias39                    => in_rowtype.ord_ias39,
                            obc_matching_status          => in_rowtype.obc_matching_status,
                            ord_lieferzone               => in_rowtype.ord_lieferzone,
                            ord_id_parent                => in_rowtype.ord_id_parent,
                            bc_request_group_id          => in_rowtype.bc_request_group_id,
                            bc_request_id                => in_rowtype.bc_request_id,
                            ord_tradedate                => in_rowtype.ord_tradedate,
                            cnc_id                       => in_rowtype.cnc_id,
                            menge_vor_update             => in_rowtype.menge_vor_update,
                            preis_vor_update             => in_rowtype.preis_vor_update,
                            preis_vor_execute            => in_rowtype.preis_vor_execute,
                            menge_status_new             => in_rowtype.menge_status_new,
                            ord_instrumenttype           => in_rowtype.ord_instrumenttype,
                            tp_client_orderid            => in_rowtype.tp_client_orderid,
                            cnc_contract_region          => in_rowtype.cnc_contract_region,
                            ord_index_preiszone          => in_rowtype.ord_index_preiszone,
                            price_visual                 => in_rowtype.price_visual,
                            price_visual_before_update   => in_rowtype.price_visual_before_update,
                            price_alerter_id             => in_rowtype.price_alerter_id,
                            otc_cleared                  => in_rowtype.otc_cleared,
                            index_preiszone_vor_execute  => in_rowtype.INDEX_PREISZONE_VOR_EXECUTE,
                            sales_channel                => in_rowtype.SALES_CHANNEL,
                            all_or_none                  => in_rowtype.all_or_none,
                            all_or_none_vor_update       => in_rowtype.all_or_none_vor_update,
							hedge_order 				 => in_rowtype.hedge_order,
							hedge_ord_id				 => in_rowtype.hedge_ord_id,
                            endur_deal_num_external      => in_rowtype.endur_deal_num_external,
							endur_deal_num_internal      => in_rowtype.endur_deal_num_internal,
                            autoinsert                   => in_rowtype.autoinsert,
                            product_hours                => in_rowtype.product_hours,
                            financial_price              => in_rowtype.financial_price,
                            ord_lieferende               => in_rowtype.ord_lieferende,
                            market_price                 => in_rowtype.market_price,
                            CNC_CONTRACT_REGION_VOR_EXECUTE => in_rowtype.CNC_CONTRACT_REGION_VOR_EXECUTE,
                            loc_so                       => in_rowtype.loc_so,
                            loc_se                       => in_rowtype.loc_se,
                            customer_price               => in_rowtype.customer_price,
                            customer_price_view          => in_rowtype.customer_price_view,
                            tradref_price                => in_rowtype.tradref_price,
                            hedge_price                  => in_rowtype.hedge_price,
                            settlement_price             => in_rowtype.settlement_price,
							ias39_display 			     => in_rowtype.ias39_display,
							ord_unit                     => in_rowtype.ord_unit,
                            ord_amount                   => in_rowtype.ord_amount,
                            gruenstrom_deal              => in_rowtype.gruenstrom_deal,
							hedge_price_visual			 => in_rowtype.hedge_price_visual);
    END to_oms_ord_t;

    FUNCTION to_rowtype (in_oms_order_t IN oms_order_t)
        RETURN oms_order%ROWTYPE
    AS
        l_scope    logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params   logger.tab_param;
        l_row      oms_order%ROWTYPE;
    BEGIN
        l_row.ord_id := in_oms_order_t.ord_id;
        l_row.organization_id := in_oms_order_t.organization_id;
        l_row.ord_extid := in_oms_order_t.ord_extid;
        l_row.ord_buysell := in_oms_order_t.ord_buysell;
        l_row.ord_produkt := in_oms_order_t.ord_produkt;
        l_row.ord_periode := in_oms_order_t.ord_periode;
        l_row.ord_lieferstart := in_oms_order_t.ord_lieferstart;
        l_row.ord_lieferende := in_oms_order_t.ord_lieferende;
        l_row.ord_menge := in_oms_order_t.ord_menge;
        l_row.ord_preis := in_oms_order_t.ord_preis;
        l_row.ord_markt := in_oms_order_t.ord_markt;
        l_row.ord_gueltig_bis := in_oms_order_t.ord_gueltig_bis;
        l_row.ord_type := in_oms_order_t.ord_type;
        l_row.ord_status := in_oms_order_t.ord_status;
        l_row.ord_comment := in_oms_order_t.ord_comment;
        l_row.ord_insdate := in_oms_order_t.ord_insdate;
        l_row.ord_moddate := in_oms_order_t.ord_moddate;
        l_row.ord_moduser := in_oms_order_t.ord_moduser;
        l_row.ord_trader := in_oms_order_t.ord_trader;
        l_row.obc_id := in_oms_order_t.obc_id;
        l_row.ord_ias39 := in_oms_order_t.ord_ias39;
        l_row.obc_matching_status := in_oms_order_t.obc_matching_status;
        l_row.ord_lieferzone := in_oms_order_t.ord_lieferzone;
        l_row.ord_id_parent := in_oms_order_t.ord_id_parent;
        l_row.bc_request_group_id := in_oms_order_t.bc_request_group_id;
        l_row.bc_request_id := in_oms_order_t.bc_request_id;
        l_row.ord_tradedate := in_oms_order_t.ord_tradedate;
        l_row.cnc_id := in_oms_order_t.cnc_id;
        l_row.menge_vor_update := in_oms_order_t.menge_vor_update;
        l_row.preis_vor_update := in_oms_order_t.preis_vor_update;
        l_row.preis_vor_execute := in_oms_order_t.preis_vor_execute;
        l_row.menge_status_new := in_oms_order_t.menge_status_new;
        l_row.ord_instrumenttype := in_oms_order_t.ord_instrumenttype;
        l_row.tp_client_orderid := in_oms_order_t.tp_client_orderid;
        l_row.cnc_contract_region := in_oms_order_t.cnc_contract_region;
        l_row.ord_index_preiszone := in_oms_order_t.ord_index_preiszone;
        l_row.price_visual := in_oms_order_t.price_visual;
        l_row.price_visual_before_update := in_oms_order_t.price_visual_before_update;
        l_row.price_alerter_id := in_oms_order_t.price_alerter_id;
        l_row.otc_cleared := in_oms_order_t.otc_cleared;
        l_row.SALES_CHANNEL := in_oms_order_t.SALES_CHANNEL;
        l_row.all_or_none := in_oms_order_t.all_or_none;
        l_row.all_or_none_vor_update := in_oms_order_t.all_or_none_vor_update;
		l_row.hedge_order := in_oms_order_t.hedge_order;
		l_row.hedge_ord_id := in_oms_order_t.hedge_ord_id;
        l_row.endur_deal_num_external      := in_oms_order_t.endur_deal_num_external;
		l_row.endur_deal_num_internal      := in_oms_order_t.endur_deal_num_internal;
        l_row.autoinsert                   := in_oms_order_t.autoinsert;
        l_row.product_hours                := in_oms_order_t.product_hours;
        l_row.financial_price              := in_oms_order_t.financial_price;
        l_row.ord_lieferende               := in_oms_order_t.ord_lieferende;
        l_row.market_price                 := in_oms_order_t.market_price;
        l_row.cnc_contract_region_vor_execute := in_oms_order_t.cnc_contract_region_vor_execute;
        l_row.loc_so                       := in_oms_order_t.loc_so;
        l_row.loc_se                       := in_oms_order_t.loc_se;
        l_row.customer_price               := in_oms_order_t.customer_price;
        l_row.customer_price_view          := in_oms_order_t.customer_price_view;
        l_row.tradref_price                := in_oms_order_t.tradref_price;
        l_row.hedge_price                  := in_oms_order_t.hedge_price;
        l_row.settlement_price             := in_oms_order_t.settlement_price;
        l_row.ord_unit 					   := in_oms_order_t.ord_unit;
        l_row.ord_amount 				   := in_oms_order_t.ord_amount;
		l_row.ias39_display                := in_oms_order_t.ias39_display;
        l_row.gruenstrom_deal              := in_oms_order_t.gruenstrom_deal;
		l_row.hedge_price_visual		   := in_oms_order_t.hedge_price_visual;
		RETURN l_row;
    END to_rowtype;

    FUNCTION get_row (in_ord_id IN oms_order.ord_id%TYPE, in_raise_no_data_found VARCHAR2 DEFAULT 'N')
        RETURN oms_order%ROWTYPE
    --Wrapper für SELECT * INTO WHERE ord_id = [ID]
    --Gibt leere Row zurück falls die ID noch nicht exisitiert
    AS
        l_scope       logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params      logger.tab_param;
        l_row_count   PLS_INTEGER;
        l_row         oms_order%ROWTYPE;
    BEGIN
        logger.append_param (p_params => l_params, p_name => 'in_ord_id', p_val => in_ord_id);
        logger.append_param (p_params => l_params, p_name => 'in_raise_no_data_found', p_val => in_raise_no_data_found);
        logger.log_information ('get_row',
                                l_scope,
                                NULL,
                                l_params);

        SELECT   COUNT (*)
          INTO   l_row_count
          FROM   oms_order o
         WHERE   o.ord_id = in_ord_id;

        IF l_row_count = 1
        THEN
            SELECT   *
              INTO   l_row
              FROM   oms_order o
             WHERE   o.ord_id = in_ord_id;
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

    PROCEDURE create_partial_ful_order (in_row IN oms_order%ROWTYPE, in_old_row IN oms_order%ROWTYPE)
    AS
        l_scope         logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params        logger.tab_param;
        l_partial_row   oms_order%ROWTYPE := in_row;
    BEGIN
        logger.log_information ('starting create_partial_ful_order!',
                                l_scope,
                                NULL,
                                l_params);
        logger.log_information ('{',
                                l_scope,
                                NULL,
                                l_params);
        l_partial_row.ord_id := NULL;
        l_partial_row.ord_menge := TO_NUMBER (in_old_row.ORD_MENGE) - TO_NUMBER (in_row.ORD_MENGE);
        l_partial_row.ord_preis := in_old_row.ord_preis;
        l_partial_row.ord_markt := in_old_row.ord_markt;
        l_partial_row.ord_status := in_old_row.ord_status;
        l_partial_row.ord_id_parent := in_row.ord_id;
        l_partial_row.ORD_INSDATE := NULL;
        l_partial_row.ORD_MODDATE := NULL;
        l_partial_row.ORD_MODUSER := NULL;
        l_partial_row.ORD_TRADER := NULL;
        l_partial_row.OBC_ID := NULL;
        l_partial_row.OBC_MATCHING_STATUS := NULL;
        l_partial_row.BC_REQUEST_GROUP_ID := NULL;
        l_partial_row.BC_REQUEST_ID := NULL;
        l_partial_row.ORD_TRADEDATE := NULL;
        l_partial_row.MENGE_VOR_UPDATE := NULL;
        l_partial_row.PREIS_VOR_UPDATE := NULL;
        l_partial_row.ALL_OR_NONE_VOR_UPDATE := NULL;
        l_partial_row.PREIS_VOR_EXECUTE := NULL;
        l_partial_row.MENGE_STATUS_NEW := NULL;
        l_partial_row.ord_instrumenttype := in_old_row.ord_instrumenttype;
        l_partial_row.price_visual_before_update := NULL;
        l_partial_row.otc_cleared := 'N';
        l_partial_row.cnc_contract_region_vor_execute := NULL;
        l_partial_row.price_alerter_id := NULL;
        logger.log_information ('in_row.ord_status = ' || in_row.ord_status,
                                l_scope,
                                NULL,
                                l_params);
        logger.log_information ('in_old_row.ord_status = ' || in_old_row.ord_status,
                                l_scope,
                                NULL,
                                l_params);
        logger.log_information ('das sollte nicht leer sein: l_partial_row.ord_status = ' || l_partial_row.ord_status,
                                l_scope,
                                NULL,
                                l_params);
        save_row (l_partial_row);
        logger.log_information ('}', l_scope);
    END create_partial_ful_order;

    PROCEDURE CORRECT_DELIVERY_START (P_INOUT_ROW IN OUT OMS_ORDER%ROWTYPE)
    IS
    --Korrigiere Lieferstart Uhrzeit (06:00 statt 00:00) falls es sich um eine Gas Order handelt
    BEGIN
        CASE P_INOUT_ROW.ord_instrumenttype
            WHEN c_instrumenttype_pwr
            THEN
                NULL;
            WHEN c_instrumenttype_gas
            THEN
                P_INOUT_ROW.ord_lieferstart := TRUNC (P_INOUT_ROW.ord_lieferstart) + 6 / 24;
            ELSE
                NULL;
        END CASE;
        log_difference('CORRECT_DELIVERY_START', p_inout_row);
    END CORRECT_DELIVERY_START;

    -- checks whether only the columns from a type have been changed
    -- FALSE -> Field values have been changed
    -- TRUE  -> No changes on fields - the old record matches with the new record
    FUNCTION CHECK_FOR_COLUMN_VALUE_CHANGE (P_IN_ROW OMS_ORDER%ROWTYPE, P_OLD_ROW OMS_ORDER%ROWTYPE, P_TYPE VARCHAR2)
        RETURN BOOLEAN
    AS
        l_scope          logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params         logger.tab_param;
        L_IN_ROW_COPY    OMS_ORDER%ROWTYPE := P_IN_ROW;
        L_OLD_ROW_COPY   OMS_ORDER%ROWTYPE := P_OLD_ROW;
        L_TYPE           VARCHAR2 (100) := P_TYPE;
        L_CHANGED        BOOLEAN := FALSE;
    BEGIN
        logger.append_param (p_params => l_params, p_name => 'in_ord_id', p_val => p_in_row.ord_id);
        logger.append_param (p_params => l_params, p_name => 'old_ord_id', p_val => p_old_row.ord_id);
        logger.append_param (p_params => l_params, p_name => 'p_in_type', p_val => p_type);
        logger.append_param (p_params => l_params, p_name => 'L_IN_ROW_COPY.ENDUR_DEAL_NUM_INTERNAL', p_val => L_IN_ROW_COPY.ENDUR_DEAL_NUM_INTERNAL);
        logger.append_param (p_params => l_params, p_name => 'L_OLD_ROW_COPY.ENDUR_DEAL_NUM_INTERNAL', p_val => L_OLD_ROW_COPY.ENDUR_DEAL_NUM_INTERNAL);
        logger.append_param (p_params => l_params, p_name => 'L_IN_ROW_COPY.ENDUR_DEAL_NUM_EXTERNAL', p_val => L_IN_ROW_COPY.ENDUR_DEAL_NUM_EXTERNAL);
        logger.append_param (p_params => l_params, p_name => 'L_OLD_ROW_COPY.ENDUR_DEAL_NUM_EXTERNAL', p_val => L_OLD_ROW_COPY.ENDUR_DEAL_NUM_EXTERNAL);
        logger.append_param (p_params => l_params, p_name => 'L_OLD_ROW_COPY.GRUENSTROM_DEAL', p_val => L_OLD_ROW_COPY.GRUENSTROM_DEAL);
        logger.log_information('input parameter of CHECK_FOR_COLUMN_VALUE_CHANGE', l_scope,null,l_params);

        IF L_TYPE = 'note_or_extid'
        THEN
            IF (   COALESCE (L_IN_ROW_COPY.ORD_COMMENT, ' ') != COALESCE (L_OLD_ROW_COPY.ORD_COMMENT, ' ')
                OR COALESCE (L_IN_ROW_COPY.ORD_EXTID, ' ') != COALESCE (L_OLD_ROW_COPY.ORD_EXTID, ' ')
                OR COALESCE (L_IN_ROW_COPY.ENDUR_DEAL_NUM_INTERNAL, 0) != COALESCE (L_OLD_ROW_COPY.ENDUR_DEAL_NUM_INTERNAL, 0)
                OR COALESCE (L_IN_ROW_COPY.ENDUR_DEAL_NUM_EXTERNAL, 0) != COALESCE (L_OLD_ROW_COPY.ENDUR_DEAL_NUM_EXTERNAL, 0))
                OR COALESCE (L_IN_ROW_COPY.GRUENSTROM_DEAL, ' ') != COALESCE (L_OLD_ROW_COPY.GRUENSTROM_DEAL, ' ')
            THEN
                logger.append_param (p_params => l_params, p_name => 'L_IN_ROW_COPY.ORD_COMMENT', p_val => L_IN_ROW_COPY.ORD_COMMENT);
                logger.append_param (p_params => l_params, p_name => 'L_OLD_ROW_COPY.ORD_COMMENT', p_val => L_OLD_ROW_COPY.ORD_COMMENT);
                logger.append_param (p_params => l_params, p_name => 'L_IN_ROW_COPY.ORD_EXTID', p_val => L_IN_ROW_COPY.ORD_EXTID);
                logger.append_param (p_params => l_params, p_name => 'L_OLD_ROW_COPY.ORD_EXTID', p_val => L_OLD_ROW_COPY.ORD_EXTID);
                logger.LOG ('note_or_extid_or_endur_deal_nr Column(s) are changed', l_scope);
                L_CHANGED := TRUE;

                L_IN_ROW_COPY.ORD_COMMENT := NULL;
                L_OLD_ROW_COPY.ORD_COMMENT := NULL;
                L_IN_ROW_COPY.ORD_EXTID := NULL;
                L_OLD_ROW_COPY.ENDUR_DEAL_NUM_INTERNAL := NULL;
                L_IN_ROW_COPY.ENDUR_DEAL_NUM_INTERNAL := NULL;
                L_OLD_ROW_COPY.ENDUR_DEAL_NUM_EXTERNAL := NULL;
                L_IN_ROW_COPY.ENDUR_DEAL_NUM_EXTERNAL := NULL;
                L_OLD_ROW_COPY.ORD_EXTID := NULL;
                L_IN_ROW_COPY.GRUENSTROM_DEAL := NULL;
                L_OLD_ROW_COPY.GRUENSTROM_DEAL := NULL;
            END IF;
        ELSIF L_TYPE = 'taboo_cols'
        THEN
            IF COALESCE (L_IN_ROW_COPY.AUTOINSERT, ' ') != COALESCE (L_OLD_ROW_COPY.AUTOINSERT, ' ')
            THEN                
                logger.append_param (p_params => l_params, p_name => 'L_IN_ROW_COPY.AUTOINSERT', p_val => L_IN_ROW_COPY.AUTOINSERT);
                logger.append_param (p_params => l_params, p_name => 'L_OLD_ROW_COPY.AUTOINSERT', p_val => L_OLD_ROW_COPY.AUTOINSERT);

                logger.append_param (p_params => l_params, p_name => 'L_IN_ROW_COPY.MENGE_VOR_UPDATE', p_val => L_IN_ROW_COPY.MENGE_VOR_UPDATE);
                logger.append_param (p_params => l_params, p_name => 'L_OLD_ROW_COPY.MENGE_VOR_UPDATE', p_val => L_OLD_ROW_COPY.MENGE_VOR_UPDATE);

                logger.append_param (p_params => l_params, p_name => 'L_IN_ROW_COPY.PREIS_VOR_UPDATE', p_val => L_IN_ROW_COPY.PREIS_VOR_UPDATE);
                logger.append_param (p_params => l_params, p_name => 'L_OLD_ROW_COPY.PREIS_VOR_UPDATE', p_val => L_OLD_ROW_COPY.PREIS_VOR_UPDATE);

                logger.append_param (p_params => l_params, p_name => 'L_IN_ROW_COPY.ALL_OR_NONE_VOR_UPDATE', p_val => L_IN_ROW_COPY.ALL_OR_NONE_VOR_UPDATE);
                logger.append_param (p_params => l_params, p_name => 'L_OLD_ROW_COPY.ALL_OR_NONE_VOR_UPDATE', p_val => L_OLD_ROW_COPY.ALL_OR_NONE_VOR_UPDATE);

                logger.append_param (p_params => l_params, p_name => 'L_IN_ROW_COPY.price_visual_before_update', p_val => L_IN_ROW_COPY.price_visual_before_update);
                logger.append_param (p_params => l_params, p_name => 'L_OLD_ROW_COPY.price_visual_before_update', p_val => L_OLD_ROW_COPY.price_visual_before_update);
                L_CHANGED := TRUE;

                L_IN_ROW_COPY.AUTOINSERT := NULL;
                L_OLD_ROW_COPY.AUTOINSERT := NULL;
                L_IN_ROW_COPY.MENGE_VOR_UPDATE       := NULL;
                L_OLD_ROW_COPY.MENGE_VOR_UPDATE       := NULL;
                L_IN_ROW_COPY.PREIS_VOR_UPDATE       := NULL;
                L_OLD_ROW_COPY.PREIS_VOR_UPDATE       := NULL;
                L_IN_ROW_COPY.ALL_OR_NONE_VOR_UPDATE := NULL;
                L_OLD_ROW_COPY.ALL_OR_NONE_VOR_UPDATE := NULL;
                L_IN_ROW_COPY.price_visual_before_update := NULL;
                L_OLD_ROW_COPY.price_visual_before_update := NULL;
                logger.LOG ('Autoinsert column changed', l_scope);
            END IF;
        ELSE
            logger.log_error ('The provided p_type => ' || p_type || ' was not found, no checks were executed.'
                            , l_scope);
        END IF;

        IF L_CHANGED
        THEN
            -- Wir löschen vor dem Vergleich ein paar Spalten, die sich immer ändern
            L_IN_ROW_COPY.ORD_INSDATE := NULL;
            L_OLD_ROW_COPY.ORD_INSDATE := NULL;
            L_IN_ROW_COPY.ORD_MODDATE := NULL;
            L_OLD_ROW_COPY.ORD_MODDATE := NULL;
            L_IN_ROW_COPY.ORD_MODUSER := NULL;
            L_OLD_ROW_COPY.ORD_MODUSER := NULL;
            L_IN_ROW_COPY.MENGE_STATUS_NEW := NULL;
            L_OLD_ROW_COPY.MENGE_STATUS_NEW := NULL;
            L_IN_ROW_COPY.CNC_CONTRACT_REGION := NULL;
            L_OLD_ROW_COPY.CNC_CONTRACT_REGION := NULL;
            L_IN_ROW_COPY.ORD_TRADEDATE := NULL;
            L_OLD_ROW_COPY.ORD_TRADEDATE := NULL;
            L_IN_ROW_COPY.FINANCIAL_PRICE  := NULL;
            L_OLD_ROW_COPY.FINANCIAL_PRICE  := NULL;
            L_IN_ROW_COPY.ORD_TRADER  := NULL;
            L_OLD_ROW_COPY.ORD_TRADER  := NULL;
            L_IN_ROW_COPY.MARKET_PRICE   := NULL;
            L_OLD_ROW_COPY.MARKET_PRICE   := NULL;

            IF (TO_OMS_ORD_T (L_IN_ROW_COPY).EQUALS (TO_OMS_ORD_T (L_OLD_ROW_COPY)))
            THEN
                logger.log_information ('The old record equals with the new record -> NO Changes, RETURN TRUE'
                                      , l_scope
                                      , NULL
                                      , l_params);
                RETURN TRUE;
            END IF;
        END IF;

        logger.log_information ('The old record IS NOT MATCHING with the new record -> Changes ins Fields, RETURN FALSE', l_scope, null, l_params);

        RETURN FALSE;
    END CHECK_FOR_COLUMN_VALUE_CHANGE;

    PROCEDURE SET_ORD_TRADEDATE (P_inout_row IN OUT OMS_ORDER%ROWTYPE, p_admin_mode IN VARCHAR2, p_params IN LOGGER.TAB_PARAM )
    --Tradedate setzen, Default ist SYSDATE außer der Status is jetzt Booked dann bleibt er, kann von Admin überschrieben werden
    IS
        l_scope   logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params    logger.tab_param     := p_params;
    BEGIN
        logger.log_information (
            'vorher ord_tradedate = ' || P_inout_row.ord_tradedate || ', l_admin_mode = ' || p_admin_mode,
            l_scope,
            null,
            l_params
        );
        P_inout_row.ord_tradedate :=
            CASE
                WHEN P_admin_mode = 'Y' AND P_inout_row.ord_tradedate IS NOT NULL
                THEN
                    P_inout_row.ord_tradedate
                WHEN P_inout_row.ord_status = AOO.Stat_Booked AND P_inout_row.ord_tradedate IS NOT NULL
                THEN
                    P_inout_row.ord_tradedate
                ELSE
                    SYSDATE
            END;
        logger.log_information ('nachher ord_tradedate = ' || P_inout_row.ord_tradedate, l_scope, null, l_params);
    END SET_ORD_TRADEDATE;

    FUNCTION CORRECT_STATUS (inout_row IN OMS_ORDER%ROWTYPE)
        RETURN OMS_ORDER.ORD_STATUS%TYPE
    IS
    BEGIN
        RETURN CASE
                   WHEN (    inout_row.ord_status = AOO.Stat_In_System
                         AND inout_row.ORD_TYPE IN (c_type_best_market, c_type_fixtrade, c_type_match_settle))
                   THEN
                       AOO.Stat_Await_Settle
                   ELSE
                       inout_row.ord_status
               END;
    END CORRECT_STATUS;

    FUNCTION INVALID_CHANGES (in_row_old OMS_ORDER%ROWTYPE, in_row_new OMS_ORDER%ROWTYPE)
        RETURN BOOLEAN
    AS
    BEGIN
        /*
         * Grundregel: Bis auf den Preis darf bei einer Teilerfüllung nichts geändert werden.
         * In Vision werden teilerfüllte Orders als Executed angezeigt. Ab dann darf ein Kunde die Order nicht mehr ändern.
         * Die Preisänderung muss erlaubt sein, wenn der Trader die Order zu einem anderen Preis exekutiert.
         */
        logger.LOG (formats ('ord_id >{0}< - >{1}<', VARARGS (in_row_old.ord_id, in_row_new.ord_id)));
        logger.LOG (
            formats ('ORGANIZATION_ID >{0}< - >{1}<', VARARGS (in_row_old.ORGANIZATION_ID, in_row_new.ORGANIZATION_ID))
        );
        logger.LOG (formats ('ORD_STATUS >{0}< - >{1}<', VARARGS (in_row_old.ORD_STATUS, in_row_new.ORD_STATUS)));
        logger.LOG (formats ('ORD_EXTID >{0}< - >{1}<', VARARGS (in_row_old.ORD_EXTID, in_row_new.ORD_EXTID)));
        logger.LOG (formats ('ORD_BUYSELL >{0}< - >{1}<', VARARGS (in_row_old.ORD_BUYSELL, in_row_new.ORD_BUYSELL)));
        logger.LOG (formats ('ORD_PRODUKT >{0}< - >{1}<', VARARGS (in_row_old.ORD_PRODUKT, in_row_new.ORD_PRODUKT)));
        logger.LOG (formats ('ORD_PERIODE >{0}< - >{1}<', VARARGS (in_row_old.ORD_PERIODE, in_row_new.ORD_PERIODE)));
        logger.LOG (
            formats (
                'ORD_LIEFERSTART >{0}< - >{1}<',
                VARARGS (TO_CHAR (in_row_old.ORD_LIEFERSTART, 'YYYY-MM-DD HH24:MI:SS'),
                         TO_CHAR (in_row_new.ORD_LIEFERSTART, 'YYYY-MM-DD HH24:MI:SS'))
            )
        );
        logger.LOG (
            formats (
                'ORD_LIEFERENDE >{0}< - >{1}<',
                VARARGS (TO_CHAR (in_row_old.ORD_LIEFERENDE, 'YYYY-MM-DD HH24:MI:SS'),
                         TO_CHAR (in_row_new.ORD_LIEFERENDE, 'YYYY-MM-DD HH24:MI:SS'))
            )
        );
        logger.LOG (formats ('ORD_MENGE >{0}< - >{1}<', VARARGS (in_row_old.ORD_MENGE, in_row_new.ORD_MENGE)));
        logger.LOG (
            formats ('ORD_LIEFERZONE >{0}< - >{1}<', VARARGS (in_row_old.ORD_LIEFERZONE, in_row_new.ORD_LIEFERZONE))
        );
        logger.LOG (formats ('ORD_MARKT >{0}< - >{1}<', VARARGS (in_row_old.ORD_MARKT, in_row_new.ORD_MARKT)));
        logger.LOG (
            formats ('ORD_GUELTIG_BIS >{0}< - >{1}<', VARARGS (in_row_old.ORD_GUELTIG_BIS, in_row_new.ORD_GUELTIG_BIS))
        );
        logger.LOG (formats ('ORD_TYPE >{0}< - >{1}<', VARARGS (in_row_old.ORD_TYPE, in_row_new.ORD_TYPE)));
        logger.LOG (formats ('ORD_IAS39 >{0}< - >{1}<', VARARGS (in_row_old.ORD_IAS39, in_row_new.ORD_IAS39)));
        RETURN NOT (    COALESCE (in_row_old.ORD_ID, -1) = COALESCE (in_row_new.ORD_ID, -1)
                    AND COALESCE (in_row_old.ORGANIZATION_ID, -1) = COALESCE (in_row_new.ORGANIZATION_ID, -1)
                    AND COALESCE (in_row_old.ORD_EXTID, 'x') = COALESCE (in_row_new.ORD_EXTID, 'x')
                    AND COALESCE (in_row_old.ORD_BUYSELL, 'x') = COALESCE (in_row_new.ORD_BUYSELL, 'x')
                    AND COALESCE (in_row_old.ORD_PRODUKT, 'x') = COALESCE (in_row_new.ORD_PRODUKT, 'x')
                    AND COALESCE (in_row_old.ORD_PERIODE, 'x') = COALESCE (in_row_new.ORD_PERIODE, 'x')
                    AND COALESCE (in_row_old.ORD_LIEFERSTART, TRUNC (SYSDATE)) =
                        COALESCE (in_row_new.ORD_LIEFERSTART, TRUNC (SYSDATE))
                    AND COALESCE (in_row_old.ORD_LIEFERENDE, TRUNC (SYSDATE)) =
                        COALESCE (in_row_new.ORD_LIEFERENDE, TRUNC (SYSDATE))
                    AND COALESCE (in_row_old.ORD_MENGE, -1) = COALESCE (in_row_new.ORD_MENGE, -1)
                    AND COALESCE (in_row_old.ORD_LIEFERZONE, 'x') = COALESCE (in_row_new.ORD_LIEFERZONE, 'x')
                    AND COALESCE (in_row_old.ORD_MARKT, 'x') = COALESCE (in_row_new.ORD_MARKT, 'x')
                    AND COALESCE (in_row_old.ORD_GUELTIG_BIS, TRUNC (SYSDATE)) =
                        COALESCE (in_row_new.ORD_GUELTIG_BIS, TRUNC (SYSDATE))
                    AND COALESCE (in_row_old.ORD_TYPE, 'x') = COALESCE (in_row_new.ORD_TYPE, 'x')
                    AND COALESCE (in_row_old.ORD_IAS39, 'x') = COALESCE (in_row_new.ORD_IAS39, 'x'));
    END INVALID_CHANGES;

    PROCEDURE GET_BEFORE_UPDATE_VALUES (inout_row IN OUT OMS_ORDER%ROWTYPE, in_row_old OMS_ORDER%ROWTYPE)
    AS
        l_scope   logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
    BEGIN
        IF inout_row.ORD_STATUS IN (AOO.Stat_Executed, AOO.Stat_Booked)
        THEN
            BEGIN
                SELECT   ord_preis
                  INTO   inout_row.PREIS_VOR_EXECUTE
                  FROM   oms_order_history
                 WHERE   odh_id = (SELECT   MAX (odh_id)
                                     FROM   oms_order_history
                                    WHERE   ord_id = inout_row.ORD_ID
                                            AND ord_status IN(AOO.Stat_In_System,AOO.STAT_UPDATE_REQUEST));
            EXCEPTION
                WHEN NO_DATA_FOUND
                THEN
                    logger.log_warning(
                        FORMATS ('get_preis_vor_execute: No previous price found for Order {0}, user: '|| sys_context('oms_context','user_id'),
                                 VARARGS (inout_row.ORD_ID)),
                        l_scope
                    );
            END;
        END IF;

        --get_preis_vor_update
        --get_menge_vor_update
        --get_all_or_none_vor_update
        IF inout_row.ORD_STATUS = AOO.Stat_Update_Request
        THEN
            BEGIN
                SELECT   ord_preis, ord_menge, price_visual, all_or_none, cnc_contract_region
                  INTO   inout_row.PREIS_VOR_UPDATE, inout_row.MENGE_VOR_UPDATE, inout_row.price_visual_before_update, inout_row.all_or_none_vor_update, inout_row.cnc_contract_region_vor_execute
                  FROM   oms_order_history
                 WHERE   odh_id = (SELECT   MAX (odh_id)
                                     FROM   oms_order_history
                                    WHERE   ord_id = inout_row.ORD_ID AND ord_status = AOO.Stat_In_System);

                IF     inout_row.price_visual_before_update IS NULL
                   AND inout_row.price_visual IS NOT NULL
                   AND in_row_old.price_visual IS NULL
                THEN
                    inout_row.price_visual_before_update := in_row_old.ord_preis;
                END IF;
            EXCEPTION
                WHEN NO_DATA_FOUND
                THEN
                    logger.log_error (
                        FORMATS ('get_preis/menge_vor_update: No previous price/quantity/all_or_none found for Order {0}, user: '|| sys_context('oms_context','user_id'),
                                 VARARGS (inout_row.ORD_ID)),
                        l_scope
                    );
            END;
        END IF;

        IF inout_row.ORD_STATUS = AOO.Stat_New
        THEN
            inout_row.menge_status_new := inout_row.ord_menge;
        END IF;
    END GET_BEFORE_UPDATE_VALUES;

    PROCEDURE update_current_quantity (in_row IN oms_order%ROWTYPE)
    AS
        l_scope         logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params        logger.tab_param;
        l_order_count   PLS_INTEGER;
    BEGIN
        logger.append_param (l_params, 'in_row.ord_id', in_row.ord_id);
        logger.append_param (l_params, 'in_row.cnc_contract_region', in_row.cnc_contract_region);
        logger.append_param (l_params, 'in_row.ord_buysell', in_row.ord_buysell);
        logger.append_param (l_params, 'in_row.ord_produkt', in_row.ord_produkt);
        logger.append_param (l_params, 'in_row.ord_periode', in_row.ord_periode);
        logger.append_param (l_params, 'in_row.ord_lieferstart', in_row.ord_lieferstart);
        logger.append_param (l_params, 'in_row.ord_menge', in_row.ord_menge);
        logger.append_param (l_params, 'in_row.ord_preis', in_row.ord_preis);
        logger.append_param (l_params, 'in_row.ord_type', in_row.ord_type);
        logger.append_param (l_params, 'in_row.ord_status', in_row.ord_status);
        logger.append_param (l_params, 'in_row.cnc_id', in_row.cnc_id);
        logger.LOG ('Updating quantity of contract ' || in_row.cnc_id || ' for order id ' || in_row.ord_id,
                    l_scope,
                    NULL,
                    l_params);

        SELECT   COUNT (ord_id)
          INTO   l_order_count
          FROM   oms_order oo
         WHERE       oo.ord_status NOT IN (AOO.Stat_Expired,
                                           AOO.Stat_Cancellation_Confirmed,
                                           AOO.Stat_Deletion_Confirmed,
                                           AOO.Stat_Sleeping,
                                           AOO.Stat_Annulled)
                 AND oo.cnc_id = in_row.cnc_id
                 AND oo.ord_periode = in_row.ord_periode
                 AND TRUNC (oo.ord_lieferstart) = TRUNC (in_row.ord_lieferstart)
                 AND oo.ord_produkt = in_row.ord_produkt
                 AND oo.cnc_contract_region = in_row.cnc_contract_region;

        IF l_order_count = 0
        THEN
            DELETE FROM cnc_current_quantity ccq
                  WHERE       ccq.cnc_id = in_row.cnc_id
                          AND ccq.lieferstart = in_row.ord_lieferstart
                          AND ccq.produkt = in_row.ord_produkt
                          AND ccq.contract_region = in_row.cnc_contract_region
                          AND ccq.TYPE = in_row.ord_type;
        ELSE
            MERGE INTO   cnc_current_quantity ccq
                 USING   (SELECT     cnc_id,
                                     ord_lieferstart,
                                     ord_produkt,
                                     ord_type,
                                     cnc_contract_region,
                                     ABS (SUM (CASE ord_buysell WHEN 'S' THEN -ord_menge ELSE ord_menge END)) ord_menge
                              FROM   oms_order oo
                             WHERE       oo.ord_status NOT IN (AOO.Stat_Expired,
                                                               AOO.Stat_Cancellation_Confirmed,
                                                               AOO.Stat_Deletion_Confirmed,
                                                               AOO.Stat_Sleeping,
                                                               AOO.Stat_Annulled)
                                     AND oo.cnc_id = in_row.cnc_id
                                     AND oo.ord_periode = in_row.ord_periode
                                     AND TRUNC (oo.ord_lieferstart) = TRUNC (in_row.ord_lieferstart)
                                     AND oo.ord_produkt = in_row.ord_produkt
                                     AND oo.cnc_contract_region = in_row.cnc_contract_region
                          GROUP BY   cnc_id,
                                     ord_lieferstart,
                                     ord_produkt,
                                     ord_type,
                                     cnc_contract_region) s
                    ON   (    ccq.cnc_id = s.cnc_id
                          AND ccq.lieferstart = s.ord_lieferstart
                          AND ccq.produkt = s.ord_produkt
                          AND ccq.contract_region = s.cnc_contract_region
                          AND ccq.TYPE = s.ord_type)
            WHEN MATCHED
            THEN
                UPDATE SET ccq.current_quantity = s.ord_menge
            WHEN NOT MATCHED
            THEN
                INSERT     VALUES   (cnc_current_quantity_seq.NEXTVAL,
                                     s.cnc_id,
                                     s.ord_lieferstart,
                                     s.ord_produkt,
                                     s.cnc_contract_region,
                                     s.ord_menge,
                                     s.ord_type)
                     WHERE   cnc_contract_region IS NOT NULL;
        END IF;
    END update_current_quantity;

    PROCEDURE ORDER_DML (inout_row IN OUT OMS_ORDER%ROWTYPE, in_dml_type IN VARCHAR2)
    AS
        l_scope               logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params              logger.tab_param;
        l_dml_type   CONSTANT VARCHAR2 (10 CHAR) := in_dml_type;
    BEGIN
        logger.append_param (p_params => l_params, p_name => 'inout_row.ord_id', p_val => inout_row.ord_id);
        logger.append_param (p_params   => l_params,
                             p_name     => 'inout_row.organization_id',
                             p_val      => inout_row.organization_id);
        logger.append_param (p_params => l_params, p_name => 'inout_row.otc_cleared', p_val => inout_row.otc_cleared);
        logger.append_param (p_params => l_params, p_name => 'inout_row.ord_extid', p_val => inout_row.ord_extid);
        logger.append_param (p_params => l_params, p_name => 'inout_row.ord_buysell', p_val => inout_row.ord_buysell);
        logger.append_param (p_params => l_params, p_name => 'inout_row.ord_produkt', p_val => inout_row.ord_produkt);
        logger.append_param (p_params => l_params, p_name => 'inout_row.ord_periode', p_val => inout_row.ord_periode);
        logger.append_param (p_params   => l_params,
                             p_name     => 'inout_row.ord_lieferstart',
                             p_val      => inout_row.ord_lieferstart);
        logger.append_param (p_params => l_params, p_name => 'inout_row.ord_menge', p_val => inout_row.ord_menge);
        logger.append_param (p_params => l_params, p_name => 'inout_row.ord_preis', p_val => inout_row.ord_preis);
        logger.append_param (p_params => l_params, p_name => 'inout_row.ord_markt', p_val => inout_row.ord_markt);
        logger.append_param (p_params   => l_params,
                             p_name     => 'inout_row.ord_gueltig_bis',
                             p_val      => inout_row.ord_gueltig_bis);
        logger.append_param (p_params => l_params, p_name => 'inout_row.ord_type', p_val => inout_row.ord_type);
        logger.append_param (p_params => l_params, p_name => 'inout_row.ord_status', p_val => inout_row.ord_status);
        logger.append_param (p_params => l_params, p_name => 'inout_row.ord_comment', p_val => inout_row.ord_comment);
        logger.append_param (p_params => l_params, p_name => 'inout_row.ord_insdate', p_val => inout_row.ord_insdate);
        logger.append_param (p_params => l_params, p_name => 'inout_row.ord_moddate', p_val => inout_row.ord_moddate);
        logger.append_param (p_params => l_params, p_name => 'inout_row.ord_moduser', p_val => inout_row.ord_moduser);
        logger.append_param (p_params => l_params, p_name => 'inout_row.ord_trader', p_val => inout_row.ord_trader);
        logger.append_param (p_params => l_params, p_name => 'inout_row.obc_id', p_val => inout_row.obc_id);
        logger.append_param (p_params => l_params, p_name => 'inout_row.ord_ias39', p_val => inout_row.ord_ias39);
        logger.append_param (p_params   => l_params,
                             p_name     => 'inout_row.obc_matching_status',
                             p_val      => inout_row.obc_matching_status);
        logger.append_param (p_params   => l_params,
                             p_name     => 'inout_row.ord_lieferzone',
                             p_val      => inout_row.ord_lieferzone);
        logger.append_param (p_params => l_params, p_name => 'inout_row.ord_id_parent', p_val => inout_row.ord_id_parent);
        logger.append_param (p_params   => l_params,
                             p_name     => 'inout_row.bc_request_group_id',
                             p_val      => inout_row.bc_request_group_id);
        logger.append_param (p_params => l_params, p_name => 'inout_row.bc_request_id', p_val => inout_row.bc_request_id);
        logger.append_param (p_params => l_params, p_name => 'inout_row.ord_tradedate', p_val => inout_row.ord_tradedate);
        logger.append_param (p_params => l_params, p_name => 'inout_row.cnc_id', p_val => inout_row.cnc_id);
        logger.append_param (p_params   => l_params,
                             p_name     => 'inout_row.menge_vor_update',
                             p_val      => inout_row.menge_vor_update);
        logger.append_param (p_params   => l_params,
                             p_name     => 'inout_row.preis_vor_update',
                             p_val      => inout_row.preis_vor_update);
        logger.append_param (p_params   => l_params,
                             p_name     => 'inout_row.all_or_none_vor_update',
                             p_val      => inout_row.all_or_none_vor_update);
        logger.append_param (p_params   => l_params,
                             p_name     => 'inout_row.preis_vor_execute',
                             p_val      => inout_row.preis_vor_execute);
        logger.append_param (p_params   => l_params,
                             p_name     => 'inout_row.menge_status_new',
                             p_val      => inout_row.menge_status_new);
        logger.append_param (p_params   => l_params,
                             p_name     => 'inout_row.ord_instrumenttype',
                             p_val      => inout_row.ord_instrumenttype);
        logger.append_param (p_params   => l_params,
                             p_name     => 'inout_row.tp_client_orderid',
                             p_val      => inout_row.tp_client_orderid);
        logger.append_param (p_params   => l_params,
                             p_name     => 'inout_row.cnc_contract_region',
                             p_val      => inout_row.cnc_contract_region);
        logger.append_param (p_params   => l_params,
                             p_name     => 'inout_row.ord_index_preiszone',
                             p_val      => inout_row.ord_index_preiszone);
        logger.append_param (p_params => l_params, p_name => 'inout_row.price_visual', p_val => inout_row.price_visual);
        logger.append_param (p_params   => l_params,
                             p_name     => 'inout_row.price_visual_before_update',
                             p_val      => inout_row.price_visual_before_update);
        logger.append_param (p_params   => l_params,
                             p_name     => 'inout_row.price_alerter_id',
                             p_val      => inout_row.price_alerter_id);
        logger.append_param (p_params   => l_params,
                             p_name     => 'inout_row.loc_so',
                             p_val      => inout_row.loc_so);
        logger.append_param (p_params   => l_params,
                             p_name     => 'inout_row.loc_se',
                             p_val      => inout_row.loc_se);
        logger.append_param (p_params   => l_params,
                             p_name     => 'inout_row.customer_price',
                             p_val      => inout_row.customer_price);
        logger.append_param (p_params   => l_params,
                             p_name     => 'inout_row.tradref_price',
                             p_val      => inout_row.tradref_price);
        logger.append_param (p_params   => l_params,
                             p_name     => 'inout_row.customer_price_view',
                             p_val      => inout_row.customer_price_view);
        logger.append_param (p_params   => l_params,
                             p_name     => 'inout_row.ias39_display',
                             p_val      => inout_row.ias39_display);
        logger.append_param (p_params   => l_params,
                             p_name     => 'inout_row.hedge_price',
                             p_val      => inout_row.hedge_price);
		logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'inout_row.hedge_price_visual',
							 p_val		=> inout_row.hedge_price_visual);
        logger.append_param (p_params   => l_params, 
							 p_name 	=> 'in_dml_type', 
							 p_val 		=> in_dml_type);
		
        logger.log_info ('params',
                         l_scope,
                         NULL,
                         l_params);
        inout_row.otc_cleared := COALESCE (inout_row.otc_cleared, 'N');

        CASE l_dml_type
            WHEN gc_dml_insert
            THEN
                logger.LOG ('Inserting new row', l_scope);

                INSERT INTO   oms_order
                     VALUES   inout_row;
            WHEN gc_dml_update
            THEN
                logger.LOG ('Updating row', l_scope);

                UPDATE oms_order oo
                   SET ROW = inout_row
                 WHERE oo.ord_id = inout_row.ord_id;
            WHEN gc_dml_delete
            THEN
                logger.LOG ('Deleting row', l_scope);

                DELETE FROM oms_order o
                      WHERE   o.ord_id = inout_row.ord_id;
        END CASE;

      --  update_current_quantity (in_row => inout_row);
    END ORDER_DML;

    FUNCTION values_changed (in_dml_type IN VARCHAR2, in_row IN OMS_ORDER%ROWTYPE)
        RETURN BOOLEAN
    AS
        l_scope     logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_row_old   OMS_ORDER%ROWTYPE;
    BEGIN
        IF in_dml_type = AOO.Stat_Update_Request
        THEN
            logger.log_information ('l_dml_type = UPDATE', l_scope);

            BEGIN
                SELECT   o.*
                  INTO   l_row_old
                  FROM   oms_order o
                 WHERE   o.ord_id = in_row.ord_id;

                RETURN NOT to_oms_ord_t (in_row).equals (to_oms_ord_t (l_row_old));
            EXCEPTION
                WHEN NO_DATA_FOUND
                THEN
                    logger.log_error ('raise c_ex_invalid_order');
                    RAISE c_ex_invalid_order;
            END;
        ELSE
            RETURN TRUE;
        END IF;
    END values_changed;

    PROCEDURE validate_changes (in_admin_mode VARCHAR2, in_row OMS_ORDER%ROWTYPE, in_old_row OMS_ORDER%ROWTYPE)
    AS
        l_scope   logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
    BEGIN
        IF     in_admin_mode = c.no
           AND in_row.ORD_ID_PARENT IS NOT NULL         -- Wir sind nicht im Admin Mode und wir haben eine Teilerfüllung
           AND in_row.ORD_STATUS NOT IN (AOO.Stat_Executed, AOO.Stat_In_System, AOO.Stat_Await_Settle) -- Wir setzen nicht auf EXECUTED (sind kein Trader)
        THEN
            logger.log_information (
                   'Wir sind nicht im Admin Mode und wir haben eine Teilerfüllung und wir setzen nicht auf EXECUTED,IN SYSTEM,AWAIT SETTLE sondern auf '
                || in_row.ORD_STATUS,
                l_scope
            );

            IF INVALID_CHANGES (in_row_old => in_old_row, in_row_new => in_row)
            THEN
                logger.log_error ('l_invalid_changes = true', l_scope);
                RAISE c_ex_invalid_changes;
            END IF;
        END IF;
    END validate_changes;

    PROCEDURE get_cnc_id (inout_row                 IN OUT OMS_ORDER%ROWTYPE,
                           in_old_row                IN     OMS_ORDER%ROWTYPE,
                           in_force_contract_check          VARCHAR2)
    AS
        l_scope       logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params      logger.tab_param;
        l_cnc_valid   VARCHAR2 (1);
    BEGIN
        logger.append_param (p_params   => l_params,
                             p_name     => 'inout_row.ORGANIZATION_ID',
                             p_val      => inout_row.ORGANIZATION_ID);
        logger.append_param (p_params => l_params, p_name => 'inout_row.ORD_TYPE', p_val => inout_row.ORD_TYPE);
        logger.append_param (p_params => l_params, p_name => 'inout_row.ORD_PRODUKT', p_val => inout_row.ORD_PRODUKT);
        logger.append_param (p_params => l_params, p_name => 'inout_row.ORD_PERIODE', p_val => inout_row.ORD_PERIODE);
        logger.append_param (p_params => l_params, p_name => 'inout_row.CNC_CONTRACT_REGION', p_val => inout_row.CNC_CONTRACT_REGION);
        logger.append_param (p_params => l_params, p_name => 'inout_row.ORD_MARKT', p_val => inout_row.ORD_MARKT);

        inout_row.cnc_id :=
            cnc.get_cnc_id (in_organization_id       => inout_row.ORGANIZATION_ID,
                            in_ord_type              => inout_row.ORD_TYPE,
                            in_ord_produkt           => inout_row.ORD_PRODUKT,
                            in_ord_periode           => inout_row.ORD_PERIODE,
                            in_cnc_contract_region   => inout_row.CNC_CONTRACT_REGION,
                            in_ord_markt             => inout_row.ORD_MARKT,
                            in_ord_instrumenttype   => inout_row.ORD_INSTRUMENTTYPE);

		logger.append_param (p_params => l_params, p_name => 'inout_row.cnc_id', p_val => inout_row.cnc_id);
        logger.log_information ('params', l_scope, NULL, l_params);
        IF inout_row.cnc_id IS NULL 
            AND (inout_row.ord_markt = 'STP-PM' 
                 OR 
                 inout_row.ord_status in (AOO.c_status_sleeping, AOO.c_status_new, AOO.c_status_update_request)
                 )
        THEN
            RAISE c_ex_invalid_cnc_id;
        END IF;

        IF inout_row.ORD_STATUS IN (AOO.Stat_New, AOO.Stat_Update_Request) OR in_force_contract_check = c.yes
        THEN
            l_cnc_valid := cnc.ist_order_valid_jn (in_order => inout_row, in_order_old => in_old_row);

            IF l_cnc_valid = c.no
            THEN
                RAISE c_ex_invalid_changes_cnc;
            END IF;
        END IF;
    END get_cnc_id;

    PROCEDURE INSERT_ORDER_HISTORY(i_ord_row IN OMS_ORDER%ROWTYPE)
    AS
       l_hist_row OMS_ORDER_HISTORY%ROWTYPE;
      BEGIN
        l_hist_row.BC_REQUEST_GROUP_ID            := i_ord_row.BC_REQUEST_GROUP_ID;
        l_hist_row.BC_REQUEST_ID                  := i_ord_row.BC_REQUEST_ID;
        l_hist_row.CNC_CONTRACT_REGION            := i_ord_row.CNC_CONTRACT_REGION;
        l_hist_row.CNC_ID                         := i_ord_row.CNC_ID;
        l_hist_row.INDEX_PREISZONE_VOR_EXECUTE    := i_ord_row.INDEX_PREISZONE_VOR_EXECUTE;
        l_hist_row.MENGE_STATUS_NEW               := i_ord_row.MENGE_STATUS_NEW;
        l_hist_row.MENGE_VOR_UPDATE               := i_ord_row.MENGE_VOR_UPDATE;
        l_hist_row.OBC_ID                         := i_ord_row.OBC_ID;
        l_hist_row.OBC_MATCHING_STATUS            := i_ord_row.OBC_MATCHING_STATUS;
        l_hist_row.ORD_BUYSELL                    := i_ord_row.ORD_BUYSELL;
        l_hist_row.ORD_COMMENT                    := i_ord_row.ORD_COMMENT;
        l_hist_row.ORD_EXTID                      := i_ord_row.ORD_EXTID;
        l_hist_row.ORD_GUELTIG_BIS                := i_ord_row.ORD_GUELTIG_BIS;
        l_hist_row.ORD_IAS39                      := i_ord_row.ORD_IAS39;
        l_hist_row.ORD_ID                         := i_ord_row.ORD_ID;
        l_hist_row.ORD_ID_PARENT                  := i_ord_row.ORD_ID_PARENT;
        l_hist_row.ORD_INDEX_PREISZONE            := i_ord_row.ORD_INDEX_PREISZONE;
        l_hist_row.ORD_INSDATE                    := i_ord_row.ORD_INSDATE;
        l_hist_row.ORD_INSTRUMENTTYPE             := i_ord_row.ORD_INSTRUMENTTYPE;
        l_hist_row.ORD_LIEFERSTART                := i_ord_row.ORD_LIEFERSTART;
        l_hist_row.ORD_LIEFERENDE                 := i_ord_row.ORD_LIEFERENDE;
        l_hist_row.ORD_LIEFERZONE                 := i_ord_row.ORD_LIEFERZONE;
        l_hist_row.ORD_MARKT                      := i_ord_row.ORD_MARKT;
        l_hist_row.ORD_MENGE                      := i_ord_row.ORD_MENGE;
        l_hist_row.ORD_MODDATE                    := i_ord_row.ORD_MODDATE;
        l_hist_row.ORD_MODUSER                    := i_ord_row.ORD_MODUSER;
        l_hist_row.ORD_PERIODE                    := i_ord_row.ORD_PERIODE;
        l_hist_row.ORD_PREIS                      := i_ord_row.ORD_PREIS;
        l_hist_row.ORD_PRODUKT                    := i_ord_row.ORD_PRODUKT;
        l_hist_row.ORD_STATUS                     := i_ord_row.ORD_STATUS;
        l_hist_row.ORD_TRADEDATE                  := i_ord_row.ORD_TRADEDATE;
        l_hist_row.ORD_TRADER                     := i_ord_row.ORD_TRADER;
        l_hist_row.ORD_TYPE                       := i_ord_row.ORD_TYPE;
        l_hist_row.ORGANIZATION_ID                := i_ord_row.ORGANIZATION_ID;
        l_hist_row.OTC_CLEARED                    := i_ord_row.OTC_CLEARED;
        l_hist_row.PREIS_VOR_EXECUTE              := i_ord_row.PREIS_VOR_EXECUTE;
        l_hist_row.PREIS_VOR_UPDATE               := i_ord_row.PREIS_VOR_UPDATE;
        l_hist_row.PRICE_ALERTER_ID               := i_ord_row.PRICE_ALERTER_ID;
        l_hist_row.PRICE_VISUAL                   := i_ord_row.PRICE_VISUAL;
        l_hist_row.PRICE_VISUAL_BEFORE_UPDATE     := i_ord_row.PRICE_VISUAL_BEFORE_UPDATE;
        l_hist_row.TP_CLIENT_ORDERID              := i_ord_row.TP_CLIENT_ORDERID;
        l_hist_row.ALL_OR_NONE                    := i_ord_row.ALL_OR_NONE;
        l_hist_row.ALL_OR_NONE_VOR_UPDATE         := i_ord_row.ALL_OR_NONE_VOR_UPDATE;
        l_hist_row.PRODUCT_HOURS                  := i_ord_row.PRODUCT_HOURS;
        l_hist_row.FINANCIAL_PRICE                := i_ord_row.FINANCIAL_PRICE;
        l_hist_row.market_price                   := i_ord_row.market_price;
        l_hist_row.cnc_contract_region_vor_execute := i_ord_row.cnc_contract_region_vor_execute;
        l_hist_row.sales_channel                  := i_ord_row.sales_channel;
        l_hist_row.hedge_ord_id                   := i_ord_row.hedge_ord_id;
        l_hist_row.hedge_order                    := i_ord_row.hedge_order;
        l_hist_row.endur_deal_num_external        := i_ord_row.endur_deal_num_external;
        l_hist_row.endur_deal_num_internal        := i_ord_row.endur_deal_num_internal;
        l_hist_row.autoinsert                     := i_ord_row.autoinsert;
        l_hist_row.loc_so                         := i_ord_row.loc_so;
        l_hist_row.loc_se                         := i_ord_row.loc_se;
        l_hist_row.customer_price                 := i_ord_row.customer_price;
        l_hist_row.customer_price_view            := i_ord_row.customer_price_view;
        l_hist_row.tradref_price                  := i_ord_row.tradref_price;
        l_hist_row.hedge_price                    := i_ord_row.hedge_price;
        l_hist_row.settlement_price               := i_ord_row.settlement_price;
        l_hist_row.ias39_display                  := i_ord_row.ias39_display;
		l_hist_row.hedge_price_visual			  := i_ord_row.hedge_price_visual;
        --l_hist_row.ord_ancestor_id                := i_ord_row.ord_ancestor_id;

        INSERT INTO OMS_ORDER_HISTORY VALUES l_hist_row;
    END INSERT_ORDER_HISTORY;

    FUNCTION append_oms_row_params(i_ord_row IN OMS_ORDER%ROWTYPE) RETURN logger.tab_param
    AS
      l_params   logger.tab_param;
      BEGIN
        logger.append_param (p_params 	=> l_params, 
							 p_name   	=> 'i_ord_row.ord_id', 
							 p_val 	  	=> i_ord_row.ord_id);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.organization_id',
                             p_val  	=>  i_ord_row.organization_id);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.ord_index_preiszone',
                             p_val  	=>  i_ord_row.ord_index_preiszone);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.ord_extid', 
							 p_val 		=> i_ord_row.ord_extid);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.ord_buysell', 
							 p_val 		=> i_ord_row.ord_buysell);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.ord_produkt', 
							 p_val 		=> i_ord_row.ord_produkt);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.ord_periode', 
							 p_val 		=> i_ord_row.ord_periode);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.ord_lieferstart',
							 p_val 		=> i_ord_row.ord_lieferstart);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.ord_lieferende',
							 p_val 		=> i_ord_row.ord_lieferende);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.ord_menge', 
							 p_val 		=> i_ord_row.ord_menge);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.ord_preis', 
							 p_val 		=> i_ord_row.ord_preis);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.ord_markt', 
							 p_val 		=> i_ord_row.ord_markt);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.ord_gueltig_bis',
                             p_val  	=>  i_ord_row.ord_gueltig_bis);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.ord_type', 
							 p_val 		=> i_ord_row.ord_type);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.ord_status', 
							 p_val 		=> i_ord_row.ord_status);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.ord_comment', 
							 p_val 		=> i_ord_row.ord_comment);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.ord_insdate', 
							 p_val	 	=> i_ord_row.ord_insdate);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.ord_moddate', 
							 p_val 		=> i_ord_row.ord_moddate);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.ord_moduser', 
							 p_val 		=> i_ord_row.ord_moduser);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.ord_trader', 
							 p_val 		=> i_ord_row.ord_trader);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.obc_id', 
							 p_val 		=> i_ord_row.obc_id);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.ord_ias39', 
							 p_val 		=> i_ord_row.ord_ias39);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.obc_matching_status',
                             p_val  	=> i_ord_row.obc_matching_status);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.ord_lieferzone', 
							 p_val 		=> i_ord_row.ord_lieferzone);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.ord_id_parent', 
							 p_val 		=> i_ord_row.ord_id_parent);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.bc_request_group_id',
                             p_val  	=>  i_ord_row.bc_request_group_id);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.bc_request_id', 
							 p_val 		=> i_ord_row.bc_request_id);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.ord_tradedate', 
							 p_val 		=> i_ord_row.ord_tradedate);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.cnc_id', 
							 p_val 		=> i_ord_row.cnc_id);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.menge_vor_update',
                             p_val  	=>  i_ord_row.menge_vor_update);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.preis_vor_update',
                             p_val  	=>  i_ord_row.preis_vor_update);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.preis_vor_execute',
                             p_val  	=>  i_ord_row.preis_vor_execute);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.menge_status_new',
                             p_val  	=>  i_ord_row.menge_status_new);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.ord_instrumenttype',
                             p_val  	=>  i_ord_row.ord_instrumenttype);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.tp_client_orderid',
                             p_val  	=>  i_ord_row.tp_client_orderid);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.cnc_contract_region',
                             p_val  	=>  i_ord_row.cnc_contract_region);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.ord_index_preiszone',
                             p_val  	=>  i_ord_row.ord_index_preiszone);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.price_visual', 
							 p_val 		=> i_ord_row.price_visual);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.price_visual_before_update',
                             p_val  	=>  i_ord_row.price_visual_before_update);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.price_alerter_id',
                             p_val  	=>  i_ord_row.price_alerter_id);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.otc_cleared',
                             p_val  	=>  i_ord_row.otc_cleared);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.index_preiszone_vor_execute',
                             p_val  	=>  i_ord_row.index_preiszone_vor_execute);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.Sales_Channel', 
							 p_val 		=> i_ord_row.Sales_Channel);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.all_or_none',
                             p_val  	=>  i_ord_row.all_or_none);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.hedge_ord_id',
                             p_val  	=> i_ord_row.hedge_ord_id);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.hedge_order',
                             p_val  	=> i_ord_row.hedge_order);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.all_or_none_vor_update',
                             p_val  	=>  i_ord_row.all_or_none_vor_update);
		logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.endur_deal_num_external',
                             p_val		=>  i_ord_row.endur_deal_num_external);
		logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.endur_deal_num_internal',
                             p_val  	=>  i_ord_row.endur_deal_num_internal);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.autoinsert',
                             p_val  	=> i_ord_row.autoinsert);                                           
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.product_hours',
                             p_val  	=>  i_ord_row.product_hours);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.financial_price',
                             p_val  	=>  i_ord_row.financial_price);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=>  'i_ord_row.ord_lieferende',
                             p_val  	=> i_ord_row.ord_lieferende);                                                
        logger.append_param (p_params   => l_params,
                             p_name     => 'i_ord_row.loc_so',
                             p_val      => i_ord_row.loc_so);
        logger.append_param (p_params   => l_params,
                             p_name     => 'i_ord_row.loc_se',
                             p_val      => i_ord_row.loc_se);
        logger.append_param (p_params   => l_params,
                             p_name     => 'i_ord_row.customer_price',
                             p_val      => i_ord_row.customer_price);
        logger.append_param (p_params   => l_params,
                             p_name     => 'i_ord_row.tradref_price',
                             p_val      => i_ord_row.tradref_price);
        logger.append_param (p_params   => l_params,
                             p_name     => 'i_ord_row.customer_price_view',
                             p_val      => i_ord_row.customer_price_view);
        logger.append_param (p_params   => l_params,
                             p_name     => 'i_ord_row.ias39_display',
                             p_val      => i_ord_row.ias39_display);
        logger.append_param (p_params   => l_params,
                             p_name     => 'i_ord_row.hedge_price',
                             p_val      => i_ord_row.hedge_price);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.market_price',
                             p_val  	=>  i_ord_row.market_price);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.ord_unit',
                             p_val 		=> i_ord_row.ord_unit);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.ord_amount',
                             p_val 		=> i_ord_row.ord_amount);
        logger.append_param (p_params   => l_params,
                             p_name     => 'i_ord_row.autoinsert',
                             p_val      => i_ord_row.autoinsert);       
        logger.append_param (p_params   => l_params,
       						 p_name     => 'i_ord_row.settlement_price',
                             p_val      => i_ord_row.settlement_price);              
		logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.market_price',
                             p_val  	=>  i_ord_row.market_price);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.ord_unit',
                             p_val 		=> i_ord_row.ord_unit);
        logger.append_param (p_params 	=> l_params, 
							 p_name 	=> 'i_ord_row.ord_amount',
                             p_val 		=> i_ord_row.ord_amount); 
		logger.append_param (p_params   => l_params,
                             p_name     => 'i_ord_row.gruenstrom_deal',
                             p_val      => i_ord_row.gruenstrom_deal);
		logger.append_param (p_params   => l_params,
                             p_name     => 'i_ord_row.hedge_price_visual',
                             p_val      => i_ord_row.hedge_price_visual);
        RETURN l_params;
    END append_oms_row_params;

    PROCEDURE SAVE_ROW
        ( inout_row                 IN OUT OMS_ORDER%ROWTYPE
        , p_admin_mode              IN     VARCHAR2 DEFAULT NULL
        , in_force_contract_check   IN     VARCHAR2 DEFAULT NULL
        )
    AS
        l_scope                        logger_logs.scope%TYPE;
        l_params                       logger.tab_param;
        l_dml_type            CONSTANT VARCHAR2 (10 CHAR)
                                           := CASE WHEN inout_row.ord_id IS NULL THEN gc_dml_insert ELSE gc_dml_update END ;
        l_fl_admin                     APEX_USERS.FL_ADMIN%TYPE := SYS_CONTEXT ('oms_context', 'fl_admin');
        l_fl_init                      APEX_USERRIGHTS.FL_INIT%TYPE;
        l_fl_trade                     APEX_USERRIGHTS.FL_TRADE%TYPE;
        l_user_is_admin       CONSTANT BOOLEAN := CASE WHEN l_fl_admin = c.yes OR p_admin_mode = c.yes THEN TRUE ELSE FALSE END; 
                                                --combined both of admin flags in order to make it possible to force saving price-alerter-id 
                                                --over admin-mode with p_admin_mode so that status changes can be made in_system to in_system 
                                                --old version: CASE l_fl_admin WHEN c.yes THEN TRUE ELSE FALSE END;
        l_bcm_book_again               VARCHAR2 (1)     := COALESCE (V ('P2_BCM_BOOK_AGAIN'), c.yes);
        l_email_again                  VARCHAR2 (1)     := COALESCE (V ('P2_BCM_EMAIL_AGAIN'), c.yes);
        l_admin_mode                   VARCHAR2 (1)     := COALESCE (P_ADMIN_MODE, V ('P2_ADMIN_MODE'), c.no);
        l_row_old                      OMS_ORDER%ROWTYPE;
        l_values_changed               BOOLEAN          := values_changed(in_dml_type => l_dml_type, in_row => inout_row);
        l_just_note_or_extid_changed   BOOLEAN          := FALSE;
        l_found_bi                     VARCHAR2 (1)     := c.no;
        l_lockname                     VARCHAR2 (128)   := inout_row.ord_id;
        l_lockhandle                   VARCHAR2 (128);
        l_result                       NUMBER;
        l_credit_limit_expiry_date     DATE;
        l_do_status_check              BOOLEAN := TRUE;

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
        logger.append_param (p_params => l_params, p_name => 'in_force_contract_check', p_val => in_force_contract_check);
        logger.append_param (p_params => l_params, p_name => 'l_email_again',           p_val => l_email_again);
        logger.log_information ('SaveRow ENTRY', l_scope, NULL, l_params);

        inout_row.ord_gueltig_bis := TRUNC (inout_row.ord_gueltig_bis);

        -- CHECK ORGANIZATION
        check_organization
            ( p_inout_row => inout_row
            , p_params    => l_params
            );

        -- CHECK MARKET
        check_market
            ( p_inout_row => inout_row
            , p_params    => l_params
            );
		-- CHECK PRICE
		IF inout_row.ord_type IN( c_type_limitorder,c_type_fixtrade) AND inout_row.ord_preis IS NULL THEN
            RAISE c_ex_invalid_price;
        END IF;
        -- SET LIFERZONE
        set_lieferzone
            ( p_inout_row => inout_row
            , p_params    => l_params
            );

        -- SET CONTRACT_REGION
        set_contract_region
            ( p_inout_row => inout_row
            , p_params    => l_params
            );

        -- SET INDEX_PREISZONE
        set_index_preiszone
            ( p_inout_row => inout_row
            , p_old_row   => l_row_old
            , p_params    => l_params
            );

        -- GET USER RIGHTS
        user_rights.get_user_rights
            ( in_organization_id => inout_row.organization_id
            , inout_init         => l_fl_init
            , inout_trade        => l_fl_trade
            );
        -- can't be moved inside of the procedure
        log_difference ('GET_USER_RIGHTS', inout_row); 

        -- if the user is admin, skip the status_check
        IF l_fl_admin = 'J'
        THEN
            l_do_status_check := FALSE;
            logger.log('l_fl_admin = "J" so we set l_do_status_check = FALSE', l_scope);
        END IF;

        -- SET ORD_INSTRUMENTTYPE
        set_ord_instrumenttype
            ( p_inout_row => inout_row
            , p_params    => l_params
            );

        -- CORRECT_DELIVERY_START
        correct_delivery_start
            (p_inout_row => inout_row
            );

        IF l_fl_admin = 'J' THEN
            l_do_status_check := FALSE;
            logger.log('l_fl_admin = "J" so we set l_do_status_check = FALSE', l_scope);
        END IF;

        --Wenn neue Zeile generiere ID und insdate ansonst prüfe ob sich nur notiz geändert hat
        IF l_dml_type = gc_dml_insert
        THEN
            inout_row.ord_id      := SEQ_ORD.NEXTVAL;
            inout_row.ord_insdate := SYSDATE;

            logger.log_information('Kein UPDATE, daher neue ROW_ID = ' || inout_row.ord_id, l_scope);

            -- Prüfen, ob ParentID ausgefüllt ist und wenn ja, dann den Switch in TABOO_ORDERS eintragen
            IF inout_row.ord_id_parent IS NOT NULL
            THEN
                oms_taboo.partial_ordid_switch
                    ( p_ord_id_parent => inout_row.ord_id_parent
                    , p_ord_id        => inout_row.ord_id
                    );
            END IF;

            -- set the ord_unit and ord_amount
            set_ord_unit_and_amount(p_inout_row => inout_row, p_params => l_params);

            -- set the ord_menge
            set_ord_menge(p_inout_row => inout_row);
            log_difference('SET_ORD_MENGE', inout_row);

            -- calculate the product hours and the financial price
            get_prod_hours_and_fin_price
                ( p_inout_row => inout_row
                , p_params    => l_params
                );
        ELSE
            -- get the the order row from the db
            BEGIN
                SELECT o.*
                  INTO l_row_old
                  FROM oms_order o
                 WHERE o.ord_id = inout_row.ord_id
                ;
            logger.log('select old_row, ord_id: '|| l_row_old.ord_id, l_scope, null, l_params);
            EXCEPTION
                WHEN no_data_found THEN
                    RAISE c_ex_invalid_update_id;
            END;

            l_just_note_or_extid_changed := 
                check_for_column_value_change        --Hat sich nur der Kommentar/Notiz geändert?
                    ( p_in_row  => inout_row
                    , p_old_row => L_ROW_OLD
                    , p_type    => 'note_or_extid'
                    );

            logger.append_param
                ( p_params => l_params
                , p_name   => 'l_just_note_or_extid_changed'
                , p_val    => l_just_note_or_extid_changed
                );

            -- CHECK ord_type changes
            IF (L_ROW_OLD.ord_type is not null and L_ROW_OLD.ord_type != c_type_fixtrade) AND inout_row.ord_type = c_type_fixtrade THEN
                RAISE c_ex_invalid_ord_type_cng;
            END IF;
        END IF;

        IF l_just_note_or_extid_changed
        THEN
            l_do_status_check := FALSE;
            logger.log('l_just_note_or_extid_changed = TRUE, so we set l_do_status_check = FALSE', l_scope);
        END IF;

        --Eine "Match Settle" Order darf nur von Admin geaendert werden. Diejenigen, die nicht Admin sind,
        --duerfen nur den Kommentar oder externen ID aendern.
        /*
        ** In Worten: 
        ** Wenn wir den Status gerade auf UPDATE wechseln sollen und der vorige Status ist MATCH SETTLE
        ** und wir nicht nur den Kommentar geändert haben 
        ** dann wirf eine Exception 
        */ 

        -- check_ms_update_error
        check_ms_update_error
            ( p_inout_row                    => inout_row
            , p_params                       => l_params
            , p_old_row                      => l_row_old
            , p_just_note_or_extid_changed => l_just_note_or_extid_changed
            );

        -- check conditional hedge order
        check_conditional_hedge_order
            ( p_inout_row => inout_row
            , p_params    => l_params
            );

        inout_row.ord_moddate := SYSDATE;
        inout_row.ord_moduser := SYS_CONTEXT ('oms_context', 'username');

        -- set ord_tradate
        set_ord_tradedate
            ( p_inout_row  => inout_row
            , p_admin_mode => l_admin_mode
            , p_params     => l_params
            );
        log_difference ('SET_ORD_TRADEDATE', inout_row); -- @todo: move it into the procedure call

        IF NOT l_just_note_or_extid_changed
        THEN
			 -- market decisions
            set_ord_market
                ( p_inout_row => inout_row
                , p_params    => l_params
                , p_old_row   => l_row_old
                );  

            IF inout_row.ORD_STATUS NOT IN (AOO.Stat_Expired,AOO.Stat_Booked)
            THEN
                inout_row.MENGE_VOR_UPDATE       := NULL;
                inout_row.PREIS_VOR_UPDATE       := NULL;
                inout_row.ALL_OR_NONE_VOR_UPDATE := NULL;
                --OM-1410 PREIS_VOR_EXECUTE (Settlement Preis), gesetzt durch Prozedur update_settlement_order_prices, soll im Admin-Screen nicht mit NULL überschrieben werden.
                set_preis_vor_execute
                    ( p_inout_row  => inout_row
                    , p_params     => l_params
                    , p_admin_mode => l_admin_mode
                    );

                inout_row.price_visual_before_update := NULL;
                logger.log_information
                    ( 'Pruefen, ob eine Teilerfüllung vorliegt ' || CHR (10)
                    || 'l_admin_mode = >' || l_admin_mode || '< ' || CHR (10)
                    || 'ist bei Teilerfuellung nicht NULL: inout_row.ORD_ID_PARENT = >' || inout_row.ORD_ID_PARENT || '<' || CHR (10)
                    || 'sollte bei Teilerfuellung IN SYSTEM sein: inout_row.ORD_STATUS = >' || inout_row.ORD_STATUS || '<'
                    , l_scope
                    );

                validate_changes
                    ( in_admin_mode => l_admin_mode
                    , in_row        => inout_row
                    , in_old_row    => l_row_old
                    );

                get_cnc_id
                    ( inout_row                 => inout_row
                    , in_old_row                => l_row_old
                    , in_force_contract_check   => in_force_contract_check
                    );
                log_difference ('CNC_ACTIONS', inout_row);

                logger.log_information ('CNC offenbar valid, sonst wären wir nicht hier', l_scope);        
            END IF;

            IF inout_row.ord_id IS NOT NULL
            THEN
                IF l_fl_trade = 'J' AND check_for_column_value_change(p_in_row => inout_row, p_old_row => l_row_old, p_type => 'taboo_cols')
                THEN
                    l_do_status_check := FALSE;
                    logger.log('l_fl_trade = "J" and CHECK_FOR_COLUMN_VALUE_CHANGE = TRUE, so we set l_do_status_check = FALSE', l_scope);
                END IF;
            END IF;

            logger.append_param (p_params => l_params, p_name => 'l_do_status_check', p_val => l_do_status_check);

            IF l_do_status_check
            THEN
                logger.log('call status_change_check', l_scope, null, l_params);
                status_change_check
                    ( p_inout_row     => inout_row
                    , p_params        => l_params
                    , p_old_row       => l_row_old
                    , p_fl_init       => l_fl_init
                    , p_fl_trade      => l_fl_trade
                    , p_fl_admin      => l_fl_admin
                    , p_user_is_admin => l_user_is_admin
                    );
            END IF; 

            -- set the autoinsert value
            set_autoinsert
                ( p_inout_row => inout_row
                , p_params    => l_params
                , p_old_row   => l_row_old
                , p_dml_type  => l_dml_type
                );
			
			-- set hedge_price_visual for spread orders
			set_hedge_price_visual
				( p_inout_row => inout_row
				, p_params	  => l_params
				);
				
           --generate market price for specific mod_date
            get_market_price
                ( p_inout_row => inout_row
                , p_params    => l_params
                , p_old_row   => l_row_old
                );

            -- check order expiration date
            check_expiry_date
                ( p_inout_row     => inout_row
                , p_params        => l_params
                , p_user_is_admin => l_user_is_admin
                );


            -- set ias39 field
            get_ias_field
                ( p_inout_row => inout_row
                , p_params    => l_params
                );

            -- call add_cnc_vision_fee_to_the_price
            add_vision_fees_to_the_price
                ( p_inout_row => inout_row
                , p_params    => l_params
                );

            -- check whether the fixtrade order price is valid
            -- if so, reserve the order
            if inout_row.SALES_CHANNEL = 'VIS' then
                reserve_fixtrade_order
                    ( p_inout_row => inout_row
                    , p_params    => l_params
                    );
            end if;

            -- check cnc_expiration date
            cnc_expiration_check
                ( p_inout_row => inout_row
                , p_params    => l_params
                );

            -- do the credit checks
            cnc_quantity_limit_management
                ( p_inout_row     => inout_row
                , p_params        => l_params
                );

            -- get new taboo client orderid
            taboo_generate_client_orderid
                ( p_inout_row => inout_row
                , p_params    => l_params
                , p_old_row   => l_row_old
                );

			-- set the ord_menge
            set_ord_menge(p_inout_row => inout_row);
            log_difference('SET_ORD_MENGE', inout_row);

            -- update the financial_price
            update_financial_price
                ( p_inout_row => inout_row
                , p_params    => l_params
                , p_old_row   => l_row_old
                );

            -- get trader
            get_trader
                ( p_inout_row => inout_row
                , p_params    => l_params
                , p_old_row   => l_row_old
                );

            -- set_vor_execution
            set_vor_execution
                ( p_inout_row => inout_row
                , p_params    => l_params
                , p_old_row   => l_row_old
                );

            -- set the bmc related data
            set_bcm
                ( p_inout_row      => inout_row
                , p_params         => l_params
                , p_bcm_book_again => l_bcm_book_again
                , p_found_bi       => l_found_bi
                );

            -- call the book
            bcm_book
                ( p_inout_row      => inout_row
                , p_params         => l_params
                , p_bcm_book_again => c.yes
                );

        END IF;

        API_OMS_ORDER_DISPLAY_FIELDS.CALC(inout_row); --calculate LOC_SE,LOC_SO etc

        IF l_values_changed AND NOT l_just_note_or_extid_changed
        THEN
            logger.log('call insert_order_history', l_scope, null, l_params);
            insert_order_history(inout_row);
        END IF;

        inout_row.otc_cleared := COALESCE (inout_row.otc_cleared, 'N');
        log_difference ('OTC_CLEARED', inout_row);

        -- call order_dml
        order_dml
            ( inout_row => inout_row
            , in_dml_type => l_dml_type
            );
        log_difference ('OMS_ORDER_DML', inout_row); -- move it to the order_dml 
		
		IF NOT l_just_note_or_extid_changed
		THEN
			  -- call price alerter procedures
            set_price_alerter
                ( p_inout_row     => inout_row
                , p_params        => l_params
                );
		END IF;
		
        IF l_email_again = c.yes AND l_found_bi = c.yes
        THEN
            logger.log_information
                ( 'rufe mail('|| inout_row.BC_REQUEST_ID|| ') auf. Send mail again: '|| l_email_again || '. Found_BI: '|| l_found_bi
                , l_scope
                , null
                , l_params
                );
            PMST.BCM_MAIL.mail(inout_row.BC_REQUEST_ID);
        END IF;

        -- call set_partial_fullfilment
        set_partial_fullfilment
            ( p_inout_row                  => inout_row
            , p_params                     => l_params
            , p_old_row                    => l_row_old  -- o_old_row is IN OUT
            , p_just_note_or_extid_changed => l_just_note_or_extid_changed
            );

        IF c_send_notifications
        THEN
            logger.log('call set_oms_notification', l_scope, null, l_params);
            set_oms_notification
                ( p_inout_row => inout_row
                , p_params    => l_params
                );

            IF inout_row.ord_markt = 'STP-PM' AND inout_row.ord_status = AOO.Stat_New  --send the notification to stp-channel
            THEN
                logger.log('call webex.post_to_stp_room', l_scope, null, l_params);
                WEBEX.POST_TO_STP_ROOM(inout_row,sysdate);
            END IF;

            IF c_vision_enabled
            THEN
                logger.log('call set_vision_ws', l_scope, null, l_params);
                set_vision_ws
                    ( p_inout_row => inout_row
                    , p_params    => l_params
                    , p_old_row   => l_row_old
                    , p_dml_type  => l_dml_type
                    );
            END IF;
        END IF;

        logger.log_information('trying to clean taboo_orders if l_just_note_or_extid_changed = TRUE',l_scope, null, l_params);
        IF NOT l_just_note_or_extid_changed
        THEN
            /* Eine Änderung an einer OMS Order kann dazu führen, dass wir über TABOO die Order nicht mehr in Trayport tracken müssen. Hiermit lösen wir die Prüfung und das eventuelle Löschen der Tracking Daten aus.*/
            OMS_TABOO.CLEAN_TABOO_ORDERS;
        END IF;

        -- have to call it from here in order to fix taboo error - OM - 2011
        IF inout_row.ord_status = AOO.c_status_new THEN
            logger.log_information('calling the taboo_oms.fill_companies procedure, order id '|| inout_row.ord_id, l_scope);    
            call_taboo_oms_fill_companies
                ( p_ord_id => inout_row.ord_id
                );
        END IF;

        l_result := DBMS_LOCK.release (l_lockhandle);

        logger.log_information('end of the save_row story, na endlich!',l_scope, null, l_params);
    EXCEPTION
        WHEN c_ex_invalid_changes THEN
            DECLARE
                l_old_string   VARCHAR2 (1000);
                l_new_string   VARCHAR2 (1000);
            BEGIN
                l_old_string := l_row_old.ORD_ID || ';' || l_row_old.ORGANIZATION_ID || ';' || l_row_old.ORD_EXTID || ';'
                    || l_row_old.ORD_BUYSELL || ';' || l_row_old.ORD_PRODUKT || ';' || l_row_old.ORD_PERIODE || ';'
                    || l_row_old.ORD_LIEFERSTART || ';'  || l_row_old.ORD_LIEFERENDE || ';'|| l_row_old.ORD_MENGE|| ';'|| l_row_old.ORD_LIEFERZONE|| ';'
                    || l_row_old.ORD_MARKT|| ';'|| l_row_old.ORD_GUELTIG_BIS|| ';'|| l_row_old.ORD_TYPE|| ';'
                    || l_row_old.ORD_IAS39;
                l_new_string := inout_row.ORD_ID || ';'|| inout_row.ORGANIZATION_ID|| ';'|| inout_row.ORD_EXTID|| ';'
                    || inout_row.ORD_BUYSELL|| ';'|| inout_row.ORD_PRODUKT|| ';'|| inout_row.ORD_PERIODE|| ';'
                    || inout_row.ORD_LIEFERSTART|| ';' || inout_row.ORD_LIEFERENDE|| ';'|| inout_row.ORD_MENGE|| ';'|| inout_row.ORD_LIEFERZONE|| ';'
                    || inout_row.ORD_MARKT|| ';'|| inout_row.ORD_GUELTIG_BIS|| ';'|| inout_row.ORD_TYPE|| ';'
                    || inout_row.ORD_IAS39;
                logger.log_error ('l_old_string = ' || l_old_string, l_scope);
                logger.log_error ('l_new_string = ' || l_new_string, l_scope);
                l_handle_error (c_ex_invalid_changes_no, c_ex_invalid_changes_msg);
            END;
        WHEN c_ex_invalid_changes_cnc THEN
            l_handle_error
                ( c_ex_invalid_changes_cnc_no
                , c_ex_invalid_changes_cnc_msg
                , VARARGS (inout_row.ORD_ID, inout_row.cnc_id)
                );
        WHEN c_ex_invalid_order THEN
            l_handle_error 
                ( c_ex_invalid_order_no
                , c_ex_invalid_order_msg
                , VARARGS (inout_row.ORD_ID, inout_row.ORD_MODUSER)
                );
        WHEN c_ex_status_invalid THEN
            l_handle_error
                ( c_ex_status_invalid_no
                , c_ex_status_invalid_msg
                , VARARGS
                    ( REPLACE (inout_row.ord_status, AOO.Stat_Cancellation_Request, 'CANCELATION REQUEST')
                    , REPLACE (l_row_old.ord_status, AOO.Stat_Cancellation_Request, 'CANCELATION REQUEST')
                    , inout_row.ORD_MODUSER
                    )
                );
        WHEN c_ex_order_expired THEN
            l_handle_error
                ( c_ex_order_expired_no
                , c_ex_order_expired_msg
                , VARARGS (inout_row.ORD_GUELTIG_BIS)
                );
        WHEN c_ex_invalid_cnc_id THEN
            l_handle_error
                ( c_ex_invalid_cnc_id_no
                , c_ex_invalid_cnc_id_msg
                );
        WHEN c_ex_invalid_market THEN
            l_handle_error
                ( c_ex_invalid_market_no
                , c_ex_invalid_market_msg
                );
        WHEN c_ex_invalid_hedge_update THEN
            l_handle_error
                ( c_ex_invalid_hedge_update_no
                , c_ex_invalid_hedge_update_msg
                );
        WHEN c_ex_invalid_hedge_order THEN
            l_handle_error
                ( c_ex_invalid_hedge_order_no
                , c_ex_invalid_hedge_order_msg
                );
        WHEN c_ex_update_not_allowed_ms THEN
            l_handle_error
                ( c_ex_update_not_allowed_ms_no
                ,c_ex_update_not_allowed_ms_msg
                );
        WHEN c_ex_invalid_update_id THEN
            l_handle_error
                ( c_ex_invalid_update_id_no
                , c_ex_invalid_update_id_msg
                , VARARGS (inout_row.ord_id)
                );
        WHEN c_ex_no_contract_region THEN
            l_handle_error
                ( c_ex_no_contract_region_no
                , c_ex_no_contract_region_msg
                , VARARGS (inout_row.ord_id)
                );
        WHEN c_ex_credit_limit_expired THEN
            l_handle_error
                ( c_ex_credit_limit_expired_no
                , c_ex_credit_limit_expired_msg
                , VARARGS (l_credit_limit_expiry_date)
                );
        WHEN c_ex_credit_limit_exceeded THEN
            l_handle_error
                ( c_ex_credit_limit_exceeded_no
                , c_ex_credit_limit_exceeded_msg
                , VARARGS (inout_row.organization_id)
                );
        WHEN c_ex_inv_organization THEN
            l_handle_error
                ( c_ex_inv_organization_no
                , c_ex_inv_organization_msg
                , AR(inout_row.organization_id)
                );
        WHEN c_ex_cant_lock_row THEN
            l_handle_error
                ( c_ex_cant_lock_row_no
                , c_ex_cant_lock_row_msg
                , AR (inout_row.ord_id)
                );
        WHEN c_ex_invalid_qswitch THEN
            l_handle_error
                ( c_ex_invalid_qswitch_no
                , c_ex_invalid_qswitch_msg
                , AR (inout_row.ord_id)
                );
        WHEN c_ex_qty_limit_exceeded THEN
            l_handle_error
                ( c_ex_qty_limit_exceeded_no
                , c_ex_qty_limit_exceeded_msg
                , VARARGS
                    ( inout_row.ord_periode
                    , inout_row.organization_id
                    , PMST.OM_PACKAGE.GET_REMAINING_QTY
                        ( inout_row.organization_id
                        , inout_row.ord_periode
                        , inout_row.ord_lieferstart
                        , inout_row.ord_produkt
                        , inout_row.ord_buysell
                        )
                    )
                );
		WHEN c_ex_invalid_price THEN
          l_handle_error
				(c_ex_invalid_price_no
				,c_ex_invalid_price_msg
				);
        WHEN c_ex_invalid_ord_type_cng THEN
          l_handle_error(c_ex_invalid_ord_type_cng_no,c_ex_invalid_ord_type_cng_msg);
        WHEN c_ex_vier_augen_prinzip THEN
          l_handle_error(c_ex_vier_augen_prinzip_no,c_ex_vier_augen_prinzip_msg);
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

    -- saves the row changes without triggering any logic and without any checks
    PROCEDURE save_row_as_silent_update (p_inout_row IN OUT oms_order%ROWTYPE, p_params IN LOGGER.TAB_PARAM)
    IS
        l_scope    logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params   logger.tab_param := p_params;
    BEGIN
        logger.log_information('endur deal num and hedge columns to be updated',l_scope,NULL,l_params);
        -- TODO: 
        -- check if user context is admin
        -- update other fields as usage grows
        -- log how many rows have been updated?
        UPDATE YYORDERDB2.OMS_ORDER
           SET   ENDUR_DEAL_NUM_EXTERNAL = p_inout_row.endur_deal_num_external
               , ENDUR_DEAL_NUM_INTERNAL = p_inout_row.endur_deal_num_internal
               , HEDGE_ORD_ID            = p_inout_row.HEDGE_ORD_ID
               , HEDGE_ORDER             = p_inout_row.HEDGE_ORDER
               , ORD_MODDATE = sysdate
         WHERE   ord_id = p_inout_row.ord_id;
		 
    EXCEPTION
        WHEN OTHERS
        THEN
            logger.log_error ('Unhandled Exception'
                            , l_scope
                            , NULL
                            , l_params);
            RAISE;
    END;

    PROCEDURE delete_row (in_ord_id IN oms_order.ord_id%TYPE)
    AS
        l_scope      logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params     logger.tab_param;
        l_row        oms_order%ROWTYPE;
        l_fl_admin   APEX_USERS.FL_ADMIN%TYPE := COALESCE (SYS_CONTEXT ('oms_context', 'fl_admin'), c.no);
        l_clob       CLOB;

        PROCEDURE l_handle_error (l_error_code PLS_INTEGER, l_message VARCHAR2, l_params VARARGS DEFAULT NULL)
        AS
            l_formatted_message   VARCHAR2 (1000 CHAR) := FORMATS (l_message, l_params);
        BEGIN
            logger.log_error (l_formatted_message, l_scope);
            RAISE_APPLICATION_ERROR (l_error_code, l_formatted_message);
        END l_handle_error;
    BEGIN
        logger.append_param (p_params => l_params, p_name => 'in_ord_id', p_val => in_ord_id);
        logger.log_information (l_scope,
                                l_scope,
                                NULL,
                                l_params);
        logger.log_information ('{', l_scope);
        l_row := get_row (in_ord_id, c.yes);

        IF l_row.ord_status != AOO.Stat_Sleeping AND l_fl_admin != c.yes
        THEN
            RAISE c_ex_delete_not_allowed;
        END IF;

        IF l_row.price_alerter_id IS NOT NULL
        THEN
            price_alerter.remove(in_row => l_row);
        END IF;

        ORDER_DML (inout_row => l_row, in_dml_type => gc_dml_delete);

       --COMMIT;
       --websocket_push_http ('Order List Update');
       --APEX_SOCKET_IO.BROADCAST_EVENT (in_service_name => 'OMS', in_event_name => 'UPDATE_NOTIFICATION');
       <<socket_notifications>>
        BEGIN
            APEX_WEB_SERVICE.g_request_headers (1).name := 'Content-Type';
            APEX_WEB_SERVICE.g_request_headers (1).VALUE := 'application/json';
            apex_json.initialize_clob_output;
            apex_json.open_object;                                                                                  -- {
            apex_json.write ('roomId', l_row.organization_id);
            apex_json.write ('actionType', c_vision_action_type_delete);
            apex_json.open_object ('payload');
            apex_json.write ('affectedRows', 1);
            apex_json.write ('id', in_ord_id);
            apex_json.close_all ();
            l_clob := apex_json.get_clob_output;

            run_async_webservice_call
                ( p_body  => l_clob
                , p_proxy => c_vision_proxy_overrride
                );

            logger.log_information ('Vision Websocket Request: ' || l_clob, l_scope, null, l_params);
            logger.log_information ('}', l_scope);
        END socket_notifications;
    EXCEPTION
        WHEN c_ex_invalid_order
        THEN
            logger.log_error ('Ungültige Order ID ' || in_ord_id || ' für delete_row angegeben',
                              l_scope,
                              NULL,
                              l_params);
            RAISE_APPLICATION_ERROR (c_ex_invalid_order_no,
                                     'Ungültige Order ID ' || in_ord_id || ' für delete_row angegeben');
        WHEN c_ex_delete_not_allowed
        THEN
            l_handle_error (c_ex_delete_not_allowed_no, c_ex_delete_not_allowed_msg);
        WHEN OTHERS
        THEN
            logger.log_error ('Unhandled Exception',
                              l_scope,
                              NULL,
                              l_params);
            RAISE;
    END delete_row;

    PROCEDURE set_status (in_ord_id IN oms_order.ord_id%TYPE, in_ord_status IN oms_order.ord_status%TYPE)
    AS
        l_scope    logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params   logger.tab_param;
        l_row      oms_order%ROWTYPE;
        l_username varchar2(100) := SYS_CONTEXT('OMS_CONTEXT','USERNAME');
    BEGIN
        logger.append_param (p_params => l_params, p_name => 'SYS_CONTEXT(OMS_CONTEXT,USERNAME)', p_val => SYS_CONTEXT('OMS_CONTEXT','USERNAME'));
        logger.log_information ('set_status(' || in_ord_id || ',' || in_ord_status || ')',
                                l_scope,
                                NULL,
                                l_params);
        l_row := get_row (in_ord_id, c.yes);

        IF l_row.ord_id IS NULL
        THEN
            RAISE c_ex_invalid_order;
        END IF;

        l_row.ord_status := in_ord_status;
        save_row (l_row, P_ADMIN_MODE => 'N');
    EXCEPTION
        WHEN c_ex_invalid_order
        THEN
            logger.log_error ('Ungültige Order ID ' || in_ord_id || ' für set_status angegeben',
                                l_scope,
                                NULL,
                                l_params);
            RAISE_APPLICATION_ERROR (c_ex_invalid_order_no,
                                     'Ungültige Order ID ' || in_ord_id || ' für set_status angegeben');
    END set_status;

    PROCEDURE expire_outdated_orders
    AS
    BEGIN
    FOR ord IN (SELECT   *
                  FROM   oms_order
                 WHERE       ord_status IN (AOO.Stat_In_System
                                          , AOO.Stat_New
                                          , AOO.Stat_Await_Settle
                                          , AOO.Stat_Update_Request
                                          , AOO.Stat_Cancellation_Request
                                          , AOO.Stat_Deletion_Request)
                         AND ORD_GUELTIG_BIS < SYSDATE)
    LOOP
        expire_outdated_order (ord.ord_id);
    END LOOP;

    --cleanup TABOO_ORDERS_ACTION_FIELDS
    DELETE FROM
        TABOO_ORDERS_ACTION_FIELDS
          WHERE   ord_id IN
                      (SELECT   t_o.ord_id
                         FROM   TABOO_ORDERS_ACTION_FIELDS t_o LEFT OUTER JOIN oms_order o_o ON t_o.ord_id = o_o.ord_id
                        WHERE      NVL (o_o.ORD_GUELTIG_BIS, SYSDATE) <= SYSDATE
                                OR t_o.ins_date_day < TRUNC (SYSDATE - 30));
    END expire_outdated_orders;

    PROCEDURE expire_outdated_order (in_ord_id NUMBER)
    AS
        l_row   oms_order%ROWTYPE;
    BEGIN
        l_row := get_row (in_ord_id, c.yes);

        IF (l_row.ORD_GUELTIG_BIS < SYSDATE)
        THEN
            set_status (in_ord_id, c_status_expired);
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND OR c_ex_invalid_order
        THEN
            logger.log_error ('could not expire order with id=' || in_ord_id);
    END expire_outdated_order;

  FUNCTION copy_order_hedge (in_row IN OUT oms_order%ROWTYPE)
        RETURN NUMBER
    AS
        l_scope    logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params   logger.tab_param;
    BEGIN
        logger.log_information ('{',
                                l_scope,
                                NULL,
                                l_params);

        IF in_row.ord_markt != 'STP-PM' THEN
            RAISE_APPLICATION_ERROR (c_ex_invalid_hedge_order_no, c_ex_invalid_hedge_order_msg) ;
        END IF;

        in_row.ord_id := NULL;                                              --ORD ID wird frei gelassen damit ein insert passiert
        in_row.ord_id_parent := NULL;                                       --ORD ID parent wird auch entfernt
        in_row.ord_status := AOO.Stat_New;
        in_row.ord_ias39 := properties.get('cond_hedge_ias39');             -- Default: FV
        in_row.ord_markt := properties.get('cond_hedge_markt');             -- Default: CHOICE
        in_row.organization_id := properties.get('cond_hedge_org_id');      -- Default: 1
        in_row.hedge_order := 'J';
		in_row.all_or_none := 'Y';
        in_row.ord_tradedate := NULL;
        in_row.obc_id := NULL;
        in_row.obc_matching_status := NULL;
        in_row.bc_request_group_id := NULL;
        in_row.bc_request_id := NULL;
        in_row.TP_CLIENT_ORDERID := NULL;
        in_row.ord_index_preiszone := NULL;
        in_row.menge_vor_update       := NULL;
        in_row.preis_vor_update       := NULL;
        in_row.all_or_none_vor_update := NULL;
        in_row.preis_vor_execute := NULL;
        in_row.menge_status_new := NULL;
        in_row.price_visual_before_update := NULL;
        in_row.cnc_contract_region_vor_execute := NULL;

        in_row.price_alerter_id := NULL;
        in_row.otc_cleared := 'N';

        logger.LOG ('saving hedge_order', l_scope);
        save_row (in_row);
        logger.log_information ('}', l_scope);
        RETURN in_row.ord_id;
    END copy_order_hedge;

    FUNCTION copy_order (in_ord_id IN oms_order.ord_id%TYPE, in_new_markt oms_order.ord_markt%TYPE DEFAULT NULL)
        RETURN NUMBER
    AS
        l_scope    logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params   logger.tab_param;
        l_row      oms_order%ROWTYPE;
    BEGIN
        logger.log_information ('{',
                                l_scope,
                                NULL,
                                l_params);

        SELECT   *
          INTO   l_row
          FROM   oms_order o
         WHERE   o.ord_id = in_ord_id;

        l_row.ord_id := NULL;                                      --ORD ID wird frei gelassen damit ein insert passiert
        l_row.ord_id_parent := NULL;                                                  --ORD ID parent wird auch entfernt
        l_row.ord_status := AOO.Stat_Sleeping;
        l_row.ord_gueltig_bis := GREATEST (TRUNC (l_row.ord_gueltig_bis), TRUNC (SYSDATE));
        l_row.ord_preis := CASE WHEN l_row.ord_type = 'Match Settle' THEN NULL ELSE l_row.ord_preis END;
        l_row.ord_comment := NULL;
        l_row.ord_tradedate := NULL;
        l_row.obc_id := NULL;
        l_row.obc_matching_status := NULL;
        l_row.bc_request_group_id := NULL;
        l_row.bc_request_id := NULL;
        l_row.ord_markt := COALESCE (in_new_markt, l_row.ord_markt);
        l_row.TP_CLIENT_ORDERID := NULL;
        l_row.ord_index_preiszone := NULL;
        l_row.menge_vor_update := NULL;
        l_row.preis_vor_update := NULL;
        l_row.preis_vor_execute := NULL;
        l_row.menge_status_new := NULL;
        l_row.price_visual_before_update := NULL;
        l_row.autoinsert := NULL;

        l_row.all_or_none_vor_update := NULL;
        l_row.cnc_contract_region_vor_execute := NULL;

        l_row.price_alerter_id := NULL;
        l_row.otc_cleared := 'N';

        l_row.hedge_order := NULL;
        l_row.hedge_ord_id := NULL;
		l_row.loc_se := NULL;
		l_row.hedge_price_visual := NULL;
        logger.LOG ('saving', l_scope);
        save_row (l_row);
        logger.log_information ('}', l_scope);
        RETURN l_row.ord_id;
    END copy_order;

    PROCEDURE copy_order (in_ord_id IN oms_order.ord_id%TYPE, in_new_markt oms_order.ord_markt%TYPE DEFAULT NULL)
    AS
        l_scope    logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params   logger.tab_param;
        l_row      oms_order%ROWTYPE;
        l_dummy    NUMBER;
    BEGIN
        logger.log_information ('{',
                                l_scope,
                                NULL,
                                l_params);
        l_dummy := copy_order (in_ord_id, in_new_markt);
        logger.log_information ('}', l_scope);
    END copy_order;

    PROCEDURE set_orders_booked
    AS
        l_scope    logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params   logger.tab_param;
	BEGIN
	   logger.log_information ('Set_Orders_Booked', l_scope, NULL, l_params);

	   oms_vpd.set_context;

	   FOR r IN (SELECT   o.ord_id
				   FROM   oms_order o 
				   JOIN   pmst.BCM_AR_GROUP_XDI_STATUS_V xdi ON (O.BC_REQUEST_GROUP_ID  = XDI.GROUP_ID)
				  WHERE   o.ord_status = AOO.Stat_Executed 
						  AND anz_booked = anz)
	   LOOP
			api_oms_order.set_status(in_ord_id => r.ord_id, in_ord_status => AOO.Stat_Booked);
	   END LOOP;

	   EXCEPTION
			WHEN OTHERS
			THEN
				logger.log_error(APEX_STRING.FORMAT('Error Code: %s Message %s at %s',
						SQLCODE, SQLERRM, DBMS_UTILITY.FORMAT_ERROR_BACKTRACE));
    END set_orders_booked;

    FUNCTION get_prod1 (p_periode IN oms_order.ord_periode%TYPE, 
                        p_lieferstart IN oms_order.ord_lieferstart%TYPE, 
                        p_lieferende IN oms_contract_check.cnc_deliverydate_to%TYPE DEFAULT NULL)
        RETURN VARCHAR2
        DETERMINISTIC
    AS
    BEGIN
        RETURN CASE p_periode
                   WHEN 'Y' THEN
                       TO_CHAR (p_lieferstart, '"CAL" YY')
                   WHEN 'Q' THEN
                       TO_CHAR (p_lieferstart, '"Q"Q YY')
                   WHEN 'M' THEN
                       TO_CHAR (p_lieferstart, 'MON YY')
                   WHEN 'W' THEN
                       TO_CHAR (p_lieferstart, '"WK" IW IY')
                   WHEN 'D' THEN
                       TO_CHAR (p_lieferstart, '"D" DD.MM.YY')
                   WHEN 'S' THEN
                       CASE EXTRACT (MONTH FROM p_lieferstart)
                           WHEN 4 THEN TO_CHAR (p_lieferstart, '"Sum" RR')
                           WHEN 10 THEN TO_CHAR (p_lieferstart, '"Win" RR')
                           ELSE 'Unknown Season'
                       END
                   WHEN 'WE' THEN
                       CASE  WHEN EXTRACT (YEAR FROM p_lieferstart) != EXTRACT (YEAR FROM sysdate) THEN
                         TO_CHAR(p_lieferstart, '"WE"-IW IY')
                       ELSE
                         TO_CHAR(p_lieferstart, '"WE"-IW')
                       END
                   WHEN 'WDB' THEN
                       CASE  WHEN EXTRACT (YEAR FROM p_lieferstart) != EXTRACT (YEAR FROM sysdate) THEN
                         TO_CHAR(p_lieferstart, '"WW"-IW IY')
                       ELSE
                         TO_CHAR(p_lieferstart, '"WW"-IW')
                       END
                   WHEN 'DA' THEN
                     TO_CHAR (p_lieferstart, '"DA" DD.MM.YY')
                   WHEN 'WD' THEN
                     TO_CHAR (p_lieferstart, '"WD" DD.MM.YY')
                   WHEN 'BOM' THEN
                     TO_CHAR (p_lieferstart, '"BOM" DD.MM.YY')
                   WHEN 'C' THEN
                     TO_CHAR (p_lieferstart, 'DD.MM.YY')||'-'||TO_CHAR(p_lieferende,'DD.MM.YY')
                   ELSE
                       TO_CHAR (p_lieferstart, 'YYYY-MM-DD')
               END;
    END get_prod1;

    -- generate a Trayport GUID for the tp_client_orderid
    FUNCTION NEW_TP_GUID
        RETURN VARCHAR2
    IS
        l_tp_guid   VARCHAR2 (100);
    BEGIN
        WITH USER_GUID AS (SELECT SYS_GUID () GUID FROM DUAL)
        SELECT   LOWER (
                     REGEXP_REPLACE (GUID,
                                     '([[:alnum:]]{8})([[:alnum:]]{4})([[:alnum:]]{4})([[:alnum:]]{4})([[:alnum:]]+)',
                                     '\1-\2-\3-\4-\5')
                 )
          INTO   l_tp_guid
          FROM   USER_GUID;

        RETURN l_tp_guid;
    END NEW_TP_GUID;

    FUNCTION status_change_valid (in_row       OMS_ORDER%ROWTYPE,
                                  in_row_old   OMS_ORDER%ROWTYPE,
                                  in_init      VARCHAR2,
                                  in_trade     VARCHAR2,
                                  in_admin     VARCHAR2)
        RETURN VARCHAR2
    AS
        l_scope       logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_status_ok   PLS_INTEGER;
        l_params      logger.tab_param;
    BEGIN
        SELECT   COUNT (*)
          INTO   l_status_ok
          FROM   TABLE (get_ordstatus_allowed_new (in_row.ORD_MODUSER,
                                                   in_row.ORGANIZATION_ID,
                                                   in_row_old.ORD_STATUS,
                                                   in_row.ORD_TYPE,
                                                   in_row.ORD_MARKT,
                                                   in_init,
                                                   in_trade,
                                                   in_admin)) t
         WHERE   t.ORD_STATUS = in_row.ORD_STATUS;

        logger.append_param (p_params => l_params, p_name => 'mod user: ', p_val => in_row.ORD_MODUSER);
        logger.append_param (p_params => l_params, p_name => 'ORGANIZATION_ID: ', p_val => in_row.ORGANIZATION_ID);
        logger.append_param (p_params => l_params, p_name => 'ORD_STATUS: ', p_val => in_row.ORD_STATUS);
        logger.append_param (p_params => l_params, p_name => 'ORD_TYPE: ', p_val => in_row.ORD_TYPE);
        logger.append_param (p_params => l_params, p_name => 'l_fl_init: ', p_val => in_init);
        logger.append_param (p_params => l_params, p_name => 'l_fl_trade: ', p_val => in_trade);
        logger.append_param (p_params => l_params, p_name => 'l_fl_adminORp_admin_mode: ', p_val => in_admin);
        logger.append_param (p_params => l_params, p_name => 'status count: ', p_val => l_status_ok);
        logger.log_information ('<<STATUS_CHANGE_CHECK>>'||CASE WHEN l_status_ok > 0 THEN 'passed' ELSE 'failed' END, l_scope, null, l_params);
        RETURN CASE WHEN l_status_ok > 0 THEN c.yes ELSE c.no END;
    END status_change_valid;

    FUNCTION fixtrade_price_is_valid (in_row OMS_ORDER%ROWTYPE)
        RETURN BOOLEAN
    IS
        l_scope        logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params       logger.tab_param;

        l_ins_type          VARCHAR2 (100)
                                := ins_type_builder (in_row.ord_periode, in_row.cnc_contract_region, in_row.ord_produkt);
        l_delivery_period   VARCHAR2 (100) := delivery_period_builder (in_row.ord_periode, in_row.ord_lieferstart);
        l_bid_ask           VARCHAR2 (10) := CASE WHEN in_row.ord_buysell = 'B' THEN 'Ask' WHEN in_row.ord_buysell = 'S' THEN 'Bid' ELSE NULL END;
        l_volume            NUMBER := in_row.ord_menge;        

        l_price_mars   NUMBER;
        l_price_oms    NUMBER;
        l_fixtrade_price_is_valid       BOOLEAN;
    BEGIN
        logger.append_param (p_params => l_params, p_name => 'in_row.ord_id', p_val => in_row.ord_id);
        logger.append_param (p_params => l_params, p_name => 'in_row.ord_buysell', p_val => in_row.ord_buysell);
        logger.append_param (p_params => l_params, p_name => 'in_row.ord_produkt', p_val => in_row.ord_produkt);
        logger.append_param (p_params => l_params, p_name => 'in_row.ord_periode', p_val => in_row.ord_periode);
        logger.append_param (p_params => l_params, p_name => 'in_row.ord_lieferstart', p_val => in_row.ord_lieferstart);
        logger.append_param (p_params => l_params, p_name => 'in_row.ord_menge', p_val => in_row.ord_menge);
        logger.append_param (p_params => l_params, p_name => 'in_row.ord_preis', p_val => in_row.ord_preis);
        logger.append_param (p_params => l_params, p_name => 'in_row.ord_type', p_val => in_row.ord_type);
        logger.append_param (p_params => l_params, p_name => 'in_row.ord_status', p_val => in_row.ord_status);
        logger.append_param (p_params   => l_params,
                             p_name     => 'in_row.cnc_contract_region',
                             p_val      => in_row.cnc_contract_region);

        logger.append_param (p_params => l_params, p_name => 'in_row.l_ins_type', p_val => l_ins_type);
        logger.append_param (p_params => l_params, p_name => 'in_row.l_delivery_period', p_val => l_delivery_period);
        logger.append_param (p_params => l_params, p_name => 'in_row.l_bid_ask', p_val => l_bid_ask);
        logger.append_param (p_params => l_params, p_name => 'in_row.l_volume', p_val => l_volume);


        if app_util.which_system = 'PROD' then
            l_price_mars := WEIGHTED_AVG_MW_PRICE_NOW@MARS (p_ins_type          => l_ins_type
                                                            , p_delivery_period   => l_delivery_period
                                                            , p_bid_ask           => l_bid_ask
                                                            , p_volume            => l_volume);
        else
            l_price_mars := WEIGHTED_AVG_MW_PRICE_NOW@MARST (p_ins_type          => l_ins_type
                                                             , p_delivery_period   => l_delivery_period
                                                             , p_bid_ask           => l_bid_ask
                                                             , p_volume            => l_volume);
            logger.append_param (p_params => l_params, p_name => 'l_price_mars', p_val => l_price_mars);
            logger.LOG ('MARS Price is '|| l_price_mars,
                l_scope,
                NULL,
                l_params);
        end if;


        l_price_oms := COALESCE (in_row.price_visual, in_row.ord_preis); -- gegen diesen Preis vergleichen wir. MARS muss besser oder gleich sein wie OMS
        logger.append_param (p_params => l_params, p_name => 'l_price_oms', p_val => l_price_oms);
        logger.LOG ('OMS Price is '|| l_price_oms,
            l_scope,
            NULL,
            l_params);

        l_fixtrade_price_is_valid := CASE in_row.ord_buysell
                                        WHEN 'B' THEN l_price_oms >= l_price_mars
                                        WHEN 'S' THEN l_price_oms <= l_price_mars
                                     END;
        logger.append_param (p_params => l_params, p_name => 'l_fixtrade_price_is_valid_vor_coalesce', p_val => l_fixtrade_price_is_valid);

        l_fixtrade_price_is_valid := coalesce(l_fixtrade_price_is_valid, FALSE);

        logger.append_param (p_params => l_params, p_name => 'l_fixtrade_price_is_valid', p_val => l_fixtrade_price_is_valid);

        logger.LOG ('Fixtrade Price is '|| case when NOT l_fixtrade_price_is_valid then 'not ' end ||'valid',
            l_scope,
            NULL,
            l_params);

        RETURN l_fixtrade_price_is_valid;
    END fixtrade_price_is_valid;

    PROCEDURE fixtrade_reserve_order (in_row OMS_ORDER%ROWTYPE)
    IS
        l_scope        logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params       logger.tab_param;

        l_ins_type          VARCHAR2 (100)
                                := ins_type_builder (in_row.ord_periode, in_row.cnc_contract_region, in_row.ord_produkt);
        l_delivery_period   VARCHAR2 (100) := delivery_period_builder (in_row.ord_periode, in_row.ord_lieferstart);
        l_bid_ask           VARCHAR2 (10) := CASE WHEN in_row.ord_buysell = 'B' THEN 'Ask' WHEN in_row.ord_buysell = 'S' THEN 'Bid' ELSE NULL END;
        l_volume            NUMBER := in_row.ord_menge;
    BEGIN
        logger.append_param (p_params => l_params, p_name => 'in_row.ord_id', p_val => in_row.ord_id);
        logger.append_param (p_params => l_params, p_name => 'in_row.ord_buysell', p_val => in_row.ord_buysell);
        logger.append_param (p_params => l_params, p_name => 'in_row.ord_produkt', p_val => in_row.ord_produkt);
        logger.append_param (p_params => l_params, p_name => 'in_row.ord_periode', p_val => in_row.ord_periode);
        logger.append_param (p_params => l_params, p_name => 'in_row.ord_lieferstart', p_val => in_row.ord_lieferstart);
        logger.append_param (p_params => l_params, p_name => 'in_row.ord_lieferende', p_val => in_row.ord_lieferende);
        logger.append_param (p_params => l_params, p_name => 'in_row.ord_menge', p_val => in_row.ord_menge);
        logger.append_param (p_params => l_params, p_name => 'in_row.ord_preis', p_val => in_row.ord_preis);
        logger.append_param (p_params => l_params, p_name => 'in_row.ord_type', p_val => in_row.ord_type);
        logger.append_param (p_params => l_params, p_name => 'in_row.ord_status', p_val => in_row.ord_status);
        logger.append_param (p_params   => l_params,
                             p_name     => 'in_row.cnc_contract_region',
                             p_val      => in_row.cnc_contract_region);
        logger.append_param (p_params => l_params, p_name => 'in_row.l_ins_type', p_val => l_ins_type);
        logger.append_param (p_params => l_params, p_name => 'in_row.l_delivery_period', p_val => l_delivery_period);
        logger.append_param (p_params => l_params, p_name => 'in_row.l_bid_ask', p_val => l_bid_ask);
        logger.append_param (p_params => l_params, p_name => 'in_row.l_volume', p_val => l_volume);

        logger.LOG ('Reserving trayport orders for Fixtrade',
                    l_scope,
                    NULL,
                    l_params);

        if app_util.which_system = 'PROD' then
            RESERVE_WEIGHTED_AVG_MW_NOW@MARS (p_ins_type          => l_ins_type
                                             , p_delivery_period   => l_delivery_period
                                             , p_bid_ask           => l_bid_ask
                                             , p_volume            => l_volume);
        else
            RESERVE_WEIGHTED_AVG_MW_NOW@MARST (p_ins_type          => l_ins_type
                                             , p_delivery_period   => l_delivery_period
                                             , p_bid_ask           => l_bid_ask
                                             , p_volume            => l_volume);
        end if;

    END;

    FUNCTION Stat_Sleeping RETURN VARCHAR2 DETERMINISTIC AS BEGIN RETURN c_status_sleeping; END Stat_Sleeping;
    FUNCTION Stat_New RETURN VARCHAR2 DETERMINISTIC AS BEGIN RETURN c_status_new; END Stat_New;
    FUNCTION Stat_Deletion_Request RETURN VARCHAR2 DETERMINISTIC AS BEGIN RETURN c_status_deletion_request; END Stat_Deletion_Request;
    FUNCTION Stat_Booked RETURN VARCHAR2 DETERMINISTIC AS BEGIN RETURN c_status_booked; END Stat_Booked;
    FUNCTION Stat_Expired RETURN VARCHAR2 DETERMINISTIC AS BEGIN RETURN c_status_expired; END Stat_Expired;
    FUNCTION Stat_Deletion_Confirmed RETURN VARCHAR2 DETERMINISTIC AS BEGIN RETURN c_status_deletion_confirmed; END Stat_Deletion_Confirmed;
    FUNCTION Stat_Cancellation_Confirmed RETURN VARCHAR2 DETERMINISTIC AS BEGIN RETURN c_status_cancelation_confirmed; END Stat_Cancellation_Confirmed;
    FUNCTION Stat_Executed RETURN VARCHAR2 DETERMINISTIC AS BEGIN RETURN c_status_executed; END Stat_Executed;
    FUNCTION Stat_In_System RETURN VARCHAR2 DETERMINISTIC AS BEGIN RETURN c_status_in_system; END Stat_In_System;
    FUNCTION Stat_Update_Request RETURN VARCHAR2 DETERMINISTIC AS BEGIN RETURN c_status_update_request; END Stat_Update_Request;
    FUNCTION Stat_Await_Settle RETURN VARCHAR2 DETERMINISTIC AS BEGIN RETURN c_status_await_settle; END Stat_Await_Settle;
    FUNCTION Stat_Cancellation_Request RETURN VARCHAR2 DETERMINISTIC AS BEGIN RETURN c_status_cancelation_request; END Stat_Cancellation_Request;
    FUNCTION Stat_Annulled RETURN VARCHAR2 DETERMINISTIC AS BEGIN RETURN c_status_annuled; END Stat_Annulled;
    FUNCTION Stat_All_Stats_CSV RETURN VARCHAR2 DETERMINISTIC AS BEGIN
        RETURN    ''
               || c_status_annuled
               || ', '
               || c_status_cancelation_request
               || ', '
               || c_status_await_settle
               || ', '
               || c_status_update_request
               || ', '
               || c_status_in_system
               || ', '
               || c_status_executed
               || ', '
               || c_status_cancelation_confirmed
               || ', '
               || c_status_deletion_confirmed
               || ', '
               || c_status_expired
               || ', '
               || c_status_booked
               || ', '
               || c_status_deletion_request
               || ', '
               || c_status_new
               || ', '
               || c_status_sleeping;END;

  	FUNCTION get_prt_name (in_ord_periode VARCHAR2, in_ord_produkt VARCHAR2, in_ord_cnc_contract_region VARCHAR2) RETURN VARCHAR2
    AS
        v_prt_name varchar2(1000) := 'POWER FUTURE ';
    BEGIN
        CASE in_ord_periode
            WHEN 'M' THEN v_prt_name := v_prt_name || 'MONTH ';
            WHEN 'Q' THEN v_prt_name := v_prt_name || 'QUARTER ';
            WHEN 'Y' THEN v_prt_name := v_prt_name || 'YEAR ';
            ELSE RETURN NULL;
        END CASE;

        IF NOT(in_ord_produkt = 'Base' OR in_ord_produkt = 'Peak') THEN
            RETURN NULL;
        ELSE
            v_prt_name := v_prt_name || UPPER(in_ord_produkt);
        END IF;

        CASE in_ord_cnc_contract_region
            WHEN 'DE' THEN v_prt_name := v_prt_name || ' GERMANY DE';
            WHEN 'AT' THEN v_prt_name := v_prt_name || ' AUSTRIA';
            WHEN 'DE/AT' THEN v_prt_name := v_prt_name || ' GERMANY';
            ELSE RETURN NULL;
        END CASE;

        RETURN v_prt_name;
    END get_prt_name;

    FUNCTION get_ts_id (in_ord_periode VARCHAR2, in_ord_produkt VARCHAR2, in_ord_cnc_contract_region VARCHAR2) RETURN VARCHAR2
    AS
        l_scope       logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        v_prt_name varchar2(1000) := 'POWER FUTURE ';
        v_ts_id varchar2(1000);
    BEGIN
        v_prt_name := get_prt_name(in_ord_periode, in_ord_produkt, in_ord_cnc_contract_region);
        IF v_prt_name IS NULL THEN
             logger.log_error ('Could not create a valid prt_name. Either the order period, product or cnc_contract_region is not in the valid range.', l_scope);
            RETURN NULL;
        END IF;

        BEGIN
            select ts_id into v_ts_id
            from adb_objects@adb
            where prt_name = v_prt_name
            and lower(dim_name) = 'settle'
            and lower(SO_NAME) = 'vets';
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                logger.log_error ('No ts_id found in adb_objects@adb for values prt_name: ' || v_prt_name || ' dim_name: SETTLE so_name: VETS', l_scope);
                RETURN NULL;
            WHEN TOO_MANY_ROWS THEN
                logger.log_error ('More than one ts_ids found in adb_objects@adb for values prt_name: ' || v_prt_name || ' dim_name: SETTLE so_name: VETS', l_scope);
                RETURN NULL;
        END;
        RETURN v_ts_id;
    END get_ts_id;

    PROCEDURE update_settlement_order_prices
    AS
        l_scope logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        v_prt_name varchar2(1000);
        v_ts_id varchar2(1000);
        v_qu_value varchar2(1000);
    BEGIN
        FOR ord IN
            (
                select *
                from oms_order
                where ord_type = 'Match Settle'
                and ord_status in ('EXECUTED', 'BOOKED')
                and preis_vor_execute IS NULL
                and ord_moddate >= TRUNC(SYSDATE - 6)
            )
            LOOP
                v_ts_id := get_ts_id(ord.ORD_PERIODE, ord.ORD_PRODUKT, NVL(ord.LOC_SO, ord.CNC_CONTRACT_REGION));
                IF v_ts_id IS NULL THEN
                    logger.log_error ('No ts_id found in adb_objects@adb for order: ' || ord.ORD_ID
                                        || ' ORD_PERIODE:' || ord.ORD_PERIODE
                                        ||  ' ORD_PRODUKT:' || ord.ORD_PRODUKT
                                        ||  ' CNC_CONTRACT_REGION:' || ord.CNC_CONTRACT_REGION,
                                        l_scope
                                    );
                    CONTINUE;
                END IF;

                BEGIN
                    select qu_value into v_qu_value
                    from adb_quote@ADB
                    where qu_ts_id = v_ts_id
                    and qu_tradedate_local = TRUNC(ord.ORD_TRADEDATE)
                    and qu_deliverydate_local =  TRUNC(ord.ORD_LIEFERSTART)
                    and qu_confidence_level >= 90
                    and rownum = 1
                    order by qu_confidence_level desc;

                    ord.PREIS_VOR_EXECUTE := v_qu_value;
					ord.ORD_PREIS := v_qu_value;
                    insert_order_history (ord);
                    api_oms_order.ORDER_DML (ord, gc_dml_update);
                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        logger.log_error ('No settlement price qu_value found in adb_quote@ADB for values qu_ts_id: ' || v_ts_id
                        || ' qu_tradedate_local: ' || TRUNC(ord.ORD_TRADEDATE)
                        || ' qu_deliverydate_local: ' || TRUNC(ord.ORD_LIEFERSTART)
                        || ' qu_confidence_level >= 90',
                        l_scope);
                        CONTINUE;
                END;
            END LOOP;
    END update_settlement_order_prices;

    FUNCTION get_ancestor_id (in_ord_id NUMBER) RETURN NUMBER
     AS
        l_scope logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_ancestor_id NUMBER;
    BEGIN
        WITH
            w_tree
            AS
                (SELECT       ord_id
                            , ord_id_parent
                            , LEVEL
                       FROM   oms_order
                 START WITH   ord_id = in_ord_id
                 CONNECT BY   ord_id = PRIOR ord_id_parent)
        SELECT  ord_id INTO l_ancestor_id
            FROM   w_tree
                WHERE   ord_id_parent IS NULL;

        RETURN l_ancestor_id;
    END get_ancestor_id;

    PROCEDURE save_pa_changes(in_pa_id IN NUMBER
							 ,in_ord_status IN VARCHAR2
							 ,in_triggered_market_price IN NUMBER)
    AS
		l_scope logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
  	    l_params       logger.tab_param;

        l_row          OMS_ORDER%ROWTYPE;
    BEGIN
        oms_vpd.set_context('PRICE_ALERTER');
		
		logger.append_param (p_params 	=> l_params
							,p_name 	=> 'in_pa_id'
							,p_val 		=> in_pa_id);
		logger.append_param (p_params 	=> l_params
							,p_name 	=> 'in_ord_status'
							,p_val 		=> in_ord_status);
		logger.append_param (p_params 	=> l_params
							,p_name 	=> 'in_triggered_market_price'
							,p_val 		=> in_triggered_market_price);
		
        SELECT   *
          INTO   l_row
          FROM   oms_order
         WHERE   price_alerter_id = in_pa_id;

        IF l_row.ord_status IN (aoo.stat_in_system
							   ,aoo.stat_update_request)
		THEN
			l_row.ord_status := in_ord_status;

			IF in_ord_status = aoo.stat_executed 
			THEN
				l_row.ord_trader := properties.get('PRICE_ALERTER_TRADER_ID');
            	l_row.ord_preis := COALESCE(in_triggered_market_price,l_row.price_visual,l_row.ord_preis);
			END IF;

			aoo.save_row (l_row);

			logger.log_information('price alerter changes: '||in_ord_status||' saved successfully'
								,l_scope
								,NULL
								,l_params);
	
        END IF;

	EXCEPTION
		WHEN NO_DATA_FOUND
		THEN
			logger.log_error ('NO_DATA_FOUND for triggered price_alert ' || in_pa_id,
							  l_scope
							  ,NULL
							  ,l_params);
			RAISE;
		WHEN OTHERS
		THEN
			logger.log_error ('Unhandled Exception',
                              l_scope,
                              NULL,
                              l_params);
            RAISE;
    END save_pa_changes;

    PROCEDURE set_autoinsert_to
        ( in_ord_id     IN oms_order.ord_id%TYPE
        , in_autoinsert IN oms_order.autoinsert%TYPE
        )
    AS
        l_scope    logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params   logger.tab_param;
        l_row      oms_order%ROWTYPE;
        l_trayport_deleted number := 0;
    BEGIN
        logger.append_param (p_params => l_params, p_name => 'SYS_CONTEXT(OMS_CONTEXT,USERNAME)', p_val => SYS_CONTEXT('OMS_CONTEXT','USERNAME'));
        logger.append_param (p_params => l_params, p_name => 'l_row.ord_status', p_val => l_row.ord_status);
        logger.append_param (p_params => l_params, p_name => 'l_row.ord_status', p_val => l_row.autoinsert);
        logger.log_information ('set_autoinsert_to(' || in_ord_id || ',' || in_autoinsert || ')',
                                l_scope,
                                NULL,
                                l_params);
        L_ROW := GET_ROW (IN_ORD_ID, C.YES);

        IF L_ROW.ORD_ID IS NULL
        THEN
            RAISE C_EX_INVALID_ORDER;
        ELSIF L_ROW.ORD_STATUS NOT IN ('NEW', 'UPDATED', 'IN SYSTEM')
        THEN
            RAISE_APPLICATION_ERROR(-20001, 'Order status is not NEW/UPDATE/IN SYSTEM');
        END IF;
        
        IF L_ROW.ORD_STATUS = 'IN SYSTEM' THEN
            SELECT   COUNT(*) 
            INTO l_trayport_deleted
                FROM   TABOO_ORDERS
                WHERE   ORD_ID = L_ROW.ORD_ID 
                    AND ACTION = 'C' 
                    AND ORDERID IS NOT NULL 
                    AND TRADEID IS NULL;
                 
            if l_trayport_deleted = 1 then
                if in_autoinsert = 'FAST_FORWARD' then
                    l_row.autoinsert := 'FAST_FORWARD_REINSERT';
                    logger.append_param (p_params => l_params, p_name => 'in_autoinsert', p_val => l_row.autoinsert);
                else
                    l_row.autoinsert := in_autoinsert;
                end if;
                save_row (l_row, P_ADMIN_MODE => 'N');               
            else
                logger.log_information ('Order (OrdId: ' || in_ord_id || ') status is IN SYSTEM, Taboo Order may not be removed from Trayport',
                             l_scope,
                             NULL,
                             l_params);   
            end if;           
        else
            l_row.autoinsert := in_autoinsert;
            save_row (l_row, P_ADMIN_MODE => 'N');
        end if;
    EXCEPTION
        WHEN c_ex_invalid_order
        THEN
            logger.log_error ('Ungültige Order ID ' || in_ord_id || ' für set_autoinsert_to angegeben',
                                l_scope,
                                NULL,
                                l_params);
            RAISE_APPLICATION_ERROR (c_ex_invalid_order_no,
                                        'Ungültige Order ID ' || in_ord_id || ' für set_autoinsert_to angegeben');
        WHEN others
        THEN
            IF SQLCODE = -20001 
            THEN
                logger.log_error ('Ungültige Order status ' || in_ord_id || ' für set_autoinsert_to angegeben',
                                l_scope,
                                NULL,
                                l_params);
                RAISE_APPLICATION_ERROR (-20100,
                                        'Ungültige Order status ' || in_ord_id || ' für set_autoinsert_to angegeben');
            ELSE
                logger.log_error ('Unexpected error in set_autoinsert_to ',
                                l_scope,
                                NULL,
                                l_params);
                RAISE_APPLICATION_ERROR (-20100,
                                        'Unexpected error ' || in_ord_id || ' in set_autoinsert_to: '|| SQLERRM);
            END IF;
    END set_autoinsert_to;
    
    PROCEDURE bulk_reinsert
        ( in_ord_id     IN oms_order.ord_id%TYPE
        )
    AS
        l_scope    logger_logs.scope%TYPE := gc_scope_prefix || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);
        l_params   logger.tab_param;
        l_row      oms_order%ROWTYPE;
        l_trayport_deleted number := 0;
    BEGIN
        logger.append_param (p_params => l_params, p_name => 'SYS_CONTEXT(OMS_CONTEXT,USERNAME)', p_val => SYS_CONTEXT('OMS_CONTEXT','USERNAME'));
        logger.append_param (p_params => l_params, p_name => 'l_row.ord_status', p_val => l_row.ord_status);
        logger.log_information ('bulk_reinsert(' || in_ord_id || ')',
                                l_scope,
                                NULL,
                                l_params);
        L_ROW := GET_ROW (IN_ORD_ID, C.YES);

        IF L_ROW.ORD_ID IS NOT NULL AND L_ROW.ORD_STATUS = 'IN SYSTEM' AND L_ROW.ORD_TYPE = 'Limitorder'
        THEN
            set_autoinsert_to(in_ord_id, 'FAST_FORWARD_REINSERT');
        END IF;       
    EXCEPTION
        WHEN others
        THEN
                logger.log_error ('Unexpected error in bulk_reinsert ',
                                l_scope,
                                NULL,
                                l_params);
                RAISE_APPLICATION_ERROR (-20100,
                                        'Unexpected error ' || in_ord_id || ' in bulk_reinsert: '|| SQLERRM);
        END bulk_reinsert;   
    

    -----------------------------------------------
    --------- SAVE ROW SUB-PROCEDURES -------------
    -----------------------------------------------
     PROCEDURE check_organization
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        )
    IS
        l_scope          logger_logs.scope%TYPE := gc_scope_prefix || 'check_organization';
        l_params         logger.tab_param := p_params;
        l_cnt            PLS_INTEGER;
    BEGIN

        SELECT COUNT(*)
          INTO l_cnt
          FROM v_organization
         WHERE organization_id = p_inout_row.organization_id;

        IF l_cnt = 0
        THEN
            logger.log_information(SYS_CONTEXT('OMS_CONTEXT','USERNAME')||' has no rights',l_scope,null,l_params);
            RAISE c_ex_inv_organization;
        END IF;
    END check_organization;

    PROCEDURE check_market
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM 
        )
    IS
        l_scope     logger_logs.scope%TYPE := gc_scope_prefix || 'check_market';
        l_params    logger.tab_param       := p_params;
    BEGIN
        IF p_inout_row.ord_status IN (AOO.Stat_Executed, AOO.Stat_Booked) AND p_inout_row.ord_markt = 'Choice'
        THEN
            RAISE c_ex_invalid_market;
        END IF;
    END check_market;

    PROCEDURE set_lieferzone
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM 
        )  
    IS
        l_scope     logger_logs.scope%TYPE := gc_scope_prefix || 'set_lieferzone';
        l_params    logger.tab_param        := p_params;
    BEGIN
        IF p_inout_row.ord_lieferzone IS NULL
        THEN
            SELECT lieferzone
              INTO p_inout_row.ord_lieferzone
              FROM v_organization ov
             WHERE ov.organization_id = p_inout_row.organization_id;

            log_difference('SET_LIEFERZONE', p_inout_row);
        END IF;
    END set_lieferzone;

    PROCEDURE set_contract_region
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        )
    IS
        l_scope  logger_logs.scope%TYPE := gc_scope_prefix || 'set_contract_region';
        l_params logger.tab_param       := p_params;
    BEGIN
        IF p_inout_row.cnc_contract_region IS NULL 
        THEN
            BEGIN
                SELECT DISTINCT occ.cnc_contract_region
                  INTO p_inout_row.cnc_contract_region
                  FROM oms_contract_check occ
                 WHERE occ.organization_id = p_inout_row.organization_id
                   AND INSTR (occ.cnc_contract_region, ':') = 0;

                log_difference('SET_CONTRACT_REGION', p_inout_row);

            EXCEPTION 
                WHEN others THEN
                    logger.log
                        ( apex_string.format
                            ( 'No unique contract region found for organization >%0<'
                            , p_inout_row.organization_id
                            )
                        , l_scope
                        );
                    RAISE c_ex_no_contract_region;
            END;
        END IF;
    END set_contract_region;

    PROCEDURE set_index_preiszone
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_old_row   IN     OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        )
    IS
        l_scope  logger_logs.scope%TYPE := gc_scope_prefix || 'set_index_preiszone';
        l_params logger.tab_param       := p_params;
    BEGIN
        IF p_inout_row.ord_status NOT IN (AOO.Stat_Executed, AOO.Stat_Booked)
            AND (p_inout_row.ord_index_preiszone IS NULL OR p_inout_row.cnc_contract_region != p_old_row.cnc_contract_region)
        THEN
            SELECT swap_name
              INTO p_inout_row.ord_index_preiszone
              FROM yyorderdb2.oms_contract_location_lookup
             WHERE contract_location = p_inout_row.cnc_contract_region 
               AND instrumenttype = 'PWR-PHYS' ;

            log_difference ('SET_INDEX_PREISZONE', p_inout_row);
        END IF;
    END set_index_preiszone;

    PROCEDURE set_ord_instrumenttype
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        )
    IS
        l_scope  logger_logs.scope%TYPE := gc_scope_prefix || 'set_ord_instrumenttype';
        l_params logger.tab_param       := p_params;
    BEGIN
        p_inout_row.ord_instrumenttype := COALESCE (p_inout_row.ord_instrumenttype, c_instrumenttype_pwr);
        log_difference ('SET_ORD_INSTRUMENTTYPE', p_inout_row);
    END set_ord_instrumenttype;

    PROCEDURE get_prod_hours_and_fin_price
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        )
    IS
        l_scope  logger_logs.scope%TYPE := gc_scope_prefix || 'get_prod_hours_and_fin_price';
        l_params logger.tab_param       := p_params;
    BEGIN
        -- OM-1826 - write Product hours
        p_inout_row.product_hours := 
            get_hours_for_product
                ( in_type            => p_inout_row.ord_produkt
                , in_ord_periode     => p_inout_row.ord_periode
                , in_ord_lieferstart => p_inout_row.ord_lieferstart
                , in_ord_lieferende  => p_inout_row.ord_lieferende
                );
        logger.log('product_hours calculated: ' || p_inout_row.product_hours, l_scope);       
        IF p_inout_row.product_hours IS NOT NULL 
        THEN
            p_inout_row.financial_price := p_inout_row.ord_preis * p_inout_row.ord_menge * p_inout_row.product_hours;
            logger.log('financial_price calculated: '|| p_inout_row.financial_price, l_scope);
        END IF;

        EXCEPTION
            WHEN others THEN
                logger.log_error
                    ( 'Error in Calculating Product Hours and Financial Price.'
                    , l_scope
                    , NULL
                    , l_params
                    );
    END get_prod_hours_and_fin_price;

    PROCEDURE check_ms_update_error
        ( p_inout_row                  IN OUT OMS_ORDER%ROWTYPE
        , p_params                     IN     LOGGER.TAB_PARAM
        , p_old_row                    IN     OMS_ORDER%ROWTYPE
        , p_just_note_or_extid_changed IN     BOOLEAN
        )
    IS
        l_scope  logger_logs.scope%TYPE := gc_scope_prefix || 'check_ms_update_error';
        l_params logger.tab_param       := p_params;
    BEGIN
        IF p_inout_row.ord_status = c_status_update_request AND p_old_row.ord_type = c_type_match_settle 
            AND NOT p_just_note_or_extid_changed
        THEN
            RAISE c_ex_update_not_allowed_ms;
        END IF;
    END check_ms_update_error;

    PROCEDURE check_conditional_hedge_order
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        )
    IS
        l_scope         logger_logs.scope%TYPE := gc_scope_prefix || 'check_conditional_hedge_order';
        l_params        logger.tab_param       := p_params;
        l_hedge         OMS_ORDER%ROWTYPE      := CASE WHEN p_inout_row.hedge_ord_id IS NOT NULL
													   THEN get_row(p_inout_row.hedge_ord_id) END;
		l_base          OMS_ORDER%ROWTYPE      := l_hedge;
        l_updated       BOOLEAN                := FALSE;
        l_current_user   VARCHAR2(100)         := SYS_CONTEXT('OMS_CONTEXT','USERNAME');
		l_changes_exist BOOLEAN				   := FALSE;
    BEGIN
		logger.append_param
			( p_params => l_params
            , p_name   => 'inout.ord_id'
            , p_val    => p_inout_row.ord_id
            );
		logger.append_param
			( p_params => l_params
            , p_name   => 'inout.hedge_ord_id'
            , p_val    => p_inout_row.hedge_ord_id
            );
		logger.append_param
			( p_params => l_params
            , p_name   => 'inout.hedge_order'
            , p_val    => p_inout_row.hedge_order
            );
        -- hedge_order changes 
        IF 	p_inout_row.hedge_order = 'J' 
        THEN
			IF  p_inout_row.ord_status IN (Stat_Deletion_Request, Stat_Cancellation_Request, Stat_Expired)
			THEN
				l_base.hedge_ord_id     := NULL;
				l_base.hedge_order      := NULL;
				
				p_inout_row.hedge_ord_id := NULL;
				p_inout_row.hedge_order  := NULL;
				
				logger.append_param( p_params => l_params
                                , p_name   => 'l_base.hedge_ord_id'
                                , p_val    => l_base.hedge_ord_id
                               );
				logger.append_param( p_params => l_params
                               , p_name   => 'l_base.hedge_order'
                               , p_val    => l_base.hedge_order
                              );
							  
				logger.log_information('hedge-pairing will be resetted because of '||p_inout_row.ord_status,l_scope,NULL,l_params);
				
				save_row_as_silent_update(l_base,l_params);
			ELSIF p_inout_row.ord_status = STAT_EXECUTED
			THEN
				l_base.ord_status := STAT_EXECUTED;
				l_base.ord_trader := properties.get('PRICE_ALERTER_TRADER_ID');
				logger.log_information('base order will be executed because of hedge-order',l_scope,NULL,l_params);
				
				save_row(l_base);
			END IF;

        -- base_order changes    
        ELSIF p_inout_row.hedge_ord_id IS NOT NULL 
			  AND p_inout_row.hedge_order = 'N' 
			  AND p_inout_row.ord_status IN (Stat_Deletion_Request, Stat_Cancellation_Request, Stat_Update_Request)
        THEN
            oms_vpd.set_context('PRICE_ALERTER');


            BEGIN
				IF l_hedge.ord_status IN (AOO.Stat_New, AOO.Stat_In_System,Stat_Update_Request)
				THEN
					l_hedge.ord_trader  := 'PRICE_ALERTER';
					l_hedge.ord_moduser := 'PRICE_ALERTER';
					logger.log_information
						( 'BaseOrd_id: '||p_inout_row.ord_id||', HedgeOrd_id: '||p_inout_row.hedge_ord_id||', Status: '||p_inout_row.ord_status
						, l_scope, NULL,l_params
						);

					IF p_inout_row.ord_status = Stat_Update_Request AND
						( p_inout_row.ord_preis        != l_hedge.ord_preis  
						OR p_inout_row.price_visual    != l_hedge.price_visual 
						OR p_inout_row.ord_gueltig_bis != l_hedge.ord_gueltig_bis
						)
					THEN
						l_hedge.ord_preis       := p_inout_row.ord_preis;
						l_hedge.price_visual    := p_inout_row.price_visual;
						l_hedge.ord_gueltig_bis := p_inout_row.ord_gueltig_bis;
                        l_changes_exist := TRUE;
                        logger.append_param
                            ( p_params => l_params
                            , p_name   => 'p_inout_row.ord_preis'
                            , p_val    => p_inout_row.ord_preis
                            );
                        logger.append_param
                            ( p_params => l_params
                            , p_name   => 'p_inout_row.price_visual'
                            , p_val    => p_inout_row.price_visual
                            );
                        logger.append_param
                            ( p_params => l_params
                            , p_name   => 'p_inout_row.ord_gueltig_bis'
                            , p_val    => p_inout_row.ord_gueltig_bis
                            );
					ELSIF p_inout_row.ord_status IN (Stat_Deletion_Request,Stat_Cancellation_Request)
					THEN
						l_hedge.hedge_ord_id      := NULL;
						l_hedge.hedge_order       := NULL;
						p_inout_row.hedge_ord_id  := NULL;
						p_inout_row.hedge_order   := NULL;
						l_changes_exist := TRUE;
					END IF;

					IF l_hedge.ord_status != Stat_Update_Request
					THEN
						IF  l_changes_exist THEN
							logger.log_information('Updates der Basisorder auf Hedge Order wird angewendet',l_scope,NULL,l_params);
							l_hedge.ord_status := p_inout_row.ord_status;
							save_row(l_hedge);
						END IF;
					 -- Wenn hedge order schon auf dem markt ist oder gerade geändert wird
					ELSE
						logger.log_error('Update der Basisorder konnte nicht auf Hedge Order angewendet werden. Daher wird die Änderung der Basisorder abgelehnt',l_scope,NULL,l_params);
						RAISE c_ex_invalid_hedge_update; 
					END IF;
				END IF;

				EXCEPTION 
					WHEN no_data_found 
					THEN
                        logger.log_error
                            ( 'Error getting hedge_order: ' || p_inout_row.ord_id
                            , l_scope
                            , NULL
                            , l_params
                            );
					WHEN OTHERS
					THEN
						logger.log_error(
							'Unhandled Exception'
							,l_scope
							,NULL
							,l_params);
						RAISE;

			END;

            oms_vpd.set_context(l_current_user);

        END IF;
    END check_conditional_hedge_order;

    PROCEDURE set_preis_vor_execute
        ( p_inout_row  IN OUT OMS_ORDER%ROWTYPE
        , p_params     IN     LOGGER.TAB_PARAM
        , p_admin_mode IN     VARCHAR2
        )
    IS
        l_scope         logger_logs.scope%TYPE := gc_scope_prefix || 'set_price_vor_execute';
        l_params        logger.tab_param       := p_params;
    BEGIN
        IF NOT (p_admin_mode = 'Y' AND p_inout_row.ORD_STATUS = AOO.Stat_Executed AND p_inout_row.ORD_TYPE = c_type_match_settle)
        THEN      
            p_inout_row.PREIS_VOR_EXECUTE := NULL;
        END IF;
        log_difference('SET_PREIS_VOR_EXECUTE', p_inout_row);
    END set_preis_vor_execute;

    PROCEDURE status_change_check
        ( p_inout_row     IN OUT OMS_ORDER%ROWTYPE
        , p_params        IN     LOGGER.TAB_PARAM
        , p_old_row       IN     OMS_ORDER%ROWTYPE
        , p_fl_init       IN     APEX_USERRIGHTS.FL_INIT%TYPE
        , p_fl_trade      IN     APEX_USERRIGHTS.FL_TRADE%TYPE
        , p_fl_admin      IN     APEX_USERS.FL_ADMIN%TYPE
        , p_user_is_admin IN     BOOLEAN
        )
    IS
        l_scope                 logger_logs.scope%TYPE := gc_scope_prefix || 'status_change_check';
        l_params                logger.tab_param       := p_params;
        l_user_is_admin         BOOLEAN                := p_user_is_admin;
        l_fl_vier_augen_prinzip    pmst.om_organization.fl_vier_augen_prinzip%TYPE;
        l_status_allowed        VARCHAR2(1)            := 
            status_change_valid
                ( in_row     => p_inout_row
                , in_row_old => p_old_row
                , in_init    => p_fl_init
                , in_trade   => p_fl_trade
                , in_admin   => p_fl_admin
                );
    BEGIN

        logger.append_param
            ( p_params => l_params
            , p_name   => 'inout.ord_id'
            , p_val    => p_inout_row.ord_id
            );

        logger.append_param
            ( p_params => l_params
            , p_name   => 'old_row.ord_id'
            , p_val    => p_inout_row.ord_id
            );

        logger.append_param
            ( p_params => l_params
            , p_name   => 'fl_init'
            , p_val    => p_fl_init
            );

        logger.append_param
            ( p_params => l_params
            , p_name   => 'fl_trade'
            , p_val    => p_fl_trade
            );

        logger.append_param
            ( p_params => l_params
            , p_name   => 'fl_admin'
            , p_val    => p_fl_admin
            );
        IF l_status_allowed = c.no 
        THEN
            IF NOT ( p_inout_row.ORD_ID_PARENT IS NOT NULL                                  /* Teilerfüllung */
                    AND
                     p_inout_row.ORD_STATUS IN (AOO.Stat_In_System, AOO.Stat_Await_Settle)
                   )
            THEN
                IF NOT l_user_is_admin AND p_inout_row.ORD_MODUSER NOT IN ('APEX_JOB', 'XDI')
                THEN
                    logger.log_information 
                        ( 'l_user_is_admin = false AND p_inout_row.ORD_MODUSER NOT IN (APEX_JOB, XDI)'
                        , l_scope
                        );
                    RAISE c_ex_status_invalid;
                END IF;
            ELSIF p_inout_row.ORD_ID_PARENT IS NOT NULL AND p_inout_row.ORD_STATUS IN (AOO.Stat_In_System, AOO.Stat_Await_Settle)
            THEN
                logger.log_information
                    ( 'l_status_ok = 0 aber wir legen gerade die Restmenge einer Teilerfüllung an und daher ist es uns egal'
                    , l_scope
                    );
            END IF;
        ELSE
            IF p_inout_row.ord_status = AOO.Stat_New and p_old_row.ord_status = AOO.Stat_Sleeping
            THEN
                BEGIN
                    SELECT fl_vier_augen_prinzip
                      INTO l_fl_vier_augen_prinzip
                      FROM pmst.om_organization
                     WHERE id = p_inout_row.organization_id
                   ;
                EXCEPTION
                    WHEN no_data_found THEN
                        NULL;
                END;
                IF l_fl_vier_augen_prinzip = 'Y' and p_inout_row.ord_trader = p_old_row.ord_trader
                THEN
                    logger.log_error
                        ( '4Augen-prinzip violation! The Trader who created the order is not allowed to set it to NEW.'
                        , l_scope
                        );
                    raise c_ex_vier_augen_prinzip;
                END IF;
            END IF;
        END IF;

        log_difference ('STATUS_CHANGE_CHECK', p_inout_row);

    END status_change_check;

    PROCEDURE set_autoinsert
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        , p_old_row   IN     OMS_ORDER%ROWTYPE
        , p_dml_type  IN     VARCHAR2
        )
    IS
        l_scope             logger_logs.scope%TYPE  := gc_scope_prefix || 'set_autoinsert';
        l_params            logger.tab_param        := p_params;
        l_row_old           OMS_ORDER%ROWTYPE       := p_old_row;
        l_autoinsert        VARCHAR2 (1)            := null;
        l_autoinsert_limit  NUMBER;
    BEGIN

        IF ((p_dml_type = gc_dml_insert OR (p_dml_type = gc_dml_update AND l_row_old.ORD_STATUS = AOO.Stat_Sleeping))
            AND p_inout_row.ORD_STATUS = AOO.Stat_New
            AND p_inout_row.autoinsert IS NULL
            ) 
            OR (p_dml_type = gc_dml_update AND p_inout_row.ORD_STATUS = AOO.Stat_Update_Request AND l_row_old.ORD_STATUS = AOO.Stat_In_System)
        THEN
            p_inout_row.autoinsert := null;

            IF p_inout_row.financial_price IS NOT NULL 
                AND p_inout_row.cnc_id IS NOT NULL 
                AND p_inout_row.ord_markt NOT IN ('STP-PM')
            THEN
                BEGIN
                    SELECT cnc_autoinsert
                        , cnc_autoinsert_limit 
                    INTO l_autoinsert
                        , l_autoinsert_limit 
                    FROM oms_contract_check 
                    WHERE cnc_id = p_inout_row.cnc_id
                    ;

                    IF l_autoinsert IN ('Y', 'J') 
                        AND p_inout_row.financial_price <= l_autoinsert_limit 
                        AND p_inout_row.financial_price <= properties.get_number ('MAX_MONETARY_ORDER_LIMIT')
                    THEN
                        IF p_inout_row.ORD_STATUS = AOO.Stat_New
                        THEN
                            p_inout_row.autoinsert := 'NEW';     
                        ELSE
                            p_inout_row.autoinsert := 'UPDATE';     
                        END IF;
                    END IF;       
                EXCEPTION 
                    WHEN no_data_found THEN
                        logger.log_error
                            ( 'Error setting AUTOINSERT status for oms order:' || p_inout_row.ord_id
                            , l_scope
                            , NULL
                            , l_params
                            );
                END;                    
            END IF;

        END IF;

        log_difference('UPDATE AUTOINSERT', p_inout_row);

    END set_autoinsert;
	
	PROCEDURE set_hedge_price_visual
		( p_inout_row IN OUT OMS_ORDER%ROWTYPE
		, p_params	  IN	 LOGGER.LOG_PARAM
		)
	IS
		l_scope             logger_logs.scope%TYPE  := gc_scope_prefix || 'set_hedge_price_visual';
        l_params            logger.tab_param        := p_params;
	BEGIN
		IF p_inout_row.ord_status = AOO.c_status_executed
           AND p_inout_row.ord_type IN ( AOO.c_type_spread_limitorder
									   , AOO.c_type_spread_dailyaverage)
        THEN
			--searching for child orders
			FOR childs (SELECT * FROM OMS_ORDER
								 WHERE parent_id = p_inout_row.ord_id)
			LOOP
				--//TODO save the hedge prices into hedge_prive_visual;
			END LOOP;
		END IF;
	END set_hedge_price_visual;
	
    PROCEDURE get_market_price
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        , p_old_row   IN     OMS_ORDER%ROWTYPE
        )
    IS
        l_scope             logger_logs.scope%TYPE  := gc_scope_prefix || 'get_market_price';
        l_params            logger.tab_param        := p_params;
        l_ins_type          VARCHAR2(100);
        l_delivery_period   VARCHAR2(100);
        l_bid_ask           VARCHAR2(10);
    BEGIN

        IF p_inout_row.ord_status IN 
            ( AOO.c_status_new
            , AOO.Stat_In_System
            , AOO.c_status_executed
            , AOO.c_status_update_request
            , AOO.c_status_await_settle
            )
            AND p_inout_row.ord_status != NVL(p_old_row.ord_status, 'INIT')
        THEN

            logger.log('set l_ins_type, call ins_type_builder', l_scope);
            l_ins_type := ins_type_builder(p_inout_row.ord_periode, p_inout_row.cnc_contract_region, p_inout_row.ord_produkt);

            logger.log('set l_delivery_period, call delivery_period_builder', l_scope);
            l_delivery_period := delivery_period_builder (p_inout_row.ord_periode, p_inout_row.ord_lieferstart);

            l_bid_ask := CASE WHEN p_inout_row.ord_buysell = 'B' THEN 'Ask' ELSE 'Bid' END;

            logger.append_param
                ( p_params => l_params
                , p_name   => 'l_ins_type'
                , p_val    => l_ins_type
                );
            logger.append_param
                ( p_params  => l_params
                , p_name    => 'l_delivery_period'
                , p_val     => l_delivery_period
                );
            logger.append_param
                ( p_params  => l_params
                , p_name    => 'l_bid_ask'
                , p_val     => l_bid_ask
                );
            logger.append_param
                ( p_params  => l_params
                , p_name    => 'p_inout_row.ord_menge'
                , p_val     => p_inout_row.ord_menge
                );
            logger.append_param
                ( p_params  => l_params
                , p_name    => 'p_inout_row.ord_periode'
                , p_val     => p_inout_row.ord_periode
                );
            logger.append_param
                ( p_params  => l_params
                , p_name    => 'p_inout_row.cnc_contract_region'
                , p_val     => p_inout_row.cnc_contract_region
                );
            logger.append_param
                ( p_params  => l_params
                , p_name    => 'p_inout_row.ord_produkt'
                , p_val     => p_inout_row.ord_produkt
                );

            logger.log_information
                ( 'MARKET_PRICE Order-ID: ' || p_inout_row.ord_id || ' Status: ' || p_inout_row.ord_status
                , l_scope
                );

            p_inout_row.market_price :=
                WEIGHTED_AVG_MW_PRICE_NOW 
                    ( p_ins_type          => l_ins_type
                    , p_delivery_period   => l_delivery_period
                    , p_bid_ask           => l_bid_ask
                    , p_volume            => p_inout_row.ord_menge
                    );

            logger.log_information
                ( 'MARKET_PRICE Order-ID: '
                || p_inout_row.ord_id
                || ' Status: '
                || p_inout_row.ord_status
                || ' Price: '
                || p_inout_row.market_price
                ,  l_scope
                );
        END IF;
        log_difference ('MARKET_PRICE', p_inout_row);
    EXCEPTION
        WHEN others THEN
            logger.log('MARKET_PRICE Fehler ' || p_inout_row.market_price, l_scope);
    END get_market_price;

    PROCEDURE check_expiry_date
        ( p_inout_row       IN OUT OMS_ORDER%ROWTYPE
        , p_params          IN     LOGGER.TAB_PARAM
        , p_user_is_admin   IN     BOOLEAN
        )
    IS
        l_scope             logger_logs.scope%TYPE  := gc_scope_prefix || 'check_expiry_date';
        l_params            logger.tab_param        := p_params;
    BEGIN
        IF (p_inout_row.ORD_GUELTIG_BIS < TRUNC (SYSDATE) AND p_inout_row.ORD_STATUS NOT IN (AOO.Stat_Expired))
            AND (NOT p_user_is_admin AND p_inout_row.ORD_MODUSER NOT IN ('APEX_JOB', 'XDI'))
        THEN
            RAISE c_ex_order_expired;
        END IF;

    END check_expiry_date;

    PROCEDURE set_ord_market
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        , p_old_row   IN     OMS_ORDER%ROWTYPE
        )
    IS
        l_scope              logger_logs.scope%TYPE := gc_scope_prefix || 'set_ord_market';
        l_params             logger.tab_param       := p_params;
        l_row_old            OMS_ORDER%ROWTYPE      := p_old_row;
        b_after_in_system    BOOLEAN                := l_row_old.ord_status != aoo.STAT_SLEEPING;
        b_waking_up          BOOLEAN                := l_row_old.ORD_STATUS =  aoo.STAT_SLEEPING AND p_inout_row.ord_status != aoo.stat_sleeping;
        b_crossing_1mw_limit BOOLEAN                := (l_row_old.ord_menge < 1 AND p_inout_row.ord_menge >= 1) OR (l_row_old.ord_menge >= 1 AND p_inout_row.ord_menge < 1);
    BEGIN
        --if the order is a vision order and the status is new then the market should be determined upon the quantity
        IF p_inout_row.ord_status IN (AOO.Stat_Sleeping,AOO.Stat_New) 
            AND ( UPPER(p_inout_row.ord_trader) like '%@VERBUND.COM%'
                OR UPPER(p_inout_row.ord_moduser) like '%@VERBUND.COM%' 
                OR UPPER(p_inout_row.sales_channel) = 'VIS'
                )
        THEN
            IF mod(p_inout_row.ORD_MENGE,1)!=0
            THEN
                p_inout_row.ORD_MARKT := 'STP-PM';
            ELSIF UPPER(l_row_old.ord_markt) = 'STP-PM' THEN
                p_inout_row.ORD_MARKT := 'Choice';
            END IF;
        END IF;

        IF b_after_in_system AND NOT b_waking_up AND b_crossing_1mw_limit
        THEN
            logger.log_error
                ( 'Invalid Quantity Switch: ord_status = '|| p_inout_row.ord_status
                || ', ord_menge = ' || p_inout_row.ORD_MENGE
                || ', old.ord_markt = ' || l_row_old.ord_markt
                , l_scope
                , NULL
                , l_params);
            RAISE c_ex_invalid_qswitch;
        END IF;

        p_inout_row.ord_markt := COALESCE(p_inout_row.ORD_MARKT,'Choice');

        log_difference('SET_ORD_MARKET', p_inout_row);
    END set_ord_market;

    PROCEDURE get_ias_field
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        )
    IS
        l_scope              logger_logs.scope%TYPE := gc_scope_prefix || 'get_ias_field';
        l_params             logger.tab_param       := p_params;
    BEGIN
        IF p_inout_row.ORD_IAS39 IS NULL
        THEN
            BEGIN
                SELECT IAS39
                  INTO p_inout_row.ORD_IAS39
                  FROM PMST.OM_ORGANIZATION
                 WHERE ID = p_inout_row.ORGANIZATION_ID;
            EXCEPTION
                WHEN no_data_found THEN
                    NULL;
            END;
        END IF;

        p_inout_row.ORD_IAS39 := COALESCE(p_inout_row.ORD_IAS39,'FV');

        log_difference('GET_IAS_FIELD', p_inout_row);

    END get_ias_field;

    PROCEDURE add_vision_fees_to_the_price
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        )
    IS
        l_scope              logger_logs.scope%TYPE := gc_scope_prefix || 'add_cnc_vision_fee_to_the_price';
        l_params             logger.tab_param       := p_params;
        l_cnc_vision_fee     OMS_CONTRACT_CHECK.CNC_VISION_FEE%TYPE := 0;
        l_vision_fee         pmst.om_company.vision_fee%type        := 0;
        l_original_ord_preis oms_order.ord_preis%TYPE;
    BEGIN
        IF p_inout_row.ord_status IN (AOO.Stat_Sleeping, AOO.Stat_New,AOO.Stat_Update_Request) AND p_inout_row.ord_type IN (c_type_limitorder,c_type_fixtrade)
        THEN
            IF p_inout_row.price_visual IS NULL
            THEN
                l_original_ord_preis := p_inout_row.ord_preis;
                --VISN-941 und OM-1728   
                IF p_inout_row.ord_type = c_type_fixtrade
                THEN 
					select nvl(max(vision_fee),0)
					  into l_vision_fee
					  from pmst.om_company
					 where id = ( select company_id
									from pmst.om_organization
								   where id = p_inout_row.organization_id
								); 

                    logger.append_param(l_params, 'l_vision_fee', l_vision_fee);

                    IF p_inout_row.ord_buysell = 'B' THEN
                        p_inout_row.ord_preis := p_inout_row.ord_preis + l_vision_fee;
                    ELSE
                        p_inout_row.ord_preis := p_inout_row.ord_preis - l_vision_fee;
                    END IF;

                    logger.log('fixtrade fee added', l_scope, null, l_params);
                END IF;

                SELECT nvl(max(cnc_vision_fee),0)
                  INTO l_cnc_vision_fee
                  FROM oms_contract_check 
                 WHERE cnc_id = p_inout_row.CNC_ID;

                logger.append_param(l_params, 'l_cnc_vision_fee', l_cnc_vision_fee);

                IF p_inout_row.ord_buysell = 'B'
                THEN
                    logger.log_information('Calculating ord_preis for buy, ord_preis: ' || p_inout_row.ord_preis,l_scope,null,l_params);
                    p_inout_row.ord_preis := p_inout_row.ord_preis + l_cnc_vision_fee;
                ELSIF p_inout_row.ord_buysell = 'S'
                THEN
                    logger.log_information('Calculating ord_preis for sell, ord_preis: '|| p_inout_row.ord_preis,l_scope,null,l_params);
                    p_inout_row.ord_preis := p_inout_row.ord_preis - l_cnc_vision_fee;
                END IF;

                IF (l_vision_fee+l_cnc_vision_fee) > 0 THEN
                    p_inout_row.price_visual := l_original_ord_preis;
                END IF;

				logger.append_param(l_params, 'price_visual', p_inout_row.price_visual);
                logger.log_information('ord_preis calculated: '|| p_inout_row.ord_preis, l_scope,NULL,l_params);
            ELSE
                logger.log
                    ( 'price_visual is not null, order id:' || p_inout_row.ord_id || ',price_visual: '|| p_inout_row.price_visual 
                    , l_scope
                    , NULL
                    , l_params
                    );
            END IF;
        END IF;
        log_difference('ADD_VISION_FEES_TO_THE_PRICE', p_inout_row);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            logger.log_error
                ( 'Error adding CNC_VISION_FEE for oms order:' || p_inout_row.ord_id || ', cnc_vision_fee not found, cnc_id: '|| p_inout_row.cnc_id 
                , l_scope
                , NULL
                , l_params
                );
    END add_vision_fees_to_the_price;

    PROCEDURE reserve_fixtrade_order
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        )
    IS
        l_scope                     logger_logs.scope%TYPE  := gc_scope_prefix || 'reserver_fixtrade_order';
        l_params                    logger.tab_param        := p_params;
    BEGIN
        IF p_inout_row.ord_type = 'Fixtrade' and p_inout_row.ord_status = AOO.Stat_New
        THEN
            IF NOT api_oms_order.fixtrade_price_is_valid(in_row => p_inout_row)
            THEN
                RAISE_APPLICATION_ERROR(api_oms_order.c_ex_invalid_ft_price_no, api_oms_order.c_ex_invalid_ft_price_msg);
            ELSE
                api_oms_order.fixtrade_reserve_order(in_row => p_inout_row);
            END IF;
        END IF;
    END reserve_fixtrade_order;

    PROCEDURE cnc_expiration_check
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        )
    IS
        l_scope                     logger_logs.scope%TYPE  := gc_scope_prefix || 'cnc_expiration_check';
        l_params                    logger.tab_param        := p_params;
        l_credit_limit_expiry_date  DATE;
    BEGIN
        --OM-1657 Credit checks sollen nur bei status new erfolgen.
        IF p_inout_row.ord_status = AOO.Stat_New AND (oms_credit_watcher.IS_CNC_EXPIRATION_CHECK_ACTIVE(in_organization_id => p_inout_row.organization_id)) 
        THEN
            logger.log('get the l_credit_limit_expiry_date value, call oms_credit_wathcer.get_credit_limit_expiry_date', l_scope);
            l_credit_limit_expiry_date := oms_credit_watcher.GET_CREDIT_LIMIT_EXPIRY_DATE(p_inout_row.organization_id);

            IF l_credit_limit_expiry_date IS NULL OR p_inout_row.ord_lieferstart > l_credit_limit_expiry_date
            THEN
                RAISE c_ex_credit_limit_expired;
            END IF;

            log_difference('CNC_EXPIRATION_CHECK', p_inout_row);
        END IF;
    END cnc_expiration_check;

    PROCEDURE cnc_quantity_limit_management
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        )
    IS
        l_scope                 logger_logs.scope%TYPE        := gc_scope_prefix || 'cnc_quantity_limit_management';
        l_params                logger.tab_param              := p_params;
        l_org_row               PMST.OM_ORGANIZATION%ROWTYPE;
        l_actual_qty_mng_row    PMST.OM_ORG_QTY_MNG%ROWTYPE;
        l_credit_limit_exceeded NUMBER;
        l_remaining_qty         NUMBER;
    BEGIN

        IF p_inout_row.ord_status IN (AOO.Stat_New, AOO.Stat_Update_Request) 
        THEN
            logger.log('get org_row from pmst.om_organization, org_id: '|| p_inout_row.organization_id, l_scope);

            SELECT *
              INTO l_org_row 
              FROM PMST.OM_ORGANIZATION o 
             WHERE o.id = p_inout_row.organization_id
            ;

            IF l_org_row.credit_watcher_active = 'Y'
            THEN
                IF p_inout_row.ord_status = AOO.Stat_New
                THEN
                    logger.log('set the value of l_credit_limit_exceeded, call oms_credit_watcher.credit_limit_exceeded', l_scope);
                    l_credit_limit_exceeded := 
                        oms_credit_watcher.credit_limit_exceeded
                            ( in_organization_id => p_inout_row.organization_id
                            , new_order          => p_inout_row
                            );   
                    IF l_credit_limit_exceeded = 1
                    THEN
                        RAISE c_ex_credit_limit_exceeded;
                    ELSIF l_credit_limit_exceeded = -1
                    THEN
                        logger.log_error ('Credit limit could not be calculated. Check error logs from OMS_CREDIT_WATCHER for further details.', l_scope, NULL, l_params);
                    END IF;
                END IF;
            ELSIF l_org_row.quantity_management_active = 'Y' -- OM-1715 : Es gibt drei mögliche LIMIT Management Optionen;
            THEN                                             -- 1) Creditwatcher 2) QuantityManagement 3) None
                logger.log('set the value of l_remaining_qty, call pmst.om_package.get_remaining_qty', l_scope);
                l_remaining_qty := 
                    PMST.OM_PACKAGE.GET_REMAINING_QTY
                        ( p_inout_row.organization_id
                        , p_inout_row.ord_periode
                        , p_inout_row.ord_lieferstart
                        , p_inout_row.ord_produkt
                        , p_inout_row.ord_buysell
                        );                          
                IF p_inout_row.ord_menge > l_remaining_qty  
                THEN
                    RAISE c_ex_qty_limit_exceeded;
                END IF;
            ELSE
                logger.log_information('NO CNC QUANTITY CHECK for org_id: '||p_inout_row.organization_id,l_scope);
            END IF;

        END IF;
    EXCEPTION
        WHEN no_data_found THEN
            logger.log_error
                ( 'Could not get boolean credit_watcher_active from table om_organization with id ' || p_inout_row.organization_id
                , l_scope
                , NULL
                , l_params
                );
        -- WHEN c_ex_qty_limit_exceeded THEN
        --     l_handle_error
        --         ( c_ex_qty_limit_exceeded_no
        --         , c_ex_qty_limit_exceeded_msg
        --         , VARARGS 
        --             ( inout_row.ord_periode
        --             , inout_row.organization_id
        --             , l_remaining_qty
        --             )
        --         );

    END cnc_quantity_limit_management;

    PROCEDURE taboo_generate_client_orderid
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        , p_old_row   IN     OMS_ORDER%ROWTYPE
        )
    IS
        l_scope     logger_logs.scope%TYPE  := gc_scope_prefix || 'taboo_generate_client_orderid';
        l_params    logger.tab_param        := p_params;
        l_row_old   OMS_ORDER%ROWTYPE       := p_old_row; 
    BEGIN
        p_inout_row.TP_CLIENT_ORDERID := COALESCE (l_row_old.TP_CLIENT_ORDERID, p_inout_row.TP_CLIENT_ORDERID, NEW_TP_GUID);
        log_difference ('TABOO_GENERATE_CLIENT_ORDERID', p_inout_row);
    END taboo_generate_client_orderid;

    PROCEDURE update_financial_price
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        , p_old_row   IN     OMS_ORDER%ROWTYPE
        )
    IS
        l_scope                 logger_logs.scope%TYPE := gc_scope_prefix || 'update_financial_price';
        l_params                logger.tab_param        := p_params;
        l_row_old               OMS_ORDER%ROWTYPE       := p_old_row;
    BEGIN
        logger.log('update_financial_price start', l_scope, null, l_params);

        IF l_row_old.ord_lieferstart   != p_inout_row.ord_lieferstart
            OR l_row_old.ord_periode   != p_inout_row.ord_periode
            OR l_row_old.ord_produkt   != p_inout_row.ord_produkt 
            OR p_inout_row.product_hours IS NULL
        THEN
            logger.log('calculate p_inout_row.product_hours, call get_hours_for_product', l_scope);
            p_inout_row.product_hours :=
                get_hours_for_product
                    ( in_type            => p_inout_row.ord_produkt
                    , in_ord_periode     => p_inout_row.ord_periode
                    , in_ord_lieferstart => p_inout_row.ord_lieferstart
                    , in_ord_lieferende => p_inout_row.ord_lieferende
                    );      
        END IF;

        logger.log('set p_inout_row.financial_price value', l_scope, null, l_params);
        p_inout_row.financial_price := p_inout_row.ord_preis * p_inout_row.ord_menge * p_inout_row.product_hours;

        log_difference('UPDATE_FINANCIAL_PRICE', p_inout_row);

    EXCEPTION 
        WHEN OTHERS THEN
            logger.log_error
                ( 'Error in Calculating Financial Price.'
                , l_scope
                , null
                , l_params
                );  

    END update_financial_price;

    PROCEDURE get_trader
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        , p_old_row   IN     OMS_ORDER%ROWTYPE
        )
    IS
        l_scope                 logger_logs.scope%TYPE := gc_scope_prefix || 'get_trader';
        l_params                logger.tab_param        := p_params;
        l_row_old               OMS_ORDER%ROWTYPE       := p_old_row;
    BEGIN
        IF ( ( (p_inout_row.ORD_STATUS != l_row_old.ORD_STATUS) -- Nur bei Statuswechsel setzen, wegen Admin Screen
            OR 
            (p_inout_row.ORD_TRADER IS NULL) -- zb bei Copy-Order
            )
            AND COALESCE (p_inout_row.ORD_TRADER, 'X') = COALESCE (l_row_old.ORD_TRADER, 'X')
            OR p_inout_row.ORD_TRADER IS NULL) -- Wenn der Trader nicht schon beim Update mitkommt, zb beim Admin Screen
        THEN
            logger.log('set ord_trader value', l_scope, null, l_params);
            p_inout_row.ORD_TRADER := p_inout_row.ORD_MODUSER;
        END IF;

        log_difference ('GET_TRADER', p_inout_row);
    END get_trader;

    PROCEDURE set_vor_execution
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        , p_old_row   IN     OMS_ORDER%ROWTYPE
        )
    IS
        l_scope         logger_logs.scope%TYPE := gc_scope_prefix || 'set_vor_execution';
        l_params        logger.tab_param;
        l_row_old       OMS_ORDER%ROWTYPE := p_old_row;
    BEGIN

        IF p_inout_row.ORD_STATUS != l_row_old.ORD_STATUS AND p_inout_row.ORD_STATUS = AOO.STAT_EXECUTED
        THEN
            p_inout_row.index_preiszone_vor_execute    := l_row_old.ORD_INDEX_PREISZONE;
            p_inout_row.cnc_contract_region_vor_execute := l_row_old.cnc_contract_region;
		END IF;

        logger.log('call get_before_update_values', l_scope, null, l_params);
        get_before_update_values
            ( inout_row   => p_inout_row
            , in_row_old  => l_row_old
            );

        log_difference ('GET_BEFORE_UPDATE_VALUES', p_inout_row);
    END set_vor_execution;

    PROCEDURE set_price_alerter
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        )
    IS
        l_trade_simulator           varchar2(10);
        l_give_to_trade_simulator   boolean;
        l_comp_name                 pmst.om_company.companyname%type;
        l_org_name                  pmst.om_organization.organizationname%type;
        l_scope                     logger_logs.scope%TYPE := gc_scope_prefix || 'set_price_alerter';
        l_params                    logger.tab_param;
    BEGIN

        begin
            select c.companyname
                 , o.organizationname
              into l_comp_name
                 , l_org_name
              from pmst.om_company c
              join pmst.om_organization o
                on c.id = o.company_id
             where o.id = p_inout_row.organization_id;
        exception
            when others then
                null;
        end;

        l_trade_simulator := properties.get('TRADE_SIMULATOR_ACTIVE');

        l_give_to_trade_simulator := l_trade_simulator = 'Y' AND instr(l_org_name,'Test') > 0 AND instr(l_comp_name,'Test') < 1;

        IF price_alerter.is_allowed_for_orga (p_inout_row.organization_id) 
          AND ( p_inout_row.ord_markt = 'STP-PM' 
                    OR
                 l_give_to_trade_simulator 
               )
        THEN
            IF p_inout_row.ord_status IN (stat_new, stat_update_request) AND p_inout_row.ord_type = c_type_limitorder
            THEN
                price_alerter.subscribe(in_row => p_inout_row);
            ELSIF p_inout_row.ord_status IN (Stat_Deletion_Request, stat_cancellation_Request, stat_annulled)
                AND p_inout_row.price_alerter_id IS NOT NULL
            THEN
                price_alerter.remove(in_row => p_inout_row);
            -- OM-1455 Price alert wird gelöscht, wenn Order manuell im OMS auf executed gesetzt wird.
            ELSIF SYS_CONTEXT ('oms_context', 'username') != 'PRICE_ALERTER' AND p_inout_row.ord_status = stat_executed
                AND p_inout_row.price_alerter_id IS NOT NULL
            THEN
                price_alerter.remove(in_row => p_inout_row);
            END IF;
        END IF;

        log_difference ('SET_PRICE_ALERTER', p_inout_row);
    END set_price_alerter;

    FUNCTION oms_to_bcm_api_request
        ( p_inout_row       OMS_ORDER%ROWTYPE
        , p_bcm_book_again  VARCHAR2 DEFAULT 'N'
        ) RETURN bcm_api_requests
    AS
        l_bcm_api_requests pmst.bcm_api_requests%rowtype;
    BEGIN
        l_bcm_api_requests.ORGANIZATION_ID      := p_inout_row.ORGANIZATION_ID;
        l_bcm_api_requests.BUYSELL              := p_inout_row.ORD_BUYSELL;
        l_bcm_api_requests.PRODUKT              := p_inout_row.ORD_PRODUKT;
        l_bcm_api_requests.PERIODE              := p_inout_row.ORD_PERIODE;
        l_bcm_api_requests.LIEFERSTART          := p_inout_row.ORD_LIEFERSTART;
        l_bcm_api_requests.LIEFERENDE           := p_inout_row.ORD_LIEFERENDE;
        l_bcm_api_requests.MENGE                := p_inout_row.ORD_MENGE;
        l_bcm_api_requests.PREIS                := p_inout_row.ORD_PREIS;
        l_bcm_api_requests.TRADREF_PRICE        := COALESCE (p_inout_row.PRICE_VISUAL, CASE WHEN p_inout_row.ord_status IN ('EXECUTED', 'BOOKED') THEN p_inout_row.PREIS_VOR_EXECUTE ELSE p_inout_row.ORD_PREIS END);
        l_bcm_api_requests.MARKT                := p_inout_row.ORD_MARKT;
        l_bcm_api_requests.TYPE                 := p_inout_row.ORD_TYPE;
        l_bcm_api_requests.STATUS               := p_inout_row.ORD_STATUS;
        l_bcm_api_requests.TRADER               := p_inout_row.ORD_TRADER;
        l_bcm_api_requests.BC_ID                := p_inout_row.OBC_ID;
        l_bcm_api_requests.IAS39                := p_inout_row.ORD_IAS39;
        l_bcm_api_requests.BC_MATCHING_STATUS   := p_inout_row.OBC_MATCHING_STATUS;
        l_bcm_api_requests.LIEFERZONE           := p_inout_row.ORD_LIEFERZONE;
        l_bcm_api_requests.TRADEDATE            := p_inout_row.ORD_TRADEDATE;
        l_bcm_api_requests.CALLING_SYSTEM       := p_inout_row.SALES_CHANNEL;
        l_bcm_api_requests.CALLING_ID           := p_inout_row.ORD_ID;
        l_bcm_api_requests.INSTRUMENTTYPE       := p_inout_row.ORD_INSTRUMENTTYPE;
        l_bcm_api_requests.CONTRACT_REGION      := p_inout_row.CNC_CONTRACT_REGION;
        l_bcm_api_requests.INDEX_PREISZONE      := p_inout_row.ord_index_preiszone;
        l_bcm_api_requests.PREIS_VOR_EXECUTION  := p_inout_row.PREIS_VOR_EXECUTE;
        l_bcm_api_requests.external_reference   := p_inout_row.ORD_EXTID;
        l_bcm_api_requests.ref3                 := p_bcm_book_again; -- is seen by bcm and triggers the booking again 
    
        RETURN l_bcm_api_requests;
    END oms_to_bcm_api_request;
    
    PROCEDURE bcm_book
        ( p_inout_row      IN OUT OMS_ORDER%ROWTYPE
        , p_params         IN     LOGGER.TAB_PARAM
        , p_bcm_book_again IN     VARCHAR2
        ) 
    IS
        l_scope             logger_logs.scope%TYPE := gc_scope_prefix || 'bcm_book';
        l_params            logger.tab_param;
        l_bcm_api_requests  pmst.bcm_api_requests%ROWTYPE := PMST.BCM_PACKAGE.bar_rowtype_defaults;
        l_out_obc_status    VARCHAR2 (4000);    
    begin
        IF p_bcm_book_again = c.yes
        THEN
            l_bcm_api_requests := oms_to_bcm_api_request (p_inout_row );
    
            IF PMST.BCM_PACKAGE.STATUS_IS_OK(p_inout_row.obc_matching_status)
            THEN
                PMST.BCM_PACKAGE.BOOK(l_bcm_api_requests, p_inout_row.BC_REQUEST_GROUP_ID, p_inout_row.BC_REQUEST_ID);
                logger.log('Group_ID after book: '||p_inout_row.BC_REQUEST_GROUP_ID, l_scope, null, l_params);
            ELSE
                logger.append_param(l_params, 'Error_Reason:', l_out_obc_status);
                logger.log('Did not find exactly one BC. Early exit.',l_scope, NULL, l_params);
            END IF;
        END IF;
    END bcm_book;

    PROCEDURE set_bcm
        ( p_inout_row      IN OUT OMS_ORDER%ROWTYPE
        , p_params         IN     LOGGER.TAB_PARAM
        , p_bcm_book_again IN     VARCHAR2
        , p_found_bi          OUT VARCHAR2
        )
    IS
        l_scope             logger_logs.scope%TYPE := gc_scope_prefix || 'set_bcm';
        l_params            logger.tab_param;
        l_bcm_api_requests  pmst.bcm_api_requests%ROWTYPE := PMST.BCM_PACKAGE.bar_rowtype_defaults;
        l_out_obc_id        VARCHAR2 (4000);
        l_out_obc_status    VARCHAR2 (4000);  
    BEGIN

        IF NOT (p_inout_row.ord_id_parent IS NOT NULL AND p_inout_row.ORD_STATUS = AOO.Stat_Await_Settle)  --Teilerfüllungs-Orders nicht doppelt Buchen
        THEN
            IF p_bcm_book_again = c.yes
            THEN
                l_bcm_api_requests := oms_to_bcm_api_request (p_inout_row );

                BEGIN
                    PMST.BCM_PACKAGE.bl_lookup_businesscase
                        ( in_req_row     => l_bcm_api_requests
                        , out_bc_id      => l_out_obc_id
                        , out_bc_status  => l_out_obc_status
                        );

                    EXCEPTION -- BCM soll das OMS nicht bremsen
                        WHEN dup_val_on_index THEN
                            logger.log_error
                                ( 'BCM: Deal konnte nicht über BCM gebucht werden! Bitte BCM Konfig prüfen!'
                                , l_scope
                                );
                            logger.log_error    -- duplication warning, should be removed?
                                ( apex_string.format
                                    ( 'BCM: Error Code: %0 Message %1 at %2'
                                    , SQLCODE
                                    , SQLERRM
                                    , DBMS_UTILITY.FORMAT_ERROR_BACKTRACE
                                    )
                                , l_scope
                                );
                        WHEN others THEN
                            logger.log_error
                                ( apex_string.format
                                    ( 'BCM: Error Code: %0 Message %1 at %2'
                                    , SQLCODE
                                    , SQLERRM
                                    , DBMS_UTILITY.FORMAT_ERROR_BACKTRACE
                                    )
                                , l_scope
                                );
                END;

                IF REGEXP_LIKE(l_out_obc_id, '^[0-9]+$')  --Nur ein GF trifft zu
                THEN
                    logger.log('set p_inout_row.obc_id = '|| l_out_obc_id, l_scope, null, l_params);
                    p_inout_row.OBC_ID := l_out_obc_id;
                    p_found_bi := c.yes;
                END IF;

                p_inout_row.obc_matching_status := l_out_obc_status;

                logger.log_information
                    ( 'OBC_Status: ' || l_out_obc_status || ', OBC_ID: ' || l_out_obc_id
                    , l_scope
                    , null
                    , l_params
                    );
            ELSE
                logger.log_information
                    ( apex_string.format
                        ( 'BCM: No booking issued for Order %0 from user %1!'
                        , p_inout_row.ORD_ID
                        , SYS_CONTEXT('oms_context', 'username')
                        )
                    , l_scope
                    , null
                    , l_params
                    );
            END IF;

            log_difference ('BCM', p_inout_row);

        END IF;

    END set_bcm;

    PROCEDURE set_partial_fullfilment
        ( p_inout_row                  IN OUT OMS_ORDER%ROWTYPE
        , p_params                     IN     LOGGER.TAB_PARAM
        , p_old_row                    IN OUT OMS_ORDER%ROWTYPE
        , p_just_note_or_extid_changed IN     BOOLEAN
        )
    IS
        l_scope       logger_logs.scope%TYPE :=  gc_scope_prefix || 'set_partial_fullfilment';
        l_params      logger.tab_param       := p_params;
    BEGIN
        IF NOT p_just_note_or_extid_changed
        THEN
            logger.log_information ('<<PARTIAL_FULLFILMENT>>', l_scope);
            -- Wenn keine Teilerfüllung vorliegt, hat die Order keinen Parent und zeigt auf sich selbst.
            -- Die Order soll auf EXECUTED gesetzt werden und war vorher nicht auf EXECUTED
            IF p_inout_row.ORD_STATUS = AOO.Stat_Executed AND p_old_row.ord_status != AOO.Stat_Executed
            THEN
                logger.log_information ('p_inout_row.ORD_STATUS = ' || p_inout_row.ORD_STATUS, l_scope);
                /*
                * Wir müssen unterscheiden, ob die Order vorher auf IN SYSTEM oder AWAIT SETTLE war, oder auf UPDATED
                * Bei UPDATED müssen wir nun mit der Menge vor dem Update weiterarbeiten,
                * da wir die Mengenänderung ablehnen.
                * Dazu setzen wir im alten Eintrag (update Request) die Menge händisch um auf die Menge vor dem Update.
                * Damit ist aus Sicht der nächsten Prozesse und Prüfungen alles wie vor dem Update Request.
                */
                IF p_old_row.ORD_STATUS = c_status_update_request
                THEN
                /*
                * Update Request ablehnen, daher
                * ORD_STATUS zurück vor den Wert, den es vor UPDATE Request gehabt haben muss
                * Menge und Preis ebenfalls zurück ändern vor Update Wunsch
                */
                    p_old_row.ORD_STATUS := CASE p_old_row.ORD_TYPE
                                                WHEN c_type_match_settle THEN
                                                    c_status_await_settle
                                                ELSE
                                                    c_status_in_system
                                            END;
                    p_old_row.ORD_MENGE   := p_old_row.MENGE_VOR_UPDATE;
                    p_old_row.ORD_PREIS   := p_old_row.PREIS_VOR_UPDATE;
                    p_old_row.ALL_OR_NONE := p_old_row.ALL_OR_NONE_VOR_UPDATE;
                END IF;

                IF to_number(p_inout_row.ORD_MENGE) < to_number(p_old_row.ORD_MENGE)
                THEN
                    logger.log_information ('create_partial_ful_order', l_scope);
                    create_partial_ful_order
                        ( in_row     => p_inout_row
                        , in_old_row => p_old_row
                        );
                END IF;
            END IF;
            log_difference('SET_PARTIAL_FULLFILMENT', p_inout_row);
        END IF;

    END set_partial_fullfilment;

    PROCEDURE set_oms_notification
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        )
    IS
        l_scope             logger_logs.scope%TYPE := gc_scope_prefix || 'set_oms_notification';
        l_params            logger.tab_param       := p_params;

        l_payload           CLOB;
    BEGIN

        logger.log_information
            ( apex_string.format
                ( 'trying to send notifications with ord_id: %0, ord_status: %1 '
                , p_inout_row.ord_id
                , p_inout_row.ord_status
                )
            , l_scope
            , null
            , l_params
            );

        logger.log_information
            ( apex_string.format
                ( 'trying to send notifications with ord_id: %0, ord_status: %1 '
                , p_inout_row.ord_id
                , p_inout_row.ord_status
                )
            , l_scope
            , null
            , l_params
            );

        apex_json.initialize_clob_output;
        apex_json.open_object;
        apex_json.write('ord_id'    , p_inout_row.ord_id);
        apex_json.write('ord_status',p_inout_row.ord_status);
        apex_json.close_all;

        l_payload := apex_json.get_clob_output;

        logger.log('call apex_socket_io.broadcast_event', l_scope, null, l_params);

        APEX_SOCKET_IO.BROADCAST_EVENT
            ( in_service_name => c_websocket_channel
            , in_event_name   => 'UPDATE_NOTIFICATION'
            , in_payload      => l_payload
            );

    END set_oms_notification;

    PROCEDURE set_vision_ws
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN     LOGGER.TAB_PARAM
        , p_old_row   IN     OMS_ORDER%ROWTYPE
        , p_dml_type  IN     VARCHAR2
        )
    IS
        l_scope             logger_logs.scope%TYPE := gc_scope_prefix || 'set_vision_ws';
        l_params            logger.tab_param       := p_params;

        l_row_old           OMS_ORDER%ROWTYPE      := p_old_row;
        l_dml_type          VARCHAR2(100)          := p_dml_type;
        l_clob              CLOB;
        l_output            CLOB;
    BEGIN

        APEX_WEB_SERVICE.g_request_headers(1).name  := 'Content-Type';
        APEX_WEB_SERVICE.g_request_headers(1).value := 'application/json';

        apex_json.initialize_clob_output;
        apex_json.open_object;
        apex_json.write ('roomId', p_inout_row.organization_id);

        CASE l_dml_type
            WHEN gc_dml_insert THEN
                apex_json.write('actionType', c_vision_action_type_create);
                apex_json.open_object ('payload');
                apex_json.write ('affectedRows', 1);
                apex_json.write ('id', p_inout_row.ord_id);
                apex_json.close_all ();

                l_output := apex_json.get_clob_output;

                run_async_webservice_call
                    ( p_body  => l_output
                    , p_proxy => c_vision_proxy_overrride
                    );

            WHEN gc_dml_update THEN
                apex_json.write ('actionType',
                    CASE 
                        WHEN p_inout_row.ord_status = AOO.Stat_Executed AND l_row_old.ord_status != AOO.Stat_Executed
                        THEN 
                            c_vision_action_type_execute
                        ELSE
                             c_vision_action_type_update
                    END );
                apex_json.open_object ('payload');
                apex_json.write ('affectedRows', 1);
                apex_json.write ('id', p_inout_row.ord_id);

                IF COALESCE (l_row_old.ord_comment, 'x') != COALESCE (p_inout_row.ord_comment, 'x')
                THEN
                    apex_json.write
                        ( p_name       => 'comment'
                        , p_value      => COALESCE(p_inout_row.ord_comment, '#NULL#')
                        , p_write_null => TRUE
                        );
                END IF;

                IF l_row_old.ord_produkt != p_inout_row.ord_produkt
                THEN
                    apex_json.write ('product', p_inout_row.ord_produkt);
                END IF;

                IF l_row_old.ord_buysell != p_inout_row.ord_buysell
                THEN
                    apex_json.write ('direction', p_inout_row.ord_buysell);
                END IF;

                IF l_row_old.ord_preis != p_inout_row.ord_preis
                THEN
                    apex_json.write ('price', p_inout_row.ord_preis);
                END IF;

                IF l_row_old.ord_type != p_inout_row.ord_type
                THEN
                    apex_json.write ('type', p_inout_row.ord_type);
                END IF;

                IF l_row_old.ord_menge != p_inout_row.ord_menge
                THEN
                    apex_json.write ('quantity', p_inout_row.ord_menge);
                END IF;

                IF l_row_old.ord_periode != p_inout_row.ord_periode
                THEN
                    apex_json.write ('period', p_inout_row.ord_periode);
                END IF;

                IF l_row_old.ord_status != p_inout_row.ord_status
                THEN
                    apex_json.write (
                        'status',
                        REPLACE (
                            REPLACE (
                                REPLACE (p_inout_row.ord_status,
                                        AOO.Stat_Cancellation_Request,
                                        'CANCELATION REQUEST'),
                                AOO.Stat_Await_Settle,
                                AOO.Stat_Executed
                            ),
                            AOO.Stat_Booked,
                            AOO.Stat_Executed
                        )
                    );
                END IF;

                IF l_row_old.ord_gueltig_bis != p_inout_row.ord_gueltig_bis 
                THEN
                    apex_json.write ('valid_to', p_inout_row.ord_gueltig_bis);
                END IF;

                IF COALESCE (l_row_old.ord_extid, 'x') != COALESCE (p_inout_row.ord_extid, 'x')
                THEN
                    apex_json.write
                        ( 'external_id'
                        , COALESCE (p_inout_row.ord_extid, '#NULL#')
                        , p_write_null   => TRUE
                        );
                END IF;

                IF l_row_old.ord_lieferstart != p_inout_row.ord_lieferstart
                THEN
                    apex_json.write ('delivery_start', p_inout_row.ord_lieferstart);
                END IF;

                IF l_row_old.ord_lieferende != p_inout_row.ord_lieferende
                THEN
                    apex_json.write ('delivery_end', p_inout_row.ord_lieferende);
                END IF;

                IF l_row_old.organization_id != p_inout_row.organization_id
                THEN
                    apex_json.write ('organization_id', p_inout_row.organization_id);
                END IF;

                IF p_inout_row.ord_status NOT IN (AOO.Stat_Booked)
                    AND NOT ( p_inout_row.ord_type IN (c_type_best_market, c_type_fixtrade)
                                AND p_inout_row.ord_status != aoo.stat_new
                            )                              --OM-1079
                THEN
                    apex_json.close_all;
                    l_output := REPLACE (apex_json.get_clob_output, '#NULL#');

                    run_async_webservice_call
                        ( p_body  => l_output
                        , p_proxy => c_vision_proxy_overrride
                        );
                END IF;
            ELSE
                NULL;
            END CASE;

            logger.log_information ('Vision Websocket Request: ' || apex_json.get_clob_output, l_scope, null, l_params);
            logger.log_information ('Vision Websocket Response: ' || l_clob, l_scope, null, l_params);
            logger.log_information ('}', l_scope, null, l_params);

    END set_vision_ws;

    PROCEDURE set_ord_menge
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        )
    AS
        l_scope         logger_logs.scope%type := gc_scope_prefix || 'calculate_ord_menge';
        l_params        logger.tab_param;

        l_periode       pmst.om_org_qty_mng.periode%type;
        l_periode_begin pmst.om_org_qty_mng.periode_begin%type;
        l_product       pmst.om_org_qty_mng.product%type;
        l_upper_limit   pmst.om_org_qty_mng.upper_limit%type;

        l_product_hours number;
        l_mwh_value     number;
        l_value         number := p_inout_row.ord_menge;
        l_ord_unit      p_inout_row.ord_unit%type := coalesce(p_inout_row.ord_unit,'MW');
    BEGIN
        logger.append_param(p_params => l_params, p_name => 'p_inout_row.organization_id'   , p_val => p_inout_row.organization_id);
        logger.append_param(p_params => l_params, p_name => 'p_inout_row.ord_produkt'       , p_val => p_inout_row.ord_produkt);
        logger.append_param(p_params => l_params, p_name => 'p_inout_row.ord_lieferstart'   , p_val => p_inout_row.ord_lieferstart);
        logger.append_param(p_params => l_params, p_name => 'p_inout_row.ord_lieferende'    , p_val => p_inout_row.ord_lieferende);
        logger.append_param(p_params => l_params, p_name => 'p_inout_row.ord_periode'       , p_val => p_inout_row.ord_periode);
        logger.append_param(p_params => l_params, p_name => 'p_inout_row.ord_unit'          , p_val => p_inout_row.ord_unit);
        logger.append_param(p_params => l_params, p_name => 'p_inout_row.ord_amount'        , p_val => p_inout_row.ord_amount);
        logger.append_param(p_params => l_params, p_name => 'l_ord_unit'                    , p_val => l_ord_unit);

        IF p_inout_row.product_hours IS NULL
        THEN
            p_inout_row.product_hours := get_hours_for_product
                ( p_inout_row.ord_produkt
                , p_inout_row.ord_periode
                , p_inout_row.ord_lieferstart
                , p_inout_row.ord_lieferende
                );
        END IF;
        logger.append_param(p_params => l_params, p_name => 'p_inout_row.product_hours'     , p_val => p_inout_row.product_hours);


        logger.log('SET_ORD_MENGE', l_scope, null, l_params);

        --IF p_inout_row.ord_unit like '\%' escaped by '\'
        IF l_ord_unit IN ('%MW', '%MWh')
        THEN
            -- get the upper bound
            select upper_limit
              into l_upper_limit
              from pmst.om_org_qty_mng
             where organization_id = p_inout_row.organization_id
               and periode         = p_inout_row.ord_periode
               and product         = p_inout_row.ord_produkt
               and periode_begin   = p_inout_row.ord_lieferstart
            ;

            logger.append_param(p_params => l_params, p_name => 'l_upper_limit'     , p_val => l_upper_limit);

            -- transform the menge into mwh
            IF p_inout_row.ord_unit = '%MWh'
            THEN
                l_upper_limit := l_upper_limit * l_product_hours;
            END IF;

            -- calculate the pct result
            l_value := round((p_inout_row.ord_amount * l_upper_limit) / 100, 6);

        ELSIF l_ord_unit = 'MWh'
        THEN
             l_value := round(p_inout_row.ord_amount / p_inout_row.product_hours, 6);
        ELSIF l_ord_unit = 'MW'
        THEN
            l_value := p_inout_row.ord_menge;
        ELSE
            raise_application_error('-20001', 'Invalid order unit');
        END IF;

        logger.log('calulated value: '|| l_value, l_scope, null, l_params);

        p_inout_row.ord_menge := l_value;

    END set_ord_menge;

    PROCEDURE set_ord_unit_and_amount
        ( p_inout_row IN OUT OMS_ORDER%ROWTYPE
        , p_params    IN LOGGER.TAB_PARAM
        )
    IS
        l_scope                   logger_logs.scope%TYPE := gc_scope_prefix || 'set_ord_unit_and_amount';
        l_params                  logger.tab_param := p_params;
    BEGIN
        IF p_inout_row.ord_unit IS NULL
        THEN
            p_inout_row.ord_unit := 'MW';
        END IF;

        logger.append_param(p_params => l_params, p_name => 'p_inout_row.ord_unit', p_val => p_inout_row.ord_unit);

        IF p_inout_row.ord_amount IS NULL
        THEN
            p_inout_row.ord_amount := p_inout_row.ord_menge;
        END IF;

        logger.append_param(p_params => l_params, p_name => 'p_inout_row.ord_amount', p_val => p_inout_row.ord_amount);

        log_difference('set_ord_unit_and_amount', p_inout_row);

    END set_ord_unit_and_amount;

END API_OMS_ORDER;
/

