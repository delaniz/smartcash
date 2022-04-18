prompt --application/pages/page_00015
begin
wwv_flow_imp_page.create_page(
 p_id=>15
,p_user_interface_id=>wwv_flow_imp.id(37628517236709248794)
,p_name=>'Bills and items'
,p_step_title=>'Bills and items'
,p_autocomplete_on_off=>'OFF'
,p_javascript_file_urls=>'#APP_IMAGES#tesseractt.min.js'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'// builds a js array from long string',
'function clob2Array(clob, size, array) {',
'  loopCount = Math.floor(clob.length / size) + 1;',
'  for (var i = 0; i < loopCount; i++) {',
'    array.push(clob.slice(size * i, size * (i + 1)));',
'  }',
'  return array;',
'}',
'',
'// converts binaryArray to base64 string',
'function binaryArray2base64(int8Array) {',
'  var data = "";',
'  var bytes = new Uint8Array(int8Array);',
'  var length = bytes.byteLength;',
'  for (var i = 0; i < length; i++) {',
'    data += String.fromCharCode(bytes[i]);',
'  }',
'  return btoa(data);',
'}',
'',
'function updateImage(id,newRow){',
'   var file = document.getElementById("P15_IMG"+id).files[0];',
'   console.log("id ->"+id);',
'    console.log("newRow->"+newRow);',
'  var insert = (newRow)?1:0;',
'    if($("#"+id).parent().prev().html().length < 2){',
'        console.log("imageColumn is empty");',
'        $("#"+id).parent().prev().html(''<img id="img_''+id+''" style="border: 4px solid #CCC; -moz-border-radius: 4px; -webkit-border-radius: 4px;" src="" height="75" width="75">'') ',
'        $("#"+id).find(".t-Button-label").html("Change");',
'    }',
'    console.log("insert value is "+insert);',
' ',
'      ',
'  apex.util.showSpinner();',
' ',
'',
' ',
'  var reader = new FileReader();',
' ',
'  reader.onload = (function(pFile) {',
'    return function(e) {',
'      if (pFile) {',
'        var base64 = binaryArray2base64(e.target.result);',
'        var f01Array = [];',
'        f01Array = clob2Array(base64, 30000, f01Array);',
'        ',
'          console.log("data->"+file.name+"--"+file.type+"--"+id+"--"+insert+"--"+f01Array);',
'        apex.server.process(',
'          ''UPLOAD_FILE'',',
'          {',
'            x01: file.name,',
'            x02: file.type,',
'            x03: id,',
'            x04: insert,',
'            f01: f01Array',
'          },',
'          {',
'            dataType: ''json'',',
'            success: function(data) {',
'                console.log("in success before result.."+data);',
'              if (data.result == ''success'') {',
'                ',
'                 if(typeof data.blob_id != "undefined" ){ // IF BLOB FILE SAVED',
'                   ',
'                     view = apex.region("bill_overview").widget().interactiveGrid("getCurrentView");',
'                     model = view.model;',
'                     records = view.getSelectedRecords();',
'                   ',
'                    records.forEach(function(r) {  ',
'                     ',
'                         model.setValue(r,"BLOB_ID", data.blob_id.toString());',
'                         ',
'                     });',
'                     ',
'                 }',
'                 $(".u-Processing").hide();',
'              ',
'                apex.message.showPageSuccess( "Image saved!" );',
'              } else {',
'                alert(''Oops! Something went terribly wrong. Please try again or contact your application administrator.'');',
'              }',
'            }',
'          }',
'        );',
'      }',
'    }',
'  })(file);',
'  reader.readAsArrayBuffer(file);',
'  ',
'     var htmlReader = new FileReader();',
'    htmlReader.addEventListener("load", function(e) {',
'        $(".u-Processing").hide();',
'      $("#img_"+id).attr("src",e.target.result);',
'    }); ',
'    htmlReader.readAsDataURL(file );',
'    ',
'',
'}',
'',
'',
'',
'//INTERACTIVE GRID - ENTERKEY PRESS -change event to TAB ',
'$(''td'').on("keydown", function(e) { alert(e.keyCode);',
'            /* ENTER PRESSED*/',
'            if (e.keyCode == 13) {',
'                /* FOCUS ELEMENT */',
'              /*  var inputs = $(this).parents("form").eq(0).find(":input");',
'                var idx = inputs.index(this);',
'',
'                if (idx == inputs.length - 1) {',
'                    inputs[0].select()',
'                } else {',
'                    inputs[idx + 1].focus(); //  handles submit buttons',
'                    inputs[idx + 1].select();',
'                }*/',
'                $(this).next().focus();',
'                alert(3);',
'                return false;',
'            }',
'        });'))
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
,p_step_template=>wwv_flow_imp.id(29373872776703049025)
,p_page_template_options=>'#DEFAULT#'
,p_page_component_map=>'21'
,p_last_updated_by=>'D.KALDI@ME.COM'
,p_last_upd_yyyymmddhh24miss=>'20191014100721'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(31082124542882430646)
,p_plug_name=>'Items'
,p_region_name=>'item_overview'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(29373897098321049048)
,p_plug_display_sequence=>50
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select bitem.biid ,bitem.pid product,bid,bitem.quantity,bitem.u_id,bitem.unit_net,bitem.unit_gross,bitem.total,t.percent as taxPercent,changes,',
'    CASE WHEN changes > 0 THEN ''<span aria-hidden="true" class="fa fa-euro fa-3x fa-anim-flash fam-arrow-up fam-is-danger" title="the price has risen by ''|| ABS(changes) || ''" ></span>''',
'        WHEN changes < 0 THEN ''<span aria-hidden="true" class="fa fa-euro fa-3x fa-anim-flash fam-arrow-down fam-is-success" title="the price is reduced by ''|| ABS(changes)|| ''"></span>''',
'        ELSE ''<span aria-hidden="true" class="fa fa-euro fa-3x fam-check fam-is-info" title="no changes"></span>'' END as price_changing,changes_biid from billitem ',
'bitem left join product p on p.pid = bitem.pid ',
'left join tax t on t.tid = p.tid left join unit u on u.u_id = bitem.u_id  where bitem.bid = :P15_BID'))
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P15_BID'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(30891069195155540723)
,p_name=>'PRODUCT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PRODUCT'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Product'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>30
,p_value_alignment=>'LEFT'
,p_is_required=>false
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>'select name,pid from product'
,p_lov_display_extra=>true
,p_lov_display_null=>true
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(30891071186441540743)
,p_name=>'TAXPERCENT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TAXPERCENT'
,p_data_type=>'NUMBER'
,p_is_query_only=>true
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Tax'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>35
,p_value_alignment=>'CENTER'
,p_is_required=>false
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>'select percent,tid from tax'
,p_lov_display_extra=>true
,p_lov_display_null=>true
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(30891071537472540747)
,p_name=>'BID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'BID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>100
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_default_type=>'ITEM'
,p_default_expression=>'P15_BID'
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(31082125769919430647)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_use_as_row_header=>false
,p_enable_hide=>true
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(31082126204089430647)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_label=>'Actions'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>20
,p_value_alignment=>'CENTER'
,p_use_as_row_header=>false
,p_enable_hide=>true
,p_is_primary_key=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(31082128639047430649)
,p_name=>'UNIT_NET'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'UNIT_NET'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Net'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>50
,p_value_alignment=>'CENTER'
,p_attribute_03=>'right'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(31082129233277430650)
,p_name=>'UNIT_GROSS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'UNIT_GROSS'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>60
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(31082129808169430650)
,p_name=>'BIID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'BIID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>70
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(31082130431378430650)
,p_name=>'TOTAL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TOTAL'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Total'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>80
,p_value_alignment=>'CENTER'
,p_attribute_03=>'right'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(31570743876426595240)
,p_name=>'QUANTITY'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'QUANTITY'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Qnt'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>40
,p_value_alignment=>'CENTER'
,p_attribute_03=>'right'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(31570744124629595243)
,p_name=>'CHANGES_BIID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CHANGES_BIID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>140
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(31570744290269595244)
,p_name=>'PRICE_CHANGING'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PRICE_CHANGING'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Price Changing'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>150
,p_value_alignment=>'LEFT'
,p_attribute_02=>'VALUE'
,p_attribute_05=>'HTML'
,p_item_attributes=>'<span title="My tooltip text">#PRICE_CHANGING#</span>'
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(31570744657548595248)
,p_name=>'U_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'U_ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Unit'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>45
,p_value_alignment=>'LEFT'
,p_is_required=>false
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>'select name, u_id from unit;'
,p_lov_display_extra=>true
,p_lov_display_null=>true
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(36521281480441042425)
,p_name=>'CHANGES'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CHANGES'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>160
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_interactive_grid(
 p_id=>wwv_flow_imp.id(31082125050260430647)
,p_internal_uid=>31082125050260430647
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_add_row_if_empty=>true
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_show_nulls_as=>'-'
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_download_formats=>'CSV:HTML'
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function(config) {',
'    config.defaultGridViewOptions = {',
'        tooltip: {',
'            // when the tooltip is integrated with the grid view the content callback',
'            // gets some extra helpful parameters',
'            content: function(callback, model, recordMeta, colMeta, columnDef ) {',
'                var text = null;',
'',
'                // if in/over the row header display a tooltip based on ',
'                // the record edit state metadata',
'                if (recordMeta && $(this).hasClass( "a-GV-rowHeader" ) ) {',
'                    if ( recordMeta.deleted ) {',
'                        text = "This record has been deleted";',
'                    } else if ( recordMeta.inserted ) {',
'                        text = "This record has been added";',
'                    } else if ( recordMeta.updated ) {',
'                        text = "This record has been changed";',
'                    }',
'                } else {',
'                    if ( columnDef && recordMeta) {',
'                        // if in/over the notes column put the notes in a tooltip so more of the notes can be seen',
'                        // if in/over the name column show the hire date',
'                        console.log("column->"+columnDef.property);',
'                        if ( columnDef.property === "PRODUCT" ) {',
'                            text = model.getValue( recordMeta.record, "PRODUCT" ).d;',
'                            console.log("text-->%o",text);',
'                        } /*else if ( columnDef.property === "ENAME" ) {',
'                            text = "Hire date: " + model.getValue( recordMeta.record, "HIREDATE" );',
'                        }*/',
'                    }',
'                    // if in/over any other column display a tooltip based on ',
'                    // the changed state metadata',
'                    if ( colMeta && colMeta.changed ) {',
'                        if ( text !== null) {',
'                            text += "<br>";',
'                        } else {',
'                            text = "";',
'                        }',
'                        text += "This cell has been changed";',
'                    }',
'                }',
'                return text;',
'            }',
'        }',
'    };',
'    return config;',
'}'))
);
wwv_flow_imp_page.create_ig_report(
 p_id=>wwv_flow_imp.id(31082125449894430647)
,p_interactive_grid_id=>wwv_flow_imp.id(31082125050260430647)
,p_static_id=>'563128518'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(31082125529587430647)
,p_report_id=>wwv_flow_imp.id(31082125449894430647)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(31082126608375430648)
,p_view_id=>wwv_flow_imp.id(31082125529587430647)
,p_display_seq=>0
,p_column_id=>wwv_flow_imp.id(31082126204089430647)
,p_is_visible=>true
,p_is_frozen=>true
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(31082129078723430649)
,p_view_id=>wwv_flow_imp.id(31082125529587430647)
,p_display_seq=>6
,p_column_id=>wwv_flow_imp.id(31082128639047430649)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(31082129661483430650)
,p_view_id=>wwv_flow_imp.id(31082125529587430647)
,p_display_seq=>7
,p_column_id=>wwv_flow_imp.id(31082129233277430650)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(31082130208119430650)
,p_view_id=>wwv_flow_imp.id(31082125529587430647)
,p_display_seq=>8
,p_column_id=>wwv_flow_imp.id(31082129808169430650)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(31082130870689430651)
,p_view_id=>wwv_flow_imp.id(31082125529587430647)
,p_display_seq=>10
,p_column_id=>wwv_flow_imp.id(31082130431378430650)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(31085358759451545141)
,p_view_id=>wwv_flow_imp.id(31082125529587430647)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(30891069195155540723)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(31128505183861676613)
,p_view_id=>wwv_flow_imp.id(31082125529587430647)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(30891071186441540743)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(31566741464897335028)
,p_view_id=>wwv_flow_imp.id(31082125529587430647)
,p_display_seq=>9
,p_column_id=>wwv_flow_imp.id(30891071537472540747)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(32472242758336591424)
,p_view_id=>wwv_flow_imp.id(31082125529587430647)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(31570743876426595240)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(33054029277612580933)
,p_view_id=>wwv_flow_imp.id(31082125529587430647)
,p_display_seq=>11
,p_column_id=>wwv_flow_imp.id(31570744124629595243)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(33060474351584970369)
,p_view_id=>wwv_flow_imp.id(31082125529587430647)
,p_display_seq=>12
,p_column_id=>wwv_flow_imp.id(31570744290269595244)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(33251141224087961727)
,p_view_id=>wwv_flow_imp.id(31082125529587430647)
,p_display_seq=>5
,p_column_id=>wwv_flow_imp.id(31570744657548595248)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(36975045253711395623)
,p_view_id=>wwv_flow_imp.id(31082125529587430647)
,p_display_seq=>13
,p_column_id=>wwv_flow_imp.id(36521281480441042425)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report(
 p_id=>wwv_flow_imp.id(68146154550469756507)
,p_interactive_grid_id=>wwv_flow_imp.id(31082125050260430647)
,p_name=>'Mobile'
,p_static_id=>'Mobile'
,p_type=>'ALTERNATIVE'
,p_default_view=>'GRID'
,p_authorization_scheme=>'MUST_NOT_BE_PUBLIC_USER'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(68146154630162756507)
,p_report_id=>wwv_flow_imp.id(68146154550469756507)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(68146155708950756508)
,p_view_id=>wwv_flow_imp.id(68146154630162756507)
,p_display_seq=>0
,p_column_id=>wwv_flow_imp.id(31082126204089430647)
,p_is_visible=>true
,p_is_frozen=>true
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(68146158179298756509)
,p_view_id=>wwv_flow_imp.id(68146154630162756507)
,p_display_seq=>5
,p_column_id=>wwv_flow_imp.id(31082128639047430649)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>50
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(68146158762058756510)
,p_view_id=>wwv_flow_imp.id(68146154630162756507)
,p_display_seq=>6
,p_column_id=>wwv_flow_imp.id(31082129233277430650)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>0
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(68146159308694756510)
,p_view_id=>wwv_flow_imp.id(68146154630162756507)
,p_display_seq=>8
,p_column_id=>wwv_flow_imp.id(31082129808169430650)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(68146159971264756511)
,p_view_id=>wwv_flow_imp.id(68146154630162756507)
,p_display_seq=>9
,p_column_id=>wwv_flow_imp.id(31082130431378430650)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>0
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(68149387860026871001)
,p_view_id=>wwv_flow_imp.id(68146154630162756507)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(30891069195155540723)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>100
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(68192534284437002473)
,p_view_id=>wwv_flow_imp.id(68146154630162756507)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(30891071186441540743)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>50
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(68630770565472660888)
,p_view_id=>wwv_flow_imp.id(68146154630162756507)
,p_display_seq=>9
,p_column_id=>wwv_flow_imp.id(30891071537472540747)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(69536271858911917284)
,p_view_id=>wwv_flow_imp.id(68146154630162756507)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(31570743876426595240)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>50
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(70118058378187906793)
,p_view_id=>wwv_flow_imp.id(68146154630162756507)
,p_display_seq=>11
,p_column_id=>wwv_flow_imp.id(31570744124629595243)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(70124503452160296229)
,p_view_id=>wwv_flow_imp.id(68146154630162756507)
,p_display_seq=>11
,p_column_id=>wwv_flow_imp.id(31570744290269595244)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>50
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(70315170324663287587)
,p_view_id=>wwv_flow_imp.id(68146154630162756507)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(31570744657548595248)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>50
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(74039074354286721483)
,p_view_id=>wwv_flow_imp.id(68146154630162756507)
,p_display_seq=>12
,p_column_id=>wwv_flow_imp.id(36521281480441042425)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>0
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(33627541252384007306)
,p_name=>'Select THE BILL'
,p_region_name=>'bill_overview'
,p_template=>wwv_flow_imp.id(29373897276343049048)
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'t-MediaList--showDesc:u-colors:t-MediaList--stack:t-MediaList--iconsRounded'
,p_display_point=>'REGION_POSITION_02'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select "BID",',
'   null link_class, -- ''#'' link,',
'    apex_page.get_url(p_items => ''P15_BID'', p_values => "BID") link,',
'    ''fa fa fa-truck'' icon_class,',
'    ''id=''||"BID" link_attr,',
'    null icon_color_class,',
'    case when nvl(:P15_BID,''0'') = "BID"',
'      then ''is-active'' ',
'      else '' ''',
'    end list_class,',
'    substr("NAME", 1, 50)|| '' ''||( case when length("NAME") > 50 then ''...'' end ) list_title,',
'    substr("SALE_DATE", 1, 50)||( case when length("SALE_DATE") > 50 then ''...'' end ) list_text,',
'    null list_badge',
'from "BILL" x left join supplier s on x.sid = s.sid',
'where (:P15_SEARCH is null',
'        or upper(s."NAME") like ''%''||upper(:P15_SEARCH)||''%''',
'        or upper(x."SALE_DATE") like ''%''||upper(:P15_SEARCH)||''%''',
'    )',
'order by "SALE_DATE" DESC,"CREATED" DESC'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P15_SEARCH'
,p_lazy_loading=>false
,p_query_row_template=>wwv_flow_imp.id(29373944776581049080)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(33899685284468706643)
,p_query_column_id=>1
,p_column_alias=>'BID'
,p_column_display_sequence=>1
,p_column_heading=>'Bid'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(33899685989149706650)
,p_query_column_id=>2
,p_column_alias=>'LINK_CLASS'
,p_column_display_sequence=>2
,p_column_heading=>'Link Class'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(33909489902206113901)
,p_query_column_id=>3
,p_column_alias=>'LINK'
,p_column_display_sequence=>3
,p_column_heading=>'Link'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(37329856652088929623)
,p_query_column_id=>4
,p_column_alias=>'ICON_CLASS'
,p_column_display_sequence=>10
,p_column_heading=>'Icon Class'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(33909490139469113903)
,p_query_column_id=>5
,p_column_alias=>'LINK_ATTR'
,p_column_display_sequence=>4
,p_column_heading=>'Link Attr'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(33909490287549113904)
,p_query_column_id=>6
,p_column_alias=>'ICON_COLOR_CLASS'
,p_column_display_sequence=>5
,p_column_heading=>'Icon Color Class'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(33909490307148113905)
,p_query_column_id=>7
,p_column_alias=>'LIST_CLASS'
,p_column_display_sequence=>6
,p_column_heading=>'List Class'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(33909490464708113906)
,p_query_column_id=>8
,p_column_alias=>'LIST_TITLE'
,p_column_display_sequence=>7
,p_column_heading=>'List Title'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(33909490523616113907)
,p_query_column_id=>9
,p_column_alias=>'LIST_TEXT'
,p_column_display_sequence=>8
,p_column_heading=>'List Text'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(33909490646372113908)
,p_query_column_id=>10
,p_column_alias=>'LIST_BADGE'
,p_column_display_sequence=>9
,p_column_heading=>'List Badge'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(34083636581110179813)
,p_name=>'Bill Details'
,p_region_name=>'bill_report'
,p_template=>wwv_flow_imp.id(29373922216698049066)
,p_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-AVPList--leftAligned'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select BID,',
'       name,mimetype,filename,',
'      dbms_lob.getlength(image) as img,',
'       SALE_DATE',
'  from BILL b left join supplier s on s.sid = b.sid',
' where "BID" = :P15_BID'))
,p_display_when_condition=>'P15_BID'
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>wwv_flow_imp.id(29373950962429049085)
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
 p_id=>wwv_flow_imp.id(34083636644465179814)
