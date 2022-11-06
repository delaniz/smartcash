--------------------------------------------------------
--  DDL for Function GET_LONG_VAL
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "YYORDERDB2"."GET_LONG_VAL" (in_column VARCHAR2, in_table VARCHAR2, in_filter_columns AR, in_filter_vals AR) RETURN CLOB DETERMINISTIC
AS
    l_query VARCHAR2(32767) := 'SELECT '||in_column||' FROM '||in_table||' WHERE 1 = 1';
    l_cursor integer default dbms_sql.open_cursor; 
    l_n number; 
    l_long_val varchar2(32767); 
    l_long_len number; 
    l_buflen number := 250; 
    l_curpos number := 0; 
    l_return CLOB;
BEGIN
    FOR i IN 1..in_filter_columns.count
    LOOP
        l_query := l_query||CHR(10)||'AND '||in_filter_columns(i)||' = :'||in_filter_columns(i);
    END LOOP;
    dbms_sql.parse( l_cursor, l_query, dbms_sql.native ); 
    FOR i IN 1..in_filter_columns.count
    LOOP
        dbms_sql.bind_variable(l_cursor, in_filter_columns(i), in_filter_vals(i));
    END LOOP;

    dbms_sql.define_column_long(l_cursor, 1); 
    l_n := dbms_sql.execute(l_cursor); 


    IF (dbms_sql.fetch_rows(l_cursor)>0) THEN
        LOOP 
            dbms_sql.column_value_long(l_cursor, 1, l_buflen, 
            l_curpos , l_long_val, 
            l_long_len ); 
            l_curpos := l_curpos + l_long_len; 
            l_return := l_return||l_long_val;
            --dbms_output.put_line( l_long_val ); 
            exit when l_long_len = 0; 
        END LOOP;
    END IF; 
    dbms_sql.close_cursor(l_cursor); 
    RETURN l_return;
    exception 
    when others then 
    if dbms_sql.is_open(l_cursor) then 
        dbms_sql.close_cursor(l_cursor); 
    end if; 
    raise; 
END;
/
