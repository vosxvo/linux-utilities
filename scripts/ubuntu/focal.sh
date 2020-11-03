#!/bin/bash

readonly ROOT_UID=0

apache2() {
    sudo apt install apache2 -y
    echo "Successful!"
}

mysql() {
    sudo apt install mysql-server -y
    sudo mysql_secure_installation
    echo "Successful!"
}

php() {
    sudo apt install php libapache2-mod-php php-mysql -y
    echo "Successful!"
}

lamp() {
    echo "Installing Apache 2..."
    apache2
    echo "Installing MySQL..."
    mysql
    echo "Installing PHP..."
    php
}

main() {

}

if [[ $UID -eq $ROOT_UID ]]; then
    main
else
    echo "[Warning] This script must be run as root privilege!"
    sudo $0
fi