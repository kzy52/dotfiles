#!/bin/bash

set -eu

DOTFILES_PATH=$HOME/dotfiles
BIN_PATH=$HOME/bin

if [ "$1" = "" ]; then
  arch=mac
else
  arch=$1
fi

if [ "$arch" = "mac" ]; then
  mkdir -p ${BIN_PATH}
  cp -ip ${DOTFILES_PATH}/bin/tmux-pbcopy ${BIN_PATH}
  cp -ip ${DOTFILES_PATH}/bin/tmuxx ${BIN_PATH}
  cp -ip ${DOTFILES_PATH}/bin/get_ssid ${BIN_PATH}
  cp -ip ${DOTFILES_PATH}/bin/battery ${BIN_PATH}
fi

ln -is ${DOTFILES_PATH}/.vimrc $HOME/.vimrc
ln -is ${DOTFILES_PATH}/.tmux.conf $HOME/.tmux.conf
ln -is ${DOTFILES_PATH}/.gitconfig $HOME/.gitconfig
ln -is ${DOTFILES_PATH}/.gitignore $HOME/.gitignore
ln -is ${DOTFILES_PATH}/.gitattributes $HOME/.gitattributes
ln -is ${DOTFILES_PATH}/.gitconfig_local $HOME/.gitconfig_local
ln -is ${DOTFILES_PATH}/.gitmessage $HOME/.gitmessage
ln -is ${DOTFILES_PATH}/.gitmodules $HOME/.gitmodules
ln -is ${DOTFILES_PATH}/.gemrc $HOME/.gemrc
ln -is ${DOTFILES_PATH}/.railsrc $HOME/.railsrc
ln -is ${DOTFILES_PATH}/.tigrc $HOME/.tigrc
ln -is ${DOTFILES_PATH}/.agignore $HOME/.agignore
ln -is ${DOTFILES_PATH}/.zsh/.zshenv $HOME/.zshenv
ln -is ${DOTFILES_PATH}/.zsh/.zshrc $HOME/.zshrc

mkdir -p $HOME/.vim/backups
mkdir -p $HOME/.vim/swaps
