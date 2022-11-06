prompt --application/shared_components/reports/report_layouts/daily_pdf_generic
begin
    wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
    wwv_flow_imp.g_varchar2_table(1) := '<?xml version = ''1.0'' encoding = ''utf-8''?>'||wwv_flow.LF||
'<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.or';
    wwv_flow_imp.g_varchar2_table(2) := 'g/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xlink="http://www.w3.org/19';
    wwv_flow_imp.g_varchar2_table(3) := '99/xlink">'||wwv_flow.LF||
'   <xsl:variable name="_XDOFOPOS" select="''''"/>'||wwv_flow.LF||
'   <xsl:variable name="_XDOFOPOS2" select';
    wwv_flow_imp.g_varchar2_table(4) := '="number(1)"/>'||wwv_flow.LF||
'   <xsl:variable name="_XDOFOTOTAL" select="number(1)"/>'||wwv_flow.LF||
'   <xsl:variable name="_XDOF';
    wwv_flow_imp.g_varchar2_table(5) := 'OOSTOTAL" select="number(0)"/>'||wwv_flow.LF||
'   <xsl:attribute-set name="padding">'||wwv_flow.LF||
'      <xsl:attribute name="padd';
    wwv_flow_imp.g_varchar2_table(6) := 'ing-bottom">0.25pt</xsl:attribute>'||wwv_flow.LF||
'      <xsl:attribute name="padding-top">0.25pt</xsl:attribute>'||wwv_flow.LF||
'  ';
    wwv_flow_imp.g_varchar2_table(7) := ' </xsl:attribute-set>'||wwv_flow.LF||
'   <xsl:attribute-set name="text">'||wwv_flow.LF||
'      <xsl:attribute name="text-align">star';
    wwv_flow_imp.g_varchar2_table(8) := 't</xsl:attribute>'||wwv_flow.LF||
'      <xsl:attribute name="orphans">2</xsl:attribute>'||wwv_flow.LF||
'      <xsl:attribute name="s';
    wwv_flow_imp.g_varchar2_table(9) := 'tart-indent">0.0pt</xsl:attribute>'||wwv_flow.LF||
'      <xsl:attribute name="linefeed-treatment">preserve</xsl:attr';
    wwv_flow_imp.g_varchar2_table(10) := 'ibute>'||wwv_flow.LF||
'      <xsl:attribute name="padding-top">0.0pt</xsl:attribute>'||wwv_flow.LF||
'      <xsl:attribute name="end-';
    wwv_flow_imp.g_varchar2_table(11) := 'indent">0.0pt</xsl:attribute>'||wwv_flow.LF||
'      <xsl:attribute name="padding-bottom">0.0pt</xsl:attribute>'||wwv_flow.LF||
'     ';
    wwv_flow_imp.g_varchar2_table(12) := ' <xsl:attribute name="height">0.0pt</xsl:attribute>'||wwv_flow.LF||
'      <xsl:attribute name="widows">2</xsl:attrib';
    wwv_flow_imp.g_varchar2_table(13) := 'ute>'||wwv_flow.LF||
'   </xsl:attribute-set>'||wwv_flow.LF||
'   <xsl:attribute-set name="align-left">'||wwv_flow.LF||
'      <xsl:attribute name="tex';
    wwv_flow_imp.g_varchar2_table(14) := 't-align">left</xsl:attribute>'||wwv_flow.LF||
'   </xsl:attribute-set>'||wwv_flow.LF||
'   <xsl:attribute-set name="align-center">'||wwv_flow.LF||
'   ';
    wwv_flow_imp.g_varchar2_table(15) := '   <xsl:attribute name="text-align">center</xsl:attribute>'||wwv_flow.LF||
'   </xsl:attribute-set>'||wwv_flow.LF||
'   <xsl:attribute';
    wwv_flow_imp.g_varchar2_table(16) := '-set name="align-right">'||wwv_flow.LF||
'      <xsl:attribute name="text-align">right</xsl:attribute>'||wwv_flow.LF||
'   </xsl:attri';
    wwv_flow_imp.g_varchar2_table(17) := 'bute-set>'||wwv_flow.LF||
'   <xsl:attribute-set name="footer">'||wwv_flow.LF||
'      <xsl:attribute name="text-align">right</xsl:att';
    wwv_flow_imp.g_varchar2_table(18) := 'ribute>'||wwv_flow.LF||
'      <xsl:attribute name="start-indent">5.4pt</xsl:attribute>'||wwv_flow.LF||
'      <xsl:attribute name="en';
    wwv_flow_imp.g_varchar2_table(19) := 'd-indent">5.4pt</xsl:attribute>'||wwv_flow.LF||
'   </xsl:attribute-set>'||wwv_flow.LF||
'   <xsl:attribute-set name="text_2">'||wwv_flow.LF||
'      <';
    wwv_flow_imp.g_varchar2_table(20) := 'xsl:attribute name="start-indent">5.4pt</xsl:attribute>'||wwv_flow.LF||
'      <xsl:attribute name="end-indent">23.4p';
    wwv_flow_imp.g_varchar2_table(21) := 't</xsl:attribute>'||wwv_flow.LF||
'   </xsl:attribute-set>'||wwv_flow.LF||
'   <xsl:attribute-set name="text_20">'||wwv_flow.LF||
'      <xsl:attribute';
    wwv_flow_imp.g_varchar2_table(22) := ' name="height">13.872pt</xsl:attribute>'||wwv_flow.LF||
'      <xsl:attribute name="end-indent">5.4pt</xsl:attribute>';
    wwv_flow_imp.g_varchar2_table(23) := ''||wwv_flow.LF||
'   </xsl:attribute-set>'||wwv_flow.LF||
'   <xsl:attribute-set name="text_0">'||wwv_flow.LF||
'      <xsl:attribute name="end-indent"';
    wwv_flow_imp.g_varchar2_table(24) := '>5.4pt</xsl:attribute>'||wwv_flow.LF||
'   </xsl:attribute-set>'||wwv_flow.LF||
'   <xsl:attribute-set name="page-header">'||wwv_flow.LF||
'      <xsl:';
    wwv_flow_imp.g_varchar2_table(25) := 'attribute name="color">#PAGE_HEADER_FONT_COLOR#</xsl:attribute>'||wwv_flow.LF||
'      <xsl:attribute name="font-fami';
    wwv_flow_imp.g_varchar2_table(26) := 'ly">#PAGE_HEADER_FONT_FAMILY#</xsl:attribute>'||wwv_flow.LF||
'      <xsl:attribute name="white-space-collapse">false';
    wwv_flow_imp.g_varchar2_table(27) := '</xsl:attribute>'||wwv_flow.LF||
'      <xsl:attribute name="font-size">#PAGE_HEADER_FONT_SIZE#pt</xsl:attribute>'||wwv_flow.LF||
'   ';
    wwv_flow_imp.g_varchar2_table(28) := '   <xsl:attribute name="font-weight">#PAGE_HEADER_FONT_WEIGHT#</xsl:attribute>'||wwv_flow.LF||
'   </xsl:attribute-se';
    wwv_flow_imp.g_varchar2_table(29) := 't>'||wwv_flow.LF||
'   <xsl:attribute-set name="page-footer">'||wwv_flow.LF||
'      <xsl:attribute name="color">#PAGE_FOOTER_FONT_COL';
    wwv_flow_imp.g_varchar2_table(30) := 'OR#</xsl:attribute>'||wwv_flow.LF||
'      <xsl:attribute name="font-family">#PAGE_FOOTER_FONT_FAMILY#</xsl:attribute';
    wwv_flow_imp.g_varchar2_table(31) := '>'||wwv_flow.LF||
'      <xsl:attribute name="white-space-collapse">false</xsl:attribute>'||wwv_flow.LF||
'      <xsl:attribute name="';
    wwv_flow_imp.g_varchar2_table(32) := 'font-size">#PAGE_FOOTER_FONT_SIZE#pt</xsl:attribute>'||wwv_flow.LF||
'      <xsl:attribute name="font-weight">#PAGE_F';
    wwv_flow_imp.g_varchar2_table(33) := 'OOTER_FONT_WEIGHT#</xsl:attribute>'||wwv_flow.LF||
'   </xsl:attribute-set>'||wwv_flow.LF||
'   <xsl:attribute-set name="body-font">'||wwv_flow.LF||
' ';
    wwv_flow_imp.g_varchar2_table(34) := '     <xsl:attribute name="height">12.0pt</xsl:attribute>'||wwv_flow.LF||
'      <xsl:attribute name="font-family">#BO';
    wwv_flow_imp.g_varchar2_table(35) := 'DY_FONT_FAMILY#</xsl:attribute>'||wwv_flow.LF||
'      <xsl:attribute name="white-space-collapse">false</xsl:attribut';
    wwv_flow_imp.g_varchar2_table(36) := 'e>'||wwv_flow.LF||
'      <xsl:attribute name="font-size">#BODY_FONT_SIZE#pt</xsl:attribute>'||wwv_flow.LF||
'      <xsl:attribute nam';
    wwv_flow_imp.g_varchar2_table(37) := 'e="font-weight">#BODY_FONT_WEIGHT#</xsl:attribute>'||wwv_flow.LF||
'   </xsl:attribute-set>'||wwv_flow.LF||
'   <xsl:attribute-set nam';
    wwv_flow_imp.g_varchar2_table(38) := 'e="page-number">'||wwv_flow.LF||
'      <xsl:attribute name="height">13.872pt</xsl:attribute>'||wwv_flow.LF||
'   </xsl:attribute-set>';
    wwv_flow_imp.g_varchar2_table(39) := ''||wwv_flow.LF||
'   <xsl:attribute-set name="header-font">'||wwv_flow.LF||
'      <xsl:attribute name="height">#HEADER_FONT_SIZE#pt</';
    wwv_flow_imp.g_varchar2_table(40) := 'xsl:attribute>'||wwv_flow.LF||
'      <xsl:attribute name="font-family">#HEADER_FONT_FAMILY#</xsl:attribute>'||wwv_flow.LF||
'      <x';
    wwv_flow_imp.g_varchar2_table(41) := 'sl:attribute name="white-space-collapse">false</xsl:attribute>'||wwv_flow.LF||
'      <xsl:attribute name="font-size"';
    wwv_flow_imp.g_varchar2_table(42) := '>#HEADER_FONT_SIZE#pt</xsl:attribute>'||wwv_flow.LF||
'      <xsl:attribute name="font-weight">#HEADER_FONT_WEIGHT#</';
    wwv_flow_imp.g_varchar2_table(43) := 'xsl:attribute>'||wwv_flow.LF||
'   </xsl:attribute-set>'||wwv_flow.LF||
'   <xsl:attribute-set name="border">'||wwv_flow.LF||
'      <xsl:attribute nam';
    wwv_flow_imp.g_varchar2_table(44) := 'e="border-top">#BORDER_WIDTH#pt solid #BORDER_COLOR#</xsl:attribute>'||wwv_flow.LF||
'      <xsl:attribute name="bord';
    wwv_flow_imp.g_varchar2_table(45) := 'er-bottom">#BORDER_WIDTH#pt solid #BORDER_COLOR#</xsl:attribute>'||wwv_flow.LF||
'      <xsl:attribute name="border-s';
    wwv_flow_imp.g_varchar2_table(46) := 'tart-width">#BORDER_WIDTH#pt</xsl:attribute>'||wwv_flow.LF||
'      <xsl:attribute name="border-start-color">#BORDER_';
    wwv_flow_imp.g_varchar2_table(47) := 'COLOR#</xsl:attribute>'||wwv_flow.LF||
'      <xsl:attribute name="border-start-style">solid</xsl:attribute>'||wwv_flow.LF||
'      <x';
    wwv_flow_imp.g_varchar2_table(48) := 'sl:attribute name="border-end-width">#BORDER_WIDTH#pt</xsl:attribute>'||wwv_flow.LF||
'      <xsl:attribute name="bor';
    wwv_flow_imp.g_varchar2_table(49) := 'der-end-color">#BORDER_COLOR#</xsl:attribute>'||wwv_flow.LF||
'      <xsl:attribute name="border-end-style">solid</xs';
    wwv_flow_imp.g_varchar2_table(50) := 'l:attribute>'||wwv_flow.LF||
'   </xsl:attribute-set>'||wwv_flow.LF||
'   <xsl:attribute-set name="cell">'||wwv_flow.LF||
'      <xsl:attribute name="b';
    wwv_flow_imp.g_varchar2_table(51) := 'ackground-color">#BODY_BG_COLOR#</xsl:attribute>'||wwv_flow.LF||
'      <xsl:attribute name="color">#BODY_FONT_COLOR#';
    wwv_flow_imp.g_varchar2_table(52) := '</xsl:attribute>'||wwv_flow.LF||
'      <xsl:attribute name="padding-start">5.15pt</xsl:attribute>'||wwv_flow.LF||
'      <xsl:attribu';
    wwv_flow_imp.g_varchar2_table(53) := 'te name="vertical-align">top</xsl:attribute>'||wwv_flow.LF||
'      <xsl:attribute name="padding-top">0.0pt</xsl:attr';
    wwv_flow_imp.g_varchar2_table(54) := 'ibute>'||wwv_flow.LF||
'      <xsl:attribute name="padding-end">5.15pt</xsl:attribute>'||wwv_flow.LF||
'      <xsl:attribute name="num';
    wwv_flow_imp.g_varchar2_table(55) := 'ber-columns-spanned">1</xsl:attribute>'||wwv_flow.LF||
'      <xsl:attribute name="height">0.0pt</xsl:attribute>'||wwv_flow.LF||
'    ';
    wwv_flow_imp.g_varchar2_table(56) := '  <xsl:attribute name="padding-bottom">0.0pt</xsl:attribute>'||wwv_flow.LF||
'   </xsl:attribute-set>'||wwv_flow.LF||
'   <xsl:attribu';
    wwv_flow_imp.g_varchar2_table(57) := 'te-set name="header-color">'||wwv_flow.LF||
'      <xsl:attribute name="background-color">#HEADER_BG_COLOR#</xsl:attr';
    wwv_flow_imp.g_varchar2_table(58) := 'ibute>'||wwv_flow.LF||
'      <xsl:attribute name="color">#HEADER_FONT_COLOR#</xsl:attribute>'||wwv_flow.LF||
'   </xsl:attribute-set>';
    wwv_flow_imp.g_varchar2_table(59) := ''||wwv_flow.LF||
'   <xsl:template match="/">'||wwv_flow.LF||
'      <fo:root>'||wwv_flow.LF||
'         <fo:layout-master-set>'||wwv_flow.LF||
'            <fo:simple-';
    wwv_flow_imp.g_varchar2_table(60) := 'page-master master-name="master0" margin-left="66.6pt" margin-right="66.6pt" page-height="#PAGE_HEIG';
    wwv_flow_imp.g_varchar2_table(61) := 'HT#pt" page-width="#PAGE_WIDTH#pt" margin-top="36.0pt" margin-bottom="36.0pt">'||wwv_flow.LF||
'               <fo:re';
    wwv_flow_imp.g_varchar2_table(62) := 'gion-body region-name="region-body" margin-top="54.0pt" margin-bottom="54.0pt"/>'||wwv_flow.LF||
'               <fo:';
    wwv_flow_imp.g_varchar2_table(63) := 'region-before region-name="region-header" extent="54.0pt"/>'||wwv_flow.LF||
'               <fo:region-after region-n';
    wwv_flow_imp.g_varchar2_table(64) := 'ame="region-footer" extent="54.0pt" display-align="after"/>'||wwv_flow.LF||
'            </fo:simple-page-master>'||wwv_flow.LF||
'   ';
    wwv_flow_imp.g_varchar2_table(65) := '      </fo:layout-master-set>'||wwv_flow.LF||
'         <fo:page-sequence master-reference="master0">'||wwv_flow.LF||
'            <xs';
    wwv_flow_imp.g_varchar2_table(66) := 'l:variable name="_PW" select="number(#PAGE_HEIGHT#)"/>'||wwv_flow.LF||
'            <xsl:variable name="_PH" select="';
    wwv_flow_imp.g_varchar2_table(67) := 'number(#PAGE_WIDTH#)"/>'||wwv_flow.LF||
'            <xsl:variable name="_ML" select="number(72.0)"/>'||wwv_flow.LF||
'            <xs';
    wwv_flow_imp.g_varchar2_table(68) := 'l:variable name="_MR" select="number(72.0)"/>'||wwv_flow.LF||
'            <xsl:variable name="_MT" select="number(90';
    wwv_flow_imp.g_varchar2_table(69) := '.0)"/>'||wwv_flow.LF||
'            <xsl:variable name="_MB" select="number(90.0)"/>'||wwv_flow.LF||
'            <xsl:variable name="';
    wwv_flow_imp.g_varchar2_table(70) := '_HY" select="number(36.0)"/>'||wwv_flow.LF||
'            <xsl:variable name="_FY" select="number(36.0)"/>'||wwv_flow.LF||
'          ';
    wwv_flow_imp.g_varchar2_table(71) := '  <xsl:variable name="_SECTION_NAME" select="string(''master0'')"/>'||wwv_flow.LF||
'            <fo:static-content flo';
    wwv_flow_imp.g_varchar2_table(72) := 'w-name="region-header">'||wwv_flow.LF||
'               <fo:block xsl:use-attribute-sets="text text_2 text_0 #PAGE_HE';
    wwv_flow_imp.g_varchar2_table(73) := 'ADER_ALIGNMENT#">'||wwv_flow.LF||
'                  <fo:inline xsl:use-attribute-sets="page-header">#PAGE_HEADER#</f';
    wwv_flow_imp.g_varchar2_table(74) := 'o:inline>'||wwv_flow.LF||
'               </fo:block>'||wwv_flow.LF||
'            </fo:static-content>'||wwv_flow.LF||
'            <fo:static-content';
    wwv_flow_imp.g_varchar2_table(75) := ' flow-name="region-footer">'||wwv_flow.LF||
'               <fo:block xsl:use-attribute-sets="text footer">'||wwv_flow.LF||
'         ';
    wwv_flow_imp.g_varchar2_table(76) := '         <fo:inline xsl:use-attribute-sets="body-font page-number">'||wwv_flow.LF||
'                     <fo:page-nu';
    wwv_flow_imp.g_varchar2_table(77) := 'mber/>'||wwv_flow.LF||
'                  </fo:inline>'||wwv_flow.LF||
'               </fo:block>'||wwv_flow.LF||
'               <fo:block xsl:use-at';
    wwv_flow_imp.g_varchar2_table(78) := 'tribute-sets="text text_2 #PAGE_FOOTER_ALIGNMENT#">'||wwv_flow.LF||
'                  <fo:inline xsl:use-attribute-s';
    wwv_flow_imp.g_varchar2_table(79) := 'ets="page-footer">#PAGE_FOOTER#</fo:inline>'||wwv_flow.LF||
'               </fo:block>'||wwv_flow.LF||
'            </fo:static-conte';
    wwv_flow_imp.g_varchar2_table(80) := 'nt>'||wwv_flow.LF||
'            <fo:flow flow-name="region-body">'||wwv_flow.LF||
'               <fo:block xsl:use-attribute-sets="p';
    wwv_flow_imp.g_varchar2_table(81) := 'adding">'||wwv_flow.LF||
'                  <fo:table start-indent="0.0pt">'||wwv_flow.LF||
'                     <xsl:variable name="';
    wwv_flow_imp.g_varchar2_table(82) := '_XDOFOPOS2" select="number(1)"/>'||wwv_flow.LF||
'                     <xsl:variable name="_XDOFOTOTAL" select="numbe';
    wwv_flow_imp.g_varchar2_table(83) := 'r(1)"/>'||wwv_flow.LF||
'#PRN_TABLE_CELLS#                     <fo:table-header>'||wwv_flow.LF||
'                        <fo:table-ro';
    wwv_flow_imp.g_varchar2_table(84) := 'w>'||wwv_flow.LF||
'#PRN_TEMPLATE_HEADER_ROW#                        </fo:table-row>'||wwv_flow.LF||
'                     </fo:table-';
    wwv_flow_imp.g_varchar2_table(85) := 'header>'||wwv_flow.LF||
'                     <fo:table-body>'||wwv_flow.LF||
'                        <xsl:for-each select=".//ROW">'||wwv_flow.LF||
'';
    wwv_flow_imp.g_varchar2_table(86) := '                           <fo:table-row>'||wwv_flow.LF||
'#PRN_TEMPLATE_BODY_ROW#                           </fo:tab';
    wwv_flow_imp.g_varchar2_table(87) := 'le-row>'||wwv_flow.LF||
'                        </xsl:for-each>'||wwv_flow.LF||
'                     </fo:table-body>'||wwv_flow.LF||
'              ';
    wwv_flow_imp.g_varchar2_table(88) := '    </fo:table>'||wwv_flow.LF||
'               </fo:block>'||wwv_flow.LF||
'               <fo:block xsl:use-attribute-sets="text tex';
    wwv_flow_imp.g_varchar2_table(89) := 't_2 text_20">'||wwv_flow.LF||
'                  <fo:inline id="{concat(''page-total-'', $_SECTION_NAME, $_XDOFOPOS)}"/';
    wwv_flow_imp.g_varchar2_table(90) := '>'||wwv_flow.LF||
'                  <fo:inline id="{concat(''page-total'', $_XDOFOPOS)}"/>'||wwv_flow.LF||
'               </fo:block>'||wwv_flow.LF||
'';
    wwv_flow_imp.g_varchar2_table(91) := '            </fo:flow>'||wwv_flow.LF||
'         </fo:page-sequence>'||wwv_flow.LF||
'      </fo:root>'||wwv_flow.LF||
'   </xsl:template>'||wwv_flow.LF||
'</xsl:styles';
    wwv_flow_imp.g_varchar2_table(92) := 'heet>'||wwv_flow.LF||
'';
wwv_flow_imp_shared.create_report_layout(
 p_id=>wwv_flow_imp.id(11470053473278791231)
,p_report_layout_name=>'daily_pdf_generic'
,p_report_layout_type=>'XSL_GENERIC'
,p_varchar2_table=>wwv_flow_imp.g_varchar2_table
,p_xslfo_column_heading=>wwv_flow_string.join(wwv_flow_t_varchar2(
'                           <fo:table-cell xsl:use-attribute-sets="cell header-color border">',
'                               <fo:block xsl:use-attribute-sets="text #TEXT_ALIGN#">',
'                                   <fo:inline xsl:use-attribute-sets="header-font">#COLUMN_HEADING#</fo:inline>',
'                               </fo:block>',
'                           </fo:table-cell>',
''))
,p_xslfo_column_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'                              <fo:table-cell xsl:use-attribute-sets="cell border">',
'                                  <fo:block xsl:use-attribute-sets="text #TEXT_ALIGN#">',
'                                      <fo:inline xsl:use-attribute-sets="body-font">',
'                                          <xsl:value-of select=".//#COLUMN_HEADER_NAME#"/>',
'                                      </fo:inline>',
'                                  </fo:block>',
'                              </fo:table-cell>',
''))
,p_xslfo_column_template_width=>wwv_flow_string.join(wwv_flow_t_varchar2(
'                     <fo:table-column column-width="#COLUMN_WIDTH#pt"/>',
''))
);
end;
/
