#!/bin/bash
set -e

INSTALL_DIR="/usr/local/bin"

ARCH=$(uname -m)

if [ "$ARCH" = "x86_64" ]; then
    KIND_URL="https://kind.sigs.k8s.io/dl/v0.31.0/kind-linux-amd64"
    KUBECTL_ARCH="amd64"
elif [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
    KIND_URL="https://kind.sigs.k8s.io/dl/v0.31.0/kind-linux-arm64"
    KUBECTL_ARCH="arm64"
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

echo "Installing kind..."
curl -Lo kind "$KIND_URL"
chmod +x kind
sudo mv kind $INSTALL_DIR/

VERSION="v1.36.0"
URL="https://dl.k8s.io/release/${VERSION}/bin/linux/${KUBECTL_ARCH}/kubectl"

echo "Installing kubectl..."
curl -Lo kubectl "$URL"
chmod +x kubectl
sudo mv kubectl $INSTALL_DIR/

echo "Verifying installation..."
kind --version
kubectl version --client

echo "Installation complete"
