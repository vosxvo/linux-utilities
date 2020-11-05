#!/bin/bash

readonly ROOT_UID=0

NAME=
VERSION_ID=

run_ubuntu() {
    case $VERSION_ID in
        "20.04") "$(pwd)/scripts/ubuntu/focal.sh";;
    esac
}

detect_os() {
    local option
    source /etc/os-release
    NAME=$NAME
    VERSION_ID=$VERSION_ID
    # read -p "Detected $NAME $VERSION_ID . Do you want change it ? (y|n) " option
    # case $option in
    #     "y"|"Y");;
    # esac
    # echo "$NAME $VERSION_ID"
    case $NAME in
        "Ubuntu") run_ubuntu;;
    esac
}

detect_os