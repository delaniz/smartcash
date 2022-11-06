--------------------------------------------------------
--  DDL for Function FORMATS
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "MACDENIZ"."FORMATS" (p_string VARCHAR2, p_args VARARGS)
   RETURN VARCHAR2
IS
   v_return   VARCHAR2 (32000 CHAR);
BEGIN
   v_return := p_string;

   IF p_args IS NOT NULL
   THEN
      FOR i IN 1 .. p_args.COUNT
      LOOP
         v_return :=
            REPLACE (v_return,
                     '{' || TO_CHAR (TO_NUMBER (i) - 1) || '}',
                     p_args (i));
      END LOOP;
   END IF;

   v_return := REGEXP_REPLACE (v_return, '\{[0-9]+\}');

--   debuglog_insert('FORMATS','v_return = '||v_return); 
   RETURN v_return;
END FORMATS;

/