,p_query_column_id=>1
,p_column_alias=>'BID'
,p_column_display_sequence=>4
,p_use_as_row_header=>'N'
,p_hidden_column=>'Y'
,p_display_when_cond_type=>'EXISTS'
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 from "BILL"',
'where "BID" is not null',
'and "BID" = :P15_BID'))
,p_derived_column=>'N'
);
end;
/
begin
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(34083637304416179821)
,p_query_column_id=>2
,p_column_alias=>'NAME'
,p_column_display_sequence=>1
,p_column_heading=>'Name'
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:4:&SESSION.::&DEBUG.:RP::'
,p_column_linktext=>'#NAME#'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(34083637550818179823)
,p_query_column_id=>3
,p_column_alias=>'MIMETYPE'
,p_column_display_sequence=>5
,p_use_as_row_header=>'N'
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(34083637683996179824)
,p_query_column_id=>4
,p_column_alias=>'FILENAME'
,p_column_display_sequence=>6
,p_use_as_row_header=>'N'
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(34083637478515179822)
,p_query_column_id=>5
,p_column_alias=>'IMG'
,p_column_display_sequence=>3
,p_column_heading=>'IMAGE'
,p_use_as_row_header=>'N'
,p_column_format=>'IMAGE:BILL:IMAGE:BID::MIMETYPE:FILENAME:::::'
,p_disable_sort_column=>'N'
,p_report_column_width=>100
,p_derived_column=>'N'
,p_include_in_export=>'Y'
,p_print_col_width=>'100'
,p_ref_table_name=>'BILL'
,p_ref_column_name=>'IMAGE'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(34083636936495179817)
,p_query_column_id=>6
,p_column_alias=>'SALE_DATE'
,p_column_display_sequence=>2
,p_column_heading=>'Sale Date'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(67763719750671711532)
,p_plug_name=>'Search'
,p_region_css_classes=>'search-region padding-md'
,p_region_template_options=>'#DEFAULT#:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_imp.id(29373897098321049048)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_02'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(67964963098591563160)
,p_plug_name=>'Bills'
,p_icon_css_classes=>'fa-server-check'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(29373914838527049061)
,p_plug_display_sequence=>90
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_attribute_03=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(34093828514400321115)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(34083636581110179813)
,p_button_name=>'EDIT'
,p_button_static_id=>'edit_master_btn'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(1740165358262749)
,p_button_image_alt=>'Edit'
,p_button_position=>'EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:7:&SESSION.::&DEBUG.:RP,7:P7_BID:&P15_BID.'
,p_icon_css_classes=>'fa-pencil-square-o'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(34084794640076231760)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(67964963098591563160)
,p_button_name=>'RESET'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft:t-Button--gapRight'
,p_button_template_id=>wwv_flow_imp.id(1740165358262749)
,p_button_image_alt=>'Reset'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:9:&SESSION.:RESET:&DEBUG.:RP,6::'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(34084811107660233159)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(67964963098591563160)
,p_button_name=>'CREATE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(1740165358262749)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:RP,7::'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(33883531484673376222)
,p_name=>'P15_SEARCH'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(67763719750671711532)
,p_prompt=>'Search'
,p_placeholder=>'Search...'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(29373976918884049105)
,p_item_icon_css_classes=>'fa-search'
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34083638149307179829)
,p_name=>'P15_BID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(34083636581110179813)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(30891069569065540727)
,p_name=>'update IG for Image Upload'
,p_event_sequence=>10
,p_bind_type=>'live'
,p_bind_delegate_to_selector=>'#bill_report'
,p_bind_event_type=>'ready'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(30891069634326540728)
,p_event_id=>wwv_flow_imp.id(30891069569065540727)
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
'   $(''#main'').append(''<input style="display:none" attr="''+bid+''" type="file" id="P15_IMG''+bid+''" name="P2_IMG''+bid+''" onChange=if(this.files.length==1){updateImage(''+bid+'',false);} />'');',
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
 p_id=>wwv_flow_imp.id(30891069766170540729)
