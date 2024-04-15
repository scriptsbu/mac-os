#!/bin/bash
echo "CHOOSE FROM THE FOLLOWING OPTIONS TO INSTALL:"
PS3=''
options=("CROWDSTRIKE" "MS365" "PAPERCUT" "SLACK" "OneDrive" "ZOOM" "CISCO-CLIENT" "SERIAL-NUMBER" "macOS-Abroad" "GLOBALPROTECT-VPN" "VS-CODE" "Global-Protect-Uninstall" "Quit")
select opt in "${options[@]}"
do
    case $opt in
#=========================CROWDSTRIKE==========================================================
        "CROWDSTRIKE")
echo "CHOOSE FROM THE FOLLOWING OPTIONS TO INSTALL:"
PS3=''
options=("CS13" "CS14" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "CS13")
        bash <(curl -Ls https://github.com/scriptsbu/mac-os/raw/main/cs13/falconinstall-13.sh)
                echo "INSTALLATION IS DONE!"
                read -p "PRESS ENTER TO RETURN TO THE MAIN MENU"
            ;;
        "CS14")
        bash <(curl -Ls https://github.com/scriptsbu/mac-os/raw/main/cs14/falconinstall-14.sh)
                echo "INSTALLATION IS DONE!"
                read -p "PRESS ENTER TO RETURN TO THE MAIN MENU"              
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
exit
            ;;
#===================MS365================================================================
        "MS365")
        echo "CHOOSE FROM THE FOLLOWING OPTIONS TO INSTALL:"
PS3=''
options=("MS-13" "MS-14" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "MS-13")
        bash <(curl -Ls https://github.com/scriptsbu/mac-os/raw/main/ms365/ms365-13.sh)
                echo "INSTALLATION IS DONE!"
                read -p "PRESS ENTER TO RETURN TO THE MAIN MENU"
            ;;
        "MS-14")
        bash <(curl -Ls https://github.com/scriptsbu/mac-os/raw/main/ms365/ms365-14.sh)
                echo "INSTALLATION IS DONE!"
                read -p "PRESS ENTER TO RETURN TO THE MAIN MENU"              
            ;;
        "Quit")
        break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
exit
            ;;
#======================PAPERCUT=============================================================
        "PAPERCUT")
        echo "CHOOSE FROM THE FOLLOWING OPTIONS TO INSTALL:"
PS3=''
options=("Papercut-13" "Papercut-14" "Papercut-15" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Papercut-13")
        bash <(curl -Ls https://github.com/scriptsbu/mac-os/raw/main/papercut/macpapercut.sh)
                echo "FINISH THE INSTALLATION!"
                read -p "PRESS ENTER TO RETURN TO THE MAIN MENU"    
            ;;
        "Papercut-14")
        bash <(curl -Ls https://github.com/scriptsbu/mac-os/raw/main/papercut/macpapercut14.sh)
                echo "FINISH THE INSTALLATION!"
                read -p "PRESS ENTER TO RETURN TO THE MAIN MENU"              
            ;;
        "Papercut-15")
        bash <(curl -Ls https://github.com/scriptsbu/mac-os/raw/main/papercut/macpapercut15.sh)
                echo "FINISH THE INSTALLATION!"
                read -p "PRESS ENTER TO RETURN TO THE MAIN MENU"              
            ;;     
        "Quit")
        break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
exit
            ;;
#============================SLACK=======================================================
        "SLACK")
        bash <(curl -Ls https://github.com/scriptsbu/mac-os/raw/main/slack/slack.sh)
                echo "INSTALLATION IS DONE!"
                read -p "PRESS ENTER TO RETURN TO THE MAIN MENU"              
            ;;
#================================ONE_DRIVE===================================================
        "OneDrive")
        bash <(curl -Ls https://github.com/scriptsbu/mac-os/raw/main/onedrive/onedrive14.sh)
                echo "INSTALLATION IS DONE!"
                read -p "PRESS ENTER TO RETURN TO THE MAIN MENU"              
            ;;
#===============================ZOOM====================================================
        "ZOOM")
        bash <(curl -Ls https://github.com/scriptsbu/mac-os/raw/main/zoom/zoom.sh)
                echo "INSTALLATION IS DONE!"
                read -p "PRESS ENTER TO RETURN TO THE MAIN MENU"              
            ;;
#=================================CISCO==================================================
        "CISCO-CLIENT")
        bash <(curl -Ls https://github.com/scriptsbu/mac-os/raw/main/cisco/cisco-client.sh)
                echo "INSTALLATION IS DONE!"
                read -p "PRESS ENTER TO RETURN TO THE MAIN MENU"              
            ;;
#===============================SERIAL====================================================
        "SERIAL-NUMBER")
        bash <(curl -Ls https://github.com/scriptsbu/mac-os/raw/main/serial-number.sh)
                read -p "PRESS ENTER TO RETURN TO THE MAIN MENU"    
            ;;
#=========================ABROAD==========================================================
     "macOS-Abroad")
        bash <(curl -Ls https://github.com/scriptsbu/it-tools/raw/main/mac-abroad.sh)
                read -p "PRESS ENTER TO RETURN TO THE MAIN MENU"    
            ;;
#=========================GLOBAL-PROTECT-VPN==========================================================
     "GLOBALPROTECT-VPN")
        bash <(curl -Ls http://10.20.240.3/it/script/mac-global-vpn.sh)
                read -p "PRESS ENTER TO RETURN TO THE MAIN MENU"    
            ;;
#=========================VSCODE==========================================================
     "VS-CODE")
        bash <(curl -Ls https://github.com/scriptsbu/mac-os/raw/main/vscode/vscode.sh)
                read -p "PRESS ENTER TO RETURN TO THE MAIN MENU"    
            ;;
#=========================VSCODE==========================================================
   "Global-Protect-Uninstall")
sudo bash /Applications/GlobalProtect.app/Contents/Resources/uninstall_gp.sh
                read -p "
            ;;
#===================================================================================
        "Quit")
            exit
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
exit
