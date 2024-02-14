#!/bin/bash

echo "Starting Docker installation on Deepin Linux..."

# Define a mapping from Deepin version to Debian version
map_deepin_to_debian() {
    if [ "$1" -lt 20 ]; then
        echo "stretch"
    elif [ "$1" -ge 20 ]; then
        echo "buster"
    else
        echo "Unknown version of Deepin"
        exit 1
    fi
}

# Get Deepin version
DEEPIN_VERSION=$(grep 'VERSION_ID' /etc/os-release | cut -d '"' -f 2)
DEBIAN_VERSION=$(map_deepin_to_debian "$DEEPIN_VERSION")

echo "Deepin version: $DEEPIN_VERSION, using Debian version: $DEBIAN_VERSION for Docker installation."

# Update and install dependencies
echo "Updating packages and installing dependencies..."
sudo apt-get update -y
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common || { echo "Failed to install dependencies"; exit 1; }

# Check if Docker is installed and remove it
if dpkg -l | grep -qw docker; then
    echo "Removing old Docker versions..."
    sudo apt-get remove -y docker docker-engine docker.io containerd runc || { echo "Failed to remove existing Docker installations"; exit 1; }
fi

# Add Docker's official GPG key
echo "Adding Docker's GPG key..."
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add - || { echo "Failed to add Docker's GPG key"; exit 1; }

# Verify key with fingerprint
sudo apt-key fingerprint 0EBFCD88

# Add Docker repository
echo "Adding Docker repository for $DEBIAN_VERSION..."
printf "deb [arch=amd64] https://download.docker.com/linux/debian $DEBIAN_VERSION stable\n" | sudo tee /etc/apt/sources.list.d/docker-ce.list || { echo "Failed to add Docker repository"; exit 1; }

# Install Docker CE
echo "Installing Docker CE..."
sudo apt-get update -y
sudo apt-get install -y docker-ce || { echo "Failed to install Docker CE"; exit 1; }

# Add current user to the Docker group (optional)
echo "Adding current user to the Docker group..."
sudo usermod -aG docker $(whoami) || { echo "Failed to add user to Docker group"; exit 1; }

echo "Docker installation and setup completed successfully."
