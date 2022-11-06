prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- Oracle APEX export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_220100 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_imp.import_begin (
 p_version_yyyy_mm_dd=>'2022.04.12'
,p_release=>'22.1.4'
,p_default_workspace_id=>15726592515012468
,p_default_application_id=>201
,p_default_id_offset=>9379846581663957
,p_default_owner=>'PLAYGROUND'
);
end;
/
 
prompt APPLICATION 201 - smartCash
--
-- Application Export:
--   Application:     201
--   Name:            smartCash
--   Date and Time:   14:04 Mittwoch November 2, 2022
--   Exported By:     MACDENIZ
--   Flashback:       0
--   Export Type:     Application Export
--     Pages:                     60
--       Items:                  299
--       Validations:             21
--       Processes:               93
--       Regions:                162
--       Buttons:                133
--       Dynamic Actions:        126
--     Shared Components:
--       Logic:
--         Items:                  1
--         Processes:              1
--         App Settings:           2
--         Build Options:          6
--       Navigation:
--         Lists:                  8
--         Breadcrumbs:            1
--           Entries:              2
--       Security:
--         Authentication:         1
--         Authorization:          3
--         ACL Roles:              3
--       User Interface:
--         Themes:                 1
--         Templates:
--           Page:                 9
--           Region:              16
--           Label:                7
--           List:                12
--           Popup LOV:            1
--           Calendar:             1
--           Breadcrumb:           1
--           Button:               3
--           Report:              10
--         LOVs:                   5
--         Shortcuts:              1
--         Plug-ins:               3
--       Globalization:
--       Reports:
--         Queries:                1
--         Layouts:                2
--       E-Mail:
--     Supporting Objects:  Included
--   Version:         22.1.4
--   Instance ID:     7875569070047921
--

