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
outdated_packages = False
for package in package_list:
    try:
        installed_version = get_distribution(package).version
    except DistributionNotFound:
        installed_version = "Not installed"

    latest_version = get_package_info(package)
    data.append([package, installed_version, latest_version])

    # Check if installed version matches latest version
    if installed_version != latest_version:
        outdated_packages = True

headers = ["Package", "Installed Version", "Latest Version"]
print(tabulate(data, headers=headers, tablefmt="github"))

if outdated_packages:
    with open('packages_to_update.txt', 'w') as update_file:
        for package in package_list:
            if data[package_list.index(package)][1] != data[package_list.index(package)][2]:
                update_file.write(package + '\n')
    print("Package names to update written to file.")
else:
    print("All packages are up to date. No updates needed.")

#if outdated_packages:
#    print("Updating outdated packages...")
#    for package in package_list:
#        if data[package_list.index(package)][1] != data[package_list.index(package)][2]:
#            subprocess.call(['pip', 'install', '--upgrade', package])
#    print("Packages updated successfully!")
#else:
#    print("All packages are up to date. No updates needed.")
