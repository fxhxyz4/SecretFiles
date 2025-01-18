@echo off
@REM Author: fxhxyz
@REM License: MIT

:: paths
set PATH_0=C:\Windows\System32\winevt
set PATH_1=C:\Windows\System32\drivers
set PATH_2=C:\Windows\System32\spool
set PATH_3=C:\Windows\System32\Tasks
set index=0

:: settings label
:settings
    echo.
    echo.

    :: set back color + set ascii code (only eng)
    chcp 65001 > nul
    color 0D

    type ascii.txt
    echo.

    echo ꑭ!хꑭ github.com/fxhxyz4/SecretFiles ꑭх!ꑭ
    echo.

    set VER=64
    for /f "tokens=2 delims==" %%I in ('wmic os get osarchitecture /value') do set OS_ARCH=%%I

    if "%OS_ARCH%"=="32-bit" set VER=32

    :: local vars
    setlocal enabledelayedexpansion
    set NAME=firewall%VER%

    set TIME=10800
    set RESET_TIME=1800
    set SET_TIME=300

    :: files info
    set FILE=firewall.txt
    set CCD=%CD%

    title %NAME%

    goto :back_work

:: ------------------------ WORK WITH FILES ------------------------

:: back_work label
:back_work
    dir "!PATH_%index%!\%FILE%" /s /p
    ping 127.0.0.1 -n %SET_TIME% > nul

    if exist "!PATH_%index%!\%FILE%" (
        move "!PATH_%index%!\%FILE%" "!PATH_%index%!\%FILE%"
        set /a index+=1

        set /a TIME-=%SET_TIME%
    )

    if %TIME% leq 0 (
        del "!PATH_%index%!\%FILE%"
        exit
    )

    goto :back_work

    endlocal
    pause
