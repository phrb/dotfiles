#!/bin/env bash

set -e

function repo() {
    set -x
    echo "Updating dotfiles from local machine"

    echo "Copying files from $HOME"

    cp ~/.xinitrc .
    cp ~/.Xresources .
    cp ~/.vimrc .
    cp ~/.xbindkeysrc .
    cp ~/.zshrc .

    echo "Copying files from $HOME/.config/"

    cp -r ~/.config/qpdfview/ .config/
    cp -r ~/.config/gtk-3.0 .config/
    cp -r ~/.config/gtk-2.0 .config/
    cp -r ~/.config/qt5ct .config/
    cp -r ~/.config/awesome .config/
    cp -r ~/.config/htop .config/

    echo "Copy some Emacs files from $HOME/.emacs.d/"

    cp ~/.emacs.d/init.org .emacs.d/
    cp ~/.emacs.d/init.el .emacs.d/
    cp ~/.emacs.d/emacs-custom.el .emacs.d/

    echo "Copy pacman.conf from /etc/"

    cp /etc/pacman.conf ./etc/
}

function local() {
    set -x
    read -p "Overwrites configuration on $HOME and $HOME/.config. Continue (Y/[n])?" CHOICE

    case "$CHOICE" in
        Y)
            echo "Proceeding to installation"
            ;;
        *)
            echo "Aborting."
            exit 0
            ;;
    esac

    echo "Installing dotfiles"

    echo "Copying files to $HOME"

    cp .xinitrc ~/
    cp .Xresources ~/
    cp .vimrc ~/
    cp .xbindkeysrc ~/
    cp .zshrc ~/

    echo "Copying files to $HOME/.config/"

    cp -r .config/qpdfview/ ~/.config/
    cp -r .config/gtk-3.0 ~/.config/
    cp -r .config/gtk-2.0 ~/.config/
    cp -r .config/qt5ct ~/.config/
    cp -r .config/awesome ~/.config/
    cp -r .config/htop ~/.config/

    echo "Copy some Emacs files from $HOME/.emacs.d/"

    cp .emacs.d/init.org ~/.emacs.d/
    cp .emacs.d/init.el ~/.emacs.d/
    cp .emacs.d/emacs-custom.el ~/.emacs.d/

    echo "Copy pacman.conf from /etc/"

    cp ./etc/pacman.conf /etc/
}

function usage() {
    echo "Usage: ./refresh.sh [--repo|--local]"
    echo -e "\t--repo\t(Default) Copy from local machine to git repository"
    echo -e "\t--local\tOverwrite local configuration"
    echo -e "\t-h, --help\tPrint this message"
    exit 0
}

if [ $# -eq 0 ]
then
    repo
    exit 0
fi

while test $# -gt 0
do
    case "$1" in
        --repo) repo;;
        --local) local;;
        --help|-h|*) usage;;
    esac
    shift
done
