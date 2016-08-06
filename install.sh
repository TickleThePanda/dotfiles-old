DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ln -sfv "$DOTFILES_DIR/runcom/bash_aliases" ~/.bash_aliases
ln -sfv "$DOTFILES_DIR/runcom/bash_profile" ~/.bash_profile
ln -sfv "$DOTFILES_DIR/runcom/bashrc" ~/.bashrc
ln -sfv "$DOTFILES_DIR/runcom/env" ~/.env
ln -sfv "$DOTFILES_DIR/runcom/prompt" ~/.prompt

ln -sfv "$DOTFILES_DIR/Xresources/Xresources" ~/.Xresources

