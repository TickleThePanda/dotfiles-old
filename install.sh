#!/bin/bash

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# install prerequisites

git clone git@github.com:magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1

# linking files

ln -sfv "$DOTFILES_DIR/runcom/bash_aliases" ~/.bash_aliases
ln -sfv "$DOTFILES_DIR/runcom/bash_profile" ~/.bash_profile
ln -sfv "$DOTFILES_DIR/runcom/bashrc" ~/.bashrc
ln -sfv "$DOTFILES_DIR/runcom/env" ~/.env
ln -sfv "$DOTFILES_DIR/runcom/prompt" ~/.prompt

ln -sfv "$DOTFILES_DIR/Xresources/Xresources" ~/.Xresources

