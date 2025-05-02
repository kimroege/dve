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

REM Upgrade all installed software using winget
echo Checking for updates for all installed software...
winget upgrade --all --silent --accept-source-agreements --accept-package-agreements

echo All done.
pause
