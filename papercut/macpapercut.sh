#!/bin/bash
cd ~/Downloads
#sudo curl -O http://10.20.240.3/it/iso/macos/Papercut/pc-print-deploy-client%5bpapercut.torc.tech%5d.dmg
#sudo curl -O http://10.20.240.3/it/iso/macos/Papercut/paper15/pc-print-deploy-client%5bpapercut.torc.tech%5d.dmg
sudo curl -O http://10.20.240.3/it/iso/macos/Papercut/paper15/PaperCut%20Print%20Deploy%20Client.pkg
sudo installer -verboseR -package ~/Downloads/PaperCut%20Print%20Deploy%20Client.pkg -target /
#open pc-print-deploy-client%5bpapercut.torc.tech%5d.dmg
