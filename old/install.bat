@echo off
set "url=https://raw.githubusercontent.com/kimroege/dve/refs/heads/main/apps_list.txt"

:: Download the list of apps
curl -o apps_list.txt %url%

:: Install each application listed in the file
for /f "tokens=*" %%a in (apps_list.txt) do (
    echo Installing: %%a
    winget install %%a --silent
)

:: Clean up by deleting the apps list file
del apps_list.txt

echo All applications installed successfully!
pause
