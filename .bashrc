# If not running interactively, don't apply bashrc config
case $- in
*i*) ;;
*) return ;;
esac

HISTCONTROL=ignoreboth
export SUDO_EDITOR=vim
export VISUAL=vim
export EDITOR=vim
PATH="$PATH:/home/porco/bash-files/:/home/porco/c-files/:/home/porco/test"
# set -u # strict mode
if [[ "$HOSTNAME" == "pcp" ]]; then
	xset r rate 300 30 # 300 milliseconds before autorepeat activates, 30 times typing by minute when autorepeating
fi

# clear

# check if software is installed, install it if not
check_software() {
	. /etc/os-release
	if [[ $ID = "rhel" ]]; then # when distribution is redhat
		if [[ ! -f /etc/yum.repos.d/epel.repo ]]; then
			sudo subscription-manager repos --enable codeready-builder-for-rhel-9-"$(arch)"-rpms
			sudo dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
		fi
		if ! which "$1" > /dev/null 2>&1; then
			if [[ "$1" == "ansible" ]]; then
				sudo dnf install -y ansible-core
			else
				sudo dnf install -y "$1"
			fi
		fi
	else # when distribution is debian
		if [[ "$1" == "snap" ]]; then # special treatment for snap
			if ! which snap > /dev/null 2>&1; then
				echo -e "\e[33msnap is not installed. Installing...\e[0m"
				if [[ "$(whoami)" == "root" ]]; then
					apt-get install -y snapd
				else
					sudo apt-get install -y snapd
				fi
			fi
		elif [[ "$1" == "crontab" ]]; then # special treatment for crontab
			if ! which crontab > /dev/null 2>&1; then
				echo -e "\e[33mcrontab is not installed. Installing...\e[0m"
				if [[ "$(whoami)" == "root" ]]; then
					apt-get install -y cron
				else
					sudo apt-get install -y cron
				fi
			fi
		elif [[ "$1" == "ripgrep" ]]; then # special treatment for ripgrep
			if ! which rg > /dev/null 2>&1; then
				echo -e "\e[33mripgrep is not installed. Installing...\e[0m"
				if [[ "$(whoami)" == "root" ]]; then
					apt-get install -y ripgrep
				else
					sudo apt-get install -y ripgrep
				fi
			fi
		elif ! which "$1" > /dev/null 2>&1; then
			echo -e "\e[33m$1 is not installed. Installing...\e[0m"
			if [[ "$(whoami)" == "root" ]]; then
				apt-get install -y "$1"
			else
				sudo apt-get install -y "$1"
			fi
		fi
	fi
}

check_software ssh
check_software curl
check_software vim
check_software tmux
check_software snap
check_software htop
check_software keychain
check_software ansible
check_software tree
check_software ncdu
check_software neofetch
check_software ripgrep
check_software crontab
check_software tldr

# check if repository exists on the home directory, update it if so, download it if not
update_repository() {
  if [ -d ~/"$1" ]; then
		cd ~/$1
		git pull https://github.com/BenoitCastang/"$1"
	else
	 	echo -e "\e[33mRepository $1 not found.\e[0m"
		cd
		git clone https://github.com/BenoitCastang/"$1"
	fi
	cd
}

update_repository dotfiles
update_repository ansible
update_repository cheatsheets
update_repository bash-files
update_repository python-files
update_repository c-files
update_repository personal-website

# check if symlink to dotfile exists on the home directory, create it if not
check_dotfiles() {
	if [ ! -L ~/$1 ]; then
	 	echo -e "\e[33mCreating $1...\e[0m"
		test -e $1 && rm $1
		ln -s ~/dotfiles/$1 ~/$1
	fi
}

check_dotfiles .bashrc
check_dotfiles .inputrc
check_dotfiles .tmux.conf
check_dotfiles .vimrc

