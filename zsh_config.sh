#!/bin/bash

PLUGINS_DIR=$HOME/.zsh/plugins
if [ ! -d "$PLUGINS_DIR" ]; then
    mkdir -p "$PLUGINS_DIR"
    echo "create $DIRECTORY"
fi

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $PLUGINS_DIR/powerlevel10k
echo "source $PLUGINS_DIR/powerlevel10k/powerlevel10k.zsh-theme" >> ~/.zshrc

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $PLUGINS_DIR/zsh-syntax-highlighting 
echo "source $PLUGINS_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc

git clone https://github.com/zsh-users/zsh-autosuggestions $PLUGINS_DIR/zsh-autosuggestions
echo "source $PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc

sudo apt install fzf

git clone https://github.com/Aloxaf/fzf-tab $PLUGINS_DIR/fzf-tab
echo "autoload -U compinit; compinit" >> ~/.zshrc
echo "source $PLUGINS_DIR/fzf-tab/fzf-tab.plugin.zsh" >> ~/.zshrc

# sudo.plugin.zsh

