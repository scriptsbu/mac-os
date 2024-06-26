#!/bin/bash
# Get the latest Firefox version
FIREFOX_VERSION=$(curl -s https://www.mozilla.org/en-US/firefox/new/ | 
                  grep -o 'data-latest-firefox="[^"]*"' | 
                  sed 's/data-latest-firefox="\([^"]*\)"/\1/')

# Construct the download URL
DOWNLOAD_URL="https://download.mozilla.org/?product=firefox-${FIREFOX_VERSION}&os=osx&lang=en-US"

# Create a temporary file in the /private/tmp directory
TEMP_DIR="/private/tmp/firefox-install"
mkdir -p "$TEMP_DIR"
TEMP_FILE="$TEMP_DIR/firefox-download.dmg"

# Create a logfile in the /private/tmp directory
LOGFILE="$TEMP_DIR/firefox-install.log"

# Get the current date and time
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Write the timestamp to the log file
echo "[$TIMESTAMP] Firefox installation started" > "$LOGFILE"

# Download the file to the temporary file and log the output
echo "Downloading Firefox version $FIREFOX_VERSION..." | tee -a "$LOGFILE"
curl -L -o "$TEMP_FILE" "$DOWNLOAD_URL" >> "$LOGFILE" 2>&1

echo "Firefox download complete!" | tee -a "$LOGFILE"

echo "Installing Firefox..." | tee -a "$LOGFILE"

# Mount the DMG file
echo "Mounting DMG file..." | tee -a "$LOGFILE"
hdiutil attach "$TEMP_FILE" >> "$LOGFILE" 2>&1

# Copy the Firefox application to the user's Applications folder
echo "Copying Firefox application to Applications folder..." | tee -a "$LOGFILE"
cp -R "/Volumes/Firefox/Firefox.app" "/Applications" >> "$LOGFILE" 2>&1

# Eject the DMG file
echo "Ejecting DMG file..." | tee -a "$LOGFILE"
hdiutil detach "/Volumes/Firefox" >> "$LOGFILE" 2>&1

# Remove the temporary file
echo "Removing temporary file..." | tee -a "$LOGFILE"
rm -rf "$TEMP_FILE" >> "$LOGFILE" 2>&1

echo "Firefox installation complete!" | tee -a "$LOGFILE"
echo "Logfile: $LOGFILE"
echo "Firefox application has been copied to the /Applications folder."

# Start the Firefox application
echo "Starting Firefox..." | tee -a "$LOGFILE"
"/Applications/Firefox.app/Contents/MacOS/firefox" &
osascript -e 'tell application "Firefox" to activate'

# ALBERTO's NOTES:
#The echo lines were done during the local testing period to troubleshoot where the script could be failing; leaving them uncommented will not affect the MDM trigger at all.
#
#The log file can be read by typing the following in Terminal: nano /private/tmp/firefox-install/firefox-install.log
