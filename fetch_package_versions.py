import requests
from tabulate import tabulate
from pkg_resources import get_distribution, DistributionNotFound

def get_package_info(package_name):
    url = f"https://pypi.org/pypi/{package_name}/json"
    response = requests.get(url)
    if response.status_code == 200:
        package_data = response.json()
        latest_version = package_data["info"]["version"]
        return latest_version
    else:
        return "Not found"

with open('packages.txt', 'r') as file:
    package_list = [line.strip() for line in file.readlines()]

data = []
for package in package_list:
    try:
        installed_version = get_distribution(package).version
    except DistributionNotFound:
        installed_version = "Not installed"

    latest_version = get_package_info(package)
    data.append([package, installed_version, latest_version])

headers = ["Package", "Installed Version", "Latest Version"]
print(tabulate(data, headers=headers, tablefmt="github"))
