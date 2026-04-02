@echo off
:: 1. Force the window to stay open if there's an error
setlocal enabledelayedexpansion

:: ============================================================
::  1. KERNEL INITIALIZATION & CONFIGURATION
:: ============================================================
set "GAME_DIR=%~dp0"
if "!GAME_DIR:~-1!" neq "\" set "GAME_DIR=!GAME_DIR!\"

pushd "!GAME_DIR!"

chcp 65001 >nul
set "PYTHONUTF8=1"
set "PYTHONIOENCODING=utf-8"
set "VERSION=4.0.0-QUANTUM-2026"
set "LOG_FILE=%GAME_DIR%session_logs.txt"

mode con: cols=120 lines=40
title HIGHER OR LOWER ENGINE [INITIALIZING...]

:start
cls
:: ============================================================
::  2. ENHANCED LOGGING & SYSTEM INFO
:: ============================================================
color 02
: : Color is Green for Engine
title HIGHER OR LOWER ENGINE [CORE: !VERSION!]

:: Organized Log Entry Header
echo ========================================== >> "%LOG_FILE%"
echo [SESSION START] [%date%] [%time%] >> "%LOG_FILE%"
echo [BUILD/USER]    !VERSION! / %USERNAME% >> "%LOG_FILE%"
echo ------------------------------------------ >> "%LOG_FILE%"

:: ============================================================
::  3. LOGO DISPLAY & AESTHETICS
:: ============================================================
echo.
echo   [!] SYSTEM BOOT SEQUENCE INITIATED...
echo.
echo ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓███████▓▒░        ░▒▓██████▓▒░░▒▓███████▓▒░       ░▒▓█▓▒░      ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓███████▓▒░  
echo ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░ 
echo ░▒▓████████▓▒░▒▓█▓▒░▒▓█▓▒▒▓███▓▒░▒▓████████▓▒░▒▓██████▓▒░ ░▒▓███████▓▒░       ░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░       ░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓██████▓▒░ ░▒▓███████▓▒░  
echo ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░       ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░      ░▒▓████████▓▒░▒▓██████▓▒░ ░▒▓█████████████▓▒░░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░ 
echo.
echo  -----------------------------------------------------------------------------------------------------------------------
echo  [GAME PATH] !GAME_DIR!
powershell -NoProfile -Command "[console]::beep(1000, 50)"
echo  [BUILD INFO] QUANTUM V!VERSION! ^| [USER] %USERNAME%
powershell -NoProfile -Command "[console]::beep(1000, 50)"
echo  -----------------------------------------------------------------------------------------------------------------------

:: ============================================================
::  4. ADVANCED ENVIRONMENT SCAN & VALIDATION
:: ============================================================
echo [SCAN] Validating Python Runtime Environment...
powershell -NoProfile -Command "[console]::beep(1000, 50)"

where python >nul 2>&1
if %errorlevel% neq 0 (
    where python3 >nul 2>&1
    if %errorlevel% neq 0 (
        color 0C
        : : Color is Light Red for Error
        echo [CRITICAL ERROR] Python Runtime Missing.
        echo [ERROR] %date% %time% - FAILED: Python Missing >> "%LOG_FILE%"
        pause
        exit /b 1
    ) else (
        set PYTHON_CMD=python3
    )
) else (
    set PYTHON_CMD=python
)

!PYTHON_CMD! --version
echo [SUCCESS] Python Environment Detected.
powershell -NoProfile -Command "[console]::beep(1000, 50)"

:: ============================================================
::  5. RECALIBRATED LOADING SEQUENCE
:: ============================================================
echo [SYSTEM] Calibrating Engine Cores...
powershell -NoProfile -Command "[console]::beep(1000, 50)"
echo [▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓] 100%% REACHED.

:: ============================================================
::  6. SAFE EXECUTION
:: ============================================================
powershell -NoProfile -Command "[console]::beep(1000, 50)"
echo [BOOT] Initiating main application file: main.py...
timeout /t 1 >nul

if not exist "%GAME_DIR%main.py" (
    color 0C
    : : Color is Red for Error
    echo [CRITICAL ERROR] main.py not found.
    echo [ERROR] %date% %time% - main.py missing >> "%LOG_FILE%"
    pause
    goto start
)

:: Executing the script
call !PYTHON_CMD! "%GAME_DIR%main.py"
:: %errorlevel% now captures the value from sys.exit(attempts)
set "TRIES=%errorlevel%"

:: Added completion time to the log
echo [STATS] [%time%] COMPLETED IN !TRIES! TRIES >> "%LOG_FILE%"

:: ============================================================
::  7. ADVANCED INTERACTIVE POST-PROCESSOR MENU
:: ============================================================
:menu
:: Logic to set EXIT_CODE to N/A if TRIES is not found/empty
if "!TRIES!"=="" (
    set "DISPLAY_CODE=N/A"
) else (
    set "DISPLAY_CODE=!TRIES!"
)

echo.
color 02
: : Color is Green for Menu
powershell -NoProfile -Command "[console]::beep(1000, 50)"
echo ============================================================
echo   HIGHER OR LOWER MENU (# OF TRIES: !DISPLAY_CODE!)
echo ============================================================
echo   [R] Recalibrate Core (Restart)
echo   [L] Launch Log Viewer
echo   [X] Terminate Program (Exit)
echo ============================================================

set /p "action=CRYPTO-CMD >> "

if /I "!action!"=="R" (
    set /p "conf=Confirm REBOOT? (Y/N): "
    if /I "!conf!"=="Y" (
        echo [ACTION] USER RESTARTED SESSION >> "%LOG_FILE%"
        echo ========================================== >> "%LOG_FILE%"
        cls
        goto start
    )
    goto menu
)

if /I "!action!"=="L" (
    if exist "%LOG_FILE%" (
        start notepad.exe "%LOG_FILE%"
    ) else (
        echo [ERROR] Log file not found.
    )
    goto menu
)

if /I "!action!"=="X" (
    set /p "conf=Confirm TERMINATION? (Y/N): "
    if /I "!conf!"=="Y" (
        echo [ACTION] USER CLOSED SESSION >> "%LOG_FILE%"
        echo ========================================== >> "%LOG_FILE%"
        echo [SHUTDOWN] Terminating system...
        popd
        powershell -NoProfile -Command "[console]::beep(1000, 50)"
        timeout /t 1 >nul
        exit /b
    )
    goto menu
)

:: Invalid input catch
color 0C 
: : Color is Light Red for Error
echo [ERROR] Invalid command received.
timeout /t 2 >nul
goto menu