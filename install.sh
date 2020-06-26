#!/bin/bash

main_menu() {
    echo "LINUX UTILITIES"
    echo "---------------"
    echo "1 - Shortcut Utilities"
    echo ""
}

shortcut_menu() {
    clear
    echo "SHORTCUT ULTILITIES"
    echo "------------------"
    echo "1 - Create"
    echo "2 - Delete"
    echo "3 - Edit"
    echo ""
}

shorcut_option() {
    local option
    read -p "Enter your option (1 ~ 3) : " option
    echo ""
    case $option in
        1)
            scripts/shortcut.sh 1;;
        2)
            scripts/shortcut.sh 2;;
    esac
}

while [[ true ]]; do
    clear
    main_menu
    read -p "Enter your option (1 ~ 5) : " option
    echo ""
    case $option in
        1)
            shortcut_menu
            shorcut_option;;
    esac
done