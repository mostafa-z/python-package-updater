from tabulate import tabulate
import subprocess
import json

def get_outdated_packages():
    try:
        result = subprocess.run(['python', '-m', 'pip', 'list', '--outdated', '--format', 'json'], capture_output=True, text=True)
        outdated_packages = json.loads(result.stdout)
        return outdated_packages
    except subprocess.CalledProcessError as e:
        print("Error:", e)
        return []

outdated = get_outdated_packages()
if outdated:
    formatted_outdated = [[package['name'], package['version'], package['latest_version']] for package in outdated]
    headers = ["Package", "Installed Version", "Latest Version"]
    print(tabulate(formatted_outdated, headers=headers, tablefmt="github"))

    upgrade = input("Do you want to upgrade these packages? (y/n): ")
    if upgrade.lower() == 'y':
        try:
            for package in outdated:
                package_name = package['name']
                subprocess.run(['python', '-m', 'pip', 'install', '--upgrade', package_name], check=True)
            print("Packages updated successfully!")
        except subprocess.CalledProcessError as e:
            print("Error:", e)
else:
    print("No packages need updating.")
