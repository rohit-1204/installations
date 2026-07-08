#!/bin/bash

################################################################################
# Script Name : slave-node-installation.sh
# Description : Install Jenkins Agent Dependencies
# OS          : Ubuntu 22.04 / 24.04
# Author      : DevOps
################################################################################

set -e

echo "=================================================="
echo " Jenkins Agent Installation Started"
echo "=================================================="

########################################
# Update Packages
########################################

echo "Updating packages..."

sudo apt update -y
sudo apt upgrade -y

########################################
# Install Java
########################################

echo "Installing Java 17..."

sudo apt install -y openjdk-17-jdk

########################################
# Install Git
########################################

echo "Installing Git..."

sudo apt install -y git

########################################
# Install Curl
########################################

sudo apt install -y curl

########################################
# Install Wget
########################################

sudo apt install -y wget

########################################
# Install Unzip
########################################

sudo apt install -y unzip

########################################
# Install Docker
########################################

echo "Installing Docker..."

sudo apt install -y docker.io

sudo systemctl enable docker
sudo systemctl start docker

########################################
# Add Current User to Docker Group
########################################

sudo usermod -aG docker $USER

########################################
# Install NodeJS 22.x
########################################

echo "Installing NodeJS..."

curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -

sudo apt install -y nodejs

########################################
# Install Python
########################################

echo "Installing Python..."

sudo apt install -y python3 python3-pip python3-venv

########################################
# Install AWS CLI
########################################

echo "Installing AWS CLI..."

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
-o "awscliv2.zip"

unzip awscliv2.zip

sudo ./aws/install

rm -rf aws
rm awscliv2.zip

########################################
# Install kubectl
########################################

echo "Installing kubectl..."

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

chmod +x kubectl

sudo mv kubectl /usr/local/bin/

########################################
# Install Helm
########################################

echo "Installing Helm..."

curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

########################################
# Create Jenkins Workspace
########################################

sudo mkdir -p /home/$USER/jenkins

sudo chown -R $USER:$USER /home/$USER/jenkins

########################################
# Versions
########################################

echo
echo "Installed Versions"
echo "------------------------------"

java -version

git --version

docker --version

node -v

npm -v

python3 --version

pip3 --version

aws --version

kubectl version --client

helm version

echo
echo "=================================================="
echo " Jenkins Agent Installation Completed"
echo "=================================================="

echo
echo "IMPORTANT:"
echo "Logout and login again"
echo "OR"
echo "Run:"
echo
echo "newgrp docker"
