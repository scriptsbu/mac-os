#!/bin/bash

# Set the download URL
url="https://trials.adobe.com/AdobeProducts/APRO/Acrobat_HelpX/osx10/Acrobat_DC_Web_WWMUI.dmg"

# Set the destination file name
filename="Acrobat_DC_Web_WWMUI.dmg"

# Download the DMG file
echo "Downloading Acrobat DC..."
curl -o "$filename" "$url"

# Mount the DMG file
echo "Mounting the DMG file..."
hdiutil attach "$filename"

# Find the package path
package_path=$(find "/Volumes" -name "*.pkg" -print -quit)

# Install the app
echo "Installing Acrobat DC..."
sudo installer -pkg "$package_path" -target /

# Unmount the DMG file
echo "Unmounting the DMG file..."
diskutil unmount force "/Volumes/Acrobat"

rm "$filename"

echo "Acrobat DC installation complete."
