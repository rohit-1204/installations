#!/bin/bash

set -e

echo "======================================"
echo " Installing Terraform"
echo "======================================"

# Update packages
sudo apt-get update

# Install required packages
sudo apt-get install -y gnupg software-properties-common curl

# Download HashiCorp GPG key
curl -fsSL https://apt.releases.hashicorp.com/gpg | \
sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

# Add HashiCorp repository
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com \
$(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

# Update package list
sudo apt-get update

# Install Terraform
sudo apt-get install -y terraform

echo "======================================"
echo " Terraform Installed Successfully"
echo "======================================"

terraform version
