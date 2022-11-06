--------------------------------------------------------
--  DDL for Function CLOB_LINE_BY_LINE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "YYORDERDB2"."CLOB_LINE_BY_LINE" (in_clob IN CLOB) RETURN VA PIPELINED
AS
  l_rows wwv_flow_global.vc_arr2;
  l_iterator INTEGER := 0;
  l_read PLS_INTEGER := 1;
  l_temporary VARCHAR2(32767 CHAR);
  l_previous_buffer VARCHAR2(32767 CHAR);
  l_buffer VARCHAR2(32767 CHAR);
  l_no_of_newlines PLS_INTEGER;
  l_last_newline_pos PLS_INTEGER;
  l_lines PLS_INTEGER := 1;

  l_clob CLOB := in_clob;
  l_readsize CONSTANT PLS_INTEGER :=  16383;
BEGIN
LOOP 
  IF l_clob IS NULL THEN RETURN; END IF;
    l_temporary := DBMS_LOB.SUBSTR(l_clob, l_readsize, l_read);
    l_read := l_read + l_readsize;
    l_no_of_newlines := REGEXP_COUNT(l_temporary, CHR(10));
    IF l_no_of_newlines = 0 THEN PIPE ROW(l_clob); RETURN; END IF;
    l_last_newline_pos := INSTR(l_temporary, CHR(10), 1, l_no_of_newlines);

    l_buffer := l_previous_buffer||SUBSTR(l_temporary, 1, l_last_newline_pos - 1);
    l_previous_buffer := SUBSTR(l_temporary, l_last_newline_pos + 1);
    l_rows := apex_util.string_to_table(REPLACE(l_buffer, CHR(13)), chr(10));
    for i in 1 .. l_rows.count loop
      --PRINTF(l_rows(i));
      PIPE ROW(l_rows(i));
      l_lines := l_lines + 1;
    end loop;


    l_iterator := l_iterator + 1;
    EXIT WHEN l_temporary IS NULL OR l_buffer IS NULL;
  END LOOP;
  EXCEPTION WHEN OTHERS THEN
    PRINTF('>'||in_clob||'<');
    RAISE;
END CLOB_LINE_BY_LINE;
/
