prompt --application/pages/page_00024
begin
wwv_flow_imp_page.create_page(
 p_id=>24
,p_user_interface_id=>wwv_flow_imp.id(37627114721722786135)
,p_name=>'Invoices'
,p_alias=>'INVOICES'
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
'            }else if (!/^[+-]?\d+(\.\d+)?$/.test($(this).val())){',
'                   console.log("in price..");',
'                err.push({',
'                        type:       "error",',
'                        location:   [ "page", "inline" ],',
'                        pageItem:   $(this).attr("id"),',
'                        message:    "Price is not valid. Example Price: ''00.23 or 00,23 or -00.23''",',
'                        unsafe:     false',
'                    });',
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
'//$("#bill_total .t-AVPList-label").css("width","100px");',
'//$("#bill_total .t-AVPList-value").css("width","100px");',
'',
'$("#BILL_ID").css("display","none");',
'$("td[headers=''BILL_ID'']").css("display","none");',
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
''))
,p_step_template=>wwv_flow_imp.id(37626983472325786034)
,p_page_template_options=>'#DEFAULT#'
,p_page_component_map=>'03'
,p_last_updated_by=>'MACDENIZ'
,p_last_upd_yyyymmddhh24miss=>'20220525141240'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(1594630424396146519)
,p_name=>'Invoice Details'
,p_region_name=>'bill_report'
,p_template=>wwv_flow_imp.id(37627033949633786074)
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-AVPList--rightAligned'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select i.id',
'      ,p.name as payment',
'      ,to_char(i.created,''DD-MM-YYYY HH24:MM:SS'') created',
'      ,to_char(i.updated,''DD-MM-YYYY HH24:MM:SS'') updated',
'      ,cancel_reason',
'      ,canceled',
'  from SC_INVOICE i',
'  left join sc_payment p on p.id=i.payment_id',
' where i.ID = :P24_BID '))
,p_display_when_condition=>'P24_BID'
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P24_BID'
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
 p_id=>wwv_flow_imp.id(920110020089906)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_column_heading=>'#ID'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(921335179089908)
