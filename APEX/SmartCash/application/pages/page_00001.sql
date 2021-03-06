prompt --application/pages/page_00001
begin
wwv_flow_imp_page.create_page(
 p_id=>1
,p_user_interface_id=>wwv_flow_imp.id(37628517236709248794)
,p_name=>'Home'
,p_alias=>'HOME'
,p_step_title=>'smartCash'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code_onload=>'$(".t-Cards-item").first().remove();'
,p_page_template_options=>'#DEFAULT#'
,p_page_component_map=>'13'
,p_last_updated_by=>'D.KALDI@ME.COM'
,p_last_upd_yyyymmddhh24miss=>'20191031123732'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(37628531186793248816)
,p_plug_name=>'smartCash'
,p_icon_css_classes=>'app-icon'
,p_region_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_imp.id(37628428965430248728)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_query_num_rows=>15
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(37628543813175248830)
,p_plug_name=>'Page Navigation'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:u-colors:t-Cards--featured t-Cards--block force-fa-lg:t-Cards--displayIcons:t-Cards--3cols:t-Cards--hideBody:t-Cards--animRaiseCard'
,p_plug_template=>wwv_flow_imp.id(37628410661712248714)
,p_plug_display_sequence=>30
,p_list_id=>wwv_flow_imp.id(37628385634853248693)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_imp.id(37628473587188248760)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
end;
/
