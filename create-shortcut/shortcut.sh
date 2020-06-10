#!/bin/bash

run() {
    # Checking for root access 
    if [ "$UID" -eq "$ROOT_UID" ]; then
        clear
    else
        # Error message
        prompt -e "\n [ Error! ] -> Run me as root! "

        # Execution of the script as root
        # if [[ -n ]]
    fi
}

run