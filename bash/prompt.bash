#!/usr/bin/env bash

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
