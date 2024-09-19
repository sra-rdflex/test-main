#!/bin/bash

# Update and install necessary dependencies
echo "Updating package list and installing dependencies..."
sudo apt update
sudo apt install -y build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
    libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python3-openssl git

# Install pyenv
echo "Installing pyenv..."
curl https://pyenv.run | bash

# Add pyenv to shell configuration
echo "Updating shell configuration..."
if ! grep -q 'pyenv' ~/.bashrc; then
    echo -e '\n# Pyenv Configuration\nexport PATH="$HOME/.pyenv/bin:$PATH"\neval "$(pyenv init --path)"\neval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
fi

# Apply changes to the shell
source ~/.bashrc

# Install a specific Python version
PYTHON_VERSION="3.8.10"
echo "Installing Python $PYTHON_VERSION..."
pyenv install $PYTHON_VERSION

# Set the installed Python version as global
echo "Setting Python $PYTHON_VERSION as global..."
pyenv global $PYTHON_VERSION

# Verify installation
echo "Verifying installation..."
pyenv --version
python --version

echo "Pyenv setup completed successfully."
