prompt --application/pages/page_00009
begin
wwv_flow_imp_page.create_page(
 p_id=>9
,p_user_interface_id=>wwv_flow_imp.id(37627114721722786135)
,p_name=>'Cash Register'
,p_step_title=>'Cash Register'
,p_autocomplete_on_off=>'OFF'
,p_javascript_file_urls=>'https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js'
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
'        $(".discount_div").hide();',
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
unistr('        total += parseFloat($(this).html().replace("\20AC","").replace('','',''.''));'),
'    });',
'    console.log("in total->"+total);',
'    if(total==0){',
'        $("#total-container .u-success").hide();',
'        $("#discount-but").attr(''disabled'',true);',
'    }',
'',
unistr('    $("#right p").last().html("\20AC "+total.toFixed(2).toString().replace(''.'','',''));'),
unistr('     //$("#right p").first().html("\20AC "+total.toFixed(2));'),
'    ',
'   ',
'    calculateDiscount();',
'    ',
'    ',
'}',
'function addItem(id,qnt,name,price,img){',
'    console.log("in Additems ->"+id);',
'    var price = parseFloat(price.toString().replace('','',''.''));',
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
'            var priceTotal = (newCount*price).toFixed(2).toString().replace(''.'','','');',
'            console.log(countTd.html());',
'            console.log("--newCount->"+newCount);',
'            countTd.find(''.cVal'').val(newCount);',
unistr('            countTd.find(".t-MediaList-badge").html("\20AC "+priceTotal);'),
'            console.log("--newCount2->"+newCount);',
'            cart = countTd.parent();',
'            sumTotal();',
'// ''<img src=f?p=&APP_ID.:0:&APP_SESSION.:APPLICATION_PROCESS=GETIMAGE:::FILE_ID:''+id+'' height=70 width=70 /></span></div>',
'        }else{ ',
'            console.log("in different Article...");',
'            var artObj = new Object( {"id":id,"qnt":qnt,"name":name,"price":price,"img":img});',
'            var priceTotal = (qnt*price).toFixed(2).toString().replace(''.'','','');',
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
unistr('              +''<div class="t-MediaList-badgeWrap" style="position:relative;"><span class="t-MediaList-badge" style="margin:0px;">\20AC ''+priceTotal+''</span>'''),
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
'                $("#shoppingCartList").animate({ scrollTop: h }, 500);',
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
'                         x02: $v(''P9_DISCOUNT''),',
'                         x03: 1',
'                         },{dataType: ''text''});',
'}',
'function calculateDiscount(){',
'    var val = $("#P9_DISCOUNT").val();',
'    if (val != ""){',
'        console.log("new val ->"+val);',
'        if(val.indexOf("%")!=-1){',
'            $("#discount_type").html(" "+val);',
unistr('            val = parseFloat(val.replace("%",""))*(parseFloat($("#right p").last().html().replace("\20AC",""))/100);'),
'        }else{',
'            $("#discount_type").html("");',
unistr('            val = parseFloat(val.replace("\20AC",""));'),
'        }',
unistr('        var total = parseFloat($("#right p").last().html().replace("\20AC",""));'),
'        var newTotal = (total-val.toFixed(2)).toFixed(2).toString().replace(''.'','','');',
unistr('        $("#right .u-success-text").html("\20AC -"+val.toFixed(2).toString().replace(''.'','',''));'),
unistr('        $("#right p").last().html("\20AC "+newTotal);'),
unistr('        //$("#right p").first().html("\20AC "+(parseFloat($("#right p").last().html().replace("\20AC",""))-val).toFixed(2));'),
'         $(".discount_div").show();',
'    }else{',
'        $(".discount_div").hide();',
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
'  return parseFloat(v.replace(/[^\d.,-]/g,'''').replace('','',''.''))||0;',
'}',
'function parseFloatDE(v) {',
'  //convert any dot separated float number to comma separated number (german reading)',
'  return v.toString().replace(/[^\d.,]/g,'''').replace(''.'','','');',
'}',
' ',
'$(document).ready(function() {',
'  //automatically format any item with the "edit_money" class',
'  $( document ).on(''change'', ''.edit_money'', function(){',
'    var i = "#"+$(this).attr("id"), v = $(i).val();',
'    if(v){ $(i).val( parseNumeric(v).formatMoney() ); }',
'  });',
'});',
'',
'function save_invoice(payment){',
'    var items = [];',
'',
'',
'    $(".t-MediaList-item").each(function(){',
'        var item = new Object();',
'        item.id = $(this).data(''id'');',
'        item.qnt = $(this).find(".cVal").val();',
unistr('        item.prc = parseFloatDE($(this).find(".t-MediaList-badge").html()); //.replace("\20AC","").replace(" ","").replace('','',''.'');'),
'        items.push(item);',
'    });',
'',
'    console.log("all items -> %o",items);',
'',
'    apex.server.process(',
'          ''CREATE_BILLITEM'',',
'          {',
'              x01: JSON.stringify({Items : items}),',
unistr('              x02: $("#right p").last().html().replace("\20AC",""),'),
'              x03: parseFloatDE($("#right .u-success-text").html()),',
'              x04: payment',
'          },',
'          {',
'            dataType: ''json'',',
'            success: function(data) {',
'                if (data.result == ''success'') {',
'                ',
'                    $(".u-Processing").hide();',
'              ',
'                    apex.message.showPageSuccess( "Invoice saved!" );',
'                    resetCart();',
'                } else {',
'                    alert(''Oops! Something went terribly wrong. Please try again or contact your application administrator.'');',
'                }',
'            }',
' });',
'',
' }'))
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
,p_last_updated_by=>'MACDENIZ'
,p_last_upd_yyyymmddhh24miss=>'20220717185308'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(37832943651513603344)
,p_name=>'Products'
,p_region_name=>'articleDiv'
,p_template=>wwv_flow_imp.id(37627033949633786074)
,p_display_sequence=>30
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:u-colors:t-Cards--compact:t-Cards--displayInitials:t-Cards--4cols:t-Cards--iconsRounded:t-Cards--animColorFill'
,p_new_grid_row=>false
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 9999999 freq,0 AID,''New Product?'' CARD_TITLE, ',
'        ''+'' CARD_INITIALS,',
'        ''<h3><img style="display:none" data-id=0 />Click Here To Add A New Product!</h3>'' CARD_TEXT,',
'        ''#'' CARD_LINK,',
'        ''#0'' CARD_SUBTEXT from dual',
'UNION',
'select  freq',
'        ,ID',
'        ,name CARD_TITLE ',
unistr('        ,''\20AC ''||TO_CHAR(price,V(''CURRENCYFORMAT'')) CARD_INITIALS,'),
'        ''<img data-id=''||ID||'' src=f?p=&APP_ID.:0:&APP_SESSION.:APPLICATION_PROCESS=GETIMAGE:::FILE_ID:''||IMG_ID||'' height=70 width=70 />'' CARD_TEXT,',
'      ',
'       ''#'' CARD_LINK,',
'       ''#''||ID CARD_SUBTEXT  ',
'from sc_article a where (:P9_SEARCH is null or upper(name) like ''%''||upper(:P9_SEARCH)||''%'') and (:P9_CATEGORY is null OR tax_id = :P9_CATEGORY)',
'order by freq desc;'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P9_CATEGORY,P9_SEARCH'
,p_lazy_loading=>false
,p_query_row_template=>wwv_flow_imp.id(37627050233091786086)
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
 p_id=>wwv_flow_imp.id(3115649843574728374)
