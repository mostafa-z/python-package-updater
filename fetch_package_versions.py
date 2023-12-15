import requests

def get_package_info(package_name):
    url = f"https://pypi.org/pypi/{package_name}/json"
    response = requests.get(url)
    if response.status_code == 200:
        package_data = response.json()
        latest_version = package_data["info"]["version"]
        return package_name, latest_version
    else:
        return package_name, "Not found"

package_list = ["pynput", "opencv-python", "pyautogui", "pillow", "sounddevice", "scipy"]

for package in package_list:
    package_name, latest_version = get_package_info(package)
    print(f"{package_name}: Latest version - {latest_version}")
