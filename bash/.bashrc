#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

set show-all-if-unmodified on

source $HOME/.config/shell/alias
source $HOME/.config/shell/profile

source /usr/share/fzf/completion.bash
source /usr/share/fzf/key-bindings.bash

source /usr/share/bash-completion/completions/git

export HISTFILE=$HOME/.cache/shell/history
export HISTCONTROL="erasedups:ignorespace"
shopt -s histappend

stty -ixon

source $XDG_CONFIG_HOME/bash/prompt.bash