,p_query_column_id=>1
,p_column_alias=>'FREQ'
,p_column_display_sequence=>7
,p_use_as_row_header=>'N'
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(969816395733271557)
,p_query_column_id=>2
,p_column_alias=>'AID'
,p_column_display_sequence=>6
,p_column_heading=>'Aid'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(37832944186224603350)
,p_query_column_id=>3
,p_column_alias=>'CARD_TITLE'
,p_column_display_sequence=>1
,p_column_heading=>'Card Title'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(37832944792654603356)
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
 p_id=>wwv_flow_imp.id(37832944411622603352)
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
 p_id=>wwv_flow_imp.id(37832944352052603351)
,p_query_column_id=>6
,p_column_alias=>'CARD_LINK'
,p_column_display_sequence=>2
,p_column_heading=>'Card Link'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(37832944784435603355)
,p_query_column_id=>7
,p_column_alias=>'CARD_SUBTEXT'
,p_column_display_sequence=>4
,p_column_heading=>'Card Subtext'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(37842388437238772672)
,p_plug_name=>'Cash'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(37627043511920786080)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(37626982600026786034)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_imp.id(37627092385605786118)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(37887414347074622147)
,p_plug_name=>'New Invoice'
,p_region_name=>'shoppingCart'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(37627033949633786074)
,p_plug_display_sequence=>10
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>4
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(1345703651188509)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(37887414347074622147)
,p_button_name=>'coupon_payment'
,p_button_static_id=>'coupon_but'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft:t-Button--hoverIconPush'
,p_button_template_id=>wwv_flow_imp.id(37627091174184786117)
,p_button_image_alt=>'Coupon'
,p_button_position=>'CHANGE'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-newspaper-o'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(1345766699188510)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(37887414347074622147)
,p_button_name=>'card_payment'
,p_button_static_id=>'card_but'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft:t-Button--hoverIconPush'
,p_button_template_id=>wwv_flow_imp.id(37627091174184786117)
,p_button_image_alt=>'Card'
,p_button_position=>'CHANGE'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-credit-card'
,p_button_cattributes=>'style=''margin-right:5px'''
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(37832945503606603363)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(37887414347074622147)
,p_button_name=>'cash_payment'
,p_button_static_id=>'cash_but'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconLeft:t-Button--hoverIconPush'
,p_button_template_id=>wwv_flow_imp.id(37627091174184786117)
,p_button_image_alt=>'Cash'
,p_button_position=>'CHANGE'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-eur'
,p_button_cattributes=>'style=''margin-right:5px'''
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(37887417033936622174)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(37887414347074622147)
,p_button_name=>'cancel'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconLeft:t-Button--hoverIconPush'
,p_button_template_id=>wwv_flow_imp.id(37627091174184786117)
,p_button_image_alt=>'Cancel'
,p_button_position=>'DELETE'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-remove'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(784005756483008)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(37887414347074622147)
,p_button_name=>'park_invoice'
,p_button_static_id=>'park_but'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--warning:t-Button--iconLeft:t-Button--hoverIconPush'
,p_button_template_id=>wwv_flow_imp.id(37627091174184786117)
,p_button_image_alt=>'Park'
,p_button_position=>'DELETE'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-thumb-tack'
,p_button_cattributes=>'style=''margin-right:5px'''
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(37887416941893622173)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(37887414347074622147)
,p_button_name=>'discount'
,p_button_static_id=>'discount-but'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft:t-Button--hoverIconPush'
,p_button_template_id=>wwv_flow_imp.id(37627091174184786117)
,p_button_image_alt=>'Discount'
,p_button_position=>'DELETE'
,p_button_redirect_url=>'f?p=&APP_ID.:12:&SESSION.::&DEBUG.:CR,12:P12_DISCOUNT_CAT,P12_DISCOUNT_VALUE:&P9_DISCOUNT_CAT.,&P9_DISCOUNT.'
,p_icon_css_classes=>'fa-percent'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(37887418774741622191)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(37832943651513603344)
,p_button_name=>'food'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(37627090985680786117)
,p_button_image_alt=>'Food'
,p_button_position=>'TEMPLATE_DEFAULT'
,p_warn_on_unsaved_changes=>null
,p_button_css_classes=>'toggle'
,p_button_cattributes=>'attr=''1'''
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(37887418622120622190)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(37832943651513603344)
,p_button_name=>'drinks'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(37627090985680786117)
,p_button_image_alt=>'Drinks'
,p_button_position=>'TEMPLATE_DEFAULT'
,p_warn_on_unsaved_changes=>null
,p_button_css_classes=>'toggle'
,p_button_cattributes=>'attr=''2'''
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1182036776520471)
,p_name=>'P9_DISCOUNT_VALUE'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(37842388437238772672)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1182054665520472)
,p_name=>'P9_DISCOUNT_CAT'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(37842388437238772672)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(969815132686271544)
,p_name=>'P9_CATEGORY'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(37842388437238772672)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(969815649158271549)
,p_name=>'P9_URL_FOOD'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(37842388437238772672)
,p_source=>'apex_util.prepare_url(''f?p=&APP_ID.:5:&SESSION.::NO:RP:P5_TAX_ID:1'',p_checksum_type => ''SESSION'',p_triggering_element => ''$("#articleDiv")'')'
,p_source_type=>'EXPRESSION'
,p_source_language=>'PLSQL'
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(969816152827271554)
,p_name=>'P9_NEW_ARTICLE'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(37842388437238772672)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(969817190193271565)
,p_name=>'P9_DISCOUNT_URL'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(37842388437238772672)
,p_source=>'apex_util.prepare_url(''f?p=&APP_ID.:12:&SESSION.::NO:RP'',p_checksum_type => ''SESSION'',p_triggering_element => ''$("#shoppingCart")'')'
,p_source_type=>'EXPRESSION'
,p_source_language=>'PLSQL'
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1959772521177467851)
,p_name=>'P9_SHOPPINGCART'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(37842388437238772672)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1959772778738467853)
,p_name=>'P9_DISCOUNT'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(37842388437238772672)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(1959774301061467869)
,p_name=>'P9_URL_DRINK'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(37842388437238772672)
,p_source=>'apex_util.prepare_url(''f?p=&APP_ID.:5:&SESSION.::NO:RP:P5_TAX_ID:2'',p_checksum_type => ''SESSION'',p_triggering_element => ''$("#articleDiv")'')'
,p_source_type=>'EXPRESSION'
,p_source_language=>'PLSQL'
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(37887417126857622175)
,p_name=>'P9_SEARCH'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(37832943651513603344)
,p_prompt=>'New'
,p_placeholder=>'Search...'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(37627089615814786115)
,p_item_icon_css_classes=>'fa-search'
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:t-Form-fieldContainer--large'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(37832944919480603357)
,p_name=>'correctCardPrice'
,p_event_sequence=>10
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(37832945006756603358)
,p_event_id=>wwv_flow_imp.id(37832944919480603357)
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
'                                                 +''<p class="u-success-text discount_div" style="display:none">-Discount<span id="discount_type"></span></p><p>Total </p></div>''',
unistr('                                                 +''<div id="right" style="padding-left:10px"><p class="u-success-text discount_div" style="display:none" > \20AC -00,00 </p><p> \20AC 0,00 </p></div></div></div>'');'),
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
end;
/
begin
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(37887414167592622145)
,p_name=>'add item '
,p_event_sequence=>20
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'.t-Cards-item'
,p_bind_type=>'live'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(37887414275110622146)
,p_event_id=>wwv_flow_imp.id(37887414167592622145)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var id = $(this.triggeringElement).find("img").data(''id'');',
unistr('var price = $(this.triggeringElement).find(''.t-Card-initials'').html().replace("\20AC","");'),
'var name = $(this.triggeringElement).find(".t-Card-title").html();',
'addItem(id,1,name,price, $(this.triggeringElement).find(".t-Card-desc").html());',
'$("#total-container .u-success").show();',
'$("#discount-but").attr(''disabled'',false);',
'//$(this.triggeringElement);',
''))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(37887414424959622148)
,p_name=>'plus button'
,p_event_sequence=>30
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'.plus'
,p_bind_type=>'live'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(37887414529684622149)
,p_event_id=>wwv_flow_imp.id(37887414424959622148)
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
 p_id=>wwv_flow_imp.id(37887414621080622150)
