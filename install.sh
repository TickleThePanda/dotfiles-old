#!/bin/bash

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# install prerequisites

git clone git@github.com:magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1

git clone git@github.com:VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim --depth=1

wget -O ~/.git-completion https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash

(
  cd $DOTFILES_DIR
  git pull --recurse-submodules
  git submodule update --recursive --remote
)

# linking files

ln -sfv "$DOTFILES_DIR/runcom/bash/rc" ~/.bashrc
ln -sfv "$DOTFILES_DIR/runcom/bash/profile" ~/.bash_profile
ln -sfv "$DOTFILES_DIR/runcom/bash/alias" ~/.alias
ln -sfv "$DOTFILES_DIR/runcom/bash/env" ~/.env
ln -sfv "$DOTFILES_DIR/runcom/bash/prompt" ~/.bash_prompt

ln -sfv "$DOTFILES_DIR/runcom/zsh/rc" ~/.zshrc

ln -sfv "$DOTFILES_DIR/Xresources/Xresources" ~/.Xresources

mkdir ~/.config

ln -sfv "$DOTFILES_DIR/config/tty-solarized" ~/.config/

ln -sfv "$DOTFILES_DIR/config/vim/vimrc" ~/.vimrc
mkdir ~/.vim/undo

ln -sfv "$DOTFILES_DIR/config/git" ~/.config/

ln -sfv "$DOTFILES_DIR/config/tmux/tmux.conf" ~/.tmux.conf

ln -sfv "$DOTFILES_DIR/config/dircolors/.dircolors.ansi-dark" ~/.dircolors.ansi-dark

vim +PluginInstall +qall

