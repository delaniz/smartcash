prompt --application/pages/page_00008
begin
wwv_flow_imp_page.create_page(
 p_id=>8
,p_user_interface_id=>wwv_flow_imp.id(37627114721722786135)
,p_name=>'Daily Report'
,p_step_title=>'Daily Report'
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
'}'))
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
''))
,p_page_template_options=>'#DEFAULT#'
,p_page_component_map=>'18'
,p_last_updated_by=>'MACDENIZ'
,p_last_upd_yyyymmddhh24miss=>'20220612172231'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(644273400518323)
,p_plug_name=>'Reports'
,p_region_template_options=>'#DEFAULT#:js-useLocalStorage:t-TabsRegion-mod--fillLabels:t-TabsRegion-mod--pill:t-TabsRegion-mod--large:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_imp.id(37627040811116786079)
,p_plug_display_sequence=>10
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(645576608518336)
,p_plug_name=>'Sales Pro MwSt.'
,p_parent_plug_id=>wwv_flow_imp.id(644273400518323)
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
'where trunc(inv.created) = :P8_REPORT_DAY',
'order by a.id;'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P8_REPORT_DAY'
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
 p_id=>wwv_flow_imp.id(645250735518333)
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
,p_internal_uid=>8734595846145624
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(645168833518332)
,p_db_column_name=>'ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(645125936518331)
,p_db_column_name=>'ARTICLE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Article'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(645030668518330)
,p_db_column_name=>'QUANTITY'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Quantity'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(644885325518329)
,p_db_column_name=>'DISCOUNT'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Discount'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(644785042518328)
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
 p_id=>wwv_flow_imp.id(644702871518327)
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
 p_id=>wwv_flow_imp.id(644618107518326)
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
 p_id=>wwv_flow_imp.id(644482090518325)
,p_db_column_name=>'PAYMENT'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Payment'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(644378574518324)
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
 p_id=>wwv_flow_imp.id(546753386747907)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_type=>'GROUP_BY'
