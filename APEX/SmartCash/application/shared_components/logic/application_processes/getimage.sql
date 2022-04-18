prompt --application/shared_components/logic/application_processes/getimage
begin
wwv_flow_imp_shared.create_flow_process(
 p_id=>wwv_flow_imp.id(37821937256791620447)
,p_process_sequence=>1
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'GETIMAGE'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    for c1 in (select *',
'                 from sc_img',
'                where iid = CASE WHEN :FILE_ID is null then ''0''',
'                                 ELSE :FILE_ID END) loop',
'        --',
'        sys.htp.init;',
'        sys.owa_util.mime_header( c1.mimetype, FALSE );',
'        sys.htp.p(''Content-length: '' || sys.dbms_lob.getlength( c1.img));',
'        sys.htp.p(''Content-Disposition: attachment; filename="'' || c1.filename || ''"'' );',
'       -- sys.htp.p(''Cache-Control: max-age=3600'');  -- tell the browser to cache for one hour, adjust as necessary',
'        sys.owa_util.http_header_close;',
'        sys.wpg_docload.download_file( c1.img );',
'     ',
'        apex_application.stop_apex_engine;',
'    end loop;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_security_scheme=>'MUST_NOT_BE_PUBLIC_USER'
);
end;
/
