#!/bin/bash
cd ~/Downloads
sudo curl -O http://10.20.240.3/it/iso/macos/OneDrive/OneDrive.pkg
sudo installer -verboseR -package ~/Downloads/OneDrive.pkg -target /
open /Applications/OneDrive.app
