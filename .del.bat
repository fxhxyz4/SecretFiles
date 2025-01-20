@echo off

chcp 65001 >nul

setlocal enabledelayedexpansion

set DOWNLOADS=%USERPROFILE%\Загрузки

for /f "tokens=2 delims==" %%A in ('reg query "HKCU\Control Panel\International" /v LocaleName 2^>nul') do set LANG=%%A

if "%LANG%"=="en-US" (
    set DOWNLOADS=%USERPROFILE%\Downloads
)

if exist "%DOWNLOADS%" (
    echo Folder found: %DOWNLOADS%

    echo Cleaning the Downloads folder...
    del /f /q "%DOWNLOADS%\*"
    for /d %%D in ("%DOWNLOADS%\*") do rd /s /q "%%D"

    echo Folder cleaned.
) else (
    echo The Downloads folder does not exist.
)

pause
