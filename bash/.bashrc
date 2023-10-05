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

_PS1 ()
{
    local PRE= NAME="$1" LENGTH="$2";
    [[ "$NAME" != "${NAME#$HOME/}" || -z "${NAME#$HOME}" ]] &&
        PRE+='~' NAME="${NAME#$HOME}" LENGTH=$[LENGTH-1];
    ((${#NAME}>$LENGTH)) && NAME="/...${NAME:$[${#NAME}-LENGTH+4]}";
    echo "$PRE$NAME"
}

GRAY="\[$(tput setaf 8)\\]"
GREEN="\[$(tput setaf 10)\\]"
BLUE="\[$(tput setaf 12)\\]"
PURPLE="\[$(tput setaf 13)\\]"
RESET="\[$(tput sgr0)\\]"
BOLD="\[$(tput bold)\\]"

function git_changes {
    local branch
    local added
    local removed
    local status=""
    # Check if we're in a Git repository
    if branch=$(git symbolic-ref --short HEAD 2>/dev/null); then
        # Get the added and removed lines using git diff --shortstat
        local git_diff="$(git diff --shortstat 2>/dev/null)"
        
        if [[ -n "$git_diff" ]]; then
            added=$(echo "$git_diff" | grep -o ' [0-9]\+ insertions' | awk '{s+=$1} END {print s}')
            removed=$(echo "$git_diff" | grep -o ' [0-9]\+ deletions' | awk '{s+=$1} END {print s}')
            changed=$(echo "$git_diff" | grep -o ' [0-9]\+ files' | awk '{s+=$1} END {print s}')
            status=""
            if [[ $added -gt 0 ]]; then
                status="\033[1;32m+$added\033[0m/"
            fi
            if [[ $removed -gt 0 ]]; then
                status="$status\033[1;31m-$removed\033[0m/"
            fi
            if [[ $removed -gt 0 ]]; then
                status="$status\033[1;33m?$changed\033[0m"
            fi
        fi
    fi
    echo -e "$status"
}

export PROMPT_DIRTRIM=2
export PROMPT_COMMAND="export PROMPT_COMMAND=echo"
source /usr/share/git/completion/git-prompt.sh

PS1="${GRAY}\t "
# PS1+="${GREEN}\u@"
# PS1+="${RESET}\h "
PS1+="${BOLD}${BLUE}\w"
PS1+="${PURPLE}\$(__git_ps1) \$(git_changes)\n "
PS1+="${RESET}\$ "
