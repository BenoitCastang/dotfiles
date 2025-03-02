# TASKS
# Make it work totally for a full new computer (kvm, vlc, google chrome, ~/.config/ and ~/.local/share/) + choose what to install or download
# Make git sync a cron job - but it has to be possible to toggle it when you want
# Make root user share dotfiles with user - prompt color must be red

# If not running interactively, don't apply bashrc config
case $- in
*i*) ;;
*) return ;;
esac

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
# [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
# if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
#   debian_chroot=$(cat /etc/debian_chroot)
# fi

# set a fancy prompt (non-color, unless we know we "want" color)
# case "$TERM" in
# xterm-color | *-256color) color_prompt=yes ;;
# esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

# if [ -n "${force_color_prompt-}" ]; then
#   if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    # color_prompt=yes
  # else
    # color_prompt=
  # fi
# fi

# if [ "$color_prompt" = yes ]; then
  prompt_color="\[\e[0m\]"
	if [[ "$HOSTNAME" == "debian2" ]]; then
		prompt_color="\[\e[33;1m\]"
	elif [[ "$HOSTNAME" == "pcp" ]]; then
		prompt_color="\[\e[32;1m\]"
	elif [[ "$HOSTNAME" == "kdebian12" ]]; then
		prompt_color="\[\e[36;1m\]"
	elif [[ "$HOSTNAME" =~ rhel ]]; then
		prompt_color="\[\e[35;1m\]"
	fi
	PS1="${prompt_color}\u@\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\]\$ "
# else
  # PS1='\[\e[1;32m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\]\$ '
# fi
# unset color_prompt force_color_prompt

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

# if [ -f ~/.bash_aliases ]; then
#   . ~/.bash_aliases
# fi

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

source .alias
