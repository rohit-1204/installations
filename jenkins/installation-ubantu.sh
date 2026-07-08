#!/bin/bash

# Script to install Jenkins on Ubuntu

set -e

echo "Updating system packages..."
sudo apt update -y
sudo apt upgrade -y

echo "Installing Java (OpenJDK 21)..."
sudo apt install -y openjdk-21-jdk

echo "Adding Jenkins repository key..."
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo "Adding Jenkins repository..."
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "Updating package list..."
sudo apt update -y

echo "Installing Jenkins..."
sudo apt install -y jenkins

echo "Starting Jenkins service..."
sudo systemctl start jenkins
sudo systemctl enable jenkins

echo "Allowing Jenkins port 8080 through firewall..."
sudo ufw allow 8080
sudo ufw reload

# Get server IP
SERVER_IP=$(hostname -I | awk '{print $1}')

echo "Jenkins installation complete!"
echo "Access Jenkins at: http://$SERVER_IP:8080"
echo "👉 Click here: [http://$SERVER_IP:8080](http://$SERVER_IP:8080)"
echo "Initial admin password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
