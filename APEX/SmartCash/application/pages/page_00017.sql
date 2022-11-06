prompt --application/pages/page_00017
begin
wwv_flow_imp_page.create_page(
 p_id=>17
,p_user_interface_id=>wwv_flow_imp.id(37627114721722786135)
,p_name=>'Logger List'
,p_alias=>'LOGGER-LIST'
,p_step_title=>'Logger List'
,p_autocomplete_on_off=>'OFF'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#APP_IMAGES#libraries/apex/widget.splitter.js',
'#APP_IMAGES#tooltipster-master/dist/js/tooltipster.bundle.min.js',
'#APP_IMAGES#libraries/prism/prism.js',
'',
''))
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function refreshAndHighlight(){',
'    apex.region(''logHistoryReport'').refresh();',
'    apex.region(''logSearch'').refresh();',
'    $.event.trigger(''highlightRows'');',
'}'))
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'(function initSplitter(){',
'    ',
'    var splitter$ = $(''#splitterContainer'').children().first();',
'',
'    splitter$.css({''width'':''100%'',''height'':''100%''});',
'    splitter$.children().css({''overflow-y'': ''auto'', ''overflow-x'': ''hidden''});',
'    ',
'    splitter$.splitter({',
'        orientation: ''horizontal'',',
'        positionedFrom: ''end'',',
'        position: splitter$.width()/2 - 4,',
'        change: function(){',
'            splitter$.find(''.js-stickyTableHeader'').trigger(''forceresize'');',
'            console.log(''this is a change'');',
'        }',
'        ',
'    })',
'    ',
'    $(window).on(''resize'', function(){',
'        splitter$.splitter(''refresh'');',
'    });',
'    ',
'    $(''#t_TreeNav'').on(''theme42layoutchanged'', function(event, obj){',
'        setTimeout(function(){',
'            console.log(''RESIZE'')',
'            splitter$.splitter(''refresh'');',
'            splitter$.find(''.js-stickyTableHeader'').trigger(''forceresize'');',
'        },250)',
'    })',
'})();',
'',
'// call the function to activate the highlighting',
'Prism.highlightAll();',
'',
'// set the "sticky" Searhc region',
'$(''#logSearch'').stickyWidget({toggleWidth:true})',
'',
'// only allow numbers in the max row fields',
'document.querySelectorAll(''.oms-logger-max-row-num'').forEach(function(el){',
'    el.addEventListener(''input'', function(e){',
'        e.target.value = e.target.value.replace(/[^0-9.]/g,'''');',
'    });',
'});',
''))
,p_css_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#APP_IMAGES#tooltipster-master/dist/css/tooltipster.bundle.min.css',
'#APP_IMAGES#tooltipster-master/dist/css/plugins/tooltipster/sideTip/themes/tooltipster-sideTip-shadow.min.css',
'#APP_IMAGES#tooltipster-master/dist/css/plugins/tooltipster/sideTip/themes/tooltipster-sideTip-punk.min.css',
'#APP_IMAGES#libraries/prism/prism.css'))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'html {',
'    scroll-behavior: smooth;',
'}',
'',
'#logDetails pre {',
'    border-radius: 10px;',
'}',
'',
'#logSearch .apex-item-option label {',
'    margin-left: 10px;',
'}',
'',
'.log-history-not-found {',
'    width: 50%;',
'    text-align: center;',
'    font-size: 2em;',
'    margin: auto;',
'    border: 1px solid lightgray;',
'    border-radius: 10px;',
'    padding: 20px;',
'}',
'',
'.logh-color-code-container {',
'    display: flex;',
'    justify-content: space-around;',
'    width: 80%;',
'    margin: auto;',
'    height: 100%;',
'    margin-top: 10px;',
'}',
'',
'.logh-color-label {',
'    align-items: center;',
'    display: flex;',
'    width: 100%;',
'}',
'',
'.logh-box {',
'    width: 17px;',
'    height: -1px;',
'    display: inline-block;',
'    margin-left: 12px;',
'}',
'',
'.logh-blue {',
'    border: 9px solid #6d9ff9b3;',
'}',
'',
'.logh-orange {',
'    border: 9px solid #f9cb77;',
'}',
'',
'.logh-red {',
'    border: 9px solid #f37171bf;',
'}',
'',
'.logh-gray {',
'    border: 9px solid #88b1bfbf;',
'}',
'',
'#lhBackBtn{',
'    margin-left: 5px;',
'    border-radius: 5px;',
'    color: white;',
'    background-color: #5aaaf7;',
'}',
'',
'#logHistoryReport {',
'    overflow-x: auto;',
'}',
'',
'#P51_FILTER_PRE_ROWS_LABEL, #P51_FILTER_FLW_ROWS_LABEL {',
'    width: 100%;',
'}',
'',
'#P51_SELECTED_ROW_CONTAINER .t-Form-labelContainer {',
'    text-align: center;',
'}',
'',
'#P51_SELECTED_ROW {',
'    margin: auto;',
'}',
'',
'.oms-logger-cell-scroll {',
'    display: inline-block;',
'    white-space: pre-wrap;',
'    max-height: 180px;',
'    overflow-y: auto;',
'    width: 100%;',
'    position: relative;',
'}',
'',
'.oms-cell-search {',
'    position: absolute;',
'    top: 0;',
'    left: 0;',
'}',
'',
'.oms-cell-occ-highlight {',
'    background-color:orange;',
'}',
''))
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(37627118963808786144)
,p_page_component_map=>'22'
,p_last_updated_by=>'MACDENIZ'
,p_last_upd_yyyymmddhh24miss=>'20220606111318'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(11150945867452119)
,p_plug_name=>'Settings Container'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(37627008146725786055)
,p_plug_display_sequence=>21
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>2
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(59384951045616288)
,p_plug_name=>'Fitler Container'
,p_region_template_options=>'#DEFAULT#:margin-bottom-lg'
,p_plug_template=>wwv_flow_imp.id(37627008146725786055)
,p_plug_display_sequence=>31
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>10
,p_plug_display_column=>2
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(94968362694985675)
,p_plug_name=>'Logger List and Details'
,p_region_name=>'splitterContainer'
,p_region_template_options=>'#DEFAULT#'
,p_region_attributes=>'style=''width: 100%;height:700px;min-height: 500px;'''
,p_plug_template=>wwv_flow_imp.id(37627008146725786055)
,p_plug_display_sequence=>41
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(94968023911985672)
,p_plug_name=>'Logger Report'
,p_region_name=>'logGrid'
,p_parent_plug_id=>wwv_flow_imp.id(94968362694985675)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(37627032830742786074)
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select time_stamp',
'     , unit_name',
'     , scope',
'     , text',
'     , extra',
'     , id',
'     , logger_level',
'     , module',
'     , action',
'     , user_name',
'     , scn',
'     , sid',
'     , call_stack',
'  from logger_logs',
' where time_stamp >= sysdate - to_number(nvl(:P17_TIME_SELECTOR, 3))',
'   and logger_level <= :P17_DEBUG_LEVEL_SELECTOR',
';',
'     '))
,p_plug_source_type=>'NATIVE_IG'
,p_ajax_items_to_submit=>'P17_TIME_SELECTOR,P17_DEBUG_LEVEL_SELECTOR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(59384464464616283)
,p_name=>'CALL_STACK'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CALL_STACK'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Call Stack'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>130
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>4000
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
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
 p_id=>wwv_flow_imp.id(95391139002250398)
