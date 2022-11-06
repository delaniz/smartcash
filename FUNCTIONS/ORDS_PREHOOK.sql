  CREATE OR REPLACE FUNCTION "ORDS_PREHOOK" RETURN BOOLEAN IS
   -- l_total_path VARCHAR2(32767 CHAR) := '/'||owa_util.get_cgi_env('X-APEX-PATH');
    l_result BOOLEAN;
    l_token apex_jwt.t_token;
    l_payload apex_json.t_values;
    l_user VARCHAR2(1000 CHAR);
BEGIN
   oms_vpd.set_context;
    --Filter für bestimmte Routen, so kann man hier etwaige Routen 'public' verfügbar machen
    IF NOT (owa_util.get_cgi_env('X-APEX-PATH') LIKE 'adfs%'
            OR owa_util.get_cgi_env('X-APEX-PATH') LIKE 'unit_test%')
        THEN 
        RETURN TRUE; 
    END IF;
    --Custom Token Validierung, hier wird zuerst versucht einen ADFS Token und dann eine Vision IDP Token zu validieren
    l_result := apex_tools.global_ords.validate_oidc_token OR apex_tools.global_ords.validate_oidc_token('https://login-dev.power.inet/account');
    --Wird false zurückgeliefert passt etwas mit dem Token nicht (abgelaufen, fehlerhaft etc.)
    IF NOT l_result THEN 
        owa_util.status_line(403, NULL, FALSE);
        OWA_UTIL.mime_header('application/json');
        apex_json.initialize_output(false);
        apex_json.open_object;
        apex_json.write('error_message', sqlerrm);
        apex_json.write('error_code', sqlcode);
        apex_json.write('stacktrace', dbms_utility.format_error_backtrace);
        apex_json.open_object('cgi_envs');
         FOR I IN 1 .. SYS.OWA.CGI_VAR_NAME.COUNT LOOP
            apex_json.write(SYS.OWA.CGI_VAR_NAME(I), SYS.OWA.CGI_VAR_VAL(I));
             /* IF UPPER(SYS.OWA.CGI_VAR_NAME(I))='PATH_INFO' THEN
                  L_PROCEDURE_NAME := UPPER(LTRIM(SYS.OWA.CGI_VAR_VAL(I), '/'));
                   EXIT;
               END IF;*/
           END LOOP;
        apex_json.close_object;
        apex_json.close_all;
        RETURN FALSE;
    END IF;
    --Wenn alles passt müssen wir den Token nochmal auslesen und verschiedene Felder prüfen
    DECLARE
        --HTTP Auth Header auslesen
        l_auth_header VARCHAR2(32767 CHAR) := owa_util.get_cgi_env('Authorization');
        --Token aus dem Header extrahieren
        l_encoded_token VARCHAR2(32767 CHAR) := TRIM(REGEXP_SUBSTR(l_auth_header, '([Bearer]+)(.*)', 1, 1, null, 2));
        nm owa.vc_arr; 
        vl owa.vc_arr;
        l_client_id VARCHAR2(32767 CHAR);
    BEGIN
        --Encodierten Token durch apex_jwt decodieren
        l_token := apex_jwt.decode(l_encoded_token);
        --Token in apex_json einlesen
        apex_json.parse(l_payload, l_token.payload);
        --Jetzt können wir die Client ID auslesen
        l_client_id := apex_json.get_varchar2(p_path => 'client_id', p_values => l_payload);
        --Ist der Token von Vision, dann verwenden wir die Email als User
        IF l_client_id = 'vision-frontend' THEN
            l_user := apex_json.get_varchar2(p_path => 'email', p_values => l_payload);
        ELSE --Hier fehlt eigentlich noch die Überprüfung des ADFS clients Names
        --Ansonsten lesen wir den unique_name aus als User
            l_user := REPLACE(apex_json.get_varchar2(p_path => 'unique_name', p_values => l_payload), 'POWER\');
        END IF;
        --Jetzt kann der OMS Context gesetzt werden
        oms_vpd.set_context(UPPER(l_user));
    END;
    RETURN l_result;
END;

/
