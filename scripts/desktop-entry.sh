#!/bin/bash

readonly ROOT_UID=0
MENU_DIR="/usr/share/applications"
DESKTOP_DIR="/home/$USER/Desktop"
URL_REGEX='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'

# File information
file_meta() {
    local location
    # local icon
    local name
    local keywords

    echo "Hint : Use TAB to auto-complete path"
    while [[ ! -f "$location" ]]; do
        read -ep "Enter location : " location 
        if [[ ! -f "$location" ]]; then
            local option
            read -p "This location is invalid. Re-enter (y|n) ? " option
            if [[ "$option" == "n" ]] || [[ "$option" == "N" ]]; then
                echo "Script aborted!!!"
                exit
            elif [[ "$option" != "y" ]] || [[ "$option" != "Y" ]]; then
                echo "Invalid option"
            fi
        fi
    done

    # while [[ ! -f "$icon" ]]; do
    #     echo "Hint : Use TAB to auto complete path"
    #     read -ep "Enter location of icon : " icon
    #     if [[ ! -f "$icon" ]]; then
    #         local option
    #         read -p "This location is invalid. Re-enter (y|n) ? " option
    #         if [[ "$option" == "n" ]] || [[ "$option" == "N" ]]; then
    #             echo "Script aborted!!!"
    #             exit
    #         elif [[ "$option" != "y" ]] || [[ "$option" != "Y" ]]; then
    #             echo "Invalid option"
    #         fi
    #     fi
    # done

    read -p "Enter link name : " name
    # echo "Tips : Set keywords to search quickly"
    # read -p "Enter keywords : " keywords

    # Create link file
    echo "$DESKTOP_DIR/$name"
    read -p ""
    # ln -s "$location" "$DESKTOP_DIR/$name"

    # Build file
    # echo "Build..."
    # echo "[Desktop Entry]" > .desktop
    # if [[ -n "$name" ]]; then
    #     echo "Name=$name" >> .desktop
    # fi
    # if [[ -n "$keywords" ]]; then
    #     echo "Keywords=$keywords" >> .desktop
    # fi
    # echo "Type=Link" >> .desktop
    # echo "URL=file://$(pwd)$location" >> .desktop
    # echo "Icon=$icon" >> .desktop
}

# URL information
url_meta() {
    local url
    local icon
    local name
    local comment
    local keywords

    while [[ ! $url =~ $URL_REGEX ]]; do
        read -p "Enter URL : " url
        if [[ ! $url =~ $URL_REGEX ]]; then
            local option
            read -p "Invalid URL. Re-enter (y|n) ? " option
            if [[ "$option" == "n" ]] || [[ "$option" == "N" ]]; then
                echo "Script abort!!!"
                exit
            elif [[ "$option" != "y" ]] || [[ "$option" != "Y" ]]; then
                echo "Invalid option"
            fi
        fi
    done

    while [[ ! -f "$icon" ]]; do
        echo "Hint : Use TAB to auto complete path"
        read -ep "Enter location of icon : " icon
        if [[ ! -f "$icon" ]]; then
            local option
            read -p "This location is not valid. Re-enter (y|n) ? " option
            if [[ "$option" == "n" ]] || [[ "$option" == "N" ]]; then
                echo "Script abort!!!"
                exit
            elif [[ "$option" != "y" ]] || [[ "$option" != "Y" ]]; then
                echo "Invalid option"
            fi
        fi
    done

    read -p "Enter URL name : " name
    read -p "Enter description : " comment
    echo "Tips : Set keywords to search quickly"
    read -p "Enter keywords : " keywords

    # Build file
    echo "Build..."
    echo "[Desktop Entry]" > .desktop
    if [[ -n "$name" ]]; then
        echo "Name=$name" >> .desktop
    fi
    if [[ -n "$comment" ]]; then
        echo "Comment=$comment" >> .desktop
    fi
    if [[ -n "$keywords" ]]; then
        echo "Keywords=$keywords" >> .desktop
    fi
    echo "Type=Link" >> .desktop
    echo "Exec=$url" >> .desktop
    echo "Icon=$icon" >> .desktop
}

