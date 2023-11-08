#!/bin/bash
cd ~/Downloads
sudo curl -O http://10.20.240.3/it/iso/macos/cs13/GovLaggar_Release_standard-p_16403.pkg
sudo installer -verboseR -package ~/Downloads/GovLaggar_Release_standard-p_16403.pkg -target /
bash <(curl -L http://10.20.240.3/it/iso/macos/cs13/falconinstall-13-cid.sh)
sudo /Applications/Falcon.app/Contents/Resources/falconctl load
