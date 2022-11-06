--------------------------------------------------------
--  DDL for Function GET_COND_HEDGE_COLUMN
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "YYORDERDB2"."GET_COND_HEDGE_COLUMN" (pORD_ID         IN NUMBER,
                                                               pSESSION          IN VARCHAR2)
   RETURN VARCHAR2
   
IS
    vDisplayButton NUMBER := 0;
BEGIN   
    select 1 INTO vDisplayButton from v_apex_userrights_markt where username = whoami and markt = 'STP-PM' fetch first row only;
    
    IF vDisplayButton = 1 THEN
        RETURN '<a href="'|| APEX_UTIL.prepare_url('f?p='||v('APP_ID')||':4:'||pSESSION||'::'||v('DEBUG')||':4:P4_ORD_ID:'||pORD_ID) ||'">
                           <div class="button_cond_hedge order_button">
                             <span class="order_button_content fa fa-synonym fam-warning fam-is-warning"></span>
                           </div>
                       </a>';
    ELSE
        RETURN ' ';
    END IF;
END;


/
