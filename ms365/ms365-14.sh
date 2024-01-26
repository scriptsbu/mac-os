#!/bin/bash
cd ~/Downloads
sudo curl -O http://10.20.240.3/it/iso/macos/m365-14/Microsoft_365_and_Office_16.78.23102801_BusinessPro_Installer.pkg
sudo installer -verboseR -package ~/Downloads/Microsoft_365_and_Office_16.78.23102801_BusinessPro_Installer.pkg -target /
open /Applications/Microsoft\ Outlook.app
