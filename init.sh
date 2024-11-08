#!/bin/bash

if [[ "$(whoami)" == "root" ]]; then
	rm /root/.bashrc
	ln -s /root/dotfiles/.bashrc /root/.bashrc
	. /root/.bashrc
else
	rm /home/"$USER"/.bashrc
	ln -s /home/"$USER"/dotfiles/.bashrc /home/"USER"/.bashrc
	. /home/"$USER"/.bashrc 
fi
