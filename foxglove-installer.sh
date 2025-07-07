#!/bin/bash

# Define basic info
PKG_ID="com.foxglove.studio.installer"
PKG_VERSION="1.0"
WORK_DIR="/tmp/foxglove_pkg_build"
SCRIPT_NAME="postinstall"
PKG_NAME="foxglove-installer.pkg"

# Clean up previous work
rm -rf "$WORK_DIR"
mkdir -p "$WORK_DIR/scripts"

# Create the postinstall script
cat > "$WORK_DIR/scripts/$SCRIPT_NAME" << 'EOF'
#!/bin/bash

APP_NAME="Foxglove Studio.app"
APP_PATH="/Applications/$APP_NAME"
TEMP_DMG="/tmp/foxglove-studio-latest.dmg"
MOUNT_POINT="/Volumes/FoxgloveStudio"

get_latest_version() {
    curl -s https://api.github.com/repos/foxglove/studio/releases/latest | grep '"tag_name":' | awk -F '"' '{print $4}'
}

LATEST_VERSION=$(get_latest_version)
if [[ -z "$LATEST_VERSION" ]]; then
    echo "Failed to fetch the latest version. Aborting."
    exit 1
fi

DMG_FILENAME="foxglove-studio-${LATEST_VERSION#v}-mac-universal.dmg"
DOWNLOAD_URL="https://github.com/foxglove/studio/releases/download/${LATEST_VERSION}/${DMG_FILENAME}"

echo "Latest version: $LATEST_VERSION"
echo "Downloading from: $DOWNLOAD_URL"

if pgrep -x "Foxglove Studio" > /dev/null; then
    echo "Foxglove Studio is currently running."
    osascript -e 'display alert "Foxglove Studio Update" message "Foxglove Studio will be closed in 2 minutes for an update. Please save your work." buttons {"OK"} default button "OK"'
    echo "Waiting 2 minutes..."
    sleep 120
    osascript -e 'quit app "Foxglove Studio"'
    sleep 5
fi

echo "Downloading Foxglove Studio..."
curl -L -o "$TEMP_DMG" "$DOWNLOAD_URL"
if [ $? -ne 0 ]; then
    echo "Download failed. Aborting."
    exit 1
fi

if ! hdiutil imageinfo "$TEMP_DMG" &>/dev/null; then
    echo "Not a valid DMG. Aborting."
    rm -f "$TEMP_DMG"
    exit 1
fi

echo "Mounting DMG..."
hdiutil attach "$TEMP_DMG" -mountpoint "$MOUNT_POINT" -nobrowse -quiet
if [ $? -ne 0 ]; then
    echo "Failed to mount DMG. Aborting."
    rm -f "$TEMP_DMG"
    exit 1
fi

echo "Removing old version..."
rm -rf "$APP_PATH"

echo "Installing Foxglove Studio..."
cp -R "$MOUNT_POINT/Foxglove Studio.app" /Applications/
if [ ! -d "$APP_PATH" ]; then
    echo "Installation failed."
    hdiutil detach "$MOUNT_POINT" -quiet
    rm -f "$TEMP_DMG"
    exit 1
fi

echo "Cleaning up..."
hdiutil detach "$MOUNT_POINT" -quiet
rm -f "$TEMP_DMG"

echo "Launching Foxglove Studio..."
open /Applications/Foxglove\ Studio.app/

echo "Foxglove Studio has been successfully installed or updated."
EOF

# Make postinstall script executable
chmod +x "$WORK_DIR/scripts/$SCRIPT_NAME"

# Build the .pkg
pkgbuild \
  --identifier "$PKG_ID" \
  --version "$PKG_VERSION" \
  --scripts "$WORK_DIR/scripts" \
  --nopayload \
  "$PKG_NAME"

echo "Package built: $PKG_NAME"