,p_query_column_id=>2
,p_column_alias=>'PAYMENT'
,p_column_display_sequence=>40
,p_column_heading=>'Payment'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(920868848089907)
,p_query_column_id=>3
,p_column_alias=>'CREATED'
,p_column_display_sequence=>20
,p_column_heading=>'Created'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(920449111089907)
,p_query_column_id=>4
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>30
,p_column_heading=>'Updated'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(919671062089906)
,p_query_column_id=>5
,p_column_alias=>'CANCEL_REASON'
,p_column_display_sequence=>60
,p_column_heading=>'Cancel Reason'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(919271760089905)
,p_query_column_id=>6
,p_column_alias=>'CANCELED'
,p_column_display_sequence=>70
,p_column_heading=>'Canceled'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(1968232989087041923)
,p_plug_name=>'Filter Container'
,p_region_template_options=>'#DEFAULT#:t-TabsRegion-mod--fillLabels:t-TabsRegion-mod--pill'
,p_region_attributes=>'style="padding:10px;padding-top:20px;border-bottom:3px dotted #999;"'
,p_plug_template=>wwv_flow_imp.id(37627040811116786079)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_02'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(1968233269141041925)
,p_plug_name=>'Price'
,p_parent_plug_id=>wwv_flow_imp.id(1968232989087041923)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(37627008146725786055)
,p_plug_display_sequence=>20
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(69521685440772744448)
,p_plug_name=>'Date'
,p_parent_plug_id=>wwv_flow_imp.id(1968232989087041923)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(37627008146725786055)
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(32840090232983463562)
,p_name=>'Items'
,p_region_name=>'item_overview'
,p_template=>wwv_flow_imp.id(37627008146725786055)
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#:t-Form--xlarge:t-Form--stretchInputs'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select inv.id as invoice_id',
'      ,a.id ',
'      ,a.name article,',
'      quantity,',
unistr('      to_char(a.price,''9999990.00'')||'' \20AC'' unit_price'),
'      ,to_char(percent,''90'')||''%''  tax',
'      ,invitem.discount',
unistr('      ,to_char(round(quantity*a.price,2),''9999990.00'')||'' \20AC'' total'),
'    from sc_invoiceitem invitem ',
'    left join sc_article a on a.id = invitem.article_id  ',
'    left join sc_invoice inv on inv.id = invitem.invoice_id',
'    left join sc_tax t on t.id = a.tax_id  ',
'    where invitem.invoice_id = :P24_BID'))
,p_display_when_condition=>'P24_BID'
,p_display_when_cond2=>':P24_BID_1'
,p_display_condition_type=>'VALUE_OF_ITEM_IN_CONDITION_NOT_IN_COLON_DELIMITED_LIST'
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
,p_ajax_items_to_submit=>'P24_BID'
,p_lazy_loading=>false
,p_query_row_template=>wwv_flow_imp.id(37627060184177786093)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'No Data Selected...'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(908828667089877)
,p_query_column_id=>1
,p_column_alias=>'INVOICE_ID'
,p_column_display_sequence=>17
,p_use_as_row_header=>'N'
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(908354211089876)
,p_query_column_id=>2
,p_column_alias=>'ID'
,p_column_display_sequence=>27
,p_use_as_row_header=>'N'
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(911168353089879)
,p_query_column_id=>3
,p_column_alias=>'ARTICLE'
,p_column_display_sequence=>2
,p_column_heading=>'Article'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(910747254089879)
,p_query_column_id=>4
,p_column_alias=>'QUANTITY'
,p_column_display_sequence=>3
,p_column_heading=>'Quantity'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(910360105089879)
,p_query_column_id=>5
,p_column_alias=>'UNIT_PRICE'
,p_column_display_sequence=>4
,p_column_heading=>'Unit Price'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(910044750089878)
,p_query_column_id=>6
,p_column_alias=>'TAX'
,p_column_display_sequence=>5
,p_column_heading=>'Tax'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(909633646089878)
,p_query_column_id=>7
,p_column_alias=>'DISCOUNT'
,p_column_display_sequence=>6
,p_column_heading=>'Discount'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(909239471089877)
,p_query_column_id=>8
,p_column_alias=>'TOTAL'
,p_column_display_sequence=>7
,p_column_heading=>'Total'
,p_use_as_row_header=>'N'
,p_column_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(35385506942485040222)
,p_name=>'Invoice List'
,p_region_name=>'bill_overview'
,p_template=>wwv_flow_imp.id(37627008340170786055)
,p_display_sequence=>30
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'t-MediaList--showDesc:u-colors:t-MediaList--stack:t-MediaList--iconsRounded'
,p_region_attributes=>'style="padding-left:10px;"'
,p_display_point=>'REGION_POSITION_02'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select "ID",',
'   null link_class, -- ''#'' link,',
'    apex_page.get_url(p_items => ''P24_BID'', p_values => "ID") link,',
'    ''fa fa fa-truck'' icon_class,',
'    ''id=''||"ID" link_attr,',
'    null icon_color_class,',
'    case when nvl(:P24_BID,''0'') = "ID"',
'      then ''is-active'' ',
'      else '' ''',
'    end list_class,',
unistr('    "TOTAL"||'' \20AC'' list_title,'),
'    to_char(created,''DD-MM-YYYY HH24:MM:SS'') list_text,',
'    null list_badge',
'from "SC_INVOICE" x',
'where (:P24_DATE_FROM is null',
'        or created > TO_DATE(:P24_DATE_FROM,''DD-MM-YYYY HH24:MI'')) AND ',
'       (:P24_DATE_UNTIL is null',
'        or created < TO_DATE(:P24_DATE_UNTIL,''DD-MM-YYYY HH24:MI'')) AND',
'         (:P24_PRICE_FROM is null',
'        or total > :P24_PRICE_FROM) AND',
'        (:P24_PRICE_UNTIL is null',
'        or total < :P24_PRICE_UNTIL) AND canceled is null',
'order by "CREATED" DESC NULLS LAST'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P24_DATE_FROM,P24_PRICE_FROM,P24_DATE_UNTIL,P24_PRICE_UNTIL'
,p_lazy_loading=>false
,p_query_row_template=>wwv_flow_imp.id(37627056785753786091)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'<b>No Data Found...</b>'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(904104495089870)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>20
,p_column_heading=>'Id'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(907690291089874)
,p_query_column_id=>2
,p_column_alias=>'LINK_CLASS'
,p_column_display_sequence=>2
,p_column_heading=>'Link Class'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(907277417089874)
,p_query_column_id=>3
,p_column_alias=>'LINK'
,p_column_display_sequence=>3
,p_column_heading=>'Link'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(906903753089873)
,p_query_column_id=>4
,p_column_alias=>'ICON_CLASS'
,p_column_display_sequence=>10
,p_column_heading=>'Icon Class'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(906463721089873)
,p_query_column_id=>5
,p_column_alias=>'LINK_ATTR'
,p_column_display_sequence=>4
,p_column_heading=>'Link Attr'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(906058697089873)
,p_query_column_id=>6
,p_column_alias=>'ICON_COLOR_CLASS'
,p_column_display_sequence=>5
,p_column_heading=>'Icon Color Class'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(905737656089872)
,p_query_column_id=>7
,p_column_alias=>'LIST_CLASS'
,p_column_display_sequence=>6
,p_column_heading=>'List Class'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(905324810089872)
,p_query_column_id=>8
,p_column_alias=>'LIST_TITLE'
,p_column_display_sequence=>7
,p_column_heading=>'List Title'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(904887810089871)
,p_query_column_id=>9
,p_column_alias=>'LIST_TEXT'
,p_column_display_sequence=>8
,p_column_heading=>'List Text'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(904465731089871)
,p_query_column_id=>10
,p_column_alias=>'LIST_BADGE'
,p_column_display_sequence=>9
,p_column_heading=>'List Badge'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(35841602271211212729)
,p_name=>'Invoice Sum Details'
,p_region_name=>'bill_total'
,p_template=>wwv_flow_imp.id(37627008146725786055)
,p_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:margin-right-none'
,p_component_template_options=>'#DEFAULT#:t-AVPList--rightAligned'
,p_display_column=>8
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select inv.id as bid2',
'        ,inv.id',
unistr('        ,to_char(round(total+discount,2),''9999990.00'')||'' \20AC'' subtotal'),
unistr('        ,to_char(discount,''9999990.00'')||'' \20AC'' discount'),
unistr('        ,to_char(total,''9999990.00'')||'' \20AC'' total'),
'  from sc_invoice inv',
'  left join sc_payment p on p.id=inv.payment_id',
' where inv.ID = :P24_BID'))
,p_display_when_condition=>'P24_BID'
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P24_BID'
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
 p_id=>wwv_flow_imp.id(913829918089884)