,p_name=>'minus button'
,p_event_sequence=>40
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'.minus'
,p_bind_type=>'live'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(37887414730504622151)
,p_event_id=>wwv_flow_imp.id(37887414621080622150)
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
 p_id=>wwv_flow_imp.id(37887416729221622171)
,p_name=>'quantity input'
,p_event_sequence=>50
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'.cVal'
,p_bind_type=>'live'
,p_bind_delegate_to_selector=>'#shoppingCart'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(37887416813612622172)
,p_event_id=>wwv_flow_imp.id(37887416729221622171)
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
 p_id=>wwv_flow_imp.id(37887417248288622176)
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
 p_id=>wwv_flow_imp.id(37887417319809622177)
,p_event_id=>wwv_flow_imp.id(37887417248288622176)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(37832943651513603344)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(37887417619586622180)
,p_event_id=>wwv_flow_imp.id(37887417248288622176)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CANCEL_EVENT'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(37887417693266622181)
,p_name=>'Reset Cart'
,p_event_sequence=>70
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(37887417033936622174)
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'addedItems.length>0'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1351711592070175942)
,p_event_id=>wwv_flow_imp.id(37887417693266622181)
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
 p_id=>wwv_flow_imp.id(37887417942364622183)
,p_name=>'Save Cart'
,p_event_sequence=>80
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'#cash_but,#card_but,#coupon_but,#park_but'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'addedItems.length>0'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(37887417992839622184)
,p_event_id=>wwv_flow_imp.id(37887417942364622183)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'save_invoice($(this.triggeringElement).attr(''id'').replace(''_but'',''''));',
''))
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(3115651486834728391)
,p_event_id=>wwv_flow_imp.id(37887417942364622183)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(37832943651513603344)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(969814971720271542)
,p_name=>'show foods'
,p_event_sequence=>90
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(37887418774741622191)
,p_bind_type=>'live'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(969814996863271543)
,p_event_id=>wwv_flow_imp.id(969814971720271542)
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
 p_id=>wwv_flow_imp.id(969815471675271547)
,p_event_id=>wwv_flow_imp.id(969814971720271542)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(37832943651513603344)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(969815234441271545)
,p_name=>'show drinks'
,p_event_sequence=>100
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(37887418622120622190)
,p_bind_type=>'live'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(969815347469271546)
,p_event_id=>wwv_flow_imp.id(969815234441271545)
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
 p_id=>wwv_flow_imp.id(969815519586271548)
,p_event_id=>wwv_flow_imp.id(969815234441271545)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(37832943651513603344)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(969815746645271550)
,p_name=>'Add Article'
,p_event_sequence=>110
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(37832943651513603344)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(969815789071271551)
,p_event_id=>wwv_flow_imp.id(969815746645271550)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(37832943651513603344)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(969815958174271552)
,p_event_id=>wwv_flow_imp.id(969815746645271550)
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
 p_id=>wwv_flow_imp.id(969816210203271555)
,p_name=>'Add new Article to Cart'
,p_event_sequence=>120
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(37832943651513603344)
,p_condition_element=>'P9_NEW_ARTICLE'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'live'
,p_bind_event_type=>'apexafterrefresh'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(969816310386271556)
,p_event_id=>wwv_flow_imp.id(969816210203271555)
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
 p_id=>wwv_flow_imp.id(969816853715271561)
,p_name=>'add discount'
,p_event_sequence=>130
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(37887416941893622173)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'NEVER'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(969816946603271562)
,p_event_id=>wwv_flow_imp.id(969816853715271561)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'console.log($("#P9_DISCOUNT_URL").val());',
'var newUrl = apex.item(''P9_DISCOUNT_URL'').getValue().replace("width:''720''", "width:''400''");',
'console.log(newUrl);',
'apex.navigation.redirect(newUrl);'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(1351713138850175957)
,p_name=>'close discount'
,p_event_sequence=>140
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(37887414347074622147)
,p_bind_type=>'live'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1351713244773175958)
,p_event_id=>wwv_flow_imp.id(1351713138850175957)
,p_event_result=>'TRUE'
,p_action_sequence=>30
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
 p_id=>wwv_flow_imp.id(1351713353571175959)
,p_event_id=>wwv_flow_imp.id(1351713138850175957)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P9_DISCOUNT_CAT'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'sumTotal();',
'let discount_cat = $v("P9_DISCOUNT").includes(''%'')? ''percent'':''cash'';',
'$s("P9_DISCOUNT_CAT",discount_cat);'))
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1182560457520477)
,p_event_id=>wwv_flow_imp.id(1351713138850175957)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'NULL;'
,p_attribute_02=>'P9_DISCOUNT,P9_DISCOUNT_CAT'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(1959774121753467867)
,p_name=>'Remove Item'
,p_event_sequence=>150
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'.fa-trash'
,p_bind_type=>'live'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(1959774233866467868)
,p_event_id=>wwv_flow_imp.id(1959774121753467867)
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
 p_id=>wwv_flow_imp.id(1959772623793467852)
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
 p_id=>wwv_flow_imp.id(37887418174445622185)
,p_process_sequence=>10
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'CREATE_BILLITEM'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'     l_scope    logger_logs.scope%TYPE := LOWER ($$plsql_unit) || ''.'' || get_proc_name_scope_context ($$plsql_unit, $$plsql_line);',
'     l_params   logger.tab_param;',
'   l_items varchar2(32767);',
'   l_msg varchar2(500);',
'   l_values apex_json.t_values;',
'   l_data_count integer;',
'   l_inv SC_INVOICE%ROWTYPE;',
'   l_invitem SC_INVOICEITEM%ROWTYPE;',
'   l_price NUMBER;',
'BEGIN',
'    logger.append_param (p_params => l_params, p_name => ''apex_application.g_x01'', p_val => apex_application.g_x01);',
'    logger.append_param (p_params => l_params, p_name => ''apex_application.g_x02'', p_val => apex_application.g_x02);',
'    logger.append_param (p_params => l_params, p_name => ''apex_application.g_x03'', p_val => apex_application.g_x03);',
'    logger.append_param (p_params => l_params, p_name => ''apex_application.g_x04'', p_val => apex_application.g_x04);',
'   -- l_price := REPLACE(apex_application.g_x02,''.'','','');',
'    logger.append_param (p_params => l_params, p_name => ''l_price'', p_val => l_price);',
'    ',
'    logger.log_information (''saving invoice'',',
'                            l_scope,',
'                            NULL,',
'                            l_params);',
'   l_msg := ''nothing happend.'';',
'   l_items := apex_application.g_x01;',
'   l_inv.total := apex_application.g_x02;',
'   l_inv.discount := apex_application.g_x03;',
'   l_inv.status := CASE WHEN apex_application.g_x04 = ''park'' THEN ''Open'' ELSE ''Closed'' END;',
'   l_inv.payment_id := API_SMARTCASH.get_payment_id(REPLACE(apex_application.g_x04,''park'',''CASH''));',
'/* CREATE THE INVOICE */',
'    ',
'  ',
'    API_SMARTCASH.SAVE_INVOICE(l_inv);',
'     ',
'     /* CREATE THE INVOICEITEMS ... */',
'   ',
'    apex_json.parse (    ',
'        p_values => l_values,    ',
'        p_source => l_items );  ',
'    ',
'    l_data_count := apex_json.get_count (    ',
'                        p_values => l_values,    ',
'                        p_path  => ''Items'' );    ',
'    ',
'    FOR i in 1 .. l_data_count loop',
'        l_invitem.id := NULL;',
'        l_invitem.invoice_id := l_inv.id;      ',
'        l_invitem.article_id := apex_json.get_varchar2( p_values => l_values, p_path  => ''Items[%d].id'',    p0      => i );',
'        l_invitem.quantity := apex_json.get_varchar2( p_values => l_values, p_path  => ''Items[%d].qnt'',    p0      => i );',
'       -- l_invitem.total := apex_json.get_varchar2( p_values => l_values, p_path => ''Items[%d].qnt'', p0 => i);',
'        ',
'        API_SMARTCASH.SAVE_INVOICEITEM(l_invitem);',
'    END LOOP;',
'    ',
'    apex_json.open_object;',
'    apex_json.write(''result'',''success'');',
'    --apex_json.write(''err'',SQLERRM||''------>msg:''||l_msg||'' l_products -->''||l_items||'' l_data_count->''||l_data_count);',
'    --apex_json.write(''tid'',l_tid);',
'    apex_json.close_object;',
'',
'    exception',
'        when OTHERS then',
'            logger.log_error(''invoice couldnt be saved'', ''CREATE_BILLITEM'',SQLERRM);',
'            apex_json.open_object;',
'            apex_json.write(''result'',SQLERRM||''------>msg:''||l_msg||'' l_products -->''||l_items||'' l_data_count->''||l_data_count);',
'            apex_json.close_object;',
'',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
