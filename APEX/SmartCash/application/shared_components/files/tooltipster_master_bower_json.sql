prompt --application/shared_components/files/tooltipster_master_bower_json
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '7B0D0A2020226E616D65223A2022746F6F6C74697073746572222C0D0A2020226D61696E223A205B22646973742F6A732F746F6F6C746970737465722E62756E646C652E6A73222C2022646973742F6373732F746F6F6C746970737465722E62756E646C';
wwv_flow_imp.g_varchar2_table(2) := '652E637373225D2C0D0A202022646570656E64656E63696573223A207B0D0A20202020226A7175657279223A20223E3D312E3130220D0A20207D0D0A7D0D0A';
wwv_flow_imp_shared.create_app_static_file(
 p_id=>wwv_flow_imp.id(1241042172907865)
,p_file_name=>'tooltipster-master/bower.json'
,p_mime_type=>'application/octet-stream'
,p_file_charset=>'utf-8'
,p_file_content => wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
