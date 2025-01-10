#!/bin/bash
# Disable FileVault for the current user

current_user=$(whoami)
echo "Disabling FileVault for user: $current_user..."
userNameUUID=$(dscl . -read /Users/$current_user GeneratedUID | awk "{print \$2}")

# Unlock the volume with sudo
sudo diskutil apfs unlockVolume /dev/disk3s1 -user "$userNameUUID"

# Disable FileVault with sudo
sudo diskutil apfs disableFileVault disk3s1 -user "$userNameUUID"

# Check FileVault status
fdesetup status
