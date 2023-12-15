@echo off
set PACKAGE_LIST=pynput opencv-python pyautogui pillow sounddevice scipy

python --version
echo Checking for updates...
python.exe -m pip install --upgrade pip

rem Check the exit code of the pip update command
if %errorlevel% equ 0 (
    echo Pip is up to date or has been updated successfully.
    echo Updating other packages...

    rem Iterate through the list of packages and check/update them
    for %%P in (%PACKAGE_LIST%) do (
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
