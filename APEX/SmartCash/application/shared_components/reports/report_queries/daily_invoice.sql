prompt --application/shared_components/reports/report_queries/daily_invoice
begin
wwv_flow_imp_shared.create_shared_query(
 p_id=>wwv_flow_imp.id(10873439105776118754)
,p_name=>'daily_invoice'
,p_query_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr(' select a.aid,a.name article,to_char(percent,''90'')||''%''  tax,to_char(a.price,''9999990.00'')||'' \20AC'' unit_price,qnt quantity,disc discount,to_char(total,''9999990.00'')||'' \20AC'' total from (select a.aid ,sum(quantity) qnt,sum(discount) disc,sum(total) total'),
'                from sc_article a left join sc_billitem bitem  on a.aid = bitem.article_id  ',
'                     where trunc(bitem.created) = :salary_day group by a.aid ) b left join sc_article a on a.aid= b.aid left join sc_tax t on t.tid = a.tax_id order by a.aid;',
'      '))
,p_xml_structure=>'APEX'
,p_report_layout_id=>wwv_flow_imp.id(11471455988265253890)
,p_format=>'PDF'
,p_output_file_name=>'daily_invoice'
,p_content_disposition=>'ATTACHMENT'
);
wwv_flow_imp_shared.create_shared_query_stmnt(
 p_id=>wwv_flow_imp.id(11471255941942790683)
,p_shared_query_id=>wwv_flow_imp.id(10873439105776118754)
,p_sql_statement=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr(' select a.aid,a.name article,to_char(percent,''90'')||''%''  tax,to_char(a.price,''9999990.00'')||'' \20AC'' unit_price,qnt quantity,disc discount,to_char(total,''9999990.00'')||'' \20AC'' total from (select a.aid ,sum(quantity) qnt,sum(discount) disc,sum(total) total'),
'                from sc_article a left join sc_billitem bitem  on a.aid = bitem.article_id  ',
'                     where trunc(bitem.created) = :P8_SALARY_DAY group by a.aid ) b left join sc_article a on a.aid= b.aid left join sc_tax t on t.tid = a.tax_id order by a.aid;',
'      '))
);
end;
/
