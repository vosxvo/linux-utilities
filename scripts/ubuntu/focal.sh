#!/bin/bash

readonly ROOT_UID=0

main() {
    sudo apt update -y
    sudo apt upgrade -y
    
}

if [[ $UID -eq $ROOT_UID ]]; then
    while true; do
        main
    done
else
    echo "[Warning] This script must be run as root privilege!"
    sudo $0
fi