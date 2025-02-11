#!/bin/bash

# Kill any running instances of logioptionsplus
echo "Stopping any running instances of logioptionsplus..."
sudo pkill logioptionsplus

# Uninstall logioptionsplus.app
app_path="/Applications/logioptionsplus.app"
if [ -d "$app_path" ]; then
    echo "Uninstalling logioptionsplus.app..."
    sudo rm -rf "$app_path"
    echo "Uninstalled logioptionsplus.app."
else
    echo "logioptionsplus.app not found in /Applications."
fi

# Create the backup directory
backup_dir="/tmp/logi_backup"
mkdir -p "$backup_dir"

# Define the paths to search for Logitech files
paths=(
    "/Applications"
    "/Library"
    "~/Library"
    "/Library/Application Support"
    "~/Library/Application Support"
    "/Library/Preferences"
    "~/Library/Preferences"
    "/Library/Caches"
    "~/Library/Caches"
    "/Library/LaunchAgents"
    "~/Library/LaunchAgents"
    "/Library/LaunchDaemons"
    "~/Library/LaunchDaemons"
    "/Library/PreferencePanes"
    "~/Library/PreferencePanes"
    "/Library/StartupItems"
    "~/Library/StartupItems"
)

# Function to move and then delete Logitech files
move_and_delete_files() {
    local pattern="$1"
    for path in "${paths[@]}"; do
        echo "Searching in: $path"
        # Use 'find' to locate and move Logitech files to backup, then delete them
        find "$path" -iname "*$pattern*" -exec mv {} "$backup_dir" \; -exec rm -rf {} +
    done
}

# Move and delete Logitech related files
move_and_delete_files "logitech"
move_and_delete_files "logi.options"
move_and_delete_files "LogiOptions"
move_and_delete_files "logioptions"
move_and_delete_files "LogiPlugin"

# Download logioptionsplus installer
installer_url="https://download01.logi.com/web/ftp/pub/techsupport/optionsplus/logioptionsplus_installer.zip"
installer_zip="/tmp/logioptionsplus_installer.zip"

echo "Downloading logioptionsplus installer..."
curl -L "$installer_url" -o "$installer_zip"

# Unzip the installer
echo "Unzipping logioptionsplus installer..."
unzip -o "$installer_zip" -d /tmp

# Install logioptionsplus
installer_app="/tmp/logioptionsplus_installer.app"
if [ -d "$installer_app" ]; then
    echo "Installing logioptionsplus..."
    open "$installer_app"
    # Wait for the installer to complete
    read -p "Press any key after installation is complete..."
else
    echo "Installer not found."
fi

# Clean up
echo "Removing installation files..."
rm -rf "$installer_zip" /tmp/logioptionsplus_installer

echo "Backup and installation process completed."
