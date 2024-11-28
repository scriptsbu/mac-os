#!/bin/bash
# Notify that the script has started
echo "Starting the script..."

# Remove the system preferences plist
echo "Removing system preferences plist..."
sudo rm /Library/Preferences/com.apple.systempreferences.plist
echo "System preferences plist removed."

# Write the new preferences
echo "Writing new preferences..."
sudo defaults write "/Library/Preferences/com.apple.systempreferences" -array "com.apple.preferences.softwareupdate"
echo "New preferences written."

# Check for available software updates
echo "Checking for available software updates..."
softwareupdate -l

# Install a specific macOS update
if [ -z "$4" ]; then
    echo "No update specified. Exiting."
    exit 1
fi

echo "Installing macOS update: $4..."
sudo softwareupdate -i "$4"
echo "Update $4 installed."

# Display a message via Jamf
if [ -n "$5" ]; then
    echo "Displaying message via Jamf: $5"
    sudo jamf displayMessage -message "$5"
else
    echo "No message provided for Jamf."
fi

# Check for any other updates after the specified update
echo "Checking for any additional software updates..."
if softwareupdate -l | grep -q "Software Update found"; then
    echo "Additional updates are available. Installing updates..."
    sudo softwareupdate -ia  # Install all available updates
    echo "Updates installed. The system will reboot in $6 seconds."

    # Delay
    sleep $6

    # Display a message via Jamf if provided
    if [ -n "$7" ]; then
        echo "Displaying last message via Jamf: $7"
        sudo jamf displayMessage -message "$7"
    else
        echo "No last message provided for Jamf."
    fi

    # Delay
    sleep $8
     
    # Perform the restart
    echo "Rebooting now..."
    sudo shutdown -r now
else
    echo "No additional updates available."
fi

# Notify that the script has completed
echo "Script completed."
