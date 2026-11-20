#This Script is used to install the required packages for the Linux environment setup.

#!/usr/bin/bash

set -e

UPDATED=false

check_package() {
    local package_name="$1"
    if dpkg -s "$package_name" &> /dev/null || command -v "$package_name" &> /dev/null; then
        echo -e "Package $package_name is already installed. \n"
        return 0
    else
        echo "[MISSING] $package_name is not installed."
        install_package
    fi

}

install_package() {
    local package_name="$1"
    echo "Installing package $package_name..."
    if [ "$UPDATED" = false ]; then
        sudo apt-get update
        UPDATED=true
    fi

    if sudo apt-get install -y "$package_name"; then
        echo "[SUCCESS] Package $package_name installed successfully."
    else
        echo "Failed to install package $package_name. Please check the package name and try again."
        exit 1
    fi
}

#Setting loop for multiple package installation
process_packages() {
    local packages=("$@")

    if [ ${#packages[@]} -eq 0 ]; then
        echo "No packages provided for installation."
        exit 1
    fi

    for package in "${packages[@]}"; do
        check_package "$package"
        if [ $? -ne 0 ]; then
            install_package "$package"
        fi
    done
}

if [ $# -gt 0 ]; then
    process_packages "$@"
else
    read -rp "Enter the packages to install (space-separated): " -a user_packages
    process_packages "${user_packages[@]}"
fi