,p_name=>'TIME_STAMP'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TIME_STAMP'
,p_data_type=>'TIMESTAMP'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER'
,p_heading=>'Time stamp'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>10
,p_value_alignment=>'CENTER'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_is_required=>true
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(95391286698250399)
,p_name=>'UNIT_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'UNIT_NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Unit name'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>20
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>255
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(95391358441250400)
,p_name=>'SCOPE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SCOPE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Scope'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>30
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>1000
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>false
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(95391432040250401)
,p_name=>'TEXT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TEXT'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Text'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>40
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>4000
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>false
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(95391578457250402)
,p_name=>'EXTRA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EXTRA'
,p_data_type=>'CLOB'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Extra'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>50
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
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
 p_id=>wwv_flow_imp.id(95391608292250403)
,p_name=>'ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Id'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>60
,p_value_alignment=>'LEFT'
,p_attribute_02=>'VALUE'
,p_attribute_05=>'PLAIN'
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
 p_id=>wwv_flow_imp.id(95391726896250404)
,p_name=>'LOGGER_LEVEL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'LOGGER_LEVEL'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Logger level'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>70
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_is_required=>true
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(95391844702250405)
,p_name=>'MODULE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'MODULE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Module'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>80
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>100
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>false
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(95391980080250406)
,p_name=>'ACTION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ACTION'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Action'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>90
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>100
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>false
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(95392071335250407)
,p_name=>'USER_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'USER_NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'User name'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>100
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>255
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>false
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(95392096452250408)
,p_name=>'SCN'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SCN'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Scn'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>110
,p_value_alignment=>'RIGHT'
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
 p_id=>wwv_flow_imp.id(95392204641250409)
