CREATE OR REPLACE FUNCTION  GET_HOURS_FOR_PRODUCT (in_type              VARCHAR2
                                                   , in_ord_periode       VARCHAR2
                                                   , in_ord_lieferstart   DATE
                                                   , in_ord_lieferende DATE DEFAULT NULL) --for custom deliverydates
    RETURN NUMBER
IS
    l_scope                    logger_logs.scope%TYPE := LOWER ($$plsql_unit) || '.' || get_proc_name ($$plsql_unit, $$plsql_line);
    l_params                   logger.tab_param;
    l_hours_factor             NUMBER := 0;
    l_num_of_days              NUMBER := 0;
    l_num_of_months            NUMBER := 0;
    l_ord_lieferende           DATE;
	l_daylight_saving_time_hour NUMBER := 0;
    ex_bad_request             EXCEPTION;
    ex_invalid_l_num_of_days   EXCEPTION;
BEGIN
    logger.append_param (l_params, 'in_type', in_type);
    logger.append_param (l_params, 'in_ord_periode', in_ord_periode);
    logger.append_param (l_params, 'in_ord_lieferstart', in_ord_lieferstart);
    logger.append_param (l_params, 'in_ord_lieferende', in_ord_lieferende);

    logger.LOG ('Calculating Hours for OMS Product'
              , l_scope
              , NULL
              , l_params);

    IF in_ord_periode NOT IN ('W'
                            , 'WE'
                            , 'DA'
                            , 'Y'
                            , 'D'
                            , 'M'
                            , 'Q'
                            , 'S'
                            , 'C')
    THEN
        RAISE ex_bad_request;
    END IF;

    IF in_ord_periode IN ('Y'
                        , 'S'
                        , 'Q'
                        , 'M')
    THEN
        CASE in_ord_periode
            WHEN 'Y'
            THEN
                l_num_of_months := 12;
            WHEN 'S'
            THEN
                l_num_of_months := 6;
            WHEN 'Q'
            THEN
                l_num_of_months := 3;
            WHEN 'M'
            THEN
                l_num_of_months := 1;
        END CASE;
    END IF;

    logger.append_param (l_params, 'l_num_of_months', l_num_of_months);

    -- handle base product
    IF in_type = AOO.c_product_base
    THEN
        l_hours_factor := 24;

        IF in_ord_periode IN ('Y'
                            , 'S'
                            , 'Q'
                            , 'M')
        THEN
            l_num_of_days := ADD_MONTHS (in_ord_lieferstart, l_num_of_months) - in_ord_lieferstart;
        ELSIF in_ord_periode = 'W'
        THEN
            l_num_of_days := 7;
        ELSIF in_ord_periode = 'WE'
        THEN
            l_num_of_days := 2;
        ELSIF in_ord_periode IN ('D', 'DA')
        THEN
            l_num_of_days := 1;
        ELSIF in_ord_periode = 'C'
        THEN
            l_num_of_days :=  GET_WEEKDAYS_BETWEEN_TWO_DATES (in_ord_lieferstart, in_ord_lieferende);
        END IF;
		
		l_ord_lieferende := in_ord_lieferstart + l_num_of_days;

        IF in_ord_periode <> 'C' THEN        
            SELECT NVL(SUM(dst_hour),0) INTO l_daylight_saving_time_hour 
            FROM (    
                SELECT  next_day( TO_DATE( '31.03.' || to_char(EXTRACT(YEAR FROM in_ord_lieferstart))) - 7, to_char(trunc(sysdate, 'iw') - 1, 'Day')) as dst_day, -1 as dst_hour FROM dual
                UNION ALL
                SELECT next_day( TO_DATE( '31.10.' || to_char(EXTRACT(YEAR FROM in_ord_lieferstart))) - 7, to_char(trunc(sysdate, 'iw') - 1, 'Day')) as dst_day, 1 as dst_hour FROM dual
            ) daylight_saving_time 
            WHERE dst_day BETWEEN in_ord_lieferstart AND l_ord_lieferende;
        END IF;
		
    -- handle peak product
    ELSIF in_type = AOO.c_product_peak
    THEN
        l_hours_factor := 12;

        IF in_ord_periode IN ('Y'
                            , 'S'
                            , 'Q'
                            , 'M')
        THEN
            l_ord_lieferende := ADD_MONTHS (in_ord_lieferstart, l_num_of_months);
        ELSIF in_ord_periode = 'W'
        THEN
            l_ord_lieferende := in_ord_lieferstart + 7;
        ELSIF in_ord_periode = 'WE'
        THEN
            l_ord_lieferende := in_ord_lieferstart + 2;
        ELSIF in_ord_periode IN ('D', 'DA')
        THEN
            l_ord_lieferende := in_ord_lieferstart + 1;
        ELSIF in_ord_periode = 'C'
        THEN
            l_ord_lieferende := in_ord_lieferende;
        END IF;

        logger.append_param (l_params, 'l_ord_lieferende', l_ord_lieferende);
        l_num_of_days := GET_WEEKDAYS_BETWEEN_TWO_DATES (in_ord_lieferstart, l_ord_lieferende);
    ELSE
        -- invalid ord_product
        RAISE ex_bad_request;
    END IF;

    IF l_num_of_days IS NULL
    THEN
        RAISE ex_invalid_l_num_of_days;
    END IF;

    logger.append_param (l_params, 'l_hours_factor', l_hours_factor);
    logger.append_param (l_params, 'l_num_of_days', l_num_of_days);
    logger.LOG ('Calculated Days for product'
              , l_scope
              , NULL
              , l_params);

    RETURN l_num_of_days * l_hours_factor;
EXCEPTION
    WHEN ex_bad_request
    THEN
        logger.LOG_ERROR (
               'Invalid in_ord_periode. Could not calculate the number of hours for base product. '
            || ' in_ord_periode '''
            || in_ord_periode
            || ''''
            || ' in_ord_lieferstart '''
            || in_ord_lieferstart
            || ''''
          , l_scope
          , NULL
          , l_params
        );
        RETURN NULL;
    WHEN OTHERS
    THEN
        logger.LOG_ERROR (
               'Could not calculate the number of hours for base product. '
            || ' in_ord_periode '''
            || in_ord_periode
            || ''''
            || ' in_ord_lieferstart '''
            || in_ord_lieferstart
            || ''''
          , l_scope
          , NULL
          , l_params
        );
        RETURN NULL;
END GET_HOURS_FOR_PRODUCT;
/