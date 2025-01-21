@echo off

net session >nul 2>&1 || (powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs" & exit)

chcp 65001 >nul
color 0D

set DOWNLOADS=%USERPROFILE%\Downloads

:: delete files in Downloads folder
del /f /q "%DOWNLOADS%\*"
for /d %%D in ("%DOWNLOADS%\*") do rd /s /q "%%D"

echo Folder cleaned successfully.

echo Select Execution policy category: A

ping 127.0.0.1 -n 4 >nul

powershell -Command "Start-Process -FilePath 'powershell.exe' -ArgumentList '-NoExit', '-Command Set-ExecutionPolicy RemoteSigned -Force' -Verb RunAs"

exit