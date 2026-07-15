#!/data/data/com.termux/files/usr/bin/bash

set -e

GALLEY_DIR="$HOME/Galley"
BASHRC="$HOME/.bashrc"

echo "Removing existing Galley installation..."
rm -rf "$GALLEY_DIR"

echo "Updating packages..."
pkg update -y

echo "Installing Git..."
pkg install -y git

echo "Cloning Galley..."
git clone https://github.com/MKVolk/Galley.git "$GALLEY_DIR"

echo "Making shell scripts executable..."
find "$GALLEY_DIR" -type f -name "*.sh" -exec chmod +x {} \;

# Add alias only if it doesn't already exist
if ! grep -qxF "alias setupGLL='bash \$HOME/Galley/setup.sh'" "$BASHRC"; then
    echo "alias setupGLL='bash \$HOME/Galley/setup.sh'" >> "$BASHRC"
    echo "Alias 'setupGLL' added to ~/.bashrc"
else
    echo "Alias 'setupGLL' already exists."
fi

echo
echo "Galley has been updated successfully!"
echo

echo "To use the new alias, either run:"
echo "  source ~/.bashrc"
echo
echo "or open a new Termux session."
echo
echo "Then start the installer with:"
echo "  setupGLL"
