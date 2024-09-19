#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "Updating system..."
sudo apt-get update && sudo apt-get upgrade -y

echo "Installing prerequisite packages..."
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

echo "Adding Docker's official GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo "Adding Docker repository..."
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

echo "Updating package database..."
sudo apt-get update

echo "Installing Docker..."
sudo apt-get install -y docker-ce

echo "Docker installed successfully. Version:"
sudo docker --version

echo "Adding user to Docker group (requires re-login to take effect)..."
sudo usermod -aG docker ${USER}

echo "Starting and enabling Docker service..."
sudo systemctl start docker
sudo systemctl enable docker

echo "Docker installation and setup is complete."
echo "Please log out and back in to use Docker without sudo."
