#!/bin/bash

set -e

echo "Installing Docker..."

apt-get remove -y docker docker-engine docker.io containerd runc || true

apt-get update

apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

apt-key fingerprint 0EBFCD88 | grep CD88

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

apt-get update

apt-get install -y docker-ce docker-ce-cli containerd.io

groupadd docker || true
gpasswd -a vagrant docker || true

systemctl daemon-reload
systemctl start docker

echo -e "\033[0;32mDocker installed!\033[0m"