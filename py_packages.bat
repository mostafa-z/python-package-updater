@echo off

rem Show installed Python version
python --version

rem Show installed pip version in a simpler format
for /f "tokens=2 delims=: " %%v in ('python -m pip show pip ^| findstr /i "version"') do echo Installed pip version: %%v

rem Check for updates for pip
python -m pip install --upgrade pip > nul
if %errorlevel% equ 0 (
    echo Pip is up to date or has been updated successfully.
) else (
    echo Pip update failed or was not needed.
)

rem Check if requests library is installed
python -c "import requests" 2>nul
if errorlevel 1 (
    echo Installing requests library...
    python -m pip install requests
)

rem Check if tabulate library is installed
python -c "import tabulate" 2>nul
if errorlevel 1 (
    echo Installing tabulate library...
    python -m pip install tabulate
)

rem Check if pkg_resources library is installed
python -c "import pkg_resources " 2>nul
if errorlevel 1 (
    echo Installing pkg_resources library...
    python -m pip install pkg_resources
)

rem Check if subprocess library is installed
python -c "import subprocess " 2>nul
if errorlevel 1 (
    echo Installing subprocess library...
    python -m pip install subprocess
)

:menu
echo Menu:
echo 1. Run version check
echo 2. Update all installed packages (even those not listed)
echo 3. Exit
set /p choice="Enter your choice: "

if "%choice%"=="1" goto version_check
if "%choice%"=="2" goto update_all
if "%choice%"=="3" goto :eof

echo Invalid choice. Please try again.
goto menu

:version_check
rem Your Python script to fetch latest package versions
echo Fetching latest package versions...
python fetch_package_versions.py

rem Check the exit code of the pip update command
if %errorlevel% equ 0 (
    rem Check if packages_to_update.txt exists
    if exist packages_to_update.txt (
        rem Read the package list from packages_to_update.txt
        rem Iterate through the list of packages and update them
        for /f %%P in (packages_to_update.txt) do (
            pip install --upgrade %%P
        )
        del packages_to_update.txt
        echo Packages updated successfully!
    ) else (
        echo No packages need updating.
    )
) else (
    echo Pip update failed or was not needed.
)

pause
goto menu

:update_all
echo Fetching list of outdated packages...
python upgrade_packages.py

pause
goto menu
