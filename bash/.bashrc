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

GRAY="\[$(tput setaf 8)\\]"
# GREEN="\[$(tput setaf 10)\\]"
BLUE="\[$(tput setaf 12)\\]"
PURPLE="\[$(tput setaf 13)\\]"
RESET="\[$(tput sgr0)\\]"
BOLD="\[$(tput bold)\\]"

function git_changes {
    local added
    local removed
    local status=""
    local git_diff
    # Check if we're in a Git repository
    git_diff="$(git diff --shortstat 2>/dev/null)"

    if [ -n "$git_diff" ]; then
        added=$(echo "$git_diff" | grep -o ' [0-9]\+ insertion' | awk '{print $1}')
        removed=$(echo "$git_diff" | grep -o ' [0-9]\+ deletion' | awk '{print $1}')
        changed=$(echo "$git_diff" | grep -o ' [0-9]\+ file' | awk '{print $1}')
        status=""
        if [[ $added -gt 0 ]]; then
            status="\033[1;32m+$added\033[0m "
        fi
        if [[ $removed -gt 0 ]]; then
            status="$status\033[1;31m-$removed\033[0m "
        fi
        if [[ $removed -gt 0 ]]; then
            status="$status\033[1;33m?$changed\033[0m"
        fi
    fi
    echo -e "$status"
}

export PROMPT_DIRTRIM=2
export PROMPT_COMMAND="export PROMPT_COMMAND=echo"
[ -r "/usr/share/git/completion/git-prompt.sh" ] && . /usr/share/git/completion/git-prompt.sh

PS1="${GRAY}\t "
# PS1+="${GREEN}\u@"
# PS1+="${RESET}\h "
PS1+="${BOLD}${BLUE}\w"
PS1+="${PURPLE}\$(__git_ps1) \$(git_changes)\n"
PS1+="${RESET}\$ "
