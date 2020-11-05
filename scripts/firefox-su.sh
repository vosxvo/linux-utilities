#!/bin/bash

readonly ROOT_UID=0

APPLICATIONS_DIR="/usr/share/applications"

main() {
    clear
    if [[ -f "$APPLICATIONS_DIR/firefox.desktop" ]]; then
        local option
        read -p "Do you want backup your Firefox Destop Entry File ? (y|n)" option
        case $option in
            "y"|"Y") cp "$APPLICATIONS_DIR/firefox.desktop" "$APPLICATIONS_DIR/firefox.desktop.bak";;
            "n"|"N") ;;
            *) echo "Invalid Option!";;
        esac
        rm "$APPLICATIONS_DIR/firefox.desktop"
    fi
    cp "../assets/firefox.desktop" "$FIREFOX_DIR/"
}

if [[ $UID -eq $ROOT_UID ]]; then
    main
else
    echo "[Warning] This script must be run with root privilege!"
    sudo $0
fi