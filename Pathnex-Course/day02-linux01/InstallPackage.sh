#This Script is used to install the required packages for the Linux environment setup.

#!/usr/bin/bash

set -e
#Get Input from the user for the package name to be installed.
read -rp "Enter the package name to install: " package_name

read_package_name() {
    local package_name="$1"
    if [ -z "$package_name" ]; then
        echo "Package name cannot be empty. Please enter a valid package name."
        exit 1
    else
        check_package "$package_name"
    fi
}

check_package() {
    local package_name="$1"
    #failure_code=0
    #cmdres=$("$package_name" --version) || failure_code=$?
    if ! command -v "$package_name" > /dev/null 2>&1; then
        echo "Package $package_name is not installed."
        install_package "$package_name"
        #return 1
    else
        echo "Package $package_name is already installed."
        return 0
    fi
}

install_package() {
    local package_name="$1"
    sudo apt-get update
    if sudo apt-get install -y "$package_name" ; then
        echo "Installing package $package_name..."
        if [ $? -eq 0 ]; then
            echo "Package $package_name installed successfully."
        else
            echo "Failed to install package $package_name."
            exit 1
        fi
    fi
}
read_package_name "$package_name"