#!/bin/bash

## ask user before each majour change

# set sudo to nopasswd
# keychain
# snap, ripgrep
# welcome messages

rm ~/.bashrc
ln -s ~/dotfiles/.bashrc ~/.bashrc

# set sudo to nopasswd
# - where sudo or wheel in /etc/sudoers
# set end of line to NOPASSWD: ALL


sudo vim -c '/^%sudo\|^%wheel' -c 'normal $biNOPASSWD: ' -c 'wq' /etc/sudoers
