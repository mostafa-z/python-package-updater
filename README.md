# Python Package Updater

This Python script helps manage installed package versions by comparing them to the latest available versions on PyPI (Python Package Index) and offering to update outdated packages.

## Features

- **Version Check**: Compares installed package versions with the latest available versions.
- **Interactive Upgrade**: Prompts the user to upgrade outdated packages.
- **Package List**: Fetches package versions from a specified `packages.txt` file.
- **Output Summary**: Displays a tabulated summary of installed vs. latest versions.

## File Structure

- `fetch_package_versions.py`: Main script to check and display package versions.
- `upgrade_packages.py`: Script to manage package upgrades interactively.
- `packages.txt`: List of packages to track/update.

## Requirements

- Python 3.x
- Required Python libraries will be install by the batch file

## Running the Script

To utilize the package update functionality, follow these steps:

1. **Ensure Python is Installed**:
   - Make sure you have Python 3.x installed on your system.

2. **Clone or Download**:
   - Clone this repository or download the script files to your local machine.

3. **Populate `packages.txt`**:
   - Edit the `packages.txt` file and list the names of the packages you wish to manage or update. One package per line.

4. **Run the Batch File**:
   - Execute `py_packages.bat` by double-clicking on it or running it from the command line.


Feel free to customize the `packages.txt` file and script behavior to suit your needs.

## Output Sample

Python 3.11.2<br>
Installed pip version: 23.3.1<br>
Pip is up to date or has been updated successfully.

### Menu:
1. Run version check
2. Update all installed packages (even those not listed)
3. Exit

Enter your choice: 1

#### Fetching latest package versions...
| Package        | Installed Version   | Latest Version   |
|----------------|---------------------|------------------|
| pynput         | 1.7.6               | 1.7.6            |
| opencv-python  | 4.8.1.78            | 4.8.1.78         |
| pyautogui      | 0.9.54              | 0.9.54           |
| pillow         | 10.1.0              | 10.1.0           |
| sounddevice    | 0.4.6               | 0.4.6            |
| scipy          | 1.11.4              | 1.11.4           |

All packages are up to date. No updates needed.<br>
No packages need updating.
