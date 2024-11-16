#!/bin/bash
# Update and upgrade system packages
sudo apt update -y
sudo apt upgrade -y

# Install prerequisites
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common gnupg

# Install Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker ubuntu

# Enable and start Docker service
sudo systemctl enable docker
sudo systemctl start docker

# Install Terraform
sudo apt update -y
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update -y
sudo apt install -y terraform

# Install AWS CLI v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf awscliv2.zip aws

# Install Visual Studio Code
Install code-server
curl -L https://code-server.dev/install.sh | sh

# Enable and start code-server service using systemctl
sudo systemctl enable --now code-server@$USER

# Brief pause to ensure the service is properly enabled
sleep 1

# Restart the code-server service
sudo systemctl restart code-server@$USER

# Configure code-server with custom settings
CONFIG_PATH="$HOME/.config/code-server/config.yaml"

# Write configuration to the config.yaml file
echo "bind-addr: 0.0.0.0:8081
auth: password
password: abcd1234
cert: false" > "$CONFIG_PATH"
# Clean up
sudo apt autoremove -y
sudo apt clean

# Reboot to finalize installations
sudo reboot
