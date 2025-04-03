#!/bin/bash
cd ~/Downloads
#sudo curl -O http://10.20.240.3/it/iso/macos/m365-14/Microsoft_365_and_Office_16.78.23102801_BusinessPro_Installer.pkg
sudo curl -L --output Microsoft_365_and_Office_16.95.25030928_Installer.pkg "https://go.microsoft.com/fwlink/?linkid=525133&clcid=0x409&culture=en-us&country=us"
sudo installer -verboseR -package ~/Downloads/Microsoft_365_and_Office_16.78.23102801_BusinessPro_Installer.pkg -target /
open /Applications/Microsoft\ Outlook.app
