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
,p_release=>'22.1.0-16'
,p_default_workspace_id=>15726592515012468
,p_default_application_id=>676496
,p_default_id_offset=>56312848539360074319
,p_default_owner=>'PLAYGROUND'
);
end;
/
 
prompt APPLICATION 676496 - smartCash
--
-- Application Export:
--   Application:     676496
--   Name:            smartCash
--   Date and Time:   14:19 Monday April 18, 2022
--   Exported By:     D.KALDI@ME.COM
--   Flashback:       0
--   Export Type:     Application Export
--     Pages:                     36
--       Items:                   71
--       Validations:              1
--       Processes:               39
--       Regions:                 99
--       Buttons:                 83
--       Dynamic Actions:         78
--     Shared Components:
--       Logic:
--         Items:                  1
--         Processes:              1
--         App Settings:           2
--         Build Options:          6
--       Navigation:
--         Lists:                  8
--         Breadcrumbs:            1
--           Entries:              4
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
--           Button:               4
--           Report:              10
--         LOVs:                   5
--         Shortcuts:              1
--         Plug-ins:               1
--       Globalization:
--       Reports:
--         Queries:                1
--         Layouts:                2
--       E-Mail:
--     Supporting Objects:  Included
--   Version:         22.1.0-16
--   Instance ID:     63113759365424
--

