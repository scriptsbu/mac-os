#!/bin/bash

# Define variables
APP_NAME="Foxglove Studio.app"
APP_PATH="/Applications/$APP_NAME"
TEMP_DMG="/tmp/foxglove-studio-latest.dmg"
MOUNT_POINT="/Volumes/FoxgloveStudio"

# Function to fetch the latest release tag from GitHub
get_latest_version() {
    curl -s https://api.github.com/repos/foxglove/studio/releases/latest | grep '"tag_name":' | awk -F '"' '{print $4}'
}

# Fetch latest version
LATEST_VERSION=$(get_latest_version)

if [[ -z "$LATEST_VERSION" ]]; then
    echo "Failed to fetch the latest version from GitHub. Aborting."
    exit 1
fi

DMG_FILENAME="foxglove-studio-${LATEST_VERSION#v}-mac-universal.dmg"
DOWNLOAD_URL="https://github.com/foxglove/studio/releases/download/${LATEST_VERSION}/${DMG_FILENAME}"

echo "Latest version: $LATEST_VERSION"
echo "Downloading from: $DOWNLOAD_URL"

# Check if app is running and notify user
if pgrep -x "Foxglove Studio" > /dev/null; then
    echo "Foxglove Studio is currently running."
    osascript -e 'display alert "Foxglove Studio Update" message "Foxglove Studio will be closed in 2 minutes for an update. Please save your work." buttons {"OK"} default button "OK"'
    echo "Waiting 2 minutes for user to save work..."
    sleep 120
    echo "Closing Foxglove Studio..."
    osascript -e 'quit app "Foxglove Studio"'
    sleep 5
fi

# Download the DMG
echo "Downloading the latest version of Foxglove Studio..."
curl -L -o "$TEMP_DMG" "$DOWNLOAD_URL"
if [ $? -ne 0 ]; then
    echo "Download failed. Aborting."
    exit 1
fi

# Sanity check: Make sure it's a valid DMG
if ! hdiutil imageinfo "$TEMP_DMG" &>/dev/null; then
    echo "Downloaded file is not a valid DMG. Aborting."
    rm -f "$TEMP_DMG"
    exit 1
fi

# Mount the DMG
echo "Mounting DMG..."
hdiutil attach "$TEMP_DMG" -mountpoint "$MOUNT_POINT" -nobrowse -quiet
if [ $? -ne 0 ]; then
    echo "Failed to mount DMG. Aborting."
    rm -f "$TEMP_DMG"
    exit 1
fi

# Remove old version (if exists)
echo "Removing old version (if any)..."
rm -rf "$APP_PATH"

# Install the new version
echo "Installing Foxglove Studio..."
cp -R "$MOUNT_POINT/Foxglove Studio.app" /Applications/
if [ ! -d "$APP_PATH" ]; then
    echo "Installation failed. App not found at expected location."
    hdiutil detach "$MOUNT_POINT" -quiet
    rm -f "$TEMP_DMG"
    exit 1
fi

# Clean up
echo "Cleaning up..."
hdiutil detach "$MOUNT_POINT" -quiet
rm -f "$TEMP_DMG"

echo "Foxglove Studio has been successfully installed or updated."

open /Applications/Foxglove\ Studio.app/
