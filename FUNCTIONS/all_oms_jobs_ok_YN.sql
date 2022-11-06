CREATE OR REPLACE FUNCTION all_oms_jobs_ok_YN RETURN VARCHAR2
as
    l_ret PLS_INTEGER;
BEGIN
    WITH individual_jobs AS
    (SELECT job_name,
           CASE WHEN state IN ('RUNNING','SCHEDULED') THEN 0 ELSE 1 END is_ok_01
    FROM user_scheduler_jobs
    WHERE job_name IN ('OMS_NOTIFICATION_QUEUE', 'OMS_TABOO_QUEUE'))
    SELECT sum(is_ok_01) INTO l_ret FROM individual_jobs;

    IF l_ret = 0 THEN
        RETURN 'Y';
    ELSE
        RETURN 'N';
    END IF;
END all_oms_jobs_ok_YN;
/
