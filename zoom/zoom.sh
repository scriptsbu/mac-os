#!/bin/bash
cd ~/Downloads
sudo curl -O http://10.20.240.3/it/iso/macos/Zoom/Zoom.pkg
sudo installer -verboseR -package ~/Downloads/Zoom.pkg -target /
