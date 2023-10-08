#!/bin/bash

PROGRAMS="htop curl wget pkg-config gcc g++ cmake make tmux unzip gettext libtool-bin npm tldr clangd python3 python3-pip tree dos2unix ripgrep"

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

function setup_neovim {

    if [ ! -d ~/.config/nvim ]
    then
        cd ~ 
        echo [!] CLONING LATEST VERSION OF NEOVIM ... && 
        git clone https://github.com/neovim/neovim > /dev/null && 
        echo [!] INSTALLING THE LATEST BUILD OF NEOVIM ... && 
        cd neovim/ && sudo make install
        echo [!] LATEST BUILD OF NEOVIM IS INSTALLED !! || echo [!] FAILED TO BUILD NEOVIM!!
        cd ../
    fi

    # setup config files
    if [ ! -d ~/.config ]
    then
        mkdir ~/.config
    else
        rm -rf ~/.config/nvim
    fi

    ln -s ~/.dotfiles/common/nvim ~/.config
}

function setup_tmux {

    if [ ! -d ~/.tmux/plugins/tpm ]
    then
        cd ~ 
        echo [!] CLONING LATEST VERSION OF TMUX ... &&
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm &&
        echo [!] INSTALLING THE LATEST BUILD OF TMUX ... &&
        sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' &&
        sudo pip install jedi  &&
        echo [!] LATEST BUILD OF TMUX IS INSTALLED !! || echo [!] FAILED TO BUILD TMUX !!
    fi

    ln -s ~/.dotfiles/common/.tmux.conf ~/.
}

function setup_symlinks {

    if [ -d ~/old_setup ]
    then
        rm -rf ~/old_setup
    fi

    mkdir ~/old_setup
    mv ~/.bashrc ~/.bash_aliases ~/.tmux.conf ~/.gitconfig ~/old_setup

    echo [*] Setting up sym links ...
    if [ "$OS" == "WINDOWS" ]
    then
        echo [!] WSL recognized!
        echo [*] Setting up workspace for wsl ...

        ln -s ~/.dotfiles/wsl/.bashrc ~/.
        ln -s ~/.dotfiles/wsl/.bash_aliases ~/.
        ln -s ~/.dotfiles/wsl/.gitconfig ~/.
    else
        echo [!] LINUX recognized!
        echo [*] Setting up workspace for linux ...

        ln -s ~/.dotfiles/linux/.bashrc ~/.
        ln -s ~/.dotfiles/linux/.bash_aliases ~/.
        ln -s ~/.dotfiles/linux/.gitconfig ~/.
        ln -s ~/.dotfiles/linux/audio-fix.sh ~/audio-fix.sh
        ln -s ~/.dotfiles/linux/run-on-startup.sh ~/run-on-startup.sh
    fi
    echo [!] All sym-links are setup!
}

function main {

    if [ ! -d ~/.dotfiles ]
    then
        echo [!] Make sure to have .dotfiles in the home directory before running rise.sh!
        exit 1
    fi

    check_os
    
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

    setup_symlinks
    setup_neovim
    setup_tmux

    echo [!] Setup finished!

}


main $1

