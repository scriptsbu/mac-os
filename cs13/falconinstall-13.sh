#!/bin/bash
cd Downloads
sudo curl -O https://github.com/scriptsbu/mac-os/raw/main/cs13/GovLaggar_Release_standard-p_16403.pkg
sudo installer -verboseR -package ~/Downloads/GovLaggar_Release_standard-p_16403.pkg -target /
sudo /Applications/Falcon.app/Contents/Resources/falconctl license 6C145CE47FC14784904D6E1B2F9B5A4C-5F
sudo /Applications/Falcon.app/Contents/Resources/falconctl load
