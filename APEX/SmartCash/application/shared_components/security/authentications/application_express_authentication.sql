prompt --application/shared_components/security/authentications/application_express_authentication
begin
wwv_flow_imp_shared.create_authentication(
 p_id=>wwv_flow_imp.id(37626982330340786033)
,p_name=>'Application Express Authentication'
,p_scheme_type=>'NATIVE_APEX_ACCOUNTS'
,p_invalid_session_type=>'LOGIN'
,p_use_secure_cookie_yn=>'N'
,p_ras_mode=>0
);
end;
/
