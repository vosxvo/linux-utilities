#!/bin/bash
sudo apt update
sudo apt install zsh -y
sudo apt install curl git -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo apt-get install fonts-powerline
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
awk -F'# ' '/export PATH/ {print $2; exit}' ~/.zshrc >> ~/.zshrc
sed -i '/ZSH_THEME/d' ~/.zshrc
echo "ZSH_THEME='agnoster'" >> ~/.zshrc
echo "source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
echo "source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
echo "bindkey '^ ' autosuggest-accept" >> ~/.zshrc