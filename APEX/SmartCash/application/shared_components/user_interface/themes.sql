prompt --application/shared_components/user_interface/themes
begin
wwv_flow_imp_shared.create_theme(
 p_id=>wwv_flow_imp.id(37627093876816786120)
,p_theme_id=>42
,p_theme_name=>'Universal Theme'
,p_theme_internal_name=>'UNIVERSAL_THEME'
,p_ui_type_name=>'DESKTOP'
,p_navigation_type=>'L'
,p_nav_bar_type=>'LIST'
,p_reference_id=>4070917134413059350
,p_is_locked=>false
,p_default_page_template=>wwv_flow_imp.id(37627000224499786048)
,p_default_dialog_template=>wwv_flow_imp.id(37626995974840786044)
,p_error_template=>wwv_flow_imp.id(37626989387195786040)
,p_printer_friendly_template=>wwv_flow_imp.id(37627000224499786048)
,p_breadcrumb_display_point=>'REGION_POSITION_01'
,p_sidebar_display_point=>'REGION_POSITION_02'
,p_login_template=>wwv_flow_imp.id(37626989387195786040)
,p_default_button_template=>wwv_flow_imp.id(37627090985680786117)
,p_default_region_template=>wwv_flow_imp.id(37627033949633786074)
,p_default_chart_template=>wwv_flow_imp.id(37627033949633786074)
,p_default_form_template=>wwv_flow_imp.id(37627033949633786074)
,p_default_reportr_template=>wwv_flow_imp.id(37627033949633786074)
,p_default_tabform_template=>wwv_flow_imp.id(37627033949633786074)
,p_default_wizard_template=>wwv_flow_imp.id(37627033949633786074)
,p_default_menur_template=>wwv_flow_imp.id(37627043511920786080)
,p_default_listr_template=>wwv_flow_imp.id(37627033949633786074)
,p_default_irr_template=>wwv_flow_imp.id(37627032830742786074)
,p_default_report_template=>wwv_flow_imp.id(37627060184177786093)
,p_default_label_template=>wwv_flow_imp.id(37627089898381786115)
,p_default_menu_template=>wwv_flow_imp.id(37627092385605786118)
,p_default_calendar_template=>wwv_flow_imp.id(37627092550648786118)
,p_default_list_template=>wwv_flow_imp.id(37627076725015786105)
,p_default_nav_list_template=>wwv_flow_imp.id(37627085561050786112)
,p_default_top_nav_list_temp=>wwv_flow_imp.id(37627085561050786112)
,p_default_side_nav_list_temp=>wwv_flow_imp.id(37627082861117786110)
,p_default_nav_list_position=>'SIDE'
,p_default_dialogbtnr_template=>wwv_flow_imp.id(37627009124693786056)
,p_default_dialogr_template=>wwv_flow_imp.id(37627008146725786055)
,p_default_option_label=>wwv_flow_imp.id(37627089898381786115)
,p_default_required_label=>wwv_flow_imp.id(37627090224500786116)
,p_default_page_transition=>'NONE'
,p_default_popup_transition=>'NONE'
,p_default_navbar_list_template=>wwv_flow_imp.id(37627082624526786109)
,p_file_prefix => nvl(wwv_flow_application_install.get_static_theme_file_prefix(42),'#IMAGE_PREFIX#themes/theme_42/1.3/')
,p_files_version=>62
,p_icon_library=>'FONTAPEX'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.stickyWidget#MIN#.js?v=#APEX_VERSION#',
'#THEME_IMAGES#js/theme42#MIN#.js?v=#APEX_VERSION#'))
,p_css_file_urls=>'#THEME_IMAGES#css/Core#MIN#.css?v=#APEX_VERSION#'
);
end;
/
