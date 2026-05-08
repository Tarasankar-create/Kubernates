#!/bin/bash

sudo apt update
# To install the latest minikube stable release on x86-64 Linux using binary download:
curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64

# Start your cluster
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64

minikube start

kubectl get po -A
