CREATE OR REPLACE FUNCTION YYORDERDB2."INS_TYPE_BUILDER" (in_period VARCHAR2, in_contract_location VARCHAR2, in_product VARCHAR2)
    RETURN VARCHAR2
IS
BEGIN
    IF in_period NOT IN ('D'
                       , 'W'
                       , 'M'
                       , 'Q'
                       , 'Y')
    THEN
        RAISE_APPLICATION_ERROR (-20001, 'Invalid period supplied, valid values are (D, W, M, Q, Y)');
    END IF;


    IF in_contract_location NOT IN ('DE'
                                  , 'DE/AT'
                                  , 'AT'
                                  , 'FR')
    THEN
        RAISE_APPLICATION_ERROR (-20001, 'Invalid contract location, valid values are (DE, DE/AT, AT, FR)');
    END IF;

    IF in_product NOT IN ('Base', 'Peak')
    THEN
        RAISE_APPLICATION_ERROR (-20001, 'Invalid contract location, valid values are (Base, Peak)');
    END IF;

    DECLARE
        l_mapped_period     CONSTANT VARCHAR2 (100)
            NOT NULL := CASE in_period
                            WHEN 'D' THEN 'Days'
                            WHEN 'W' THEN 'Weeks'
                            WHEN 'M' THEN 'Months'
                            WHEN 'Q' THEN 'Quarters'
                            WHEN 'Y' THEN 'Years'
                        END ;
        l_mapped_location   CONSTANT VARCHAR2 (100) NOT NULL := REPLACE (in_contract_location, '/', '/');
        l_mapped_product    CONSTANT VARCHAR2 (100) NOT NULL := in_product;
    BEGIN
        RETURN l_mapped_location || '-' || in_product || '-' || l_mapped_period;
    END;
END ins_type_builder;
/