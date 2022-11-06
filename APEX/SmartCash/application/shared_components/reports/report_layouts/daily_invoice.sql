prompt --application/shared_components/reports/report_layouts/daily_invoice
begin
    wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
    wwv_flow_imp.g_varchar2_table(1) := '<?xml version="1.0" encoding="UTF-8"?>'||wwv_flow.LF||
'<DOCUMENT>'||wwv_flow.LF||
'<ROWSET>'||wwv_flow.LF||
'   <ROW>'||wwv_flow.LF||
'      <AID></AID>'||wwv_flow.LF||
'      <ARTICLE';
    wwv_flow_imp.g_varchar2_table(2) := '></ARTICLE>'||wwv_flow.LF||
'      <TAX></TAX>'||wwv_flow.LF||
'      <UNIT_PRICE></UNIT_PRICE>'||wwv_flow.LF||
'      <QUANTITY></QUANTITY>'||wwv_flow.LF||
'      <DIS';
    wwv_flow_imp.g_varchar2_table(3) := 'COUNT></DISCOUNT>'||wwv_flow.LF||
'      <TOTAL></TOTAL>'||wwv_flow.LF||
'   </ROW>'||wwv_flow.LF||
'</ROWSET>'||wwv_flow.LF||
'</DOCUMENT>'||wwv_flow.LF||
'';
wwv_flow_imp_shared.create_report_layout(
 p_id=>wwv_flow_imp.id(10871975415812190648)
,p_report_layout_name=>'daily_invoice'
,p_report_layout_type=>'RTF_FILE'
,p_varchar2_table=>wwv_flow_imp.g_varchar2_table
);
end;
/