,p_query_column_id=>1
,p_column_alias=>'BID2'
,p_column_display_sequence=>5
,p_use_as_row_header=>'N'
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(912202368089882)
,p_query_column_id=>2
,p_column_alias=>'ID'
,p_column_display_sequence=>15
,p_column_heading=>'Id'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(913437450089884)
,p_query_column_id=>3
,p_column_alias=>'SUBTOTAL'
,p_column_display_sequence=>2
,p_column_heading=>'Subtotal'
,p_use_as_row_header=>'Y'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(912992906089883)
,p_query_column_id=>4
,p_column_alias=>'DISCOUNT'
,p_column_display_sequence=>3
,p_column_heading=>'Discount'
,p_use_as_row_header=>'N'
,p_column_html_expression=>'<span class="u-text-success">-#DISCOUNT#</span>'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(912588217089883)
,p_query_column_id=>5
,p_column_alias=>'TOTAL'
,p_column_display_sequence=>4
,p_column_heading=>'Total'
,p_use_as_row_header=>'N'
,p_column_html_expression=>'<span id=total><b>#TOTAL#</b></span>'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(69722928788692596076)
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
 p_id=>wwv_flow_imp.id(916817477089890)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(1968233269141041925)
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
 p_id=>wwv_flow_imp.id(915340711089887)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(69521685440772744448)
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
 p_id=>wwv_flow_imp.id(918910489089903)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(1594630424396146519)
