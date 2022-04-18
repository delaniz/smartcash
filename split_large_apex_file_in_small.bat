CD /D %~dp0
powershell -File .\deployment_scripts\apex_split_local.ps1 -customPath "%~1"
pause