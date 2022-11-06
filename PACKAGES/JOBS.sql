create or replace PACKAGE "MACDENIZ"."JOBS" 
AS
    /******************************************************************************
       NAME:       JOB_LOOPS
       PURPOSE:

       REVISIONS:
       Ver        Date        Author           Description
       ---------  ----------  ---------------  ------------------------------------
       1.0        12.10.2017      schumacm       1. Created this package.
    ******************************************************************************/
    PROCEDURE STOP_LOOPS (p_commit BOOLEAN:= TRUE);

    PROCEDURE START_LOOPS (p_commit BOOLEAN:= TRUE);

    PROCEDURE LOOPS_STOP (p_commit BOOLEAN:= TRUE);

    PROCEDURE LOOPS_START (p_commit BOOLEAN:= TRUE);

    PROCEDURE ALL_STOP; -- in YYORDERDB2, TRAP, APP_UTIL, PMST

    PROCEDURE ALL_START; -- in YYORDERDB2, TRAP, APP_UTIL, PMST
    
    PROCEDURE STOP_JOB(p_job_name IN VARCHAR2, p_commit BOOLEAN := TRUE);
    
    PROCEDURE START_JOB(p_job_name IN VARCHAR2, p_commit BOOLEAN := TRUE);
    
    FUNCTION GET_JOB_STATE(p_job_name IN VARCHAR2) RETURN VARCHAR2;
END JOBS;
/