,p_report_alias=>'88331'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'ID:ARTICLE:QUANTITY:DISCOUNT:TOTAL:TAX:UNIT_PRICE:PAYMENT:CREATED'
);
wwv_flow_imp_page.create_worksheet_group_by(
 p_id=>wwv_flow_imp.id(545309435732032)
,p_report_id=>wwv_flow_imp.id(546753386747907)
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
 p_id=>wwv_flow_imp.id(644141909518321)
,p_plug_name=>'Sales Pro Category'
,p_parent_plug_id=>wwv_flow_imp.id(644273400518323)
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
'where trunc(inv.created) = :P8_REPORT_DAY',
'order by a.id;'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P8_REPORT_DAY'
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
 p_id=>wwv_flow_imp.id(643978700518320)
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
,p_internal_uid=>8735867881145637
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(643891148518319)
,p_db_column_name=>'ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(643834344518318)
,p_db_column_name=>'ARTICLE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Article'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(643722454518317)
,p_db_column_name=>'QUANTITY'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Quantity'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(643599883518316)
,p_db_column_name=>'DISCOUNT'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Discount'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(643463697518315)
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
 p_id=>wwv_flow_imp.id(643404720518314)
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
 p_id=>wwv_flow_imp.id(643315849518313)
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
 p_id=>wwv_flow_imp.id(643184264518312)
,p_db_column_name=>'PAYMENT'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Payment'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(643104337518311)
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
 p_id=>wwv_flow_imp.id(643024006518310)
,p_db_column_name=>'PRODUCTCATEGORY'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Productcategory'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(533556991540218)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_type=>'GROUP_BY'
,p_report_alias=>'88463'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'ID:ARTICLE:QUANTITY:DISCOUNT:TOTAL:TAX:UNIT_PRICE:PAYMENT:CREATED:PRODUCTCATEGORY'
);
wwv_flow_imp_page.create_worksheet_group_by(
 p_id=>wwv_flow_imp.id(532653767529539)
,p_report_id=>wwv_flow_imp.id(533556991540218)
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
 p_id=>wwv_flow_imp.id(642886407518309)
,p_plug_name=>'Sales Pro Payment'
,p_parent_plug_id=>wwv_flow_imp.id(644273400518323)
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
'where trunc(inv.created) = :P8_REPORT_DAY',
'order by a.id;'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P8_REPORT_DAY'
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
 p_id=>wwv_flow_imp.id(642835043518308)
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
,p_internal_uid=>8737011538145649
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(642722888518307)
,p_db_column_name=>'ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(531667198518356)
,p_db_column_name=>'ARTICLE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Article'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(531581538518355)
,p_db_column_name=>'QUANTITY'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Quantity'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(531528770518354)
,p_db_column_name=>'DISCOUNT'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Discount'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(531365677518353)
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
 p_id=>wwv_flow_imp.id(531274022518352)
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
 p_id=>wwv_flow_imp.id(531180809518351)
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
 p_id=>wwv_flow_imp.id(531078204518350)
,p_db_column_name=>'PAYMENT'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Payment'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(531008776518349)
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
 p_id=>wwv_flow_imp.id(523544695517003)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'88564'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'ID:ARTICLE:QUANTITY:DISCOUNT:TOTAL:TAX:UNIT_PRICE:PAYMENT:CREATED'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(1959773206290467858)
,p_plug_name=>'Sales Pro Product'
,p_parent_plug_id=>wwv_flow_imp.id(644273400518323)
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
'where trunc(inv.created) = :P8_REPORT_DAY',
'order by a.id;'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P8_REPORT_DAY'
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
 p_id=>wwv_flow_imp.id(647450112518355)
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
,p_internal_uid=>8732396469145602
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(647427871518354)
,p_db_column_name=>'ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Id'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(647280291518353)
,p_db_column_name=>'ARTICLE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Article'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(646986211518350)
,p_db_column_name=>'QUANTITY'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Quantity'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(646859085518349)
,p_db_column_name=>'DISCOUNT'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Discount'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(646208829518342)
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
 p_id=>wwv_flow_imp.id(646073674518341)
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
 p_id=>wwv_flow_imp.id(646006425518340)
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
 p_id=>wwv_flow_imp.id(645903719518339)
,p_db_column_name=>'PAYMENT'
,p_display_order=>100
,p_column_identifier=>'K'
,p_column_label=>'Payment'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(645842303518338)
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
 p_id=>wwv_flow_imp.id(644178706518322)
,p_db_column_name=>'PRODUCTCATEGORY'
,p_display_order=>120
,p_column_identifier=>'M'
,p_column_label=>'Productcategory'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(628645848936246)
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
 p_id=>wwv_flow_imp.id(532114868526747)
,p_report_id=>wwv_flow_imp.id(628645848936246)
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
 p_id=>wwv_flow_imp.id(71740920223578443162)
,p_plug_name=>'Daily Report'
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
 p_id=>wwv_flow_imp.id(646448373518345)
,p_name=>'P8_TODAY'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(71740920223578443162)
,p_item_default=>'sysdate'
,p_item_default_type=>'EXPRESSION'
,p_item_default_language=>'PLSQL'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1959774575886467871)
,p_name=>'P8_CS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(71740920223578443162)
,p_source=>'apex_util.prepare_url('''',p_checksum_type => ''SESSION'')'
,p_source_type=>'EXPRESSION'
,p_source_language=>'PLSQL'
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(6825275339244012649)
,p_name=>'P8_REPORT_DAY'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(71740920223578443162)
,p_prompt=>'Report Day'
,p_placeholder=>'Report Day'
,p_source=>'sysdate'
,p_source_type=>'EXPRESSION'
,p_source_language=>'PLSQL'
,p_display_as=>'NATIVE_DATE_PICKER_JET'
,p_tag_attributes=>'style=''line-height:3'''
,p_field_template=>wwv_flow_imp.id(37627089615814786115)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--large:margin-top-none:margin-bottom-none:margin-left-none:margin-right-none:t-Form-fieldContainer--radioButtonGroup'
,p_warn_on_unsaved_changes=>'I'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'POPUP'
,p_attribute_03=>'NONE'
,p_attribute_06=>'ITEM'
,p_attribute_08=>'P8_TODAY'
,p_attribute_09=>'N'
,p_attribute_11=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(2025061477338958492)
,p_name=>'update IG for Image Upload'
,p_event_sequence=>10
,p_bind_type=>'live'
,p_bind_delegate_to_selector=>'#bill_report'
,p_bind_event_type=>'ready'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(2025061929600958493)
,p_event_id=>wwv_flow_imp.id(2025061477338958492)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
' $("img").css("width","150px");',
'   $("img").addClass(''tooltipImg'');',
'//CREATE A FAKE UPLOAD FIELD for every ROW',
'',
'/*var widget      = apex.region(''bill_overview'').widget();',
'var grid        = widget.interactiveGrid(''getViews'',''grid'');  ',
'var model       = grid.model; ',
'',
'grid.view$.grid("setColumnWidth", "BLOB_ID", 0); //MAKE BLOB_ID INVISIBLE;',
'',
'$("#hiddenForm").hide();',
'model.forEach(function(r) {',
'    var record = r;',
'    var bid= model.getValue(record,''BID'');',
'   $(''#main'').append(''<input style="display:none" attr="''+bid+''" type="file" id="P8_IMG''+bid+''" name="P2_IMG''+bid+''" onChange=if(this.files.length==1){updateImage(''+bid+'',false);} />'');',
'})',
'',
'//CREATE TOOLTIP DIVS for BILL IMAGES',
'*/',
'',
'var changeTooltipPosition = function(event) {',
'	  var tooltipX = event.pageX - 8;',
'	  var tooltipY = event.pageY + 8;',
'	  $(''div.tooltip'').css({top: tooltipY, left: tooltipX});',
'	};',
'',
'	var showTooltip = function(event) {',
'	  $(''div.tooltip'').remove();',
'	  $(''<div class="tooltip" ><img src=''+$(this).attr("src")+'' /></div>'')',
'            .appendTo(''body'');',
'	  changeTooltipPosition(event);',
'	};',
'',
'	var hideTooltip = function() {',
'	   $(''div.tooltip'').remove();',
'	};',
'',
'	$(".tooltipImg").bind({',
'	   mousemove : changeTooltipPosition,',
'	   mouseenter : showTooltip,',
'	   mouseleave: hideTooltip',
'	});',
'',
'//move report_day to the right top',
'$(".t-HeroRegion-form").parent().append($("#P8_REPORT_DAY"));',
''))
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(645716475518337)
,p_event_id=>wwv_flow_imp.id(2025061477338958492)
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
 p_id=>wwv_flow_imp.id(2025062357384958493)
