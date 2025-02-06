#!/bin/bash

# Get the total number of applications
total_apps=$(ls /Applications | wc -l)
count=0
rejected_apps=()

echo "Scanning for applications blocked by Gatekeeper..."

for app in /Applications/*; do
    result=$(sudo spctl --assess --verbose=1 "$app" 2>&1)
    if echo "$result" | grep -q 'rejected'; then
        rejected_apps+=("$app: $result")
    fi
    count=$((count + 1))
    percent=$((count * 100 / total_apps))
    printf "\rProgress: [%-50s] %d%%" $(printf '#%.0s' $(seq 1 $((percent / 2)))) $percent
done

echo -e "\nScan complete."
echo -e "\nRejected applications:"
for rejected in "${rejected_apps[@]}"; do
    echo "$rejected"
done
