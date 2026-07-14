
#!/data/data/com.termux/files/usr/bin/bash

# ======================================================
# Termux Setup Script
# Sets dependencies and environment for the local server
# ======================================================

set -e

PREFIX=/data/data/com.termux/files/usr
BASHRC="$HOME/.bashrc"

echo "=== Galley Local Server Setup ==="

# ------------------------------------------------------
# Get Language
# ------------------------------------------------------
LANGUAGE="${LANG%%_*}"

if [ -z "$LANGUAGE" ]; then
    LANGUAGE="en"
fi

echo "Detected language: $LANGUAGE"

# ------------------------------------------------------
# Update packages
# ------------------------------------------------------
echo "Updating packages..."
pkg update -y
pkg upgrade -y

# ------------------------------------------------------
# Install dependencies
# ------------------------------------------------------
echo "Installing Python..."
pkg install -y python

echo "Installing Termux API..."
pkg install -y termux-api

echo "Installing Python package: pyqr..."
pip install --upgrade pip
pip install pyqr

# ------------------------------------------------------
# Create alias
# ------------------------------------------------------
if ! grep -q "alias startGLL=" "$BASHRC"; then
cat >> "$BASHRC" <<'EOF'

# Galley Local Server
alias startGLL='python ~/Galley/simple_server.py'
EOF
fi

if ! grep -q "alias updateGLL=" "$BASHRC"; then
cat >> "$BASHRC" <<'EOF'

# Galley Updater
alias updateGLL='bash ~/Galley/update.sh'
EOF
fi

# ------------------------------------------------------
# Create prompt command
# ------------------------------------------------------
cat > "$PREFIX/bin/startGLLPrompt" <<'EOF'
#!/data/data/com.termux/files/usr/bin/bash

if ! command -v termux-dialog >/dev/null 2>&1; then
    echo "termux-dialog not found."
    echo "Starting server..."
    python ~/Galley/simple_server.py
    exit 0
fi

RESULT=$(termux-dialog radio \
    -t "Galley" \
    -v "Yes,No")

CHOICE=$(echo "$RESULT" | python -c '
import json,sys
try:
    print(json.load(sys.stdin).get("text",""))
except Exception:
    pass
')

case "$CHOICE" in
    Yes|yes)
        python ~/Galley/simple_server.py
        ;;
    *)
        echo "Server not started."
        ;;
esac
EOF

chmod +x "$PREFIX/bin/startGLLPrompt"

# ------------------------------------------------------
# Reload shell
# ------------------------------------------------------
source "$BASHRC"

echo
echo "======================================="
echo "Setup complete!"
echo
echo "Available commands:"
echo "  startGLL        - Start the local server"
echo "  startGLLPrompt  - Ask using Android UI before starting"
echo "======================================="
