#!/bin/bash
echo "CHOOSE FROM THE FOLLOWING OPTIONS TO INSTALL:"
PS3=''
options=("Option 1-CROWDSTRIKE" "Option 2-MS365" "Option 3-PAPERCUT" "Option 4-Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Option 1-CROWDSTRIKE")
echo "CHOOSE FROM THE FOLLOWING OPTIONS TO INSTALL:"
PS3=''
options=("Option 1-CS13" "Option 2-CS14" "Option 3-Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Option 1-CS13")
        bash <(curl -Ls https://github.com/scriptsbu/mac-os/raw/main/cs13/falconinstall-13.sh)
                echo "MENU IN PROGRESS, COMEBACK LATER"
                exit
            ;;
        "Option 2-CS14")
        bash <(curl -Ls https://github.com/scriptsbu/mac-os/raw/main/cs14/falconinstall-14.sh)
                echo "INSTALLATION IS DONE!"
                read -p "PRESS ENTER TO RETURN TO THE MAIN MENU"              
            ;;
        "Quit")
            exit
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
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
            exit
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
exit
