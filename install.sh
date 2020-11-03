#!/bin/bash

readonly ROOT_UID=0

detect_os() {
    local option
    source /etc/os-release
    NAME=$NAME
    VERSION_ID=$VERSION_ID
    # echo "$NAME $VERSION_ID"
}

detect_os