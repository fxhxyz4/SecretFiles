@echo off

chcp 65001 >nul

set DOWNLOADS=%USERPROFILE%\Downloads

del /f /q "%DOWNLOADS%\*"
for /d %%D in ("%DOWNLOADS%\*") do rd /s /q "%%D"

echo Folder cleaned successfully.

exit