@echo off

chcp 65001 >nul

set DOWNLOADS=%USERPROFILE%\Загрузки

if not exist "%DOWNLOADS%" (
  set DOWNLOADS=%USERPROFILE%\Downloads
)

if not exist "%DOWNLOADS%" (
  echo The Downloads/Загрузки folder does not exist.
  exit /b
)

echo Cleaning the Downloads folder: %DOWNLOADS%

del /f /q "%DOWNLOADS%\*"
for /d %%D in ("%DOWNLOADS%\*") do rd /s /q "%%D"

echo Folder cleaned successfully.

pause