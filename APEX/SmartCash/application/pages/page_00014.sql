prompt --application/pages/page_00014
begin
wwv_flow_imp_page.create_page(
 p_id=>14
,p_user_interface_id=>wwv_flow_imp.id(37627114721722786135)
,p_name=>'Invoices'
,p_step_title=>'Invoices'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$("#subtotal-val").html($("#total").html());',
'$("#discount-val").html($("#discount").html());',
'$("#total-val").html((parseFloat($("#total").html())-parseFloat($("#discount").html())).toFixed(2));',
'',
'function customConfirm( pMessage, pCallback, pOkLabel, pCancelLabel ){',
'    var l_original_messages = {"APEX.DIALOG.OK":     apex.lang.getMessage("APEX.DIALOG.OK"),',
'                               "APEX.DIALOG.CANCEL": apex.lang.getMessage("APEX.DIALOG.CANCEL")};',
'',
'    //change the button labels messages',
'    apex.lang.addMessages({"APEX.DIALOG.OK":     pOkLabel});',
'    apex.lang.addMessages({"APEX.DIALOG.CANCEL": pCancelLabel});',
'',
'    //show the confirm dialog',
'    apex.message.confirm(pMessage, pCallback);',
'',
'    //changes the button labels messages back to their original values',
'    apex.lang.addMessages({"APEX.DIALOG.OK":     l_original_messages["APEX.DIALOG.OK"]});',
'    apex.lang.addMessages({"APEX.DIALOG.CANCEL": l_original_messages["APEX.DIALOG.CANCEL"]});',
'}',
'function isValidDate(dateString) {',
'    var regEx = /^\d{2}-\d{2}-\d{4} [0-9]?[0-9]:[0-9][0-9]$/;',
'    if(!dateString.match(regEx)) return false;  // Invalid format',
'    var d = new Date(dateString);',
'    var dNum = d.getTime();',
'    if(!dNum && dNum !== 0) return false; // NaN value, Invalid date',
'    return true; //d.toISOString().slice(0,10) === dateString.slice(0,10);',
'}',
'',
'function checkFilterInputs(){',
'    var err = [];',
'    $(".t-TabsRegion input").each(function(){',
'        if($(this).val()!=""){',
'            $(this).val($(this).val().replace(",","."));',
'            console.log("this -val ->"+$(this).val());',
'            if($(this).attr("id").indexOf("DATE") != -1){',
'                console.log("in date..");',
'                if(!isValidDate($(this).val())){',
'                    err.push({',
'                        type:       "error",',
'                        location:    [ "page", "inline" ],',
'                        pageItem:   $(this).attr("id"),',
'                        message:    "Date is not valid. Example Date: ''DD-MM-YYYY HH:MM => 27-01-2019 13:29''",',
'                        unsafe:     false',
'                    });',
'                }',
'                 ',
'            }else if($(this).attr("id").indexOf("PRICE") != -1){',
'                if (!/^[+-]?\d+(\.\d+)?$/.test($(this).val())){',
'                    console.log("in price..");',
'                    err.push({',
'                            type:       "error",',
'                            location:   [ "page", "inline" ],',
'                            pageItem:   $(this).attr("id"),',
'                            message:    "Price is not valid. Example Price: ''00.23 or 00,23 or -00.23''",',
'                            unsafe:     false',
'                        });',
'                }',
'            } ',
'        }',
'',
'        ',
'    });',
'    return err;',
'    ',
'    ',
'}'))
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'//$("#bill_total .t-AVPList-label").css("width","200px"); //100',
'//$("#bill_total .t-AVPList-value").css("width","200px"); //100',
'',
'$("#BILL_ID").css("display","none");',
'$("td[headers=''BILL_ID'']").css("display","none");',
'$(".t-MediaList-title").css(''width'',''100%'');',
''))
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
'.t-MediaList-title{ ',
'    width:100%;',
'}',
'.selectedInvoice{',
'    background-color:#ddd;',
'}'))
,p_step_template=>wwv_flow_imp.id(37627000224499786048)
,p_page_template_options=>'#DEFAULT#'
,p_page_component_map=>'03'
,p_last_updated_by=>'MACDENIZ'
,p_last_upd_yyyymmddhh24miss=>'20220625172437'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(1345484639188507)
,p_plug_name=>'Invoice #<span>&P14_BID.</span>'
,p_region_name=>'invoice_overview'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(37627033949633786074)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>3
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(785356102483022)
,p_name=>'Invoice Tax Details'
,p_region_name=>'invoice_tax_detail'
,p_parent_plug_id=>wwv_flow_imp.id(1345484639188507)
,p_template=>wwv_flow_imp.id(37627008340170786055)
,p_display_sequence=>55
,p_region_template_options=>'#DEFAULT#:t-Form--noPadding:t-Form--stretchInputs:margin-top-none:margin-bottom-none'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight:t-Report--noBorders'
,p_region_attributes=>'style="padding:10px;padding-top:20px;border-bottom:3px'
,p_display_point=>'SUB_REGIONS'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select inv.id',
'    , ''davon ''||t.percent||''% USt''',
'    , TO_CHAR(sum(round(invitem.quantity*a.price,2))*(t.percent/100),V(''CURRENCYFORMAT''))||'' EUR'' ',
'     as total',
'  from sc_invoice inv',
'  left join sc_invoiceitem invitem on invitem.invoice_id = inv.id',
'  left join sc_article a on a.id = invitem.article_id',
'  left join sc_tax t on t.id = a.tax_id',
'where inv.id = :P14_BID',
'group by inv.id,t.percent'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P14_BID'
,p_lazy_loading=>false
,p_query_row_template=>wwv_flow_imp.id(37627060184177786093)
,p_query_headings_type=>'NO_HEADINGS'
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'No Records Selected.'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'Y'
);
wwv_flow_imp_page.set_region_column_width(
 p_id=>wwv_flow_imp.id(785356102483022)
,p_plug_column_width=>'style=''margin-top:-30px'''
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(784859295483017)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>30
,p_use_as_row_header=>'N'
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(784711048483015)
,p_query_column_id=>2
,p_column_alias=>'''DAVON''||T.PERCENT||''%UST'''
,p_column_display_sequence=>10
,p_column_heading=>'&#x27;davon&#x27;||t.percent||&#x27;%ust&#x27;'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(785094441483019)
,p_query_column_id=>3
,p_column_alias=>'TOTAL'
,p_column_display_sequence=>20
,p_column_heading=>'<b>Total</b>'
,p_use_as_row_header=>'N'
,p_column_html_expression=>'<span id=total><b>#TOTAL#</b></span>'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(32831632635654889519)
,p_name=>'Items'
,p_region_name=>'invoice_details'
,p_parent_plug_id=>wwv_flow_imp.id(1345484639188507)
,p_template=>wwv_flow_imp.id(37627008146725786055)
,p_display_sequence=>40
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight:t-Report--noBorders'
,p_display_point=>'SUB_REGIONS'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select inv.id as invoice_id',
'      ,a.id ',
'      ,a.name article,',
'      quantity||''x'' as qty,',
'      to_char(a.price,v(''CURRENCYFORMAT''))||'' EUR'' ',
'        as unit_price',
'      ,to_char(percent,''90'')||''%''  ',
'        as tax',
'      ,invitem.discount',
'      ,to_char(round(quantity*a.price,2),v(''CURRENCYFORMAT''))||'' EUR'' ',
'        as total',
'    from sc_invoiceitem invitem ',
'    left join sc_article a on a.id = invitem.article_id  ',
'    left join sc_invoice inv on inv.id = invitem.invoice_id',
'    left join sc_tax t on t.id = a.tax_id  ',
'    where invitem.invoice_id = :P14_BID',
'UNION',
'SELECT null as invoice_id',
'     , null as id',
'     , ''No Invoice Selected'' as article',
'     , null as qty',
'     , null unit_price',
'     , null as tax',
'     ,null discount',
'     ,null as total',
'  FROM DUAL WHERE :P14_BID IS NULL;'))
,p_footer=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!--<div id="total-container" style="position:absolute;',
'    right:20px;',
'    margin-top:10px;',
'    height:50px;',
'    padding:0px;',
'    font-size:20px;',
'    font-weight: normal;',
'     text-align:right;" >',
'    ',
'',
'    <div style="display:table;">',
'        <div style=''display:table-row''>',
'            <div style="display:table-cell">',
'                <p><b>SUB-TOTAL</b></p>',
'                <p><b>DISCOUNT</b></p>',
'                <p><b>TOTAL</b></p>',
'            </div>',
'            <div style="display:table-cell">',
unistr('                <p><span id=''subtotal-val''></span> \20AC</p>'),
'                <p><span id=''discount-val''></span></p>',
unistr('                 <p><span id=''total-val''></span> \20AC</p>'),
'            </div>',
'        </div>',
'    </div>',
'</div> ',
'-->'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P14_BID'
,p_lazy_loading=>false
,p_query_row_template=>wwv_flow_imp.id(37627060184177786093)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'No Data Selected...'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_prn_format=>'PDF'
,p_prn_output_link_text=>'Print'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width_units=>'PERCENTAGE'
,p_prn_width=>297
,p_prn_height=>210
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Items'
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
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.set_region_column_width(
 p_id=>wwv_flow_imp.id(32831632635654889519)
,p_plug_column_width=>'style="min-height:300px;padding:5px;border-bottom:3px solid #999;"'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(1349201839188544)
,p_query_column_id=>1
,p_column_alias=>'INVOICE_ID'
,p_column_display_sequence=>70
,p_use_as_row_header=>'N'
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(1349086178188543)
,p_query_column_id=>2
,p_column_alias=>'ID'
,p_column_display_sequence=>80
,p_use_as_row_header=>'N'
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(1959771852800467844)
,p_query_column_id=>3
,p_column_alias=>'ARTICLE'
,p_column_display_sequence=>20
,p_column_heading=>'Products'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(788693237483055)
,p_query_column_id=>4
,p_column_alias=>'QTY'
,p_column_display_sequence=>10
,p_column_heading=>'#'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(1959772069131467846)
,p_query_column_id=>5
,p_column_alias=>'UNIT_PRICE'
,p_column_display_sequence=>30
,p_column_heading=>'Unit Price'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(1959772140717467847)
,p_query_column_id=>6
,p_column_alias=>'TAX'
,p_column_display_sequence=>40
,p_column_heading=>'Vat.'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(1959772260102467848)
,p_query_column_id=>7
,p_column_alias=>'DISCOUNT'
,p_column_display_sequence=>50
,p_use_as_row_header=>'N'
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(1959772288918467849)
,p_query_column_id=>8
,p_column_alias=>'TOTAL'
,p_column_display_sequence=>60
,p_column_heading=>'Total'
,p_use_as_row_header=>'N'
,p_column_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(35833144673882638686)
,p_name=>'Invoice Sum Details'
,p_region_name=>'invoice_total'
,p_parent_plug_id=>wwv_flow_imp.id(1345484639188507)
,p_template=>wwv_flow_imp.id(37627008146725786055)
,p_display_sequence=>45
,p_region_template_options=>'#DEFAULT#:margin-bottom-none:margin-right-none'
,p_component_template_options=>'#DEFAULT#:t-AVPList--variableLabelLarge:t-AVPList--rightAligned'
,p_region_attributes=>'style="padding:10px;padding-top:20px;border-bottom:3px'
,p_display_point=>'SUB_REGIONS'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select inv.id as bid2',
'        ,inv.id',
'        ,to_char(round(total+discount,2),v(''CURRENCYFORMAT''))||'' EUR'' ',
'            as subtotal',
'        ,to_char(discount,v(''CURRENCYFORMAT''))||'' EUR'' ',
'            as discount',
'        ,to_char(total,v(''CURRENCYFORMAT''))||'' EUR'' ',
'            as total',
'    --    ,sum()',
'  from sc_invoice inv',
'  left join sc_payment p on p.id=inv.payment_id',
' where inv.ID = :P14_BID'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P14_BID'
,p_lazy_loading=>false
,p_query_row_template=>wwv_flow_imp.id(37627063101389786096)
,p_query_headings_type=>'NO_HEADINGS'
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'No Records Selected.'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(3115649688301728373)
,p_query_column_id=>1
,p_column_alias=>'BID2'
,p_column_display_sequence=>5
,p_use_as_row_header=>'N'
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(1348981966188542)
,p_query_column_id=>2
,p_column_alias=>'ID'
,p_column_display_sequence=>15
,p_use_as_row_header=>'N'
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(1586173709369572485)
,p_query_column_id=>3
,p_column_alias=>'SUBTOTAL'
,p_column_display_sequence=>2
,p_column_heading=>'Subtotal'
,p_use_as_row_header=>'Y'
,p_column_html_expression=>'<b>#SUBTOTAL#</b>'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_report_column_width=>10
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(1586170471277572452)
,p_query_column_id=>4
,p_column_alias=>'DISCOUNT'
,p_column_display_sequence=>3
,p_column_heading=>'- Discount'
,p_use_as_row_header=>'N'
,p_column_html_expression=>'<span class="u-text-success">-#DISCOUNT#</span>'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_display_when_cond_type=>'EXISTS'
,p_display_when_condition=>'SELECT * FROM SC_INVOICE WHERE ID = :P14_BID AND DISCOUNT != 0'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(1586170306105572451)
,p_query_column_id=>5
,p_column_alias=>'TOTAL'
,p_column_display_sequence=>4
,p_column_heading=>'<b>Total</b>'
,p_use_as_row_header=>'N'
,p_column_html_expression=>'<span id=total><b>#TOTAL#</b></span>'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(1959775391758467880)
,p_plug_name=>'Filter Container'
,p_region_template_options=>'#DEFAULT#:t-TabsRegion-mod--fillLabels:t-TabsRegion-mod--pill'
,p_region_attributes=>'style="border-bottom:3px dotted #999;"'
,p_plug_template=>wwv_flow_imp.id(37627040811116786079)
,p_plug_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(784378199483012)
,p_plug_name=>'Text Search'
,p_parent_plug_id=>wwv_flow_imp.id(1959775391758467880)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(37627008146725786055)
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(1959775671812467882)
,p_plug_name=>'Price Search'
,p_parent_plug_id=>wwv_flow_imp.id(1959775391758467880)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(37627008146725786055)
,p_plug_display_sequence=>30
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(69513227843444170405)
,p_plug_name=>'Date Search'
,p_parent_plug_id=>wwv_flow_imp.id(1959775391758467880)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(37627008146725786055)
,p_plug_display_sequence=>20
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(35377049345156466179)
,p_name=>'Invoice List'
,p_region_name=>'bill_overview'
,p_template=>wwv_flow_imp.id(37627008340170786055)
,p_display_sequence=>60
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'t-MediaList--showIcons:t-MediaList--showBadges:t-MediaList--stack'
,p_region_attributes=>'style="padding-left:10px;"'
,p_new_grid_row=>false
,p_new_grid_column=>false
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select inv.id,',
'    CASE WHEN :P14_BID = inv.id THEN ''u-color-1'' ELSE '''' END link_class, -- ''#'' link,',
'    --apex_page.get_url(p_items => ''P14_BID'', p_values => inv.id) link,',
'    ''#'' link,',
'    case inv.status ',
'    when ''Open'' then ''fa fa-lg fa-exclamation-circle-o''',
'    when ''Closed'' then ''fa fa-lg fa-check-circle u-success-text''',
'    when ''Canceled'' then ''fa fa-lg fa-minus-circle u-danger-text''',
'    when ''Pending'' then ''fa fa-lg fa-exclamation-triangle u-warning-text''',
'  end icon_class,',
'    ''id=''||inv.id||'' style=color:#333; data=''||discount  link_attr, --||'' data="''||discount||''"''',
'    null icon_color_class,',
'    case when nvl(:P14_BID,''0'') = inv.id',
'      then ''is-active'' ',
'      else '' ''',
'    end list_class,',
'    TO_CHAR(inv.TOTAL,V(''CURRENCYFORMAT''))||'' EUR'' list_title,',
'    ''Invoice#''||inv.id||'' <br/>''||TO_CHAR(inv.created,V(''DATEFORMAT'')) list_text,',
'    inv.status list_badge,',
'    p.name as payment',
'from "SC_INVOICE" inv',
'left join sc_payment p on p.id = inv.payment_id',
'where (:P14_TEXT_SEARCH IS NULL ',
'        OR inv.id LIKE ''%''||:P14_TEXT_SEARCH||''%''',
'        OR UPPER(p.name) LIKE ''%''||UPPER(:P14_TEXT_SEARCH)||''%''',
'        OR UPPER(inv.status) LIKE ''%''||UPPER(:P14_TEXT_SEARCH)||''%'') AND',
'       (:P14_DATE_FROM is null',
'        or inv.created >= TO_DATE(:P14_DATE_FROM,''DD-MM-YYYY HH24:MI'')) AND ',
'       (:P14_DATE_UNTIL is null',
'        or inv.created <= TO_DATE(:P14_DATE_UNTIL,''DD-MM-YYYY HH24:MI'')) AND',
'         (:P14_PRICE_FROM is null',
'        or inv.total >= :P14_PRICE_FROM) AND',
'        (:P14_PRICE_UNTIL is null',
'        or inv.total <= :P14_PRICE_UNTIL) ',
'       -- inv.canceled is null',
'',
'order by inv.CREATED DESC NULLS LAST'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P14_DATE_FROM,P14_PRICE_FROM,P14_DATE_UNTIL,P14_PRICE_UNTIL,P14_TEXT_SEARCH'
,p_lazy_loading=>false
,p_query_row_template=>wwv_flow_imp.id(37627056785753786091)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(787216781483040)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_column_heading=>'Id'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(787125024483039)
,p_query_column_id=>2
,p_column_alias=>'LINK_CLASS'
,p_column_display_sequence=>20
,p_column_heading=>'Link Class'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(786958331483038)
,p_query_column_id=>3
,p_column_alias=>'LINK'
,p_column_display_sequence=>30
,p_column_heading=>'Link'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(786854104483037)
,p_query_column_id=>4
,p_column_alias=>'ICON_CLASS'
,p_column_display_sequence=>40
,p_column_heading=>'Icon Class'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(786788701483036)
,p_query_column_id=>5
,p_column_alias=>'LINK_ATTR'
,p_column_display_sequence=>50
,p_column_heading=>'Link Attr'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(786676559483035)
,p_query_column_id=>6
,p_column_alias=>'ICON_COLOR_CLASS'
,p_column_display_sequence=>60
,p_column_heading=>'Icon Color Class'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(786625193483034)
,p_query_column_id=>7
,p_column_alias=>'LIST_CLASS'
,p_column_display_sequence=>70
,p_column_heading=>'List Class'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(786457531483033)
,p_query_column_id=>8
,p_column_alias=>'LIST_TITLE'
,p_column_display_sequence=>80
,p_column_heading=>'List Title'
,p_use_as_row_header=>'N'
,p_column_html_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'    <div style=''width:40%;float:left;''>#LIST_TEXT#</div>',
'    <div style=''width:40%;float:left;line-height:3''>#PAYMENT#</div>',
'    <div style=''width:20%;float:right;text-align:right;line-height:3''>#LIST_TITLE#</div>',
''))
,p_column_css_class=>'fullwidth'
,p_column_alignment=>'CENTER'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
,p_column_comment=>'<table style=''width:100%''><tr><td>#LIST_TITLE#</td><td>#LIST_TEXT#</td><td>#PAYMENT#</td></tr></table>'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(786381195483032)
,p_query_column_id=>9
,p_column_alias=>'LIST_TEXT'
,p_column_display_sequence=>90
,p_column_heading=>'List Text'
,p_use_as_row_header=>'N'
,p_column_alignment=>'CENTER'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(786322527483031)
,p_query_column_id=>10
,p_column_alias=>'LIST_BADGE'
,p_column_display_sequence=>100
,p_column_heading=>'List Badge'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(786189228483030)
,p_query_column_id=>11
,p_column_alias=>'PAYMENT'
,p_column_display_sequence=>110
,p_column_heading=>'Payment'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(69714471191364022033)
,p_plug_name=>'Invoices'
,p_icon_css_classes=>'fa-server-check'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(37627026450443786069)
,p_plug_display_sequence=>90
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(784113719483009)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(784378199483012)
,p_button_name=>'Reset_1_1'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft:t-Button--gapTop'
,p_button_template_id=>wwv_flow_imp.id(37627091174184786117)
,p_button_image_alt=>'Reset Filter'
,p_button_position=>'BOTTOM'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_css_classes=>'resetSearch'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(3115646796648728344)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(69513227843444170405)
,p_button_name=>'Reset'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft:t-Button--gapTop'
,p_button_template_id=>wwv_flow_imp.id(37627091174184786117)
,p_button_image_alt=>'Reset Filter'
,p_button_position=>'BOTTOM'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_css_classes=>'resetSearch'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(3115646906173728345)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(1959775671812467882)
,p_button_name=>'Reset_1'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft:t-Button--gapTop'
,p_button_template_id=>wwv_flow_imp.id(37627091174184786117)
,p_button_image_alt=>'Reset Filter'
,p_button_position=>'BOTTOM'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_css_classes=>'resetSearch'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(3115648355973728359)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(1345484639188507)
,p_button_name=>'Cancel_bill'
,p_button_static_id=>'but_cancel'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconRight'
,p_button_template_id=>wwv_flow_imp.id(37627091174184786117)
,p_button_image_alt=>'Cancel Invoice'
,p_button_position=>'CHANGE'
,p_button_redirect_url=>'f?p=&APP_ID.:11:&SESSION.::&DEBUG.:RP,11:P11_BID:&P14_BID.'
,p_icon_css_classes=>'fa-remove'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(6825275431852012650)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(1345484639188507)
,p_button_name=>'print'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(37627091174184786117)
,p_button_image_alt=>'Print'
,p_button_position=>'CLOSE'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-print fam-arrow-down fam-is-success'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(788477545483053)
,p_name=>'P14_DISCOUNT'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(1959775391758467880)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(784299182483011)
,p_name=>'P14_TEXT_SEARCH'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(784378199483012)
,p_prompt=>'Text Search'
,p_placeholder=>'Text Search'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_imp.id(37627089615814786115)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:t-Form-fieldContainer--large:margin-top-none:margin-bottom-none:margin-left-none:margin-right-none:t-Form-fieldContainer--radioButtonGroup'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1749522985446462207)
,p_name=>'P14_BID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(1959775391758467880)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1749523704449462209)
,p_name=>'P14_DATE_FROM'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(69513227843444170405)
,p_prompt=>'Date From'
,p_placeholder=>'From'
,p_format_mask=>'DD-MM-YYYY HH24:MI'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_imp.id(37627089615814786115)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:t-Form-fieldContainer--large:margin-top-none:margin-bottom-none:margin-left-none:margin-right-none:t-Form-fieldContainer--radioButtonGroup'
,p_encrypt_session_state_yn=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'Y'
,p_attribute_07=>'MONTH_AND_YEAR'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1959775706428467883)
,p_name=>'P14_DATE_UNTIL'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(69513227843444170405)
,p_prompt=>'Date From'
,p_placeholder=>'Until'
,p_format_mask=>'DD-MM-YYYY HH24:MI'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_imp.id(37627089615814786115)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:t-Form-fieldContainer--large:margin-top-none:margin-bottom-none:margin-left-none:margin-right-none:t-Form-fieldContainer--radioButtonGroup'
,p_encrypt_session_state_yn=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1959775835222467884)
,p_name=>'P14_PRICE_FROM'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(1959775671812467882)
,p_prompt=>'Price From'
,p_placeholder=>'From'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_imp.id(37627089615814786115)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:t-Form-fieldContainer--large:margin-top-none:margin-bottom-none:margin-left-none:margin-right-none:t-Form-fieldContainer--radioButtonGroup'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
end;
/
begin
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1959775901836467885)
,p_name=>'P14_PRICE_UNTIL'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(1959775671812467882)
,p_prompt=>'Price From'
,p_placeholder=>'Until'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_imp.id(37627089615814786115)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:t-Form-fieldContainer--large:margin-top-none:margin-bottom-none:margin-left-none:margin-right-none:t-Form-fieldContainer--radioButtonGroup'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3115650222244728378)
,p_name=>'P14_CANCEL_REASON'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(32831632635654889519)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(1749534215551462227)
,p_name=>'update IG for Image Upload'
,p_event_sequence=>10
,p_bind_type=>'live'
,p_bind_delegate_to_selector=>'#bill_report'
,p_bind_event_type=>'ready'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1749534705884462227)
,p_event_id=>wwv_flow_imp.id(1749534215551462227)
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
'   $(''#main'').append(''<input style="display:none" attr="''+bid+''" type="file" id="P14_IMG''+bid+''" name="P2_IMG''+bid+''" onChange=if(this.files.length==1){updateImage(''+bid+'',false);} />'');',
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
''))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(1749536980104462229)
,p_name=>'performSearch PRESS'
,p_event_sequence=>100
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P14_DATE_FROM,P14_DATE_UNTIL,P14_PRICE_FROM,P14_PRICE_UNTIL,P14_TEXT_SEARCH'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'checkFilterInputs().length == 0 && this.browserEvent.which === apex.jQuery.ui.keyCode.ENTER'
,p_bind_type=>'live'
,p_bind_event_type=>'keypress'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1351715411579175980)
,p_event_id=>wwv_flow_imp.id(1749536980104462229)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.message.clearErrors();',
'if(this.browserEvent.which === apex.jQuery.ui.keyCode.ENTER){',
'console.log(checkFilterInputs());',
'    apex.message.showErrors(checkFilterInputs());',
'}'))
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(3115647613388728352)
,p_event_id=>wwv_flow_imp.id(1749536980104462229)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'apex.message.clearErrors();'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1749537461412462230)
,p_event_id=>wwv_flow_imp.id(1749536980104462229)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(35377049345156466179)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1749537944304462230)
,p_event_id=>wwv_flow_imp.id(1749536980104462229)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CANCEL_EVENT'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(1351714657408175972)
,p_name=>'performSearch Date CLOSE'
,p_event_sequence=>130
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'.ui-datepicker-close'
,p_bind_type=>'live'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1351714748290175973)
,p_event_id=>wwv_flow_imp.id(1351714657408175972)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(35377049345156466179)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1351714851563175974)
,p_event_id=>wwv_flow_imp.id(1351714657408175972)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CANCEL_EVENT'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(3115647143053728347)
,p_name=>'performSearch LOSE'
,p_event_sequence=>150
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P14_DATE_FROM,P14_DATE_UNTIL,P14_PRICE_FROM,P14_PRICE_UNTIL,P14_TEXT_SEARCH'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'checkFilterInputs().length == 0'
,p_bind_type=>'live'
,p_bind_event_type=>'focusout'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(3115647437108728350)
,p_event_id=>wwv_flow_imp.id(3115647143053728347)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.message.clearErrors();',
'',
'apex.message.showErrors(checkFilterInputs());'))
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(3115647496392728351)
,p_event_id=>wwv_flow_imp.id(3115647143053728347)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'apex.message.clearErrors();'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(3115647212841728348)
,p_event_id=>wwv_flow_imp.id(3115647143053728347)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(35377049345156466179)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(3115647361372728349)
,p_event_id=>wwv_flow_imp.id(3115647143053728347)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CANCEL_EVENT'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(1749540130390462232)
,p_name=>'optimize image size'
,p_event_sequence=>170
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(35833144673882638686)
,p_bind_type=>'live'
,p_bind_event_type=>'load'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1749540630829462232)
,p_event_id=>wwv_flow_imp.id(1749540130390462232)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
' $("img").css("width","200px");',
'   $("img").addClass(''tooltipImg'');',
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
''))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(1959776440627467890)
,p_name=>'Reset Search Filter'
,p_event_sequence=>180
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'.resetSearch'
,p_bind_type=>'live'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1959776502738467891)
,p_event_id=>wwv_flow_imp.id(1959776440627467890)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P14_DATE_FROM,P14_PRICE_FROM,P14_DATE_UNTIL,P14_PRICE_UNTIL'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(3115647042788728346)
,p_event_id=>wwv_flow_imp.id(1959776440627467890)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(35377049345156466179)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(6825275565509012651)
,p_name=>'print receipt'
,p_event_sequence=>220
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(6825275431852012650)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(6825275590281012652)
,p_event_id=>wwv_flow_imp.id(6825275565509012651)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.server.process(',
'    ''create_receipt'',                             // Process or AJAX Callback name',
'    {x01: $v(''P14_BID'')},  // Parameter "x01"',
'    {',
'      success: function (pData) {             // Success Javascript',
'        var oldBody = $("body").html();',
'        $("body").html(pData);',
'        window.print();',
'        $("body").html(oldBody);',
'        $("#t_Body_content_offset").remove();',
'      },',
'      dataType: "text"                        // Response type (here: plain text)',
'    }',
'  );'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(786126953483029)
,p_name=>'select invoice'
,p_event_sequence=>230
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'.t-MediaList-itemWrap'
,p_bind_type=>'live'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(786041009483028)
,p_event_id=>wwv_flow_imp.id(786126953483029)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P14_BID'
,p_attribute_01=>'JAVASCRIPT_EXPRESSION'
,p_attribute_05=>'this.triggeringElement.id'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(785480793483023)
,p_event_id=>wwv_flow_imp.id(786126953483029)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P14_DISCOUNT'
,p_attribute_01=>'JAVASCRIPT_EXPRESSION'
,p_attribute_05=>'$(this.triggeringElement).attr(''data'')'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(785704743483025)
,p_event_id=>wwv_flow_imp.id(786126953483029)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(".u-color-1").removeClass(''u-color-1'');',
'$(this.triggeringElement).addClass(''u-color-1'');',
'apex.region("invoice_details").refresh();',
'apex.region("invoice_total").refresh(); ',
'apex.region("invoice_tax_detail").refresh(); ',
'',
'var attrOnclick = $("#but_cancel").attr(''onclick'');',
'var parts = attrOnclick.split(''P11_BID'');',
'var parts2 = parts[1].split(''\\u0026p_dialog_cs'');',
'var old_bid = parts2[0];',
'attrOnclick = attrOnclick.replace(''P11_BID''+old_bid,''P11_BID:''+$v(''P14_BID''));',
'$("#but_cancel").attr(''onclick'',attrOnclick);',
'',
'$("#invoice_overview_heading span").html($v(''P14_BID''));'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(783876046483007)
,p_name=>'Cancel Closed'
,p_event_sequence=>240
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(3115648355973728359)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(647559987518356)
,p_event_id=>wwv_flow_imp.id(783876046483007)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(35377049345156466179)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(530930369518348)
,p_name=>'DA_SELECT_MONTH'
,p_event_sequence=>250
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'.oj-enabled[data-handler=''selectMonth'']'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(530768266518347)
,p_event_id=>wwv_flow_imp.id(530930369518348)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'$s("P14_REPORT_MONTH",$(this).attr(''data-month'')+"/"+$(this).attr(''data-year''));'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(6825276143653012657)
,p_process_sequence=>10
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'create_receipt'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'begin',
'IA.create_receipt(apex_application.g_x01);',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(1749531527073462225)
,p_process_sequence=>20
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
