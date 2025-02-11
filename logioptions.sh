#!/bin/bash

# ***********************************************************************
#                       IT Support Script
# 
# Author: Alberto Lopez-Santiago
# GitHub: https://github.com/scriptsbu
#
# This script addresses a notorious problem with logioptionsplus 
# where it suddenly stops loading for users and gets stuck on 
# an infinite loading screen with the message "Backend connection 
# problem click here to launch backend".
#
# It provides options to install logioptionsplus or restore a backup.
#
# Feel free to use and modify this script under the following copyright:
# © 2023 Alberto Lopez-Santiago
# ***********************************************************************

# ASCII Art Logo
echo "  _____   _____ "
echo " |_   _| |_   _|"
echo "   | |     | | "
echo "   | |     | | "
echo "  _| |_    | | "
echo " |_____|   |_| "
echo "Welcome to the IT Support Script!"
# ***********************************************************************

# Function to show a loading bar
loading_bar() {
    local duration=$1
    local bar_length=20
    local progress=0
    local increment=$((duration / bar_length))

    while [ $progress -le $duration ]; do
        local filled=$((progress * bar_length / duration))
        local empty=$((bar_length - filled))
        printf "\r[%-${bar_length}s] %d%%" "$(printf "%0.s#" $(seq 1 $filled))$(printf "%0.s-" $(seq 1 $empty))" $((progress * 100 / duration))
        sleep $increment
        ((progress += increment))
    done
    echo -ne "\r[####################] 100%\n"
}

# Function to install logioptionsplus
install_logioptions() {
    echo "Purging logioptionsplus..."
    # Kill any running instances of logioptionsplus
    sudo pkill logioptionsplus

    # Uninstall logioptionsplus.app silently with a loading bar
    app_path="/Applications/logioptionsplus.app"
    if [ -d "$app_path" ]; then
        echo "Uninstalling logioptionsplus.app..."
        (sudo rm -rf "$app_path") &
        loading_bar 5  # Adjust the duration as needed
        wait  # Wait for the uninstall command to finish
        echo "Uninstalled logioptionsplus.app."
    else
        echo "logioptionsplus.app not found in /Applications."
    fi

    # Create the backup directory silently with a loading bar
    backup_dir="/tmp/logi_backup"
    echo "Creating backup directory..."
    (mkdir -p "$backup_dir") &
    loading_bar 2  # Adjust the duration as needed
    wait  # Wait for the mkdir command to finish

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

    # Function to move and delete Logitech files with a loading bar
    move_and_delete_files() {
        local pattern="$1"
        for path in "${paths[@]}"; do
            echo "Searching in: $path"
            (find "$path" -iname "*$pattern*" -exec mv {} "$backup_dir" \; -exec rm -rf {} +) &
            loading_bar 3  # Adjust duration for each path
            wait  # Wait for the find command to finish
        done
    }

    # Move and delete Logitech related files
    move_and_delete_files "logitech"
    move_and_delete_files "logi.options"
    move_and_delete_files "LogiOptions"
    move_and_delete_files "logioptions"
    move_and_delete_files "LogiPlugin"

    # Download logioptionsplus installer
    echo "Installing logioptionsplus..."
    installer_url="https://download01.logi.com/web/ftp/pub/techsupport/optionsplus/logioptionsplus_installer.zip"
    installer_zip="/tmp/logioptionsplus_installer.zip"

    echo "Downloading logioptionsplus installer..."
    (curl -L "$installer_url" -o "$installer_zip") &
    loading_bar 5  # Adjust the duration as needed
    wait  # Wait for the download to finish

    # Unzip the installer
    echo "Unzipping logioptionsplus installer..."
    (unzip -o "$installer_zip" -d /tmp) &
    loading_bar 3  # Adjust duration as needed
    wait  # Wait for the unzip command to finish

    # Install logioptionsplus
    installer_app="/tmp/logioptionsplus_installer.app"
    if [ -d "$installer_app" ]; then
        echo "Installing logioptionsplus..."
        open "$installer_app"
        read -p "Press any key after installation is complete..."
        # Resolving Options+ issues when Secure Input is enabled.
        open -a Terminal --args bash -c 'kill -9 $(ioreg -l -d 1 -w 0 | grep kCGSSessionSecureInputPID | sed -E "s/.*\"kCGSSessionSecureInputPID\"=([0-9]+).*/\1/")'
    else
        echo "Installer not found."
    fi

    # Clean up
    echo "Removing installation files..."
    rm -rf "$installer_zip" /tmp/logioptionsplus_installer

    echo "Backup and installation process completed. Files stored at $backup_dir"
}

# Function to restore the backup
restore_backup() {
    echo "Restoring backup from /tmp/logi_backup..."
    backup_dir="/tmp/logi_backup"

    if [ ! -d "$backup_dir" ]; then
        echo "Backup directory not found: $backup_dir"
        exit 1
    fi

    for file in "$backup_dir"/*; do
        if [ -f "$file" ]; then
            original_path="${file/$backup_dir\//}"
            original_path="$HOME$original_path"
            echo "Restoring $file to $original_path..."
            mkdir -p "$(dirname "$original_path")"
            mv "$file" "$original_path"
        fi
    done

    echo "Restoration process completed."
}

# Main menu
while true; do
    echo "Select an option:"
    echo "1) Fix/Install logioptionsplus"
    echo "2) Restore backup"
    echo "3) Exit"
    read -p "Enter your choice (1-3): " choice

    case $choice in
        1)
            install_logioptions
            ;;
        2)
            restore_backup
            ;;
        3)
            echo "Exiting."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please enter 1, 2, or 3."
            ;;
    esac
done
