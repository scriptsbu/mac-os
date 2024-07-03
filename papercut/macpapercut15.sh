#!/bin/bash

# Set the download URL
#download_url="http://10.20.240.3/it/iso/macos/papercut15/pc-print-deploy-client%5bpapercut.torc.tech%5d.dmg"
download_url="http://10.20.240.3/it/iso/macos/Papercut/pc-print-deploy-client%5bpapercut.torc.tech%5d.dmg"

# Set the destination file name and path
file_name="pc-print-deploy-client[papercut.torc.tech].dmg"
file_path="/Users/$USER/Downloads/$file_name"

# Download the file
echo "Downloading $file_name..."
curl -o "$file_path" "$download_url"

if [ $? -eq 0 ]; then
    echo "Download complete."
    
    # Mount the DMG file
    echo "Mounting the DMG file..."
    hdiutil attach "$file_path"
    
    # Find the package file inside the mounted volume
    package_path=$(find /Volumes/ -name "*.pkg" -type f -print -quit)
    
    if [ -n "$package_path" ]; then
        # Install the package
        echo "Installing the package..."
        sudo installer -pkg "$package_path" -target /
        
        if [ $? -eq 0 ]; then
            echo "Installation successful."
        else
            echo "Installation failed. Error code: $?"
        fi
    else
        echo "Failed to find the package file inside the DMG."
    fi
    
    # Unmount the DMG file
    echo "Unmounting the DMG file..."
    hdiutil detach "/Volumes/$(basename "${package_path%.*}")"
else
    echo "Download failed. Error code: $?"
fi
