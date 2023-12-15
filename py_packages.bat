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

rem Define the required Python libraries
set "libraries=requests tabulate pkg_resources subprocess"

rem Loop through each library and check/install if needed
for %%l in (%libraries%) do (
    python -c "import %%l" 2>nul || (
        echo Installing %%l library...
        python -m pip install %%l
    )
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
