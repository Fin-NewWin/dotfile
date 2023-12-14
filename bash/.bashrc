#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

set show-all-if-unmodified on

export HISTFILE=$HOME/.cache/shell/history
export HISTCONTROL="erasedups:ignorespace"
shopt -s histappend

stty -ixon

[ -r "/home/fin/.config/shell/alias" ] && . "/home/fin/.config/shell/alias"
[ -r "/home/fin/.config/shell/profile" ] && . "/home/fin/.config/shell/profile"

[ -r "/usr/share/fzf/completion.bash" ] && . /usr/share/fzf/completion.bash
[ -r "/usr/share/fzf/key-bindings.bash" ] && . /usr/share/fzf/key-bindings.bash

[ -r "/usr/share/bash-completion/completions/git" ] && . /usr/share/bash-completion/completions/git

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
