#!/bin/bash
echo "PLEASE PAY ATTENTION TO ALL PROMPTS."
read -p "PRESS ENTER TO CONTINUE"
cd ~/Downloads
sudo curl -O http://10.20.240.3/it/iso/macos/cs14/GovLaggar_Release_standard-p_17506.pkg
sudo installer -verboseR -package ~/Downloads/GovLaggar_Release_standard-p_17506.pkg -target /
bash <(curl -L http://10.20.240.3/it/iso/macos/cs13/falconinstall-13-cid.sh)
sudo /Applications/Falcon.app/Contents/Resources/falconctl load
bash <(curl -L http://10.20.240.3/it/iso/macos/cs14/falconinstall-14-cid.sh)
