#!/bin/sh
# Set the current user variable
currentUser=$(scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ { print $3 }' )

#Remove the admin privilege (Standard account)
dseditgroup -o edit -d $currentUser -t user admin

# Create the sudoers configuration file with restricted permissions
cat << EOF | sudo tee /private/etc/sudoers.d/restricted_user
$currentUser ALL=(ALL) NOPASSWD: /usr/bin/sudo, /usr/bin/vi, /usr/bin/nano, /usr/bin/pico, /usr/bin/vim
$currentUser ALL=!/usr/bin/passwd, !/usr/bin/defaults, !/usr/sbin/visudo, !/usr/bin/sudo -e /etc/sudoers, !/usr/local/bin/jamf, !/usr/bin/sudo -e /private/etc/sudoers
EOF

# Ensure the sudoers file has the correct permissions
sudo chmod 0440 /private/etc/sudoers.d/restricted_user

exit 0;     ## Sucess
exit 1;     ## Failure}
