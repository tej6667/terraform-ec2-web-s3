# -----------------------------------------------------------------------------
# This script sets up an Apache web server on a Debian/Ubuntu-based system,
# downloads a website template, and deploys it to the web server's root directory.
#
# Steps performed:
# 1. Updates the package list to ensure latest versions.
# 2. Installs wget, unzip, and apache2 packages.
# 3. Starts and enables the Apache2 service to run on boot.
# 4. Downloads the "Infinite Loop" website template from tooplate.com.
# 5. Unzips the downloaded template archive.
# 6. Copies the extracted website files to the Apache web root (/var/www/html/).
# 7. Restarts Apache2 to apply changes.
# -----------------------------------------------------------------------------

#!/bin/bash
apt update
apt install wget unzip apache2 -y
systemctl start apache2
systemctl enable apache2
wget https://www.tooplate.com/zip-templates/2117_infinite_loop.zip
unzip -o 2117_infinite_loop.zip
cp -r 2117_infinite_loop/* /var/www/html/
systemctl restart apache2
