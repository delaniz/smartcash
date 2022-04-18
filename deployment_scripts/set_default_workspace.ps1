param([string]$workspace_id)
$apex_app_path = ".\APEX\SMARTCASH.sql"
$body = ((Get-Content -encoding UTF8 $apex_app_path) -join "`r`n")
$body = $body -replace "(?m)^(,p_default_workspace_id=>)[0-9]+", "`${1}$workspace_id"
#$body|Set-Content -Encoding UTF8 -Path $apex_app_path
$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
[System.IO.File]::WriteAllLines("$(Get-Location)\$apex_app_path", $body, $Utf8NoBomEncoding)