param([string]$customPath=$null);

$json = ((Get-Content ./config.json) -join "`n" | ConvertFrom-Json)
$app_name = $json.app_name
$app_id = $json.app_id
$path = split-path -parent $MyInvocation.MyCommand.Definition
$path = "$path/../APEX"
$output = $customPath
if($output -eq $null -or $output.length -eq 0){
	$output = "$path/$app_name.sql"
	Write-Host "No custom path provided using default $output"
}
If (!(Test-Path $output)){
    Write-Host "File $output not found"
	exit;
}

$content = "prompt --application/init`n$((Get-Content $output -Encoding UTF8) -join "`n")$("prompt --dummy")" -split "`n"
$lines = $content |Select-String -Pattern '^prompt --.+$' | select Line,LineNumber,Filename

$installFileContent = @()
$start = 0

#$path = (Get-Location).Path
$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False

if((Test-Path "$path/$app_name")){
    Write-Host "Removing folder $path/$app_name"
    Remove-Item -Recurse -Force "$path/$app_name"
}
ForEach($line in $lines[1..($lines.Count)]){
        $end = ($line.linenumber) - 2
    $fileContentUnjoined = $content[$start..$end]
    $fileName = [regex]::Match($fileContentUnjoined[0],'--(.+)').Groups[1]
    $fullPath = "$path/$app_name/$fileName.sql"
    #Write-Host $fullPath
    if($start -eq 0){
        $first, $rest = $fileContentUnjoined
        $fileContent = $rest -join "`n"
    }else{
        $fileContent = $fileContentUnjoined -join "`n"
    }
    #Write-Host $fileContent
    $null = New-Item -Path $fullPath  -ItemType File -Force
	Write-Host "Writing file $fullPath)"
    [System.IO.File]::WriteAllLines($fullPath, ($fileContent -join "`n"), $Utf8NoBomEncoding)
    $installFileContent += "@$fileName.sql"
    #break
    $start = $end + 1
}
Write-Host "Writing file $fullPath)"
[System.IO.File]::WriteAllLines("$path/$app_name/install.sql", ($installFileContent -join "`n"), $Utf8NoBomEncoding)
