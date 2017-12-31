#!/bin/bash

mkdir -p ~/.vimundo

cd "$(dirname "$0")"

if [[ ! -e ~/.zplug ]]; then
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
fi

UNAME=$(uname)

for f in $(ls -A dotfiles)
do
  if [ -L ~/$f ]; then
    rm ~/$f
  fi
  if [ -e ~/$f ]; then
    mv ~/$f ~/$f.bak
  fi

  FILE_PATH="$PWD/dotfiles/$f"
  if [ -d $FILE_PATH ] && [ ! $UNAME == 'Darwin' ]; then
    ln -sd $FILE_PATH ~/$f
  else
    ln -s $FILE_PATH ~/$f
  fi
done

if [ ! $UNAME == 'Darwin' ]; then
  for f in $(ls -A config)
  do
    if [ -L ~/.config/$f ]; then
      rm ~/.config/$f
    fi
    if [ -e ~/.config/$f ]; then
      mv ~/.config/$f ~/.config/$f.bak
    fi

    FILE_PATH="$PWD/config/$f"
    if [ -d $FILE_PATH ]; then
      ln -sd $FILE_PATH ~/.config/$f
    else
      ln -s $FILE_PATH ~/.config/$f
    fi
  done
fi

if [ ! -e ~/.vim/bundle/Vundle.vim ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

if [ ! -e ~/bin ]; then
  ln -s $PWD/bin ~/bin
fi

cd -
