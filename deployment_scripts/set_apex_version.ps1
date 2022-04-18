param([string]$version)
$apex_app_path = ".\APEX\SMARTCASH.sql"
$dateStr = (Get-Date).ToString("yyyy.MM.dd")
$body = ((Get-Content -encoding UTF8 $apex_app_path) -join "`r`n")
$body = $body -replace "(?m)^(,p_flow_version=>')([^']+)(')", "`$1$($version)`$3"
#$body|Set-Content -Encoding UTF8 -Path $apex_app_path
$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
[System.IO.File]::WriteAllLines("$(Get-Location)\$apex_app_path", $body, $Utf8NoBomEncoding)