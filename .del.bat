@echo off

chcp 65001 >nul

set DOWNLOADS=%USERPROFILE%\Downloads

if exist "%DOWNLOADS%" (
    echo Folder found: %DOWNLOADS%
) else (
    echo "Downloads" folder not found. Trying "Загрузки"...
    set DOWNLOADS=%USERPROFILE%\Загрузки
    if exist "%DOWNLOADS%" (
        echo Folder found: %DOWNLOADS%
    ) else (
        echo The Downloads/Загрузки folder does not exist.
        exit /b
    )
)

echo Cleaning the Downloads folder...
del /f /q "%DOWNLOADS%\*"
for /d %%D in ("%DOWNLOADS%\*") do rd /s /q "%%D"

echo Folder cleaned.

pause
