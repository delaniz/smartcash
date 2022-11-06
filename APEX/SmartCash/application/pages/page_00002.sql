prompt --application/pages/page_00002
begin
wwv_flow_imp_page.create_page(
 p_id=>2
,p_user_interface_id=>wwv_flow_imp.id(37627114721722786135)
,p_name=>'Product Category'
,p_alias=>'PRODUCTCATEGORY'
,p_step_title=>'Product Category'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code_onload=>'$("#PopupLov_19_P19_BUTTON_COLOR_dlg li").each(function(){$(this).addClass(''color-cell-block u-''+$(this).html())});'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'18'
,p_last_updated_by=>'MACDENIZ'
,p_last_upd_yyyymmddhh24miss=>'20220525113513'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(1085584065590444)
,p_plug_name=>'Report 1'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(37627032830742786074)
,p_plug_display_sequence=>10
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select c.ID,',
'       c.NAME,',
'       p.name as printer_name,',
'       c.BUTTON_COLOR,',
'       c.CREATED,',
'       c.UPDATED',
'  from SC_CATEGORY c',
'  LEFT JOIN sc_printer p on p.id = c.printer_id'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_page_header=>'Report 1'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(1085216395590444)
,p_name=>'Report 1'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:19:&SESSION.::&DEBUG.:RP:P19_ID:\#ID#\'
,p_detail_link_text=>'<span aria-label="Edit"><span class="fa fa-edit" aria-hidden="true" title="Edit"></span></span>'
,p_owner=>'MACDENIZ'
,p_internal_uid=>8294630186073513
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(1085100299590441)
,p_db_column_name=>'ID'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(1084734212590439)
,p_db_column_name=>'NAME'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(1346705549188519)
,p_db_column_name=>'PRINTER_NAME'
,p_display_order=>12
,p_column_identifier=>'G'
,p_column_label=>'Printer Name'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(1083868225590438)
,p_db_column_name=>'BUTTON_COLOR'
,p_display_order=>22
,p_column_identifier=>'D'
,p_column_label=>'Button Color'
,p_column_html_expression=>'<div style=''text-align:center;width:100%;height:100%;line-height:2;'' class=''color-cell-block color-background u-color-#BUTTON_COLOR#'' >color-#BUTTON_COLOR#</div>'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(1083537562590437)
,p_db_column_name=>'CREATED'
,p_display_order=>32
,p_column_identifier=>'E'
,p_column_label=>'Created'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_format_mask=>'&DATEFORMAT.'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(1083144244590437)
,p_db_column_name=>'UPDATED'
,p_display_order=>42
,p_column_identifier=>'F'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_format_mask=>'&DATEFORMAT.'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(1080303590589934)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'82996'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'NAME:PRINTER_NAME:BUTTON_COLOR:CREATED:UPDATED:'
,p_sort_column_1=>'NAME'
,p_sort_direction_1=>'ASC'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(37336757635240571238)
,p_plug_name=>'Product Category'
,p_region_template_options=>'#DEFAULT#:t-HeroRegion--hideIcon'
,p_plug_template=>wwv_flow_imp.id(37627026450443786069)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_08'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(1080664650590426)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(1085584065590444)
,p_button_name=>'CREATE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(37627090985680786117)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:19:&SESSION.::&DEBUG.:19'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(1081676142590428)
,p_name=>'Edit Report - Dialog Closed'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(1085584065590444)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1081201065590426)
,p_event_id=>wwv_flow_imp.id(1081676142590428)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(1085584065590444)
);
end;
/
