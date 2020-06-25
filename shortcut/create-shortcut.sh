#!/bin/bash

readonly ROOT_UID=0
SHORTCUT_DIR="/usr/share/applications"

# Enter application informations
build_shortcut() {

    # Location of execution file
    local location
    read -p "Enter location of execution file : " location
    if [[ -f "$location" ]]; then
        echo "Done"
    else
        echo "This location is not valid!"
        exit
    fi

    # Location of icon
    local icon
    read -p "Enter icon location : " icon
    if [[ -f "$icon" ]]; then
        echo "Done"
    else
        echo "File not found!"
    fi

    # Version
    local ver
    read -p "Enter application version : " ver
    echo "Done"

    # Name
    local name
    read -p "Enter application name : " name
    echo "Done"

    # Description
    local comment
    read -p "Enter description : " comment
    echo "Done"

    # Category
    local generic
    read -p "Enter category : " generic
    echo "Done"

    # Keywords
    local keywords
    read -p "Enter keywords : " keywords
    echo "Done"

    # Build file
    echo "Build..."
    echo "[Desktop Entry]" > .desktop
    if [[ -n "$var" ]]; then
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
    echo "Done"
}

# Copy shortcut to SHORTCUT_DIR
create_shortcut() {
    local name
    read -p "Enter shortcut name : " name
    if [[ -f "$SHORTCUT_DIR/$name.desktop" ]]; then
        echo "$name.desktop is already exist!"
    else
        cp .desktop "$SHORTCUT_DIR/$name.desktop"
    fi
}

if [[ $UID -eq $ROOT_UID ]]; then
    build_shortcut
    create_shortcut
else
    echo "[ Error ] - Mising permision!"
    sudo $0
fi