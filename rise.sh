#!/bin/bash

PROGRAMS="curl gcc make tmux neovim npm nodejs-legacy tldr clangd python3 pip"

function check_os {

    cmd.exe /c "" 2> /dev/null
    if [ $? == 0 ]
    then 
        OS="WINDOWS"
    else
        OS="LINUX"
    fi
}

function setup_workspace_for_wsl {

    echo [*] Setting up sym links ...
    ln -s ~/.dotfiles/wsl/.bashrc ~/.
    ln -s ~/.dotfiles/wsl/.bash_aliases ~/.
    ln -s ~/.dotfiles/wsl/.tmux.conf ~/.
    ln -s ~/.dotfiles/wsl/.gitconfig ~/.
    rm ~/.config/nvim/init.vim && ln -s ~/.dotfiles/wsl/init.vim ~/.config/nvim/
    ln -s ~/.dotfiles/wsl/syntax ~/.config/nvim/
    echo [!] All sym-links are setup!

}

function main {
    
    sudo apt-get update -y 2> /dev/null && sudo apt-get upgrade -y 2> /dev/null && echo "[!] System updated and upgraded!"

    sudo apt-get install $PROGRAMS
    if [ $? -ne 0 ]
    then
        echo "[!] Error occured!"
        exit 1
    else
        echo "[!] All programs are installed"
    fi

    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    sudo curl -sL install-node.now.sh/lts | bash
    sudo pip install jedi 


    check_os

    if [ "$OS" == "WINDOWS" ]
    then
        echo [!] WSL recognized!
        echo [*] Setting up workspace for wsl ...
        setup_workspace_for_wsl
    else
        echo "TODO: setup for linux"
    fi

    echo [!] Setup finished!

}


main $1
