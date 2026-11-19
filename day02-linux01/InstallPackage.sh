#This Script is used to install the required packages for the Linux environment setup.

#/usr/bin/bash

#Get Input from the user for the package name to be installed.
read -p "Enter the package name to install: " package_name
function read_package_name($package_name) {
    if [ -z "$package_name" ]; then
        echo "Package name cannot be empty. Please enter a valid package name."
        exit 1
    else
        check_package "$package_name"
    fi
}

function check_package($package_name) {
    if ! docker -v "$package_name" &> /dev/null; then
        echo "Package $package_name is not installed."
        return 1
        install_package "$package_name"
    else
        echo "Package $package_name is already installed."
        return 0
    fi
}

function install_package($package_name) {
    if ! check_package "$package_name"; then
        echo "Installing package $package_name..."
        sudo apt-get update
        sudo apt-get install -y "$package_name"
        if [ $? -eq 0 ]; then
            echo "Package $package_name installed successfully."
        else
            echo "Failed to install package $package_name."
            exit 1
        fi
    fi
}
read_package_name "$package_name"