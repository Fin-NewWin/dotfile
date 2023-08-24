#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

set show-all-if-unmodified on

# shellcheck source=/dev/null
source $HOME/.config/shell/alias
# shellcheck source=/dev/null
source $HOME/.config/shell/profile

source /usr/share/doc/pkgfile/command-not-found.bash

source /usr/share/fzf/completion.bash
source /usr/share/fzf/key-bindings.bash

source /usr/share/bash-completion/completions/git

export HISTFILE=$HOME/.cache/shell/history
export HISTCONTROL="erasedups:ignorespace"
shopt -s histappend

stty -ixon

# shellcheck source=/dev/null
source $XDG_CONFIG_HOME/bash/prompt.bash
