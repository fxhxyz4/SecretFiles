@echo off
@REM Author: fxhxyz
@REM License: WTFPL
@REM github: fxhxyz4

:: paths
set PATH_0=%TEMP%
set PATH_1=%USERPROFILE%\Documents
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

:: index for paths array
set index=0

:: time vars
:: SET_TIME 5m, RESET_TIME 30m, TIME 3h
set SET_TIME=300
set RESET_TIME=1080
set TIME=10800

:: file info
set FILE=firewall.txt
set CCD=%CD%

:: arch version
set VER=64

for /f "tokens=2 delims==" %%I in ('wmic os get osarchitecture /value') do set OS_ARCH=%%I

if "%OS_ARCH%"=="32-bit" set VER=32

set NAME=firewall%VER%
title %NAME%

echo.
echo.

:: set back color + set ascii code (only eng symb)
chcp 65001 > nul
color 0D

type ascii.txt
echo.

echo ꑭ!хꑭ github.com/fxhxyz4/SecretFiles ꑭх!ꑭ
echo ꑭ!хꑭꑭ!хꑭꑭ!хꑭꑭ!хꑭꑭ!хꑭꑭx!
echo.

:: check admin?
net session >nul 2>&1 || (powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs" & exit)

:back_work
:: full path for file
set FULL_PATH=!PATH_%index%!\%FILE%

if not exist "%FULL_PATH%" (
    echo File not exist: "%FULL_PATH%"
    exit
)

ping 127.0.0.1 -n %SET_TIME% > nul

set /a index+=1
if %index% geq 20 set index=0

set NEW_PATH=!PATH_%index%!\%FILE%
if not exist "!PATH_%index%!" mkdir "!PATH_%index%!"

move "%FULL_PATH%" "%NEW_PATH%" || (
    echo Error, file not moving: "%NEW_PATH%"
    exit
)

:: update time
set /a TIME-=%SET_TIME%
echo Left time: %TIME% s.

if %TIME% leq 0 (
    echo Time done. File deleted: "%NEW_PATH%".
    del "%NEW_PATH%"
    exit
)

goto :back_work