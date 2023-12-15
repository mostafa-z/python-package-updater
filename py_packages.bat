@echo off

rem Check if requests library is installed
python -c "import requests" 2>nul
if errorlevel 1 (
    echo Installing requests library...
    python -m pip install requests
)

rem Your Python script to fetch latest package versions
echo Fetching latest package versions...
python fetch_package_versions.py

python --version
echo Checking for updates...
python.exe -m pip install --upgrade pip

rem Check the exit code of the pip update command
if %errorlevel% equ 0 (
    echo Pip is up to date or has been updated successfully.
    echo Updating other packages...


	rem Read the package list from packages.txt
	rem Iterate through the list of packages and check/update them
	for /f %%P in (packages.txt) do (
		pip show %%P >nul
		if %errorlevel% neq 0 (
			echo Installing %%P...
			pip install %%P
		) else (
			echo Updating %%P...
			pip install --upgrade %%P
		)
	)
) else (
    echo Pip update failed or was not needed.
)

echo Installation complete.
pause
