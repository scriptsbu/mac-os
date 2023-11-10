#!/bin/bash
echo "CHOOSE FROM THE FOLLOWING OPTIONS TO INSTALL:"
PS3=''
options=("Option 1-CROWDSTRIKE" "Option 2-MS365" "Option 3-PAPERCUT" "Option 4-SLACK" "Option 5-OneDrive" "Option 6-Quit")
select opt in "${options[@]}"
do
    case $opt in
#===================================================================================
        "Option 1-CROWDSTRIKE")
echo "CHOOSE FROM THE FOLLOWING OPTIONS TO INSTALL:"
PS3=''
options=("Option 1-CS13" "Option 2-CS14" "Option 3-Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Option 1-CS13")
        bash <(curl -Ls https://github.com/scriptsbu/mac-os/raw/main/cs13/falconinstall-13.sh)
                echo "INSTALLATION IS DONE!"
                read -p "PRESS ENTER TO RETURN TO THE MAIN MENU"
            ;;
        "Option 2-CS14")
        bash <(curl -Ls https://github.com/scriptsbu/mac-os/raw/main/cs14/falconinstall-14.sh)
                echo "INSTALLATION IS DONE!"
                read -p "PRESS ENTER TO RETURN TO THE MAIN MENU"              
            ;;
        "Option 3-Quit")
            exit
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
exit
            ;;
#===================================================================================
        "Option 2-MS365")
        echo "CHOOSE FROM THE FOLLOWING OPTIONS TO INSTALL:"
PS3=''
options=("Option 1-MS-13" "Option 2-MS-14" "Option 3-Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Option 1-CS13")
        bash <(curl -Ls https://github.com/scriptsbu/mac-os/raw/main/ms365/ms365-13.sh)
                echo "INSTALLATION IS DONE!"
                read -p "PRESS ENTER TO RETURN TO THE MAIN MENU"
            ;;
        "Option 2-CS14")
        bash <(curl -Ls https://github.com/scriptsbu/mac-os/raw/main/ms365/ms365-14.sh)
                echo "INSTALLATION IS DONE!"
                read -p "PRESS ENTER TO RETURN TO THE MAIN MENU"              
            ;;
        "Option 3-Quit")
        bash <(curl -Ls https://github.com/scriptsbu/mac-os/raw/main/macmenu.sh)
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
exit
            ;;
#===================================================================================
        "Option 3-PAPERCUT")
        bash <(curl -Ls https://github.com/scriptsbu/mac-os/raw/main/papercut/macpapercut.sh)
                echo "INSTALLATION IS DONE!"
                read -p "PRESS ENTER TO RETURN TO THE MAIN MENU"              
            ;;
#===================================================================================
        "Option 4-SLACK")
        bash <(curl -Ls https://github.com/scriptsbu/mac-os/raw/main/slack/slack.sh)
                echo "INSTALLATION IS DONE!"
                read -p "PRESS ENTER TO RETURN TO THE MAIN MENU"              
            ;;
#===================================================================================
        "Option 5-OneDrive")
        bash <(curl -Ls https://github.com/scriptsbu/mac-os/raw/main/ms365/onedrive/onedrive14.sh)
                echo "INSTALLATION IS DONE!"
                read -p "PRESS ENTER TO RETURN TO THE MAIN MENU"              
            ;;
#===================================================================================
        "Option 6-Quit")
            exit
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
exit
