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
        *) echo "Unsupported architecture: $ARCHITECTURE" >&2;;
        exit 1 ;;
        esac
}

install_kubectl() {
    local ARCHITECTURE
    ARCHITECTURE=$(get_os_architecture)
    echo "Downloading latest kubectl for architecture: $ARCHITECTURE"
    newtemp -d
    local stable_version
    stable_version=$(curl -fsSL https://dl.k8s.io/release/stable.txt)
    curl -fsSL "https://dl.k8s.io/release/${stable_version}/bin/linux/${ARCHITECTURE}/kubectl" -o "${tmp_dir}/kubectl"
    sudo install -o root -g root -m 0755 "${tmp_dir}/kubectl" /usr/local/bin/kubectl
    rm -rf "${tmp_dir}"
}

install awscli() {
    local RAW_ARCHITECTURE
    RAW_ARCHITECTURE=$(get_os_architecture)
    echo "Downloading AWS CLI v2..."
    newtemp -d
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "${tmp_dir}/awscliv2.zip"
    unzip "${tmp_dir}/awscliv2.zip" -d "${tmp_dir}"
    sudo "${tmp_dir}/aws/install"
    rm -rf "${tmp_dir}"
}