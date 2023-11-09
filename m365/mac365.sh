#!/bin/bash
cd ~/Downloads
sudo curl -O http://10.20.240.3/it/iso/macos/m365/Microsoft_365_and_Office_16.77.23091003_BusinessPro_Installer.pkg
sudo installer -verboseR -package ~/Downloads/Microsoft_365_and_Office_16.77.23091003_BusinessPro_Installer.pkg -target /
