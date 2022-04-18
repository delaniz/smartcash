prompt --application/pages/page_00005
begin
wwv_flow_imp_page.create_page(
 p_id=>5
,p_user_interface_id=>wwv_flow_imp.id(37628517236709248794)
,p_name=>'Article Edit'
,p_page_mode=>'MODAL'
,p_step_title=>'Article Edit'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';',
'',
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
'function updateImage(){',
'   var file = document.getElementById("P5_IMG").files[0];',
'  // console.log("id ->"+id);',
'   // console.log("newRow->"+newRow);',
'  var insert = $("#P5_IMG_ID").val()==""?1:0;',
'    //if($("#"+id).parent().prev().html().length < 2){',
'      //  console.log("imageColumn is empty");',
'      //  $("#P5_ART_IMG").parent().append(''<img id="img_art" style="border: 4px solid #CCC; -moz-border-radius: 4px; -webkit-border-radius: 4px;" src="" height="75" width="75">'') ',
'      //  $("#"+id).find(".t-Button-label").html("Change");',
'    //}',
'    console.log("insert value is "+insert);',
' ',
'      ',
'  apex.util.showSpinner();',
' ',
'',
' ',
'  var reader = new FileReader();',
'  ',
'  reader.onload = (function(pFile) {',
'    return function(e) {',
'      if (pFile) {',
'        var base64 = binaryArray2base64(e.target.result);',
'        var f01Array = [];',
'        f01Array = clob2Array(base64, 30000, f01Array);',
'        ',
'      ',
'          console.log("files -> %o",e);',
'   ',
'        console.log("content of image -> %0",base64);',
'         console.log("data->"+file.name+"--"+file.type+"--"+insert+"--"+f01Array);',
'        apex.server.process(',
'          ''upload_img'',',
'          {',
'            x01: file.name,',
'            x02: file.type,',
'            x03: $v(''P5_IMG_ID'')==""?0:$v(''P5_IMG_ID''),',
'            x04: e.target.result,',
'            f01: f01Array',
'          },',
'          {',
'            dataType: ''json'',',
'            success: function(data) {',
'                console.log("in success before result..%o",data);',
'              if (data.result == ''success'') {',
'                console.log("hash ->"+data.md5);',
'                 if(typeof data.blob_id != "undefined" ){ // IF BLOB FILE SAVED',
'                    console.log(''image saved and id ->''+data.blob_id.toString());',
'                    $s(''P5_IMG_ID'',data.blob_id.toString());',
'                         ',
'                    ',
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
'      $("#P5_ACTUALIMAGE_DISPLAY>img").attr("src",e.target.result);',
'    }); ',
'    htmlReader.readAsDataURL(file );',
'    ',
'',
'}',
''))
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'02'
,p_last_updated_by=>'D.KALDI@ME.COM'
,p_last_upd_yyyymmddhh24miss=>'20220416161553'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(37650957636437193380)
,p_plug_name=>'Create Form'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(37628410661712248714)
,p_plug_display_sequence=>10
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select AID,',
'       NAME,',
'       PRICE,',
'       TAX_ID,',
'       IMG_ID,',
'       ''<img src=f?p=&APP_ID.:0:&APP_SESSION.:APPLICATION_PROCESS=GETIMAGE:::FILE_ID:''||IMG_ID||'' width=75 height=75 />'' as ActualImage',
'  from SC_ARTICLE'))
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(37650961500138193383)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(37628411639680248715)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(37650961944700193384)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(37650961500138193383)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(37628493500667248776)
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(37650963553584193386)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(37650961500138193383)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(37628493500667248776)
,p_button_image_alt=>'Delete'
,p_button_position=>'DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P5_AID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(37650963953609193386)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(37650961500138193383)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(37628493500667248776)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'NEXT'
,p_button_condition=>'P5_AID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(37650964316428193387)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(37650961500138193383)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(37628493500667248776)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'NEXT'
,p_button_condition=>'P5_AID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(37650958065342193380)
,p_name=>'P5_AID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(37650957636437193380)
,p_item_source_plug_id=>wwv_flow_imp.id(37650957636437193380)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Aid'
,p_source=>'AID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(37628492413368248774)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(37650958441746193381)
,p_name=>'P5_NAME'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(37650957636437193380)
,p_item_source_plug_id=>wwv_flow_imp.id(37650957636437193380)
,p_prompt=>'Name'
,p_source=>'NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>500
,p_field_template=>wwv_flow_imp.id(37628492739487248775)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(37650958874820193381)
,p_name=>'P5_PRICE'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(37650957636437193380)
,p_item_source_plug_id=>wwv_flow_imp.id(37650957636437193380)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Price'
,p_source=>'PRICE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_cHeight=>1
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(37628492739487248775)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_encrypt_session_state_yn=>'N'
,p_attribute_03=>'right'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(37650959207443193382)
,p_name=>'P5_TAX_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(37650957636437193380)
,p_item_source_plug_id=>wwv_flow_imp.id(37650957636437193380)
,p_prompt=>'Tax'
,p_source=>'TAX_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'select name,tid from sc_tax;'
,p_cHeight=>1
,p_field_template=>wwv_flow_imp.id(37628492413368248774)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(37650959670346193382)
,p_name=>'P5_IMG_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(37650957636437193380)
,p_item_source_plug_id=>wwv_flow_imp.id(37650957636437193380)
,p_source=>'IMG_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>0
,p_tag_attributes=>'style=''display:none''; '
,p_field_template=>wwv_flow_imp.id(37628492413368248774)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_encrypt_session_state_yn=>'N'
,p_attribute_03=>'right'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(37657046516379386920)
,p_name=>'P5_IMG'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(37650957636437193380)
,p_prompt=>'Image'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(37628492413368248774)
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'APEX_APPLICATION_TEMP_FILES'
,p_attribute_09=>'SESSION'
,p_attribute_10=>'N'
,p_attribute_12=>'NATIVE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(37657049509766386950)
,p_name=>'P5_ACTUALIMAGE'
,p_source_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(37650957636437193380)
,p_item_source_plug_id=>wwv_flow_imp.id(37650957636437193380)
,p_prompt=>'Actualimage'
,p_source=>'ACTUALIMAGE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_imp.id(37628492413368248774)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
,p_attribute_05=>'HTML'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(37650962022723193384)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(37650961944700193384)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(37650962815824193385)
,p_event_id=>wwv_flow_imp.id(37650962022723193384)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(37329859340130929650)
,p_name=>'Make It Numeric'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P5_PRICE'
,p_condition_element=>'P5_PRICE'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'live'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(37657044664982386901)
,p_event_id=>wwv_flow_imp.id(37329859340130929650)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P5_PRICE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if(/\,/.test($(''#P5_PRICE'').val())){',
'    $(''#P5_PRICE'').val($(''#P5_PRICE'').val().replace('','',''.''));',
'}'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(37657047175067386926)
,p_name=>'uploadImage'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P5_IMG'
,p_condition_element=>'P5_IMG'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'live'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(37657047287968386927)
,p_event_id=>wwv_flow_imp.id(37657047175067386926)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'updateImage();'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(37650965194557193387)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(37650957636437193380)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Create Form'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(37650965592819193388)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_attribute_01=>'P5_AID'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(37650964799835193387)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(37650957636437193380)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Create Form'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(37657047038860386925)
,p_process_sequence=>60
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'upload_img'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'  l_blob blob;',
'  l_filename varchar2(200);',
'  l_mime_type varchar2(200);',
'  l_token varchar2(32000);',
'  l_iid number;',
' -- l_insert number;',
'  v_msg varchar2(4000);',
'  l_md5 varchar2(32767);',
'begin  ',
'  l_filename := apex_application.g_x01;',
'  l_mime_type := nvl(apex_application.g_x02, ''application/octet-stream'');',
'  l_iid := apex_application.g_x03;',
'  --l_insert := apex_application.g_x04;',
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
'',
'  -- update product or save the blob in temp table (only if BLOB is not null)',
'  if dbms_lob.getlength(l_blob) is not null then',
'    if l_iid != 0 then',
'        UPDATE sc_img SET img = l_blob, mimetype = l_mime_type, filename = l_filename WHERE iid = l_iid;',
'        l_token := ''update '';',
'    else',
'        INSERT INTO sc_img(img,mimetype,filename) VALUES(l_blob,l_mime_type,l_filename) RETURNING iid INTO l_iid;',
'        l_token := ''insert'';',
'    end if;',
'  end if;',
'',
'',
'  --  select standard_hash(apex_application.g_x04, ''MD5'')||''__''||standard_hash(UPPER(apex_application.g_x04), ''MD5'')||''__''||standard_hash(LOWER(apex_application.g_x04), ''MD5'') INTO l_md5 from dual;',
'   /*  l_md5 := DBMS_OUTPUT. DBMS_CRYPTO.HASH(',
'            src => apex_application.g_x04,',
'            typ => DBMS_CRYPTO.HASH_MD5',
'        );',
'    */',
' apex_json.open_object;',
' apex_json.write(',
'     p_name => ''blob_id'',',
'     p_value => l_iid',
' );',
' apex_json.write(',
'    p_name => ''result'',',
'    p_value => ''success''',
'  );',
'  apex_json.write(',
'      p_name => ''type'',',
'      p_value => l_token',
'  );',
'  apex_json.write(',
'      p_name => ''md5'',',
'      p_value => l_md5',
'  );',
' ',
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
