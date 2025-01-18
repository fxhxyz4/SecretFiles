@echo off
@REM Author: fxhxyz
@REM License: MIT

:: settings func
:settings
    echo.
    echo.

    :: set back color + set ascii code (only eng)
    chcp 65001 >nul
    color 0D

    type ascii.txt
    echo.

    echo ꑭ!хꑭ github.com/fxhxyz4/SecretFiles ꑭх!ꑭ
    echo.

    set VER=64
    for /f "tokens=2 delims==" %%I in ('wmic os get osarchitecture /value') do set OS_ARCH=%%I

    if "%OS_ARCH%"=="32-bit" set VER=32

    :: local vars
    setlocal
    set NAME=firewall%VER%

    set TIME=10800
    set RESET_TIME=1800
    set SET_TIME=300

    :: files info
    set FILE=firewall.txt
    set CCD=%CD%

    title %NAME%

    goto :main

:: ------------------------ WORK WITH FILES ------------------------

:: main func
:main
    if exist "%FILE%" (
        echo 1
    ) else (
        echo 2
    )

    endlocal
    pause
    exit
