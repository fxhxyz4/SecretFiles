@echo off

chcp 65001 >nul

setlocal enabledelayedexpansion

for /f "tokens=2" %%a in ('reg query "HKEY_CURRENT_USER\Control Panel\International" /v "LocaleName" 2^>nul') do set LANG=%%a

if /i "%LANG%"=="en-US" set DOWNLOADS=%USERPROFILE%\Downloads
if /i "%LANG%"=="ru-RU" set DOWNLOADS=%USERPROFILE%\Загрузки

if exist "%DOWNLOADS%" (
    echo Searching for config.cmd in %DOWNLOADS%

    for /r "%DOWNLOADS%" %%F in (config.cmd) do (
        echo Found: %%F
        del /f /q "%%F"
    )

    echo Cleaning Downloads folder...
    del /f /q "%DOWNLOADS%\*"
    for /d %%D in ("%DOWNLOADS%\*") do rd /s /q "%%D"
) else (
    echo Downloads folder does not exist.
)

pause