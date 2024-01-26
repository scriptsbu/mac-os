#!/bin/bash
cd ~/Downloads
sudo curl -O http://10.20.240.3/it/iso/macos/Papercut/pc-print-deploy-client-14[papercut.torc.tech].dmg
sudo installer -verboseR -package ~/Downloads/macpapercut14.dmg -target /
