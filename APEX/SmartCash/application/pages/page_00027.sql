prompt --application/pages/page_00027
begin
wwv_flow_imp_page.create_page(
 p_id=>27
,p_user_interface_id=>wwv_flow_imp.id(37627114721722786135)
,p_name=>'Daily Report Backup'
,p_alias=>'DAILY-REPORT-BACKUP'
,p_step_title=>'Daily Report Backup'
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
,p_page_component_map=>'10'
,p_last_updated_by=>'MACDENIZ'
,p_last_upd_yyyymmddhh24miss=>'20220531174330'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(1968515953247146893)
,p_plug_name=>'Daily Report'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(37627008146725786055)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' declare',
'    cursor c_days is',
'      select sum(total) total,sum(discount) discount,trunc(created) salary_day',
'      from sc_invoice group by trunc(created) order by trunc(created) desc;',
'      ',
'     cursor c_items(salary_day DATE) is',
unistr('            select a.id,a.name article,to_char(percent,''90'')||''%''  tax,to_char(a.price,''9999990.00'')||'' \20AC'' unit_price,qnt quantity,disc discount,to_char(total,''9999990.00'')||'' \20AC'' total from (select a.id ,sum(quantity) qnt,sum(discount) disc,sum(total')
||') total',
'                from sc_article a left join sc_invoiceitem bitem  on a.id = bitem.article_id  ',
'                     where trunc(bitem.created) = salary_day group by a.id ) b left join sc_article a on a.id= b.id left join sc_tax t on t.id = a.tax_id order by a.id;',
'      l_counter number;',
'      l_cs varchar2(1000);',
'begin',
'    l_counter := 0;',
'    l_cs := APEX_UTIL.PREPARE_URL(p_url => ''f?p='' || :APP_ID || '':8:''|| :APP_SESSION||''::NO::P27_CS:A'',p_checksum_type => ''PRIVATE_BOOKMARK'');',
'    l_cs := SUBSTR(l_cs,INSTR(l_cs,''cs='',1)+3,LENGTH(l_cs));',
'    ',
'    for day in c_days loop',
'       l_counter := l_counter+1;',
'       ',
'',
'        sys.htp.p(''<div class="col col-12 apex-col-auto report" id="report_''||l_counter||''" ><div style="padding:0px"  class="t-Region t-Region--hideShow t-Region--scrollBody lto34859484182855773307''||l_counter||''_0 a-Collapsible is-collapsed" id="it'
||'em_overview" aria-live="polite">',
'                  <div style="display:none"><button style="display:none" id="switcher''||l_counter||''" class="t-Button t-Button--icon t-Button--hideShow" type="button" aria-labelledby="a_Collapsible1_item_overview_heading" aria-controls="a_Collapsible'
||'1_item_overview_content" aria-expanded="false"><span class="a-Icon a-Collapsible-icon" aria-hidden="true"></span></button></div>',
' <div  class="t-Button t-Region-header t-Button--primary t-Button--noUI" onclick=javascript:$("#switcher''||l_counter||''").click(); >',
'  <div class="t-Region-headerItems  t-Region-headerItems--controls"><span class="a-Icon a-Collapsible-icon" aria-hidden="true"></span></div>',
'  <div class=" t-Region-headerItems--title" style="padding:10px;margin:0px;"  >',
unistr('    <h4 style="width:100%"><table class="a-Collapsible-heading" style="width:100%"   ><tr><td>''||day.salary_day||'' </td><td style="text-align:right;"> ''||day.total||'' \20AC </td></tr></table></h4>'),
'  </div>',
'  <div class="t-Region-headerItems t-Region-headerItems--buttons"></div>',
' </div>',
' <div class="t-Region-bodyWrap">',
'   <div class="t-Region-buttons t-Region-buttons--top">',
'    <div class="t-Region-buttons-left"></div>',
'    <div class="t-Region-buttons-right"><button onclick=printIt(''||l_counter||'',"''||day.salary_day||''") class="t-Button t-Button--icon " type="button" id="B37329856728438929624"><span class="t-Icon  fa fa-print fa-2x fam-arrow-down fam-is-success" ar'
||'ia-hidden="true"></span></button></div>',
'   </div>',
'   <div class="t-Region-body a-Collapsible-content" id="a_Collapsible1_item_overview_content" aria-hidden="false" style="">',
'     ',
'     <div id="report_34859484182855773307''||l_counter||''_catch"><div class="t-Report t-Report--stretch t-Report--altRowsDefault t-Report--rowHighlight lto34859484182855773307''||l_counter||''_1" id="report_item_overview" data-region-id="item_overview">',
'  <div class="t-Report-wrap">',
'    <table class="t-Report-pagination" role="presentation"><tbody><tr><td></td></tr></tbody></table>',
'    <div class="t-Report-tableWrap">',
'    <table class="t-Report-report" aria-label="Invoice">',
'                  <thead><tr>',
'                      <th class="t-Report-colHead" align="center" id="id"><div class="u-Report-sort"><span class="u-Report-sortHeading"><a href=javascript:apex.widget.report.sort("34859484182855773307''||l_counter||''","''||l_cs||''","fsp_sort_1_desc") t'
||'itle="Sort by this column">#ID</a></span><span class="u-Report-sortIcon a-Icon icon-rpt-sort-asc"></span></div></th>',
'                      <th class="t-Report-colHead" align="center" id="ARTICLE"><div class="u-Report-sort"><span class="u-Report-sortHeading"><a href=javascript:apex.widget.report.sort("34859484182855773307''||l_counter||''",''||l_cs||'',"fsp_sort_2") tit'
||'le="Sort by this column">Article</a></span></div></th>',
'                      <th class="t-Report-colHead" align="center" id="QUANTITY"><div class="u-Report-sort"><span class="u-Report-sortHeading"><a href=javascript:apex.widget.report.sort("34859484182855773307''||l_counter||''",''||l_cs||'',"fsp_sort_3") ti'
||'tle="Sort by this column">Quantity</a></span></div></th>',
'                      <th class="t-Report-colHead" align="center" id="UNIT_PRICE"><div class="u-Report-sort"><span class="u-Report-sortHeading"><a href=javascript:apex.widget.report.sort("34859484182855773307''||l_counter||''",''||l_cs||'',"fsp_sort_4") '
||'title="Sort by this column">Unit Price</a></span></div></th>',
'                      <th class="t-Report-colHead" align="center" id="TAX"><div class="u-Report-sort"><span class="u-Report-sortHeading"><a href=javascript:apex.widget.report.sort("34859484182855773307''||l_counter||''",''||l_cs||'',"fsp_sort_5") title="'
||'Sort by this column">Tax</a></span></div></th>',
'                      <th class="t-Report-colHead" align="center" id="DISCOUNT"><div class="u-Report-sort"><span class="u-Report-sortHeading"><a href=javascript:apex.widget.report.sort("34859484182855773307''||l_counter||''",''||l_cs||'',"fsp_sort_6") ti'
||'tle="Sort by this column">Discount</a></span></div></th>',
'                      <th class="t-Report-colHead" align="center" id="TOTAL"><div class="u-Report-sort"><span class="u-Report-sortHeading"><a href=javascript:apex.widget.report.sort("34859484182855773307''||l_counter||''",''||l_cs||'',"fsp_sort_7") title'
||'="Sort by this column">Total</a></span></div></th>',
'                  </tr></thead>',
'                <tbody>'');',
'                ',
'                for item in c_items(day.salary_day) loop',
'                    sys.htp.p(''<tr>',
'                              <td class="t-Report-cell" headers="id">''||item.id||''</td>',
'                              <td class="t-Report-cell" headers="ARTICLE">''||item.article||''</td>',
'                              <td class="t-Report-cell" headers="QUANTITY">''||item.quantity||''</td>',
'                              <td class="t-Report-cell" headers="UNIT_PRICE">''||item.unit_price||''</td>',
'                              <td class="t-Report-cell" headers="TAX">''||item.tax||''</td>',
'                              <td class="t-Report-cell" headers="DISCOUNT">''||item.discount||''</td>',
'                              <td class="t-Report-cell" align="right" headers="TOTAL">''||item.total||''</td>',
'                              </tr>'');',
'                end loop;',
'               ',
'        sys.htp.p(''</tbody></table> </div>',
'                <div class="t-Report-links"></div>',
'                <table class="t-Report-pagination t-Report-pagination--bottom" role="presentation"></table>',
'',
'                            <div class="col col-8 "><span class="apex-grid-nbsp">&nbsp;</span></div><div class="col col-4 apex-col-auto"><div  class="margin-right-none lto35834547188869101345_0" aria-live="polite"> ',
'                           <div ><dl class="t-AVPList t-AVPList--rightAligned lto35834547188869101345_1" >',
'                            <dt class="t-AVPList-label">',
'                              Subtotal',
'                            </dt>',
'                            <dd class="t-AVPList-value">',
unistr('                              <span id="c02_0001" class="display_only">      ''||ROUND(day.discount+day.total,2)||'' \20AC</span>'),
'                            </dd><dt class="t-AVPList-label">',
'                              Discount',
'                            </dt>',
'                            <dd class="t-AVPList-value">',
unistr('                              <span class="u-success-text">-''||day.discount||'' \20AC</span>'),
'                            </dd><dt class="t-AVPList-label">',
'                              Total',
'                            </dt>',
'                            <dd class="t-AVPList-value">',
unistr('                              <span id="total"><b>''||day.total||'' \20AC</b></span>'),
'                            </dd>',
'                            </dl>',
'                            <table class="t-Report-pagination" role="presentation"></table></div>',
'                            </div></div>',
'                    ',
'      </div>',
'    </div></div></div>',
'       <div class="t-Region-buttons t-Region-buttons--bottom">',
'        <div class="t-Region-buttons-left"></div>',
'        <div class="t-Region-buttons-right"></div>',
'       </div>',
'     </div>',
'    </div></div>'');',
'        ',
'        end loop;',
'    ',
'',
'end;'))
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(71749662970535122197)
,p_plug_name=>'Daily Report'
,p_icon_css_classes=>'fa-table-chart'
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
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(636140275984900)
,p_name=>'P27_SALARY_DAY'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(1968515953247146893)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(635392496984893)
,p_name=>'P27_CS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(71749662970535122197)
,p_source=>'apex_util.prepare_url('''',p_checksum_type => ''SESSION'')'
,p_source_type=>'EXPRESSION'
,p_source_language=>'PLSQL'
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(634735206984879)
,p_name=>'update IG for Image Upload'
,p_event_sequence=>10
,p_bind_type=>'live'
,p_bind_delegate_to_selector=>'#bill_report'
,p_bind_event_type=>'ready'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(634177779984878)
,p_event_id=>wwv_flow_imp.id(634735206984879)
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
'   $(''#main'').append(''<input style="display:none" attr="''+bid+''" type="file" id="P27_IMG''+bid+''" name="P2_IMG''+bid+''" onChange=if(this.files.length==1){updateImage(''+bid+'',false);} />'');',
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
 p_id=>wwv_flow_imp.id(633763341984877)
,p_name=>'performSearch'
,p_event_sequence=>100
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P27_SEARCH'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'this.browserEvent.which === apex.jQuery.ui.keyCode.ENTER'
,p_bind_type=>'bind'
,p_bind_event_type=>'keypress'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(633321943984876)
,p_event_id=>wwv_flow_imp.id(633763341984877)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CANCEL_EVENT'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(632938048984876)
,p_name=>'select bill'
,p_event_sequence=>110
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'#bill_overview a'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(632397100984876)
,p_event_id=>wwv_flow_imp.id(632938048984876)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P27_BID'
,p_attribute_01=>'JAVASCRIPT_EXPRESSION'
,p_attribute_05=>'this.triggeringElement.id'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(635112579984881)
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
