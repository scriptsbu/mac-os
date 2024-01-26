#!/bin/bash
cd ~/Downloads
sudo curl -O http://10.20.240.3/it/iso/macos/Papercut/pc-print-deploy-client-14%5bpapercut.torc.tech%5d.dmg
sudo installer -verboseR -package ~/Downloads/pc-print-deploy-client-14%5bpapercut.torc.tech%5d -target /
