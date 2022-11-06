--------------------------------------------------------
--  DDL for Function GENERATE_RANDOM_NUMBER
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION GENERATE_RANDOM_NUMBER(
      l_start   NUMBER,
      l_end     NUMBER,
	  l_modval  NUMBER DEFAULT 0) --0 for gerade 
    RETURN NUMBER
  AS
      l_randomvalue NUMBER DEFAULT NULL;
      l_decimal_number NUMBER DEFAULT 0;
    BEGIN
      
      IF NOT ( ( 0 <= l_start ) And ( l_start < l_end ) ) Then
        raise_application_error (-20002, 'INVALID_INTERVALL! 
										INTERVALL-START MUST BE GREATER 0 AND LOWER THAN INTERVALL-END.');
      END IF;
	  
      -- create random-number:
	  SELECT length((l_modval) - trunc(l_modval)) - 1 as digits_after_decimal
			 INTO 
			 l_decimal_number
		FROM DUAL;
			 
      LOOP
        SELECT ROUND(dbms_random.value(l_start,l_end),l_decimal_number) 
			   INTO l_randomvalue 
			FROM dual;
			
        EXIT WHEN ( MOD(l_randomvalue,l_modval)=0 );
      END LOOP;      
      RETURN l_randomvalue;
 END;
 /