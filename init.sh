#!/bin/bash

# set sudo to nopasswd
# keychain
# snap, ripgrep
# welcome messages

rm ~/.bashrc
ln -s ~/dotfiles/.bashrc ~/.bashrc

# set sudo to nopasswd
# - where sudo or wheel in /etc/sudoers
# set end of line to NOPASSWD: ALL
