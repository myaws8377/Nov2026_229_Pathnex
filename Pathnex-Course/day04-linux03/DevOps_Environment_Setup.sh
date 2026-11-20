#This Script is used to install the required packages for the Linux environment setup.

#!/usr/bin/bash

set -e

UPDATED=false

#Default list of DevOps tools need to be checked.
DEFAULT_TOOLS=("git", "curl", "docker", "kubectl", "helm", "aws")

apt_update() {
    if [ "$UPDATED" = "false" ]; then
        echo "Updating package lists..."
        sudo apt-get update -y
        UPDATED=true
    fi
}

get_os_architecture() {
    local ARCHITECTURE
    ARCHITECTURE=$(uname -m)
    echo "Detected architecture: $ARCHITECTURE"
    case "$ARCHITECTURE" in
        x86_64) echo "Architecture is x86_64" ;;
        aarch64) echo "Architecture is aarch64" ;;
        *) echo "Unsupported architecture: $ARCHITECTURE" >& 2
        return 1
        ;;
    esac
}

install_kubectl() {
    local ARCHITECTURE
    ARCHITECTURE=$(get_os_architecture)
    echo "Downloading latest kubectl for architecture: $ARCHITECTURE"
    local tmp_dir
    tmp_dir=$(mktemp -d)
    local stable_version
    stable_version=$(curl -fsSL https://dl.k8s.io/release/stable.txt)
    curl -fsSL "https://dl.k8s.io/release/${stable_version}/bin/linux/${ARCHITECTURE}/kubectl" -o "${tmp_dir}/kubectl"
    sudo install -o root -g root -m 0755 "${tmp_dir}/kubectl" /usr/local/bin/kubectl
    rm -rf "${tmp_dir}"
}

install_awscli() {
    local RAW_ARCHITECTURE
    RAW_ARCHITECTURE=$(get_os_architecture)
    echo "Downloading AWS CLI v2..."
    #Need curl and unzip first
    if ! command -v curl &> /dev/null || ! command -v unzip &> /dev/null; then
        apt_update
        sudo apt-get install -y curl unzip
    fi

    local temp_dir
    temp_dir=$(mktemp -d)
    curl -fsSL "https://amazonaws.com{RAW_ARCHITECTURE}.zip" -o "${temp_dir}/awscliv2.zip"
    unzip -q "${temp_dir}/awscliv2.zip" -d "${temp_dir}"
    sudo "${temp_dir}/aws/install" --update
    rm -rf "${temp_dir}"
}

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