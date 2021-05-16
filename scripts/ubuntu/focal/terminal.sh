#!/bin/bash

function has_command() {
    command -v $1 > /dev/null
}


function setup() {
    if [[ $(id -u) -ne 0 ]]; then
        echo "[Warning] This script must be run with root privilege!"
        sudo $0
    fi

    if has_command apt-get; then
        sudo apt-get update
        sudo apt-get install zsh -y
        sudo apt-get install fonts-powerline
    fi

    if ! has_command git; then
        sudo apt-get install git -y
    fi
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

    if ! has_command curl; then
        sudo apt-get install curl -y
    fi
    yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

function config() {
    if has_command awk; then
        awk -F'# ' '/export PATH/ {print $2; exit}' ~/.zshrc >> ~/.zshrc
    elif has_command apt-get; then
        sudo apt install gwak -y;
    fi

    if has_command sed; then
        sed -i '/ZSH_THEME/d' ~/.zshrc
    elif has_command apt-get; then
        sudo apt install sed -y;
    fi

    echo "ZSH_THEME='agnoster'" >> ~/.zshrc
    echo "source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
    echo "source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
    echo "bindkey '^ ' autosuggest-accept" >> ~/.zshrc
}

case "$1" in
    "setup") setup ;;
    "config") config ;;
    *) echo "Wrong option!";;
esac