#!/bin/bash

# Exit on error
set -e

# Install build dependencies
echo "Installing build dependencies..."
sudo apt update
sudo apt install -y build-essential checkinstall zlib1g-dev wget

# Download OpenSSL 3 source code
OPENSSL_VERSION="3.0.8"
OPENSSL_TAR="openssl-${OPENSSL_VERSION}.tar.gz"
OPENSSL_URL="https://www.openssl.org/source/${OPENSSL_TAR}"

echo "Downloading OpenSSL ${OPENSSL_VERSION}..."
wget $OPENSSL_URL

# Extract the source code
echo "Extracting OpenSSL ${OPENSSL_VERSION}..."
tar -xvf $OPENSSL_TAR
cd "openssl-${OPENSSL_VERSION}"

# Configure, build, and install OpenSSL
echo "Configuring OpenSSL ${OPENSSL_VERSION}..."
./config --prefix=/usr/local/openssl

echo "Building OpenSSL ${OPENSSL_VERSION}..."
make

echo "Installing OpenSSL ${OPENSSL_VERSION}..."
sudo make install

# Update system to use the new OpenSSL
echo "Updating system to use new OpenSSL..."
sudo ln -sf /usr/local/openssl/bin/openssl /usr/bin/openssl
sudo ldconfig

# Verify the installation
echo "Verifying OpenSSL installation..."
openssl version

# Optional: Set environment variables
echo "Setting environment variables..."
export LD_LIBRARY_PATH=/usr/local/openssl/lib:$LD_LIBRARY_PATH
export PATH=/usr/local/openssl/bin:$PATH

# Persist environment variables
echo 'export LD_LIBRARY_PATH=/usr/local/openssl/lib:$LD_LIBRARY_PATH' >> ~/.bashrc
echo 'export PATH=/usr/local/openssl/bin:$PATH' >> ~/.bashrc

# Reload .bashrc
source ~/.bashrc

echo "OpenSSL ${OPENSSL_VERSION} installation completed successfully."
