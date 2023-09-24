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

source $HOME/.config/shell/alias
source $HOME/.config/shell/profile

source /usr/share/fzf/completion.bash
source /usr/share/fzf/key-bindings.bash

source /usr/share/bash-completion/completions/git

function parse_git_branch {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
GRAY="\[$(tput setaf 8)\\]"
GREEN="\[$(tput setaf 10)\\]"
BLUE="\[$(tput setaf 12)\\]"
PURPLE="\[$(tput setaf 13)\\]"
RESET="\[$(tput sgr0)\\]"



PS1="${GRAY}\t "
PS1+="${GREEN}\u@"
PS1+="${RESET}\h "
PS1+="${BLUE}\w"
PS1+="${PURPLE}\$(parse_git_branch)"
PS1+="${RESET}\$ "
