
#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "Updating packages..."
pkg update -y

echo "Installing Git..."
pkg install -y git

echo "Removing existing Galley installation..."
rm -rf ~/Galley

echo "Cloning latest Galley..."
git clone https://github.com/MKVolk/Galley.git ~/Galley

echo "Making shell scripts executable..."
find ~/Galley -name '*.sh' -exec chmod +x {} \;

# Add alias if it doesn't already exist
if ! grep -qxF "alias setupGLL='bash ~/Galley/setup.sh'" ~/.bashrc; then
    echo "alias setupGLL='bash ~/Galley/setup.sh'" >> ~/.bashrc
fi

# Reload shell configuration
. ~/.bashrc

echo
echo "Galley has been updated successfully!"
echo "Run 'setupGLL' to start the setup script."
