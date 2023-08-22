#!/bin/bash

yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm

yum -y install vim-powerline tmux-powerline

cat bashrc >> ~/.bashrc
cp -f tmux.conf ~/.tmux.conf
cp -f vimrc ~/.vimrc

source ~/.bashrc


