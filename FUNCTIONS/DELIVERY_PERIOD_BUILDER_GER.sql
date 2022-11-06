create or replace FUNCTION              "DELIVERY_PERIOD_BUILDER_GER" (in_period VARCHAR2, in_delivery_start DATE)
    RETURN VARCHAR2
AS
BEGIN
    IF in_period NOT IN ('D'
                       , 'W'
                       , 'M'
                       , 'Q'
                       , 'Y')
    THEN
        RAISE_APPLICATION_ERROR (-20001, 'Invalid period supplied, valid values are (D, W, M, Q, Y)');
    END IF;

    BEGIN
        RETURN CASE in_period
                   WHEN 'D'
                   THEN
                          INITCAP (TO_CHAR (in_delivery_start, 'DY', 'nls_date_language=German'))
                       || TO_CHAR (in_delivery_start, ' DD/MM/YYYY')
                   WHEN 'W'
                   THEN
                       TO_CHAR (in_delivery_start, '"KW"IW-YYYY', 'nls_date_language=English')
                   WHEN 'M'
                   THEN
                       TO_CHAR (in_delivery_start, 'MON-YYYY', 'nls_date_language=English')
                   WHEN 'Q'
                   THEN
                       TO_CHAR (in_delivery_start, '"Q"Q-YYYY', 'nls_date_language=English')
                   WHEN 'Y'
                   THEN
                       TO_CHAR (in_delivery_start, '"CAL"-YYYY', 'nls_date_language=English')
               END;
    END;
END delivery_period_builder_ger;
/