CREATE OR REPLACE FUNCTION WEIGHTED_AVG_MW_PRICE_NOW (p_ins_type          VARCHAR2
                                                    , p_delivery_period   VARCHAR2
                                                    , p_bid_ask           VARCHAR2
                                                    , p_volume            NUMBER)
    RETURN NUMBER
AS
BEGIN
    IF app_util.which_system = 'PROD'
    THEN
        RETURN trap.WEIGHTED_AVG_MW_PRICE_NOW@mars (p_ins_type          => p_ins_type
                                                  , p_delivery_period   => p_delivery_period
                                                  , p_bid_ask           => p_bid_ask
                                                  , p_volume            => p_volume);
    ELSE
        RETURN trap.WEIGHTED_AVG_MW_PRICE_NOW@marst (p_ins_type          => p_ins_type
                                                   , p_delivery_period   => p_delivery_period
                                                   , p_bid_ask           => p_bid_ask
                                                   , p_volume            => p_volume);
    END IF;
END;
/