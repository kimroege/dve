@echo off
setlocal

REM === Check for admin rights ===
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ========================================================
    echo   This script needs to be run as Administrator.
    echo   Please right-click and choose "Run as administrator".
    echo ========================================================
    pause
    exit /b
)

REM Base URL where everything is hosted
set BASE_URL=https://raw.githubusercontent.com/kimroege/dve/refs/heads/main

REM Temp location for the main script
set SCRIPT_FILE=%TEMP%\manage_software.bat

echo Fetching management script...
curl -s -o "%SCRIPT_FILE%" "%BASE_URL%/manage_software.bat"

echo Running management script...
call "%SCRIPT_FILE%"

echo Done.
pause
