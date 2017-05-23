#!/bin/bash

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# install prerequisites

git clone git@github.com:magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

wget -O ~/.git-completion https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash

(
  cd $DOTFILES_DIR
  git pull --recurse-submodules
  git submodule update --recursive --remote
)

# linking files

ln -sfv "$DOTFILES_DIR/runcom/bashrc" ~/.bashrc
ln -sfv "$DOTFILES_DIR/runcom/bash-alias" ~/.bash_aliases
ln -sfv "$DOTFILES_DIR/runcom/bash-profile" ~/.bash_profile
ln -sfv "$DOTFILES_DIR/runcom/bash-env" ~/.bash-env
ln -sfv "$DOTFILES_DIR/runcom/bash-prompt" ~/.bash-prompt

ln -sfv "$DOTFILES_DIR/Xresources/Xresources" ~/.Xresources

mkdir ~/.config

ln -sfv "$DOTFILES_DIR/config/awesome" ~/.config/

ln -sfv "$DOTFILES_DIR/config/vim/vimrc" ~/.vimrc
ln -sfv "$DOTFILES_DIR/config/git" ~/.config/

vim +PluginInstall +qall
