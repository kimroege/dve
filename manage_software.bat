@echo off
:: Elevate if not already running as admin
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting administrator access...
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

setlocal enabledelayedexpansion

REM URLs to your manifests
set INSTALL_URL=https://raw.githubusercontent.com/kimroege/dve/refs/heads/main/install_temp.txt
set UNINSTALL_URL=https://raw.githubusercontent.com/kimroege/dve/refs/heads/main/uninstall.txt

REM Temp files
set INSTALL_FILE=%TEMP%\winget_install.txt
set UNINSTALL_FILE=%TEMP%\winget_uninstall.txt

echo Downloading manifest files...
curl -s -o "%INSTALL_FILE%" "%INSTALL_URL%"
curl -s -o "%UNINSTALL_FILE%" "%UNINSTALL_URL%"

echo Uninstalling unwanted apps...
for /f "tokens=* delims=" %%A in (%UNINSTALL_FILE%) do (
    set ID=%%A
    if not "!ID!"=="" (
        echo Uninstalling !ID!...
        winget uninstall --id !ID! --silent --accept-source-agreements --accept-package-agreements
    )
)

echo Installing required apps...
for /f "tokens=* delims=" %%A in (%INSTALL_FILE%) do (
    set ID=%%A
    if not "!ID!"=="" (
        echo Installing or updating !ID!...
        winget install --id !ID! --silent --accept-source-agreements --accept-package-agreements
    )
)

echo Cleaning up...
del "%INSTALL_FILE%" >nul 2>&1
del "%UNINSTALL_FILE%" >nul 2>&1

echo All done.
pause