# Application information
application_meta() {
    local location
    local icon
    local ver
    local name
    local comment
    local generic
    local keywords

    echo "Hint : Use TAB to auto-complete path"
    while [[ ! -f "$location" ]]; do
        read -ep "Enter location of application : " location
        if [[ ! -f "$location" ]]; then
            local option
            read -p "This location is not valid. Re-enter (y|n) ? " option
            if [[ "$option" == "n" ]] || [[ "$option" == "N" ]]; then
                echo "Script abort!!!"
                exit
            elif [[ "$option" != "y" ]] || [[ "$option" != "Y" ]]; then
                echo "Invalid option"
            fi
        fi
    done

    while [[ ! -f "$icon" ]]; do
        read -ep "Enter location of icon : " icon
        if [[ ! -f "$icon" ]]; then
            local option
            read -p "This location is not valid. Re-enter (y|n) ? " option
            if [[ "$option" == "n" ]] || [[ "$option" == "N" ]]; then
                echo "Script abort!!!"
                exit
            elif [[ "$option" != "y" ]] || [[ "$option" != "Y" ]]; then
                echo "Invalid option"
            fi
        fi
    done

    read -p "Enter application version : " ver
    read -p "Enter application name : " name
    read -p "Enter description : " comment
    read -p "Enter category : " generic
    echo "Tips : Set keywords to search quickly"
    read -p "Enter keywords : " keywords

    # Build file
    echo "Build..."
    echo "[Desktop Entry]" > .desktop
    if [[ -n "$ver" ]]; then
        echo "Version=$ver" >> .desktop
    fi
    if [[ -n "$name" ]]; then
        echo "Name=$name" >> .desktop
    fi
    if [[ -n "$comment" ]]; then
        echo "Comment=$comment" >> .desktop
    fi
    if [[ -n "$generic" ]]; then
        echo "GenericName=$generic" >> .desktop
    fi
    if [[ -n "$keywords" ]]; then
        echo "Keywords=$keywords" >> .desktop
    fi
    echo "Type=Application" >> .desktop
    echo "Exec=$location" >> .desktop
    echo "Icon=$icon" >> .desktop
    # copy_de
}

# Copy desktop entry to menu folder
copy_de() {
    if [[ -f ".desktop" ]] && [[ $UID -eq $ROOT_UID ]]; then
        local name
        while true; do
            read -p "Enter desktop entry file name : " name
            if [[ -f "$MENU_DIR/$name.desktop" ]]; then
                local option
                read -p "File is already exist! Replace (y|n|rename) ?" option
                case $option in
                    "y"|"Y")
                        sudo rm "$MENU_DIR/$name.desktop"
                        sudo cp ".desktop" "$MENU_DIR/$name.desktop";;
                    "n"|"N")
                        echo "Script aborted!"
                        exit;;
                    "rename")
                        name="";;
                    *)
                        echo "Invalid option";;
                esac
            else
                sudo cp ".desktop" "$MENU_DIR/$name.desktop"
            fi
        done
    fi
}

# Create desktop entry
create_de() {
    clear
    echo "==================================================================="
    echo "                        CREATE DESKTOP ENTRY                       "
    echo "==================================================================="
    echo ""
    echo "Choose type of desktop entry :"
    echo "1 - File"
    echo "2 - URL"
    echo "3 - Application"
    echo ""
    local option
    read -p "Enter option : " option
    case $option in
        1) file_meta;;
        2) url_meta;;
        3) application_meta;;
        *) echo "Invalid option!";;
    esac
    # copy_de
}

# Delete desktop entry
delete_de() {
    clear
    echo "==================================================================="
    echo "                       DELETE DESKTOP ENTRY                        "
    echo "==================================================================="
    echo ""
    local name
    while [[ true ]]; do
        read -p "Enter desktop entry name : " name
        if [[ ! -f "$MENU_DIR/$name.desktop" ]]; then
            local option
            read -p "Location is invalid. Re-enter (y|n) ? " option
            if [[ $option == "n" ]] || [[ $option == "N" ]]; then
                echo "Script aborted!"
                exit
            elif [[ $option != "y" ]] && [[ $option != "Y" ]]; then
                echo "Invalid option!"
            fi
        else
            break
        fi
    done
    local option
    read -p "\"$name.desktop\" will be deteted. Are you sure (y|n) ? " option
    if [[ $option == "n" ]] || [[ $option == "N" ]]; then
        echo "Script aborted!"
        exit
    elif [[ $option == "y" ]] || [[ $option == "Y" ]]; then
        sudo rm "$MENU_DIR/$name.desktop"
        echo "Successful!"
    else
        echo "Invalid option"
    fi
}

# Edit desktop entry
edit_de() {
    clear
    echo "==================================================================="
    echo "                         EDIT DESKTOP ENTRY                        "
    echo "==================================================================="
    echo ""
    local name
    while [[ true ]]; do
        read -p "Enter desktop entry name : " name
        if [[ ! -f "$MENU_DIR/$name.desktop" ]]; then
            local option
            read -p "Location is invalid. Re-enter (y|n) ? " option
            if [[ $option == "n" ]] || [[ $option == "N" ]]; then
                echo "Script aborted!"
                exit
            elif [[ $option != "y" ]] && [[ $option != "Y" ]]; then
                echo "Invalid option!"
            fi
        else
            break
        fi
    done
    # copy_de
}

main_menu() {
    clear
    echo "==================================================================="
    echo "||                      DESKTOP ENTRY TOOLS                      ||"
    echo "==================================================================="
    echo ""
    echo "1 - Create"
    echo "2 - Delete"
    echo "3 - Edit"
    echo "Press another keys to exit!"
    echo ""
    local option
    read -p "Enter option : " option
    case $option in
        1) create_de;;
        2) delete_de;;
        3) edit_de;;
        *) exit;;
    esac

}

if [[ $UID -eq $ROOT_UID ]]; then
    while true; do
        main_menu
    done
else
    echo "[Warning] This script must be run as root!"
    sudo $0
fi