,p_button_name=>'print'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(37627091174184786117)
,p_button_image_alt=>'Print'
,p_button_position=>'EDIT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-print fam-arrow-down fam-is-success'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(918507463089902)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(1594630424396146519)
,p_button_name=>'Cancel_bill'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconRight'
,p_button_template_id=>wwv_flow_imp.id(37627091174184786117)
,p_button_image_alt=>'Cancel Invoice'
,p_button_position=>'EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:11:&SESSION.::&DEBUG.:RP:P11_BID:&P24_BID.'
,p_icon_css_classes=>'fa-remove'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(918083393089897)
,p_name=>'P24_CANCEL_REASON'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(1594630424396146519)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(917501918089891)
,p_name=>'P24_BID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(1968232989087041923)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(916394127089889)
,p_name=>'P24_PRICE_FROM'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(1968233269141041925)
,p_prompt=>'Price From'
,p_placeholder=>'From...'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(37627089615814786115)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:t-Form-fieldContainer--large'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(916039692089889)
,p_name=>'P24_PRICE_UNTIL'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(1968233269141041925)
,p_prompt=>'Price From'
,p_placeholder=>'Until...'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(37627089615814786115)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:t-Form-fieldContainer--large'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(914930762089886)
,p_name=>'P24_DATE_FROM'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(69521685440772744448)
,p_prompt=>'Date From'
,p_placeholder=>'From'
,p_format_mask=>'DD-MM-YYYY HH24:MI'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(37627089615814786115)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--large'
,p_encrypt_session_state_yn=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(914533672089886)
,p_name=>'P24_DATE_UNTIL'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(69521685440772744448)
,p_prompt=>'Date From'
,p_placeholder=>'Until'
,p_format_mask=>'DD-MM-YYYY HH24:MI'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(37627089615814786115)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--large'
,p_encrypt_session_state_yn=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(902909971089863)
,p_name=>'update IG for Image Upload'
,p_event_sequence=>10
,p_bind_type=>'live'
,p_bind_delegate_to_selector=>'#bill_report'
,p_bind_event_type=>'ready'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(902441628089862)
,p_event_id=>wwv_flow_imp.id(902909971089863)
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
'   $(''#main'').append(''<input style="display:none" attr="''+bid+''" type="file" id="P24_IMG''+bid+''" name="P2_IMG''+bid+''" onChange=if(this.files.length==1){updateImage(''+bid+'',false);} />'');',
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
 p_id=>wwv_flow_imp.id(901991332089861)
,p_name=>'performSearch PRESS'
,p_event_sequence=>100
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P24_DATE_FROM,P24_DATE_UNTIL,P24_PRICE_FROM,P24_PRICE_UNTIL'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'checkFilterInputs().length == 0 && this.browserEvent.which === apex.jQuery.ui.keyCode.ENTER'
,p_bind_type=>'live'
,p_bind_event_type=>'keypress'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(901481424089860)
,p_event_id=>wwv_flow_imp.id(901991332089861)
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
 p_id=>wwv_flow_imp.id(900970591089860)
