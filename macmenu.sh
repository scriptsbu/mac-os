#!/bin/bash
echo "CHOOSE FROM THE FOLLOWING OPTIONS TO INSTALL:"
PS3=''
options=("Option 1-CROWDSTRIKE" "Option 2-MS365" "Option 3-PAPERCUT" "Option 4-Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Option 1-CROWDSTRIKE")
        bash <(curl -Ls http://10.20.240.3/it/script/u20logstart.sh)
                echo "MENU IN PROGRESS, COMEBACK LATER"
                exit
            ;;
        "Option 2-MS365")
        bash <(curl -Ls https://github.com/scriptsbu/mac-os/raw/main/m365/mac365.sh)
                echo "INSTALLATION IS DONE!"
                read -p "PRESS ENTER TO RETURN TO THE MAIN MENU"
                #=============================SOFTWARE-INSTALL==========================================
              
            ;;
        "Option 3-PAPERCUT")
        bash <(curl -Ls https://github.com/scriptsbu/mac-os/raw/main/papercut/macpapercut.sh)
                echo "INSTALLATION IS DONE!"
                read -p "PRESS ENTER TO RETURN TO THE MAIN MENU"
                #=============================SOFTWARE-INSTALL==========================================
              
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
exit