,p_name=>'uploadButton'
,p_event_sequence=>20
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'.file'
,p_bind_type=>'live'
,p_bind_delegate_to_selector=>'#bill_overview'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(30891069859012540730)
,p_event_id=>wwv_flow_imp.id(30891069766170540729)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'JAVASCRIPT_EXPRESSION'
,p_affected_elements=>'$("#P15_IMG"+this.triggeringElement.id)'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'console.log(this.triggeringElement.id); ',
'$("#P15_IMG"+this.triggeringElement.id).click();'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(30891070485762540736)
,p_name=>'calcPriceOnQuantity'
,p_event_sequence=>40
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_imp.id(31082124542882430646)
,p_triggering_element=>'QUANTITY'
,p_condition_element_type=>'COLUMN'
,p_condition_element=>'QUANTITY'
,p_triggering_condition_type=>'GREATER_THAN'
,p_triggering_expression=>'0'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(30891070556967540737)
,p_event_id=>wwv_flow_imp.id(30891070485762540736)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var g =  apex.region("item_overview").widget().interactiveGrid("getCurrentView");',
' var r = g.getSelectedRecords()[0]; ',
'console.log("getSelectedRecprds"+JSON.stringify(g.getSelectedRecords()));',
'console.log("before Total+>"+isNaN(parseFloat(g.model.getValue(r,"TOTAL"))));',
'',
'if (!isNaN(parseFloat(g.model.getValue(r,"UNIT_NET"))) ){ // || !isNaN(parseFloat(g.model.getValue(r,"UNIT_NET")))){',
unistr('    console.log("in quantity-dynamic-action->UNIT\00C4_net is Number+>this.value:"+$(this.triggeringElement).val());'),
'   // g.model.setValue(r,"TOTAL",parseFloat(parseFloat($(this.triggeringElement).val())*parseFloat(g.model.getValue(r,"UNIT_GROSS"))).toFixed(2));',
'  /*  if (isNaN(parseFloat(g.model.getValue(r,"UNIT_NET")))){',
'        console.log("in units-dynamic action-> unit_net");',
'        g.model.setValue(r,"UNIT_NET",parseFloat(parseFloat(g.model.getValue(r,"UNIT_GROSS"))/((parseFloat(g.model.getValue(r,"TAXPERCENT").d)+100)/100)).toFixed(2));',
'    }*/',
'    console.log("new total:->"+parseFloat(parseFloat($(this.triggeringElement).val())*parseFloat(g.model.getValue(r,"UNIT_NET"))).toFixed(2));',
'    g.model.setValue(r,"TOTAL",parseFloat(parseFloat($(this.triggeringElement).val())*parseFloat(g.model.getValue(r,"UNIT_NET"))).toFixed(2));',
'    /*else',
'    if (!isNaN(parseFloat(g.model.getValue(r,"UNIT_NET")))){',
'        g.model.setValue(r,"UNIT_GROSS",parseFloat(parseFloat(g.model.getValue(r,"UNIT_NET"))*((parseFloat(g.model.getValue(r,"TAXPERCENT").d)+100)/100)).toFixed(2))',
'    }*/',
'    ',
'}else if ( !isNaN(parseFloat(g.model.getValue(r, "TOTAL")))){',
'    console.log("in units-dynamic action-> set unit_gross and unit_net+>");',
'     var u_net = parseFloat(g.model.getValue(r,"TOTAL")) / parseFloat($(this.triggeringElement).val());',
'    //if( isNaN(parseFloat(g.model.getValue(r,"UNIT_NET")))){',
'        g.model.setValue(r,"UNIT_NET", u_net.toFixed(2));',
'   // }',
'    /*if ( !isNaN(parseFloat(g.model.getValue(r,"TAXPERCENT").d) ) && isNaN(parseFloat(g.model.getValue(r,)))){',
'        g.model.setValue(r,"UNIT_NET",parseFloat(u_gross/((parseFloat(g.model.getValue(r,"TAXPERCENT").d)+100)/100)).toFixed(2));',
'    }*/',
'}',
''))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(30891070955337540741)
,p_name=>'updatePercentOnProductSelect'
,p_event_sequence=>50
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_imp.id(31082124542882430646)
,p_triggering_element=>'PRODUCT'
,p_condition_element_type=>'COLUMN'
,p_condition_element=>'PRODUCT'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(30891071060231540742)
,p_event_id=>wwv_flow_imp.id(30891070955337540741)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'COLUMN'
,p_affected_elements=>'TAXPERCENT'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>'select t.tid from product p left join tax t on t.tid = p.tid where pid = :PRODUCT'
,p_attribute_07=>'PRODUCT'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(30891071242519540744)
,p_name=>'calcPriceOnUnit_net'
,p_event_sequence=>60
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_imp.id(31082124542882430646)
,p_triggering_element=>'UNIT_NET'
,p_condition_element_type=>'COLUMN'
,p_condition_element=>'UNIT_NET'
,p_triggering_condition_type=>'GREATER_THAN'
,p_triggering_expression=>'0'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(30891071323485540745)
,p_event_id=>wwv_flow_imp.id(30891071242519540744)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var g =  apex.region("item_overview").widget().interactiveGrid("getCurrentView");',
' var r = g.getSelectedRecords()[0]; ',
'',
'if ( !isNaN(parseFloat(g.model.getValue(r, "TAXPERCENT").d))){',
'    var u_gross = (parseFloat($(this.triggeringElement).val())*((parseFloat(g.model.getValue(r,"TAXPERCENT").d)+100)/100)).toFixed(2);',
'    console.log("in unit_net-dynamic action->unit_net value ->"+$(this.triggeringElement).val());',
'    console.log("in unit_net-dynamic action->u_gross value"+u_gross);',
'    g.model.setValue(r,"UNIT_GROSS", u_gross);',
'    if ( !isNaN(parseFloat(g.model.getValue(r,"QUANTITY")))){',
'console.log("in unit_net-dynamic action -> set Total->units value"+ g.model.getValue(r,"QUANTITY"));',
'        g.model.setValue(r,"TOTAL",(parseFloat($(this.triggeringElement).val())*parseFloat(g.model.getValue(r,"QUANTITY"))).toFixed(2));',
'    }',
'    ',
'    /*if (!isNaN(parseFloat(g.model.getValue(r,"TOTAL") ))){',
'',
'        g.model.setValue(r,"UNITS",parseFloat(g.model.getValue(r,"TOTAL")/u_gross).toFixed(0));',
'    }*/',
'}',
''))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(30891071619860540748)
,p_name=>'calcPriceOnUnit_gross'
,p_event_sequence=>70
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_imp.id(31082124542882430646)
,p_triggering_element=>'UNIT_GROSS'
,p_condition_element_type=>'COLUMN'
,p_condition_element=>'UNIT_GROSS'
,p_triggering_condition_type=>'GREATER_THAN'
,p_triggering_expression=>'0'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(30891071771051540749)
,p_event_id=>wwv_flow_imp.id(30891071619860540748)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var g =  apex.region("item_overview").widget().interactiveGrid("getCurrentView");',
' var r = g.getSelectedRecords()[0]; ',
'',
'if ( !isNaN(parseFloat(g.model.getValue(r, "TAXPERCENT").d))){',
'    var u_gross = parseFloat($(this.triggeringElement).val());',
'    var u_net = (u_gross/((parseFloat(g.model.getValue(r,"TAXPERCENT").d)+100)/100)).toFixed(2);',
'    console.log("unit_gross->dynamic action->u_gross ->"+u_gross+"\n u_net ->"+u_net);',
'    ',
'    g.model.setValue(r,"UNIT_NET", u_net);',
'    if ( !isNaN(parseFloat(g.model.getValue(r,"QUANTITY")))){',
'console.log("in unit_net -> set Total->units is not NaN"+ g.model.getValue(r,"QUANTITY"));',
'        g.model.setValue(r,"TOTAL",(u_net*parseFloat(g.model.getValue(r,"QUANTITY"))).toFixed(2));',
'    }',
'    /*else if (!isNaN(parseFloat(g.model.getValue(r,"TOTAL") ))){',
'',
'        g.model.setValue(r,"QUANTITY",parseFloat(g.model.getValue(r,"TOTAL")/u_gross).toFixed(0));',
'    }*/',
'}',
''))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(30891071818361540750)
,p_name=>'calcPriceOn_Total'
,p_event_sequence=>80
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_imp.id(31082124542882430646)
,p_triggering_element=>'TOTAL'
,p_condition_element_type=>'COLUMN'
,p_condition_element=>'TOTAL'
,p_triggering_condition_type=>'GREATER_THAN'
,p_triggering_expression=>'0'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(31570739937578595201)
,p_event_id=>wwv_flow_imp.id(30891071818361540750)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var g =  apex.region("item_overview").widget().interactiveGrid("getCurrentView");',
' var r = g.getSelectedRecords()[0]; ',
'//console.log("this is a trigger ->"+$(this.triggeringElement).isTrigger());',
'',
'if ( !isNaN(parseFloat(g.model.getValue(r,"QUANTITY")))){',
'    var totalBefore =  (parseFloat(g.model.getValue(r,"UNIT_NET"))*parseFloat(g.model.getValue(r,"QUANTITY"))).toFixed(2);',
'   console.log("in total-dynamic-action => this.triggeringValue and getValueTotal =>"+$(this.triggeringElement).val()+"-"+g.model.getValue(r,"TOTAL"));',
'    if($(this.triggeringElement).val() != g.model.getValue(r,"TOTAL")){',
'        console.log("in total dynamic-action ->this.TriggeringElement and now "+$(this.triggeringElement).val()+"-"+g.model.getValue(r,"TOTAL"));',
'        console.log("in total dynamic-action this triggeringElement ->"+$(this.triggeringElement).val());',
'        g.model.setValue(r,"UNIT_NET",(parseFloat($(this.triggeringElement).val())/parseFloat(g.model.getValue(r,"QUANTITY"))).toFixed(2));',
'         console.log("in total-dynamic-action -> u_gross"+g.model.getValue(r,"UNIT_GROSS"));',
'        if(!isNaN(parseFloat(g.model.getValue(r,"TAXPERCENT")))){',
'            g.model.setValue(r,"UNIT_GROSS",(parseFloat(g.model.getValue(r,"UNIT_NET"))*((parseFloat(g.model.getValue(r,"TAXPERCENT"))+100)/100)).toFixed(2));',
'        }',
'    }',
'}',
'',
'',
''))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(33909491071158113912)
,p_name=>'performSearch'
,p_event_sequence=>100
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P15_SEARCH'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'this.browserEvent.which === apex.jQuery.ui.keyCode.ENTER'
,p_bind_type=>'bind'
,p_bind_event_type=>'keypress'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(33909491126238113913)
,p_event_id=>wwv_flow_imp.id(33909491071158113912)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(33627541252384007306)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(33909491248502113914)
,p_event_id=>wwv_flow_imp.id(33909491071158113912)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CANCEL_EVENT'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(33909491312624113915)
,p_name=>'select bill'
,p_event_sequence=>110
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'#bill_overview a'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(33909491694261113918)
,p_event_id=>wwv_flow_imp.id(33909491312624113915)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P15_BID'
,p_attribute_01=>'JAVASCRIPT_EXPRESSION'
,p_attribute_05=>'this.triggeringElement.id'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(34313153322528565303)
,p_name=>'show uploaded items'
,p_event_sequence=>120
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(67964963098591563160)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(34313153457151565304)
,p_event_id=>wwv_flow_imp.id(34313153322528565303)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(31082124542882430646)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(34083638039958179828)
,p_event_id=>wwv_flow_imp.id(34313153322528565303)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(33627541252384007306)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(34083639629365179844)
,p_event_id=>wwv_flow_imp.id(34313153322528565303)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$("img").css("width","150px");',
'   $("img").addClass(''tooltipImg'');'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(34083639126485179839)
,p_name=>'showChanges'
,p_event_sequence=>130
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(34083636581110179813)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(34083639276726179840)
,p_event_id=>wwv_flow_imp.id(34083639126485179839)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(34083636581110179813)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(34083639346526179841)
,p_event_id=>wwv_flow_imp.id(34083639126485179839)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(33627541252384007306)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(34083639957570179847)
,p_name=>'optimize image size'
,p_event_sequence=>140
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(34083636581110179813)
,p_bind_type=>'live'
,p_bind_event_type=>'load'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(34083640041138179848)
,p_event_id=>wwv_flow_imp.id(34083639957570179847)
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
 p_id=>wwv_flow_imp.id(36520779179854042402)
