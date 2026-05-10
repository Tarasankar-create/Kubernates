#!/bin/bash

# Update packages
sudo apt update -y

# Install dependencies
sudo apt install -y curl apt-transport-https

# Download kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s \
https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Make kubectl executable
chmod +x kubectl

# Move kubectl to system path
sudo mv kubectl /usr/local/bin/

# Verify kubectl
kubectl version --client

# Download Minikube
curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64

# Install Minikube
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Remove downloaded file
rm minikube-linux-amd64

# Start Minikube
minikube start --driver=docker

# Verify cluster
kubectl get nodes
kubectl get po -A