,p_event_id=>wwv_flow_imp.id(901991332089861)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'apex.message.clearErrors();'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(900528229089859)
,p_event_id=>wwv_flow_imp.id(901991332089861)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(35385506942485040222)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(900031203089859)
,p_event_id=>wwv_flow_imp.id(901991332089861)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CANCEL_EVENT'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(899630923089858)
,p_name=>'performSearch Date CLOSE'
,p_event_sequence=>130
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'.ui-datepicker-close'
,p_bind_type=>'live'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(899055934089858)
,p_event_id=>wwv_flow_imp.id(899630923089858)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(35385506942485040222)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(898604598089857)
,p_event_id=>wwv_flow_imp.id(899630923089858)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CANCEL_EVENT'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(898245819089857)
,p_name=>'performSearch LOSE'
,p_event_sequence=>150
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P24_DATE_FROM,P24_DATE_UNTIL,P24_PRICE_FROM,P24_PRICE_UNTIL'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'checkFilterInputs().length == 0'
,p_bind_type=>'live'
,p_bind_event_type=>'focusout'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(897710604089856)
,p_event_id=>wwv_flow_imp.id(898245819089857)
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
 p_id=>wwv_flow_imp.id(897227254089856)
,p_event_id=>wwv_flow_imp.id(898245819089857)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'apex.message.clearErrors();'
);
end;
/
begin
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(896653763089855)
,p_event_id=>wwv_flow_imp.id(898245819089857)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(35385506942485040222)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(896207507089855)
,p_event_id=>wwv_flow_imp.id(898245819089857)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CANCEL_EVENT'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(895808913089854)
,p_name=>'select bill'
,p_event_sequence=>160
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'#bill_overview a'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(895307248089854)
,p_event_id=>wwv_flow_imp.id(895808913089854)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P24_BID'
,p_attribute_01=>'JAVASCRIPT_EXPRESSION'
,p_attribute_05=>'this.triggeringElement.id'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(894919786089853)
,p_name=>'optimize image size'
,p_event_sequence=>170
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(35841602271211212729)
,p_bind_type=>'live'
,p_bind_event_type=>'load'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(894358821089853)
,p_event_id=>wwv_flow_imp.id(894919786089853)
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
 p_id=>wwv_flow_imp.id(894019690089852)
,p_name=>'Reset Search Filter'
,p_event_sequence=>180
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'.resetSearch'
,p_bind_type=>'live'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(893531310089851)
,p_event_id=>wwv_flow_imp.id(894019690089852)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P24_DATE_FROM,P24_PRICE_FROM,P24_DATE_UNTIL,P24_PRICE_UNTIL'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(892964587089851)
,p_event_id=>wwv_flow_imp.id(894019690089852)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(35385506942485040222)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(892565500089850)
,p_name=>'Close Dialog - Cancel'
,p_event_sequence=>210
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(1594630424396146519)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(892073439089850)
,p_event_id=>wwv_flow_imp.id(892565500089850)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P24_BID'
,p_attribute_01=>'DIALOG_RETURN_ITEM'
,p_attribute_09=>'N'
,p_attribute_10=>'P11_BID'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(891624419089849)
,p_event_id=>wwv_flow_imp.id(892565500089850)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(32840090232983463562)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(891085447089849)
,p_event_id=>wwv_flow_imp.id(892565500089850)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(35841602271211212729)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(890641431089848)
,p_event_id=>wwv_flow_imp.id(892565500089850)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(35385506942485040222)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(890123586089848)
,p_event_id=>wwv_flow_imp.id(892565500089850)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(1594630424396146519)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(889605893089847)
,p_event_id=>wwv_flow_imp.id(892565500089850)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'$(".t-MediaList-item").first().addClass("is-active");'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(889214263089847)
,p_name=>'print receipt'
,p_event_sequence=>220
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(918910489089903)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(888723052089846)
,p_event_id=>wwv_flow_imp.id(889214263089847)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.server.process(',
'    ''create_receipt'',                             // Process or AJAX Callback name',
'    {x01: $v(''P24_BID'')},  // Parameter "x01"',
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
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(903342209089864)
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
 p_id=>wwv_flow_imp.id(903664682089865)
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
