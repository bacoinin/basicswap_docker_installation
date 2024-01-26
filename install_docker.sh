#!/bin/bash

# Update package list
sudo apt-get update

# Install Docker's package dependencies
sudo apt-get install -y build-essential apt-transport-https ca-certificates curl software-properties-common curl gnupg

# Download Docker's official GPG key
sudo install -m 0755 -d /etc/apt/keyrings
if [[ -f "/etc/apt/keyrings/docker.gpg" ]]; then
    echo "- /etc/apt/keyrings/docker.gpg already exists"
else
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
fi

# Move the GPG key to the trusted directory
#sudo mv docker.gpg /etc/apt/trusted.gpg.d/

# Add Docker repository
# sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
echo \
"deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
"$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package list again
sudo apt-get update

# Install Docker CE
sudo apt-get install -y docker-ce
echo "- Done! (Restart needed to enable the changes)"

    
# Setup sudoless docker
sudo usermod -aG docker ${USER}
newgrp docker
