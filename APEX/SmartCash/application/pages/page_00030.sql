prompt --application/pages/page_00030
begin
wwv_flow_imp_page.create_page(
 p_id=>30
,p_user_interface_id=>wwv_flow_imp.id(37627114721722786135)
,p_name=>'Data Collection Protocoll'
,p_alias=>'DATENERFASSUNGSPROTOKOLL'
,p_step_title=>'Data Collection Protocoll'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'18'
,p_last_updated_by=>'MACDENIZ'
,p_last_upd_yyyymmddhh24miss=>'20220706064928'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(471718644695106)
,p_plug_name=>'Data Collection Protocoll'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_plug_template=>wwv_flow_imp.id(37627032830742786074)
,p_plug_display_sequence=>20
,p_query_type=>'TABLE'
,p_query_table=>'SC_DEP'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Data Collection Protocoll'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#EEEEEE'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'bold'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#FFFFFF'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_prn_border_color=>'#666666'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(471552530695106)
,p_name=>'Datenerfassungsprotokoll'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_base_pk1=>'ID'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_download_filename=>'dep_7'
,p_enable_mail_download=>'Y'
,p_detail_link_text=>'<img src="#APEX_FILES#app_ui/img/icons/apex-edit-pencil.png" class="apex-edit-pencil" alt="">'
,p_allow_exclude_null_values=>'N'
,p_allow_hide_extra_columns=>'N'
,p_owner=>'MACDENIZ'
,p_internal_uid=>8908294050968851
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(471230797695104)
,p_db_column_name=>'ID'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'Id'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(60685187995131)
,p_db_column_name=>'COMPANY_ID'
,p_display_order=>11
,p_column_identifier=>'Q'
,p_column_label=>'Company Id'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(60607765995130)
,p_db_column_name=>'NAME'
,p_display_order=>21
,p_column_identifier=>'R'
,p_column_label=>'Name'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(60514407995129)
,p_db_column_name=>'DESCRIPTION'
,p_display_order=>31
,p_column_identifier=>'S'
,p_column_label=>'Description'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(60382617995128)
,p_db_column_name=>'SUBJECT'
,p_display_order=>41
,p_column_identifier=>'T'
,p_column_label=>'Subject'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(60272333995127)
,p_db_column_name=>'OLDVALUE'
,p_display_order=>51
,p_column_identifier=>'U'
,p_column_label=>'Oldvalue'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(60164344995126)
,p_db_column_name=>'NEWVALUE'
,p_display_order=>61
,p_column_identifier=>'V'
,p_column_label=>'Newvalue'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(60102263995125)
,p_db_column_name=>'PROGRAMMVERSION'
,p_display_order=>71
,p_column_identifier=>'W'
,p_column_label=>'Programmversion'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(59969283995124)
,p_db_column_name=>'CASHREGISTER_ID'
,p_display_order=>81
,p_column_identifier=>'X'
,p_column_label=>'Cashregister Id'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(59905386995123)
,p_db_column_name=>'FL_DEMO'
,p_display_order=>91
,p_column_identifier=>'Y'
,p_column_label=>'Fl Demo'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(59750991995122)
,p_db_column_name=>'AMOUNT'
,p_display_order=>101
,p_column_identifier=>'Z'
,p_column_label=>'Amount'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(59690890995121)
,p_db_column_name=>'AMOUNT_GROSS'
,p_display_order=>111
,p_column_identifier=>'AA'
,p_column_label=>'Amount Gross'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'FML&CURRENCYFORMAT.'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(59625720995120)
,p_db_column_name=>'AMOUNT_NET'
,p_display_order=>121
,p_column_identifier=>'AB'
,p_column_label=>'Amount Net'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'&CURRENCYFORMAT.'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(59472195995119)
,p_db_column_name=>'AMOUNT_TAX'
,p_display_order=>131
,p_column_identifier=>'AC'
,p_column_label=>'Amount Tax'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>unistr('\20AC &CURRENCYFORMAT.')
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(59444915995118)
,p_db_column_name=>'ISSUE'
,p_display_order=>141
,p_column_identifier=>'AD'
,p_column_label=>'Issue'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(59316677995117)
,p_db_column_name=>'CREATED'
,p_display_order=>151
,p_column_identifier=>'AE'
,p_column_label=>'Created'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(59197907995116)
,p_db_column_name=>'UPDATED'
,p_display_order=>161
,p_column_identifier=>'AF'
,p_column_label=>'Updated'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(59047427995115)
,p_db_column_name=>'MODUSER'
,p_display_order=>171
,p_column_identifier=>'AG'
,p_column_label=>'Moduser'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(464821196694503)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'89151'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'NAME:DESCRIPTION:SUBJECT:OLDVALUE:NEWVALUE:AMOUNT_GROSS:CREATED:'
,p_sort_column_1=>'ID'
,p_sort_direction_1=>'DESC NULLS LAST'
,p_sort_column_2=>'0'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'0'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'0'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(1181837958520469)
,p_plug_name=>'Info'
,p_icon_css_classes=>'fa-info-circle-o'
,p_region_template_options=>'#DEFAULT#:t-Region--showIcon:t-Region--textContent:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(37627033949633786074)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_source=>unistr('Das vollst\00E4ndige DEP-7 ist zumindest viertelj\00E4hrlich auf einem elektronischen, externen Medium unver\00E4nderbar zu sichern. Als geeignete Medien gelten beispielsweise schreibgesch\00FCtzte (abgeschlossene) externe Festplatten, USB-Sticks und Speicher extern')
||unistr('er Server, die vor unberechtigten Datenzugriffen gesch\00FCtzt sind. Die Unver\00E4nderbarkeit des Inhaltes der Daten ist durch die Signatur bzw. das Siegel und insbesondere durch die signierten Monatsbelege gegeben. Jede Sicherung ist gem\00E4\00DF \00A7 132 BAO aufzub')
||'ewahren.'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
end;
/