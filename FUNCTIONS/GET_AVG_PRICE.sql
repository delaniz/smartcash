CREATE OR REPLACE FUNCTION YYORDERDB2."GET_AVG_PRICE" (in_odh_id NUMBER, in_ord_id NUMBER)
    RETURN NUMBER
AS
    l_price   NUMBER;
BEGIN
    BEGIN
        SELECT   market_price
          INTO   l_price
          FROM   V_OMS_ORDER_HISTORY_DETAILS
         WHERE   ord_id = in_ord_id AND odh_id = in_odh_id;
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            l_price := NULL;
    END;

    RETURN l_price;
END GET_AVG_PRICE;
/
