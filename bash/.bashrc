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

# Get the status code from the last command executed
STATUS=$?

# Get the number of jobs running.
NUM_JOBS=$(jobs -p | wc -l)

# Set the prompt to the output of `starship prompt`
PS1="$(starship prompt --status=$STATUS --jobs=$NUM_JOBS)"


set -o vi
bind '"\C-p": history-search-backward'
bind '"\C-n": history-search-forward'
bind '"\C-l": clear-screen'

# GRAY="\[$(tput setaf 8)\\]"
# # GREEN="\[$(tput setaf 10)\\]"
# BLUE="\[$(tput setaf 12)\\]"
# PURPLE="\[$(tput setaf 13)\\]"
# RESET="\[$(tput sgr0)\\]"
# BOLD="\[$(tput bold)\\]"

# function git_changes {
#     local status=""
#     # Check if we're in a Git repository
#     INDEX=$(git status --porcelain -b 2> /dev/null)

#     if $(echo "$INDEX" | command grep '^A[ MDAU] ' &> /dev/null); then
#         status="\033[1;32m+\033[0m"
#     elif $(echo "$INDEX" | command grep '^M[ MD] ' &> /dev/null); then
#         status="\033[1;32m+\033[0m"
#     elif $(echo "$INDEX" | command grep '^UA' &> /dev/null); then
#         status="\033[1;32m+\033[0m"
#     fi

#     if $(echo "$INDEX" | command grep '^[ MARC]M ' &> /dev/null); then
#         status="\033[1;31m!\033[0m"
#     fi

#     if $(echo "$INDEX" | command grep -E '^\?\? ' &> /dev/null); then
#         status="$status\033[1;33m?\033[0m"
#     fi
#     echo -e "$status"
# }

# export PROMPT_DIRTRIM=2
# export PROMPT_COMMAND="export PROMPT_COMMAND=echo"
# [ -r "/usr/share/git/completion/git-prompt.sh" ] && . /usr/share/git/completion/git-prompt.sh

# PS1="${GRAY}\t "
# # PS1+="${GREEN}\u@"
# # PS1+="${RESET}\h "
# PS1+="${BOLD}${BLUE}\w"
# PS1+="${PURPLE}\$(__git_ps1) \$(git_changes)\n"
# PS1+="${RESET}\$ "
