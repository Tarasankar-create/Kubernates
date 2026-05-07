#!/bin/bash

# For AMD64 / x86_64
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.31.0/kind-linux-amd64
chmod +x ./kind
sudo cp ./kind usr/local/bin/kind

VERSION="v1.36.0"
URL="https://dl.k8s.io/release/${Version}/bin/linux/arm64/kubectl"
INSTALL_DIR="/usr/local/bin"

curl -LO "$URL"
chmod +x kubectl
sudo mv kubectl $INSTALL_DIR/

rm -f kubectl
rm -rf kind

echo "Installation complete"
