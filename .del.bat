@echo off

chcp 65001 >nul

del /f /q "%DOWNLOADS%\*"
for /d %%D in ("%DOWNLOADS%\*") do rd /s /q "%%D"

echo Folder cleaned successfully.

pause