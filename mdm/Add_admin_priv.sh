#!/bin/sh
# Set the current user variable
currentUser=$(scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ { print $3 }' )

#Add the admin privilege (Admin account)
dseditgroup -o edit -a $currentUser -t user admin

# Ensure the sudoers file has the correct permissions
sudo chmod 777 /private/etc/sudoers.d/restricted_user

# Ensure the sudoers file has been removed
sudo rm /private/etc/sudoers.d/restricted_user

exit 0;     ## Sucess
exit 1;     ## Failure}
