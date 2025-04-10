#!/bin/bash

# Author: Alberto Lopez-Santiago
# Description: This script lists connected drives on a macOS system,
# allows the user to select a drive to format, and then erases and formats 
# the drive based on the user's choice. The script prompts for confirmations 
# to ensure the user is aware of the irreversible nature of formatting drives.

# Display introduction
echo "============================================"
echo "          Disk Formatting Tool            "
echo "            Author: Alberto Lopez-Santiago "
echo "            Description: Lists connected drives"
echo "            and formats them upon user request."
echo "============================================"
# Function to list connected drives with their capacities
list_drives() {
    echo "Connected Drives:"
    # Counter for numbering the drives
    local count=1

    # Use diskutil list to display drives
    diskutil list | grep "/dev/disk" | while read -r line; do
        # Extract the disk identifier
        disk_id=$(echo "$line" | awk '{print $1}')

        # Check if the disk exists and retrieve its capacity
        if [ -n "$disk_id" ]; then
            capacity=$(diskutil info "$disk_id" | grep "Disk Size" | awk '{for (i=3; i<=NF; i++) printf $i " "; print ""}')
            
            # Display the drive with a number and its capacity
            echo "$count) $disk_id - $capacity"
            # Increment the counter
            count=$((count + 1))
        fi
    done
}

# Function to prompt for drive selection
select_drive() {
    read -p "Please select the number corresponding to the drive you want to erase (q to quit): " drive_number
    if [[ "$drive_number" == "q" ]]; then
        echo "Exiting the script."
        exit 0
    fi
    # Validate drive selection
    if ! [[ "$drive_number" =~ ^[0-9]+$ ]]; then
        echo "Invalid input. Please enter a number or 'q' to quit."
        select_drive
    fi
}

# Function to format the drive
format_drive() {
    local drive="$1"
    local format="$2"
    local drive_name="${3:-MyDrive}"  # Use passed name or default to MyDrive
    
    echo "You have chosen to format $drive as $format."
    read -p "Are you sure you want to erase and format $drive? This action cannot be undone (yes/no, q to quit): " confirm
    if [[ "$confirm" == "yes" ]]; then
        # Format the drive - WARNING: This will erase all data on the selected drive!
        diskutil eraseDisk "$format" "$drive_name" "$drive"
        echo "Drive $drive has been formatted as $format with the name '$drive_name'."
    elif [[ "$confirm" == "q" ]]; then
        echo "Exiting the script."
        exit 0
    else
        echo "Operation canceled."
    fi
}

# Main script execution
list_drives
select_drive

# Get the selected drive based on the entered number
selected_drive=$(diskutil list | grep "/dev/disk" | awk '{print $1}' | sed -n "${drive_number}p")

# Format options
echo "Select the format option:"
echo "1) exFAT"
echo "2) FAT32"
echo "3) NTFS"
echo "4) APFS"
echo "5) USB-Compatible Format (FAT32/exFAT, Max 4096B Sector, No Encryption Check)"
read -p "Enter the format option (1-5, q to quit): " format_option

if [[ "$format_option" == "q" ]]; then
    echo "Exiting the script."
    exit 0
fi

case $format_option in
    1) format="ExFAT" ;;
    2) format="MS-DOS FAT32" ;;
    3) format="NTFS" ;;
    4) format="APFS" ;;
    5)
        # USB-Compatible Format Option
        echo "Checking for USB compatibility..."

        # Check sector size
        sector_size=$(diskutil info "$selected_drive" | grep "Device Block Size" | awk '{print $4}')
        if [[ "$sector_size" -gt 4096 ]]; then
            echo "Warning: Sector size is greater than 4096 bytes. This may not be USB compatible."
        fi

        echo "Choose file system:"
        echo "1) exFAT"
        echo "2) FAT32"
        read -p "Select a format (1 or 2): " usb_format_choice
        case $usb_format_choice in
            1) format="ExFAT" ;;
            2) format="MS-DOS FAT32" ;;
            *) echo "Invalid option. Defaulting to FAT32."; format="MS-DOS FAT32" ;;
        esac

        echo "Note: This option assumes the USB meets these conditions:"
        echo "- USB Mass Storage Class"
        echo "- SCSI or SFF-8070i subclass"
        echo "- Bulk Transfer"
        echo "- Max sector size 4096 Bytes"
        echo "- No encryption (not enforceable by script)"
        ;;
    *) echo "Invalid option selected"; exit 1 ;;
esac
cd 
# Ask for the drive name
read -p "Would you like to change the drive name? (yes/no, q to quit): " change_name
if [[ "$change_name" == "q" ]]; then
    echo "Exiting the script."
    exit 0
elif [[ "$change_name" == "yes" ]]; then
    read -p "Enter the new drive name: " drive_name
else
    drive_name="MyDrive"  # Default name
fi

# Call the format function
format_drive "$selected_drive" "$format" "$drive_name"