,p_name=>'performSearch'
,p_event_sequence=>100
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P8_SEARCH'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'this.browserEvent.which === apex.jQuery.ui.keyCode.ENTER'
,p_bind_type=>'bind'
,p_bind_event_type=>'keypress'
);
end;
/
begin
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(2025063382805958494)
,p_event_id=>wwv_flow_imp.id(2025062357384958493)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CANCEL_EVENT'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(2025064614543958495)
,p_name=>'select bill'
,p_event_sequence=>110
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'#bill_overview a'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(2025065169624958495)
,p_event_id=>wwv_flow_imp.id(2025064614543958495)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P8_BID'
,p_attribute_01=>'JAVASCRIPT_EXPRESSION'
,p_attribute_05=>'this.triggeringElement.id'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(646440653518344)
,p_name=>'DA_REFRESH_DAILY_REPORT'
,p_event_sequence=>120
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P8_REPORT_DAY'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(646266316518343)
,p_event_id=>wwv_flow_imp.id(646440653518344)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(1959773206290467858)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(214784145543623)
,p_event_id=>wwv_flow_imp.id(646440653518344)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(644141909518321)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(214657123543622)
,p_event_id=>wwv_flow_imp.id(646440653518344)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(645576608518336)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(214573763543621)
,p_event_id=>wwv_flow_imp.id(646440653518344)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(642886407518309)
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(2025061030051958491)
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
