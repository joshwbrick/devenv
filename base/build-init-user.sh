#!/bin/sh

export PATH="$PATH:/home/$DEVENV_USER/.local/bin"

sudo n stable

python2 -m pip install --upgrade pip
pip2 install pynvim

python3 -m pip install --upgrade pip
pip3 install -U pynvim neovim-remote
pip3 install 'python-language-server[all]'

cpanm -n --local-lib=~/perl5 local::lib && eval $(perl -I ~/perl5/lib/perl5/ -Mlocal::lib)
sudo cpanm -n MsgPack::Raw
sudo cpanm -n Neovim::Ext

mkdir -p ~/.config/nvim

