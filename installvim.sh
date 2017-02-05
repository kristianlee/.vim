#!/bin/bash

#check if root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi



if [ "$(uname)" == "Darwin" ]; then
    # Do something under Mac OS X platform
echo "Mac OS X Detected"

#check if homebrew is installed, and if not, install it
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew update
fi

# exuberant ctags
brew install ctags
# vifm
brew install vifm

elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # Do something under GNU/Linux platform
echo "Linux Detected"

apt-get -y install exuberant-ctags
apt-get -y install vifm

#install pathogen: https://github.com/tpope/vim-pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

#get solarized scheme
cd ~/.vim/bundle
  if [ ! -d "vim-colors-solarized" ]; then
    git clone git://github.com/altercation/vim-colors-solarized.git
  fi


#install vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim


fi
