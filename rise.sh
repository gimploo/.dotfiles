#!/bin/bash

PROGRAMS="curl gcc make tmux neovim npm tldr clangd python3 pip"

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

    mkdir ~/old_setup
    mv ~/.bashrc ~/.bash_aliases ~/.tmux.conf ~/.gitconfig ~/old_setup

    ln -s ~/.dotfiles/wsl/.bashrc ~/.
    ln -s ~/.dotfiles/wsl/.bash_aliases ~/.
    ln -s ~/.dotfiles/wsl/.tmux.conf ~/.
    ln -s ~/.dotfiles/wsl/.gitconfig ~/.
    rm ~/.config/nvim/init.vim && ln -s ~/.dotfiles/wsl/init.vim ~/.config/nvim/
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
    
    sudo su
    apt-get update -y 3> /dev/null && apt-get upgrade -y 3> /dev/null && echo "[!] System updated and upgraded!"

    apt-get install $PROGRAMS 3> /dev/null
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
    sudo pip install jedi 

    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    source ~/.bashrc
    nvm install node

    cd ~/.config/coc/extensions/node_modules/coc-ccls
    ln -s node_modules/ws/lib lib
    cd -

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

