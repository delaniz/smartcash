prompt --application/pages/page_00010
begin
wwv_flow_imp_page.create_page(
 p_id=>10
,p_user_interface_id=>wwv_flow_imp.id(37627114721722786135)
,p_name=>'Montly Report'
,p_alias=>'MONTLY-REPORT'
,p_step_title=>'Montly Report'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$("#subtotal-val").html($("#total").html());',
'$("#discount-val").html($("#discount").html());',
'$("#total-val").html((parseFloat($("#total").html())-parseFloat($("#discount").html())).toFixed(2));',
'',
'function printIt(id,salary_day){',
'    $("body").children().hide();',
'    $("body").append($("#report_"+id).clone()); //.show();',
'    $("#report_1>div").removeClass("is-collapsed").addClass("is-expanded"); ',
'    $("#report_1 .a-Collapsible-content").show();',
'    window.print();',
'    $("body").children().show();',
'}',
'',
'$(document).on(".oj-enabled[data-handler=''selectMonth'']",''click'',function(){',
'        console.log(''month clicked'');',
'        $s("P10_REPORT_MONTH",$(this).attr(''data-month'')+"."+$(this).attr(''data-year''));',
'        $(".oj-datepicker-wrapper").hide();',
'});'))
,p_javascript_code_onload=>'/*(function(){apex.widget.report.init("348594841828557733071","B7OOO4-gyy34JIt8h4spKcVzD56pBUow6KH5o8I8vzT-UT7siI0Qaj5-XltTVfvz",{"styleChecked":"#dddddd","internalRegionId":"1961177187002930531"});})();*/'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
' .a-GV-cell {',
'  height: 87px;',
'}',
'.tooltip {',
'    margin:4px;',
'    padding:4px;',
'    border:1px solid #666;',
'    background-color:#666;',
'    position: absolute;',
'    z-index: 99999;',
'    max-width:800px;',
'}',
'.tooltip img{',
'   max-width:780px;',
'}',
'',
''))
,p_page_template_options=>'#DEFAULT#'
,p_page_component_map=>'18'
,p_last_updated_by=>'MACDENIZ'
,p_last_upd_yyyymmddhh24miss=>'20220612172522'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(8218679642658087)
,p_plug_name=>'Reports'
,p_region_template_options=>'#DEFAULT#:js-useLocalStorage:t-TabsRegion-mod--fillLabels:t-TabsRegion-mod--pill:t-TabsRegion-mod--large:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_imp.id(37627040811116786079)
,p_plug_display_sequence=>10
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(8217376434658074)
,p_plug_name=>'Sales Pro MwSt.'
,p_parent_plug_id=>wwv_flow_imp.id(8218679642658087)
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(37627032830742786074)
,p_plug_display_sequence=>40
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a.id',
'    , a.name article',
'    ,percent tax',
'    ,a.price unit_price',
'    ,invitem.quantity',
'    ,invitem.discount',
'    ,a.price*invitem.quantity total',
'    ,p.name payment',
'    ,invitem.created',
'from sc_invoice inv ',
'right join sc_invoiceitem invitem on inv.id = invitem.invoice_id',
'left join sc_article a on a.id= invitem.article_id ',
'left join sc_tax t on t.id = a.tax_id ',
'left join sc_payment p on p.id = inv.payment_id',
'where  to_char(inv.created,''MM.YYYY'') = :P10_REPORT_MONTH ',
'order by a.id;'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P10_REPORT_MONTH'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>297
,p_prn_height=>210
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Sales Pro MwSt.'
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
 p_id=>wwv_flow_imp.id(8217702307658077)
