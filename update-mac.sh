#!/bin/bash

# Notify that the script has started
echo "Starting the script..."

# Disable FileVault for the current user
current_user=$(whoami)
echo "Disabling FileVault for user: $current_user..."
userNameUUID=$(dscl . -read /Users/$USER/ GeneratedUID | awk '{print $2}')
diskutil apfs unlockVolume /dev/disk3s1 -user $userNameUUID
diskutil apfs disableFileVault disk3s1 -user $userNameUUID
fdesetup status
#sudo fdesetup disable

# Display a message via Jamf
echo "Displaying message via Jamf: Initiating macOS Update - The update process may take up to 4 hours to complete. Please refrain from rebooting your system during this time to ensure a smooth installation."
sudo jamf displayMessage -message "Initiating macOS Update - The update process may take up to 4 hours to complete. Please refrain from rebooting your system during this time to ensure a smooth installation."
echo "No message provided for Jamf."

# Write the new preferences to enable update menu
echo "Writing new preferences..."
sudo defaults delete "/Library/Preferences/com.apple.systempreferences" "com.apple.preferences.softwareupdate"
echo "New preferences written."

# Check for available software updates
echo "Checking for available software updates..."
softwareupdate -l

# Check if the update specified in macOS Sonoma 14.7.1-23H222 is already installed
#if softwareupdate --history | grep -q "macOS Sonoma 14.7.1-23H222"; then
#    echo "Update macOS Sonoma 14.7.1-23H222 is already installed. Exiting script."
#    exit 0
#fi

echo "Downloading macOS update: macOS Sonoma 14.7.1-23H222..."
sudo softwareupdate -d "macOS Sonoma 14.7.1-23H222"
echo "Update macOS Sonoma 14.7.1-23H222 downloaded."

# Display a message via Jamf
echo "Displaying message via Jamf: The macOS update has been successfully downloaded. The system will reboot in 15 minutes. Please make sure to save all your work and close any open applications to avoid losing data. Do not reboot the system on your own, as this may corrupt your files. Allow the system to reboot itself to ensure a smooth transition and to avoid any potential issues."
sudo jamf displayMessage -message "The macOS update has been successfully downloaded. The system will reboot in 15 minutes. Please make sure to save all your work and close any open applications to avoid losing data. Do not reboot the system on your own, as this may corrupt your files. Allow the system to reboot itself to ensure a smooth transition and to avoid any potential issues."

sleep 10

# Display a message via Jamf if provided
echo "Displaying last message via Jamf: The system will reboot in 1 minute."
sudo jamf displayMessage -message "The system will reboot in 1 minute."

# Delay
sleep 5

# Notify that the script has completed
echo "Script completed."

echo "Installing macOS update: macOS Sonoma 14.7.1-23H222..."
sudo softwareupdate -iR "macOS Sonoma 14.7.1-23H222" --verbose
echo "Update macOS Sonoma 14.7.1-23H222 installed."

# Perform the restart
#echo "Shutting down now..."
#sudo shutdown -r now
