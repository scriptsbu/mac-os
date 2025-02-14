#!/bin/bash

# Determine the processor architecture
ARCH=$(uname -m)

# Set the download URL based on the architecture
if [ "$ARCH" == "x86_64" ]; then
    URL="https://d1uj6qtbmh3dt5.cloudfront.net/2024.0/Clients/nice-dcv-viewer-2024.0.7209.x86_64.dmg"
elif [ "$ARCH" == "arm64" ]; then
    URL="https://d1uj6qtbmh3dt5.cloudfront.net/2024.0/Clients/nice-dcv-viewer-2024.0.7209.arm64.dmg"
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

# Define the filename
FILENAME="nice-dcv-viewer.dmg"

# Download the DMG file
echo "Downloading Amazon DCV from $URL..."
curl -o "$FILENAME" "$URL"

# Mount the DMG file
echo "Mounting the DMG file..."
MOUNT_OUTPUT=$(hdiutil attach "$FILENAME" -nobrowse)

# Extract the mounted volume name
MOUNT_POINT=$(echo "$MOUNT_OUTPUT" | grep -o '/Volumes/[^ ]*' | head -n 1)

# Install the application
if [ -d "$MOUNT_POINT" ]; then
    echo "Contents of the mounted volume:"
    ls "$MOUNT_POINT"  # List contents for debugging

    echo "Installing Amazon DCV..."
    # Copy the app folder, assuming it has the .app extension
    cp -R "$MOUNT_POINT/"*.app /Applications/

    # Check if the application was copied successfully
    if [ -e /Applications/DCV\ Viewer.app ]; then
        echo "Installation successful."
    else
        echo "Installation failed: Application not found in /Applications."
        exit 1
    fi
else
    echo "Error: Mount point not found."
    exit 1
fi

# Unmount the DMG file
echo "Unmounting the DMG file..."
hdiutil detach "$MOUNT_POINT"

# Clean up the installer
echo "Cleaning up..."
rm "$FILENAME"

# Open the application
echo "Opening Amazon DCV..."
osascript -e 'tell application "DCV Viewer" to activate'

echo "Installation complete!"
