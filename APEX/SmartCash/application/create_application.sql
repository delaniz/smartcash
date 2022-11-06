prompt --application/create_application
begin
wwv_flow_imp.create_flow(
 p_id=>wwv_flow.g_flow_id
,p_owner=>nvl(wwv_flow_application_install.get_schema,'PLAYGROUND')
,p_name=>nvl(wwv_flow_application_install.get_application_name,'smartCash')
,p_alias=>nvl(wwv_flow_application_install.get_application_alias,'A20120220701053701856')
,p_page_view_logging=>'YES'
,p_page_protection_enabled_y_n=>'Y'
,p_checksum_salt=>'D1FC2127B269267C8C5FB26FA7028CAF765EA98D3A8CA1B68FBC11BB52FD7FA0'
,p_bookmark_checksum_function=>'SH512'
,p_accept_old_checksums=>false
,p_compatibility_mode=>'19.1'
,p_flow_language=>'de-at'
,p_flow_language_derived_from=>'FLOW_PRIMARY_LANGUAGE'
,p_date_format=>'DD.MM.YYYY'
,p_date_time_format=>'DD.MM.YYYY HH24:MI:SS'
,p_timestamp_format=>'DD.MM.YYYY HH24:MI:SSXFF'
,p_timestamp_tz_format=>'DD.MM.YYYY HH24:MI:SSXFF TZR'
,p_nls_sort=>'BINARY'
,p_direction_right_to_left=>'N'
,p_flow_image_prefix => nvl(wwv_flow_application_install.get_image_prefix,'')
,p_authentication=>'PLUGIN'
,p_authentication_id=>wwv_flow_imp.id(37626982330340786033)
,p_application_tab_set=>0
,p_logo_type=>'I'
,p_logo=>'#WORKSPACE_IMAGES#app-icon.svg'
,p_public_user=>'APEX_PUBLIC_USER'
,p_proxy_server=>nvl(wwv_flow_application_install.get_proxy,'')
,p_no_proxy_domains=>nvl(wwv_flow_application_install.get_no_proxy_domains,'')
,p_flow_version=>'Release 1.0'
,p_flow_status=>'AVAILABLE_W_EDIT_LINK'
,p_flow_unavailable_text=>'This application is currently unavailable at this time.'
,p_exact_substitutions_only=>'Y'
,p_browser_cache=>'N'
,p_browser_frame=>'D'
,p_referrer_policy=>'strict-origin-when-cross-origin'
,p_vpd=>unistr('execute immediate ''alter session set NLS_CURRENCY=''''\20AC'''''';')
,p_runtime_api_usage=>'T'
,p_authorize_batch_job=>'N'
,p_rejoin_existing_sessions=>'N'
,p_csv_encoding=>'Y'
,p_auto_time_zone=>'Y'
,p_tokenize_row_search=>'N'
,p_friendly_url=>'N'
,p_substitution_string_01=>'APP_NAME'
,p_substitution_value_01=>'smartCash'
,p_substitution_string_02=>'DATEFORMAT'
,p_substitution_value_02=>'DD.MM.YYYY HH24:MI:SS'
,p_substitution_string_03=>'CURRENCYFORMAT'
,p_substitution_value_03=>'999G999G999G999G990D00'
,p_last_updated_by=>'MACDENIZ'
,p_last_upd_yyyymmddhh24miss=>'20221002084721'
,p_file_prefix => nvl(wwv_flow_application_install.get_static_app_file_prefix,'')
,p_files_version=>35
,p_ui_type_name => null
,p_print_server_type=>'INSTANCE'
,p_is_pwa=>'N'
);
end;
/