,p_name=>'SID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Sid'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>120
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_interactive_grid(
 p_id=>wwv_flow_imp.id(95391073421250397)
,p_internal_uid=>104770920002914354
,p_is_editable=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_show_nulls_as=>'-'
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SET'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_enable_save_public_report=>true
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_enable_mail_download=>true
,p_fixed_header=>'REGION'
,p_fixed_header_max_height=>700
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_imp_page.create_ig_report(
 p_id=>wwv_flow_imp.id(95420274058553767)
,p_interactive_grid_id=>wwv_flow_imp.id(95391073421250397)
,p_static_id=>'322361'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(95420355552553767)
,p_report_id=>wwv_flow_imp.id(95420274058553767)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(59414498498077400)
,p_view_id=>wwv_flow_imp.id(95420355552553767)
,p_display_seq=>13
,p_column_id=>wwv_flow_imp.id(59384464464616283)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(95420799527553768)
,p_view_id=>wwv_flow_imp.id(95420355552553767)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(95391139002250398)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>144
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(95421301262553770)
,p_view_id=>wwv_flow_imp.id(95420355552553767)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(95391286698250399)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(95421807894553771)
,p_view_id=>wwv_flow_imp.id(95420355552553767)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(95391358441250400)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(95422317747553772)
,p_view_id=>wwv_flow_imp.id(95420355552553767)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(95391432040250401)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(95422884115553774)
,p_view_id=>wwv_flow_imp.id(95420355552553767)
,p_display_seq=>5
,p_column_id=>wwv_flow_imp.id(95391578457250402)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(95423395508553775)
,p_view_id=>wwv_flow_imp.id(95420355552553767)
,p_display_seq=>6
,p_column_id=>wwv_flow_imp.id(95391608292250403)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(95423796436553776)
,p_view_id=>wwv_flow_imp.id(95420355552553767)
,p_display_seq=>7
,p_column_id=>wwv_flow_imp.id(95391726896250404)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(95424307956553777)
,p_view_id=>wwv_flow_imp.id(95420355552553767)
,p_display_seq=>8
,p_column_id=>wwv_flow_imp.id(95391844702250405)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(95424885780553779)
,p_view_id=>wwv_flow_imp.id(95420355552553767)
,p_display_seq=>9
,p_column_id=>wwv_flow_imp.id(95391980080250406)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(95425320945553780)
,p_view_id=>wwv_flow_imp.id(95420355552553767)
,p_display_seq=>10
,p_column_id=>wwv_flow_imp.id(95392071335250407)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(95425818649553781)
,p_view_id=>wwv_flow_imp.id(95420355552553767)
,p_display_seq=>11
,p_column_id=>wwv_flow_imp.id(95392096452250408)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(95426392100553782)
,p_view_id=>wwv_flow_imp.id(95420355552553767)
,p_display_seq=>12
,p_column_id=>wwv_flow_imp.id(95392204641250409)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(94968459558985676)
,p_plug_name=>'Details'
,p_parent_plug_id=>wwv_flow_imp.id(94968362694985675)
,p_region_template_options=>'#DEFAULT#:t-Region--hiddenOverflow'
,p_region_attributes=>'style="min-height:700px;"'
,p_plug_template=>wwv_flow_imp.id(37627033949633786074)
,p_plug_display_sequence=>30
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(59384495779616284)
,p_plug_name=>'Log Data Details'
,p_region_name=>'logDetails'
,p_parent_plug_id=>wwv_flow_imp.id(94968459558985676)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(37627008146725786055)
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_source_type=>'PLUGIN_COM.FOS.STATIC_CONTENT'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'     Text',
'</p>',
'<pre class="line-numbers"><code class="lang-sql">&P17_LOG_TEXT.</code></pre>',
'',
'',
'',
'<p>',
'    Extra  ',
'</p>',
'<pre class="line-numbers"><code class="lang-sql">&P17_LOG_EXTRA.</code></pre>',
'',
'<p>',
'    Code Peek',
'</p>',
'<pre class="line-numbers" data-start=&P17_ERROR_LINE_NUM.><code class="lang-plsql">&P17_CODE_VIEW.</code></pre>',
'',
'<p>',
'   CallStack',
'</p>',
'<pre class="line-numbers"><code class="lang-sql">&P17_LOG_CALL_STACK.</code></pre>',
'',
'<p>',
'    Action',
'</p>',
'<pre class="line-numbers"><code class="lang-sql">&P17_LOG_ACTION.</code></pre>',
''))
,p_attribute_05=>'N'
,p_attribute_06=>'N'
,p_attribute_07=>'Y'
,p_attribute_08=>'N'
,p_attribute_11=>'N'
,p_attribute_12=>'N'
,p_attribute_14=>'N'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(95388039216250367)
,p_plug_name=>'Debugger Logs '
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h1'
,p_plug_template=>wwv_flow_imp.id(37627024292360786068)
,p_plug_display_sequence=>11
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>10
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(95388286487250369)
,p_plug_name=>'Log History Container'
,p_region_name=>'logHistory'
,p_region_template_options=>'#DEFAULT#:margin-top-lg'
,p_region_attributes=>'style="min-height:100vh;"'
,p_plug_template=>wwv_flow_imp.id(37627008146725786055)
,p_plug_display_sequence=>51
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(61297579021375283)
,p_plug_name=>'Log History'
,p_parent_plug_id=>wwv_flow_imp.id(95388286487250369)
,p_region_template_options=>'#DEFAULT#:t-ContentBlock--h1'
,p_plug_template=>wwv_flow_imp.id(37627024292360786068)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>2
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(61297620432375284)
,p_plug_name=>'Log History Color Codes'
,p_parent_plug_id=>wwv_flow_imp.id(95388286487250369)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(37627008146725786055)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(95388145844250368)
,p_plug_name=>'Log History Container'
,p_parent_plug_id=>wwv_flow_imp.id(95388286487250369)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(37627008146725786055)
,p_plug_display_sequence=>30
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(59385636141616295)
,p_name=>'Log History Report'
,p_region_name=>'logHistoryReport'
,p_parent_plug_id=>wwv_flow_imp.id(95388145844250368)
,p_template=>wwv_flow_imp.id(37627008340170786055)
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--staticRowColors:t-Report--rowHighlightOff'
,p_new_grid_row=>false
,p_display_point=>'SUB_REGIONS'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select id',
'     , to_char(id) as vid',
'     , to_char(sid) as sid',
'     , time_stamp',
'     , scope',
'     , text',
'     , logger_level',
'     , action',
'     , extra',
'     , unit_name',
'     , replace(module, '':'', '';'') module',
'  from logger_logs',
' where ( id >= :P17_LOG_ID - nvl(to_number(:P17_FILTER_PRE_MAX_ROWS),10)',
'           and ',
'         time_stamp > (to_timestamp(:P17_LOG_TIMESTAMP) - numtodsinterval(nvl(to_number(:P17_FILTER_PRE_ROWS),9999999),''second''))',
'       ) ',
'   and ( id <= :P17_LOG_ID + nvl(to_number(:P17_FILTER_FLW_MAX_ROWS),30)',
'           and',
'         time_stamp < (to_timestamp(:P17_LOG_TIMESTAMP) + numtodsinterval(nvl(to_number(:P17_FILTER_FLW_ROWS),9999999),''second''))',
'       ) ',
';'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P17_LOG_ID,P17_FILTER_PRE_ROWS,P17_LOG_TIMESTAMP,P17_FILTER_FLW_ROWS,P17_FILTER_FLW_MAX_ROWS,P17_FILTER_PRE_MAX_ROWS'
,p_lazy_loading=>false
,p_query_row_template=>wwv_flow_imp.id(37627060184177786093)
,p_query_num_rows=>100
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="log-history-not-found">',
'<p>No data found</p>',
'<p>Select another row from the list above</p>',
'</div>'))
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(1291697434968402)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>1
,p_column_heading=>'Id'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(1291345034968397)
,p_query_column_id=>2
,p_column_alias=>'VID'
,p_column_display_sequence=>8
,p_use_as_row_header=>'N'
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(1290934716968396)
,p_query_column_id=>3
,p_column_alias=>'SID'
,p_column_display_sequence=>20
,p_column_heading=>'SID'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(1290495450968395)
,p_query_column_id=>4
,p_column_alias=>'TIME_STAMP'
,p_column_display_sequence=>2
,p_column_heading=>'Time Stamp'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(1290094271968395)
,p_query_column_id=>5
,p_column_alias=>'SCOPE'
,p_column_display_sequence=>3
,p_column_heading=>'Scope'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(1289732328968395)
,p_query_column_id=>6
,p_column_alias=>'TEXT'
,p_column_display_sequence=>4
,p_column_heading=>'Text'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(1289312053968394)
,p_query_column_id=>7
,p_column_alias=>'LOGGER_LEVEL'
,p_column_display_sequence=>5
,p_column_heading=>'Logger Level'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(1288927452968394)
,p_query_column_id=>8
,p_column_alias=>'ACTION'
,p_column_display_sequence=>6
,p_column_heading=>'Action'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(1288547913968393)
,p_query_column_id=>9
,p_column_alias=>'EXTRA'
,p_column_display_sequence=>7
,p_column_heading=>'Extra'
,p_use_as_row_header=>'N'
,p_column_html_expression=>'<div class="oms-logger-cell-scroll"><span>#EXTRA#</span></div>'
,p_column_css_class=>'oms-logger-cell-scroll'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(1288202425968393)
,p_query_column_id=>10
,p_column_alias=>'UNIT_NAME'
,p_column_display_sequence=>9
,p_column_heading=>'Unit Name'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(1287802708968392)
,p_query_column_id=>11
,p_column_alias=>'MODULE'
,p_column_display_sequence=>10
,p_column_heading=>'Module'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(59387089790616309)
,p_plug_name=>'Search'
,p_region_name=>'logSearch'
,p_parent_plug_id=>wwv_flow_imp.id(95388145844250368)
,p_region_template_options=>'#DEFAULT#'
,p_region_attributes=>'style="min-height:400px;max-height:90vh;overflow:auto;"'
,p_plug_template=>wwv_flow_imp.id(37627008340170786055)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>2
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_source_type=>'NATIVE_FACETED_SEARCH'
,p_filtered_region_id=>wwv_flow_imp.id(59385636141616295)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_06=>'Y'
,p_attribute_09=>'N'
,p_attribute_13=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(1309259605968459)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(11150945867452119)
,p_button_name=>'BTN_RESTART_LOOPS'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight:t-Button--gapTop'
,p_button_template_id=>wwv_flow_imp.id(37627091174184786117)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Restart Loops'
,p_icon_css_classes=>'a-Icon fa fa-2x fa-refresh refresh_job_status'
,p_button_cattributes=>'style="margin-top:25px!important;"'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
end;
/
begin
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(1287066783968391)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(59387089790616309)
,p_button_name=>'P17_SCROLL_TO_TOP_BUTTON'
,p_button_static_id=>'lhBackBtn'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(37627090985680786117)
,p_button_image_alt=>'Scroll to Top'
,p_button_position=>'NEXT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1308172310968448)
,p_name=>'P17_TIME_SELECTOR'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(59384951045616288)
,p_use_cache_before_default=>'NO'
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1/24/60 * 5',
'  from dual;'))
,p_item_default_type=>'SQL_QUERY'
,p_prompt=>'Time Selector'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ''1 minute''   d',
'     , 1/24/60      r',
'  from dual',
' union all',
'select ''5 minutes''  d',
'     , 1/24/60 * 5  r',
'  from dual',
' union all',
'select ''10 minutes'' d',
'     , 1/24/60 * 10 r',
'  from dual',
' union all',
'select ''1 hour''     d',
'     , 1/24         r',
'  from dual',
' union all',
'select ''3 hours''    d',
'     , 1/24 * 3     r',
'  from dual',
' union all',
'select ''1 day''      d',
'     , 1            r',
'  from dual',
' order by 2',
';'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Select -'
,p_cHeight=>1
,p_colspan=>2
,p_grid_column=>1
,p_field_template=>wwv_flow_imp.id(37627089859026786115)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'YES'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
,p_fc_show_label=>true
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1307804188968447)
,p_name=>'P17_DEBUG_LEVEL_SELECTOR'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(59384951045616288)
,p_use_cache_before_default=>'NO'
,p_item_default=>'2'
,p_prompt=>'Debug Level Selector'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC2:Errors ;2,All;16'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_field_template=>wwv_flow_imp.id(37627089859026786115)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'YES'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
,p_fc_show_label=>true
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1307386822968446)
,p_name=>'P17_SCROLL_TO_HISTORY'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(59384951045616288)
,p_item_default=>'N'
,p_prompt=>'Scroll To History'
,p_display_as=>'NATIVE_YES_NO'
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_field_template=>wwv_flow_imp.id(37627089859026786115)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
,p_fc_show_label=>true
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1307028803968446)
,p_name=>'P17_CP_PRE_ROWS'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(59384951045616288)
,p_item_default=>'3'
,p_prompt=>'CodePeek Num. of Pre. Rows'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC2:5;5,10;10,15;15'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_field_template=>wwv_flow_imp.id(37627089859026786115)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
,p_fc_show_label=>true
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1306549619968446)
,p_name=>'P17_CP_FLW_ROWS'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(59384951045616288)
,p_item_default=>'5'
,p_prompt=>'CodePeek Num. of Folllow. Rows'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC2:5;5,10;10,15;15'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_field_template=>wwv_flow_imp.id(37627089859026786115)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
,p_fc_show_label=>true
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1299405372968417)
,p_name=>'P17_LOG_TEXT'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(94968459558985676)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
,p_fc_show_label=>true
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1298964963968416)
,p_name=>'P17_LOG_EXTRA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(94968459558985676)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
,p_fc_show_label=>true
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1298639189968416)
,p_name=>'P17_CODE_VIEW'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(94968459558985676)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
,p_fc_show_label=>true
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1298245106968415)
,p_name=>'P17_LOG_CALL_STACK'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(94968459558985676)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
,p_fc_show_label=>true
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1297806293968415)
,p_name=>'P17_LOG_ACTION'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(94968459558985676)
,p_use_cache_before_default=>'NO'
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
,p_fc_show_label=>true
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1297419748968414)
,p_name=>'P17_LOG_ID'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(94968459558985676)
,p_use_cache_before_default=>'NO'
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
,p_fc_show_label=>true
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1297035710968414)
,p_name=>'P17_ERROR_DATA_CODEPEEK'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(94968459558985676)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
,p_fc_show_label=>true
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1296633443968413)
,p_name=>'P17_ERROR_LINE_NUM'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(94968459558985676)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
,p_fc_show_label=>true
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1296157346968413)
,p_name=>'P17_LOG_TIMESTAMP'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(94968459558985676)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
,p_fc_show_label=>true
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1294344841968408)
,p_name=>'P17_FILTER_PRE_ROWS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(61297620432375284)
,p_item_default=>'5'
,p_prompt=>'<span class="logh-color-label">Show Previous Rows From:  <span class="logh-box logh-orange"></span></span>'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC2:- 1 sec;1,- 2 sec;2,- 5 sec;5,- 10 sec;10,- 60 sec;60,- 300 sec;300'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- All - '
,p_cHeight=>1
,p_colspan=>3
,p_field_template=>wwv_flow_imp.id(37627089859026786115)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
,p_fc_show_label=>true
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1293917208968407)
,p_name=>'P17_FILTER_PRE_MAX_ROWS'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(61297620432375284)
,p_prompt=>'Max Number of Prev. Rows'
,p_source=>'10'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'oms-logger-max-row-num'
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_field_template=>wwv_flow_imp.id(37627089859026786115)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_warn_on_unsaved_changes=>'I'
,p_encrypt_session_state_yn=>'N'
,p_attribute_03=>'right'
,p_fc_show_label=>true
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1293479700968406)
,p_name=>'P17_SELECTED_ROW'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(61297620432375284)
,p_prompt=>'<span class="logh-color-label">Selected Row:  <span class="logh-box logh-red"></span></span>'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_colspan=>1
,p_field_template=>wwv_flow_imp.id(37627089859026786115)
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
,p_attribute_05=>'PLAIN'
,p_fc_show_label=>true
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1293100237968406)
,p_name=>'P17_FILTER_FLW_ROWS'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(61297620432375284)
,p_item_default=>'5'
,p_prompt=>'<span class="logh-color-label">Show Following Rows Up To:<span class="logh-box logh-gray"></span> </span> '
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC2:+ 1 sec;1,+ 2 sec;2,+ 5 sec;5,+ 10 sec;10,+ 60 sec;60,+ 300 sec;300'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- All - '
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_imp.id(37627089859026786115)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
,p_fc_show_label=>true
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1292673875968405)
,p_name=>'P17_FILTER_FLW_MAX_ROWS'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(61297620432375284)
,p_prompt=>'Max Number of Follw. Rows'
,p_source=>'30'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'oms-logger-max-row-num'
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_field_template=>wwv_flow_imp.id(37627089859026786115)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_warn_on_unsaved_changes=>'I'
,p_encrypt_session_state_yn=>'N'
,p_attribute_03=>'right'
,p_fc_show_label=>true
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1286718863968390)
,p_name=>'P17_FS_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(59387089790616309)
,p_prompt=>'Log ID'
,p_placeholder=>'Id, text, extra'
,p_source=>'VID,TEXT,EXTRA'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_SEARCH'
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'ROW'
,p_attribute_02=>'FACET'
,p_fc_show_label=>true
,p_fc_filter_values=>false
,p_fc_show_chart=>false
,p_fc_actions_filter=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1286325830968390)
,p_name=>'P17_FS_LOG_LEVEL'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(59387089790616309)
,p_prompt=>'Log Levels'
,p_source=>'LOGGER_LEVEL'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct logger_level as d',
'              , logger_level as r',
'           from logger_logs',
'          where time_stamp > sysdate - 1 / 8;'))
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'N'
,p_fc_show_label=>true
,p_fc_collapsible=>true
,p_fc_initial_collapsed=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>5
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>false
,p_fc_actions_filter=>false
,p_fc_toggleable=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1285885313968389)
,p_name=>'P17_FS_SCOPE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(59387089790616309)
,p_prompt=>'Scope'
,p_source=>'SCOPE'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct scope as d',
'              , scope as r ',
'           from logger_logs',
'          where time_stamp > sysdate - 1 / 8;'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'No Data'
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'N'
,p_fc_show_label=>true
,p_fc_collapsible=>true
,p_fc_initial_collapsed=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>5
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>false
,p_fc_actions_filter=>false
,p_fc_toggleable=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1285526477968388)
,p_name=>'P17_FS_ACTION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(59387089790616309)
,p_prompt=>'Action'
,p_source=>'ACTION'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct action as d',
'              , action as r ',
'           from logger_logs',
'          where time_stamp > sysdate - 1 / 8; '))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'No Data'
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'N'
,p_fc_show_label=>true
,p_fc_collapsible=>true
,p_fc_initial_collapsed=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>5
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>false
,p_fc_actions_filter=>false
,p_fc_toggleable=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1285101356968388)
,p_name=>'P17_FS_UNIT_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(59387089790616309)
,p_prompt=>'Unit '
,p_source=>'UNIT_NAME'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct unit_name as d',
'              , unit_name as r',
'           from logger_logs',
'          where time_stamp > sysdate - 1 / 8;'))
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'N'
,p_fc_show_label=>true
,p_fc_collapsible=>true
,p_fc_initial_collapsed=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>5
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>false
,p_fc_actions_filter=>false
,p_fc_toggleable=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1284692818968387)
,p_name=>'P17_FS_MODULE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(59387089790616309)
,p_prompt=>'Module'
,p_source=>'MODULE'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct module as d',
'              , replace(module, '':'', '';'') as r',
'           from logger_logs',
'          where time_stamp > sysdate - 1 / 8;'))
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'N'
,p_fc_show_label=>true
,p_fc_collapsible=>true
,p_fc_initial_collapsed=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>5
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>false
,p_fc_actions_filter=>false
,p_fc_toggleable=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1284322086968387)
,p_name=>'P17_FS_SID'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(59387089790616309)
,p_prompt=>'SID'
,p_source=>'SID'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct to_char(sid) as d',
'              , to_char(sid) as r',
'           from logger_logs',
'          where time_stamp > sysdate - 1 / 8;'))
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'N'
,p_fc_show_label=>true
,p_fc_collapsible=>true
,p_fc_initial_collapsed=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>5
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>false
,p_fc_actions_filter=>false
,p_fc_toggleable=>false
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(1283494776968367)
,p_name=>'Set Log Data'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(94968023911985672)
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'apex.region(''logGrid'').call(''getSelectedRecords'').length > 0'
,p_bind_type=>'bind'
,p_bind_event_type=>'NATIVE_IG|REGION TYPE|interactivegridselectionchange'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1283012521968365)
,p_event_id=>wwv_flow_imp.id(1283494776968367)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var record = this.data.selectedRecords[0];',
'// need for the history ',
'apex.item(''P17_LOG_TIMESTAMP'').setValue(this.data.model.getValue(record,''TIME_STAMP''));',
'// values to the "Details Region"',
'apex.item(''P17_LOG_TEXT'').setValue(this.data.model.getValue(record, ''TEXT''));',
'apex.item(''P17_LOG_EXTRA'').setValue(this.data.model.getValue(record, ''EXTRA''));',
'// the CodePeek needs more computations, that''s why on row-selection we just clear it first',
'apex.item(''P17_CODE_VIEW'').setValue('''');',
'apex.item(''P17_LOG_CALL_STACK'').setValue(this.data.model.getValue(record, ''CALL_STACK'').trim());',
'apex.item(''P17_LOG_ACTION'').setValue(this.data.model.getValue(record, ''ACTION''));',
'apex.item(''P17_LOG_ID'').setValue(this.data.model.getValue(record, ''ID''));',
'',
'// the package name is always in the third line',
'var errorLine = this.data.model.getValue(record, ''CALL_STACK'').split(''\n'')[2];',
'var loggerLevel = parseInt(this.data.model.getValue(record, ''LOGGER_LEVEL''), 10);',
'if(errorLine && errorLine.length > 0 ){',
'    var re;',
'    if(loggerLevel === 2){',
'        re = /"(.+?)".*?(\d+)/;',
'    }else{',
'        re = /^\S+\s+(\d+).+?(\S+\.\S+)/;',
'    }',
'    var result = errorLine.match(re);',
'    if(result && result[1].length > 0 && result[2].length > 0){',
'        if(loggerLevel === 2){',
'            var pkgName = result[1];',
'            var lineNum = result[2];',
'        }else{',
'            var pkgName = result[2];',
'            var lineNum = result[1];',
'        }',
'        var unitName = this.data.model.getValue(record, ''UNIT_NAME'');',
'        console.log(''unitName'', unitName);',
'        console.log(''pkgName'', pkgName);',
'        //if (unitName === pkgName || loggerLevel !== 2){',
'        if (!pkgName.includes(''WWV_FLOW'')){',
'            apex.item(''P17_ERROR_LINE_NUM'').setValue(parseInt(lineNum) - parseInt(apex.item(''P17_CP_PRE_ROWS'').getValue()));',
'            apex.item(''P17_ERROR_DATA_CODEPEEK'').setValue(pkgName+'':''+lineNum);',
'        } else {',
'            console.log(''The error is coming from an APEX package: ''+pkgName+''.'');',
'            // refresh the details region and initialize the code highlighting',
'            apex.region(''logDetails'').refresh();',
'            Prism.highlightAll();',
'        }',
'    } else {',
'        console.log(''Call stack does not contain the required data.'');',
'        // refresh the details region and initialize the code highlighting',
'        apex.region(''logDetails'').refresh();',
'        Prism.highlightAll();',
'    }',
'}'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(1282567400968364)
,p_name=>'Refresh Logger List - Timestamp'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P17_TIME_SELECTOR'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1282069659968363)
,p_event_id=>wwv_flow_imp.id(1282567400968364)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(94968023911985672)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(1281735701968363)
,p_name=>'Refresh Logger List - Debug Level'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P17_DEBUG_LEVEL_SELECTOR'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1281165040968362)
,p_event_id=>wwv_flow_imp.id(1281735701968363)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(94968023911985672)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(1280749612968360)
,p_name=>'Show Log History'
,p_event_sequence=>50
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P17_LOG_ID'
,p_condition_element=>'P17_SCROLL_TO_HISTORY'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'J'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1280329101968359)
,p_event_id=>wwv_flow_imp.id(1280749612968360)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// refresh the report to get the data',
'apex.item(''P17_SELECTED_ROW'').setValue(this.triggeringElement.value);',
'apex.region(''logHistoryReport'').refresh();',
'document.getElementById(''logHistory'').scrollIntoView();',
'',
'',
'',
''))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(1279861582968359)
,p_name=>'Highlight rows after filter'
,p_event_sequence=>60
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(59387089790616309)
,p_bind_type=>'bind'
,p_bind_event_type=>'NATIVE_FACETED_SEARCH|REGION TYPE|facetschange'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1279414484968358)
,p_event_id=>wwv_flow_imp.id(1279861582968359)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$.event.trigger(''highlightRows'');',
''))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(1278981211968358)
,p_name=>'Clear History Report'
,p_event_sequence=>70
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P17_SCROLL_TO_HISTORY'
,p_condition_element=>'P17_SCROLL_TO_HISTORY'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'N'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1278520113968357)
,p_event_id=>wwv_flow_imp.id(1278981211968358)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// remove the selected id',
'apex.item(''P17_SELECTED_ROW'').setValue('''');',
'apex.item(''P17_LOG_ID'').setValue('''');',
'apex.item(''P17_LOG_ID'').refresh();',
'//',
'apex.region(''logHistoryReport'').refresh();',
'//apex.region(''logSearch'').refresh();',
'apex.region(''logSearch'').fetchCounts();'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(1278142037968357)
,p_name=>'Scroll to History Report'
,p_event_sequence=>80
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P17_SCROLL_TO_HISTORY'
,p_condition_element=>'P17_SCROLL_TO_HISTORY'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'J'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1277618885968356)
,p_event_id=>wwv_flow_imp.id(1278142037968357)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var records = apex.region(''logGrid'').call(''getSelectedRecords'');',
'if (records.length > 0){',
'    var model = apex.region(''logGrid'').widget().interactiveGrid(''getViews'',''grid'').model;',
'    apex.item(''P17_LOG_ID'').setValue(model.getValue(records[0], ''ID''));',
'}'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(1277160947968356)
,p_name=>'Get Package Data to the CodePeek'
,p_event_sequence=>90
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P17_ERROR_DATA_CODEPEEK'
,p_condition_element=>'P17_ERROR_DATA_CODEPEEK'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1276710140968355)
,p_event_id=>wwv_flow_imp.id(1277160947968356)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P17_CODE_VIEW'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_err_data apex_t_varchar2 := apex_string.split(:P17_ERROR_DATA_CODEPEEK, '':'');',
'    l_pkg_name varchar2(100)   := apex_string.split(l_err_data(1), ''.'')(2);',
'    l_err_line varchar2(100)   := l_err_data(2);',
'    ',
'    l_result varchar2(32000);',
'begin',
'    ',
'    select listagg(text) within group (order by line asc)',
'      into l_result',
'      from user_source',
'     where name = l_pkg_name',
'       and type = ''PACKAGE BODY''',
'       and line >= l_err_line - :P17_CP_PRE_ROWS',
'       and line <= l_err_line + :P17_CP_FLW_ROWS',
'     order by line asc;',
'       ',
'       return l_result;',
'end;'))
,p_attribute_07=>'P17_ERROR_DATA_CODEPEEK,P17_CP_PRE_ROWS,P17_CP_FLW_ROWS'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(1276268616968354)
,p_name=>'Refresh the Details Region'
,p_event_sequence=>100
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P17_CODE_VIEW'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1275763909968354)
,p_event_id=>wwv_flow_imp.id(1276268616968354)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.region(''logDetails'').refresh();',
'Prism.highlightAll();',
''))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(1275419487968354)
,p_name=>'Highlight Rows in the Log History Report'
,p_event_sequence=>110
,p_triggering_element_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_element=>'document'
,p_bind_type=>'bind'
,p_bind_event_type=>'custom'
,p_bind_event_type_custom=>'highlightRows'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1274909214968353)
,p_event_id=>wwv_flow_imp.id(1275419487968354)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var preRowsNum = parseInt(apex.item(''P17_FILTER_PRE_MAX_ROWS'').getValue() || 10);',
'var flwRowsNum = parseInt(apex.item(''P17_FILTER_FLW_MAX_ROWS'').getValue() || 30);',
'setTimeout(function(){',
'    var selectedRow = apex.item(''P17_LOG_ID'').getValue();',
'    for (const cell of document.querySelectorAll(''#logHistoryReport td'')){',
'        if(cell.textContent == selectedRow){',
'            cell.parentNode.style.backgroundColor = ''#f37171bf'';',
'        }else if ((parseInt(cell.textContent) >= parseInt(selectedRow) - preRowsNum) && parseInt(cell.textContent) < parseInt(selectedRow)){',
'            cell.parentNode.style.backgroundColor = ''#f9cb77'';',
'        } else if ((parseInt(cell.textContent) > parseInt(selectedRow)) && parseInt(cell.textContent) <= parseInt(selectedRow) + flwRowsNum){',
'             cell.parentNode.style.backgroundColor = ''#88b1bfbf'';',
'        } else if(cell.textContent === ''2''){',
'            cell.style.color = ''red'';',
'            cell.parentNode.style.boxShadow = ''inset 0px 0px 0px 3px rgba(240,45,45,0.46)'';',
'        }',
'    }',
'}, 800);'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(1274465253968353)
,p_name=>'Scroll to Top'
,p_event_sequence=>120
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(1287066783968391)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1274026816968352)
,p_event_id=>wwv_flow_imp.id(1274465253968353)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'window.scrollTo(0,0)'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(1273585668968352)
,p_name=>'Clear Existing Erorrs'
,p_event_sequence=>130
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'localStorage.getItem(''lastLoggerError'') && localStorage.getItem(''lastLoggerError'').length > 0'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1273144527968351)
,p_event_id=>wwv_flow_imp.id(1273585668968352)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'window.clearTimeout(loggerNotify.timer);',
'loggerNotify.setLoggerStatus(false);',
'localStorage.removeItem(''lastLoggerError'');'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(1272739954968351)
,p_name=>'Refresh Log History Report - Pre Rows Filter'
,p_event_sequence=>140
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P17_FILTER_PRE_ROWS'
,p_condition_element=>'P17_SCROLL_TO_HISTORY'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'J'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1272189985968350)
,p_event_id=>wwv_flow_imp.id(1272739954968351)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'refreshAndHighlight();'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(1271817649968350)
,p_name=>'Refresh Log History Report - Pre Flw Rows Filter'
,p_event_sequence=>150
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P17_FILTER_FLW_ROWS'
,p_condition_element=>'P17_SCROLL_TO_HISTORY'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'J'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1271315187968349)
,p_event_id=>wwv_flow_imp.id(1271817649968350)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'refreshAndHighlight();'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(1270913369968349)
,p_name=>'Refresh Log History Report - Pre Rows Max Filter'
,p_event_sequence=>160
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P17_FILTER_PRE_MAX_ROWS'
,p_condition_element=>'P17_SCROLL_TO_HISTORY'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'J'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
end;
/
begin
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1270383373968348)
,p_event_id=>wwv_flow_imp.id(1270913369968349)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'refreshAndHighlight();'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(1270005563968348)
,p_name=>'Refresh Log History Report - Flw Rows Max Filter'
,p_event_sequence=>170
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P17_FILTER_FLW_MAX_ROWS'
,p_condition_element=>'P17_SCROLL_TO_HISTORY'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'J'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1269457283968347)
,p_event_id=>wwv_flow_imp.id(1270005563968348)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'refreshAndHighlight();'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(1269094980968347)
,p_name=>'Add Search Field to Cells'
,p_event_sequence=>180
,p_triggering_element_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_element=>'document'
,p_bind_type=>'bind'
,p_bind_event_type=>'custom'
,p_bind_event_type_custom=>'highlightRows'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1268642599968346)
,p_event_id=>wwv_flow_imp.id(1269094980968347)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'setTimeout(function(){',
'    let cells = document.querySelectorAll(''.oms-logger-cell-scroll'');',
'    cells.forEach((cell)=>{',
'        cell.addEventListener(''dblclick'', (e)=>{',
'            let cellEl = cell.querySelector(''span'');',
'            let cellTxt = cell.innerText;',
'            ',
'            if(cell.querySelector(''.oms-cell-search'') || cellTxt == ''-''){',
'                return;',
'            }',
'            ',
'            let searchField = document.createElement(''input'');',
'            searchField.setAttribute(''type'', ''text'');',
'            searchField.setAttribute(''placeholder'',''Search in the cell'');',
'            searchField.classList.add(''oms-cell-search'');',
'            ',
'            cell.appendChild(searchField);',
'',
'            let startIdx = 0;',
'            let foundIdxNum = 0;',
'            let foundIdx = [];',
'            searchField.addEventListener(''input'', (ev)=>{',
'                foundIdx = [];',
'                foundIdxNum = 0;',
'                let searchTxt = ev.currentTarget.value;',
'                if(ev.key == ''Enter''){',
'                    return;',
'                }',
'                if(!searchTxt && searchTxt.length == 0){',
'                    foundIdx = [];',
'                    foundIdxNum = 0;',
'                    cellEl.innerHTML = cellTxt;',
'                    return;',
'                }',
'                // get the index of the first occurence of searched value',
'                let idx = cellTxt.indexOf(searchTxt,0);',
'                let newValue;',
'                let i;',
'                // todo: replace it with recursive function',
'                if(idx >= 0){',
'                    foundIdx.push(idx);',
'                    newValue = cellTxt.substring(0,idx) + ''<span id="cellOcc''+idx+''" style="color:yellow">''+ cellTxt.substring(idx,idx+searchTxt.length) + ''</span>'';',
'                    i = idx+searchTxt.length;',
'                }',
'                while( idx >= 0){',
'                    idx = cellTxt.indexOf(searchTxt,i+1);   ',
'                    if(idx <= i){',
'                        break;',
'                    };',
'                    foundIdx.push(idx);',
'                    newValue += cellTxt.substring(i,idx) + ''<span id="cellOcc''+idx+''" style="color:yellow">''+ cellTxt.substring(idx,idx+searchTxt.length) + ''</span>'';',
'                    i = idx+searchTxt.length;',
'                }',
'                newValue += cellTxt.substring(i);',
'                cellEl.innerHTML = newValue;',
'            });',
'            ',
'            searchField.addEventListener(''keyup'', function(e){',
'                if(e.key == ''Enter'' && e.target.value.length > 0 && foundIdx.length > 0){',
'                    let target = document.getElementById(''cellOcc''+foundIdx[foundIdxNum]);',
'                    if(target){',
'                        let prevEl = document.querySelector(''.oms-cell-occ-highlight'');',
'                        if(prevEl){',
'                             prevEl.classList.remove(''oms-cell-occ-highlight'');   ',
'                        }',
'                        target.classList.add(''oms-cell-occ-highlight'');',
'                        // moves the whole page, have to update',
'                        target.scrollIntoView({block: ''nearest'', inline: ''end'', behavior: ''smooth''});',
'                        foundIdxNum = foundIdxNum >= foundIdx.length - 1 ? 0 : foundIdxNum + 1;    ',
'                    }',
'                }',
'            })',
'            ',
'            // remove the seachbar and set the cell value back to default on click outside of the cell',
'            document.documentElement.addEventListener(''click'', function x(e){',
'                if(e.target != cell && e.target != searchField && e.target != cellEl){',
'                    searchField.remove();',
'                    cellEl.innerHTML = cellTxt;',
'                    this.removeEventListener(''click'', x);',
'                }',
'            })',
'        });',
'        ',
'    });',
'},800)'))
,p_da_action_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'scrollIntoView Bug:',
'https://stackoverflow.com/questions/635706/how-to-scroll-to-an-element-inside-a-div'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(1268236743968346)
,p_name=>'Refresh Facets'
,p_event_sequence=>190
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(59385636141616295)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterrefresh'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1267680613968345)
,p_event_id=>wwv_flow_imp.id(1268236743968346)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.region(''logSearch'').fetchCounts();',
'$.event.trigger(''highlightRows'');'))
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(1283888226968368)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'PRC_RESTART_LOOPS'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  JOBS.ALL_STOP;',
'  execute immediate ''ALTER PACKAGE api_oms_order COMPILE BODY'';',
'  JOBS.ALL_START;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(1309259605968459)
,p_process_success_message=>'Job Loops restarted!'
);
end;
/
