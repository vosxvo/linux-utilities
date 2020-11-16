#!/bin/bash

readonly ROOT_UID=0

apache2() {
    sudo apt install apache2 -y
    echo "Successful!"
}

nginx() {
    sudo apt install nginx
    echo "Successful!"
}

mysql() {
    sudo apt install mysql-server -y
    mysql_secure_installation
    echo "Successful!"
}

php() {
    sudo apt install php libapache2-mod-php php-mysql -y
    echo "Successful!"
}

lamp() {
    clear
    echo "Installing Apache 2..."
    apache2
    echo "Installing MySQL..."
    mysql
    echo "Installing PHP..."
    php
    read -p "Press any key to continue!"
}

lemp() {
    echo ""
}

install() {
    clear
    echo "==================================================================="
    echo "||          Ubuntu 20.04 Focal Utilities Menu > Install          ||"
    echo "==================================================================="
    echo "1. LAMP stack"
    echo "2. LEMP stack"
    echo "Press another keys to back!"
    local option
    read -p "Enter option : " option
    case $option in
        1)  lamp;;
        2)  lemp;;
    esac
}

main() {
    clear
    echo "==================================================================="
    echo "||               Ubuntu 20.04 Focal Utilities Menu               ||"
    echo "==================================================================="
    echo "1. Install"
    echo "Press another keys to exit!"
    local option
    read -p "Enter option : " option
    case $option in
        1)  install;;
        *)  exit;;
    esac
}

if [[ $UID -eq $ROOT_UID ]]; then
    while true; do
        main
    done
else
    echo "[Warning] This script must be run with root privilege!"
    sudo $0
fi