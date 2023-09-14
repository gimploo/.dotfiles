#!/bin/bash

PROGRAMS="curl pkg-config gcc g++ cmake make tmux unzip gettext libtool-bin npm tldr clangd python3 python3-pip tree dos2unix"

function check_os {

    cmd.exe /c "" 2> /dev/null
    if [ $? == 0 ]
    then 
        OS="WINDOWS"
        echo [!] WINDOWS RECOGNIZED
    else
        OS="LINUX"
        echo [!] LINUX RECOGNIZED
    fi
}

function setup_workspace_for_wsl {

    echo [*] Setting up sym links ...

    if [ -d ~/old_setup ]
    then
        rm -rf ~/old_setup
    fi

    mkdir ~/old_setup
    mv ~/.bashrc ~/.bash_aliases ~/.tmux.conf ~/.gitconfig ~/old_setup

   
    if [ ! -d ~/.config ]
    then
        mkdir ~/.config
        mkdir ~/.config/nvim
    else
        rm -rf ~/.config/nvim
        mkdir ~/.config/nvim
    fi

    ln -s ~/.dotfiles/wsl/.bashrc ~/.
    ln -s ~/.dotfiles/wsl/.bash_aliases ~/.
    ln -s ~/.dotfiles/wsl/.tmux.conf ~/.
    ln -s ~/.dotfiles/wsl/.gitconfig ~/.
    ln -s ~/.dotfiles/wsl/init.vim ~/.config/nvim/
    ln -s ~/.dotfiles/wsl/syntax ~/.config/nvim/
    echo [!] All sym-links are setup!

}

function setup_workspace_for_linux {

    echo [*] Setting up sym links ...

    mkdir ~/old_setup
    mv ~/.bashrc ~/.bash_aliases ~/.tmux.conf ~/.gitconfig ~/old_setup

    ln -s ~/.dotfiles/linux/.bashrc ~/.
    ln -s ~/.dotfiles/linux/.bash_aliases ~/.
    ln -s ~/.dotfiles/linux/.tmux.conf ~/.
    ln -s ~/.dotfiles/linux/.gitconfig ~/.
    rm ~/.config/nvim/init.vim && ln -s ~/.dotfiles/linux/init.vim ~/.config/nvim/
    ln -s ~/.dotfiles/linux/syntax ~/.config/nvim/
    ln -s ~/.dotfiles/linux/audio-fix.sh ~/audio-fix.sh
    ln -s ~/.dotfiles/linux/run-on-startup.sh ~/run-on-startup.sh

    echo [!] All sym-links are setup!
}

function main {

    if [ ! -d ~/.dotfiles ]
    then
        echo [!] Make sure to have .dotfiles in the home directory before running rise.sh!
        exit 1
    fi
    
    echo [!] SYSTEM UPDATING ...
    sudo apt-get update -y > /dev/null && 
    echo [!] SYSTEM UPGRADING ... 
    sudo apt-get upgrade -y > /dev/null && 
    echo "[!] System updated and upgraded!"

    echo [!] INSTALLING DEFAULT PROGRAMS ...
    sudo apt-get install $PROGRAMS
    if [ $? -ne 0 ]
    then
        echo "[!] Error occured!"
        exit 1
    else
        echo "[!] All programs are installed"
    fi

    # Latest neovim version
    if [ ! -d ~/neovim ] 
    then
    cd ~ && git clone https://github.com/neovim/neovim
    cd neovim && sudo make install || echo "[!] FALIED TO SETUP NEOVIM"
    fi
    # setup lua folder for neovim
    ln -s ~/.dotfiles/common/lua ~/.config/nvim/

    if [ ! -d ~/.tmux/plugins/tpm ]
    then
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
        sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        sudo pip install jedi 
    fi

    check_os

    if [ "$OS" == "WINDOWS" ]
    then
        echo [!] WSL recognized!
        echo [*] Setting up workspace for wsl ...
        setup_workspace_for_wsl
    else
        setup_workspace_for_linux
    fi

    echo [!] Setup finished!

}


main $1

