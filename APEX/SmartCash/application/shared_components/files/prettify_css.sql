prompt --application/shared_components/files/prettify_css
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '2E706C6E2C202E6B77642C202E7461672C202E70756E2C202E6E6F636F6465207B0D0A202020636F6C6F723A20233130323035313B0D0A7D0D0A0D0A7072652E7072657474797072696E74207B0D0A2020206261636B67726F756E642D636F6C6F723A20';
wwv_flow_imp.g_varchar2_table(2) := '236638663866393B0D0A7D0D0A0D0A6F6C2E6C696E656E756D73207B0D0A202020636F6C6F723A2077686974653B0D0A2020206261636B67726F756E642D636F6C6F723A20234434443444393B0D0A7D0D0A0D0A2F2A204576656E2D6E756D6265726564';
wwv_flow_imp.g_varchar2_table(3) := '206C696E656E756D6265727320286C696E65206E756D626572696E67207374796C6573207374617274206174203029202A2F0D0A2F2A206F6C2E6C696E656E756D73206C693A6E74682D6368696C64286576656E292C202A2F20202F2A20466F72204854';
wwv_flow_imp.g_varchar2_table(4) := '4D4C3520616E6420616C6C206D6F6465726E2062726F7773657273202D2077696C6C20757365207768656E206965382068617320676F6E652061776179202A2F0D0A6C692E4C302C206C692E4C322C206C692E4C342C206C692E4C362C206C692E4C3820';
wwv_flow_imp.g_varchar2_table(5) := '7B0D0A2020206261636B67726F756E642D636F6C6F723A2077686974653B0D0A7D0D0A0D0A2F2A204F64642D6E756D6265726564206C696E656E756D626572733A202A2F0D0A2F2A206F6C2E6C696E656E756D73206C693A6E74682D6368696C64286F64';
wwv_flow_imp.g_varchar2_table(6) := '64292C202A2F0D0A6C692E4C312C206C692E4C332C206C692E4C352C206C692E4C372C206C692E4C39207B0D0A2020206261636B67726F756E642D636F6C6F723A20236630666666363B0D0A7D0D0A0D0A2F2A2047726561742077617920746F2073656C';
wwv_flow_imp.g_varchar2_table(7) := '656374206576656E2F6F6464206C696E65732C20646F65736E277420776F726B20696E204945382074686F7567682E0D0A6F6C2E6C696E656E756D73206C693A6E74682D6368696C64286576656E29207B0D0A2020206261636B67726F756E642D636F6C';
wwv_flow_imp.g_varchar2_table(8) := '6F723A2077686974653B0D0A7D0D0A6F6C2E6C696E656E756D73206C693A6E74682D6368696C64286F646429207B0D0A2020206261636B67726F756E642D636F6C6F723A20236630666666363B0D0A7D202A2F0D0A0D0A2E636F6D207B0D0A202020636F';
wwv_flow_imp.g_varchar2_table(9) := '6C6F723A233830383039303B0D0A202020666F6E742D7374796C653A206974616C69633B0D0A7D0D0A0D0A2E6F706E2C2E636C6F207B0D0A202020636F6C6F723A233636303B0D0A7D0D0A0D0A2E66756E207B0D0A202020636F6C6F723A202330303730';
wwv_flow_imp.g_varchar2_table(10) := '36353B0D0A7D0D0A0D0A2E7374722C2E617476207B0D0A202020636F6C6F723A20233030393964373B0D0A7D0D0A0D0A2E6C6974207B0D0A202020636F6C6F723A20233030613437373B0D0A7D0D0A0D0A2E747970207B0D0A202020636F6C6F723A2023';
wwv_flow_imp.g_varchar2_table(11) := '3130343062303B0D0A7D0D0A0D0A2E657863207B0D0A202020636F6C6F723A20236130343B0D0A7D0D0A0D0A2E61746E2C2E6465632C2E766172207B0D0A202020636F6C6F723A236134613B0D0A7D';
wwv_flow_imp_shared.create_app_static_file(
 p_id=>wwv_flow_imp.id(1242207351907871)
,p_file_name=>'prettify.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content => wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/