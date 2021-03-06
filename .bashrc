# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=99000
HISTFILESIZE=99000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

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

#   -------------------------------
#   1. ENVIRONMENT CONFIGURATION
#   -------------------------------

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
    xterm-color|*-256color) color_prompt=yes;;
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

#   Change Prompt
#   ------------------------------------------------------------
#export PS1="\u@\h [\w] :$ "

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] [\[\033[01;34m\]\w\[\033[00m\]]:$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

#   -------------------------------
#   2. DISABLE PIP UNLES (VENV)
#   -------------------------------

# pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=true
# cache pip-installed packages to avoid re-downloading
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

syspip(){
   PIP_REQUIRE_VIRTUALENV="" pip "$@"
}


#   -------------------------------
#   3. EXPORTS
#   -------------------------------

export PATH=usr/local/bin:$PATH
export PATH=usr/local/share/python:$PATH

export CLICOLOR=1

if [ -e /usr/share/terminfo/x/xterm-256color ]; then
        export TERM='xterm-256color'
else
        export TERM='xterm-color'
fi

# bash completion
#[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

#   -------------------------------
#   4. ALIASES
#   -------------------------------

alias ll='ls -lah'
cd() { builtin cd "$@"; ll; }               # Always list directory contents upon 'cd'
alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias edit='code'			    # Open any file in VS Code
alias fix_stty='stty sane'                  # fix_stty:     Restore terminal settings when screwed up
alias cic='set completion-ignore-case On'   # cic:          Make tab-completion case-insensitive
# mcd () { mkdir -p "$1" && cd "$1"; }        # mcd:          Makes new Dir and jumps inside
# trash () { command mv "$@" ~/.Trash ; }     # trash:        Moves a file to the MacOS trash
# ql () { qlmanage -p "$*" >& /dev/null; }    # ql:           Opens any file in MacOS Quicklook Preview
alias DT='tee ~/Desktop/terminalOut.txt'    # DT:           Pipe content to file on MacOS Desktop
alias gad='git add'		# git add <FILES>
alias gcl='git clone'		# git clone <repo_url>
alias gcom='git commit -m'	# git commit -m, just enter 'COMMENT'
alias gd='git diff'		# git diff <FILE>
alias grm='git rm'              # git remove <FILES>
alias gs='git status'           # git status
alias gst='git stash'           # git stash
alias gstl='git stash list'     # git stash list
alias grb='git rebase'		# git rebase
alias gl='git log'           	# git log
alias gp='git push'             # git push
alias gpll='git pull'           # git pull
alias gf='git fetch'            # git fetch
alias gd='git diff'		# git diff
alias gco='git checkout'	# git checkout <BRANCH>
alias gc-='git checkout -'      # git checkout last branch
alias gssh='GIT_SSH_COMMAND="\ssh -i ~/.ssh/id_rsa"\ '

# Git completion for aliases
source /usr/share/bash-completion/completions/git
__git_complete gco _git_checkout	# git checkout <BRANCH>
__git_complete gst _git_stash		# git stash
__git_complete gstl _git_stash list	# git stash list
__git_complete gp _git_push		# git push
__git_complete grb _git_rebase		# git rebase

alias alpha='echo a b c d e f g h i  j  k  l  m  n  o  p  q  r  s  t  u  v  w  x  y  z; echo 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26'

# Vagrant
alias vup='vagrant up'
alias vssh='vagrant ssh'
alias vd='vagrant destroy'
alias vr='vagrant reload'
alias vdr='vagrant destroy -f && vagrant up'
alias vh='vagrant halt'
alias vpr='vagrant provision'
alias vrep='vagrant reload --provision'

# Terraform
alias tf='terraform'

# Activate Ansible venv
alias ans='source ~/.virtualenvs/ansible/bin/activate'

#   -------------------------------
#   5. SHELL COMPLETIONS
#   -------------------------------

export VISUAL="vim"
## GO lang
#export PATH=$PATH:/usr/local/opt/go/libexec/bin
export GOPATH=$HOME/src/go
#export GOROOT=/usr/local/bin/go

#export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
source /usr/share/virtualenvwrapper/virtualenvwrapper.sh

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

## Start Docker PSQL
echo "Start Docker PSQL"
if ! $(docker ps | grep -q postgres);
then
	docker run -d --rm --name psql-10 -p 5432:5432 -e POSTGRES_PASSWORD=sq -v /var/run/postgresql:/var/run/postgresql postgres:10
fi

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