,p_name=>'setValues'
,p_event_sequence=>150
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(67964963098591563160)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(36520779273705042403)
,p_event_id=>wwv_flow_imp.id(36520779179854042402)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P15_BID'
,p_attribute_01=>'DIALOG_RETURN_ITEM'
,p_attribute_09=>'Y'
,p_attribute_10=>'P15_BID'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(31082131028239430651)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(31082124542882430646)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Items - Save Interactive Grid Data'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'N'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(30891070298924540734)
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
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(31570743732889595239)
,p_process_sequence=>40
,p_process_point=>'ON_DEMAND'
,p_region_id=>wwv_flow_imp.id(31082124542882430646)
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'EXIST_PRODUCT'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    l_pid number := 0;',
'    l_name VARCHAR2(100);',
'    l_unit VARCHAR2(30);',
'    l_qnt number;',
'    l_unit_net number;',
'    l_tid number;',
'    l_differance number;',
'    l_total number;',
'    l_unit_gross number;',
'    l_bid number;',
'    l_msg varchar2(200);',
'   -- l_unit_gross number;',
'    l_percent number;',
'    l_exist_billitem number;',
'    l_dif_name number;',
'    l_unit_id number;',
'    --l_changedPrice_biid number;',
'   -- l_dif_price number;',
'BEGIN',
'    l_name := apex_application.g_x01;',
'    l_unit := apex_application.g_x02;',
'    l_qnt := apex_application.g_x03;',
'    l_unit_net := apex_application.g_x04;',
'    l_total := apex_application.g_x05;',
'    l_bid := apex_application.g_x06;',
'    l_percent := apex_application.g_x07;',
'    l_msg := ''nothing happend.'';',
'    ',
'    BEGIN',
'        SELECT pid,tid,UTL_MATCH.edit_distance(UPPER(l_name), UPPER(name)) AS ed,LENGTH(NAME) INTO l_pid,l_tid,l_differance,l_dif_name FROM   product order by ed fetch first 1 row only;',
'        EXCEPTION when others then',
'            l_differance := 4; ',
'    END;',
'    if l_differance > 3 THEN ',
'        l_msg := ''->in differance > 3'';',
'        select tid INTO l_tid from tax where percent = l_percent;',
'        insert into product(name,tid,notes) VALUES(l_name,l_tid,''readen from OCR'') RETURNING pid INTO l_pid;',
'    elsif l_differance > 0 THEN',
'        l_msg := ''in differance > 0'';',
'        update product set notes = l_name || '','' || (select notes from product where pid = l_pid) where pid = l_pid;',
'        ',
'    else ',
'        l_msg := ''in differance == 0'';',
'        select pid INTO l_pid from product where name = l_name;',
'    end if;',
'    ',
'   ',
'    ',
'    BEGIN',
'        select u_id INTO l_unit_id from unit where UPPER(name) = UPPER(l_unit);',
'        ',
'        EXCEPTION when others then',
'            INSERT INTO unit(name) VALUES(l_unit) RETURNING u_id INTO l_unit_id;',
'    end;',
'    ',
'    select count(*) INTO l_exist_billitem from billitem where pid = l_pid AND bid = l_bid;',
'    ',
'    if l_exist_billitem > 0 then',
'        update billitem set quantity = quantity+l_qnt where pid = l_pid AND bid = l_bid;',
'    else',
'        insert into billitem(bid,pid,u_id,quantity,unit_net,unit_gross,total) VALUES(l_bid,l_pid,l_unit_id,l_qnt,l_unit_net,round((l_unit_net*((100+l_percent)/100)),2),l_total) ;',
'    end if;',
'    ',
'    apex_json.open_object;',
'    apex_json.write(''result'',''success'');',
'    apex_json.write(''err'',SQLERRM||''------>msg:''||l_msg||''--bid:''||l_bid||''=>''||l_pid||''-->''||l_unit||''--->''||l_qnt||''-''||l_unit_net||''-''||(l_unit_net*((100+l_percent)/100))||''-''||l_total);',
'    --apex_json.write(''tid'',l_tid);',
'    apex_json.close_object;',
'',
'    exception',
'        when OTHERS then',
'            apex_json.open_object;',
'            apex_json.write(''result'',SQLERRM||''------>msg:''||l_msg||''--bid:''||l_bid||''=>''||l_pid||''-->''||l_unit||''--->''||l_qnt||''-''||l_unit_net||''-''||(l_unit_net*((100+l_percent)/100))||''-''||l_total);',
'            apex_json.close_object;',
'',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