,p_max_row_count=>'1000000'
,p_allow_save_rpt_public=>'Y'
,p_save_rpt_public_auth_scheme=>wwv_flow_imp.id(37627119141403786144)
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_view_enabled_yn=>'Y'
,p_owner=>'MACDENIZ'
,p_internal_uid=>17597548889322034
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(509140336487514)
,p_db_column_name=>'ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(508665470487513)
,p_db_column_name=>'ARTICLE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Article'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(508257861487513)
,p_db_column_name=>'QUANTITY'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Quantity'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(507937665487512)
,p_db_column_name=>'DISCOUNT'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Discount'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(507508296487512)
,p_db_column_name=>'TOTAL'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Total'
,p_column_html_expression=>unistr('\20AC #TOTAL#')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'&CURRENCYFORMAT.'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(507118193487511)
,p_db_column_name=>'TAX'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Tax'
,p_column_html_expression=>'#TAX# %'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(506734838487511)
,p_db_column_name=>'UNIT_PRICE'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Unit Price'
,p_column_html_expression=>unistr('\20AC #UNIT_PRICE#')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'&CURRENCYFORMAT.'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(506291548487510)
,p_db_column_name=>'PAYMENT'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Payment'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(505942765487510)
,p_db_column_name=>'CREATED'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Created'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_format_mask=>'&DATEFORMAT.'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(8316199656428503)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_type=>'GROUP_BY'
,p_report_alias=>'88331'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'ID:ARTICLE:QUANTITY:DISCOUNT:TOTAL:TAX:UNIT_PRICE:PAYMENT:CREATED'
);
wwv_flow_imp_page.create_worksheet_group_by(
 p_id=>wwv_flow_imp.id(505221105487509)
,p_report_id=>wwv_flow_imp.id(8316199656428503)
,p_group_by_columns=>'TAX'
,p_function_01=>'COUNT'
,p_function_column_01=>'QUANTITY'
,p_function_db_column_name_01=>'APXWS_GBFC_01'
,p_function_label_01=>'Quantity'
,p_function_format_mask_01=>'999G999G999G999G990'
,p_function_sum_01=>'Y'
,p_function_02=>'SUM'
,p_function_column_02=>'TOTAL'
,p_function_db_column_name_02=>'APXWS_GBFC_02'
,p_function_label_02=>'Total'
,p_function_format_mask_02=>'999G999G999G999G990'
,p_function_sum_02=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(8218811133658089)
,p_plug_name=>'Sales Pro Category'
,p_parent_plug_id=>wwv_flow_imp.id(8218679642658087)
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(37627032830742786074)
,p_plug_display_sequence=>30
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a.id',
'    , a.name article',
'    ,percent tax',
'    ,a.price unit_price',
'    ,invitem.quantity',
'    ,invitem.discount',
'    ,a.price*invitem.quantity total',
'    ,p.name payment',
'    ,invitem.created',
'    ,c.name as productcategory',
'from sc_invoice inv ',
'right join sc_invoiceitem invitem on inv.id = invitem.invoice_id',
'left join sc_article a on a.id= invitem.article_id ',
'left join sc_tax t on t.id = a.tax_id ',
'left join sc_category c on c.id = a.category_id',
'left join sc_payment p on p.id = inv.payment_id',
'where  to_char(inv.created,''MM.YYYY'') = :P10_REPORT_MONTH ',
'order by a.id;'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P10_REPORT_MONTH'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>297
,p_prn_height=>210
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Sales Pro Category'
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
 p_id=>wwv_flow_imp.id(8218974342658090)
,p_max_row_count=>'1000000'
,p_allow_save_rpt_public=>'Y'
,p_save_rpt_public_auth_scheme=>wwv_flow_imp.id(37627119141403786144)
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_view_enabled_yn=>'Y'
,p_owner=>'MACDENIZ'
,p_internal_uid=>17598820924322047
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(500261101487501)
,p_db_column_name=>'ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(499858680487500)
,p_db_column_name=>'ARTICLE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Article'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(499516585487497)
,p_db_column_name=>'QUANTITY'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Quantity'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(499133675487497)
,p_db_column_name=>'DISCOUNT'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Discount'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(498651254487496)
,p_db_column_name=>'TOTAL'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Total'
,p_column_html_expression=>unistr('\20AC #TOTAL#')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'&CURRENCYFORMAT.'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(498290589487496)
,p_db_column_name=>'TAX'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Tax'
,p_column_html_expression=>'#TAX# %'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(497869456487495)
,p_db_column_name=>'UNIT_PRICE'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Unit Price'
,p_column_html_expression=>unistr('\20AC #UNIT_PRICE#')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'&CURRENCYFORMAT.'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(497539247487495)
,p_db_column_name=>'PAYMENT'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Payment'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(497091877487494)
,p_db_column_name=>'CREATED'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Created'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_format_mask=>'&DATEFORMAT.'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(496661625487494)
,p_db_column_name=>'PRODUCTCATEGORY'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Productcategory'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(8329396051636192)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_type=>'GROUP_BY'
,p_report_alias=>'88463'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'ID:ARTICLE:QUANTITY:DISCOUNT:TOTAL:TAX:UNIT_PRICE:PAYMENT:CREATED:PRODUCTCATEGORY'
);
wwv_flow_imp_page.create_worksheet_group_by(
 p_id=>wwv_flow_imp.id(496094845487493)
,p_report_id=>wwv_flow_imp.id(8329396051636192)
,p_group_by_columns=>'PRODUCTCATEGORY:TAX'
,p_function_01=>'COUNT'
,p_function_column_01=>'QUANTITY'
,p_function_db_column_name_01=>'APXWS_GBFC_01'
,p_function_label_01=>'Quantity'
,p_function_format_mask_01=>'999G999G999G999G990'
,p_function_sum_01=>'Y'
,p_function_02=>'SUM'
,p_function_column_02=>'TOTAL'
,p_function_db_column_name_02=>'APXWS_GBFC_02'
,p_function_label_02=>'Total'
,p_function_format_mask_02=>'FML999G999G999G999G990D00'
,p_function_sum_02=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(8220066635658101)
,p_plug_name=>'Sales Pro Payment'
,p_parent_plug_id=>wwv_flow_imp.id(8218679642658087)
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(37627032830742786074)
,p_plug_display_sequence=>50
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a.id',
'    , a.name article',
'    ,percent tax',
'    ,a.price unit_price',
'    ,invitem.quantity',
'    ,invitem.discount',
'    ,a.price*invitem.quantity total',
'    ,p.name payment',
'    ,invitem.created',
'from sc_invoice inv ',
'right join sc_invoiceitem invitem on inv.id = invitem.invoice_id',
'left join sc_article a on a.id= invitem.article_id ',
'left join sc_tax t on t.id = a.tax_id ',
'left join sc_payment p on p.id = inv.payment_id',
'where  to_char(inv.created,''MM.YYYY'') = :P10_REPORT_MONTH ',
'order by a.id;'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P10_REPORT_MONTH'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>297
,p_prn_height=>210
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Sales Pro Payment'
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
 p_id=>wwv_flow_imp.id(8220117999658102)
,p_max_row_count=>'1000000'
,p_allow_save_rpt_public=>'Y'
,p_save_rpt_public_auth_scheme=>wwv_flow_imp.id(37627119141403786144)
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_view_enabled_yn=>'Y'
,p_owner=>'MACDENIZ'
,p_internal_uid=>17599964581322059
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(504484431487507)
,p_db_column_name=>'ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(504102259487507)
,p_db_column_name=>'ARTICLE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Article'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(503741467487506)
,p_db_column_name=>'QUANTITY'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Quantity'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(503345904487506)
,p_db_column_name=>'DISCOUNT'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Discount'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(502921300487505)
,p_db_column_name=>'TOTAL'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Total'
,p_column_html_expression=>unistr('\20AC #TOTAL#')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'&CURRENCYFORMAT.'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(502492727487505)
,p_db_column_name=>'TAX'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Tax'
,p_column_html_expression=>'#TAX# %'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(502114695487504)
,p_db_column_name=>'UNIT_PRICE'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Unit Price'
,p_column_html_expression=>unistr('\20AC #UNIT_PRICE#')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'&CURRENCYFORMAT.'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(501696066487504)
,p_db_column_name=>'PAYMENT'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Payment'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(501307973487503)
,p_db_column_name=>'CREATED'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Created'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_format_mask=>'&DATEFORMAT.'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(8339408347659407)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_type=>'GROUP_BY'
,p_report_alias=>'88564'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'ID:ARTICLE:QUANTITY:DISCOUNT:TOTAL:TAX:UNIT_PRICE:PAYMENT:CREATED'
);
wwv_flow_imp_page.create_worksheet_group_by(
 p_id=>wwv_flow_imp.id(482352846417411)
,p_report_id=>wwv_flow_imp.id(8339408347659407)
,p_group_by_columns=>'PAYMENT'
,p_function_01=>'COUNT'
,p_function_column_01=>'QUANTITY'
,p_function_db_column_name_01=>'APXWS_GBFC_01'
,p_function_label_01=>'Quantity'
,p_function_format_mask_01=>'999G999G999G999G990'
,p_function_sum_01=>'Y'
,p_function_02=>'SUM'
,p_function_column_02=>'TOTAL'
,p_function_db_column_name_02=>'APXWS_GBFC_02'
,p_function_label_02=>'Total'
,p_function_format_mask_02=>'FML999G999G999G999G990D00'
,p_function_sum_02=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(1968636159333644268)
,p_plug_name=>'Sales Pro Product'
,p_parent_plug_id=>wwv_flow_imp.id(8218679642658087)
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders:js-showMaximizeButton'
,p_plug_template=>wwv_flow_imp.id(37627032830742786074)
,p_plug_display_sequence=>20
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a.id',
'    , a.name article',
'    ,percent tax',
'    ,a.price unit_price',
'    ,invitem.quantity',
'    ,invitem.discount',
'    ,a.price*invitem.quantity total',
'    ,p.name payment',
'    ,invitem.created',
'    ,c.name as productcategory',
'from sc_invoice inv ',
'right join sc_invoiceitem invitem on inv.id = invitem.invoice_id',
'left join sc_article a on a.id= invitem.article_id ',
'left join sc_tax t on t.id = a.tax_id ',
'left join sc_category c on c.id = a.category_id',
'left join sc_payment p on p.id = inv.payment_id',
'where  to_char(inv.created,''MM.YYYY'') = :P10_REPORT_MONTH ',
'order by a.id;'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P10_REPORT_MONTH'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>297
,p_prn_height=>210
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Sales Pro Product'
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
 p_id=>wwv_flow_imp.id(8215502930658055)
,p_max_row_count=>'1000000'
,p_allow_save_rpt_public=>'Y'
,p_save_rpt_public_auth_scheme=>wwv_flow_imp.id(37627119141403786144)
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_view_enabled_yn=>'Y'
,p_owner=>'MACDENIZ'
,p_internal_uid=>17595349512322012
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(514049379487527)
,p_db_column_name=>'ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(513697368487525)
,p_db_column_name=>'ARTICLE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Article'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(513343175487524)
,p_db_column_name=>'QUANTITY'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Quantity'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(512939726487524)
,p_db_column_name=>'DISCOUNT'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Discount'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(512520175487523)
,p_db_column_name=>'TOTAL'
,p_display_order=>70
,p_column_identifier=>'H'
,p_column_label=>'Total'
,p_column_html_expression=>unistr('\20AC #TOTAL#')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'&CURRENCYFORMAT.'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(512114539487523)
,p_db_column_name=>'TAX'
,p_display_order=>80
,p_column_identifier=>'I'
,p_column_label=>'Tax'
,p_column_html_expression=>'#TAX# %'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(511683032487522)
,p_db_column_name=>'UNIT_PRICE'
,p_display_order=>90
,p_column_identifier=>'J'
,p_column_label=>'Unit Price'
,p_column_html_expression=>unistr('\20AC #UNIT_PRICE#')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'&CURRENCYFORMAT.'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(511285916487522)
,p_db_column_name=>'PAYMENT'
,p_display_order=>100
,p_column_identifier=>'K'
,p_column_label=>'Payment'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(510944217487521)
,p_db_column_name=>'CREATED'
,p_display_order=>110
,p_column_identifier=>'L'
,p_column_label=>'Created'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_format_mask=>'&DATEFORMAT.'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(510528421487521)
,p_db_column_name=>'PRODUCTCATEGORY'
,p_display_order=>120
,p_column_identifier=>'M'
,p_column_label=>'Productcategory'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(8234307194240164)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_type=>'GROUP_BY'
,p_report_alias=>'87513'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_view_mode=>'REPORT'
,p_report_columns=>'ARTICLE:DISCOUNT:PAYMENT:QUANTITY:TAX:UNIT_PRICE:TOTAL::CREATED:PRODUCTCATEGORY'
,p_break_on=>'0:0:0:0:0:0'
,p_break_enabled_on=>'0:0:0:0:0:0'
,p_sum_columns_on_break=>'QUANTITY:TOTAL'
);
wwv_flow_imp_page.create_worksheet_group_by(
 p_id=>wwv_flow_imp.id(483120818422167)
,p_report_id=>wwv_flow_imp.id(8234307194240164)
,p_group_by_columns=>'ARTICLE:TAX:UNIT_PRICE'
,p_function_01=>'COUNT'
,p_function_column_01=>'QUANTITY'
,p_function_db_column_name_01=>'APXWS_GBFC_01'
,p_function_label_01=>'Quantity'
,p_function_format_mask_01=>'999G999G999G999G990'
,p_function_sum_01=>'Y'
,p_function_02=>'SUM'
,p_function_column_02=>'TOTAL'
,p_function_db_column_name_02=>'APXWS_GBFC_02'
,p_function_label_02=>'Total'
,p_function_format_mask_02=>'FML999G999G999G999G990D00'
,p_function_sum_02=>'Y'
,p_sort_column_01=>'TAX'
,p_sort_direction_01=>'ASC'
,p_sort_column_02=>'ARTICLE'
,p_sort_direction_02=>'ASC'
,p_sort_column_03=>'PAYMENT'
,p_sort_direction_03=>'ASC'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(71749783176621619572)
,p_plug_name=>'Montly Report'
,p_icon_css_classes=>'fa-table-clock'
,p_region_template_options=>'#DEFAULT#:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_imp.id(37627026450443786069)
,p_plug_display_sequence=>30
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(515898154487536)
,p_name=>'P10_CS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(71749783176621619572)
,p_source=>'apex_util.prepare_url('''',p_checksum_type => ''SESSION'')'
,p_source_type=>'EXPRESSION'
,p_source_language=>'PLSQL'
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(515451493487533)
,p_name=>'P10_ACTUAL_MONTH'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(71749783176621619572)
,p_item_default=>'sysdate'
,p_item_default_type=>'EXPRESSION'
,p_item_default_language=>'PLSQL'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(515074002487532)
,p_name=>'P10_REPORT_MONTH'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(71749783176621619572)
,p_prompt=>'Report Month'
,p_placeholder=>'Report Month'
,p_format_mask=>'MM.YYYY'
,p_source=>'to_char(sysdate,''MM.YYYY'')'
,p_source_type=>'EXPRESSION'
,p_source_language=>'PLSQL'
,p_display_as=>'NATIVE_DATE_PICKER_JET'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(37627089615814786115)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--large:margin-top-none:margin-bottom-none:margin-left-none:margin-right-none:t-Form-fieldContainer--radioButtonGroup'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
,p_attribute_02=>'POPUP'
,p_attribute_03=>'NONE'
,p_attribute_06=>'ITEM'
,p_attribute_08=>'P10_ACTUAL_MONTH'
,p_attribute_09=>'N'
,p_attribute_11=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(494421016487489)
,p_name=>'setting for page load'
,p_event_sequence=>10
,p_bind_type=>'live'
,p_bind_delegate_to_selector=>'#bill_report'
,p_bind_event_type=>'ready'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(493351083487488)
,p_event_id=>wwv_flow_imp.id(494421016487489)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'//move report_day to the right top',
'$(".t-HeroRegion-form").parent().append($("#P10_REPORT_MONTH"));',
''))
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(493940471487488)
,p_event_id=>wwv_flow_imp.id(494421016487489)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
unistr('    execute immediate ''alter session set nls_currency = '''' \20AC'''' '';'),
'end;'))
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(495263118487491)
,p_name=>'DA_REFRESH_DAILY_REPORT'
,p_event_sequence=>120
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P10_REPORT_MONTH'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(494824716487489)
,p_event_id=>wwv_flow_imp.id(495263118487491)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(1968636159333644268)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(214504844543620)
,p_event_id=>wwv_flow_imp.id(495263118487491)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(8218811133658089)
);
end;
/
begin
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(214398149543619)
,p_event_id=>wwv_flow_imp.id(495263118487491)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(8217376434658074)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(214344013543618)
,p_event_id=>wwv_flow_imp.id(495263118487491)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(8220066635658101)
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(495697385487492)
,p_process_sequence=>30
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'UPLOAD_FILE'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_blob blob;',
'  l_filename varchar2(200);',
'  l_mime_type varchar2(200);',
'  l_token varchar2(32000);',
'  l_bid number;',
'  l_insert number;',
'  v_msg varchar2(4000);',
'begin  ',
'  l_filename := apex_application.g_x01;',
'  l_mime_type := nvl(apex_application.g_x02, ''application/octet-stream'');',
'  l_bid := apex_application.g_x03;',
'  l_insert := apex_application.g_x04;',
'  -- build BLOB from f01 30k array (base64 encoded)',
'  dbms_lob.createtemporary(l_blob, false, dbms_lob.session);',
'  for i in 1 .. apex_application.g_f01.count loop',
'    l_token := wwv_flow.g_f01(i);',
'    if length(l_token) > 0 then',
'      dbms_lob.append(',
'        dest_lob => l_blob,',
'        src_lob => to_blob(utl_encode.base64_decode(utl_raw.cast_to_raw(l_token)))',
'      );',
'    end if;',
'  end loop;',
' --print retrieven value',
'  -- update bill or save the blob in temp table (only if BLOB is not null)',
'  if dbms_lob.getlength(l_blob) is not null then',
'    if l_bid != 0 AND l_insert = 0 then',
'        UPDATE bill SET image = l_blob, mimetype = l_mime_type, filename = l_filename WHERE bid = l_bid;',
'    else',
'        INSERT INTO temp_blob(image,mimetype,filename) VALUES(l_blob,l_mime_type,l_filename) RETURNING tid INTO l_bid;',
'    end if;',
'  end if;',
'',
' apex_json.open_object;',
' ',
' apex_json.write(',
'    p_name => ''result'',',
'    p_value => ''success''',
'  );',
' ',
'  if l_insert = 1 then --IF BLOB inserted in a different table',
'     apex_json.write(',
'          p_name => ''blob_id'',',
'          p_value => l_bid);',
'      ',
'   end if;',
'apex_json.close_object;',
'',
'   exception',
'      when others then',
'       apex_json.open_object;',
'        apex_json.write(',
'          p_name => ''result'',',
'          p_value => ''fail''',
'        );',
'        apex_json.close_object;',
'',
'        ',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
