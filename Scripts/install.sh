#!/bin/bash

set -e

CLI_NAME="iosgen"
BUILD_PATH=".build/release/$CLI_NAME"
INSTALL_BIN="/usr/local/bin/$CLI_NAME"
INSTALL_TEMPLATE="/usr/local/share/$CLI_NAME/Templates"

echo "📦 Building $CLI_NAME CLI..."
swift build -c release

if [ ! -f "$BUILD_PATH" ]; then
  echo "❌ Build failed: $BUILD_PATH not found"
  exit 1
fi

echo "📥 Installing binary to $INSTALL_BIN"
sudo cp "$BUILD_PATH" "$INSTALL_BIN"
sudo chmod +x "$INSTALL_BIN"

echo "📁 Installing templates to $INSTALL_TEMPLATE"
sudo mkdir -p "$INSTALL_TEMPLATE"
sudo cp -R Templates/* "$INSTALL_TEMPLATE"

sudo chown -R $(whoami) "$INSTALL_TEMPLATE"
sudo chmod -R u+rwX "$INSTALL_TEMPLATE"

echo "✅ Installation complete!"
echo "👉 You can now run '$CLI_NAME init YourProjectName' from anywhere."
