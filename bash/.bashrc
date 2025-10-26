# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi


# XDG Base Directory
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache

# Cleaning up $HOME
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv

# Rust
export CARGO_HOME="$XDG_DATA_HOME"/cargo
if ! [[ "$PATH" =~ "$CARGO_HOME/bin:" ]]; then
    PATH="$CARGO_HOME/bin:$PATH"
fi
export PATH

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH


# History
set show-all-if-unmodified on
export HISTFILE=$HOME/.cache/shell/history
export HISTCONTROL="erasedups:ignorespace"
export HISTTIMEFORMAT="%F %T "
export HISTSIZE=10000
export HISTFILESIZE=10000
shopt -s histappend

# Get the status code from the last command executed
STATUS=$?

# Get the number of jobs running.
NUM_JOBS=$(jobs -p | wc -l)

# # Set the prompt to the output of `starship prompt`
PS1="\[\e[1;31m\][\[\e[1;33m\]\u\[\e[1;32m\]@\[\e[1;34m\]\h \[\e[1;35m\]\w\[\e[1;31m\]]\[\e[1;00m\]\$\[\e[0;00m\] "


set -o vi
bind '"\C-p": history-search-backward'
bind '"\C-n": history-search-forward'
bind '"\C-l": clear-screen'

set show-mode-in-prompt on
set vi-cmd-mode-string "\1\e[2 q\2"
set vi-ins-mode-string "\1\e[6 q\2"

# # fzf
[ -r "/usr/share/fzf/completion.bash" ] && . /usr/share/fzf/completion.bash
[ -r "/usr/share/fzf/key-bindings.bash" ] && . /usr/share/fzf/key-bindings.bash
eval "$(fzf --bash)"

# Common alias
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias e="nvim"
alias se="sudo nvim"

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc
