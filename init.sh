#!/bin/bash

if [[ "$(whoami)" == "root" ]]; then
	ln -s /root/dotfiles/.bashrc /root/.bashrc
	. /root/.bashrc
else
	ln -s /home/"$USER"/dotfiles/.bashrc /home/"USER"/.bashrc
	. /home/"$USER"/.bashrc 
fi
