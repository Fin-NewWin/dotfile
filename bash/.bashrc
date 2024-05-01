#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# XDG
export HOME=/home/fin
export XAUTHORITY=/home/fin/.cache/Xauthority
export XDG_CACHE_HOME=/home/fin/.cache
export XDG_CONFIG_HOME=/home/fin/.config
export XDG_DATA_HOME=/home/fin/.local/share
export XDG_RUNTIME_DIR=/run/user/1000
export XDG_SEAT=seat0
export XDG_SESSION_CLASS=user
export XDG_SESSION_ID=1
export XDG_SESSION_TYPE=tty
export XDG_STATE_HOME=/home/fin/.local/state
export XDG_VTNR=1
export XDG_DATA_DIRS=/usr/local/share:/usr/share
export XDG_RUNTIME_DIR=/run/user/$UID
export XINITRC=/home/fin/.config/X11/xinitrc

set show-all-if-unmodified on

export HISTFILE=$HOME/.cache/shell/history
export HISTCONTROL="erasedups:ignorespace"
export HISTTIMEFORMAT="%F %T "
shopt -s histappend

stty -ixon

[ -r "/home/fin/.config/shell/alias" ] && . "/home/fin/.config/shell/alias"
[ -r "/home/fin/.config/shell/profile" ] && . "/home/fin/.config/shell/profile"

[ -r "/usr/share/fzf/completion.bash" ] && . /usr/share/fzf/completion.bash
[ -r "/usr/share/fzf/key-bindings.bash" ] && . /usr/share/fzf/key-bindings.bash

[ -r "/usr/share/bash-completion/completions/git" ] && . /usr/share/bash-completion/completions/git

eval "$(pyenv init -)"
eval "$(starship init bash)"


export HISTSIZE=10000
export HISTFILESIZE=10000

# Get the status code from the last command executed
STATUS=$?

# Get the number of jobs running.
NUM_JOBS=$(jobs -p | wc -l)

# Set the prompt to the output of `starship prompt`
PS1="$(starship prompt --status=$STATUS --jobs="$NUM_JOBS")"


set -o vi
bind '"\C-p": history-search-backward'
bind '"\C-n": history-search-forward'
bind '"\C-l": clear-screen'

set show-mode-in-prompt on
set vi-cmd-mode-string "\1\e[2 q\2"
set vi-ins-mode-string "\1\e[6 q\2"
