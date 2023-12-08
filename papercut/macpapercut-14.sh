#!/bin/bash
cd ~/Downloads
sudo curl -O http://10.20.240.3/it/iso/macos/Papercut/macpapercut14.dmg 
sudo installer -verboseR -package ~/Downloads/macpapercut14.dmg-target /
