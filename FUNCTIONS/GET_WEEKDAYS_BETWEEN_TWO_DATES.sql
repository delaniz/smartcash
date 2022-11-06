CREATE OR REPLACE FUNCTION GET_WEEKDAYS_BETWEEN_TWO_DATES (startdate DATE, enddate DATE)
    RETURN NUMBER
IS
    l_scope                    logger_logs.scope%TYPE := LOWER ($$plsql_unit);
    l_params                   logger.tab_param;
    num_of_weekdays            NUMBER;
    v1                         NUMBER;
    v2                         NUMBER;
    v3                         NUMBER;
BEGIN
    IF TO_DAY_OF_WEEK (startdate) = 7
    THEN
        v1 := 1;
    ELSE
        v1 := 0;
    END IF;

    IF TO_DAY_OF_WEEK (enddate) = 7
    THEN
        v2 := 1;
    ELSE
        v2 := 0;
    END IF;

    IF SIGN (TO_DAY_OF_WEEK (enddate) - TO_DAY_OF_WEEK (startdate)) = -1
    THEN
        v3 := 2;
    ELSE
        v3 := 0;
    END IF;

    num_of_weekdays := (enddate - startdate) - 2 * FLOOR ((enddate - startdate) / 7) - v3 + v1 - v2;
    RETURN num_of_weekdays;
EXCEPTION
    WHEN OTHERS
    THEN
        logger.LOG_ERROR (
               'Could not calculate the number of weekdays between two dates: '
            || ' startdate '''
            || startdate
            || ''''
            || ' startdate '''
            || startdate
            || ''''
          , l_scope
          , NULL
          , l_params
        );
        RETURN NULL;
END GET_WEEKDAYS_BETWEEN_TWO_DATES;
/