search() {
	grep -ni --color=auto $1 ~/cheatsheets/*
}

eval $(keychain --eval --agents ssh ~/.ssh/*id*) # keychain activation to manage ssh key authentication

# system update cron job added if not on the crontab
crontab -l | grep dist-upgrade > /dev/null 2>&1 || (crontab -l; echo "0 0 * * * sudo apt update; sudo apt autoremove -y; sudo apt dist-upgrade -y") | crontab
alias cron='crontab -e'

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

if [ -n "${force_color_prompt-}" ]; then
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

	alias grep='grep -i --color=auto'
  alias fgrep='fgrep --color=auto' # like grep -F : grep but "fixed strings" ie eliminating metacharacters as * or .
	alias egrep='egrep --color=auto' # like grep -E : grep plus the extend support of regular expressions (+, ?, |, parenthesis etc)

fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

## ALIASES

# alias vim='nvim'
alias nvim='/snap/bin/nvim'
# some more ls aliases
# alias cat='cat -n'
alias ll='ls -Alh'
alias la='ls -A'
alias l='ls -CF'
alias pgrep='pgrep -l'
alias gzip='gzip -v'

# apt aliases
alias update='sudo apt update'
alias upgrade='sudo apt dist-upgrade'
alias install='sudo apt install -y'
alias i='sudo apt install -y'
alias remove='sudo apt remove'
alias purge='sudo apt purge'
alias autoremove='sudo apt autoremove -y'

# systemctl aliases - units systemd management
status() {
	systemctl status $1
}
stop() {
	sudo systemctl stop $1
	status $1
}
start() {
	sudo systemctl start $1
	status $1
}
restart() {
	sudo systemctl restart $1
	status $1
}
reload() {
	sudo systemctl reload $1
	status $1
}
enable() {
	sudo systemctl enable $1
	status $1
}
disable() {
	sudo systemctl disable $1
	status $1
}
log() {
	sudo journalctl -u $1
}
daemonreload() {
	sudo systemctl daemon-reload
}

# cyberghost vpn aliases
alias vpn='sudo cyberghostvpn'
alias vpnconnect='sudo cyberghostvpn --connect --country-code'

# monitoring aliases
alias free='free -h'
alias uname='uname -a'
alias df='df -h | grep -v tmpfs'
alias du='sudo du -hs * .* 2> /dev/null'
alias dmesg='sudo dmesg -T'
alias ps='ps -ef'

# tree aliases
alias tree='tree -a'

# rsync aliases
# alias rsync='rsync -avh'

# compression aliases
alias compress="tar -czvf"
alias extract="tar -xvf"

# miscellaneous aliases
alias music="cmus"
# alias man="tldr" # command man to go over it
# alias rm="rm -i"
alias srcprofile="source ~/.profile"
alias vmm="sudo virt-manager"
alias lsblk="lsblk -e 7" # skip loopback devices

#? c aliases

# alias compile='gcc -std=c17 -g -Wall -Werror'
# alias side='cd /opt/lampp/htdocs/www/side/c/packt'
# alias gcce='gcc && ./hangman'
# alias gdb='gcc && gdb -q ./hw'
# alias plusminus='/opt/lampp/htdocs/www/side/c/zero/plusminus/plusminus'
# alias hangman='/opt/lampp/htdocs/www/side/c/hangman/hangman'
# alias gcc-hangman='cd /opt/lampp/htdocs/www/side/c/hangman/ && gcc -g -Wall hangman.c check_letter_presence.c if_present.c if_not_present.c draw_hangman.c hide_word.c -o hangman'
# alias hw='gcc -g -Wall /home/porco/c/packt/helloworld/helloworld.c -o /home/porco/helloworld && /home/porco/helloworld'

#bash aliases
alias c='clear'
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
alias tx='tmux'
alias txa='tmux a -t'
alias bind='bind -p'
alias lshost='hostnamectl status'

# network aliases
alias lamp='cd /opt/lampp/ && sudo ./lampp start'
alias mysql='/opt/lampp/bin/mysql -p test'
alias mysqldump='/opt/lampp/bin/mysqldump -p --opt'
alias nc='nc -v'

# git aliases
alias gs='git status'
alias push='git push origin main'
alias commit='git add -u && git add . && git commit'

# python aliases
alias python='python3'

# docker aliases
alias dr='docker run'
alias drm='docker rm'
alias drmi='docker rmi'
alias dp='docker system prune'
alias da='docker attach'
alias de='docker exec'
alias di='docker images'
alias db='docker build'
alias dps='docker ps -a'

# managing users aliases
alias lsuser='sudo cat /etc/passwd | grep -v nologin | grep -v false | grep -v sync | cut -d: -f1'
alias lsgroup='for user in $(lsuser); do echo $(groups $user); done'
lspasswd() {
	printf "%-10s %-7s %-12s %-5s %-15s %-10s %-10s\n" "USER" "STATUS" "LAST" "MIN" "MAX" "WARN" "GRACE"
	for user in $(lsuser); do
		printf "%-10s %-7s %-12s %-5s %-15s %-10s %-10s\n" "$(sudo passwd -S $user | cut -d " " -f 1)" "$(sudo passwd -S $user | cut -d " " -f 2)" "$(sudo passwd -S $user | cut -d " " -f 3)" "$(sudo passwd -S $user | cut -d " " -f 4)" "$(sudo passwd -S $user | cut -d " " -f 5)" "$(sudo passwd -S $user | cut -d " " -f 6)" "$(sudo passwd -S $user | cut -d " " -f 7)"
	done
}
echo "/home/$(whoami)/.bashrc loaded."
