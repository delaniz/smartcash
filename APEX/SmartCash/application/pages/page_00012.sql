prompt --application/pages/page_00012
begin
wwv_flow_imp_page.create_page(
 p_id=>12
,p_user_interface_id=>wwv_flow_imp.id(37627114721722786135)
,p_name=>'Discount'
,p_page_mode=>'MODAL'
,p_step_title=>'Discount'
,p_autocomplete_on_off=>'OFF'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.discount-but{',
'  width:60px;',
'}',
'',
'.apex-item-option input[value=''Y''][checked="checked"] + label {',
'    background-color: green;',
'}',
'',
'.apex-item-option input[value=''N''][checked="checked"] + label {',
'    background-color: red;',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_dialog_width=>'420'
,p_page_component_map=>'17'
,p_last_updated_by=>'MACDENIZ'
,p_last_upd_yyyymmddhh24miss=>'20220717184658'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(969818844255271581)
,p_plug_name=>'Discount'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(37627008146725786055)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(969819100069271584)
,p_plug_name=>'buttons'
,p_region_name=>'div_buttons'
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--slimPadding:t-ButtonRegion--noBorder'
,p_plug_template=>wwv_flow_imp.id(37627009124693786056)
,p_plug_display_sequence=>10
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(969819754952271590)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(969819100069271584)
,p_button_name=>'5b'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--padBottom'
,p_button_template_id=>wwv_flow_imp.id(37627090985680786117)
,p_button_image_alt=>'5 %'
,p_button_position=>'BELOW_BOX'
,p_button_alignment=>'LEFT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_css_classes=>'discount-but'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(1586169811016572446)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(969818844255271581)
,p_button_name=>'cancel'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--danger'
,p_button_template_id=>wwv_flow_imp.id(37627090985680786117)
,p_button_image_alt=>'Cancel'
,p_button_position=>'BELOW_BOX'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(969819848785271591)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(969819100069271584)
,p_button_name=>'10b'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--padBottom'
,p_button_template_id=>wwv_flow_imp.id(37627090985680786117)
,p_button_image_alt=>'10 %'
,p_button_position=>'BELOW_BOX'
,p_button_alignment=>'LEFT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_css_classes=>'discount-but'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(1586169685105572445)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(969818844255271581)
,p_button_name=>'save'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--large'
,p_button_template_id=>wwv_flow_imp.id(37627090985680786117)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Save'
,p_button_position=>'BELOW_BOX'
,p_button_execute_validations=>'N'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(1586169423746572442)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(969819100069271584)
,p_button_name=>'20b'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--padBottom'
,p_button_template_id=>wwv_flow_imp.id(37627090985680786117)
,p_button_image_alt=>'20 %'
,p_button_position=>'BELOW_BOX'
,p_button_alignment=>'LEFT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_css_classes=>'discount-but'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(1586169525956572443)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(969819100069271584)
,p_button_name=>'25b'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--padBottom'
,p_button_template_id=>wwv_flow_imp.id(37627090985680786117)
,p_button_image_alt=>'25 %'
,p_button_position=>'BELOW_BOX'
,p_button_alignment=>'LEFT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_css_classes=>'discount-but'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(1586169626646572444)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_imp.id(969819100069271584)
,p_button_name=>'40b'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--padBottom'
,p_button_template_id=>wwv_flow_imp.id(37627090985680786117)
,p_button_image_alt=>'40 %'
,p_button_position=>'BELOW_BOX'
,p_button_alignment=>'LEFT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_css_classes=>'discount-but'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(969819196871271585)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_imp.id(969819100069271584)
,p_button_name=>'50b'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--large'
,p_button_template_id=>wwv_flow_imp.id(37627090985680786117)
,p_button_image_alt=>'50 %'
,p_button_position=>'BOTTOM'
,p_button_alignment=>'LEFT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_css_classes=>'discount-but'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(969819310138271586)
,p_button_sequence=>70
,p_button_plug_id=>wwv_flow_imp.id(969819100069271584)
,p_button_name=>'60b'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--large'
,p_button_template_id=>wwv_flow_imp.id(37627090985680786117)
,p_button_image_alt=>'60 %'
,p_button_position=>'BOTTOM'
,p_button_alignment=>'LEFT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_css_classes=>'discount-but'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(969819404077271587)
,p_button_sequence=>80
,p_button_plug_id=>wwv_flow_imp.id(969819100069271584)
,p_button_name=>'75b'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--large'
,p_button_template_id=>wwv_flow_imp.id(37627090985680786117)
,p_button_image_alt=>'75 %'
,p_button_position=>'BOTTOM'
,p_button_alignment=>'LEFT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_css_classes=>'discount-but'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(969819540366271588)
,p_button_sequence=>90
,p_button_plug_id=>wwv_flow_imp.id(969819100069271584)
,p_button_name=>'80b'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--large'
,p_button_template_id=>wwv_flow_imp.id(37627090985680786117)
,p_button_image_alt=>'80 %'
,p_button_position=>'BOTTOM'
,p_button_alignment=>'LEFT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_css_classes=>'discount-but'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(969819620718271589)
,p_button_sequence=>100
,p_button_plug_id=>wwv_flow_imp.id(969819100069271584)
,p_button_name=>'100b'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--large'
,p_button_template_id=>wwv_flow_imp.id(37627090985680786117)
,p_button_image_alt=>'100 %'
,p_button_position=>'BOTTOM'
,p_button_alignment=>'LEFT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_css_classes=>'discount-but'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(969818927235271582)
,p_name=>'P12_DISCOUNT_VALUE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(969818844255271581)
,p_prompt=>'Discount Value'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_imp.id(37627089898381786115)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:t-Form-fieldContainer--xlarge'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(969819049806271583)
,p_name=>'P12_DISCOUNT_CAT'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(969818844255271581)
,p_item_default=>'yes'
,p_prompt=>'Discount in'
,p_display_as=>'NATIVE_YES_NO'
,p_tag_css_classes=>'t-Button--warning'
,p_grid_column_css_classes=>'discount_cat'
,p_field_template=>wwv_flow_imp.id(37627089615814786115)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:t-Form-fieldContainer--xlarge'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'percent'
,p_attribute_03=>'percent'
,p_attribute_04=>'cash'
,p_attribute_05=>'cash'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(1586169950061572447)
,p_name=>'discount  button'
,p_event_sequence=>10
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'.discount-but'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1586170023013572448)
,p_event_id=>wwv_flow_imp.id(1586169950061572447)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'let selectedBut = $(this.triggeringElement);',
'$s("P12_DISCOUNT_VALUE",selectedBut.find("span").html());',
'$("#div_buttons .t-Button--warning").removeClass(''t-Button--warning'');',
'selectedBut.addClass(''t-Button--warning'');'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(1586170184564572449)
,p_name=>'cancel'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(1586169811016572446)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1586170254365572450)
,p_event_id=>wwv_flow_imp.id(1586170184564572449)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(1351712806083175954)
,p_name=>'save discount'
,p_event_sequence=>40
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(1586169685105572445)
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>unistr('isNaN(parseFloat($("#P12_DISCOUNT_VALUE").val().replace("\20AC","").replace("%","")))')
,p_bind_type=>'live'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1351712968234175955)
,p_event_id=>wwv_flow_imp.id(1351712806083175954)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
,p_attribute_01=>'P12_DISCOUNT_VALUE'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(1351713397493175960)
,p_name=>'clear value'
,p_event_sequence=>50
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P12_DISCOUNT_VALUE'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1351713583985175961)
,p_event_id=>wwv_flow_imp.id(1351713397493175960)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('//console.log("changed value..."+$(this.triggeringElement).val().replace(/%|\20AC/gi,"")); '),
unistr('$(this.triggeringElement).val($(this.triggeringElement).val().replace(/%|\20AC| /gi,""));')))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(1351713666801175962)
,p_name=>'correct value'
,p_event_sequence=>60
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P12_DISCOUNT_VALUE'
,p_condition_element=>'P12_DISCOUNT_VALUE'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'focusout'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1351713690632175963)
,p_event_id=>wwv_flow_imp.id(1351713666801175962)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('//console.log("changed value..."+$(this.triggeringElement).val().replace(/%|\20AC/gi,""));'),
unistr('if(isNaN(parseFloat($("#P12_DISCOUNT_VALUE").val().replace("/\20AC|%| /gi","")))){'),
'    apex.message.showErrors([',
'    {',
'        type:       "error",',
'        location:   [ "page", "inline" ],',
'        pageItem:   "P12_DISCOUNT_VALUE",',
'        message:    "Value must be numeric!",',
'        unsafe:     false',
'    }',
'        ]);',
'}else{',
unistr('    $(this.triggeringElement).val(parseFloat($(this.triggeringElement).val().replace(/%|\20AC| /gi,""))+" "+($("#P12_DISCOUNT_CAT_Y").prop("checked")?"%":"\20AC"));'),
'    apex.message.clearErrors();',
'}'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(1351713863298175964)
,p_name=>'discount type'
,p_event_sequence=>70
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P12_DISCOUNT_CAT'
,p_condition_element=>'P12_DISCOUNT_VALUE'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'live'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1351713928128175965)
,p_event_id=>wwv_flow_imp.id(1351713863298175964)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'console.log("switch value..."+$(this.triggeringElement).val()); ',
'',
'let selectedCat = $(this.triggeringElement);',
'',
'$(".div_discountcat .t-Button--warning").removeClass(''t-Button--warning'');',
'selectedCat.addClass(''t-Button--warning'');',
'',
unistr('var type= ($("#P12_DISCOUNT_CAT_Y").prop("checked")?"%":"\20AC");'),
unistr('$("#P12_DISCOUNT_VALUE").val($("#P12_DISCOUNT_VALUE").val().replace(/%|\20AC| /gi,"")+" "+type);'),
'',
'$(".discount-but span").each(function(){',
unistr('    $(this).html($(this).html().replace(/%|\20AC/gi,type));'),
'});',
'',
''))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(1351714443597175970)
,p_name=>'correct discount type selection'
,p_event_sequence=>80
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1351714518229175971)
,p_event_id=>wwv_flow_imp.id(1351714443597175970)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P12_DISCOUNT_CAT'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/*let discount_val = $v("P12_DISCOUNT_VALUE");',
'console.log(''discount_val''+discount_val);',
'//$(".discount-but:contains(''"+discount_val+'')").trigger(''click'');',
'',
'//$("#P12_DISCOUNT_CAT_Y").prop("checked",true);',
'*/',
''))
,p_server_condition_type=>'NEVER'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(1351713058582175956)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'close discount'
,p_attribute_01=>'P12_DISCOUNT_VALUE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
