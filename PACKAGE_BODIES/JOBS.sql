create or replace PACKAGE BODY "MACDENIZ"."JOBS" 
AS
    /******************************************************************************
       NAME:       JOB_LOOPS
       PURPOSE:

       REVISIONS:
       Ver        Date        Author           Description
       ---------  ----------  ---------------  ------------------------------------
       1.0        12.10.2017      Deniz Kaldi       1. Created this package.
    ******************************************************************************/
    PROCEDURE LOOPS_STOP (p_commit BOOLEAN:= TRUE)
    IS
    BEGIN
        FOR c IN (SELECT job_name FROM user_scheduler_jobs)
        LOOP
            DBMS_SCHEDULER.DISABLE (name => c.job_name, FORCE => TRUE);
        END LOOP;

        FOR c IN (SELECT   job_name
                    FROM   user_scheduler_jobs
                   WHERE   state = 'RUNNING')
        LOOP
            DBMS_SCHEDULER.STOP_JOB (job_name => c.job_name);
        END LOOP;

        IF COALESCE (p_commit, TRUE)
        THEN
            COMMIT;
        END IF;
    END;

    PROCEDURE LOOPS_START (p_commit BOOLEAN:= TRUE)
    IS
    BEGIN
        IF COALESCE (p_commit, TRUE)
        THEN
            COMMIT;
        END IF;

        FOR r IN (SELECT job_name FROM user_scheduler_jobs)
        LOOP
            DBMS_SCHEDULER.enable (name => r.job_name);
        END LOOP;

        FOR c IN (SELECT   job_name
                    FROM   user_scheduler_jobs
                   WHERE   job_name LIKE '%QUEUE' AND state NOT LIKE 'RUNNING')
        LOOP
            DBMS_SCHEDULER.RUN_JOB (job_name => c.job_name, USE_CURRENT_SESSION => FALSE);
        END LOOP;
    END;

    PROCEDURE STOP_LOOPS (p_commit BOOLEAN:= TRUE)
    IS
    BEGIN
        LOOPS_STOP (p_commit);
    END;

    PROCEDURE START_LOOPS (p_commit BOOLEAN:= TRUE)
    IS
    BEGIN
        LOOPS_START (p_commit);
    END;

    PROCEDURE ALL_STOP                                                         
    IS
    BEGIN
        jobs.loops_stop;
    END;

    PROCEDURE ALL_START                                                        
    IS
    BEGIN
        jobs.loops_start;
    END;
    
    PROCEDURE STOP_JOB(p_job_name IN VARCHAR2, p_commit BOOLEAN := TRUE)
    IS
    BEGIN
        FOR c IN (SELECT job_name FROM user_scheduler_jobs WHERE job_name = p_job_name)
        LOOP
            DBMS_SCHEDULER.DISABLE (name => c.job_name, FORCE => TRUE);
        END LOOP;
        FOR c in (SELECT job_name  FROM ALL_SCHEDULER_JOBS        
                    WHERE job_name = p_job_name and state = 'RUNNING')
        LOOP
             DBMS_SCHEDULER.STOP_JOB (job_name => c.job_name);
        END LOOP;
        IF COALESCE (p_commit, TRUE)
        THEN
            COMMIT;
        END IF;
    END;
    
    PROCEDURE START_JOB (p_job_name IN VARCHAR2, p_commit BOOLEAN:= TRUE)
    IS
    BEGIN
        IF COALESCE (p_commit, TRUE)
        THEN
            COMMIT;
        END IF;

        FOR c IN (SELECT job_name FROM user_scheduler_jobs WHERE job_name = p_job_name)
        LOOP
            DBMS_SCHEDULER.enable (name => c.job_name);
        END LOOP;

        FOR c IN (SELECT   job_name
                    FROM   user_scheduler_jobs
                   WHERE job_name = p_job_name AND state NOT LIKE 'RUNNING')
        LOOP
            DBMS_SCHEDULER.RUN_JOB (job_name => c.job_name, USE_CURRENT_SESSION => FALSE);
        END LOOP;
    END;
    
    FUNCTION GET_JOB_STATE(p_job_name IN VARCHAR2) 
        RETURN VARCHAR2
     IS
     BEGIN
        FOR c IN (SELECT   state
                    FROM   user_scheduler_jobs
                   WHERE job_name = p_job_name)
        LOOP
            RETURN c.state;
        END LOOP;
        
        RETURN 'JOB_NOT_FOUND';
    END;
END JOBS;
/