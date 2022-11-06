prompt --application/pages/page_00016
begin
wwv_flow_imp_page.create_page(
 p_id=>16
,p_user_interface_id=>wwv_flow_imp.id(37627114721722786135)
,p_name=>'createbillOCR'
,p_page_mode=>'MODAL'
,p_step_title=>'createbillOCR'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_javascript_file_urls=>'#APP_IMAGES#tesseractt.min.js'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var button = parent.$(''.ui-dialog-titlebar-close''); //get the button',
'button.hide(); ',
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
'function convertImage2Text(file,f01Array,base64){',
'   ',
'    apex.util.showSpinner($("#ocr_result"));',
'    ',
'    var b64 = base64.replace(''data:image/jpeg;base64,'', '''');',
'     request = {',
'        "requests":[',
'          {',
'            "image":{  ',
'				"content": b64',
'				},',
'            "features":[',
'              {',
'                // if you want to detect more faces, or detect something else, change this',
'                "type":"DOCUMENT_TEXT_DETECTION"',
'               ',
'              }',
'            ]/*,',
'            "imageContext": {',
'                "languageHints": ["de"]',
'              }*/',
'          }',
'        ]',
'      };',
'      var begin = new Date();',
'    $("progress").animate({value: 0.15},3000);',
'      $.ajax({',
'        method: ''POST'',',
'        url: ''https://vision.googleapis.com/v1/images:annotate?key=AIzaSyAigHVzuQYTdq5qUgrX88SjS5WfqS3j2HE'',',
'        contentType: ''application/json'',',
'        data: JSON.stringify(request),',
'        processData: false,',
'        success: function(data){',
'            var end = new Date();',
'            console.log("google api request time ->"+(begin.getMilliseconds()-end.getMilliseconds()));',
'            console.log("%o",data);',
'          //  console.log("annonatation: "+data.responses[0].fullTextAnnotation);',
'           // getLines(data.responses[0].fullTextAnnotation);',
'          //  console.log("output data BEFORE: -> %o",data.responses[0].textAnnotations);',
'            begin = new Date();',
'            var result = extractProducts(data.responses[0].textAnnotations.sort(compareYX)); //function(a,b){return (a.boundingPoly.vertices[0].y - b.boundingPoly.vertices[0].y)+(a.boundingPoly.vertices[0].x - b.boundingPoly.vertices[0].x);});',
'            end = new Date();',
'           ',
'            console.log("extractProduct with sort Function time ->"+(begin.getMilliseconds()-end.getMilliseconds()));',
'            console.log("output data AFTER sort: -> %o",result);',
'            //console.log(''result'', result);',
'            var lineObj = [];',
'            var boundHeight = 0;',
'            var y_top = 0',
'            var y_bottom = 0;',
'            var productLines = [];',
'            begin = new Date();',
'            $.each(result,function(i,v){',
'                if ( i > 0 ){',
'                    /*if (v.description.match(/(Pos|Beschreibung|Einzelpreis|Menge|Summe)/gi) || lineObj.length == 0){  ',
'                        ',
'                        sizeOfCharacter = v.boundingPoly.vertices[2].y - v.boundingPoly.vertices[0].y;',
'                        console.log("in create of size of character -> text:"+v.description+"-->height:"+sizeOfCharacter);',
'                    }*/',
'                    if(i==1){',
'                        boundHeight = v.boundingPoly.vertices[3].y+5;',
'                        console.log("boundheigh is ->"+boundHeight);',
'                    }',
'                  // console.log("actualText:"+v.description+" -> v[0]y:"+v.boundingPoly.vertices[0].y+"-boundheigth: ->"+boundHeight);',
'                    ',
'                    if( v.boundingPoly.vertices[0].y > boundHeight){',
'                        lineObj.sort(function(a,b){return a.x - b.x });',
'                        var line = "";',
'                       console.log("line break with ->"+boundHeight+"-> line obj:%o ",lineObj);',
'                        $.each(lineObj,function(i,v){',
'                            line += v.v;',
'                        })',
'                        console.log(line);',
'                        productLines.push(line);',
'                        var progressVal = parseFloat($(".ocr_result>progress").val())+0.01;',
'                        console.log("progressVal ->"+progressVal);',
'                         $(".ocr_result>progress").val(progressVal.toFixed(2));',
'                       // console.log("joinedLine ->"+lineObj.join)',
'                        lineObj = [];',
'                        boundHeight = v.boundingPoly.vertices[3].y+5;',
'                        ',
'                    }',
'                    var space = i==(result.length-1)?"":((result[i+1].description==","|| result[i+1].description=="."||v.description==",")?"":" ");',
'                    lineObj.push({v: v.description.replace(/(?:\r\n|\r|\n)/g," ")+space,  x: v.boundingPoly.vertices[0].x, b: v.boundingPoly.vertices});',
'//                      line += v.description+" ";',
'                }',
'            });',
'             end = new Date();',
'            console.log("CreateLine Array  ->time ->"+(begin.getMilliseconds()-end.getMilliseconds()));',
'            result = data.responses[0].fullTextAnnotation.text;',
'            var email = result.match(/([a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9._-]+)/gi) != null?result.match(/([a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9._-]+)/gi)[0]:'''';',
'            if(email.length == 0){',
'                   if(/ecogast/.test(result.text)){',
'                      email = "office@ecogast.at";',
'                   }else{',
'                       email = "office@yalcin-gastro.at";',
'                   }',
'            }',
'             createBillitems(productLines,email,file,f01Array);',
'        ',
'        },',
'        error: function (data, textStatus, errorThrown) {',
'          console.log(''error: '' + data);',
'        }',
'      });',
'   ',
'   ',
'  //  apex.region(''item_overview'').widget().interactiveGrid(''getViews'', ''grid'').model.clearChanges();',
'  //  apex.region("item_overview").refresh();',
'   ',
'  ',
'}',
'function extractProducts(obj){',
'    var products = obj.slice();',
'    //console.log("indexOf Mwst:"+indexOf(term));',
'    var pos = 0;',
'    if(obj.map(function(e) { return e.description; }).indexOf("ecogast") != -1){',
'        pos = obj.map(function(e) { return e.description; }).indexOf("Einh")+12;',
'        console.log("in ecogast ...pos->"+pos);',
'    }else{',
'        console.log("in yalcin...");',
'        pos = obj.map(function(e) { return e.description; }).indexOf("MwSt");',
'    }',
'    products.splice(0,pos+1);',
'    console.log("products length:-"+products.length+" -ab MwSt:%o",products);',
'    //console.log("indexoF Netto ->"+products.indexOf("Netto"));',
'    products.length = products.map(function(e) { return e.description; }).indexOf("MwSt");',
'    return products;',
'    ',
'}',
'function compareYX(a,b){',
'  ',
'     if ( Math.abs(a.boundingPoly.vertices[0].y -b.boundingPoly.vertices[0].y) < 10) {',
'        return 0;',
'    }',
'    else {',
'        return (a.boundingPoly.vertices[0].y < b.boundingPoly.vertices[0].y) ? -1:1; // ((a.boundingPoly.vertices[0].x < b.boundingPoly.vertices[0].x)? -1 : 1):1;',
'    }',
'}',
'',
'',
'// x = variable to be replaced; x = searchTerm , r=replaceTerm;',
'function replaceSafe(x,s,r){',
'    return (typeof x != ''undefined''?x.replace(s,r):'''');',
'}',
'function createBillitems(lineArr,email,file,f01Array){',
'    var begin = new Date();',
' ',
'    console.log("in createBillitems -> data->%o",lineArr);',
'    var products = [];',
'    $.each(lineArr,function(i,line){',
'         var p = new Object();',
'        //var line = obj.v;',
'        console.log("line ->%o",line);',
'            var parts = line.replace(/(,| ,)/g,".").replace(/^\s+|\s+$/g, '''').split(" ");',
'            ',
'            /*if( /office@ecogast.at/.test(email)){',
'                parts.splice(0,1);',
'                parts.splice(0,1);',
'            }*/',
'            if (/^\d+$/.test(parts[0])){',
'                parts.splice(0,1);',
'            }',
'            parts = parts.reverse();',
'          ',
'           console.log(parts);',
'           ',
'          // p.total = parts[0];',
'       ',
'           if( /office@ecogast.at/.test(email)){',
'              console.log("in ECO GASTRO ..");',
'               //if',
'               p.unit_net = parts[1];',
'               p.percent = parts[2]!="%"?0:parts[3];',
'               p.unit = parts[4];',
'               p.qnt = p.percent==0?(parseFloat(parts[0])/parseFloat(parts[1])):parts[5];',
'               ',
'           ',
'               console.log("pqnt->"+p.qnt+"-punit->"+p.unit+"-parts:"+parts+"--partsjoin:"+parts.join(" "));',
'               p.name = parts.reverse().join(" ").split(p.qnt+" "+p.unit)[0].replace(/[A-Z][0-9][0-9][0-9] /, "");',
'               console.log("pname first.>"+p.name);',
'',
'            ',
'           }else{',
'             ',
'               if(isNaN(parseFloat(parts[0]))){',
'                  parts.unshift(0);',
'               }else{',
'                   if(!isNaN(parseFloat(parts[1]))){  //if the second array value is a number because of this schema [ Name | Percent | unit_net | quantity | sum ]',
'                       parts.splice(1,1);',
'                   }',
'               }',
'               ',
'               p.unit = parts[1];',
'               p.qnt = parts[2];',
'               p.unit_net = parts[3];',
'               p.percent = parts[4] =="%"?parts[5]:"0";',
'               if (/[0-9]/.test(p.unit)){ //IF UNIT variable is not alphabetic ',
'                   p.qnt = replaceSafe(replaceSafe(p.unit,/[^0-9.,]/gi,''''),/[^0-9]$/,'''');',
'',
'                   p.unit = replaceSafe(p.unit,p.qnt,'''');',
'                   p.unit_net = parts[2];',
'               }',
'                //p.total = p.unit_net*p.qnt;',
'               var splitter  = p.percent=="0"?(p.unit_net+" "+p.qnt):(p.percent+" % "+p.unit_net);',
'               p.name =  parts.reverse().join(" ").split(splitter)[0]; //line.split(" "+p.unit_net.toString())[0].replace("0%","");',
'           }',
'           p.unit = replaceSafe(p.unit,/[^a-zA-Z]/gi, '''') ==""?"Stk":replaceSafe(p.unit,/[^a-zA-Z]/gi,'''');',
'         console.log(''index: -> ''+i+'' name ->''+p.name+"-UNIT_NET:-"+p.unit_net+"-QUANTITY:-"+p.qnt+"-UNIT:-"+p.unit+"-Percent:"+p.percent);',
'          if(!isUndefined(p.name) && !isUndefined(p.unit) && !isUndefined(p.qnt) && !isNaN(p.qnt) && !isUndefined(p.unit_net) && !isNaN(p.unit_net) ){',
'             ',
'               p.qnt = checkDecimal(p.qnt);',
'               p.unit_net = checkDecimal(p.unit_net);',
'               p.percent = parseInt(p.percent);',
'              ',
'               products.push(p);',
'            ',
'            ',
'              $(".ocr_result").append("<div class=''success-msg'' ><span class=''t-Icon t-Icon--left'' aria-hidden=''true''></span><span>"+p.name+" "+p.percent+"% "+p.unit_net+" "+p.qnt+" "+p.unit+" "+(p.unit_net*p.qnt).toFixed(2)+"  </span><span class=''t-'
||'Icon t-Icon--right fa fa-check'' aria-hidden=''true''></span></div>").fadeIn(5000);',
'          }else{',
'              console.log("in else ->progressUupdate");',
'               updateProgress(lineArr.length);',
'          }',
'           ',
'     ',
'    });',
'   ',
'    $("progress").animate({value: 1},5000);',
'    apex.server.process(',
'                  ''CREATE_BILLITEM'',',
'                  {',
'                      x01: JSON.stringify({Products : products}),',
'                      x02: email,',
'                      x03: file.name,',
'                      x04: file.type,',
'                      f01: f01Array',
'                  },',
'                  {',
'                    dataType: ''json'',',
'                    success: function(data) {',
'                      console.log("in success before result.."+data);',
'                      if (data.result == ''success'') {',
'                           $(".u-Processing").hide();',
'                          $("#P9_OCR_IMAGE").val("");                      ',
'                          console.log(''success: ''+data.err);',
'                         //updateProgress(products.length);',
'                         apex.message.showPageSuccess(''Data saved.'');  ',
'',
'                      } else {',
'',
'                       console.log(''err:->''+data.result);',
'                       apex.message.showErrors([',
'                            {',
'                                type: apex.message.TYPE.ERROR,',
'                                location: ["page"],',
'                                message: data.result,',
'                                unsafe: false',
'                             }    ',
'                       ]);',
'                      }',
'                      ',
'                      ',
'                    }',
'                  }',
'              );',
'   var end = new Date();',
'   console.log("createBillitem-> time ->"+(begin.getMilliseconds()-end.getMilliseconds()));',
'}',
'function updateProgress(arrLen){',
'     var actVal = parseFloat($(".ocr_result > progress").val());',
'      var newVal = actVal + ((1-(arrLen*0.01))/arrLen);',
'      console.log("in success -> actVal->"+actVal.toFixed(2)+"---newVal->"+newVal+".---"+(1-actVal)+"---"+((1-actVal)/arrLen));',
'       $(".ocr_result > progress").val( newVal);',
'}',
'function isUndefined(x){',
'    return typeof x == "undefined";',
'}',
'function closeModal(){',
'    apex.message.showPageSuccess(''Data saved.'');  ',
'    apex.navigation.dialog.close(true);',
'}',
'function checkDecimal(x){',
'    return parseFloat((typeof x !=''undefined''?x.toString().replace(",","."):"")).toFixed(2);',
'}'))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
' .success-msg{',
' margin: 10px 10px;',
'  padding: 5px;',
'  border-radius: 3px 3px 3px 3px;',
'      color: #fff;',
'  background-color: #79D173;',
'}'))
,p_step_template=>wwv_flow_imp.id(37626995974840786044)
,p_page_template_options=>'#DEFAULT#:ui-dialog--stretch'
,p_page_component_map=>'17'
,p_last_updated_by=>'MACDENIZ'
,p_last_upd_yyyymmddhh24miss=>'20220520095248'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(57678367093529849486)
,p_plug_name=>'ButtonDiv'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(37627008146725786055)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(87140236049452423735)
,p_plug_name=>'OCR Result'
,p_region_name=>'ocr_result'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(37627033949633786074)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(87140236169102423736)
,p_plug_name=>'Uploaded Bill'
,p_region_name=>'img_region'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(37627033949633786074)
,p_plug_display_sequence=>10
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(87140236374340423738)
,p_plug_name=>' - '
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(37627008146725786055)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_01'
,p_query_type=>'TABLE'
,p_query_table=>'BILL'
,p_include_rowid_column=>false
,p_is_editable=>false
,p_plug_source_type=>'NATIVE_FORM'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(21462203897717140058)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(57678367093529849486)
,p_button_name=>'cancel'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(37627090985680786117)
,p_button_image_alt=>'Cancel'
,p_button_position=>'BELOW_BOX'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(21462204302279140058)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(57678367093529849486)
,p_button_name=>'insertBut'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--mobileHideLabel:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(37627091174184786117)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'BELOW_BOX'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-check'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(21462205672561140060)
,p_name=>'P16_OCR_IMAGE'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(87140236374340423738)
,p_prompt=>'Upload Your Image'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(37627089898381786115)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'APEX_APPLICATION_TEMP_FILES'
,p_attribute_09=>'SESSION'
,p_attribute_10=>'N'
,p_attribute_12=>'NATIVE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(21462206036667140061)
,p_name=>'P16_BIDD'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(87140236374340423738)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(21462207591617140064)
,p_name=>'onchange_executeOCR'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P16_OCR_IMAGE'
,p_condition_element=>'P16_OCR_IMAGE'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'live'
,p_bind_delegate_to_selector=>'.t-Dialog'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21462208108126140064)
,p_event_id=>wwv_flow_imp.id(21462207591617140064)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var file = $(this.triggeringElement).get(0).files[0];',
'',
'',
'$(".ocr_result").find("progress").remove();',
'var oldResult = typeof $(".ocr_result").html() == ''undefined''?'''':''-------------<br/><br/>''+$(".ocr_result").html();',
'$(".ocr_result").remove();',
'$("progress").remove();',
'$("#ocr_result").append(''<div class="ocr_result"><progress class="active" style="width:100%" value="0" max="1"></progress></div>''+oldResult);',
'',
'var htmlReader = new FileReader();',
'htmlReader.onload = (function(pFile) {',
'    return function(e) {',
'      if (pFile) {',
'        var base64 = binaryArray2base64(e.target.result);',
'        var f01Array = [];',
'        f01Array = clob2Array(base64, 30000, f01Array);',
'        convertImage2Text(file,f01Array,base64);',
'          ',
'        const arrayBuffer = e.target.result;',
'        const blob = new Blob([arrayBuffer], {type: ''image/png''});',
'        let src = URL.createObjectURL(blob);',
'        console.log("data->"+file.name+"--"+file.type);',
'        $("#img_region").find(".t-Region-body").html("<img class=''tooltipImg'' style=''max-height:750px'' src=''"+src+"'' />");',
'        ',
'         ',
'        ',
'      }   ',
'    }',
'})(file);',
'htmlReader.readAsArrayBuffer(file);',
'',
''))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(21462208581895140065)
,p_name=>'Close Dialog With BID'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(21462204302279140058)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21462209082102140065)
,p_event_id=>wwv_flow_imp.id(21462208581895140065)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'apex.navigation.dialog.close(true,''f?p=&APP_ID.:16:&SESSION.:::9:P16_BID:''+$("#P16_BIDD").val());'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(21462209461557140065)
,p_name=>'Cancel Dialog'
,p_event_sequence=>30
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(21462203897717140058)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21462209904194140066)
,p_event_id=>wwv_flow_imp.id(21462209461557140065)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(21462207268056140063)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'closeDialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(21462206390885140062)
,p_process_sequence=>10
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'CREATE_BILLITEM'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    l_pid number := 0;',
'    l_sid number := 0;',
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
'    l_percent number;',
'    l_exist_billitem number;',
'    l_dif_name number;',
'    l_unit_id number;',
'    l_products varchar2(32767);',
'    l_values apex_json.t_values;',
'   l_data_count integer;',
'   l_email varchar2(100);',
'   l_filename varchar2(200);',
'   l_mimetype varchar2(100);',
'   l_blob blob;',
'   l_token varchar2(32000);',
'BEGIN',
'   /* l_name := apex_application.g_x01;',
'    l_unit := apex_application.g_x02;',
'    l_qnt := apex_application.g_x03;',
'    l_unit_net := apex_application.g_x04;',
'    l_total := l_qnt*l_unit_net;',
'    l_percent := apex_application.g_x07;',
'   ',
'    l_bid := apex_application.g_x06;',
'  */',
'   l_msg := ''nothing happend.'';',
'   l_products := apex_application.g_x01;',
'   --l_bid := apex_application.g_x02;',
'    l_email := apex_application.g_x02;',
'    l_filename := apex_application.g_x03;',
'    l_mimetype := nvl(apex_application.g_x04,''application/octet-stream'');',
'',
'/* CREATE THE BILL */',
'    -- build BLOB from f01 30k array (base64 encoded)',
'    dbms_lob.createtemporary(l_blob, false, dbms_lob.session);',
'    for i in 1 .. apex_application.g_f01.count loop',
'        l_token := wwv_flow.g_f01(i);',
'        l_msg := '' in blob loop'';',
'        if length(l_token) > 0 then',
'          dbms_lob.append(',
'            dest_lob => l_blob,',
'            src_lob => to_blob(utl_encode.base64_decode(utl_raw.cast_to_raw(l_token)))',
'          );',
'          else ',
'                l_msg := '' in else loop'';',
'        end if;',
'    end loop;',
'   ',
'    -- create supplier if not exist ',
'    BEGIN',
'        SELECT sid INTO l_sid from sc_supplier where UPPER(email) LIKE ''%''||UPPER(l_email)||''%'' fetch first 1 row only;',
'        l_msg := ''in select sid AFTER SELECT;'';',
'        EXCEPTION WHEN OTHERS THEN',
'            l_msg := ''in insert supplier BEFORe INSERT'';',
'            INSERT INTO sc_supplier(name,email) VALUES(l_email,l_email) RETURNING sid INTO l_sid;',
'            l_msg := ''in insert supplier after INSERT'';',
'    END;',
'    ',
'    --create BILL TABLE ROW',
'    l_msg := ''before dbms_lob...'';',
'    if dbms_lob.getlength(l_blob) is not null then',
'       l_msg := ''in insert into bill BEFORE insert.'';',
'       l_msg := ''sid:''||l_sid||'', sale_date:''||TO_DATE(TO_CHAR(SYSDATE,''mm/dd/yyyy''),''mm/dd/yyyy'')||'', mimetype:''||l_mimetype||'', filename:''||l_filename;',
'        INSERT INTO sc_bill(sid,sale_date,image,mimetype,filename) VALUES(l_sid,TO_DATE(TO_CHAR(SYSDATE,''mm/dd/yyyy''),''mm/dd/yyyy''),l_blob,l_mimetype,l_filename) RETURNING bid INTO l_bid;',
'        l_msg := ''in insert into bill after insert'';',
'    end if;',
'      l_msg := ''after dbms_lob...'';',
'      ',
'     ',
'     /* CREATE THE BILLITEMS ... */',
'   ',
'    apex_json.parse (    ',
'        p_values => l_values,    ',
'        p_source => l_products );  ',
'    ',
'    l_data_count := apex_json.get_count (    ',
'                        p_values => l_values,    ',
'                        p_path  => ''Products'' );    ',
'    ',
'    for i in 1 .. l_data_count loop      ',
'        l_name := apex_json.get_varchar2( p_values => l_values, p_path  => ''Products[%d].name'',    p0      => i );',
'        l_unit := apex_json.get_varchar2( p_values => l_values, p_path  => ''Products[%d].unit'',    p0      => i );',
'        l_qnt := apex_json.get_varchar2( p_values => l_values, p_path  => ''Products[%d].qnt'',    p0      => i );                  ',
'        l_unit_net := apex_json.get_varchar2( p_values => l_values, p_path  => ''Products[%d].unit_net'',    p0      => i );',
'        l_total := ROUND((l_qnt*l_unit_net),2);',
'        l_percent :=  apex_json.get_varchar2(p_values => l_values, p_path  => ''Products[%d].percent'',    p0      => i );',
'        ',
'        BEGIN',
'            SELECT aid,tax_id,UTL_MATCH.edit_distance(UPPER(l_name), UPPER(name)) AS ed,LENGTH(NAME) INTO l_pid,l_tid,l_differance,l_dif_name FROM   sc_article order by ed fetch first 1 row only;',
'            EXCEPTION when others then',
'                l_differance := 4; ',
'        END;',
'        if l_differance > 3 THEN ',
'            l_msg := ''->in differance > 3 ==> l_percent = ''||l_percent;',
'            ',
'            if l_percent > 0 THEN',
'                select tid INTO l_tid from sc_tax where percent = l_percent;',
'            ELSE',
'                select tid INTO l_tid from sc_tax where percent = 20;',
'            END IF;',
'            ',
'            insert into sc_article(name,tax_id) VALUES(l_name,l_tid) RETURNING aid INTO l_pid;',
'        elsif l_differance > 0 THEN',
'            l_msg := ''in differance > 0'';',
'            --update sc_article set notes = l_name || '','' || (select substr(notes,0,(Length(notes)-LENGTH(l_name)-1)) from sc_article where aid = l_pid) where aid = l_pid;',
'',
'        else ',
'            l_msg := ''in differance == 0'';',
'            select aid INTO l_pid from sc_article where name = l_name;',
'        end if;',
'',
'',
'',
'        BEGIN',
'            select u_id INTO l_unit_id from sc_unit where UPPER(name) = UPPER(l_unit);',
'',
'            EXCEPTION when others then',
'                INSERT INTO sc_unit(name) VALUES(l_unit) RETURNING u_id INTO l_unit_id;',
'        end;',
'',
'        select count(*) INTO l_exist_billitem from billitem where pid = l_pid AND bid = l_bid;',
'',
'        if l_exist_billitem > 0 then',
'            update billitem set quantity = quantity+l_qnt where pid = l_pid AND bid = l_bid;',
'        else',
'            insert into billitem(bid,pid,u_id,quantity,unit_net,unit_gross,total) VALUES(l_bid,l_pid,l_unit_id,l_qnt,l_unit_net,round((l_unit_net*((100+l_percent)/100)),2),l_total) ;',
'        end if;',
'    ',
'    END LOOP;',
'    ',
'    apex_json.open_object;',
'    apex_json.write(''result'',''success'');',
'    apex_json.write(''err'',SQLERRM||''------>msg:''||l_msg||'' l_products -->''||l_products||'' l_data_count->''||l_data_count||'' --bid:''||l_bid||'' l_pid=>''||l_pid||'' l_unit-->''||l_unit||'' l_qnt--->''||l_qnt||'' l_unit_net-->''||l_unit_net||'' l_unit_gross->''||'
||'(l_unit_net*((100+l_percent)/100))||'' l_total-->''||l_total);',
'    --apex_json.write(''tid'',l_tid);',
'    apex_json.close_object;',
'',
'    exception',
'        when OTHERS then',
'            apex_json.open_object;',
'            apex_json.write(''result'',SQLERRM||''------>msg:''||l_msg||'' l_products -->''||l_products||'' l_data_count->''||l_data_count||'' --bid:''||l_bid||'' l_pid=>''||l_pid||'' l_unit-->''||l_unit||'' l_qnt--->''||l_qnt||'' l_unit_net-->''||l_unit_net||'' l_unit'
||'_gross->''||(l_unit_net*((100+l_percent)/100))||'' l_total-->''||l_total);',
'            apex_json.close_object;',
'',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(21462206875275140063)
,p_process_sequence=>20
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'CREATE_BILL'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    l_sid number;',
'    l_bid number;',
'    l_email varchar2(100);',
'    l_blob BLOB;',
'    l_filename varchar2(200);',
'    l_mimetype varchar2(100);',
'    l_token varchar2(32000);',
'    l_msg varchar2(500);',
'BEGIN',
'    l_email := apex_application.g_x01;',
'    l_filename := apex_application.g_x02;',
'    l_mimetype := nvl(apex_application.g_x03,''application/octet-stream'');',
'',
'    -- build BLOB from f01 30k array (base64 encoded)',
'    dbms_lob.createtemporary(l_blob, false, dbms_lob.session);',
'    for i in 1 .. apex_application.g_f01.count loop',
'    l_token := wwv_flow.g_f01(i);',
'    if length(l_token) > 0 then',
'      dbms_lob.append(',
'        dest_lob => l_blob,',
'        src_lob => to_blob(utl_encode.base64_decode(utl_raw.cast_to_raw(l_token)))',
'      );',
'    end if;',
'    end loop;',
'   ',
'    -- create supplier if not exist ',
'    BEGIN',
'        SELECT sid INTO l_sid from supplier where UPPER(email) LIKE ''%''||UPPER(l_email)||''%'' fetch first 1 row only;',
'        l_msg := ''in select sid AFTER SELECT;'';',
'        EXCEPTION WHEN OTHERS THEN',
'            l_msg := ''in insert supplier BEFORe INSERT'';',
'            INSERT INTO supplier(name,email) VALUES(l_email,l_email) RETURNING sid INTO l_sid;',
'            l_msg := ''in insert supplier after INSERT'';',
'    END;',
'    ',
'    --create BILL TABLE ROW',
'    l_msg := ''before dbms_lob...'';',
'    if dbms_lob.getlength(l_blob) is not null then',
'       l_msg := ''in insert into bill BEFORE insert.'';',
'       l_msg := ''sid:''||l_sid||'', sale_date:''||TO_DATE(TO_CHAR(SYSDATE,''mm/dd/yyyy''),''mm/dd/yyyy'')||'', mimetype:''||l_mimetype||'', filename:''||l_filename;',
'        INSERT INTO bill(sid,sale_date,image,mimetype,filename) VALUES(l_sid,TO_DATE(TO_CHAR(SYSDATE,''mm/dd/yyyy''),''mm/dd/yyyy''),l_blob,l_mimetype,l_filename) RETURNING bid INTO l_bid;',
'        l_msg := ''in insert into bill after insert'';',
'    end if;',
'      l_msg := ''after dbms_lob...'';',
'    apex_json.open_object;',
'    apex_json.write(''result'',''success'');',
'    apex_json.write(''bid'',l_bid);',
'    apex_json.write(''err'',SQLERRM||''------bid:''||l_bid||''--lsid:''||l_sid||''_email:''||l_email);',
'    apex_json.close_object;',
'',
'    exception',
'        when OTHERS then',
'            apex_json.open_object;',
'            apex_json.write(''result'',SQLERRM||''------bid:''||l_bid||''--lsid:''||l_sid||''_email:''||l_email||'' ---l_msg: ''||l_msg);',
'            apex_json.close_object;',
'',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
