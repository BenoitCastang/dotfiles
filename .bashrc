# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
*) ;;

esac

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir -h --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -Alh'
alias la='ls -A'
alias l='ls -CF'

# apt aliases
alias update='sudo apt update'
alias upgrade='sudo apt upgrade'
alias install='sudo apt install -y'
alias uninstall='sudo apt purge'
alias autoremove='sudo apt autoremove'
alias purge='sudo apt purge'
alias search='sudo apt-cache search'

# systemctl aliases
alias status='systemctl status'
alias start='systemctl start'
alias stop='systemctl stop'
alias enable='systemctl enable'
alias disable='systemctl disable'
alias restart='systemctl restart'

# cyberghost vpn aliases
alias vpn='sudo cyberghostvpn'
alias vpnconnect='sudo cyberghostvpn --connect --country-code'

# grep aliases
alias grep='grep -ni --color=auto'

# MONITORING

alias free='free -h' # ram free
# alias df='sudo df -h'
alias df='df -h' # disk free
alias mem="htop" # general state
alias uptime='uptime' # uptime + load average
# alias du='du -hsc *'

# tree aliases
alias tree='tree -a'

# rsync aliases
alias rsync='rsync -ravh'

# miscellaneous aliases
alias date="date; ncal"
alias music="cmus"
alias compress="tar -czvf"
alias extract="tar -xvf"
# alias man="tldr" # command man to go over it
# alias rm="rm -i"
alias srcprofile="source ~/.profile"
alias back="cd $OLDPWD"

# c aliases
alias compile='gcc -std=c17 -g -Wall -Werror'
# alias side='cd /opt/lampp/htdocs/www/side/c/packt'
# alias gcce='gcc && ./hangman'
# alias gdb='gcc && gdb -q ./hw'
# alias plusminus='/opt/lampp/htdocs/www/side/c/zero/plusminus/plusminus'
# alias hangman='/opt/lampp/htdocs/www/side/c/hangman/hangman'
# alias gcc-hangman='cd /opt/lampp/htdocs/www/side/c/hangman/ && gcc -g -Wall hangman.c check_letter_presence.c if_present.c if_not_present.c draw_hangman.c hide_word.c -o hangman'
# alias hw='gcc -g -Wall /home/porco/c/packt/helloworld/helloworld.c -o /home/porco/helloworld && /home/porco/helloworld'

#bash aliases
alias profile='vim ~/.profile'
alias fstab='sudo vim /etc/fstab'
alias bashrc='vim ~/.bashrc'
alias vimrc='vim ~/.vimrc'
alias inputrc='vim ~/.inputrc'
alias tmuxrc='vim ~/.tmux.conf'
alias bashsrc='source ~/.bashrc'
alias vimsrc='source ~/.vimrc'
alias inputsrc='bind -f ~/.inputrc'
alias tmuxsrc='source ~/.tmux.conf'
alias bind='bind -p'

# network aliases
alias sshpcf='ssh porco@192.168.0.25' # address given to dns server in /etc/hosts
alias lamp='cd /opt/lampp/ && sudo ./lampp start'
alias mysql='/opt/lampp/bin/mysql -p test'
alias mysqldump='/opt/lampp/bin/mysqldump -p --opt'

HISTCONTROL=ignoreboth

export VISUAL=vim
export EDITOR=vim

PATH="$PATH:/home/porco/coding/bash/"
