prompt --application/pages/page_00009
begin
wwv_flow_imp_page.create_page(
 p_id=>9
,p_user_interface_id=>wwv_flow_imp.id(37628517236709248794)
,p_name=>'Invoice'
,p_step_title=>'Invoice'
,p_autocomplete_on_off=>'OFF'
,p_javascript_file_urls=>'#APP_FILES#jquery.easing.min.js'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var counter = 0;',
'var lastSeenCartItem = "";',
'var scrollHeight = $("#shoppingCartList").height();',
'var addedItems = [];',
'',
'function resetCart(){',
'     $("#shoppingCartList li").animate({''opacity'':0},500,function(){',
'            $(this).remove();',
'        });',
unistr('        $("#right p").html("\20AC 0.00");'),
'         $("#discount_type").html("");',
'        addedItems =[];',
'        $("#total-container .u-success").hide();',
'        $("#discount-but").attr(''disabled'',true);',
'        $s("P9_DISCOUNT",""); $s("SHOPPINGCART","");',
'        saveData();',
'}',
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
'function sumTotal(){',
'    var total = 0;',
'    $(".t-MediaList-badge").each(function(){',
unistr('        total += parseFloat($(this).html().replace("\20AC",""));'),
'    });',
'    console.log("in total->"+total);',
'    if(total==0){',
'        $("#total-container .u-success").hide();',
'        $("#discount-but").attr(''disabled'',true);',
'    }',
'',
unistr('    $("#right p").last().html("\20AC "+total.toFixed(2));'),
unistr('     $("#right p").first().html("\20AC "+total.toFixed(2));'),
'    ',
'   ',
'    calculateDiscount();',
'    ',
'    ',
'}',
'function addItem(id,qnt,name,price,img){',
'    console.log("in Additems ->"+id);',
'    ',
'    var obj = $(".t-Card-info:contains(''#"+id+"'')").parent().parent().parent().parent();',
'    var imgtodrag = $("#articleDiv img[data-id="+id+"]").length? $("#articleDiv img[data-id="+id+"]").eq(0):img;',
'    var cart = counter==0?$("#shoppingCartList"):$(''#shoppingCartList li'').last();',
'    if (id == 0){',
'',
'       /* apex.navigation.dialog(apex.item(''P9_URL'').getValue(), {   ',
'            title:''Add New Article'',   ',
'            height:''740'',   ',
'            width:''810'',   ',
'            maxWidth:''960'',   ',
'            modal:true,  ',
'            dialog:null },   ',
'            ''t-Dialog--standard'',   ',
'            $(''#articleDiv'')                      ',
'        );*/   ',
'       if($v("P9_CATEGORY")==1){',
'           apex.navigation.redirect(apex.item(''P9_URL_FOOD'').getValue());',
'       }else{',
'           apex.navigation.redirect(apex.item(''P9_URL_DRINK'').getValue());',
'       }',
'    }else{',
'        counter++;',
'      // console.log("in addItem->"+obj.html());',
'        //onsole.log(obj.find(''.t-Card-initials'').html());',
'        // console.log($("#articleDiv ul").html());',
'      /*  $("#cartBut > .button_badge").show();',
'        $("#cartBut > .button_badge").html(counter);',
'*/',
unistr('      //  var unit_net = parseFloat(obj.find(''.t-Card-initials'').html().replace("\20AC",""));'),
'      //  var article = obj.find(".t-Card-title").html();',
'     //   console.log(unit_net+"---"+article);',
'',
'        if(addedItems.filter(function(a){return a.id == id}).length){ //IF article exists',
'           addedItems.filter(function(a){return a.id==id?(a.qnt++):a;});',
'            ',
'            console.log("in same article..counter");',
'            var countTd = $("#shoppingCartList li[data-id="+id+"]");',
'            var newCount = parseInt(countTd.find(''.cVal'').val())+1;',
'            console.log(countTd.html());',
'            console.log("--newCount->"+newCount);',
'            countTd.find(''.cVal'').val(newCount);',
unistr('            countTd.find(".t-MediaList-badge").html("\20AC "+(newCount*price).toFixed(2));'),
'            console.log("--newCount2->"+newCount);',
'            cart = countTd.parent();',
'            sumTotal();',
'// ''<img src=f?p=&APP_ID.:0:&APP_SESSION.:APPLICATION_PROCESS=GETIMAGE:::FILE_ID:''+id+'' height=70 width=70 /></span></div>',
'        }else{ ',
'            console.log("in different Article...");',
'            var artObj = new Object( {"id":id,"qnt":qnt,"name":name,"price":price,"img":img});',
'            addedItems.push(artObj);',
unistr('           // $("#shoppingCart>ul").append("<tr><td>"+article+"<br/>"+unit_net+" \20AC</td><td><span class=''t-Icon fa fa-minus''></span><input value=''1'' style=''width:30px'' class=''cVal'' /><span class=''t-Icon fa fa-plus''></span></td><td>"+unit_net+" \20AC</td><')
||'/tr>");',
'            setTimeout(function(){',
'                $("#shoppingCart").find("ul").append($(''<li class="t-MediaList-item" data-id=''+id+'' > ''',
'                                         +''<div class="t-MediaList-iconWrap"><span class="t-MediaList-icon u-color #ICON_COLOR_CLASS#">''',
'                                             +img+''</span></div>''',
unistr('                                         +''<div class="t-MediaList-body"><h3 class="t-MediaList-title">''+name+'' </h3><p class="t-MediaList-desc">\20AC ''+price+''</p></div>'''),
'                                         +''<div class="input-increment">''',
'                  +"<span class=''minus''>-</span><input value="+qnt+" style=''width:30px'' class=''cVal'' /><span class=''plus''>+</span></div>"',
unistr('              +''<div class="t-MediaList-badgeWrap" style="position:relative;"><span class="t-MediaList-badge" style="margin:0px;">\20AC ''+(price*qnt).toFixed(2)+''</span>'''),
'                                                       +''<div class="fa fa-trash" style="position:absolute;bottom:5px;right:0px;text-align:right;font-size:25px;cursor:pointer;"></div></div></li>'').hide().fadeIn());',
'                sumTotal();',
'            },500);',
'           ',
'        /*   if(counter ==5){',
'               lastSeenCartItem = $("#shoppingCartList li").last();',
'           }',
'           if(counter > 5){',
'               cart = lastSeenCartItem;',
'           }*/',
'            ',
'        }',
'',
'',
'        ',
'        if($("#P9_SEARCH").val().length> 0){',
'            $("#P9_SEARCH").val("");',
'            apex.region("articleDiv").refresh();',
'        }',
'',
'    }',
'   ',
'    moveIt(imgtodrag,id);',
'    ',
'   // console.log($("#articleDiv ul").html());',
'}',
'function moveIt(imgtodrag,id){',
'    console.log(imgtodrag+"__"+id);',
'    //var cart = counter==0?$("#shoppingCartList"):$(''#shoppingCartList li'').last();',
'     //   var imgtodrag = $(this).find("img").eq(0);',
'        if (imgtodrag) {',
'            var imgclone = "";',
'            if(!$("#articleDiv img[data-id="+id+"]").length){ //if the img not exist in articleDiv because of selected filter options',
'                $("#articleDiv_cards").append(imgtodrag);',
'               ',
'             ',
'                ',
'               imgclone = $("#articleDiv_cards img[data-id="+id+"]");',
'                 /*.offset({',
'                   top: $("#articleDiv_cards").offset().top+($("#articleDiv_cards").height()/2),',
'                   left:$("#articleDiv_cards").offset().left+($("#articleDiv_cards").width()/2)',
'               }); */',
'            }else{',
'                //console.log($("#articleDiv img[data-id="+id+"]").length);',
'                imgclone = imgtodrag.clone()',
'                    .offset({',
'                    top: imgtodrag.offset().top,',
'                    left: imgtodrag.offset().left',
'                });',
'            }',
'            imgclone.css({',
'                    ''opacity'': ''0.5'',',
'                        ''position'': ''absolute'',',
'                        ''height'': ''150px'',',
'                        ''width'': ''150px'',',
'                        ''z-index'': ''100''',
'                    })',
'                    .appendTo($(''body''))',
'                .animate({',
'                ''top'': $("#shoppingCartList").offset().top + $("#shoppingCartList").height()/2,',
'                    ''left'': $("#shoppingCartList").offset().left + $("#shoppingCartList").width()/2,',
'                    ''width'': 75,',
'                    ''height'': 75',
'            }, 1000, ''easeInOutExpo'');',
'            ',
'            setTimeout(function () {',
'                var c = 0;',
'                var h = addedItems.findIndex(o=>o.id===id)*100;',
'              /*  $("#shoppingCartList li").each(function(){',
'                    c++;',
'                    if($(this).data(''id'') == id){ ',
'                        h=100*c;',
'                    } ',
'                                               ',
'                });*/',
'                console.log("scrollheight->"+h+"__"+ addedItems.findIndex(o=>o.id===id));',
'                console.log(addedItems);',
'                $("#shoppingCartList").animate({ scrollTop: h-100 }, 500);',
'                /*$("#shoppingCartList li[attr="+id+"]").effect("shake", {',
'                    times: 2',
'                }, 200);*/',
'                $("#shoppingCartList li[data-id="+id+"]").addClass(''u-color-7'').animate({',
'                      opacity:"0.3"',
'                  }, 500, function() {',
'                    $("#shoppingCartList li").animate({',
'                        opacity:"1"',
'                    }, 500);',
'                     $("#shoppingCartList li[data-id="+id+"]").removeClass(''u-color-7'');',
'                  });',
'                ',
'            }, 1000);',
'',
'            imgclone.animate({',
'                ''width'': 0,',
'                    ''height'': 0',
'            }, function () {',
'                $(this).detach()',
'            });',
'        }',
'    ',
'    // $("#shoppingCart").find("ul").append(item);',
'}',
'function saveData(){',
'     $s("P9_SHOPPINGCART",JSON.stringify(addedItems));',
'   ',
'    apex.server.process(''SAVE_CART'',',
'                        {x01: $v(''P9_SHOPPINGCART''),',
'                         x02: $v(''P9_DISCOUNT'')',
'                       ',
'                         },{dataType: ''text''});',
'}',
'function calculateDiscount(){',
'    var val = $("#P9_DISCOUNT").val();',
'    if (val != ""){',
'        console.log("new val ->"+val);',
'        if(val.indexOf("%")!=-1){',
'            $("#discount_type").html(" "+val);',
unistr('            val = parseFloat(val.replace("%",""))*(parseFloat($("#right p").first().html().replace("\20AC",""))/100);'),
'        }else{',
'            $("#discount_type").html("");',
unistr('            val = parseFloat(val.replace("\20AC",""));'),
'        }',
unistr('        $("#right .u-success-text").html("\20AC -"+val.toFixed(2));'),
unistr('        $("#right p").last().html("\20AC "+(parseFloat($("#right p").first().html().replace("\20AC",""))-val).toFixed(2));'),
unistr('        //$("#right p").first().html("\20AC "+(parseFloat($("#right p").last().html().replace("\20AC",""))-val).toFixed(2));'),
'    }',
'     saveData();',
'}',
'',
'Number.prototype.formatMoney = function(decPlaces, thouSep, decSep) {',
'/* this function taken from http://stackoverflow.com/questions/9318674/javascript-number-currency-formatting */',
'  var n = this,',
'  decPlaces = isNaN(decPlaces = Math.abs(decPlaces)) ? 2 : decPlaces,',
'  decSep = decSep == undefined ? "." : decSep,',
'  thouSep = thouSep == undefined ? "," : thouSep,',
'  sign = n < 0 ? "-" : "",',
'  i = parseInt(n = Math.abs(+n || 0).toFixed(decPlaces)) + "",',
'  j = (j = i.length) > 3 ? j % 3 : 0;',
'  return sign + (j ? i.substr(0, j) + thouSep : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + thouSep) + (decPlaces ? decSep + Math.abs(n - i).toFixed(decPlaces).slice(2) : "");',
'};',
' ',
'function parseNumeric(v) {',
'  //strip any non-numeric characters and return a non-null numeric value',
'  return parseFloat(v.replace(/[^\d.-]/g,''''))||0;',
'}',
' ',
'$(document).ready(function() {',
'  //automatically format any item with the "edit_money" class',
'  $( document ).on(''change'', ''.edit_money'', function(){',
'    var i = "#"+$(this).attr("id"), v = $(i).val();',
'    if(v){ $(i).val( parseNumeric(v).formatMoney() ); }',
'  });',
'});'))
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$("#articleDiv").css("height",$("#shoppingCart").height());',
'$("#P9_SEARCH").parent().prepend("<div id=''toggles'' style=''width:200px;margin-right:150px;''>"+$(".toggle").parent().html()+"</div>");',
'$("td>button").remove();',
'$(".toggle").first().css("margin-right","-4px");',
'$("#articleDiv .t-Region-headerItems--buttons").append($("#P9_SEARCH").parent().parent().parent().parent().html());',
'$("#articleDiv .container>.row").remove();',
'$("#P9_SEARCH").css("width","200px");',
'$("#shoppingCartList").css("border-style","none none dotted none");',
'',
'',
'//console.log(scrollHeight);'))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.button_badge {',
'  background-color: #fa3e3e;',
'  border-radius: 5px;',
'  color: white;',
' ',
'  padding: 1px 5px;',
'  font-size: 12px;',
'  ',
'  position: absolute; /* Position the badge within the relatively positioned button */',
'  top: -7px;',
'  right: -7px;',
'  z-index: 99999;',
'}',
'',
'',
'',
'	span {cursor:pointer; }',
'',
'		.number{',
'			/*margin:100px;*/',
'		}',
'		.minus, .plus{',
'    width:20px;',
'    height:20px;',
'    background:#f2f2f2;',
'    border-radius:4px;',
'    /*			padding:8px 5px 8px 5px;*/',
'    border:1px solid #ddd;',
'    display: inline-block;',
'    vertical-align: middle;',
'    text-align: center;',
'		}',
'		input{',
'    			height:34px;',
'    width: 100px;',
'    text-align: center;',
'    font-size: 16px;',
'			    border:1px solid #ddd;',
'			    border-radius:4px;',
'    display: inline-block;',
'    vertical-align: middle;',
'}',
'.input-increment{',
'    position:static;',
'    right:140px;',
' /*   margin-right:20px;*/',
'    padding-top:10px;',
'    min-width:80px;',
'}',
'',
'#total-val,#discount-val{',
'   ',
'   ',
'    text-align:right;',
'}',
'.total-text{',
'    text-align:left;',
'}',
'#total-container{',
'    display:table;',
'    position:absolute;',
'    right:20px;',
'    margin-top:10px;',
'    height:50px;',
'    padding:0px;',
'    font-size:20px;',
'    font-weight: normal;',
'     text-align:right;',
'}',
'#row{',
'    display:table-row;',
'}',
'#left,#right{',
'    display:table-cell;',
'    padding:0px;',
'}',
'#left p:last-child,#right p:last-child{',
'    font-size:26px;',
'    font-weight: bold;',
'    padding:0px;',
'}',
'',
'#shoppingCartList{',
'    margin:0px;',
'    padding:0px;',
'    overflow-y: auto; ',
'    height:50vh;',
'}',
'#articleDiv .t-Region-body{',
'    height:63vh;',
'}',
'#shoppingCart .t-Region-body{',
'    height:63vh;',
'}',
'.t-MediaList-badge{',
'    width:70px;',
'}',
'',
'',
'			'))
,p_page_template_options=>'#DEFAULT#'
,p_page_component_map=>'03'
,p_last_updated_by=>'D.KALDI@ME.COM'
,p_last_upd_yyyymmddhh24miss=>'20220414144939'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(37834346166500066003)
,p_name=>'Articles'
,p_region_name=>'articleDiv'
,p_template=>wwv_flow_imp.id(37628436464620248733)
,p_display_sequence=>30
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:u-colors:t-Cards--compact:t-Cards--displayInitials:t-Cards--4cols:t-Cards--iconsRounded:t-Cards--animColorFill'
,p_new_grid_row=>false
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 9999999 freq,0 AID,''NEW ARTICLE?'' CARD_TITLE, ',
'        ''+'' CARD_INITIALS,',
'        ''<h3><img style="display:none" data-id=0 />Click Here To Add A New Article!</h3>'' CARD_TEXT,',
'        ''#'' CARD_LINK,',
'        ''#0'' CARD_SUBTEXT from dual',
'UNION',
'select  freq,AID,name CARD_TITLE, ',
unistr('        TO_CHAR(price)||''\20AC'' CARD_INITIALS,'),
'        ''<img data-id=''||AID||'' src=f?p=&APP_ID.:0:&APP_SESSION.:APPLICATION_PROCESS=GETIMAGE:::FILE_ID:''||IMG_ID||'' height=70 width=70 />'' CARD_TEXT,',
'      ',
'       ''#'' CARD_LINK,',
'       ''#''||AID CARD_SUBTEXT  ',
'from sc_article a ',
'where (:P9_SEARCH is null OR upper(name) like ''%''||upper(:P9_SEARCH)||''%'') ',
'       AND (:P9_CATEGORY is null ',
'            OR tax_id = (select tid from sc_tax where name = :P9_CATEGORY))',
'order by freq desc;'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P9_CATEGORY,P9_SEARCH'
,p_lazy_loading=>false
,p_query_row_template=>wwv_flow_imp.id(37628452748078248745)
,p_query_num_rows=>100
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_num_rows_type=>'ROWS_X_TO_Y'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(3117052358561191033)
,p_query_column_id=>1
,p_column_alias=>'FREQ'
,p_column_display_sequence=>7
,p_use_as_row_header=>'N'
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(971218910719734216)
,p_query_column_id=>2
,p_column_alias=>'AID'
,p_column_display_sequence=>6
,p_column_heading=>'Aid'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(37834346701211066009)
,p_query_column_id=>3
,p_column_alias=>'CARD_TITLE'
,p_column_display_sequence=>1
,p_column_heading=>'Card Title'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(37834347307641066015)
,p_query_column_id=>4
,p_column_alias=>'CARD_INITIALS'
,p_column_display_sequence=>5
,p_column_heading=>'Card Initials'
,p_use_as_row_header=>'N'
,p_column_format=>'FML990D00'
,p_heading_alignment=>'LEFT'
,p_report_column_width=>50
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(37834346926609066011)
,p_query_column_id=>5
,p_column_alias=>'CARD_TEXT'
,p_column_display_sequence=>3
,p_column_heading=>'Card Text'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(37834346867039066010)
,p_query_column_id=>6
,p_column_alias=>'CARD_LINK'
,p_column_display_sequence=>2
,p_column_heading=>'Card Link'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(37834347299422066014)
,p_query_column_id=>7
,p_column_alias=>'CARD_SUBTEXT'
,p_column_display_sequence=>4
,p_column_heading=>'Card Subtext'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(37843790952225235331)
,p_plug_name=>'Cash'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(37628446026907248739)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(37628385115013248693)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_imp.id(37628494900592248777)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(37888816862061084806)
,p_plug_name=>'Shopping Cart'
,p_region_name=>'shoppingCart'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(37628436464620248733)
,p_plug_display_sequence=>10
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>5
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(37834348018593066022)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(37888816862061084806)
,p_button_name=>'charge'
,p_button_static_id=>'chargeBut'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--success:t-Button--pill:t-Button--gapLeft:t-Button--gapRight'
,p_button_template_id=>wwv_flow_imp.id(37628493500667248776)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Charge'
,p_button_position=>'CHANGE'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(37888819548923084833)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(37888816862061084806)
,p_button_name=>'cancel'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--danger'
,p_button_template_id=>wwv_flow_imp.id(37628493500667248776)
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(37888819456880084832)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(37888816862061084806)
,p_button_name=>'discount'
,p_button_static_id=>'discount-but'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--large'
,p_button_template_id=>wwv_flow_imp.id(37628493500667248776)
,p_button_image_alt=>'Discount'
,p_button_position=>'HELP'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(37888821289728084850)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(37834346166500066003)
,p_button_name=>'food'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(37628493500667248776)
,p_button_image_alt=>'Food'
,p_button_position=>'TEMPLATE_DEFAULT'
,p_warn_on_unsaved_changes=>null
,p_button_css_classes=>'toggle'
,p_button_cattributes=>'attr=''food'''
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(37888821137107084849)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(37834346166500066003)
,p_button_name=>'drinks'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(37628493500667248776)
,p_button_image_alt=>'Drinks'
,p_button_position=>'TEMPLATE_DEFAULT'
,p_warn_on_unsaved_changes=>null
,p_button_css_classes=>'toggle'
,p_button_cattributes=>'attr=''drinks'''
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(971217647672734203)
,p_name=>'P9_CATEGORY'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(37843790952225235331)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(971218164144734208)
,p_name=>'P9_URL_FOOD'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(37843790952225235331)
,p_source=>'apex_util.prepare_url(''f?p=&APP_ID.:5:&SESSION.::NO:RP:P5_TAX_ID:1'',p_checksum_type => ''SESSION'',p_triggering_element => ''$("#articleDiv")'')'
,p_source_type=>'EXPRESSION'
,p_source_language=>'PLSQL'
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(971218667813734213)
,p_name=>'P9_NEW_ARTICLE'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(37843790952225235331)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(971219705179734224)
,p_name=>'P9_DISCOUNT_URL'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(37843790952225235331)
,p_source=>'apex_util.prepare_url(''f?p=&APP_ID.:12:&SESSION.::NO:RP'',p_checksum_type => ''SESSION'',p_triggering_element => ''$("#shoppingCart")'')'
,p_source_type=>'EXPRESSION'
,p_source_language=>'PLSQL'
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1961175036163930510)
,p_name=>'P9_SHOPPINGCART'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(37843790952225235331)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1961175293724930512)
,p_name=>'P9_DISCOUNT'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(37843790952225235331)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1961176816047930528)
,p_name=>'P9_URL_DRINK'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(37843790952225235331)
,p_source=>'apex_util.prepare_url(''f?p=&APP_ID.:5:&SESSION.::NO:RP:P5_TAX_ID:2'',p_checksum_type => ''SESSION'',p_triggering_element => ''$("#articleDiv")'')'
,p_source_type=>'EXPRESSION'
,p_source_language=>'PLSQL'
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(37888819641844084834)
,p_name=>'P9_SEARCH'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(37834346166500066003)
,p_prompt=>'New'
,p_placeholder=>'Search...'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(37628492130801248774)
,p_item_icon_css_classes=>'fa-search'
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:t-Form-fieldContainer--large'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(37834347434467066016)
,p_name=>'correctCardPrice'
,p_event_sequence=>10
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(37834347521743066017)
,p_event_id=>wwv_flow_imp.id(37834347434467066016)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(".t-Card-icon").css(''min-width'',''50px'');',
'$("#shoppingCart").find(".t-Region-body").css("padding","0px");',
'//$(".t-MediaList-badge").live("css",functicss("width","100px");',
'',
'$("#cartBut").append("<span class=''button_badge'' style=''display:none''></span>");',
'',
'$("#shoppingCart").find(".t-Region-body").append(''<ul class="t-MediaList t-MediaList--showIcons t-MediaList--showDesc t-MediaList--showBadges u-colors t-MediaList--stack t-MediaList--large force-fa-lg t-MediaList--iconsRounded" id="shoppingCartList" '
||'data-region-id="shoppingCart"></ul>''',
'                                                 +''<div id="total-container"><div id="row" ><div class="total-text" id="left" >''',
'                                                 +''<p>Subtotal</p><p class="u-success-text" >Discount<span id="discount_type"></span></p><p>Total</p></div>''',
unistr('                                                 +''<div id="right"><p>\20AC 0.00</p><p class="u-success-text" >\20AC -00.00</p><p>\20AC 0.00</p></div></div></div>'');'),
'',
'',
'console.log("selected value ->"+$v("P9_CATEGORY"));',
'if($v("P9_CATEGORY")!=""){',
'   $(".toggle[attr="+$v("P9_CATEGORY")+"]").addClass("t-Button--warning");',
'}',
'if($v("P9_SHOPPINGCART").length>3){',
'    var items2add = JSON.parse($v("P9_SHOPPINGCART"));',
'    console.log("%o",items2add);',
'    ',
'    $.each(items2add,function(i,o){',
'        addItem(o.id,o.qnt,o.name,o.price,o.img);',
'       ',
'    })',
'    calculateDiscount();',
'    ',
'    ',
'}else{',
'    $("#total-container .u-success").hide();',
'    $("#discount-but").attr(''disabled'',true);',
'}'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(37888816682579084804)
,p_name=>'add item '
,p_event_sequence=>20
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'.t-Cards-item'
,p_bind_type=>'live'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(37888816790097084805)
,p_event_id=>wwv_flow_imp.id(37888816682579084804)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
' var id = $(this.triggeringElement).find("img").data(''id'');',
unistr(' var price = parseFloat($(this.triggeringElement).find(''.t-Card-initials'').html().replace("\20AC",""));'),
' var name = $(this.triggeringElement).find(".t-Card-title").html();',
'addItem(id,1,name,price, $(this.triggeringElement).find(".t-Card-desc").html());',
'$("#total-container .u-success").show();',
'$("#discount-but").attr(''disabled'',false);',
'//$(this.triggeringElement);',
''))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(37888816939946084807)
,p_name=>'plus button'
,p_event_sequence=>30
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'.plus'
,p_bind_type=>'live'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(37888817044671084808)
,p_event_id=>wwv_flow_imp.id(37888816939946084807)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var countVal = parseInt($(this.triggeringElement).prev().val());',
'var id = $(this.triggeringElement).parent().parent().data(''id'');',
'addedItems.filter(function(a){return a.id ==id?a.qnt++:a;});',
'console.log("in fa plus clicked..."+countVal);',
unistr('var total = parseFloat($(this.triggeringElement).parent().next().find("span").html().replace("\20AC",""));'),
'$(this.triggeringElement).prev().val(countVal+1);',
unistr('$(this.triggeringElement).parent().next().find("span").html("\20AC "+(total+(total/countVal)).toFixed(2));'),
'',
'sumTotal();'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(37888817136067084809)
,p_name=>'minus button'
,p_event_sequence=>40
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'.minus'
,p_bind_type=>'live'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(37888817245491084810)
,p_event_id=>wwv_flow_imp.id(37888817136067084809)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var countVal = parseInt($(this.triggeringElement).next().val());',
'var id = $(this.triggeringElement).parent().parent().data(''id'');',
'',
'console.log("in fa minus clicked..."+countVal);',
'if(countVal > 1){',
'    addedItems.filter(function(v){return v.id ==id?v.qnt--:v;});',
unistr('    var total = parseFloat($(this.triggeringElement).parent().next().find("span").html().replace("\20AC",""));'),
'    $(this.triggeringElement).next().val(countVal-1);',
unistr('    $(this.triggeringElement).parent().next().find("span").html((total-(total/countVal)).toFixed(2)+" \20AC");'),
'}else{',
'    $(this.triggeringElement).parent().parent().remove();',
'    console.log("remove id ->"+$(this.triggeringElement).parent().parent().data(''id''));',
'     addedItems.splice(addedItems.findIndex(o=>o.id===id),1);',
'}',
'',
'sumTotal();'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(37888819244208084830)
,p_name=>'quantity input'
,p_event_sequence=>50
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'.cVal'
,p_bind_type=>'live'
,p_bind_delegate_to_selector=>'#shoppingCart'
,p_bind_event_type=>'change'
);
end;
/
begin
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(37888819328599084831)
,p_event_id=>wwv_flow_imp.id(37888819244208084830)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if($(this.triggeringElement).val()<1){',
'    $(this.triggeringElement).parent().parent().remove();',
'}else{',
unistr('    var unit_net = parseFloat($(this.triggeringElement).parent().prev().find(".t-MediaList-desc").html().replace("\20AC",""));'),
unistr('    $(this.triggeringElement).parent().next().find("span").html("\20AC "+($(this.triggeringElement).val()*unit_net).toFixed(2));'),
'}',
'sumTotal();'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(37888819763275084835)
,p_name=>'perform search'
,p_event_sequence=>60
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P9_SEARCH'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'this.browserEvent.which === apex.jQuery.ui.keyCode.ENTER'
,p_bind_type=>'live'
,p_bind_event_type=>'keypress'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(37888819834796084836)
,p_event_id=>wwv_flow_imp.id(37888819763275084835)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(37834346166500066003)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(37888820134573084839)
,p_event_id=>wwv_flow_imp.id(37888819763275084835)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CANCEL_EVENT'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(37888820208253084840)
,p_name=>'Reset Cart'
,p_event_sequence=>70
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(37888819548923084833)
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'addedItems.length>0'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1353114107056638601)
,p_event_id=>wwv_flow_imp.id(37888820208253084840)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'customConfirm( "Are you sure?", function( okPressed ) {',
'    if(okPressed){',
'       resetCart();',
'    }',
'}, "Yes", "No");'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(37888820457351084842)
,p_name=>'Save Cart'
,p_event_sequence=>80
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(37834348018593066022)
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'addedItems.length>0'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(37888820507826084843)
,p_event_id=>wwv_flow_imp.id(37888820457351084842)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var items = [];',
'',
'',
'$(".t-MediaList-item").each(function(){',
'    var item = new Object();',
'    item.id = $(this).data(''id'');',
'    item.qnt = $(this).find(".cVal").val();',
unistr('    item.prc = $(this).find(".t-MediaList-badge").html().replace("\20AC","").replace(" ","");'),
'    items.push(item);',
'});',
'',
'console.log("all items -> %o",items);',
'',
'    apex.server.process(',
'          ''CREATE_BILLITEM'',',
'          {',
'              x01: JSON.stringify({Items : items}),',
unistr('              x02: parseFloat($("#right p").last().html().replace("\20AC","")),'),
unistr('              x03: Math.abs(parseFloat($("#right .u-success-text").html().replace("\20AC","")))'),
'          },',
'          {',
'            dataType: ''json'',',
'            success: function(data) {',
'                apex.message.showPageSuccess(''Invoice saved.'');  ',
'               /* $("#shoppingCartList").html("");',
'                sumTotal();',
'                addedItems = [];',
'                $("#discount_type").html("");',
unistr('                $("#right .u-success-text").html("\20AC -0.00");*/'),
'                resetCart();',
'            }',
' });'))
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(3117054001821191050)
,p_event_id=>wwv_flow_imp.id(37888820457351084842)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(37834346166500066003)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(971217486706734201)
,p_name=>'show foods'
,p_event_sequence=>90
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(37888821289728084850)
,p_bind_type=>'live'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(971217511849734202)
,p_event_id=>wwv_flow_imp.id(971217486706734201)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P9_CATEGORY'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$("#P9_CATEGORY").val($(this.triggeringElement).attr(''attr''));',
'',
'',
'if(!$(this.triggeringElement).hasClass("t-Button--warning")){',
'      $(".t-Button--warning").removeClass("t-Button--warning");',
'    $(this.triggeringElement).addClass("t-Button--warning");',
'    ',
'}else{',
'     $(".t-Button--warning").removeClass("t-Button--warning");',
'    $("#P9_CATEGORY").val("");',
'}',
''))
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(971217986661734206)
,p_event_id=>wwv_flow_imp.id(971217486706734201)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(37834346166500066003)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(971217749427734204)
,p_name=>'show drinks'
,p_event_sequence=>100
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(37888821137107084849)
,p_bind_type=>'live'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(971217862455734205)
,p_event_id=>wwv_flow_imp.id(971217749427734204)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$("#P9_CATEGORY").val($(this.triggeringElement).attr(''attr''));',
'',
'',
'if(!$(this.triggeringElement).hasClass("t-Button--warning")){',
'      $(".t-Button--warning").removeClass("t-Button--warning");',
'    $(this.triggeringElement).addClass("t-Button--warning");',
'}else{',
'     $(".t-Button--warning").removeClass("t-Button--warning");',
'    $("#P9_CATEGORY").val("");',
'}',
''))
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(971218034572734207)
,p_event_id=>wwv_flow_imp.id(971217749427734204)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(37834346166500066003)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(971218261631734209)
,p_name=>'Add Article'
,p_event_sequence=>110
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(37834346166500066003)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(971218304057734210)
,p_event_id=>wwv_flow_imp.id(971218261631734209)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(37834346166500066003)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(971218473160734211)
,p_event_id=>wwv_flow_imp.id(971218261631734209)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P9_NEW_ARTICLE'
,p_attribute_01=>'DIALOG_RETURN_ITEM'
,p_attribute_09=>'N'
,p_attribute_10=>'P5_AID'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(971218725189734214)
,p_name=>'Add new Article to Cart'
,p_event_sequence=>120
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(37834346166500066003)
,p_condition_element=>'P9_NEW_ARTICLE'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'live'
,p_bind_event_type=>'apexafterrefresh'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(971218825372734215)
,p_event_id=>wwv_flow_imp.id(971218725189734214)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var id = $("#P9_NEW_ARTICLE").val();',
'console.log("#id of new article ->"+id);',
'addItem(id); '))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(971219368701734220)
,p_name=>'add discount'
,p_event_sequence=>130
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(37888819456880084832)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(971219461589734221)
,p_event_id=>wwv_flow_imp.id(971219368701734220)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'console.log($("#P9_DISCOUNT_URL").val());',
'var newUrl = apex.item(''P9_DISCOUNT_URL'').getValue().replace("width:''720''", "width:''400''");',
'console.log(newUrl);',
'apex.navigation.redirect(newUrl);'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(1353115653836638616)
,p_name=>'close discount'
,p_event_sequence=>140
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(37888816862061084806)
,p_bind_type=>'live'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1353115759759638617)
,p_event_id=>wwv_flow_imp.id(1353115653836638616)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P9_DISCOUNT'
,p_attribute_01=>'DIALOG_RETURN_ITEM'
,p_attribute_09=>'N'
,p_attribute_10=>'P12_DISCOUNT_VALUE'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1353115868557638618)
,p_event_id=>wwv_flow_imp.id(1353115653836638616)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'calculateDiscount();'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(1961176636739930526)
,p_name=>'Remove Item'
,p_event_sequence=>150
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'.fa-trash'
,p_bind_type=>'live'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1961176748852930527)
,p_event_id=>wwv_flow_imp.id(1961176636739930526)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var obj = $(this.triggeringElement).parent().parent();',
'obj.animate({''margin-left'':''-=''+obj.width()+10},500,function(){',
'    obj.remove();',
'    sumTotal();',
'});//.hide(''slow'', function(){obj.remove(); })',
'//obj.remove();',
'//$("li").css("margin-left","0px");',
'addedItems.splice(addedItems.findIndex(o=>o.id===obj.data(''id'')),1);',
''))
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(1961175138779930511)
,p_process_sequence=>10
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'SAVE_CART'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    l_cart varchar2(32000);',
'    l_discount varchar2(100);',
'BEGIN',
'    l_cart := apex_application.g_x01;',
'    l_discount := apex_application.g_x02;',
'',
'    select l_cart,l_discount INTO :P9_SHOPPINGCART, :P9_DISCOUNT from dual;',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(37888820689432084844)
,p_process_sequence=>10
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'CREATE_BILLITEM'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'   l_aid number;',
'   l_qnt number;',
'   l_prc number;',
'   l_bid number;',
'   l_total number;',
'   l_items varchar2(32767);',
'   l_msg varchar2(500);',
'   l_values apex_json.t_values;',
'    l_data_count integer;',
'   l_discount number;',
'BEGIN',
'   l_msg := ''nothing happend.'';',
'   l_items := apex_application.g_x01;',
'   l_total := apex_application.g_x02;',
'   l_discount := apex_application.g_x03;',
'/* CREATE THE BILL */',
'    ',
'  ',
'    INSERT INTO sc_invoice(total,discount) VALUES(l_total,l_discount) RETURNING bid INTO l_bid;',
'     ',
'     /* CREATE THE BILLITEMS ... */',
'   ',
'    apex_json.parse (    ',
'        p_values => l_values,    ',
'        p_source => l_items );  ',
'    ',
'    l_data_count := apex_json.get_count (    ',
'                        p_values => l_values,    ',
'                        p_path  => ''Items'' );    ',
'    ',
'    FOR i in 1 .. l_data_count loop      ',
'        l_aid := apex_json.get_varchar2( p_values => l_values, p_path  => ''Items[%d].id'',    p0      => i );',
'        l_qnt := apex_json.get_varchar2( p_values => l_values, p_path  => ''Items[%d].qnt'',    p0      => i );',
'        l_prc := apex_json.get_varchar2( p_values => l_values, p_path => ''Items[%d].qnt'', p0 => i);',
'        INSERT INTO sc_invoiceitem(article_id,quantity,invoice_id,created,total) VALUES(l_aid,l_qnt,l_bid,systimestamp,l_prc); --RETURNING pid INTO l_pid;',
'        UPDATE sc_article set freq = freq+1 where aid = l_aid;',
'    END LOOP;',
'    ',
'    apex_json.open_object;',
'    apex_json.write(''result'',''success'');',
'    apex_json.write(''err'',SQLERRM||''------>msg:''||l_msg||'' l_products -->''||l_items||'' l_data_count->''||l_data_count||'' --bid:''||l_bid||'' l_aid-->''||l_aid||'' l_qnt--->''||l_qnt||'' l_total-->''||l_total);',
'    --apex_json.write(''tid'',l_tid);',
'    apex_json.close_object;',
'',
'    exception',
'        when OTHERS then',
'            apex_json.open_object;',
'            apex_json.write(''result'',SQLERRM||''------>msg:''||l_msg||'' l_products -->''||l_items||'' l_data_count->''||l_data_count||'' --bid:''||l_bid||'' l_aid-->''||l_aid||'' l_qnt--->''||l_qnt||'' l_total-->''||l_total);',
'            apex_json.close_object;',
'',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
