#!/bin/bash
cd ~/Downloads
sudo curl -O http://10.20.240.3/it/iso/macos/cisco-client/anyconnect-macos-4.10.01075-core-vpn-webdeploy-k9.dmg
sudo installer -verboseR -package ~/Downloads/anyconnect-macos-4.10.01075-core-vpn-webdeploy-k9.dmg -target /
open Cisco\ AnyConnect\ Secure\ Mobility\ Client.app
