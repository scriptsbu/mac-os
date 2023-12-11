#!/bin/bash
cd ~/Downloads
sudo curl -O http://10.20.240.3/it/iso/macos/Papercut/pc-print-deploy-client[papercut.torc.tech].dmg 
sudo installer -verboseR -package ~/Downloads/pc-print-deploy-client%5bpapercut.torc.tech%5d.dmg-target /
