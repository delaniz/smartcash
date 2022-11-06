prompt --application/pages/page_00005
begin
wwv_flow_imp_page.create_page(
 p_id=>5
,p_user_interface_id=>wwv_flow_imp.id(37627114721722786135)
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
'',
'$(document).ready(function() {',
'',
'    $(''#P5_IMG'').change(function(evt) {',
'',
'        var files = evt.target.files;',
'        var file = files[0];',
'        console.log(file);',
'        if (file) {',
'            var reader = new FileReader();',
'            reader.onload = function(e) {',
'                console.log(e);',
'                 document.getElementById(''preview'').src = e.target.result;',
'            ',
'            };',
'            reader.readAsDataURL(file);',
'              ResizeImage();',
'        }',
'    });',
'});',
'',
'function getArrayOfPreview(file,base64mini){',
'    $(".u-Processing").show();',
'    var filesToUploads = document.getElementById(''P5_IMG'').files;',
'        var file = filesToUploads[0];',
'        if (file) {',
'',
'            var reader = new FileReader();',
'            // Set the image once loaded into file reader',
'            reader.onload = function(e) {',
'                var base64 = binaryArray2base64(e.target.result);',
'                var f01Array = [];',
'                f01Array = clob2Array(base64, 30000, f01Array);',
'',
'                console.log("f01Array of arrayFile"+f01Array);',
'                postData(''upload_img''',
'                        ,file.name',
'                        ,file.type',
'                        ,$v("P5_IMG_ID")',
'                        ,f01Array',
'                        ,base64mini);',
'            };',
'            reader.readAsArrayBuffer(file);',
'',
'        }',
'}',
'',
'function ResizeImage() {',
'    /*if (window.File && window.FileReader && window.FileList && window.Blob) {*/',
'        var filesToUploads = document.getElementById(''P5_IMG'').files;',
'        var file = filesToUploads[0];',
'        if (file) {',
'',
'            var reader = new FileReader();',
'            // Set the image once loaded into file reader',
'            reader.onload = function(e) {',
'',
'                var img = document.createElement("img");',
'                img.src = e.target.result;',
'',
'                var canvas = document.createElement("canvas");',
'                var ctx = canvas.getContext("2d");',
'                ctx.drawImage(img, 0, 0);',
'',
'                var MAX_WIDTH = 256;',
'                var MAX_HEIGHT = 256;',
'                var width = img.width;',
'                var height = img.height;',
'',
'                if (width > height) {',
'                    if (width > MAX_WIDTH) {',
'                        height *= MAX_WIDTH / width;',
'                        width = MAX_WIDTH;',
'                    }',
'                } else {',
'                    if (height > MAX_HEIGHT) {',
'                        width *= MAX_HEIGHT / height;',
'                        height = MAX_HEIGHT;',
'                    }',
'                }',
'                canvas.width = width;',
'                canvas.height = height;',
'                var ctx = canvas.getContext("2d");',
'                ctx.drawImage(img, 0, 0, width, height);',
'',
'                dataurl = canvas.toDataURL(file.type);',
'                var base64 = dataurl.split('';base64,'')[1];',
'           ',
'                document.getElementById(''P5_IMG'').src = dataurl;',
'                console.log(''dataurl: +''+dataurl);',
'                ',
'                ',
'              ',
'               // getArrayOfPreview(file,base64);',
'               postData(''upload_img''',
'                        ,file.name',
'                        ,file.type',
'                        ,$v("P5_IMG_ID")',
'                        ,base64);',
'            }    ',
'            ',
'            reader.readAsDataURL(file);',
'',
'        }',
'',
'   /* } else {',
'        alert(''The File APIs are not fully supported in this browser.'');',
'    }*/',
'}',
'',
'function postData(url,p1,p2,p3,f1){',
'     apex.server.process(',
'          url,',
'          {',
'            x01: p1,',
'            x02: p2,',
'            x03: p3,',
'            f01: f1,',
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
'                $(".u-Processing").hide();',
'              ',
'                apex.message.showPageSuccess( "Image saved!" );',
'              } else {',
'                alert(''Oops! Something went terribly wrong. Please try again or contact your application administrator.'');',
'              }',
'            }',
'          }',
'        );',
'}',
''))
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'02'
,p_last_updated_by=>'MACDENIZ'
,p_last_upd_yyyymmddhh24miss=>'20220624175625'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(37649555121450730721)
,p_plug_name=>'Create Form'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(37627008146725786055)
,p_plug_display_sequence=>10
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ID,',
'       COMPANY_ID,',
'       NAME,',
'       PRICE,',
'       TAX_ID,',
'       CATEGORY_ID,',
'       IMG_ID,',
'       ''<img id="preview" height=128 width=128 src=f?p=&APP_ID.:0:&APP_SESSION.:APPLICATION_PROCESS=GETIMAGE:::FILE_ID:''||IMG_ID||''  />'' ',
'       as ActualImage',
'  from SC_ARTICLE'))
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(37649558985151730724)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(37627009124693786056)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(37649559429713730725)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(37649558985151730724)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(37627090985680786117)
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(37649561038597730727)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(37649558985151730724)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(37627090985680786117)
,p_button_image_alt=>'Delete'
,p_button_position=>'DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P5_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(37649561438622730727)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(37649558985151730724)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(37627090985680786117)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'NEXT'
,p_button_condition=>'P5_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(37649561801441730728)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(37649558985151730724)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(37627090985680786117)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'NEXT'
,p_button_condition=>'P5_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1350162686188554)
,p_name=>'P5_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(37649555121450730721)
,p_item_source_plug_id=>wwv_flow_imp.id(37649555121450730721)
,p_prompt=>'#ID'
,p_source=>'ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_imp.id(37627089898381786115)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
,p_attribute_05=>'PLAIN'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1180954257520461)
,p_name=>'P5_COMPANY_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(37649555121450730721)
,p_item_source_plug_id=>wwv_flow_imp.id(37649555121450730721)
,p_source=>'COMPANY_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1181317560520464)
,p_name=>'P5_CATEGORY_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(37649555121450730721)
,p_item_source_plug_id=>wwv_flow_imp.id(37649555121450730721)
,p_prompt=>'Category'
,p_source=>'CATEGORY_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'select name d, id r from sc_category'
,p_cHeight=>1
,p_field_template=>wwv_flow_imp.id(37627089898381786115)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(37649555926759730722)
,p_name=>'P5_NAME'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(37649555121450730721)
,p_item_source_plug_id=>wwv_flow_imp.id(37649555121450730721)
,p_prompt=>'Name'
,p_source=>'NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>500
,p_field_template=>wwv_flow_imp.id(37627090224500786116)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(37649556359833730722)
,p_name=>'P5_PRICE'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(37649555121450730721)
,p_item_source_plug_id=>wwv_flow_imp.id(37649555121450730721)
,p_prompt=>'Price'
,p_format_mask=>'&CURRENCYFORMAT.'
,p_source=>'PRICE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_imp.id(37627090224500786116)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_encrypt_session_state_yn=>'N'
,p_attribute_03=>'right'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(37649556692456730723)
,p_name=>'P5_TAX_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(37649555121450730721)
,p_item_source_plug_id=>wwv_flow_imp.id(37649555121450730721)
,p_prompt=>'MwSt'
,p_source=>'TAX_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'select name,id from sc_tax;'
,p_cHeight=>1
,p_field_template=>wwv_flow_imp.id(37627089898381786115)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(37649557155359730723)
,p_name=>'P5_IMG_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(37649555121450730721)
,p_item_source_plug_id=>wwv_flow_imp.id(37649555121450730721)
,p_source=>'IMG_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>0
,p_tag_attributes=>'style=''display:none''; '
,p_field_template=>wwv_flow_imp.id(37627089898381786115)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_encrypt_session_state_yn=>'N'
,p_attribute_03=>'right'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(37655644001392924261)
,p_name=>'P5_IMG'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(37649555121450730721)
,p_prompt=>'Image'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(37627089898381786115)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'APEX_APPLICATION_TEMP_FILES'
,p_attribute_09=>'SESSION'
,p_attribute_10=>'N'
,p_attribute_12=>'NATIVE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(37655646994779924291)
,p_name=>'P5_ACTUALIMAGE'
,p_source_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(37649555121450730721)
,p_item_source_plug_id=>wwv_flow_imp.id(37649555121450730721)
,p_prompt=>'Actualimage'
,p_source=>'ACTUALIMAGE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_imp.id(37627089898381786115)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
,p_attribute_05=>'HTML'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(37649559507736730725)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(37649559429713730725)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(37649560300837730726)
,p_event_id=>wwv_flow_imp.id(37649559507736730725)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(1181171691520463)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'SET COMPANY_ID'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_ID := COALESCE(:P5_ID,SEQ_ID.NEXTVAL);',
':P5_COMPANY_ID := COALESCE(:P5_COMPANY_ID,API_SMARTCASH.GET_COMPANY_ID(V(''APP_USER'')));'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(37649562679570730728)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(37649555121450730721)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Create Form'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(37649563077832730729)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(37649562284848730728)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(37649555121450730721)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Create Form'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(37655644523873924266)
,p_process_sequence=>60
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'upload_img'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'  l_blob blob;',
'  l_blob_mini blob;',
'  l_filename varchar2(200);',
'  l_mimetype varchar2(200);',
'  l_token varchar2(32000);',
'  l_img_id number;',
' -- l_insert number;',
'  v_msg varchar2(4000);',
'  l_md5 varchar2(32767);',
'begin  ',
'  l_filename := apex_application.g_x01;',
'  l_mimetype := nvl(apex_application.g_x02, ''application/octet-stream'');',
'  l_img_id := apex_application.g_x03;',
'    ',
' -- logger.log(''l_blob'',''upload_process'',dbms_lob.substr(l_blob),null);',
'  --l--ogger.log(''l_blob_mini'',''upload_process'',l_blob_mini);',
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
'',
'    dbms_lob.createtemporary(l_blob_mini, false, dbms_lob.session);',
'  for i in 1 .. apex_application.g_f01.count loop',
'    l_token := wwv_flow.g_f01(i);',
'    if length(l_token) > 0 then',
'      dbms_lob.append(',
'        dest_lob => l_blob_mini,',
'        src_lob => to_blob(utl_encode.base64_decode(utl_raw.cast_to_raw(l_token)))',
'      );',
'    end if;',
'  end loop;',
' --print retrieven value',
'',
'  /*logger.log(''l_blob'',''upload_process'',l_blob);',
'  logger.log(''l_blob_mini'',''upload_process'',l_blob_mini);*/',
'  -- update product or save the blob in temp table (only if BLOB is not null)',
'  if dbms_lob.getlength(l_blob) is not null then',
'    l_img_id :=API_SMARTCASH.SAVE_IMAGE(l_filename',
'                                        ,l_mimetype',
'                                        ,l_blob_mini',
'                                        ,l_img_id);',
'',
'  end if;',
'',
'',
'    select standard_hash(apex_application.g_x04, ''MD5'')||''__''||standard_hash(UPPER(apex_application.g_x04), ''MD5'')||''__''||standard_hash(LOWER(apex_application.g_x04), ''MD5'') INTO l_md5 from dual;',
'   /*  l_md5 := DBMS_OUTPUT. DBMS_CRYPTO.HASH(',
'            src => apex_application.g_x04,',
'            typ => DBMS_CRYPTO.HASH_MD5',
'        );',
'    */',
' apex_json.open_object;',
' apex_json.write(',
'     p_name => ''l_blob'',',
'     p_value => length(l_blob)',
' );',
' apex_json.write(',
'     p_name => ''l_blob_mini'',',
'     p_value => length(l_blob_mini)',
' );',
' apex_json.write(',
'     p_name => ''blob_id'',',
'     p_value => l_img_id',
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
